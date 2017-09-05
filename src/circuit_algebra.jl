
const qca = PyNULL()
function init_qca()
    copy!(qca, pyimport("qnet.algebra.circuit_algebra"))
end

type QCircuit <: QNETObject
    c::PyObject
end
pyo(qc::QCircuit) = qc.c
SLH(S::QMatrix, L::QMatrix, H::QOperator) = QCircuit(qca[:SLH](S.m, L.m, H.o))
substitute(qc::QCircuit; kws...) = QCircuit(qc.c[:substitute](Dict(kws)))

⊞(qc1::QCircuit, qc2::QCircuit) = QCircuit(qc1.c+qc2.c)
▷(qc1::QCircuit, qc2::QCircuit) = QCircuit(qc2.cqc1.c)
