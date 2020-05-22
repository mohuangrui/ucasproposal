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
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}%
\@iflatexlater{2017/01/01}{}{%
    \ClassError{ucasproposal}{TeXLive/MikTex >= 2017 is required ...}{}%
}
\ProvidesClass{ucasproposal}[2014/10/01 v1.0 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\DeclareOption{oneside}{%
    \PassOptionsToClass{oneside}{ctexart}%
}
\DeclareOption{twoside}{%
    \PassOptionsToClass{twoside}{ctexart}%
}
\newif\ifucas@print \ucas@printfalse
\DeclareOption{print}{%
    \PassOptionsToClass{twoside}{ctexart}%
    \ucas@printtrue%
}
%-
%-> Language
%-
\newif\ifucas@plain \ucas@plainfalse
\DeclareOption{scheme=plain}{% enable plain writing style
    \PassOptionsToClass{scheme=plain}{ctexart}%
    \ucas@plaintrue%
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
\LoadClass[UTF8,a4paper,zihao=-4]{ctexart}%
\@ifclasslater{ctexart}{2017/01/01}{}{%
    \ClassError{ucasthesis}{ctex >= 2017/01/01 is required ...}{}%
}
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn
\newcommand{\ucaslntotab}[2][1pt]{% convert lines into table lines
    \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
    \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
    \clist_clear:N \l_tmpb_clist
    \clist_map_inline:Nn \l_tmpa_clist
      {%
        \clist_put_right:Nn \l_tmpb_clist 
          { \ulenhance[#1]{\ulextend{##1}} }
      }
    %\clist_show:N\l_tmpb_clist% show the content of comma list
    \clist_use:Nn \l_tmpb_clist { \\ & }
}
\ExplSyntaxOff
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
%- use \topmargin insead of \voffset to shift the complete text vertically
%- use \<odd|even>sidemargin insead of \hoffset to shift text horizontally
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifucas@print% if print layout enabled
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
\setlength{\voffset}{0mm}% set vertical offset
\setlength{\topmargin}{-10.4mm}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{10.4mm}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.6}% line space setting
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
\ifxetex%
    \RequirePackage{ulem}%
\else%
    \RequirePackage{ulem}%
\fi
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \setlength{\ULdepth}{0.3em}% set depth
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
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
\def\ucas@value@ch@schoollogo{}
\newcommand{\schoollogo}[2]{\def\ucas@value@ch@schoollogo{\includegraphics[#1]{#2}}}
\def\ucas@value@ch@title{}
\def\ucas@value@ch@titlemark{}
\renewcommand{\title}[2][\ucas@value@ch@title]{%
  \def\ucas@value@ch@title{#2}
  %\def\ucas@value@ch@titlemark{\MakeUppercase{#1}}}
  \def\ucas@value@ch@titlemark{#1}}
\def\ucas@value@ch@author{}
\renewcommand{\author}[1]{\def\ucas@value@ch@author{#1}}
\def\ucas@value@ch@authorid{}
\newcommand{\authorid}[1]{\def\ucas@value@ch@authorid{#1}}
\def\ucas@value@ch@advisor{}
\newcommand{\advisor}[1]{\def\ucas@value@ch@advisor{#1}}
\def\ucas@value@ch@advisortitle{}
\newcommand{\advisortitle}[1]{\def\ucas@value@ch@advisortitle{#1}}
\def\ucas@value@ch@degree{}
\newcommand{\degree}[1]{\def\ucas@value@ch@degree{#1}}
\def\ucas@value@ch@degreetype{}
\newcommand{\degreetype}[1]{\def\ucas@value@ch@degreetype{#1}}
\def\ucas@value@ch@major{}
\newcommand{\major}[1]{\def\ucas@value@ch@major{#1}}
\def\ucas@value@ch@field{}
\newcommand{\field}[1]{\def\ucas@value@ch@field{#1}}
\def\ucas@value@ch@institute{}
\newcommand{\institute}[1]{\def\ucas@value@ch@institute{#1}}
\def\ucas@value@ch@date{}
\newcommand{\chinesedate}[1]{\def\ucas@value@ch@date{#1}}
%-
%-> English item commands
%-
\def\ucas@value@en@titlemark{\ucas@value@ch@titlemark}
\def\ucas@value@en@author{\ucas@value@ch@author}
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

        {\ucas@value@ch@schoollogo}

        \vspace*{20pt}

        {\zihao{1}\bfseries\sffamily \ucas@label@ch@thesis}

        \vspace*{195pt}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{lc}
            %\ucas@label@ch@title & \ulenhance{\ulextend{\shortstack{\ucas@value@ch@title}}}\\
            %\ucas@label@ch@title & \ulenhance{\ulextend{\specialcell[c]{b}{\ucas@value@ch@title}}}\\
            \ucas@label@ch@title & \ucaslntotab{\ucas@value@ch@title}\\
            \ucas@label@ch@author & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@ch@author}}\ucas@label@ch@authorid\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@ch@authorid}}\\
            \ucas@label@ch@advisor & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@ch@advisor}}\ucas@label@ch@advisortitle\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@ch@advisortitle}}\\
            \ucas@label@ch@degree & \ulenhance{\ulextend{\ucas@value@ch@degreetype\ucas@value@ch@degree}}\\
            \ucas@label@ch@major & \ulenhance{\ulextend{\ucas@value@ch@major}}\\
            \ucas@label@ch@field & \ulenhance{\ulextend{\ucas@value@ch@field}}\\
            \ucas@label@ch@institute & \ucaslntotab{\ucas@value@ch@institute}\\
            \ucas@label@ch@date & \ulenhance{\ulextend{\ucas@value@ch@date}}
      \end{tabular}

      \vspace*{50pt}

      {\ucas@label@ch@mark}
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
    \ifucas@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
}
%---------------------------------------------------------------------------%
%->> Structure elements
%---------------------------------------------------------------------------%
\ifucas@plain%
    \def\contentsname{\ucas@label@en@tocname}
    \def\listfigurename{\ucas@label@en@lsfigname}
    \def\listtablename{\ucas@label@en@lstabname}
    \def\bibname{\ucas@label@en@bibname}
    \def\refname{\ucas@label@en@bibname}
    \def\algname{\ucas@label@en@algname}
    \def\bibetal{\ucas@label@en@bibetal}
    \def\biband{\ucas@label@en@biband}
    \def\axiomname{\ucas@label@en@axiomname}
    \def\theoremname{\ucas@label@en@theoremname}
    \def\lemmaname{\ucas@label@en@lemmaname}
    \def\corollaryname{\ucas@label@en@corollaryname}
    \def\assertionname{\ucas@label@en@assertionname}
    \def\propositionname{\ucas@label@en@propositionname}
    \def\conjecturename{\ucas@label@en@conjecturename}
    \def\definitionname{\ucas@label@en@definitionname}
    \def\examplename{\ucas@label@en@examplename}
    \def\remarkname{\ucas@label@en@remarkname}
    \def\proofname{\ucas@label@en@proofname}
    \def\@title{\ucas@value@en@titlemark}
    \def\@author{\ucas@value@en@author}
\else
    \def\contentsname{\ucas@label@ch@tocname}
    \def\listfigurename{\ucas@label@ch@lsfigname}
    \def\listtablename{\ucas@label@ch@lstabname}
    \def\algname{\ucas@label@ch@algname}
    \def\bibname{\ucas@label@ch@bibname}
    \def\refname{\ucas@label@ch@bibname}
    \def\bibetal{\ucas@label@ch@bibetal}
    \def\biband{\ucas@label@ch@biband}
    \def\axiomname{\ucas@label@ch@axiomname}
    \def\theoremname{\ucas@label@ch@theoremname}
    \def\lemmaname{\ucas@label@ch@lemmaname}
    \def\corollaryname{\ucas@label@ch@corollaryname}
    \def\assertionname{\ucas@label@ch@assertionname}
    \def\propositionname{\ucas@label@ch@propositionname}
    \def\conjecturename{\ucas@label@ch@conjecturename}
    \def\definitionname{\ucas@label@ch@definitionname}
    \def\examplename{\ucas@label@ch@examplename}
    \def\remarkname{\ucas@label@ch@remarkname}
    \def\proofname{\ucas@label@ch@proofname}
    \def\@title{\ucas@value@ch@titlemark}
    \def\@author{\ucas@value@ch@author}
\fi
%---------------------------------------------------------------------------%
%->> Structure elements configuration
%---------------------------------------------------------------------------%
%- section
\ctexset {
    section = {
        format = \centering\zihao{4}\sffamily,
        number = {\chinese{section}},
        aftername = \quad,
        beforeskip = {24pt},
        afterskip = {6pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \sffamily,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \sffamily,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number

%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
\def\@sectionvspace{1ex}% vertical space between section titles

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
        \addvspace{\@sectionvspace \@plus\p@}%
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
%- redefine indentation for others
%\renewcommand*\l@section{\@dottedtocline{1}{0em}{1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{1em}{1.8em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{2em}{2.8em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{3em}{3.8em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{4em}{4.8em}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{0.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{0em}{0.8em}}
%---------------------------------------------------------------------------%
\endinput

