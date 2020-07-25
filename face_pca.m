%用于三维模型以及纹理数据的主成分提取，读取文件格式为obj,数据保存为mat
path='E:\PRNet-master\output\faceobj';%读取文件的路径
a=dir(fullfile(path,'*.obj'));
Vertices=zeros(43867*3,length(a)); %zeros的列数等于读取模型的个数
Texture=zeros(43867*3,length(a));
for i=1:length(a)
    A=importdata(fullfile(path,a(i).name));
    data=A.data;
    vertices=data(1:43867,1:3);
    texture=data(1:43867,4:6);
    vertices=vertices';
    texture=texture';
    shape = reshape(vertices,43867*3,1);
    rgb=reshape(texture,43867*3,1);
    Vertices(:,i)=shape;
    Texture(:,i)=rgb;
end

shapeMean=mean(Vertices,2);
rgbMean=mean(Texture,2);
[shapePC,SCORE,latent]=pca(Vertices');
[rgbPC,SCORE1,latent1]=pca(Texture');
save('facemodel_zxy.mat','shapeMean','shapePC','rgbMean','rgbPC');
shape1=1*shapeMean-0.1*1e4*shapePC(:,1)-0*1e4*shapePC(:,2)-0*1e4*shapePC(:,3)+0*1e4*shapePC(:,4)+0*1e4*shapePC(:,5);%捏脸的前五个参数和向量
shape = reshape(shape1, 3, 43867);
shape = shape';
x = shape(:, 1);
y = shape(:, 2);
z = shape(:, 3);

figure;
pcshow(shape);
title('face with Texture');
xlabel('X');
ylabel('Y');
zlabel('Z');