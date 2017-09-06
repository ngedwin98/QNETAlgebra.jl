
const qma = PyNULL()
function init_qma()
    copy!(qma, pyimport("qnet.algebra.matrix_algebra"))
end

type QMatrix <: QNETObject
    m::PyObject
end
pyo(qm::QMatrix) = qm.m

QMatrix(arr::Array{QOperator}) = QMatrix(qma[:Matrix]([e.o for e in arr]))
QMatrix(arr::Array{Any}) = QMatrix([isa(e,QOperator)?e:*(e,Id)])

*(c::Number, qm::QMatrix) = QMatrix([c*QOperator(o) for o in pyo(qm)[:matrix]])

Qeye(n::Int) = QMatrix(qma[:identity_matrix](n))

getindex(qm::QMatrix, ind::Int) = QOperator(qm.m[ind])
substitute(qm::QMatrix; subs...) = QMatrix(qm.m[:substitute](Dict(subs)))
