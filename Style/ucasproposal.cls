%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]%
\ProvidesClass{ucasproposal}[2014/10/01 v0.1 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
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
%-
%-> Draft version info
%-
\newif\ifUCAS@versioninfo \UCAS@versioninfofalse
\DeclareOption{draftversion}{%
    \UCAS@versioninfotrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexart}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\ifUCAS@doublesided% if double-sided printing enabled
  \LoadClass[UTF8,a4paper,twoside,12pt]{ctexart}
\else% if double-sided printing isn't enabled
  \LoadClass[UTF8,a4paper,oneside,12pt]{ctexart}
\fi
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/ucasproposal.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- left side width of [odd, even] page = [odd, even]sidemargin + 1.0in (fixed) + hoffset
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{150mm}% set required text width first
\ifUCAS@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{10mm}% binding side width
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{5mm}% left side width
    \setlength{\evensidemargin}{5mm}% ensure uniform left side width for EThesis
\fi
%- set margin for notes to zero
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{240mm}% set required text height first
\setlength{\voffset}{-20mm}% set a minimum header height
\setlength{\headheight}{15pt}% set a minimum header height
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.3}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
    \renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}% set underline color
    \renewcommand{\uline}[1]{\CJKunderline{#1}}% unified name
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \uline{#2}}
\newcommand{\ulhshift}{-3em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%- special cell
%- \specialcell[<align2>]{align1}{text1\\text2};
%- <align1>: t,c,b; <align2> l,c,r; @{} suppress spaces before and after text 
\newcommand{\specialcell}[3][c]{%
    \begin{tabular}[#2]{@{}#1@{}}#3\end{tabular}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\newcommand{\schoollogo}[2]{\def\UCAS@value@schoollogo{\includegraphics[#1]{#2}}}
\renewcommand{\title}[2][\UCAS@value@title]{%
  \def\UCAS@value@title{#2}
  %\def\UCAS@value@titlemark{\MakeUppercase{#1}}}
  \def\UCAS@value@titlemark{#1}}
\renewcommand{\@title}{\UCAS@value@titlemark}
\renewcommand{\author}[1]{\def\UCAS@value@author{#1}}
\newcommand{\authorid}[1]{\def\UCAS@value@authorid{#1}}
\newcommand{\advisor}[1]{\def\UCAS@value@advisor{#1}}
\newcommand{\advisortitle}[1]{\def\UCAS@value@advisortitle{#1}}
\newcommand{\degree}[1]{\def\UCAS@value@degree{#1}}
\newcommand{\degreetype}[1]{\def\UCAS@value@degreetype{#1}}
\newcommand{\major}[1]{\def\UCAS@value@major{#1}}
\newcommand{\field}[1]{\def\UCAS@value@field{#1}}
\newcommand{\institute}[1]{\def\UCAS@value@institute{#1}}
\newcommand{\chinesedate}[1]{\def\UCAS@value@chinesedate{#1}}
%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \zihao{-3}\bfseries
        \vspace*{10pt}

        {\UCAS@value@schoollogo}

        \vspace*{20pt}

        {\zihao{1}\bfseries\sffamily \UCAS@label@thesis}

        \vspace*{195pt}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{lc}
            %\UCAS@label@title & \ulenhance{\ulextend{\shortstack{\UCAS@value@title}}}\\
            \UCAS@label@title & \ulenhance{\ulextend{\specialcell[c]{b}{\UCAS@value@title}}}\\
            \UCAS@label@author & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\UCAS@value@author}}\UCAS@label@authorid\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\UCAS@value@authorid}}\\
            \UCAS@label@advisor & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\UCAS@value@advisor}}\UCAS@label@advisortitle\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\UCAS@value@advisortitle}}\\
            \UCAS@label@degree & \ulenhance{\ulextend{\UCAS@value@degreetype\UCAS@value@degree}}\\
            \UCAS@label@major & \ulenhance{\ulextend{\UCAS@value@major}}\\
            \UCAS@label@field & \ulenhance{\ulextend{\UCAS@value@field}}\\
            \UCAS@label@institute & \ulenhance{\ulextend{\UCAS@value@institute}}\\
            \UCAS@label@date & \ulenhance{\ulextend{\UCAS@value@chinesedate}}
      \end{tabular}

      \vspace*{50pt}

      {\UCAS@label@mark}
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
        \cleardoublepage[empty]
    \else
        \ifUCAS@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
}
%---------------------------------------------------------------------------%
\endinput

