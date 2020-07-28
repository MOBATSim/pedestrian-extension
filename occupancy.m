% 
clc,clear

% nearestValue = 0.25;
% value = round(value/nearestValue)*nearestValue;

% pipos=[15 14.5];
% pdpos=[11 19];

pipos=[3.8 8];
pdpos=[11 19];
for i=1:70

        ptraj(i,1)=pipos(1)+(pdpos(1)-pipos(1))*i/70;
 
        ptraj(i,2)=pipos(2)+(pdpos(2)-pipos(2))*i/70;

end

 cipos1=[1 11];
 cdpos1=[15 11];
 
 cipos2=[19 14];
 cdpos2=[3 14];
 
 cipos=[cipos1 cipos2];
 cdpos=[cdpos1 cdpos2];
 
 
  for i=1:5:350
      for j=1:2:3
        ctraj(i,j)=cipos(j)+(cdpos(j)-cipos(j))*i/250;
        ctraj(i+1,j)=ctraj(i,j)+0.2;
        ctraj(i+2,j)=ctraj(i,j)+0.2;
        ctraj(i+3,j)=ctraj(i,j)-0.2;
        ctraj(i+4,j)=ctraj(i,j)-0.2;
    
        ctraj(i,j+1)=cipos(j+1)+(cdpos(j+1)-cipos(j+1))*i/250;
        ctraj(i+1,j+1)=ctraj(i,j+1)+0.2;
        ctraj(i+2,j+1)=ctraj(i,j+1)-0.2;
        ctraj(i+3,j+1)=ctraj(i,j+1)+0.2;
        ctraj(i+4,j+1)=ctraj(i,j+1)-0.2;
      end
  end

  resolution=2;
  A=zeros(40,40);
  b=binaryOccupancyMap(A,resolution);           

  setOccupancy(b,[ptraj;ctraj(:,1:2);ctraj(:,3:4)],true)
%   time=40
%   setOccupancy(b,[ptraj(time,:);ctraj((time-1)*5+1:(time-1)*5+5,1:2);ctraj((time-1)*5+1:(time-1)*5+5,3:4)],true)
% inflate(b,1,'grid')
  for t=1:70
  for j=1:2:3    
  oc=repmat(world2grid(b,ptraj(t,:)),5,1)== world2grid(b,ctraj((t-1)*5+1:(t-1)*5+5,j:j+1));
  switch j
      case 1 
        occ(1:5,t)=oc(:,1)& oc(:,2);
      case 3
        occ(6:10,t)=oc(:,1)& oc(:,2);
  end
  end
  end

coll=find(any(occ))
 
 show(b)
%   hold on
%   plot(2,3,'*k')
%   hold off
                            
            