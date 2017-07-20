
const qca = PyNULL()
function init_qca()
    copy!(qca, pyimport("qnet.algebra.circuit_algebra"))
end

type QCircuit
    c::PyObject
end
SLH(S::QMatrix, L::QMatrix, H::QOperator) = QCircuit(qca[:SLH](S.m, L.m, H.o))
substitute(qc::QCircuit; kws...) = QCircuit(qc.c[:substitute](Dict(kws)))

⊞(qc1::QCircuit, qc2::QCircuit) = QCircuit(qc1.c+qc2.c)
◁(qc1::QCircuit, qc2::QCircuit) = QCircuit(qc1.c<<qc2.c)

show(io::IO, mime::MIME{Symbol("text/plain")}, qc::QCircuit) = display(qc.c)
