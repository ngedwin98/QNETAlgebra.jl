__precompile__()

module QNETAlgebra

import Base.show
import Base: +, -, *, /, ctranspose, getindex
import Base: convert

import SymPy: Sym

export QSpace

using PyCall

abstract type QNETObject end
function show(io::IO, mime::MIME{Symbol("text/latex")}, q::QNETObject)
    write(io, convert(AbstractString, pyo(q)[:_repr_latex_]()))
end
function substitute(q::T, q1::QNETObject, q2::QNETObject) where {T<:QNETObject}
    return T(pyo(q)[:substitute](Dict(pyo(q1)=>pyo(q2))))
end
function substitute(q::T, s::Sym, x::Number) where {T<:QNETObject}
    T(pyo(q)[:substitute](Dict(s=>x)))
end
function getindex(q::T, subs::Pair{S,S}) where {T<:QNETObject} where {S<:QNETObject}
    return substitute(q, subs[1], subs[2])
end

function (q::Q)


include("hilbert_space_algebra.jl")
include("operator_algebra.jl")
include("matrix_algebra.jl")
include("circuit_algebra.jl")

function __init__()
    init_qha()
    init_qoa()
    init_qma()
    init_qca()
end

end #module
