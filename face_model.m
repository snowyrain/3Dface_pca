%{
    �����ַ����У���Ȼ��ͨ����ȡ���ɷֵķ�ʽ����������������Ҳ��ʹ���ɷֶ�Ӧ�����������Ĳ��֣�����ʹ��PRnet��ȡһ����Ҫ���촽���в����ģ�ͣ�����pca������������ɷ�
    ��Ϊ�����촽���ֵ����ɷ�������ͬ���ĵ������������У���ȡһ����Ҫ��üë�����в�����������ݣ���ô�õ���������ɷ����������ڿ���üë���ֵ�����
    �����ַ������Խ����Լ������ݿ�(ʹ��PRnet��ȡ��Ҫ�����ݷǳ�����)�������ݿ�����ȡ��Ҫ���Ƶĳɷ֣��Լ���Ҫ�����������ģ���Լ��������ģ�ͣ�������������ٽ���������
%}
clear;
model=load('facemodel_zxy.mat');
[s1,s2,s3,s4,s5,s6]=deal(-30,0,0,0,0,0);%�����޸Ķ�������� ��ΧΪ-100��100�� ���黬������Ϊ2�� �������ȼ���˳�����У�
shape_change=1*model.shapeMean+s1*20*model.shapePC(:,1)+s2*20*model.shapePC(:,2)+s3*20*model.shapePC(:,3)+s4*20*model.shapePC(:,4)+s5*20*model.shapePC(:,5)+s6*20*model.shapePC(:,6);%������ǰ��������������
%�ɽ�model.shapeMean������������Ҫ���������㣬����Ҫ�������������ٽ��е���
shape_change = reshape(shape_change, 3, 43867);
shape_change = shape_change';


[T1,T2,T3,T4,T5,T6,T7]=deal(80,0,0,0,0,0,-40);%�����޸���������� ��ΧΪ-100��100�� ���黬������Ϊ2�� ���������ȼ�
texture_change=1*model.rgbMean+T1*model.rgbPC(:,1)+T2*model.rgbPC(:,2)+T3*model.rgbPC(:,3)+T4*model.rgbPC(:,4)+T5*model.rgbPC(:,5)+T6*model.rgbPC(:,6)+T7*model.rgbPC(:,7);
%�ɽ�model.rgbMean������������Ҫ��������������Ҫ�������������ٽ��е���
%���� �������ɷ���Ҫ�ǿ����۾�������촽����Ҳ�����ܿ�����Ů�����������������Ҫ���ݷ������������ݶ�����
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

