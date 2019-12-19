function [attributesProbability] = compute_attribute_probs(imdsTest, featuresTest, attributeModels)
addpath('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2');
C = countEachLabel(imdsTest);
S = sum(M(:,2:end),2);
findsum = sum(S);



attributesProbability = 1 + zeros(85, findsum);

for u = 1:85
    
    for v = 1:findsum
        [label, SVMscores] = predict(attributeModels{u}, featuresTest(x,:));
        attributesProbability(u, v) = SVMscores(2);
    end
end

    
    
    
    