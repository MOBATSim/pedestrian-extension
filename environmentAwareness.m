classdef environmentAwareness < matlab.System & matlab.system.mixin.Propagates
    % Untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties (SetAccess=protected)
        cpos
        count
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
           obj.count=[0 0];
        end

        function [Carpos,closestcr,timegap,Streetreach] = stepImpl(obj,carpos,pos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if obj.count==0;
                obj.cpos=[carpos(1),carpos(3)];
                obj.count=1;
            else
                obj.cpos(1)=obj.cpos(1)+sign(carpos(2,1))*0.7;
                obj.cpos(2)=obj.cpos(2)-0.7;
            end
            if pos(2)<=12.5 & pos(2)>=7.5
                Streetreach=true;
            else
                Streetreach=false;
            end
            Carpos=[obj.cpos;carpos(2,:)];
            closestcr = 1;
            timegap=min(sqrt((obj.cpos(1,:)-pos(1)).^2+(carpos(2,:)-pos(2)).^2));
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function [out,out2,out3,out4] = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [2 2];
            out2 = [1 1];
            out3=[1 1];
            out4=[1 1];
            

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [out,out2, out3,out4] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out = "double";
            out2 = "double";
            out3 = "double";
            out4 = "logical";

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function [out,out2,out3,out4] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out = false;
            out2 = false;
            out3 = false;
            out4 = false;

            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end

        function [out,out2,out3,out4] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out = true;
            out2 = true;
            out3 = true;
            out4 = true;

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end
        
    end
end
