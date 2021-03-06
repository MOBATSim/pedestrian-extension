classdef forward < matlab.System & matlab.system.mixin.Propagates
    % Untitled10 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties (SetAccess=protected)
    oldpos
    grid
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            obj.oldpos=0;
            obj.grid=zeros(40,40);
            % Perform one-time calculations, such as computing constants
        end

        function [pos,Car] = stepImpl(obj,car,npos) 
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            pos=npos;
            
            Car=car(1,:);
            
            %% Vehicle 1 - Pose
            x1 = car(1);
            y1 = car(2);
%             yaw1 = V1_Pose(3);

            centerP = [x1;y1];

            V1_HalfLength = 1; % Length = 4m
            V1_HalfWidth = 0.5; % Width = 2m

            % Creating a rectangle
            vp11 = [V1_HalfLength; V1_HalfWidth];
            vp21 = [V1_HalfLength; -V1_HalfWidth];
            vp31 = [-V1_HalfLength; -V1_HalfWidth];
            vp41 = [-V1_HalfLength; V1_HalfWidth];

            % Rotation Matrix
            yaw1=0;
            Rmatrix = [cos(yaw1) -sin(yaw1); sin(yaw1) cos(yaw1)];

            % Rotated Points
            p1r = centerP + Rmatrix*vp11;
            p2r = centerP + Rmatrix*vp21;
            p3r = centerP + Rmatrix*vp31;
            p4r = centerP + Rmatrix*vp41;

            % Connecting points
            Hitbox_V1 = [p1r p2r p3r p4r p1r];

            cornersV1_x = transpose(Hitbox_V1(1,:));
            cornersV1_y = transpose(Hitbox_V1(2,:));
            %% Vehicle 2 - Pose
            x2 = car(3);
            y2 = car(4);
%             yaw2 = V2_Pose(3);

            centerP = [x2;y2];

            V2_HalfLength = 1; % Length = 4m
            V2_HalfWidth = 0.5; % Width = 2m

            % Creating a rectangle
            vp12 = [V2_HalfLength; V2_HalfWidth];
            vp22 = [V2_HalfLength; -V2_HalfWidth];
            vp32 = [-V2_HalfLength; -V2_HalfWidth];
            vp42 = [-V2_HalfLength; V2_HalfWidth];

            % Rotation Matrix
            yaw2=0;
            Rmatrix = [cos(yaw2) -sin(yaw2); sin(yaw2) cos(yaw2)];

            % Rotated Points
            p1r = centerP + Rmatrix*vp12;
            p2r = centerP + Rmatrix*vp22;
            p3r = centerP + Rmatrix*vp32;
            p4r = centerP + Rmatrix*vp42;
            

            % Connecting points
%             Hitbox_V2 = [p1r p2r p3r p4r p1r];
           

%             cornersV2_x = transpose(Hitbox_V2(1,:));
%             cornersV2_y = transpose(Hitbox_V2(2,:));
            
            
            
            %% Ped 1 - Pose
            x3 = npos(1);
            y3 = npos(2);
%             yaw1 = V1_Pose(3);

            centerP = [x3;y3];

            P1_HalfLength = 0.2; % Length = 4m
            P1_HalfWidth = 0.2; % Width = 2m

            % Creating a rectangle
            pp11 = [P1_HalfLength; P1_HalfWidth];
            pp21 = [P1_HalfLength; -P1_HalfWidth];
            pp31 = [-P1_HalfLength; -P1_HalfWidth];
            pp41 = [-P1_HalfLength; P1_HalfWidth];

            % Rotation Matrix
            yaw3=0;
            Rmatrix = [cos(yaw3) -sin(yaw3); sin(yaw3) cos(yaw3)];

            % Rotated Points
            p1r = centerP + Rmatrix*pp11;
            p2r = centerP + Rmatrix*pp21;
            p3r = centerP + Rmatrix*pp31;
            p4r = centerP + Rmatrix*pp41;

            % Connecting points
            Hitbox_P1 = [p1r p2r p3r p4r p1r];
%             a=floor([p1r p2r p3r p4r]);
%             a1=[a(:,1) [a(1)+0,25; a(2)] [a(1)+0,25; a(2)+0.25] [a(1); a(2)+0.25] a(:,1)]
%             cx=transpose(a1(1,:));
%             cy=transpose(a1(2,:));
            
            cornersP1_x = transpose(Hitbox_P1(1,:));
            cornersP1_y = transpose(Hitbox_P1(2,:));

            Hitbox_V2 = [[x1 y1];[x2 y2]; [x3 y3]];
            
            figure(2)
            hold on
            resolution=4;
            B=zeros(80,80);
            c=binaryOccupancyMap(B,resolution);
            setOccupancy(c,Hitbox_V2,true)
            inflate(c,1,'grid')
            show(c)
            hold off
            
%             plot([-10 10],[2 2],'-k',[-10 10],[-2 -2],'-k',[-10 10],[0 0],'--k')
%             axis([-10 10 -10 10])
%             grid minor
%             
%             hold on
%             plot(cornersV1_x,cornersV1_y,'g'); %Vehicle 1 rectangle
%             plot(x1,y1,'*'); %Vehicle 1 center
%             plot(cornersV2_x,cornersV2_y,'r'); %Vehicle 2 rectangle
%             plot(x2,y2,'o'); %Vehicle 2 center
%             plot(cornersP1_x,cornersP1_y,'b'); %Ped 1 rectangle
%             plot(x3,y3,'o'); %Ped 1 center
%             plot(cx,cy,'k')


%             plot(car(1),car(2),'o')
%             plot(car(3),car(4),'o')
%             plot(npos(1),npos(2),'s')
           
%             plot(v(3),v(4),'s')
%             plot(v(5),v(6),'s')
%             hold off
            % pause(0.2)
            % c.XData=u(1)
            % c.YData=u(2)
%             drawnow
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        function [out,out2] = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [2 1];
            out2=[1 2];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [out,out2] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out = "double";
            out2 = "double";

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function [out,out2] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out = false;
            out2 = false;


            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end

        function [out,out2] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out = true;
            out2 = true;

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end
        
    end
end
