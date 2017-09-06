
const qoa = PyNULL()
function init_qoa()
    copy!(qoa, pyimport("qnet.algebra.operator_algebra"))
    global const Id = QOperator(qoa[:IdentityOperator])
end

type QOperator <: QNETObject
    o::PyObject
end
pyo(qo::QOperator) = qo.o

Destroy(qs::QSpace) = QOperator(qoa[:Destroy](hs=qs.s))

ctranspose(qo::QOperator) = QOperator(qoa[:Adjoint](qo.o))
+(qo1::QOperator, qo2::QOperator) = QOperator(qo1.o[:__add__](qo2.o))
*(qo1::QOperator, qo2::QOperator) = QOperator(qo1.o[:__mul__](qo2.o))
*(c::Number, qo::QOperator) = QOperator(qoa[:ScalarTimesOperator](c,qo.o))
^(qo::QOperator, p::Int) = QOperator(qoa[:__pow__](p))
-(qo::QOperator) = *(-1,Id) * qo
+(c::Number, qo::QOperator) = *(c,Id) + qo
+(qo::QOperator, c::Number) = c + qo
*(qo::QOperator, c::Number) = c * qo
-(qo1::QOperator, qo2::QOperator) = qo1 + -(qo2)
-(c::Number, qo::QOperator) = c + -(qo)
-(qo::QOperator, c::Number) = -(c) + qo
/(qo::QOperator, c::Number) = (1/c) * qo

space(qo::QOperator) = QSpace(qo.o[:space])
