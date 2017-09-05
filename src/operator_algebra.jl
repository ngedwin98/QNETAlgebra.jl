
const qoa = PyNULL()
function init_qoa()
    copy!(qoa, pyimport("qnet.algebra.operator_algebra"))
    global const Id = Operator(qoa[:IdentityOperator])
end

type Operator <: QNETObject
    o::PyObject
end
pyo(qo::Operator) = qo.o

Destroy(qs::QSpace) = Operator(qoa[:Destroy](hs=qs.s))

ctranspose(qo::Operator) = Operator(qoa[:Adjoint](qo.o))
+(qo1::Operator, qo2::Operator) = Operator(qo1.o[:__add__](qo2.o))
*(qo1::Operator, qo2::Operator) = Operator(qo1.o[:__mul__](qo2.o))
*(c::Number, qo::Operator) = Operator(qoa[:ScalarTimesOperator](c,qo.o))

-(qo::Operator) = *(-1,Id) * qos
+(c::Number, qo::Operator) = *(c,Id) + qo

+(qo::Operator, c::Number) = c + qo
*(qo::Operator, c::Number) = c * qo

-(qo1::Operator, qo2::Operator) = qo1 + -(qo2)
-(c::Number, qo::Operator) = c + -(qo)
-(qo::Operator, c::Number) = -(c) + qo
/(qo::Operator, c::Number) = (1/c) * qo

space(qo::Operator) = QSpace(qo.o[:space])
substitute(qo::Operator; kws...) = QMatrix(qo.o[:substitute](Dict(kws)))
