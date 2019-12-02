%MATLAB script for controlling the 3 omni-wheel rover platform

%------------------------------INSTRUCTIONS-------------------------------%
%{
1.  Ensure the files inside of
    C:\Program Files\V-REP3\V-REP_PRO_EDU\programming\remoteApiBindings\matlab\matlab
    C:\Program Files\V-REP3\V-REP_PRO_EDU\programming\remoteApiBindings\lib\lib\Windows\64Bit
    are copied into the current MATLAB workspace

2.  In v-rep, ensure that the line:
    simRemoteApi.start(19999)
    is inside a non-threaded child script, under sysCall_init()
    (this runs once and starts the internal server for MATLAB to connect to)

3.  For more information on API functions, please see
    http://www.coppeliarobotics.com/helpFiles/en/remoteApiFunctionsMatlab.htm
%}

%---------------------------------SCRIPT----------------------------------%
%constructs remote api object
vrep=remApi('remoteApi');
%destroy's any current connections to v-rep simulation
vrep.simxFinish(-1);
%establishes connection to v-rep simulation on port 19999
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

%clientID is -1 if the connection to the server was NOT possible
if (clientID>-1)
    disp('connected to v-rep');
    
    %------------------------------CODE HERE------------------------------%
    
    %defining motor handles
    %return code functions as a debug tool/error message
    [returnCode,motor_0]=vrep.simxGetObjectHandle(clientID,'motor_0',vrep.simx_opmode_blocking);
    [returnCode,motor_1]=vrep.simxGetObjectHandle(clientID,'motor_1',vrep.simx_opmode_blocking);
    [returnCode,motor_2]=vrep.simxGetObjectHandle(clientID,'motor_2',vrep.simx_opmode_blocking);

    %syntax
    %[returnCode]=vrep.simxSetJointTargetVelocity(clientID,MOTOR_X,TARGET_V,vrep.simx_opmode_blocking);
    
    %setting motor speeds for straight line
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,motor_0,10,vrep.simx_opmode_blocking);
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,motor_1,-10,vrep.simx_opmode_blocking);
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,motor_2,0,vrep.simx_opmode_blocking);
    
    %destroy connection to v-rep simulation
    vrep.simxFinish(-1);
else
    disp('Failed connecting to remote API server');
end

vrep.delete()