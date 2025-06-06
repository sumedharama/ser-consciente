% Anecdote Class
%
% A memoir-based documentclass with a contemporary style for books with a lighter content.
%
% https://github.com/profound-labs/anecdote
%
% http://profound-labs.github.io/projects/anecdote/
%
% (c) Gambhiro Bhikkhu, 2017
% gambhiro.bhikkhu.85@gmail.com
%
% LPPL LaTeX Pubic Project Licence
%

% TODO: document interfaces
% TODO: test document to compile

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anecdote}[2017/08/19 v0.11 A memoir-based documentclass with a contemporary style for books.]

% ========================
% Preliminary Declarations
% ========================

\newif\ifdesktopversion
\desktopversionfalse

\newif\ifoverleaf
\overleaffalse

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
  babelLanguage/.default=british,
  babelLanguage/.store in=\BOOK@babelLanguage,
  desktopVersion/.code=\desktopversiontrue,
  overleaf/.code=\overleaftrue,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/BOOK}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

\LoadClass[11pt,twoside]{memoir}

% \raggedbottom stops these warnings:
%
% Underfull \vbox (badness 10000) has occurred while \output is active
%
% by not streching the glue in vertical spaces, such as before and after chapter
% and section headings. The bottom of the pages will be uneven.
%
% Default is \flushbottom. The small streches are good because an even page
% bottom is better. When it causes large streches, it is better to put in
% a \clearpage manually.
%
% NOTE use the 'bottom' footmisc option when using \raggedbottom.

% NOTE Using \raggedbottom in this book. There are many quotes and the pages
% frequently have to break early anyway.
\raggedbottom

% \raggedbottomsection only affects pages where the section header was moved to
% the next page.

\raggedbottomsection

% === Color Profile ===

% Embed a color profile in the PDF for correctly interpreting CMYK images.

% \ifoverleaf\relax
% \else
% 
% \immediate\pdfobj stream attr{/N 4} file{assets/other/UncoatedFOGRA29.icc}
% \pdfcatalog{%
%   /OutputIntents [ <<
%   /Type /OutputIntent
%   /S/GTS_PDFX
%   /DestOutputProfile \the\pdflastobj\space 0 R
%   /OutputConditionIdentifier (Uncoated FOGRA29 (ISO 12647-2:2004))
%   /Info(Uncoated FOGRA29 (ISO 12647-2:2004))
%   /RegistryName (http://www.color.org/)
%   >> ]
% }
% 
% \fi

% === Book Core ===

%\RequirePackage{silence}
%\WarningsOff

\RequirePackage[\BOOK@babelLanguage]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage[geometry]{ifsym}
\RequirePackage{textcomp}
% Don't use the [cmyk] option. Specify the color model in the color definitions.
\RequirePackage{xcolor}
\RequirePackage{xcoffins}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{footnote}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{longtable}

\RequirePackage{tikz}
\usetikzlibrary{positioning}

% === Define colors ===

% Define text colors as Gray color values.
\definecolor{textbody}{gray}{0.05}% 95% is good for contrast, on yellowish paper it is not harsh.
\definecolor{footnoterule}{gray}{0.5}
\definecolor{header}{gray}{0.2}
\definecolor{footer}{gray}{0.2}
\definecolor{chapternum}{gray}{0.8}
\definecolor{chaptertitle}{gray}{0.3}
\definecolor{chaptertitlefootnote}{gray}{0.4}
\definecolor{chapterauthor}{gray}{0.3}
\definecolor{chapternote}{gray}{0.3}
\definecolor{section}{gray}{0.5}
\definecolor{tocleftside}{gray}{0.5}
\definecolor{tocleftsidepart}{gray}{0.2}
\definecolor{partname}{gray}{0.5}
\definecolor{parttitle}{gray}{0.3}
\definecolor{linkborder}{rgb}{0.4,0.4,1}% light blue
\definecolor{link}{rgb}{0.2,0.2,1}% not so light blue

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./assets/fonts/}, }

% If -- dashes don't work for your font, try
% Renderer = Basic
% http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

\setmainfont[
  SmallCapsFont = Crimson-Roman.otf,
  SmallCapsFeatures= { Ligatures = TeX, Letters = SmallCaps, Scale = 0.8, LetterSpace = 0.2 },
  ItalicFont = GentiumPlus-I.ttf,
  BoldFont = GenBkBasB.ttf,
  BoldItalicFont = GenBkBasBI.ttf,
]{GentiumPlus-R.ttf}

\newfontfamily\crimsonRomanFont[
  SmallCapsFeatures= { LetterSpace = 0.2 },
  BoldFont = Crimson-Semibold.otf,
  ItalicFont = Crimson-Italic.otf,
]{Crimson-Roman.otf}

\newfontfamily\crimsonRomanFontOldNum[
  Numbers = OldStyle,
]{Crimson-Roman.otf}

