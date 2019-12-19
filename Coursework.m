 = load('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\predicate-matrix-binary.txt');
[c1, c2] = textread('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\classes.txt', '%u %s');
%row, column
path = "\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\JPEGImages\";
trainingImages = textread('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\trainclasses.txt', '%s');
testingImages = textread('\\smbhome.uscs.susx.ac.uk\mt451\Documents\CV\Animals_with_Attributes2\testclasses.txt', '%s');

for f =1:length(trainingImages)
    trainingPaths(f) = strcat(path, trainingImages(f));   
end
for w =1:size(testingImages, 1)
    testingPaths(w) = strcat(path, testingImages(w));   
end

imdsTrain = imageDatastore(trainingPaths,'IncludeSubfolders',true,'LabelSource','foldernames');
imdsTest = imageDatastore(testingPaths,'IncludeSubfolders',true,'LabelSource','foldernames');

numTrainImages = numel(imdsTrain.Labels);

net = resnet18;

inputSize = net.Layers(1).InputSize;
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);

layer = 'pool5';
disp("Training features");
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
disp("Testing features");
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');

whos featuresTrain
disp("training models")
[attributeModels] = train_attribute_models(featuresTrain, imdsTrain, trainingImages, c1)
disp("computing att probability")
[attributesProbability] = compute_attribute_probs(imdsTest, featuresTest, attributeModels)
disp("computing cls probability")
[classesProbability] = compute_class_probs(testingImages, featuresTest, attributeModels, attributesProbability)
disp("computing accuracy")
[global_accuracy] = compute_accuracy(testingclasses, classeesProbability, attributesProbability )
disp(global_accuracy)


