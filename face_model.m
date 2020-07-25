%{
    在这种方法中，虽然是通过提取主成分的方式来控制捏脸，但是也能使主成分对应上人脸调整的部分，例如使用PRnet获取一组主要在嘴唇上有差异的模型，进行pca分析，最大主成分
    即为调整嘴唇部分的主成分向量。同样的道理用于纹理中，获取一组主要在眉毛部分有差异的纹理数据，那么得到的最大主成分向量可用于控制眉毛部分的纹理。
    用这种方法可以建立自己的数据库(使用PRnet获取想要的数据非常方便)，从数据库中提取想要控制的成分，以及想要获得人脸基础模型以及纹理基础模型，在这个基础上再进行捏脸。
%}
clear;
model=load('facemodel_zxy.mat');
[s1,s2,s3,s4,s5,s6]=deal(-30,0,0,0,0,0);%捏脸修改顶点参数； 范围为-100至100； 建议滑动步长为2； 参数优先级按顺序排列；
shape_change=1*model.shapeMean+s1*20*model.shapePC(:,1)+s2*20*model.shapePC(:,2)+s3*20*model.shapePC(:,3)+s4*20*model.shapePC(:,4)+s5*20*model.shapePC(:,5)+s6*20*model.shapePC(:,6);%捏脸的前六个参数和向量
%可将model.shapeMean换成其他的想要的人脸顶点，在想要的人脸顶点上再进行调整
shape_change = reshape(shape_change, 3, 43867);
shape_change = shape_change';


[T1,T2,T3,T4,T5,T6,T7]=deal(80,0,0,0,0,0,-40);%捏脸修改纹理参数； 范围为-100至100； 建议滑动步长为2； 参数无优先级
texture_change=1*model.rgbMean+T1*model.rgbPC(:,1)+T2*model.rgbPC(:,2)+T3*model.rgbPC(:,3)+T4*model.rgbPC(:,4)+T5*model.rgbPC(:,5)+T6*model.rgbPC(:,6)+T7*model.rgbPC(:,7);
%可将model.rgbMean换成其他的想要的人脸纹理，在想要的人脸纹理上再进行调整
%纹理 第七主成分主要是控制眼睛纹理和嘴唇纹理，也是最能控制男女特征的纹理（具体情况要根据分析的纹理数据而定）
texture_change = reshape(texture_change, 3, 43867);
texture_change = texture_change';
texture_change=uint8(texture_change*255);

A=importdata('E:\PRNet-master\output\faceobj\001948.obj');
data=A.data;
rgb=data(1:43867,4:6);
rgb=uint8(rgb*255);

figure;
pcshow(shape_change,texture_change);
title('face with Texture');
xlabel('X');
ylabel('Y');
zlabel('Z');

