% !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
% \ProvidesClass{WHUThesis}[2015/11/07 4.0 Wuhan University Thesis Template for PHD -- TeX Live 2015  version]
\ProvidesClass{WHUThesis}[2023/3/8 4.1 Wuhan University Thesis Template for Master -- TeX Live 2015  version]

\newcommand\whu@warning[1]{%
	\ClassWarning{WHUThesis}{#1}%
}

\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=whu,
	prefix=whu@,
	setkeys=\kvsetkeys}
\let\whu@setup@hook\@empty
\newcommand\whusetup[1]{%
	\let\whu@setup@hook\@empty
	\kvsetkeys{whu}{#1}%
	\whu@setup@hook
}
\newcommand\whu@define@key[1]{%
	\kvsetkeys{whu@key}{#1}%
}
\kv@set@family@handler{whu@key}{%
	\@namedef{whu@#1@@name}{#1}%
	\def\whu@@default{}%
	\def\whu@@choices{}%
	\kv@define@key{whu@value}{name}{%
		\@namedef{whu@#1@@name}{##1}%
	}%
	\@namedef{whu@#1@@check}{}%
	\@namedef{whu@#1@@code}{}%
	\kv@define@key{whu@value}{choices}{%
		\def\whu@@choices{##1}%
		\@namedef{whu@#1@@reset}{}%
		\@namedef{whu@#1@@check}{%
			\@ifundefined{%
				ifwhu@\@nameuse{whu@#1@@name}@\@nameuse{whu@\@nameuse{whu@#1@@name}}%
			}{%
				\whu@error{Invalid value "#1 = \@nameuse{whu@\@nameuse{whu@#1@@name}}"}%
			}%
			\@nameuse{whu@#1@@reset}%
			\@nameuse{whu@\@nameuse{whu@#1@@name}@\@nameuse{whu@\@nameuse{whu@#1@@name}}true}%
		}%
	}%
	\kv@define@key{whu@value}{default}{%
		\def\whu@@default{##1}%
	}%
	\kvsetkeys{whu@value}{#2}%
	\@namedef{whu@\@nameuse{whu@#1@@name}}{}%
	\kv@set@family@handler{whu@choice}{%
		\ifx\whu@@default\@empty
		\def\whu@@default{##1}%
		\fi
		\expandafter\newif\csname ifwhu@\@nameuse{whu@#1@@name}@##1\endcsname
		\expandafter\g@addto@macro\csname whu@#1@@reset\endcsname{%
			\@nameuse{whu@\@nameuse{whu@#1@@name}@##1false}%
		}%
	}%
	\kvsetkeys@expandafter{whu@choice}{\whu@@choices}%
	\expandafter\let\csname whu@\@nameuse{whu@#1@@name}\endcsname\whu@@default
	\expandafter\ifx\csname whu@\@nameuse{whu@#1@@name}\endcsname\@empty\else
	\@nameuse{whu@#1@@check}%
	\fi
	\kv@define@key{whu}{#1}{%
		\@namedef{whu@\@nameuse{whu@#1@@name}}{##1}%
		\@nameuse{whu@#1@@check}%
		\@nameuse{whu@#1@@code}%
	}%
}
\whu@define@key{
	output={
		choices = {
			print,
			electronic,
			ppt,
		},
		default = electronic,
	},
	clc={
		default={V249.32+8},
	},
	udc,
	secret-level = {
		name = secret@level,
	},
	school-id={
		default={10486},
		name =  school@id,
	},
	title = {
		default = {标题},
	},
	title* = {
		default = {Title},
		name    = title@en,
	},
	author,
	author* = {
		name    = author@en,
	},
	number,
	number* = {
		name    = number@en,
	},
	supervisor,
	supervisor* = {
		name    = supervisor@en,
	},
	second-supervisor = {
		name = second@supervisor,
	},
	second-supervisor* = {
		name = second@supervisor@en,
	},
    third-supervisor = {
    	name = third@supervisor,
    },
    third-supervisor* = {
    	name = third@supervisor@en,
    },
	major,
	major*={
		name    = major@en,  
	},
	speciality,
	speciality*={
		name    = speciality@en,  
	},
	date,
	date*={
		name=date@en
	},
	school-name={ name=school@name},
	include-spine = {
		name = include@spine,
		choices = {
			false,
			true,
		},
		default = false,
	},
	review={
		choices = {
			false,
			true,
		},
		default = false,
	},
	refstyle-file = {
		name = refstyle@file,
   	},
   	statement-file={
   		name = statement@file,
   	},
   	license-file={
   		name = license@file,
   	},
	entitle-entype={
		name = entitle@entype,
		choices = {
			false,
			true,
		},
		default = true,
	}
}
\ProcessKeyvalOptions*

\LoadClass[a4paper,zihao=-4,twoside,fontset=windows]{ctexbook}
 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
%------------------------ Page layout ----------------------------------
\RequirePackage{fancyhdr,hyperref}
\hypersetup{bookmarksnumbered=true,bookmarksopen=true,colorlinks=true,pdfencoding=auto,citecolor=[rgb]{0.796,0.0196,0.0196},
            linkcolor=[rgb]{0,0.094,0.749}}
\ifwhu@output@print
\RequirePackage[top=3truecm,bottom=2.9truecm,left=2.8truecm,right=2.5truecm,
%includehead,%includefoot,
xetex]{geometry}    % 页面设置%
\else
\RequirePackage[top=3truecm,bottom=2.9truecm,left=2.65truecm,right=2.65truecm,
%includehead,%includefoot,
xetex]{geometry}    % 页面设置%
\let\cleardoublepage\clearpage
\fi


%判断是否需要空白页
\def\checkdoublepage{ 
\ifwhu@output@print
\newpage
\thispagestyle{empty}
\cleardoublepage
\else
\let\cleardoublepage\clearpage
\fi
}


%===============================================页眉设置=====================================================%
\renewcommand{\headrulewidth}{0.5pt}    %在页眉下画一个0.5pt宽的分隔线
\renewcommand{\footrulewidth}{0pt}      % 在页脚不画分隔线。

\let\ps@oldplain\ps@plain
 \fancyhf{}  %清除以前对页眉页脚的设置
 \fancyhead[CE]{\zihao{5} 武汉大学硕士学位论文} %偶数页页眉居中位置的设置. 不填则为空.
 \fancyhead[CO]{\zihao{5} \whu@title}    %L,C,R 是左中右; O,E 是奇偶. 可以自己组合调整.
 \fancyfoot[C]{-\,\thepage\,-}                     %页面下侧的设置. 大括号内置空, 表示什么也不填. 反之, 没有此命令的话, 会在页脚出现页码
 \newcommand{\fancyfancy}{\fancypagestyle{plain}{%
  \fancyhf{}
   \fancyhead[CE]{\zihao{5} 武汉大学硕士学位论文}                       %偶数页页眉居中位置的设置. 不填则为空.
 \fancyhead[CO]{\zihao{5} \whu@title}    %L,C,R 是左中右; O,E 是奇偶. 可以自己组合调整.
 \fancyfoot[C]{-\,\thepage\,-} }}
%%%=== 封面 ===%%%
\def\maketitle{%
  \null
  \thispagestyle{empty}%
  %\vspace*{-2cm}
  \begin{center}\leavevmode
    {\fangsong \zihao{4}%
    \begin{tabular}{llp{5cm}ll}
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{分\hfill 类\hfill 号}} &\raisebox{-0.5ex}[0pt]{\makebox[2.2cm][c]{\hfill \whu@clc \hfill}} &  &
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{密\hfill 级}} & {}\hfill\raisebox{-0.5ex}[0pt]{\whu@secret@level}\hfill{}  \\ \cline{2-2}\cline{5-5}
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{U\hfill D\hfill C} } & {}\hfill\raisebox{-0.5ex}[0pt]{\whu@udc}\hfill{}      &  &
      \raisebox{-0.5ex}[0pt]{\makebox[1.5cm][s]{编\hfill 号}} & \raisebox{-0.5ex}[0pt]{\makebox[2.2cm][c]{\hfill \whu@school@id\hfill}} \\ \cline{2-2}\cline{5-5}
    \end{tabular}
    }
    \par
    \vspace*{15mm} %插入空白
    {\songti \zihao{2} \ziju{1} %武汉大学 
    \includegraphics[width=0.4\textwidth]{wudaname.eps}
    \\[3mm] 硕士学位论文}\\
    \vspace{2cm}
    {\kaishu \zihao{1}  \whu@title \par}%
%    \vspace{4cm}
     \vfill\vfill\vfill
    {\songti\zihao{4}
    \begin{tabular}{ccc}
\ifwhu@review@false
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{研\hfill 究\hfill 生\hfill 姓\hfill 名: }} & {\songti {}\raisebox{-3ex}[0pt]{\whu@author}\hfill{}} & \\[3ex]
	  \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{学\hfill 号: }} & {\songti {}\raisebox{-3ex}[0pt]{\whu@number}\hfill{}} & \\[3ex]
\raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{指\hfill 导\hfill 教\hfill 师\hfill 姓\hfill 名、\hfill 职\hfill 称: }} & {\songti{}\raisebox{-3ex}[0pt]{\whu@supervisor}\hfill{}} & 	\\[3ex] % \cline{2-2}

\ifx\whu@second@supervisor\@empty\else
    & {\songti {}\raisebox{-3ex}[0pt]{\whu@second@supervisor}\hfill{}} & \\[3ex]
\fi
\ifx\whu@third@supervisor\@empty\else
	& {\songti {}\raisebox{-3ex}[0pt]{\whu@third@supervisor}\hfill{}} & \\[3ex]
\fi

\else
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{研\hfill 究\hfill 生\hfill 姓\hfill 名: }} & {\songti {}\raisebox{-3ex}[0pt]{}\hfill{}} & \\[3ex]
	  \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{学\hfill 号: }} & {\songti {}\raisebox{-3ex}[0pt]{}\hfill{}} & \\[3ex]
\raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{指\hfill 导\hfill 教\hfill 师\hfill 姓\hfill 名、\hfill 职\hfill 称: }} & {\songti	{}\raisebox{-3ex}[0pt]{}\hfill{}} & \\[3ex] % \cline{2-2}
\fi
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{专\hfill 业\hfill 名\hfill 称: }} & {\songti {}\raisebox{-3ex}[0pt]{\whu@major}\hfill{}} &
      \\[3ex]
      \raisebox{-3ex}[0pt]{\makebox[4.8cm][s]{研\hfill 究\hfill 方\hfill 向: }} & {\songti{}\raisebox{-3ex}[0pt]{\whu@speciality}\hfill{}} & \\[3ex]
     \end{tabular}
    }
    \par
    \vspace{20mm}
    {
%    {\heiti \zihao{3} \the\year~年 ~\the\month~月 ~\the\day~日 \par}%
    {\heiti \zihao{3} \whu@date \par}%
    }
    %\vspace*{-0.7cm}
  \end{center}%
\ifwhu@include@spine@true
\spine
\else
\checkdoublepage
\fi
}

\def\makeentitle{ 
\ifwhu@entitle@entype@true
  \null
  \thispagestyle{empty}
  \renewcommand{\baselinestretch}{1.5}  %下文的行距
  \vspace*{1.5cm}
  
  \begin{center}{
  \zihao{2}  Master Thesis of Wuhan University \par}\end{center}
  \vspace*{3cm}
  \begin{center}{ \zihao{2}
  \whu@title@en \par}\end{center}
  
  \vspace*{1cm}
  \begin{center}{\zihao{4} By \\
   \ifwhu@review@false 
   \whu@author@en \\
   \fi
   \vspace*{2cm}
   \textit{Supervised by} \\ 
   \ifwhu@review@false 
   \whu@supervisor@en \\
   \ifx\whu@second@supervisor\@empty\else
   \whu@second@supervisor@en
   \fi \\
   \ifx\whu@third@supervisor\@empty\else
   \whu@third@supervisor@en
   \fi
   \fi
  }\end{center}
  \vfill
  \begin{center} 	
  	\zihao{4}
  	\whu@school@name \\
  	{Wuhan University} \\
  	\whu@date@en
  \end{center}
  \checkdoublepage

\else

  \null
  \thispagestyle{empty}
  \renewcommand{\baselinestretch}{1.5}  %下文的行距
  \vspace*{0.5cm}
  
  \begin{center}{\zihao{2} \whu@title@en \par}\end{center}
  
  \vfill
  
  \begin{center}
  \zihao{4}
  \begin{tabular}{ r l }
   Candidate:      & {\sc \ifwhu@review@false  \whu@author@en \fi}      \\
   Student Number: & {\ifwhu@review@false \whu@number@en \fi} \\
   \ifwhu@review@true Supervisor: & \\ \else 
	Supervisor:     & {\sc \whu@supervisor@en}   \\
	\ifx \whu@second@supervisor@en\@empty \else & {\sc \whu@second@supervisor@en} \fi \\ 
	\ifx \whu@third@supervisor@en\@empty \else & {\sc \whu@third@supervisor@en} \fi \\ 
   \fi
   Major:          & \whu@major@en  \\
   Speciality:     & \whu@speciality@en 
  \end{tabular}
  
%   \vspace*{2cm}
  \vfill
  \begin{center}
	% \iflib % 向图书馆提交电子文档, 使用黑白校徽.
	% \includegraphics[height=4cm]{whu.eps}       %%  黑白的. 很小, 只有 10k.
	% \else
	\ifwhu@output@print % 文档打印, 使用黑白校徽.
	\includegraphics[height=4cm]{whu.eps}       %%  黑白的.
	\else
	\includegraphics[height=4cm]{whulogo.eps} %%  彩色的.
	\fi
  \end{center}
  
  
  \begin{center} 	
	\zihao{4}
	\whu@school@name \\
	{\sc Wuhan University} \\
	\whu@date@en
  \end{center}
  \checkdoublepage
  
  \end{center}

\fi
}


%------------------------ Abstract & Keywords -------------------------
\newcommand\cnabstractname{摘要}
\newcommand\enabstractname{ABSTRACT}
\newcommand\cnkeywords[1]{ {\heiti\zihao{-4}\cnkeywordsname: }#1}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{ {\bfseries\zihao{-4}\enkeywordsname: }#1}
\newcommand\enkeywordsname{Key words}

\newenvironment{cnabstract}{
    \newpage
    \chapter[\cnabstractname]{\zihao{-2}\ziju{2}{\cnabstractname}}   %%%终于解决了书签乱码的问题 2005-04-12.huangzh
%    \songti\zihao{-4}
    \@afterheading}
    {\par}

\newenvironment{enabstract}{
    \newpage
    \chapter[\enabstractname]{\zihao{-2}{\enabstractname}}
%    \Times New Roman \zihao{-4}
    \@afterheading}
    {\par}
    
\newenvironment{innovation}{
	\newpage\vspace*{20pt}\thispagestyle{empty}
	\begin{center}{\zihao{-2}\heiti 博士生自认为的论文创新点}\end{center}
	\par\vspace*{30pt}
	\baselineskip=20pt
    \@afterheading}{\par}

\renewcommand\thanks[1]{
	\newpage\chapter[致谢]{\ziju{2}致谢}
	\ifwhu@review@false
	#1
	\fi
}

\newcommand\achievement[3]{
	\item
	\ifwhu@review@false
	#1
	\else
	***.
	\fi
	#2
	\ifwhu@review@true
	（#3）
	\fi
}

%%------------------------常用宏包-----------------------------------
\RequirePackage{amsmath,amssymb}% AMSLaTeX宏包.
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{graphicx}                 % 图形
\RequirePackage[titles]{tocloft} 
\newcommand\mydot[1]{\scalebox{#1}{.}}
\renewcommand\cftdot{\mydot{1}} % change the size of dots
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand\cftdotsep{0.5} % change the space between dots
\RequirePackage{multirow}                 % 表格
\RequirePackage{booktabs}                 % 表格
\RequirePackage{caption}                      % 制图
\RequirePackage{subcaption}                 % 制图
\RequirePackage{color,xcolor}             %支持彩色
\RequirePackage{xr}
\RequirePackage{tabularx}
\RequirePackage{float}
\RequirePackage{graphbox}
\RequirePackage{textcomp,gensymb} %支持°
\RequirePackage[backend=biber,style=\whu@refstyle@file,gbpub=false,isbn=false,doi=true,gbtitlelink=true,url=true,sortlocale=zh__pinyin]{biblatex}  % 参考文献引用, 使用biblatex包
\RequirePackage[ruled,linesnumbered]{algorithm2e} %伪代码
%\RequirePackage{setspace}
\RequirePackage{url}
\RequirePackage{enumitem}
\RequirePackage{newtxmath}
\RequirePackage{emptypage}%空白页无页码
\RequirePackage{verbatim} %多行注释，用\begin{comment} ... \end{comment} 包含被注释的文字
%%----------------------- Theorems -----------------------------------
\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti} \theoremindent0em
\theorempreskip{0pt}
\theorempostskip{0pt}
%\theoremseparator{\hspace{1em}}
\theoremnumbering{arabic}
%\theoremsymbol{} %定理结束时自动添加的标志
\newtheorem{theorem}{\hspace{2em}定理}[section]
\newtheorem{definition}{\hspace{2em}定义}[section]
\newtheorem{lemma}{\hspace{2em}引理}[section]
\newtheorem{corollary}{\hspace{2em}推论}[section]
\newtheorem{proposition}{\hspace{2em}性质}[section]
\newtheorem{example}{\hspace{2em}例}[section]
\newtheorem{remark}{\hspace{2em}注}[section]

\theoremstyle{nonumberplain}
\theoremheaderfont{\heiti}
\theorembodyfont{\normalfont \rm \songti}
\theoremindent0em \theoremseparator{\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}

%%%---  Publications -------------------------------
\newenvironment{publications}[1]
  {\renewcommand\bibname{}\begin{thebibliography}{#1}}
  {\end{thebibliography}}

%%%%%%%--判断是否需要彩色链接-----------------------------
%  \ifwhu@output@print
  \hypersetup{hidelinks}
%  \fi
%%%%%%%-------------------------------------------------
%%%===  suppress extra inter-line spacing in \list environments
\makeatletter \setlength\partopsep{0pt}
\def\@listI{\leftmargin\leftmargini
            \parsep 0pt
            \topsep \parsep
            \itemsep \parsep}
\@listI
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listiv{\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listv{\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
\def\@listvi{\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep
              \parsep    \z@ \@plus\z@  \@minus\z@
              \topsep    \parsep
              \itemsep   \parsep}
%
% Change default margins for \list environments
\setlength\leftmargini   {2\ccwd} \setlength\leftmarginii
{\leftmargini} \setlength\leftmarginiii {\leftmargini}
\setlength\leftmarginiv  {\leftmargini} \setlength\leftmarginv
{\ccwd} \setlength\leftmarginvi  {\ccwd} \setlength\leftmargin
{\leftmargini} \setlength\labelsep      {.5\ccwd}
\setlength\labelwidth    {\leftmargini}
%
\setlength\listparindent{2\ccwd}
% Change \listparindent to 2\ccwd in \list
\def\list#1#2{\ifnum \@listdepth >5\relax \@toodeep
     \else \global\advance\@listdepth\@ne \fi
  \rightmargin \z@ \listparindent2\ccwd \itemindent \z@
  \csname @list\romannumeral\the\@listdepth\endcsname
  \def\@itemlabel{#1}\let\makelabel\@mklab \@nmbrlistfalse #2\relax
  \@trivlist
  \parskip\parsep \parindent\listparindent
  \advance\linewidth -\rightmargin \advance\linewidth -\leftmargin
  \advance\@totalleftmargin \leftmargin
  \parshape \@ne \@totalleftmargin \linewidth
  \ignorespaces}

\makeatother
%---------------------------------------------------
\renewcommand{\contentsname}{目\qquad 录}

%%% ---- 章节标题设置 ----- %%%%
\ctexset{chapter={nameformat={\zihao{-2}\bfseries\raggedright},titleformat={\zihao{-2}\bfseries\centering},%
                number={\chinese{chapter}},name={第,章},afterskip={30pt},beforeskip={20pt}}}
\ctexset{section={format+={\zihao{3}\raggedright}}}
\ctexset{subsection={format+={\zihao{4}\raggedright}}}
\ctexset{subsubsection={format={\zihao{-4}\kaishu\raggedright}}}
\ctexset{bibname={参考文献}}
\ctexset{listfigurename={图目录}}
\ctexset{listtablename={表目录}}
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}
\RequirePackage[font=small]{caption}
\RequirePackage[nottoc]{tocbibind}

\makeatletter
\let\oldnumberline\numberline
\renewcommand\listoffigures{
	\renewcommand{\numberline}{\figurename~\oldnumberline}
	\@starttoc{lof}
}
\renewcommand\listoftables{
	\renewcommand{\numberline}{\tablename~\oldnumberline}
	\@starttoc{lot}
}
\makeatletter

\newcommand\listoffig{
	\chapter[\listfigurename]{\ziju{1}\listfigurename}
	\listoffigures
}
\newcommand\listoftab{
	\chapter[\listtablename]{\ziju{1}\listtablename}
	\listoftables
}
\newcommand\listoffigandtab{
	\chapter[图表目录]{\ziju{1}图表目录}
	\listoffigures
	\listoftables
}

\renewcommand\tabularxcolumn[1]{m{#1}}%表格居中
\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcommand{\citeA}[1]{\citeauthor{#1}\cite{#1}}

\renewcommand{\bibfont}{\zihao{5}}%

\RequirePackage{cleveref}
\crefname{figure}{图}{图}
\crefname{table}{表}{表}
\captionsetup[table]{labelsep=space}
\captionsetup[figure]{labelsep=space}
\crefname{algorithm}{算法}{算法}
\crefname{equation}{式}{式}
\crefname{section}{章节}{章节}
\renewcommand{\cref}[1]{\hyperref[#1]{\namecref{#1}\labelcref{#1}}}

%图、表标题使用自定义\ftname
%启用时，方便做ppt使图表标题去掉编号，并减少标题间距
\ifwhu@output@ppt
\newcommand\ftname[1]{\caption*{#1}}
\captionsetup[table]{skip=0pt}
\captionsetup[figure]{skip=0pt}
\captionsetup[subfigure]{skip=0pt}
\else
\newcommand\ftname[1]{\caption{#1}}
\fi

\setlength{\abovecaptionskip}{0.cm}
\setlength{\belowcaptionskip}{0.cm} 

%%%=== 路径=== %%%
\graphicspath{{figures/}}% 图片放在 figures 文件夹.

\raggedbottom%页面顶部对齐

%\renewcommand{\algorithmcfname}{算法} 
\SetAlgorithmName{算法}{算法}{算法列表}
\SetKwInput{KwIn}{输入}
\SetKwInput{KwOut}{输出}
\setlength{\algoheightrule}{\heavyrulewidth} 
\setlength{\algotitleheightrule}{\lightrulewidth}
\AtBeginEnvironment{algorithm}{\linespread{1.0}\selectfont}

%缩略词表
\RequirePackage{nomencl}
\newcommand{\listnomname}{缩略词}
\renewcommand{\nomname}{\ziju{1}\listnomname}
\newcommand{\nomdescr}[1]{
	\parbox[t]{7.6cm}{\raggedright\strut #1 \strut}
}
\newcommand{\nomdescrchn}[1]{
	\hfill\parbox[t]{4.8cm}{\strut #1 \strut}\ignorespaces
}
\newcommand{\nomchn}[4][]{
	\nomenclature[#1]{#2}{
		\nomdescr{#3}
		\nomdescrchn{#4}
	}
}

\whu@define@key{
	spine-font = {
		default=\zihao{4},
		name = spine@font,
	},
}
\renewcommand\whu@spine@font{%
	\fontsize{16bp}{20.8bp}\selectfont
}
\newbox\whu@stretch@box
\newcommand\whu@stretch[2]{%
	\sbox\whu@stretch@box{#2}%
	\ifdim \wd\whu@stretch@box < #1\relax
	\begingroup
	\def\CJKglue{\hskip 0pt plus 2filll}%
	\makebox[#1][l]{#2}%
	\endgroup
	\else
	\box\whu@stretch@box
	\fi
}
\newcommand*\CJKmovesymbol[1]{\raise.3em\hbox{#1}}
\newcommand*\CJKmove{%
	\punctstyle{plain}%
	\let\CJKsymbol\CJKmovesymbol
	\let\CJKpunctsymbol\CJKsymbol
}
\NewDocumentCommand{\spine}{
	O{
		武汉大学硕士学位论文\qquad
	}
	O{
		\whu@title\qquad\qquad
	}
	O{
		\whu@author
     }}{%
	\clearpage
	\newgeometry{
		vmargin = 5.5cm,
		hmargin = 1cm,
	}%
	\thispagestyle{empty}
	\pdfbookmark{0}{书脊}
	\begingroup
	\noindent\hfill
	\rotatebox[origin=lt]{-90}{%
		\makebox[\textheight]{%
			\fangsong
			\addCJKfontfeatures*{RawFeature={vertical}}%
			\whu@spine@font
			\CJKmove
			#1\hfill
			\kaishu
			\addCJKfontfeatures*{RawFeature={vertical}}%
			\whu@spine@font
			\CJKmove
			#2\hfill
			\whu@stretch{4.5em}{
			\fangsong
			\addCJKfontfeatures*{RawFeature={vertical}}%
			#3}%
		}
	}
	\endgroup
	\clearpage
	\restoregeometry
}
\RequirePackage{pdfpages}
\newcommand\statement{
	\ifx\whu@statement@file\@empty
	\newpage
	\vspace*{20pt}
	\begin{center}{\zihao{-2}\heiti 论文原创性声明}\end{center}
	\par\vspace*{30pt}
	\renewcommand{\baselinestretch}{2}
	{\zihao{4} \songti %
		
		
		
		本人郑重声明: 所呈交的学位论文, 是本人在导师指导下, 独立进行研究工作所取得的研究成果。
		除文中已经标明引用的内容外, 本论文不包含任何其他个人或集体已发表或撰写的研究成果。
		对本文的研究做出贡献的个人和集体, 均已在文中以明确方式标明。
		本声明的法律结果由本人承担。
		
		\vskip2cm
		
		\hspace*{4cm}学位论文作者（签名）: \hspace{4cm} \hfill \\[1cm]
		\hspace*{10cm}年 \hfill  月 \hfill 日\hspace{1cm}\hfill\par}
	
	%%%%%%%-------------------------------------------------
	\renewcommand{\baselinestretch}{1.6}
	\small\normalsize
	\else
	\includepdf{\whu@statement@file}
	\fi
	\checkdoublepage
}

\newcommand\protocol{
	\ifx\whu@license@file\@empty
	\newpage\vspace*{20pt}\thispagestyle{empty}
	\begin{center}{\zihao{-2}\heiti 武汉大学学位论文使用授权协议书}\end{center}
	\par\vspace*{30pt}
	
	本学位论文作者愿意遵守武汉大学关于保存、使用学位论文的管理办法及规定,
	即：学校有权保存学位论文的印刷本和电子版, 并提供文献检索与阅览服务；
	学校可以采用影印、缩印、数字化或其它复制手段保存论文；
	在以教学与科研服务为目的前提下, 学校可以向本校认证用户公布部分及全部内容。
	\begin{enumerate}[label=\chinese*、,wide]
		\item  在本论文提交当年, 同意向本校认证用户以及中国高等教育文献保障系统(CALIS)之高校学位论文系统提供查询及前十六页浏览服务。
		\item  在本论文提交~$\Box$~当年/~$\Box$~一年/~$\Box$~两年
		/~$\Box$~三年以后，同意在校园网内允许读者在线浏览并下载全文，学校可以为存在馆际合作关系的兄弟高校用户提供文献传递服务和交换服务。（保密论文解密后遵守此规定）
	\end{enumerate}
	
	\vskip 15mm
	
    论文作者（签名）：\raisebox{0ex}{\underline{\makebox[8.5em][c]{}}}
%    \vskip2em
    
    学\hspace{2em}号：\raisebox{0ex}{\underline{\makebox[12em][c]{}}}
%    \vskip2em	
    
    学\hspace{2em}院：\raisebox{0ex}{\underline{\makebox[12em][c]{}}}
    \vskip5em
    \hspace*{10cm}年 \hfill  月 \hfill 日\hspace{1cm}\hfill\par		
	\else
	\includepdf{\whu@license@file}
	\fi
	\checkdoublepage
}


\renewcommand*\cftsecfillnum[1]{%
	\cftsecleader\nobreak%
	#1\cftsecafterpnum\par}

\renewcommand*\cftsubsecfillnum[1]{%
	\cftsubsecleader\nobreak%
	#1\cftsubsecafterpnum\par}

\renewcommand*\cftchapfillnum[1]{%
	\cftchapleader\nobreak%
	#1\cftchapafterpnum\par}

\renewcommand*\cftsubsubsecfillnum[1]{%
	\cftsubsubsecleader\nobreak%
	#1\cftsubsubsecafterpnum\par}

\renewcommand*\cftparafillnum[1]{%
	\cftparaleader\nobreak%
	#1\cftparaafterpnum\par}

\renewcommand*\cfttabfillnum[1]{%
	\cfttableader\nobreak%
	#1\cfttabafterpnum\par}

\renewcommand*\cftfigfillnum[1]{%
	\cftfigleader\nobreak%
	#1\cftfigafterpnum\par}

\renewcommand {\thetable} {\thechapter{}-\arabic{table}}
\renewcommand {\thefigure} {\thechapter{}-\arabic{figure}}

\allowdisplaybreaks
\endlinechar `\^^M
\endinput
