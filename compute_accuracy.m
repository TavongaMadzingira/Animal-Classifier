function [global_accuracy] = compute_accuracy(testclasses, classesProbability, attributesProbability )
class_array = [];
true = 0;
false = 0;
for u = 1:10
    for y = 1:1531
        class_array = [class_array; testclasses];
    end
end

class_array = reshape(class_array,[], 1);

for v = 1:size(classesProbability)
    localProb = classesProbability(:,v);
    [~,imagex] = max(localProb);
     if eq(imagex, class_array)
         true = true + 1;
     end
     
     if ne(imagex, class_array)
         false = false+1;
     end
end

conflate = true + false;
global_accuracy = (true/conflate);

         
    