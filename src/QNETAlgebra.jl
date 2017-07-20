__precompile__()

module QNETAlgebra

import Base.show
import Base: +, -, *, /, ctranspose, getindex
import Base: convert

export Destroy, QSpace, QMatrix, Qid, Qeye, substitute, ⊞, SLH, ▷

using PyCall

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