\newfontfamily\gentiumFont[
  ItalicFont = GentiumPlus-I.ttf,
  BoldFont = GenBkBasB.ttf,
  BoldItalicFont = GenBkBasBI.ttf,
]{GentiumPlus-R.ttf}

\newfontfamily\alegreyaScFont[
  ItalicFont = AlegreyaSC-Italic.otf,
  BoldFont = AlegreyaSC-Bold.otf,
  BoldItalicFont = AlegreyaSC-BoldItalic.otf,
]{AlegreyaSC-Regular.otf}

% header and footer

\newcommand\headerFont\crimsonRomanFont
\newcommand\footerFont\gentiumFont
\newcommand\pageNumFont\gentiumFont

% chapter and section

\newcommand\partTitleFont\alegreyaScFont

\newcommand\chapterNameFont\alegreyaScFont
\newcommand\chapterTitleFont\alegreyaScFont
\newcommand\chapterNumberFont\alegreyaScFont
\newcommand\chapterAuthorFont\crimsonRomanFont
\newcommand\chapterNoteFont\crimsonRomanFont

\newcommand\sectionFont\alegreyaScFont

% toc

\newcommand\tocFont\crimsonRomanFont
\newcommand\tocFontOldNum\crimsonRomanFontOldNum

% Some default font sizes, use \renewcommand to adjust

\newcommand{\chapterNameSize}
  {\@setfontsize\chapterNameSize{22}{24}}
\newcommand{\chapterNumberSize}
  {\@setfontsize\chapterNumberSize{32}{32}}
\newcommand{\chapterTitleSize}
  {\@setfontsize\chapterTitleSize{16}{25}}
\newcommand{\chapterTitleFootnoteSize}
  {\@setfontsize\chapterTitleFootnoteSize{16}{30}}
\newcommand{\chapterAuthorSize}
  {\@setfontsize\chapterAuthorSize{12}{14}}
\newcommand{\chapterNoteSize}
  {\@setfontsize\chapterNoteSize{13}{15}}
\newcommand{\footerSize}
  {\@setfontsize\footerSize{10.5}{10.5}}
\newcommand{\headerSize}
  {\@setfontsize\headerSize{10}{10}}
%\newcommand{\pageNumSize}
%  {\@setfontsize\pageNumSize{10}{12}}

\newcommand{\smaller}
  {\@setfontsize\smaller{9}{11}}

\newcommand{\copyrightsize}
  {\@setfontsize\copyrightsize{9}{11}}

% foreign language wrappers

\newfontfamily\thaiFont{Kinnari.ttf}

