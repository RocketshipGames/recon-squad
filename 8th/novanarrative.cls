\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{novanarrative}[2017/01/01 NOVA 40k Narrative Template]

%%----------------------------------------------------------------------
%%-- Core Packages

\LoadClass[12pt,twoside,openany]{book}

\pdfminorversion=4

\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{suffix}

% xcolor has to lead here to avoid options conflicts from other packages
\RequirePackage[usenames,dvipsnames,table]{xcolor}

%%----------------------------------------------------------------------
%%-- Options

\DeclareOption{nobackground}{\renewcommand{\setbackground}{}}
\ProcessOptions

%%----------------------------------------------------------------------
%%-- Geometry

\RequirePackage[
%     showframe,
     paperwidth=8.5in, paperheight=11in,
%     textwidth=7.5in, textheight=10in,
     margin={0.5in,0.75in},
     headheight=24pt,
     headsep=0.5in-24pt
]{geometry}   % for margins

\setlength{\parskip}{\medskipamount}

\newenvironment{columns}
{\begin{multicols}{2}
\@afterindentfalse\@afterheading
}
{\end{multicols}
\ignorespacesafterend
}

\newcommand{\divider}{%
\hrule
\vspace*{3pt}
\hrule
}

%%----------------------------------------------------------------------
%%-- Background

\newcommand{\backgroundpicodd}{-odd.pdf}
\newcommand{\backgroundpiceven}{art/background/background-even.pdf}
\RequirePackage{changepage}

\newcommand{\setbackground}{%
\AddToShipoutPicture{\BackgroundPic{art/background/background}}%
}

\RequirePackage{eso-pic}

