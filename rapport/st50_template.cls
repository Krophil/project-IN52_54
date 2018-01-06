\ProvidesClass{st50_template}[4/2/2015 custom ST class]
\LoadClass[12pt]{article}

\RequirePackage[top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[francais]{babel}
\RequirePackage{titlesec}
\RequirePackage{color}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{fancyhdr}

\setcounter{secnumdepth}{5}

\renewcommand{\baselinestretch}{1.1}
\setlength{\parskip}{0.2cm}

\hypersetup{
    colorlinks=false,
    pdfborder={0 0 0},
}

\pagenumbering{arabic}

%Color
\definecolor{white}{rgb}{1.0, 1.0, 1.0}
\definecolor{black}{rgb}{0.0, 0.0, 0.0}
\definecolor{gray}{rgb}{0.30, 0.30, 0.36}
\definecolor{yellow}{rgb}{0.85, 0.85, 0.34}
\definecolor{purple}{rgb}{0.488, 0.36, 0.51}
\definecolor{orange}{rgb}{0.929, 0.41, 0.0}

%Format
\titleformat{\section}[block]
    {\Large}
    {\textcolor{orange}{\thesection/}}
    {1.5em}
    {\textcolor{orange}}
    
\titleformat{\subsection}[block]
    {\Large}
    {\textcolor{orange}{\thesubsection/}}
    {1.5em}
    {\textcolor{orange}}
  
\titleformat{\subsubsection}[block]
    {\Large}
    {\textcolor{orange}{\thesubsubsection/}}
    {1.5em}
    {\textcolor{orange}}

\titleformat{\paragraph}[block]
    {\Large}
    {\textcolor{orange}{\theparagraph/}}
    {1.5em}
    {\textcolor{orange}}