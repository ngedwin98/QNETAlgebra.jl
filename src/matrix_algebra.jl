
const qma = PyNULL()
function init_qma()
    copy!(qma, pyimport("qnet.algebra.matrix_algebra"))
end

type QMatrix
    m::PyObject
end
QMatrix(arr::Array{QOperator}) = QMatrix(qma[:Matrix]([e.o for e in arr]))
QMatrix(arr::Array{Any}) = QMatrix([isa(e,QOperator)?e:e*Qid])
Qeye(n::Int) = QMatrix(qma[:identity_matrix](n))

getindex(qm::QMatrix, ind::Int) = QOperator(qm.m[ind])

substitute(qm::QMatrix; kws...) = QMatrix(qm.m[:substitute](Dict(kws)))

show(io::IO, mime::MIME{Symbol("text/plain")}, qm::QMatrix) = display(qm.m)
