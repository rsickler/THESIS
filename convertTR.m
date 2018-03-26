function [TRnumber] = convertTR(onset, offset, TRlength)
dt = offset - onset;
TRnumber = floor(dt/TRlength) + 1;

end