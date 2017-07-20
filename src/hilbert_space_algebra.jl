
const qha = PyNULL()
function init_qha()
    copy!(qha, pyimport("qnet.algebra.hilbert_space_algebra"))
end

type QSpace
    s::PyObject
end
QSpace(name::String; kws...) = QSpace(qha[:LocalSpace](name; kws...))

local_factors(qs::QSpace) = (QSpace(s) for s in qs.s[:local_factors])

function show(io::IO, mime::MIME{Symbol("text/latex")}, qs::QSpace)
    write(io, convert(AbstractString,qs.s[:_repr_latex_]()))
end
