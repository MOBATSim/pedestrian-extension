classdef trajPlanner < matlab.System & matlab.system.mixin.Propagates
    % Untitled2 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties (SetAccess=protected)
        count
    end

    properties(DiscreteState)
       
    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            obj.count=0;
            % Perform one-time calculations, such as computing constants
        end

        function traj = stepImpl(obj,ipos,dpos,pos,speed,mustinclude)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if obj.count==0
                for i=1:5
                traj(1,i)=ipos(1)+(dpos(1)-ipos(1))*i/25
                traj(2,i)=ipos(2)+(dpos(2)-ipos(2))*i/25
                end
                obj.count=obj.count+1;
           
            else
                a=dpos(1)-pos(1);
                b=dpos(2)-pos(2);
                aa=a/sqrt((a^2+b^2));
                phi=acosd(aa);
                if sign(b)==-1
                    phi=phi*-1;
                end
                for i=1:5
                traj(1,i)=pos(1)+cosd(phi)*i*speed/25
                traj(2,i)=pos(2)+sind(phi)*i*speed/25
                end
            end
            
%             nearestValue = 0.25;
%             occdata = round(traj/nearestValue)*nearestValue;
%             A=zeros(80,80);
%             for i=1:size(occdata,2)
%              A(occdata(1,i)*4,occdata(2,i)*4)=1;
%             end
%           
%             resolution=4;
%             b=binaryOccupancyMap(A,resolution);
%             show(b)
%             traj=ipos(1)+(ipos(2)-ipos(1))*1/9
        end
        

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function out = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [2 5];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function out = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out = "double";

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function out = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out = false;

            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end

        function out = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out = true;

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end

      
    end
end