\newcommand*\thai[1]{{\thaiFont #1}}

% === microtype ===

\RequirePackage[final,babel=true]{microtype}

% Tracking for uppercase section heading
\SetTracking[spacing={400,100,}]{encoding=*, family={Crimson-Roman.otf}}{20}
\SetTracking[spacing={400,100,}]{encoding=*, family={AlegreyaSC-Regular.otf}}{20}

% === hyperref ===

\RequirePackage{hyperref}
\RequirePackage{hyperxmp}

\ifdesktopversion
\hypersetup{
  unicode=true,
  % Colors: in the desktop version, use colored link text 
  colorlinks=true,
  % FIXME: the links don't work, so don't color them blue
  %linkcolor=link,
  %citecolor=link,
  %filecolor=link,
  %urlcolor=link,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody,
  % Metadata
  pdftitle={Stillness Flowing},
  pdfauthor={Ajahn Jayasaro},
  pdfcopyright={Copyright (C) 2017, Panyaprateep Foundation},
  pdfsubject={The Life and Teachings of Ajahn Chah},
  pdfkeywords={buddhism, dhamma, biography, ajahn chah, luang por chah},
  pdflicenseurl={http://creativecommons.org/licenses/by-nc-nd/4.0/},
  pdfcontacturl={http://jayasaro.panyaprateep.org},
  pdflang={en},
  % Behaviour
  bookmarksopen=true,
  bookmarksopenlevel=3,
  hypertexnames=false,
  linktocpage=true,
  plainpages=false,
  breaklinks
}
\else
\hypersetup{
  unicode=true,
  % Colors: in the print version, set link colors to text color, so that it doesn't interfere with printing
  colorlinks=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody,
  % Metadata
  pdftitle={Stillness Flowing},
  pdfauthor={Ajahn Jayasaro},
  pdfcopyright={Copyright (C) 2017, Panyaprateep Foundation},
  pdfsubject={The Life and Teachings of Ajahn Chah},
  pdfkeywords={buddhism, dhamma, biography, ajahn chah, luang por chah},
  pdflicenseurl={http://creativecommons.org/licenses/by-nc-nd/4.0/},
  pdfcontacturl={http://jayasaro.panyaprateep.org},
  pdflang={en},
  % Behaviour
  bookmarksopen=true,
  bookmarksopenlevel=3,
  hypertexnames=false,
  linktocpage=true,
  plainpages=false,
  breaklinks
}
\fi

\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% === penalties and hyphenation ===

% memoir's more allowing penalties
\midsloppy

\renewcommand\portuguesehyphenmins{{3}{3}}

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
%\finalhyphendemerits=5000 % default is 5000

% It is more effective to \mbox{...} the words to avoid hyphenation.
\brokenpenalty=5000 % penalty for page break after a hyphenated line

\RequirePackage[defaultlines=2,all]{nowidow}

% === common hyphenation exceptions and corrections ===

\hyphenation{season wisdom develop-ment respon-sible pheno-mena
philo-sophical munindo amaravati thai-land}

%\hyphenation{accur-ately argu-men-ta-tive attach Ayu-dhaya becomes
%ben-e-fi-cial capa-bil-ity car-ry car-ry-ing cere-monies cere-mony
%ces-sa-tion chal-lenge chal-leng-ing clas-si-fi-ca-tion
%clas-si-fi-ca-tions clas-si-fied com-mu-nity con-di-tion
%con-di-tioned con-struc-tions con-tem-plate con-tem-plat-ing
%con-tem-pla-tion cul-ti-vate cul-ti-vates cul-ti-vat-ing
%cul-ti-vation def-i-ni-tion de-ter-mine de-ter-mined dhamma dhammas
%dis-cern-ment dis-con-tent dis-cur-sive dying em-pha-size
%enlight-ened equa-nim-ity es-pe-cial-ly estab-lish exist-ence
%ex-pe-ri-ence hap-pen-ing having ig-no-rance immedi-ately
%im-per-ma-nent in-nu-mer-a-ble in-se-cu-ri-ty in-spir-ing
%in-struct-ed in-ves-ti-gate in-ves-ti-ga-tion iso-late iso-lat-ed
%Keuan lay-peo-ple ma-te-ri-al mat-u-ra-tion medi-tate medi-ta-tion
%medi-ta-tive mental mon-as-teries mon-as-tery Nana-chat or-dain
%or-dain-ed or-di-na-tion orig-inate oth-er-wise pene-trat-ing
%per-son-al per-son-al-ity phe-nom-e-na phe-nom-e-non po-si-tion
%pow-er pow-ers pre-vi-ous pro-lif-er-ate pro-lif-er-ating
%pro-lif-er-a-tions puthu-jjana quest-ion rec-i-ta-tion
%sat-is-fac-tory sen-sa-tion sen-sa-tions sim-i-lar suf-fer-ing
%sup-po-si-tion syn-on-y-mous tem-per-a-ment tem-per-a-ments tong-rat
%tran-scend tran-scend-ent tran-scends un-con-di-tioned under-stand
%under-stood un-hap-pi-ness un-sat-is-fac-tori-ness un-sat-is-fac-tory
%ven-er-able wea-ri-ness what-ev-er when-ever wher-ever whole-hearted
%whole-heart-edly wrong-do-ing}

% === soul settings ===

\sodef\soTocChapter{}{.1em}{.5em plus.1em}{.1em plus.1em minus.1em}
\sodef\soSection{}{.07em}{.4em plus.1em}{.1em plus.1em minus.1em}

% Use \textls letterspacing (for uppercase chapter titles for example)
% with microtype instead, because soul swallows
% accented characters at the end of words.

% === Custom commands and environments ===

\newcommand\dividerRule{%
{\centering\bigskip
{\color[gray]{0.6}\rule{0.6\linewidth}{0.2pt}}
\par\bigskip}%
}

\newcommand\emptysheet{%
  \cleardoublepage
  \thispagestyle{empty}\mbox{}\newpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand\emptydoublepage\emptysheet

\newcommand\emptypage{%
  \clearpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\printedByInfo}[1]{\def\@thePrintedByInfo{#1}}
\newcommand*{\publisher}[1]{\def\@thePublisher{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\thePrintedByInfo{\@thePrintedByInfo}
\newcommand\thePublisher{\@thePublisher}
\newcommand\theISBN{\@theISBN}

\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

\newenvironment{packeditemize}%
{\begin{itemize}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=4pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{itemize}}

\newcommand\speakerName[1]{%
  % The hangindent only works with alternating speakers.
  %\par\hangindent=1pc%
  {\color[gray]{0.25}\crimsonRomanFont\scshape\MakeLowercase{#1}}\quad}

\newlength\qw
\setlength\qw{17pt}% same as parindent for smallpage

\newcommand{\question}[1]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \ifthenelse{\equal{#1}{}}{\textit{Q:}\space}{\textit{#1:}\space}%
}

\newcommand{\questionBi}[2]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #1}
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #2}
}

\newcommand{\answer}[1]{%
  \smallskip%
  \par\noindent%
  \ifthenelse{\equal{#1}{}}{\textit{A:}\space}{\textit{#1:}\space}%
}

% If class option desktopVersion is used, show content in a paper sized
% minipage, empty page otherwise.
% Redefine \color{desktopcoverbg} to change page background color.
\newcommand\desktopCover[1]{%
\thispagestyle{empty}\mbox{}
\ifdesktopversion
\AddToShipoutPictureFG*{\put(0,0){%
\begin{minipage}[b][\paperheight][c]{\paperwidth}%
#1
\end{minipage}}}
\fi
\clearpage
}

% === titlepage ===

\newlength{\titleLength}
\newlength{\xheight}

% === quotes ===

\newlength{\quoteMargin}
\setlength{\quoteMargin}{18pt}

% FIXME
%\setlength{\footnotemargin}{\quoteMargin}

\newenvironment{openingVerse}%
{%
  \cleartoverso%
  \thispagestyle{empty}%
  \mbox{}\vfill%
  \begin{verse}%
}%
{%
  \par\end{verse}%
  \vfill\mbox{}%
}

% for sutta verses and other short stanzas
\renewenvironment{verse}
{\begin{centering}%
    \itshape}%
{\par\end{centering}}

\newcommand{\verseRef}[1]{%
  {\centering\itshape\footnotesize #1\par}%
}

% for longer sutta and book quotes
\renewenvironment{quote}%
{\list{}{%
    \itshape
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newcommand{\quoteTitle}[1]{%
  {%
    \centering\upshape%
    \sectionFont\fontsize{8}{10}\selectfont%
    \color{section}%
    \textls{\MakeUppercase{#1}}%
    \par%
  }%
}

\newcommand{\quoteRef}[1]{%
  {\raggedleft\itshape\footnotesize #1\par}%
}

\newcommand{\quoteRefInline}[1]{%
  {\hfill\itshape\footnotesize #1}%
}

\newenvironment{speaker}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newlength{\diaItemIndent}
\setlength{\diaItemIndent}{-\quoteMargin}
\newlength{\diaLeftMargin}
\setlength{\diaLeftMargin}{2\quoteMargin}

\newenvironment{dialogue}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \diaItemIndent
    \leftmargin    \diaLeftMargin
    \rightmargin   0pt
    \parsep        4pt
    \topsep        0pt
    \partopsep     0pt}%
\relax}%
{\endlist}

\newcommand\photoFullBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \includegraphics[height={\paperheight + 6mm}]{#1}%
    }%
  }%
}

\newcommand\photoSideBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \includegraphics[width={\paperwidth + 6mm}]{#1}%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoSideBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \color[gray]{0.8}%
        \rule{\paperwidth + 6mm}{0.5\paperheight}%
      \end{minipage}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoFullBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \color[gray]{0.8}%
      \rule{\paperwidth + 6mm}{\paperheight + 6mm}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \begin{minipage}[b][\paperheight + 6mm][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

% #1: photo
\newcommand{\chapterPhotoPagePortrait}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=100mm]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% #1: width
% #2: photo
\newcommand{\chapterPhotoInlinePortrait}[2]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=#1]{#2}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

% #1: photo
\newcommand{\chapterPhotoPageLandscape}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% The width only makes sense at \linewidth. Copy the macro inline and add trim
% and clip option on the photo if necessary.
%
% #1: photo
\newcommand{\chapterPhotoInlineLandscape}[1]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

\newcommand\sectionBreak{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \gentiumFont%
    \fontsize{20}{20}\selectfont%
    \color[gray]{0.7}%
    *\quad*\quad*%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

\newcommand\quoteBreak{%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \fontsize{8}{8}\selectfont%
    \color[gray]{0.4}%
    \FilledDiamondshape%
  \par}%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
}

% glossary as item list

\newenvironment{glossarydescription}%
{\list{}{%
    \labelwidth\z@ \itemindent-\leftmargin
    \labelsep 2pt
    \let\makelabel\glossaryDescriptionlabel}}%
{\endlist}

\newcommand*{\glossaryDescriptionlabel}[1]{%
  \normalfont\textbf{#1}%
  \hspace*{\labelsep}%
}

% === Color specs ===

\newcommand\modelTmp{}
\newcommand\specTextbody{}
\newcommand\specChaptertitle{}
\newcommand\specSection{}
\newcommand\specFootnote{}
\newcommand\specFooter{}

\newcommand\extractSpecs{%
  \extractcolorspecs{textbody}{\modelTmp}{\specTextbody}%
  \extractcolorspecs{chaptertitle}{\modelTmp}{\specChaptertitle}%
  \extractcolorspecs{section}{\modelTmp}{\specSection}%
  \extractcolorspecs{footnote}{\modelTmp}{\specFootnote}%
  \extractcolorspecs{footer}{\modelTmp}{\specFooter}%
}

% #1: description title of specs, such as 'variation A, base colors'
\newcommand{\printSpecs}[1]{%
  \cleartoverso%
  \mbox{}\vfill
  \thispagestyle{empty}%
  \extractSpecs%

  #1

  \begin{tabular}{@{} l l}
    Chapter title & \specChaptertitle \\
    Text body & \specTextbody \\
    Section & \specSection \\
    Footnote & \specFootnote \\
    Footer & \specFooter \\
  \end{tabular}%
  \vfill\mbox{}%
}

% === Renewing package macros ===

\addtodef{\mainmatter}{}{%
  \addtocontents{toc}{\addvspace{15pt}}%
  \setcounter{chapter}{0}%
}

\addtodef{\appendix}{}{%
  % Not adding vspace here because it interferes with the closing '.' of the
  % section list. The vertical space is added in \titlecontents{appendix}.
  \bookmarksetup{startatroot}%
}

\addtodef{\backmatter}{}{%
  \bookmarksetup{startatroot}%
}

\renewenvironment{quote}%
{\small
\list{}{\rightmargin\leftmargin}%
\item[]}%
{\endlist}

\newcommand\quoteref[1]{%
\par
{\footnotesize #1}
\par
}

\renewcommand\footnoterule{%
  \vspace*{\baselineskip}%
  \kern-3\p@
  {\color{footnoterule}\hrule height 0.25pt width \columnwidth}
  \kern2.6\p@}

\renewcommand*{\notesname}{Notes}
\renewcommand*{\notedivision}{\chapter{\notesname}}
%\renewcommand*{\notedivision}{\section*{\notesname}}
\renewcommand*{\pagenotesubhead}[3]{}
\renewcommand*{\notenumintext}[1]{\textsuperscript{\thinspace [#1]}}
\renewcommand{\prenoteinnotes}{\par\noindent\hangindent=17pt}
\renewcommand{\postnoteinnotes}{\par\vspace*{0.5\baselineskip}}

% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newcommand{\sepline}{%
  \hspace{6pt}%
  \raisebox{-0.3\baselineskip}{\rule{0.2pt}{1.2\baselineskip}}%
  \hspace{6pt}%
}
\makepagestyle{topbottomcentered}
\makeevenhead{topbottomcentered}{}{\headerFont\headerSize\color{header}\textit{\thetitle}}{}
\makeevenfoot{topbottomcentered}{}{\footerFont\footerSize\color{footer}\thepage}{}
\makeoddhead{topbottomcentered}{}{\headerFont\headerSize\color{header}\textit{\leftmark}}{}
\makeoddfoot{topbottomcentered}{}{\footerFont\footerSize\color{footer}\thepage}{}
\makepsmarks{topbottomcentered}{%
  \nouppercaseheads
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\makepagestyle{bottomcorner}
\makeevenhead{bottomcorner}{}{}{}
\makeevenfoot{bottomcorner}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage\hspace*{1em}$\cdot$\hspace*{1em}\textit{\thetitle}%
}{}{}
\makeoddhead{bottomcorner}{}{}{}
\makeoddfoot{bottomcorner}{}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \textit{\leftmark}\hspace*{1em}$\cdot$\hspace*{1em}\thepage%
}

\makepagestyle{bottomcenter}
\makeevenhead{bottomcenter}{}{}{}
\makeevenfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}
\makeoddhead{bottomcenter}{}{}{}
\makeoddfoot{bottomcenter}{}{%
  \footerFont\footerSize%
  \color{footer}%
  \thepage%
}{}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{topbottomcentered}
\aliaspagestyle{chapter}{bottomcenter}
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

% === TOC settings ===

\maxtocdepth{chapter}

% the right TOC margin
\contentsmargin{-5pt}

\newlength\tocLeftWidth
\setlength\tocLeftWidth{10mm}

% Roman numerals in the chapter title TOC chapter entries.
%\renewcommand\thechapter{\Roman{chapter}}

% Fixes Undefined control sequence error for \@chapapp@head
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

% Fixes Missing number error when chapter number is not numeric, as in
% Appendix A
\let\ttll@appendix\ttll@chapter

\newcommand*\l@chapternote{\@nodottedtocline{0}{\tocLeftWidth}{1pc}{1pc}}

\def\@nodottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth \else
    %\vskip \z@ \@plus.2\p@
    \vspace*{3pt}
    {\fontsize{11}{15}\itshape\tocFont\selectfont
     \leftskip #2\relax
     \rightskip \@tocrmarg
     \advance\rightskip #3\relax
     \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #4\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#5}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{\,}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalsize\normalfont}%
     \par}%
    \vspace*{5pt}%
  \fi}

\def\tocChapterNote#1{%
    \addcontentsline{toc}{chapternote}{%
    \noexpand\numberline{}#1}%
}

% FIXME: the first Part heading in the TOC will also add that 20pt
% vspace. How to add it only before a Part that follows a Chapter?

\titlecontents{part}[\tocLeftWidth]
{\addvspace{25pt}%
\fontsize{11}{11}\partTitleFont\selectfont}%
{%
  \contentsmargin{0pt}%
  \thecontentslabel.\space
  \hspace*{1em}%
  \MakeUppercase
}
{\contentsmargin{0pt}}
{}

\titlecontents{chapter}[\tocLeftWidth]
{\addvspace{15pt}\fontsize{13}{13}\gentiumFont\selectfont}%
{\contentsmargin{0pt}}
{\contentsmargin{0pt}%
\itshape}
{\hfill\normalsize\tocFont\thecontentspage}

\titlecontents{appendix}[\tocLeftWidth]
{\addvspace{30pt}\fontsize{13}{13}\crimsonRomanFont\bfseries\selectfont}%
{\contentsmargin{0pt}%
\itshape}
{\contentsmargin{0pt}%
\itshape}
{\enspace\hfill\normalsize\tocFont\thecontentspage}
[\addvspace{0pt}]

% === Book styles ===

% === Part styles ===

\newif\ifthisparthastitle
\thisparthastitletrue

\newif\ifthisparthasnote
\thisparthasnotefalse

\newcommand*{\thePartNote}{}
\newcommand*{\partNote}[1]{%
  \thisparthasnotetrue%
  \renewcommand*\thePartNote{#1}%
}

\renewcommand{\partnamefont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\partnumfont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\parttitlefont}{\large\partTitleFont\color{parttitle}\MakeUppercase}
\renewcommand*{\midpartskip}{\par\vskip 10pt}%

% FIXME: Currently, if there isn't a part title, we have to do
% \part{\space} to still create the part line in the TOC and the
% bookmark index.
%
% It would be better if the index had ``Part One'', and the TOC would
% handle it better too.

\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \phantomsection
  \ifnum \c@secnumdepth >-2\relax
  \refstepcounter{part}%
  \addcontentsline{toc}{part}%
  {\protect\partnumberline{\thepart}#1}%
  \mempartinfo{\thepart}{#1}{#2}%
  \else
  \addcontentsline{toc}{part}{#1}%
  \mempartinfo{}{#1}{#2}%
  \fi
  \partmark{#1}%
  {%
    \raggedright
    \hspace*{\chapterTitleLeftSkip}%
    \begin{minipage}{\linewidth - \chapterTitleLeftSkip}
      \raggedright
      \interlinepenalty \@M
      \parskip\z@
      \ifthisparthasnote
        \thePartNote
        \par
        \global\thisparthasnotefalse
        \midpartskip
      \fi
      \normalfont
      \ifnum \c@secnumdepth >-2\relax
        {\partTitleFont\fontsize{30}{35}\selectfont \printpartname \partnamenum \printpartnum}
        \par\vskip 20pt
      \fi
      \ifthisparthastitle
        \printparttitle{\textls*{#2}}
      \else
        \global\thisparthastitletrue
      \fi
      \par%
    \end{minipage}%
    \par%
  }%
\@endpart}

% === Chapter styles ===

\setsecnumdepth{chapter}

% define chapter styles with "fantasy" names

\newif\ifchapterauthor
\chapterauthorfalse

\newcommand*{\theChapterAuthor}{}
\newcommand*{\chapterAuthor}[1]{%
  \chapterauthortrue%
  \renewcommand*{\theChapterAuthor}{#1}%
}

\newcommand\chapterAuthorFmt[1]{%
  \chapterAuthorFont\chapterAuthorSize\color{chapterauthor}%
  #1%
}

\newif\ifchapternote
\chapternotefalse

\newcommand\chapterNoteFmt[1]{%
  \chapterNoteFont\chapterNoteSize\color{chapternote}%
  \itshape #1%
}

\newcommand*{\theChapterNote}{}
\newcommand*{\chapterNote}[1]{%
  \chapternotetrue%
  \renewcommand*\theChapterNote{#1}%
}

\newif\ifchapterfootnote
\chapterfootnotefalse

\newcommand*{\theChapterFootnoteMark}{}
\newcommand*{\theChapterFootnoteText}{}
\newcommand*{\chapterFootnote}[2][\footnotemark]{%
  \chapterfootnotetrue%
  \renewcommand*\theChapterFootnoteMark{#1}%
  \renewcommand*\theChapterFootnoteText{\footnotetext{#2}}%
}

\newlength\chapterTitleLeftSkip
\setlength{\chapterTitleLeftSkip}{17pt}

\makechapterstyle{lowtitle}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{30mm-1.5\baselineskip}
  \setlength{\chapterTitleLeftSkip}{17pt}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\chapnumfont{\chapterNumberFont\chapterNumberSize}
  \renewcommand\printchapternum{%
    \chapnumfont\color{chapternum}%
    \hspace*{\chapterTitleLeftSkip}\thechapter%
  }
  \setlength{\midchapskip}{1.5\onelineskip}
  \renewcommand\afterchapternum{\par\nobreak\vskip \midchapskip}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand*\printchaptertitle[1]{%
    \raggedright\hspace*{\chapterTitleLeftSkip}%
    \parbox{\linewidth - \chapterTitleLeftSkip}{%
      \raggedright\chaptitlefont\color{chaptertitle}%
      \textls*{##1}%
      \ifchapterfootnote%
        \hspace*{2pt}\theChapterFootnoteMark%
      \fi%
      \ifchapterauthor%
        \vskip 0.5\onelineskip%
        \chapterAuthorFmt{\theChapterAuthor}%
        \global\chapterauthorfalse%
      \fi%
      \ifchapternote%
        \vskip 0.5\onelineskip%
        \chapterNoteFmt{\theChapterNote}%
        \global\chapternotefalse%
      \fi%
    }%
    \ifchapterfootnote%
      \theChapterFootnoteText%
      \global\chapterfootnotefalse%
    \fi%
  }
  \setlength{\afterchapskip}{3.5\onelineskip}
  \renewcommand\afterchaptertitle{\par\nobreak\vskip \afterchapskip}%
}

\makechapterstyle{hightitle}{
  \chapterstyle{lowtitle}
  \setlength{\beforechapskip}{0pt}
  \setlength{\chapterTitleLeftSkip}{0pt}
  \renewcommand*\printchaptertitle[1]{%
    {%
      \centering\crimsonRomanFont\fontsize{18}{16}\selectfont\color{chaptertitle}%
      \textit{##1}%
      \par
    }%
  }
}

% Commands to assign the chapter styles to book parts. Use \renewcommand
% to adjust.

% No numbers in chapter mark
%\createmark{chapter}{left}{nonumber}{}{}

\newcommand\frontmatterChapterStyle{\chapterstyle{hightitle}}
\newcommand\mainmatterChapterStyle{\chapterstyle{lowtitle}}
\newcommand\appendixChapterStyle{\chapterstyle{hightitle}}
\newcommand\backmatterChapterStyle{\chapterstyle{hightitle}}

% append them to the macros
\addtodef{\frontmatter}{}{\frontmatterChapterStyle}
\addtodef{\mainmatter}{}{\mainmatterChapterStyle}
\addtodef{\appendix}{}{\appendixChapterStyle}
\addtodef{\backmatter}{}{\backmatterChapterStyle}

% === Section styles ===

% TODO: could use \makeheadstyles to keep bundle different chapter and
% section style together. See memoir manual '6.9 Predefined heading
% styles'.

% No glue after section headers. It is better to break the page early. With
% glue, (eg \setaftersecskip{2.3ex \@plus .2ex}), when nowidow moves some lines
% to the next page, the space after the section header will strech a lot to shift
% the bottom lines to the bottom of the text block.
%
% With no glue, the space will be at the bottom of the text block instead.

\setbeforesecskip{-5.5ex \@plus -1ex \@minus -.2ex}
\setaftersecskip{2.3ex}

\setbeforesubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsecskip{2.3ex}

\setbeforesubsubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsubsecskip{2.3ex}

% Roman numerals for section numbering.
%\renewcommand*{\thesection}{\roman{section}}
%\setsechook{\setsecnumformat{\thesection.\space}}

\newcommand\sectionFmt[1]{%
  \sectionFont\fontsize{11.5}{14}\selectfont%
  \color{section}%
  \centering
  \textls{\MakeUppercase{#1}}%
}

\newcommand\subsectionFmt[1]{%
  \sectionFont\fontsize{10}{13}\selectfont%
  \color{section}%
  \memRTLraggedright%
  \textls{\MakeUppercase{#1}}%
}

\newcommand\subsubsectionFmt[1]{%
  \gentiumFont\normalsize\itshape\color[gray]{0.1}%
  \memRTLraggedright%
  #1
}

\setsecheadstyle{\sectionFmt}
\setsubsecheadstyle{\subsectionFmt}
\setsubsubsecheadstyle{\subsubsectionFmt}

% === Page geometry and layout ===

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\newlength\BOOK@paperHeight
\newlength\BOOK@paperWidth

\def\BOOK@fontSizePt{}
\def\BOOK@lineHeightPt{}

% Based on 'largepage', with font sizes from 'largevolume' (i.e. Collected Teachings)

% === normalsize ===

\def\BOOK@fontSizePt{11}
\def\BOOK@lineHeightPt{16}

\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\BOOK@fontSizePt\BOOK@lineHeightPt
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}
\normalsize

% === indentations ===

\setlength{\vgap}{1.5em}
\setlength{\vindent}{\vgap}
\setlength{\vleftmargin}{2em}

\setlength{\parskip}{0pt}
\setlength{\parindent}{17pt}

% === setup page layout ===

\setlength{\BOOK@paperHeight}{8in}
\setlength{\BOOK@paperWidth}{5.25in}

\ifshowtrims
  \stockaiv% use A4 paper size to show trims
  \setlength{\paperheight}{\BOOK@paperHeight}
  \setlength{\paperwidth}{\BOOK@paperWidth}
  \trimXmarks
  \trimLmarks
  \quarkmarks
  \settrims{0.5\stockheight - 0.5\paperheight}{0.5\stockwidth - 0.5\paperwidth}
  \settrimmedsize{\BOOK@paperHeight}{\BOOK@paperWidth}{*}
\else\relax
  \setstocksize{\BOOK@paperHeight}{\BOOK@paperWidth}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
\fi

% Text block for 10.5 / 15pt:
%%\settypeblocksize{521pt}{*}{0.599}% 1/1.667, 3:5, major 6th (183.79mm x 110mm)
%\settypeblocksize{34\baselineskip + \topskip}{*}{0.599}% 1/1.667, 3:5, major 6th
%\setlrmargins{*}{20mm}{*}% 22.71669mm and 19.99976mm

\settypeblocksize{27\baselineskip + \topskip}{95mm}{*}% 155.6mm / 94.89mm = 1.63979344504
\setlrmargins{*}{17mm}{*}

\setulmargins{20mm}{*}{*}%
\setlength{\footskip}{30pt}

% Fixes these warnings:
%
% Overfull \vbox (1.4pt too high) has occurred while \output is active
\addtolength{\headheight}{2pt}

% This will also typeout values in pt (default)
\checkandfixthelayout
% It is useful to see layout values in mm too.
\settypeoutlayoutunit{mm}
\typeoutlayout

% ******************************************************
% Stock height and width: 578.15999pt by 379.4175pt
% Top and edge trims: 0pt and 0pt
% Page height and width: 578.15999pt by 379.4175pt
% Text height and width: 443pt by 270pt
% Spine and edge margins: 60.74664pt and 48.36967pt
% Upper and lower margins: 56.9055pt and 78.25449pt
% Headheight and headsep: 15.6pt and 19.8738pt
% Footskip: 30pt
% Columnsep and columnseprule: 10pt and 0pt
% Marginparsep and marginparwidth: 7pt and 34.36967pt
% Sidecapsep and sidecapwidth: 7pt and 111pt
% Sidebarhsep and sidebarwidth: 7pt and 111pt
% Sidebarvsep and sidebartopsep: 13.6pt and 0pt
% Sidebarheight: 539.9202pt
% Sidefoothsep and sidefootwidth: 7pt and 111pt
% Sidefootvsep and sidefootheight: 13.6pt and 539.9202pt
% ******************************************************
% 
% 
% ******************************************************
% Stock height and width: 203.19762mm by 133.34843mm
% Top and edge trims: 0mm and 0mm
% Page height and width: 203.19762mm by 133.34843mm
% Text height and width: 155.69487mm by 94.89304mm
% Spine and edge margins: 21.34975mm and 16.99979mm
% Upper and lower margins: 19.99976mm and 27.50298mm
% Headheight and headsep: 5.4827mm and 6.98476mm
% Footskip: 10.54367mm
% Columnsep and columnseprule: 3.51456mm and 0mm
% Marginparsep and marginparwidth: 2.46019mm and 12.0794mm
% Sidecapsep and sidecapwidth: 2.46019mm and 39.01158mm
% Sidebarhsep and sidebarwidth: 2.46019mm and 39.01158mm
% Sidebarvsep and sidebartopsep: 4.77979mm and 0mm
% Sidebarheight: 189.75801mm
% Sidefoothsep and sidefootwidth: 2.46019mm and 39.01158mm
% Sidefootvsep and sidefootheight: 4.77979mm and 189.75801mm
% ******************************************************

% Math sizes for superscript sizes
\DeclareMathSizes{12.5}{12.5}{7}{7}

% === Packages to be loaded LAST ===

% NOTE use the 'bottom' footmisc option when using \raggedbottom.

\RequirePackage[perpage,symbol*,bottom,norule,multiple]{footmisc}

% NOTE if you have a quote margin, the \footnotemargin can be set equal to that
% in your local.sty
\setlength{\footnotemargin}{2em}

\renewcommand{\footnotelayout}{\hangpara{\footnotemargin}{1}}

% Asterisks for the first three footnotes, then numbers produced by the
% 'symbol*' option.
\DefineFNsymbols{anecdote}{*{**}{***}}
\setfnsymbol{anecdote}
