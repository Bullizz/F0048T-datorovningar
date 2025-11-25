function [tp] = TransCoef(s1,s2,n1,n2)
% Denna funktion beräknar transsmisions koefficienten tp
% Input:
%   s1       - Riktningsvektorn för vågen i första mediumet
%   s2       - Riktningsvektorn för vågen i mediumet den går in i
%   n1       - Brytningsindext för första mediumet
%   n2       - Brytningsindex för andra mediumet
%
% Output:
%   tp          - Transmissionskoefficienten för p polariserat ljus

% Beräkna tp
tp      = (2 * n1 * s1(2)) / (n2 * s1(2) + n1 * s2(2));

end