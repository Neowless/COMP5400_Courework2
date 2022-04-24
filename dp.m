subplot(2,1,1);
plot(x,step_number)
ylim([0,30]);
title('Step Versus Episode of Q-Learning')
xlabel('Episode 0-20000') 
ylabel('Number of Steps in a Single Episode') 
subplot(2,1,2);
plot(x,step_number_sarsa)
ylim([0,30]);
title('Step Versus Episode of SARSA')
xlabel('Episode 0-20000') 
ylabel('Number of Steps in a Single Episode') 