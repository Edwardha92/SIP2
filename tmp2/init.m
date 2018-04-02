%% init.m
% -------------------------------------------------------------------------
%
% Author:  Andreas Rommel
% Datum:   14.03.2018
%
% Funktion:
% - nimmt alle benötigte Pfade verschiedener Dateien/Module im Workspace
%   auf, um direkt darauf zugreifen zu können
% - komplett-reset des aktuellen Workspaces
% - Definition globaler Variablen
%
% -------------------------------------------------------------------------



%% Reset workspace
%
clc;
fprintf("Start initialization...\n");
%
% schließt ebenfalls sogenannte "hidden figures"
figHandles = findall(groot, 'Type', 'figure');
close(figHandles);
%
clear all;
diary off;
restoredefaultpath;



%% Globale Variablen
%
% Symbolisiert von der Init-Datei abhänigen Skripte, dass die
% Init-Datei ausgeführt wurde.
global GENERAL_INIT_EXECUTED;
GENERAL_INIT_EXECUTED = true;
%
% Absoluter Pfad der Init-Datei
global GENERAL_INIT_PATH;
GENERAL_INIT_PATH = fileparts(mfilename('fullpath'));
%
% Standart Output-Pfad (Vorschlag, muss nicht verwendet werden)
% Standart = relativ zum Pfad dieses Skriptes
global GENERAL_OUTPUT_PATH; 
GENERAL_OUTPUT_PATH = char(sprintf("%s\\%s", GENERAL_INIT_PATH, "Output"));
[~,~] = mkdir(GENERAL_OUTPUT_PATH);
%
global GENERAL_DATABASE_PATH; 
GENERAL_DATABASE_PATH = 'N:\SIP2_SS18\Software\02_resampled_database';
[~,~] = mkdir(GENERAL_DATABASE_PATH) 



%% Pfade zur Datenbank
%
addpath('N:\Datenbank\HNO_2015');
%
addpath('N:\Datenbank\HNO_2017');
%
addpath('N:\Datenbank\HNO_2017_SOMTE');
%
addpath(GENERAL_DATABASE_PATH);





fprintf("Initialization success!\n\n");
