%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/
%                                                                           %
%  MONITEUR D'ENCHAINEMENT POUR LE CALCUL DE L'EQUILIBRE D'UN RESEAU D'EAU  %
%                                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/
 

% ------------------------------------------
% Fonctions fournies dans le cadre du projet
% ------------------------------------------

   % Donnees du problemes

    Probleme_R;
    Structures_R;
    
    global  n m mr md orig dest absn ordn r pr fd ;
    global A Ar Ad AdT AdI AdC B q0;

    
    
 

% ------------------------------
% Initialisation de l'algorithme
% ------------------------------

   % La dimension (n-md) est celle du probleme primal
   % �  compl�ter selon la nature du probl�me r�solu

   %xini = 0.5*rand(n,1);
   %xini=[105.4180;123.6113;104.0031;87.5987;102.7678;105.0652;103.1309;86.1410;73.8671;102.7922;76.4341;99.3793;104.0286];
    xini=  [ -0.0647;-0.0535;0.1031;-0.4265;0.4428;0.2953;-0.1282;-0.1516;0.1700;0.1391;0.130;0.0985; 0.0584;    0.3116; -0.0175;0.1628;  0.4307;   0.0382;-0.0156;   -0.151;   -0.1191;   0.1840];
% ----------------------------
% Minimisation proprement dite
% ----------------------------

   % Exemple : la fonction "Gradient_F"  pour l'algorithme de gradient �
   % pas fixe
   %
   %[fopt,xopt,gopt] = Gradient_F(@OracleDG,xini);
   %[fopt,xopt,gopt] = Gradient_v(@OracleDG,xini);
   [fopt,xopt,gopt] = Gradient_P(@OracleGP,xini);
   
%[fopt,xopt,gopt] = PR(@OracleDG,xini);
%[fopt,xopt,gopt] = Newton(@OracleDH,xini);
   % -----> A completer... pour d'autres algorithmes

% --------------------------
% Verification des resultats. Utilisation de fonctions fournies avec le
% projet. Utiliser HydrauliqueD pour le probl�me dual
% --------------------------

   [q,z,f,p] = HydrauliqueP2(xopt); %on doit utiliser hydrauliqueD pour le problème dual

   Verification(q,z,f,p);

%
