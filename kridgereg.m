function [alpha] = kridgereg(k, y, gamma)
   alpha = (k + gamma*length(y)*eye(length(y))) \ y; 
end