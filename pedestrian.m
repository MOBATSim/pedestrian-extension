classdef pedestrian
    %pedestrian Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        names
        start
        dest
        risklevel
        hurry
        fitness
        
    end
    
    methods
        function obj = pedestrian(PedNames,start, dest, risklevel, hurry, fitness)
            %creating a pedestrian
            obj.names = PedNames;
            obj.start = start;
            obj.dest = dest;
            obj.risklevel = risklevel;
            obj.hurry = hurry;
            obj.fitness = fitness;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        function person= evaluateped(pos)
        
        end
    end
end

