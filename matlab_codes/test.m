clc
A=[]
count=1
for i=1:20
    A(:,i,:)=aclcv(:,count:count+20)
end



x=[1:10];
y=rand*(x);

z=x*y'
quit()
