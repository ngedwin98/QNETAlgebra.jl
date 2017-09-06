__precompile__()

module QNETAlgebra

import Base.show
import Base: +, -, *, /, ctranspose, getindex
import Base: convert

export QSpace

using PyCall

abstract type QNETObject end
function show(io::IO, mime::MIME{Symbol("text/latex")}, q::QNETObject)
    write(io, convert(AbstractString, pyo(q)[:_repr_latex_]()))
end

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
