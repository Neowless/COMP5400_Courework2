function ACTION = choose_action( STATUS, CHOISE )

global Maze_row Maze_col EPSILON;
col = mod(STATUS, Maze_col); 
if col == 0
    col = Maze_col;
end
row = ceil(STATUS/Maze_col);

a = rand;


if a>EPSILON || ~any(CHOISE) % Choose Randomly
    ACTION = ceil(4*rand);
    return
else
    [maximum ,ACTION] = max(CHOISE); 

end

end