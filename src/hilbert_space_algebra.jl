
const qha = PyNULL()
function init_qha()
    copy!(qha, pyimport("qnet.algebra.hilbert_space_algebra"))
end

type QSpace <: QNETObject
    s::PyObject
end
QSpace(name::String; kws...) = QSpace(qha[:LocalSpace](name; kws...))
pyo(qs::QSpace) = qs.s

local_factors(qs::QSpace) = (QSpace(s) for s in pyo(s)[:local_factors])
