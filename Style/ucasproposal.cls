%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Version Information ********************************
%%
%% Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%% This is free software: you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ucasproposal}
  [2014/10/01 v1.0 ucasproposal
   document class]
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Declare Options **************************************
%%
%% end-user parameters, each option is declared by one declare option command
\newif\ifUCAS@versioninfo \UCAS@versioninfofalse
\DeclareOption{draftversion}{% draft information reminder
  \UCAS@versioninfotrue%
}
\newif\ifUCAS@singlesided \UCAS@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
  \UCAS@singlesidedtrue%
}
\newif\ifUCAS@doublesided \UCAS@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
  \UCAS@doublesidedtrue%
}
\newif\ifUCAS@printcopy \UCAS@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
  \UCAS@doublesidedtrue% auto enable double-sided style
  \UCAS@printcopytrue%
}
\DeclareOption*{% handle non-implemented options
  \PassOptionsToClass{\CurrentOption}{ctexart}%
}
%% terminates all options processing
\ProcessOptions\relax
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Loadclass Infomation *********************************
%%
\ifUCAS@doublesided% if double-sided printing enabled
  \LoadClass[UTF8,a4paper,twoside,fntef,12pt]{ctexart}
\else% if double-sided printing isn't enabled
  \LoadClass[UTF8,a4paper,oneside,fntef,12pt]{ctexart}
\fi
%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Package Infomation *********************************
%%
%% color packages
\RequirePackage[usenames,dvipsnames,table]{xcolor}%
%% math packages
\RequirePackage{amsmath,amssymb,amstext}
%%%%% --------------------------------------------------------------------------------
%%
%%%%************************ Load Class Configuretion ********************************
%%
\AtEndOfPackage{%class cfg loaded after package, makes commands at preamble take effect
  \makeatletter
  \InputIfFileExists{Style/ucasproposal.cfg}{}{}
  \makeatother
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%******************************* Page Layout **************************************
%%
%% part one -- horizontal widths
%% left side width + textwidth + right side width = paperwidth
%% left side width of [odd, even] page = [odd, even]sidemargin + 1.0in (fixed) + hoffset
%% binding side width + textwidth + nonbinding side width = paperwidth
%% binding side width of [odd, even] page = [left, right] side width
%% assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{150mm}% set required text width first
\ifUCAS@printcopy% if print copy layout enabled
  \setlength{\oddsidemargin}{10mm}% binding side width
  \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
  \setlength{\oddsidemargin}{5mm}% left side width
  \setlength{\evensidemargin}{5mm}% ensure uniform left side width for EThesis
\fi
 %% set margin for notes to zero
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%% part two -- vertical heights
%% top height + textheight + bottom height = paperheight
%% top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{240mm}% set required text height first
\setlength{\voffset}{-15mm}% set a minimum header height
\setlength{\headheight}{15pt}% set a minimum header height
%% specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%% line spacing
\renewcommand{\baselinestretch}{1.4} % line space setting
\raggedbottom % prevent adding vertical white space in strange places
%% default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* Some Style Control Commands ********************************
%%
%% redefine cleardoublepage to empty pages
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \thispagestyle{empty}%
\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
%% underline
\renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}
\def\UCAS@underline[#1]#2{%
    \CJKunderline{\hbox to #1{\hfill#2\hfill}}}
\def\UCASunderline{\@ifnextchar[\UCAS@underline\CJKunderline}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************** Chinese Titlepage Items ***********************************
%%
\newcommand\schoollogo[2]{\def\UCAS@value@schoollogo{\includegraphics[#1]{#2}}}
\renewcommand\title[2][\UCAS@value@title]{%
  \def\UCAS@value@title{#2}
  %\def\UCAS@value@titlemark{\MakeUppercase{#1}}}
  \def\UCAS@value@titlemark{#1}}
\def\@title{\UCAS@value@titlemark}
\renewcommand\author[1]{\def\UCAS@value@author{#1}}
\newcommand\authorid[1]{\def\UCAS@value@authorid{#1}}
\newcommand\advisor[1]{\def\UCAS@value@advisor{#1}}
\newcommand\advisortitle[1]{\def\UCAS@value@advisortitle{#1}}
\newcommand\degree[1]{\def\UCAS@value@degree{#1}}
\newcommand\degreetype[1]{\def\UCAS@value@degreetype{#1}}
\newcommand\major[1]{\def\UCAS@value@major{#1}}
\newcommand\field[1]{\def\UCAS@value@field{#1}}
\newcommand\institute[1]{\def\UCAS@value@institute{#1}}
\newcommand\chinesedate[1]{\def\UCAS@value@chinesedate{#1}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%**************************** Make Titlepage ******************************
%%
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \zihao{-3}\bfseries\songti
    \vspace*{10pt}

    \UCAS@value@schoollogo

    \vspace*{20pt}

    {\zihao{1} \UCAS@label@thesis}

    \vspace*{195pt}

    \def\tabcolsep{1pt}
    \def\arraystretch{1.2}
    %\hskip -15pt
    \begin{tabular}{lc}
      \UCAS@label@title & \UCASunderline[295pt]{\UCAS@value@title}
    \\
      \UCAS@label@author & \UCASunderline[132pt]{\UCAS@value@author}\UCAS@label@authorid\UCASunderline[132pt]{\UCAS@value@authorid}
    \\
      \UCAS@label@advisor & \UCASunderline[132pt]{\UCAS@value@advisor}\UCAS@label@advisortitle\UCASunderline[132pt]{\UCAS@value@advisortitle}
    \\
      \UCAS@label@degree & \UCASunderline[295pt]{\UCAS@value@degreetype\UCAS@value@degree}
    \\
      \UCAS@label@major &  \UCASunderline[295pt]{\UCAS@value@major}
    \\
      \UCAS@label@field &  \UCASunderline[295pt]{\UCAS@value@field}
    \\
      \UCAS@label@institute & \UCASunderline[295pt]{\UCAS@value@institute}
    \\
      \UCAS@label@date & \UCASunderline[295pt]{\UCAS@value@chinesedate}
    \end{tabular}

    \vspace*{50pt}

    \UCAS@label@mark
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \ifUCAS@versioninfo
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
    \fi
    \cleardoublepage
  \else
    \ifUCAS@versioninfo
      \thispagestyle{empty}
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
      \cleardoublepage
    \fi
  \fi
}
%%%%% --------------------------------------------------------------------------------
\endinput
%% End of file
%%%%% --------------------------------------------------------------------------------
