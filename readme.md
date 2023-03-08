# 武汉大学硕士论文LaTeX模板
本模板在[rhjin](https://gitee.com/rhjin)修改的[武汉大学博士论文Latex模板](https://gitee.com/rhjin/PhdTemplate)基础上修改，修改为硕士论文的要求。
每年的论文提交要求可能略有变化，或者有一些模糊的地方，请在提交前与教学秘书再次确认。

## 主要文件列表：


|  MasterThesis.tex   | 主文档，在其中设置编译选项与增减包含的章节文件 |
|:------------------:|-------------------------------------------------|
|     WHUThesis.cls     | 定义硕士论文文档格式的 class file，包含中英文主页的具体定义格式  |
|includefile/frontmatter.tex | 无页码部分，包含中英文主页声明，论文“郑重声明”和"授权协议”  |
|includefile/midmatter.tex | 罗马数字页码部分，中英文摘要，目录，图表目录，缩略词                               |
|includefile/backmatter.tex | 参考文献、致谢、攻硕期间成果  |
|data/whusetup.tex | 封面信息，题目、作者、指导老师、专业等等信息  |
|data/innovations.tex | 创新点(硕士不需要，下一版删掉)           |
|data/cnabstract.tex | 中文摘要                                        |
|data/enabstract.tex | 英文摘要                                        |
|data/nomenclature.tex | 缩略词                                          |
|data/achievements.tex | 攻硕期间成果列表                                        |
|data/thanks.tex | 致谢                                            |
|ref/refs.bib|      参考文献列表                                   |
|figures/   | 存放图片文件                                  |
|attachment-pdf| 附件pdf，包括授权协议，授权书和原创声明 |
|ref-style   | 参考文件引用格式                                 |
|Fonts  | 存放字体文件                                  |

请特别注意：
- 源文件里的注释说明，主要包含了编译配置选项、命令；
- 源文件正文(或编译出来的 MasterThesis_backup.pdf)，给出了论文撰写格式说明

## 编译环境

推荐使用texlive+texstudio进行编译，两点提醒：
- 默认编译器选择XeLaTex(编译中文);
- 默认文献工具选择Biber(否则可能出现引用格式错误)。


也可以使用texlive + vscode，需要安装插件Latex Workshop

推荐使用较新的texlive, 比如2022，并手动安装
- https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/
- 安装完成后需要重启

## linux需要配置环境变量

```
export MANPATH=${MANPATH}:/usr/local/texlive/2022/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2022/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2022/bin/x86_64-linux
```
## Linux下字体缺失(Windows无需此项操作)

1、将/Fonts文件中的四种字体拷贝到Linux中/usr/share/fonts目录下；

2、终端进入/usr/share/font，依次执行
```
sudo mkfontscale 
sudo mkfontdir 
sudo fc-cache -fv
```

## vscode 编译配置
ctrl+shift + p， 打开Open User Settings (Json)

添加以下内容
<details>
<summary>展开查看</summary>
<pre><code>
   // Latex workshop
    "latex-workshop.latex.tools": [
        {
        "name": "latexmk",
        "command": "latexmk",
        "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-pdf",
        "%DOC%"
        ]
        },
        {
        "name": "xelatex",
        "command": "xelatex",
        "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
            ]
        },          
        {
        "name": "pdflatex",
        "command": "pdflatex",
        "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
        ]
        },
        {
        "name": "bibtex",
        "command": "bibtex",
        "args": [
        "%DOCFILE%"
        ]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
            "-l zh__pinyin",
            "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
        "name": "xelatex",
        "tools": [
        "xelatex"
                    ]
        },
        {
        "name": "latexmk",
        "tools": [
        "latexmk"
                    ]
        },
        {
            "name": "xelatex -> biber -> xelatex*2",
            "tools": [
            "xelatex",
            "biber",
            "xelatex",
            "xelatex"
                        ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "browser",
    "latex-workshop.latex.clean.fileTypes": [
    "*.aux",
    "*.bbl",
    "*.blg",
    "*.idx",
    "*.ind",
    "*.lof",
    "*.lot",
    "*.out",
    "*.toc",
    "*.acn",
    "*.acr",
    "*.alg",
    "*.glg",
    "*.glo",
    "*.gls",
    "*.ist",
    "*.fls",
    "*.log",
    "*.fdb_latexmk"
    ],   
</code></pre>
</details>

## 字数统计
在主文档目录运行以下命令，用于统计data文件夹中论文字数。
```
texcount -brief -sum=1 -ch data/*.tex
```
## 扫描版授权协议与原创声明
如果使用扫描版文件进行编译时出现以下错误，则需要将扫描版pdf文件使用pdf阅读器另存为新文件。
```
xdvipdfmx:fatal: pdf_link_obj(): passed invalid object.
```
## 书脊的制作
打印店可以帮助处理，也可使用根目录下的spine.tex文件生成。

## 参考文献生成与引用
推荐使用[Zotero](https://www.zotero.org/)管理参考文献，添加插件[Better BibTeX](https://retorque.re/zotero-better-bibtex/)用于自动生成与更新refs.bib文件。

使用\cite{}、\citeA{}分别引用参考文献得到形如 [编号]、作者（年份） 的样式。大括号内要填入由refs.bib 文件提供的字符串。

如果参考文献列表中网址与预印本异常，在Zotero的“首选项”-“Better BibTeX”-“Export”-“postscript”设置中添加如下代码：
```js
if (Translator.BetterBibTeX && item.itemType === 'webpage') {
    if (item.accessDate) {
      reference.add({ name: 'note', value: "(accessed " + item.accessDate.replace(/\s*T?\d+:\d+:\d+.*/, '') + ")" });
    }
    if (item.url) {
      reference.add({ name: 'howpublished', bibtex: "{\\url{" + reference.enc_verbatim({value: item.url}) + "}}" });
    }
  }

if (Translator.BetterTeX && item.arXiv.id) {
  reference.add({ name: 'pages', value: item.arXiv.id });
  if (!reference.has.journaltitle) { reference.add({ name: 'journaltitle', bibtex: '{}' }); }
}

if (Translator.BetterBibTeX && reference.referencetype === 'article' && item.arXiv) {
  if (reference.has.journal && item.arXiv.source === 'publicationTitle') {
    reference.remove('journal');
  }
  if (!reference.has.journal) reference.referencetype = 'misc'
}
```