\newcommand\BackgroundPic[1]{%
\put(0,0){%
\parbox[b][\paperheight]{\paperwidth}{%
\vfill%
\centering%
\checkoddpage
\ifoddpage
\includegraphics[width=\paperwidth,height=\paperheight,keepaspectratio]{#1}%
\else
\reflectbox{\includegraphics[width=\paperwidth,height=\paperheight,keepaspectratio]{#1}}%
\fi
%
\vfill%
}}}

\newcommand{\squelchbackground}{%
\ClearShipoutPicture
}

\newcommand{\restorebackground}{%
\setbackground
}

\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\squelchbackground\origdoublepage}%
  \restorebackground
}
\let\cleardoublepage\clearemptydoublepage

%%----------------------------------------------------------------------
%%-- Fonts

% Change the base font to Helvetica Sans
\RequirePackage[T1]{fontenc}
\RequirePackage[scaled]{helvet}
\renewcommand*{\familydefault}{\sfdefault}

\newcommand{\coalitionfont}{\usefont{T1}{coalition}{m}{n}}

\RequirePackage{pifont}

\RequirePackage{textcomp}

%%----------------------------------------------------------------------
%%-- Colors

\definecolor{LightGray}{RGB}{245,245,245}

%\definecolor{LineColor}{HTML}{a77337}% 2016
\definecolor{LineColor}{HTML}{6f8a91}% 2017

%%----------------------------------------------------------------------
%%-- Header and Footer

% titlesec needed here for page styles
\RequirePackage[explicit,compact,pagestyles]{titlesec}
\RequirePackage{adjustbox}

\newcommand{\currentname}{}
\newcommand{\footname}[1]{\renewcommand{\currentname}{#1}}

\newpagestyle{onlyfoot}{%
  \sethead
    []%[\color{LineColor}\coalitionfont The Human Condition]% Even-left
    []% Even-center
    []% Even-right
    {}% Odd-left
    {}% Odd-center
    {}% Odd-right
    
  \setfoot
    [\color{LineColor}\coalitionfont\thepage]% Even-left
    []% Even-center
    [\color{LineColor}\coalitionfont\MakeUppercase{Rocketship Games}]% Even-right
    {\color{LineColor}\coalitionfont RECON SQUAD}% Odd-left
    {}% Odd-center
    {\color{LineColor}\coalitionfont\thepage}% Odd-right
}

\newpagestyle{main}{%
  \sethead
    []%[\color{LineColor}\coalitionfont The Human Condition]% Even-left
    []% Even-center
    []% Even-right
    {}% Odd-left
    {}% Odd-center
    {}% Odd-right{\lapbox[\width]{0.375in}{\raisebox{0pt}[.8\height]{\includegraphics[height=2.5\headheight]{art/logos/novaopen-outlined-shadow}}}}
    
  \setfoot
    [\color{LineColor}\coalitionfont\thepage]% Even-left
    []% Even-center
    [\color{LineColor}\coalitionfont\MakeUppercase{Rocketship Games}]% Even-right
    {\color{LineColor}\coalitionfont RECON SQUAD}% Odd-left
    {}% Odd-center
    {\color{LineColor}\coalitionfont\thepage}% Odd-right
}

\pagestyle{main}
\assignpagestyle{\chapter}{main}

%%----------------------------------------------------------------------
%%-- Section Headings

\titleformat{\chapter}
[display] % Shape
{\color{LineColor}\fontsize{36}{36}\coalitionfont} % Format
{} % Label
{0pt} % Separation
{\MakeUppercase{#1}} % Command (explicit)

\titlespacing*{\chapter}
{0pt}% Left
{-6pt}% Before
{0pt}% After

\makeatletter
\patchcmd{\ttlh@display}{\strut}{}{}{}
\makeatother

\titleformat{\section}
[display] % Shape
{\color{LineColor}\fontsize{18}{18}\coalitionfont} % Format {\bfseries\sffamily\Large} % Format
{} % Label
{0pt} % Separation
{#1} % Command (explicit)

\titlespacing*{\section}
{0pt}% left margin
{16pt}% before
{4pt}% after

\titleformat{\subsection}
[display] % Shape
{\color{LineColor}\fontsize{14}{14}\coalitionfont} % Format {\bfseries\sffamily\Large} % Format
{} % Label
{0pt} % Separation
{#1} % Command (explicit)

\titlespacing*{\subsection}
{0pt}% left margin
{16pt}% before
{4pt}% after

%%----------------------------------------------------------------------
%%-- Arrays and Lists

\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{amsmath}
\RequirePackage{tabularx}
\RequirePackage{array}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{F}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{E}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{O}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

\RequirePackage{enumitem}


\newcommand{\shortlist}{
\setlength{\labelwidth}{0pt}
\setlength{\leftmargin}{0pt}
% \setlength{\labelsep}{0pt}
% \renewcommand{\labelitemi}{*}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
\setlength{\headsep}{0pt}
\setlength{\topskip}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\topsep}{0pt}
\setlength{\partopsep}{0pt}
}

\newenvironment{squishitemize}
{\begin{list}{$\bullet$}{%
    \setlength{\itemsep}{2pt}%
    \setlength{\parsep}{2pt}%
    \setlength{\topsep}{2pt}%
    \setlength{\parskip}{0pt} %
%    \setlength{\labelwidth}{.5in}%
%    \setlength{\labelsep}{0.05in} %
%    \setlength{\leftmargin}{0.2in} %
    \renewcommand{\labelitemi}{--}}}
  {\end{list}}

%%----------------------------------------------------------------------
%%-- Story Boxes

\newenvironment{storyquote}
{
\noindent\begin{minipage}[t]{1.0\linewidth}\centering
\begin{tikzpicture}
\node (t) at (0,0) \bgroup
\begin{minipage}[c]{5.5in}\centering\Large\usefont{T1}{ostrichblack}{m}{n}
}
{\end{minipage}
\egroup;
\node[above = -1.5em of t] {\includegraphics{art/rules/rule-top.pdf}};
\node[below = -1.5em of t] {\includegraphics[angle=180]{art/rules/rule-top.pdf}};
\end{tikzpicture}
\end{minipage}
}

\newenvironment{storyquotepage}
{
\clearpage
\squelchbackground
\thispagestyle{empty}

\vbox to 0pt{}
\vfill
\begin{storyquote}
}
{
\end{storyquote}
\vfill
\vbox to 0pt{}

\pagebreak

\restorebackground
}

%%----------------------------------------------------------------------
%%-- Graphics

\RequirePackage{graphicx}

\RequirePackage{tikz}
\usetikzlibrary{shapes}
\usetikzlibrary{decorations}
\usetikzlibrary{calc}
\usetikzlibrary{positioning}

\RequirePackage{pdfpages}
%\includepdfset{offset=1in -0.5in}

\newcommand*{\shiftbox}[2]{%
  \settowidth{\@tempdima}{#2}%
  \makebox[\@tempdima]{\hspace*{#1}#2}%
}

\newcommand{\rescheck}{$\Box$}

%%----------------------------------------------------------------------
%%-- Misc Packages

\RequirePackage[obeyspaces]{url}

\RequirePackage{latexsym}

%%----------------------------------------------------------------------
%%-- End

\setbackground

\endinput
