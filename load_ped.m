Peds=[]
PedNames = [{'P1'} {'P2'} {'P3'} ];
start=[0 5 8];
dest=[9 3 10];
risk=[1 3 0];
hurry=[1 1 1];
fitness=[10 4 6];

for j=1:length(PedNames)
    
    PedVariable = strcat('Pedestrian',num2str(j));
    assignin('base',PedVariable,pedestrian(PedNames{j},start(j),dest(j),risk(j),hurry(j),fitness(j)));
    NewPed = evalin('base',strcat('Pedestrian',int2str(j)));
    Peds =[Peds NewPed];
end