function[attributeModels] = train_attribute_models(featuresTrain, imdsTrain, trainingImages,c1)
addpath('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2');
M = load('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\predicate-matrix-binary.txt');
M_length = size(M,2);

attributeModels = {};
trainPredicate = []

for i = 1:size(40, 1)
trainPredicate (i,:) = M(c1(i),:);
end

for u =1:85
    trainingLabels = [];
    for v = 1:40
        w(u,:) = trainPredicate(1,u);
        x = countEachLabel(imdsTrain);
        for y = 1:x{v,2}
            trainingLabels = [trainingLabels;w];
        end
    end
    NewModel = fitcsvm(featuresTrain, trainingLabels, 'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
    disp(u)
    NewModel = fitSVMPosterior(NewModel);
    attributeModels{u} = NewModel; 
        
        
       
end
end