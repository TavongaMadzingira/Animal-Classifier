function [classesProbability] = compute_class_probs(testingImages, featuresTest, attributeModels, attributesProbability)
addpath('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2');
M = load('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\predicate-matrix-binary.txt');
T_length = size(10,1);
A_length = size(attributesProbability,2)
test = [];

for u = 1:T_length
    test(u,:) = M(featuresTest(u),:);
end

classesProbability = 1 + zeros(T_length, A_length );
for v = 1:85
    for w = A_length
        for x = T_length
if eq(test(x,v),1)
    classesProbability(x,w) = classesProbability(x,w)*classesProbability(v,w);
end
if ne(test(x,v),1)
    classesProbability(x,w) = classesProbability(x,w)*(1 - classesProbability(v,w));
end
        end
    end
end
