
import Base.convert
import Base.promote_rule

type X end

convert(::Type{Number}, x::X) = 3
promote_rule(::Type{X}, ::Type{Number}) = Number

X() + 4
