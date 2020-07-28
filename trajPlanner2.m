classdef trajPlanner2 < matlab.System & matlab.system.mixin.Propagates
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

        function [ptraj,ctraj,coll] = stepImpl(obj,pipos,pdpos,cipos,cdpos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
%             if obj.count==0
                for i=1:70
                     ptraj(i,1)=pipos(1)+(pdpos(1)-pipos(1))*i/70;
                     ptraj(i,2)=pipos(2)+(pdpos(2)-pipos(2))*i/70;
                end
                
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

%                obj.count=obj.count+1;           
%             else
                resolution=2;
                A=zeros(40,40);
                b=binaryOccupancyMap(A,resolution);           

                setOccupancy(b,[ptraj;ctraj(:,1:2);ctraj(:,3:4)],true)
%                   time=40
                %  setOccupancy(b,[ptraj(time,:);ctraj((time-1)*5+1:(time-1)*5+5,1:2);ctraj((time-1)*5+1:(time-1)*5+5,3:4)],true)
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
        end

        

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function [out,out2,out3] = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [70 2];
            out2 = [350 4];
            out3=[1 6];
            
            

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [out,out2, out3] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out = "double";
            out2 = "double";
            out3 = "double";
           

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function [out,out2,out3] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out = false;
            out2 = false;
            out3 = false;

            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end
        function [out,out2,out3] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out = true;
            out2 = true;
            out3 = true;
            

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end

      
    end
end
