
const qoa = PyNULL()
function init_qoa()
    copy!(qoa, pyimport("qnet.algebra.operator_algebra"))
    global const Qid = QOperator(qoa[:IdentityOperator])
end

type QOperator
    o::PyObject
end
Destroy(qs::QSpace) = QOperator(qoa[:Destroy](hs=qs.s))
Destroy(name::String) = QOperator(QSpace(name))

space(qo::QOperator) = QSpace(qo.o[:space])

ctranspose(qo::QOperator) = QOperator(qoa[:Adjoint](qo.o))
+(qo1::QOperator, qo2::QOperator) = QOperator(qo1.o+qo2.o)
*(qo1::QOperator, qo2::QOperator) = QOperator(qo1.o*qo2.o)
*(c::Number, qo::QOperator) = QOperator(qoa[:ScalarTimesOperator](c,qo.o))
-(qo::QOperator) = *(-1,Qid) * qo

+(c::Number, qo::QOperator) = *(c,Qid) + qo

+(qo::QOperator, c::Number) = c + qo
*(qo::QOperator, c::Number) = c * qo

-(qo1::QOperator, qo2::QOperator) = qo1 + -(qo2)
-(c::Number, qo::QOperator) = c + -(qo)
-(qo::QOperator, c::Number) = -(c) + qo
/(qo::QOperator, c::Number) = (1/c) * qo

substitute(qo::QOperator; kws...) = QMatrix(qo.o[:substitute](Dict(kws)))

Displace(alpha::Number) = QOperator(qoa[:Displace](alpha))

show(io::IO, mime::MIME{Symbol("text/plain")}, qo::QOperator) = display(qo.o)
