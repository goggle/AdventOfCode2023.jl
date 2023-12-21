module Day20

using AdventOfCode2023

abstract type AbstractModuleType end
mutable struct FlipFlop <: AbstractModuleType
    name::String
    status::Bool
    in::Set{AbstractModuleType}
    out::Vector{AbstractModuleType}
    FlipFlop(name::String) = new(name, false, Set{AbstractModuleType}(), Vector{AbstractModuleType}())
end
mutable struct Conjunction <: AbstractModuleType
    name::String
    in::Set{AbstractModuleType}
    out::Vector{AbstractModuleType}
    last_high::Dict{AbstractModuleType,Bool}
    Conjunction(name::String) = new(name, Set{AbstractModuleType}(), Vector{AbstractModuleType}(), Dict{AbstractModuleType,Bool}())
end
struct Broadcaster <: AbstractModuleType
    name::String
    out::Vector{AbstractModuleType}
    Broadcaster(name::String) = new(name, Vector{AbstractModuleType}())
end
struct Untyped <: AbstractModuleType
    name::String
    in::Set{AbstractModuleType}
    Untyped(name::String) = new(name, Set{AbstractModuleType}())
end
struct Button <: AbstractModuleType
    name::String
    Button() = new("buton")
end

struct Pulse
    ishigh::Bool
end

function receive_pulse!(queue::Vector{Tuple{AbstractModuleType,AbstractModuleType,Pulse}}, mod::Broadcaster, ::AbstractModuleType, ::Pulse)
    for node ∈ mod.out
        push!(queue, (mod, node, Pulse(false)))
    end
end

function receive_pulse!(queue::Vector{Tuple{AbstractModuleType,AbstractModuleType,Pulse}}, mod::FlipFlop, ::AbstractModuleType, pulse::Pulse)
    if !pulse.ishigh
        mod.status = !mod.status
        for node ∈ mod.out
            push!(queue, (mod, node, Pulse(mod.status)))
        end
    end
end

function receive_pulse!(queue::Vector{Tuple{AbstractModuleType,AbstractModuleType,Pulse}}, mod::Conjunction, from::AbstractModuleType, pulse::Pulse)
    mod.last_high[from] = pulse.ishigh
    pulse = all(values(mod.last_high)) ? Pulse(false) : Pulse(true)
    for node ∈ mod.out
        push!(queue, (mod, node, pulse))
    end
end
receive_pulse!(::Vector{Tuple{AbstractModuleType,AbstractModuleType,Pulse}}, ::Untyped, ::AbstractModuleType, ::Pulse) = nothing


function day20(input::String = readInput(joinpath(@__DIR__, "..", "data", "day20.txt")))
    graph = parse_input(input)
    return [part1(graph), part2!(graph)]
end

function parse_input(input::AbstractString)
    graph = Dict{String,AbstractModuleType}()
    data = Dict{String,Vector{String}}()
    for line ∈ eachsplit(rstrip(input), "\n")
        m = match(r"([%&]?[a-z]+)\s+->\s+(.+)", line)
        name = m.captures[1]
        elems = strip.(split(m.captures[2], ","))
        if startswith(name, "%")
            graph[name[2:end]] = FlipFlop(string(name[2:end]))
            data[name[2:end]] = elems
        elseif startswith(name, "&")
            graph[name[2:end]] = Conjunction(string(name[2:end]))
            data[name[2:end]] = elems
        else
            graph[name] = Broadcaster(string(name))
            data[name] = elems
        end
    end
    for (k, v) ∈ data
        for name ∈ v
            if !haskey(graph, name)
                graph[name] = Untyped(name)
            end
            push!(graph[k].out, graph[name])
            push!(graph[name].in, graph[k])
            if typeof(graph[name]) == Conjunction
                graph[name].last_high[graph[k]] = false
            end
        end
    end
    return graph
end

function part1(graph::Dict{String,AbstractModuleType})
    graph = deepcopy(graph)
    n_low, n_high = 0, 0
    for _ ∈ 1:1000
        nl, nh = play_round!(graph)
        n_low += nl
        n_high += nh
    end
    return n_low * n_high
end

function part2!(graph::Dict{String,AbstractModuleType})
    # Identifying the relevant modules:
    # This part might still be dependent on the users personal input...
    sender = collect(graph["rx"].in)[1]
    cycle_senders = [x.name for x ∈ sender.in]
    cycles = Dict{String,Int}()

    for cs ∈ cycle_senders
        cycles[cs] = 0
    end
    i = 1
    while any(values(cycles) .== 0)
        play_round!(graph; i, cycles)
        i += 1
    end
    return lcm(values(cycles)...)
end

function play_round!(graph::Dict{String,AbstractModuleType}; i::Int=0, cycles::Dict{String,Int}=Dict{String,Int}())
    n_low, n_high = 0, 0
    queue = Vector{Tuple{AbstractModuleType,AbstractModuleType,Pulse}}()
    push!(queue, (Button(), graph["broadcaster"], Pulse(false)))
    while !isempty(queue)
        from, to, pulse = popfirst!(queue)

        # for part 2
        if i != 0 && !pulse.ishigh && haskey(cycles, to.name) && cycles[to.name] == 0
            cycles[to.name] = i
        end

        if pulse.ishigh
            n_high += 1
        else
            n_low += 1
        end
        receive_pulse!(queue, to, from, pulse)
    end
    return n_low, n_high
end


end # module
