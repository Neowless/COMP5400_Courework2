clear;
clc; 
close all;
global Maze_row Maze_col EPSILON goal_num;
Maze_row = 6;
Maze_col = 6;
EPSILON = 0.9;
state_num = Maze_row*Maze_col; 
action_num = 4;
episode_max = 20000;
GAMMA = 0.8; % Discout factor
ALPHA = 0.2; % Learning efficiency
Q_table = zeros(state_num, action_num);
goal = [1, 6];
goal_num = (goal(1)-1)*Maze_col+goal(2);
start = [1, 1];
start_num = (start(1)-1)*Maze_col+start(2);
EB = 0;
fail = 0;
step_number = zeros(1,episode_max);
for i=1:episode_max    
    step_counter = 0;
    Position = start_num;
    is_terminal = false;
    Choices = Q_table(Position, :);
    action = [];
    A = choose_action(Position, Choices);
    while ~is_terminal
         action = [action A];
        step_counter = step_counter + 1;
        Choices = Q_table(Position, :);
        [NewPosition, Reward, flag] = get_env_feedback(Position, A);
         A_ = choose_action(NewPosition, Choices); 
        Q_predict = Q_table(Position, A);
        if NewPosition ~= goal_num && flag == 0
             Q_target = Reward + GAMMA * Q_table(NewPosition, A_); 
        elseif flag == 1 
            Q_target = Reward;
            Q_table(Position, A) = Q_table(Position, A) + ALPHA * (Q_target - Q_predict);
            break;
        else

            Q_target = Reward;
            is_terminal = true;
        end
        Q_table(Position, A) = Q_table(Position, A) + ALPHA * (Q_target - Q_predict);
        Position = NewPosition; 
        A=A_; 
        if step_counter > 10000
            break
        end
    end
    if Position==goal_num
        fprintf('%d: Succeed! total step: %d\n', i, step_counter);
        step_number(i) = step_counter;
    elseif flag == 1
        fprintf('%d: Failed! total step: %d\n', i, step_counter);
        step_number(i) = 0;
        if i>10000
            fail = fail+1;
        end
    else
        fprintf('%d: Emergency break\n',i);
        step_number(i) = 0;
        EB = EB+1;
    end
end
x = 1:1:episode_max;
plot(x,step_number)
ylim([0,50]);
title('Step Versus Episode of SARSA')
xlabel('Episode 0-20000') 
ylabel('Number of Steps in a Single Episode')
Q_table


