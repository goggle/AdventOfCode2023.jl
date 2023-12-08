module Day07

using AdventOfCode2023

struct Hand
    cards::Vector{Int8}
    bid::Int
end

struct Handp2
    cards::Vector{Int8}
    bid::Int
end


function day07(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    hands = [Hand([_to_value(c) for c ∈ x[1]], parse(Int, x[2])) for x ∈ split.(eachsplit(rstrip(input), "\n"), " ")]
    p1 = solve(hands)
    handsp2 = [Handp2([_to_value(c; p2=true) for c ∈ x[1]], parse(Int, x[2])) for x ∈ split.(eachsplit(rstrip(input), "\n"), " ")]
    p2 = solve(handsp2)
    return [p1, p2]
end

function _to_value(c::Char; p2 = false)
    p2 && c == 'J' && return Int8(1)
    isdigit(c) && return Int8(c - '0')
    c == 'T' && return Int8(10)
    c == 'J' && return Int8(11)
    c == 'Q' && return Int8(12)
    c == 'K' && return Int8(13)
    c == 'A' && return Int8(14)
    return Int8(0)
end

function Base.isless(a::Union{Hand,Handp2}, b::Union{Hand,Handp2})
    scores = [score(a), score(b)]
    scores[1] < scores[2] && return true
    scores[1] > scores[2] && return false
    for (v1, v2) ∈ zip(a.cards, b.cards)
        v1 < v2 && return true
        v1 > v2 && return false
    end
    return false
end

function _score(hand::Union{Hand,Handp2})
    bins = Dict{Int8,Int8}()
    for card ∈ hand.cards
        if haskey(bins, card)
            bins[card] += 1
        else
            bins[card] = 1
        end
    end
    vals = values(bins)
    if length(vals) == 1  # five of a kind
        return 7
    elseif length(vals) == 2
        if maximum(vals) == 4  # four of a kind
            return 6
        else  # full house
            return 5
        end
    elseif length(vals) == 3
        if maximum(vals) == 3  # three of a kind
            return 4
        else  # two pair
            return 3
        end
    elseif length(vals) == 4  # one pair
        return 2
    end
    return 1  # highcard
end

score(hand::Hand) = _score(hand)

function score(hand::Handp2)
    # Implement the upgrades for the Joker cards:
    initial_score = _score(hand)
    njoker = sum(x == 1 for x ∈ hand.cards)
    if njoker == 1
        initial_score ∈ (1, 6) && return initial_score + 1
        initial_score ∈ (2, 3, 4) && return initial_score + 2
    elseif njoker == 2
        initial_score ∈ (2, 5) && return initial_score + 2
        initial_score == 3 && return initial_score + 3
    elseif njoker == 3
        initial_score ∈ (4, 5) && return initial_score + 2
    elseif njoker == 4
        initial_score == 6 && return initial_score + 1
    end
    return initial_score
end

function solve(hands::Union{Vector{Hand},Vector{Handp2}})
    sort!(hands)
    s = 0
    for (i, hand) ∈ enumerate(hands)
        s += i * hand.bid
    end
    return s
end

end # module
