function output = gaussiana(media, varianza, input)

output = exp(-(input - media)^2/(2*varianza));

end

