function [fopt,xopt,gopt]=Gradient_P(Oracle,xini)
global Ad fd md

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/
%                                                                           %
%         RESOLUTION D'UN PROBLEME D'OPTIMISATION SANS CONTRAINTES          %
%                                                                           %
%         Methode de gradient projeté                                   %
%                                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/


% ------------------------
% Parametres de la methode
% ------------------------


[iter,alphai,tol, ok] = mainMenu;


% ----------------------------
% Initialisation des variables
% ----------------------------

logG = [];
logP = [];
Cout = [];
Z=zeros(md,1);

if(ok==1)
    tic;
    
    % -------------------------
    % Boucle sur les iterations
    % -------------------------
    
       x = xini;

    kstar = iter;
    for k = 1:iter
        
        %    - valeur du critere et du gradient
        
        ind = 4;
        [F,G] = Oracle(x,ind);
        
        %    - test de convergence
        
        if norm(Projection(G,Ad,Z)) <= tol
            kstar = k;
            break;
        end
        
        %    - calcul de la direction de descente
        [F,G,ind]=Oracle(x,ind);
        D = -G;
        
        %    - calcul de la longueur du pas de gradient
        
        [alpha,~] = Wolfe(alphai,x,D,Oracle);
        
        %    - mise a jour des variables
        
        x = Projection(x + (alpha*D),Ad,fd);
        
        %    - evolution du gradient, du pas et du critere
        
        logG = [ logG ; log10(norm(Projection(G,Ad,Z))) ];
        logP = [ logP ; log10(alpha) ];
        Cout = [ Cout ; F ];
        
    end
    
    % ---------------------------
    % Resultats de l'optimisation
    % ---------------------------
    
    fopt = F;
    xopt = x;
    gopt = G;
    
    tcpu = toc;
    fprintf('=============================================================\n');
    fprintf('                      R�sultats du calcul                    \n');
    fprintf('=============================================================\n');
    fprintf('Iteration         : %d\n',kstar);
    fprintf('Temps CPU         : %d\n',tcpu);
    fprintf('Critere optimal   : %f\n',fopt);
    fprintf('Norme du gradient : %f\n',norm(gopt));
    fprintf('Fin de la methode de gradient projeté.\n');
    
    fprintf('=============================================================\n');
    
    % - visualisation de la convergence
    
    Visualg(logG,logP,Cout);
    
else
    fprintf('=============================================================\n');
    fprintf('Abandon\n');
    fprintf('=============================================================\n');
    x=xini;
    ind = 4;
    [F,G] = Oracle(x,ind);
    fopt = F;
    xopt = x;
    gopt = G;
end
end