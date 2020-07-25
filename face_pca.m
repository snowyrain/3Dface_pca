%������άģ���Լ��������ݵ����ɷ���ȡ����ȡ�ļ���ʽΪobj,���ݱ���Ϊmat
path='E:\PRNet-master\output\faceobj';%��ȡ�ļ���·��
a=dir(fullfile(path,'*.obj'));
Vertices=zeros(43867*3,length(a)); %zeros���������ڶ�ȡģ�͵ĸ���
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
shape1=1*shapeMean-0.1*1e4*shapePC(:,1)-0*1e4*shapePC(:,2)-0*1e4*shapePC(:,3)+0*1e4*shapePC(:,4)+0*1e4*shapePC(:,5);%������ǰ�������������
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