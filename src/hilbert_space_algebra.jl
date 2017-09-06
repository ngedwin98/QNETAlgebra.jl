
const qha = PyNULL()
function init_qha()
    copy!(qha, pyimport("qnet.algebra.hilbert_space_algebra"))
    #global const Null = QSpace(qha[:TrivialSpace])
    #global const All = QSpace(qha[:FullSpace])
end

type QSpace <: QNETObject
    s::PyObject
end
pyo(qs::QSpace) = qs.s

QSpace(label::String) = QSpace(qha[:LocalSpace](label))

QSpace(label::String, dim::Int) = QSpace(qha[:LocalSpace](label,dimension=dim))
QSpace(label::String, basis::Tuple{Vararg{String}}) =
    QSpace(qha[:LocalSpace](label,basis=basis))

local_factors(qs::QSpace) = (QSpace(s) for s in pyo(qs)[:local_factors])
has_basis(qs::QSpace) = pyo(qs)[:has_basis]
dimension(qs::QSpace) = pyo(qs)[:dimension]
