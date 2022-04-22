function [NewPosition, Reward, flag] = get_env_feedback(Position, Action)
global Maze_row Maze_col goal_num

% Find the Actual Position
col = mod(Position, Maze_col); 
if col == 0
    col = Maze_col;
end
row = ceil(Position/Maze_col); 


if Action == 1  % up
    if row < 6
        row = row+1;
    end
elseif Action == 2 % right
    if col < 6
        col = col+1;
    end
elseif Action == 3 % down
    if row > 1
        row = row-1;
    end
elseif Action == 4 % left
    if col > 1
        col = col-1;
    end
end
    
NewPosition = Maze_col*(row-1) + col;

% Reward Function
flag = 0;
trap = [3,4,15,16]; % locations of trap
if NewPosition == goal_num
    Reward = 1;
elseif ismember(NewPosition, trap)
    Reward = -1;
    flag = 1;
else
    Reward=0;
end

end

