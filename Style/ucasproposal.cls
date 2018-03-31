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
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{ucasproposal}[2014/10/01 v0.1 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\newif\ifucas@singlesided \ucas@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
    \ucas@singlesidedtrue%
}
\newif\ifucas@doublesided \ucas@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
    \ucas@doublesidedtrue%
}
\newif\ifucas@printcopy \ucas@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \ucas@doublesidedtrue% auto enable double-sided style
    \ucas@printcopytrue%
}
%-
%-> Draft version info
%-
\newif\ifucas@versioninfo \ucas@versioninfofalse
\DeclareOption{draftversion}{%
    \ucas@versioninfotrue%
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
\ifucas@doublesided% if double-sided printing enabled
  \LoadClass[UTF8,a4paper,twoside,zihao=-4]{ctexart}
\else% if double-sided printing isn't enabled
  \LoadClass[UTF8,a4paper,oneside,zihao=-4]{ctexart}
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
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifucas@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{6.3mm}% left side margin
    \setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
\setlength{\voffset}{-17.4mm}% set vertical offset
\setlength{\topmargin}{20pt}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{29.5pt}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.5}% line space setting
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
\newcommand{\schoollogo}[2]{\def\ucas@value@schoollogo{\includegraphics[#1]{#2}}}
\renewcommand{\title}[2][\ucas@value@title]{%
  \def\ucas@value@title{#2}
  %\def\ucas@value@titlemark{\MakeUppercase{#1}}}
  \def\ucas@value@titlemark{#1}}
\renewcommand{\@title}{\ucas@value@titlemark}
\renewcommand{\author}[1]{\def\ucas@value@author{#1}}
\newcommand{\authorid}[1]{\def\ucas@value@authorid{#1}}
\newcommand{\advisor}[1]{\def\ucas@value@advisor{#1}}
\newcommand{\advisortitle}[1]{\def\ucas@value@advisortitle{#1}}
\newcommand{\degree}[1]{\def\ucas@value@degree{#1}}
\newcommand{\degreetype}[1]{\def\ucas@value@degreetype{#1}}
\newcommand{\major}[1]{\def\ucas@value@major{#1}}
\newcommand{\field}[1]{\def\ucas@value@field{#1}}
\newcommand{\institute}[1]{\def\ucas@value@institute{#1}}
\newcommand{\chinesedate}[1]{\def\ucas@value@chinesedate{#1}}
%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.3}
        \zihao{-3}\bfseries
        \vspace*{10pt}

        {\ucas@value@schoollogo}

        \vspace*{20pt}

        {\zihao{1}\bfseries\sffamily \ucas@label@thesis}

        \vspace*{195pt}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{lc}
            %\ucas@label@title & \ulenhance{\ulextend{\shortstack{\ucas@value@title}}}\\
            \ucas@label@title & \ulenhance{\ulextend{\specialcell[c]{b}{\ucas@value@title}}}\\
            \ucas@label@author & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@author}}\ucas@label@authorid\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@authorid}}\\
            \ucas@label@advisor & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@advisor}}\ucas@label@advisortitle\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@advisortitle}}\\
            \ucas@label@degree & \ulenhance{\ulextend{\ucas@value@degreetype\ucas@value@degree}}\\
            \ucas@label@major & \ulenhance{\ulextend{\ucas@value@major}}\\
            \ucas@label@field & \ulenhance{\ulextend{\ucas@value@field}}\\
            \ucas@label@institute & \ulenhance{\ulextend{\ucas@value@institute}}\\
            \ucas@label@date & \ulenhance{\ulextend{\ucas@value@chinesedate}}
      \end{tabular}

      \vspace*{50pt}

      {\ucas@label@mark}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifucas@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifucas@versioninfo
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
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- define spacing and length
\def\@dotsep{1.5mu}% spacing for dots
\def\@pnumwidth{2em}% spacing between titles and page numbers
\def\@tocrmarg{2em}% right margin indentation
\def\@chaptervspace{1ex}% spacing between chapter titles
%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\sffamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from article.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty\@secpenalty
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \if@compatibility
                \global\@nobreaktrue
                \everypar{\global\@nobreakfalse\everypar{}}%
            \fi
        \endgroup
    \fi
}
%- redefine l@section from article.cls to add dotted toc line
\renewcommand*\l@section[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\z@
        \addpenalty\@secpenalty
        \addvspace{1.0em \@plus\p@}%
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\sffamily
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
        \endgroup
    \fi
}
%---------------------------------------------------------------------------%
\endinput

