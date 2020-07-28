classdef crossingbehavior < matlab.System & matlab.system.mixin.Propagates
    % Untitled5 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function [npos,crossing,how,time] = stepImpl(obj,clocations,timegap,traj)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
           
            npos = traj(:,1);
            if traj(2,:)<=2.5 & traj(2,:)>=-2.5
                crossing=true
            else
            crossing=false;
            end
            time=timegap;
            how=1;
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function [out,out2,out3,out4] = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [2 1];
            out2 = [1 1];
            out3 = [1 1];
            out4 = [1 1];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [out,out2,out3,out4] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out = "double";
            out2 = "logical";
            out3 = "double";
            out4 = "double";

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
