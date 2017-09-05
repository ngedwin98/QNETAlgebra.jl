
const qha = PyNULL()
function init_qha()
    copy!(qha, pyimport("qnet.algebra.hilbert_space_algebra"))
    global const Null = Space(qha[:TrivialSpace])
    global const All = Space(qha[:FullSpace])
end

type Space <: QNETObject
    s::PyObject
end
pyo(qs::Space) = qs.s

Space(label::String) = Space(qha[:LocalSpace](label))

label(qs::Space) = pyo(qs)[:label]
local_factors(qs::Space) = (Space(s) for s in pyo(qs)[:local_factors])

#== Basis
QSpace(label::String, dim::Int) = QSpace(qha[:LocalSpace](label,dimension=dim))
QSpace(label::String, basis::Tuple{Vararg{String}}) =
  QSpace(qha[:LocalSpace](label,basis=basis))
has_basis(qs::QSpace) = pyo(qs)[:has_basis]
basis_labels(qs::QSpace) = pyo(qs)[:basis_labels]
dimension(qs::QSpace) = pyo(qs)[:dimension]
==#
