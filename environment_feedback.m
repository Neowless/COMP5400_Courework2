function [STATE,REWARD] = environment_feedback(Current_STATE,ACTION)

STATE = Current_STATE+ACTION*2-3;

if STATE == 0;
    STATE = 1;
end

if STATE == 6;
    REWARD = 1;
else
    REWARD = 0;
end

end