class Numeric
	def to_rad
		self * Math::PI / 180
	end

	def to_deg
		self * 180 / Math::PI
	end

	def to_sci
		exp = Math.log10(self).floor
		num = self.to_f / 10 ** exp
		"#{num} x 10^#{exp}"
	end

	def sqrt
		Math.sqrt(self)
	end

	def sqr
		self * self
	end
end

class Integer
	def fact
		(1..self).reduce(1, :*)
	end
end

def sin(a)
	Math.sin(a)
end

def cos(a)
	Math.cos(a)
end

def tan(a)
	Math.tan(a)
end

def asin(a)
	Math.asin(a)
end

def acos(a)
	Math.acos(a)
end

def atan(a)
	Math.atan(a)
end

def sqr(n)
	n * n
end

def sqrt(n)
	Math.sqrt(n)
end

def log(n)
	Math.log(n)
end

def vector(x, y)
	magnitude = Math.sqrt(x ** 2 + y ** 2)
	puts "Magnitude: #{magnitude}"
	angle = Math.atan(y / x.to_f)
	if x < 0
		angle += Math::PI
	end
	if angle < 0
		angle += 2 * Math::PI
	end
	angle *= 180 / Math::PI
	puts "Angle: #{angle}"
end

PI = Math::PI
E = Math::E
