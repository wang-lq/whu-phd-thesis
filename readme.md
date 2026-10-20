# 武汉大学博士论文LaTeX模板
本模板在[rhjin](https://gitee.com/rhjin)修改的[武汉大学博士论文Latex模板](https://gitee.com/rhjin/PhdTemplate)基础上修改，保留了硕士论文模板中的改进（可选参考文献格式、可选英文封面样式、附件pdf目录等），按博士论文的要求修改。
每年的论文提交要求可能略有变化，或者有一些模糊的地方，请在提交前与教学秘书再次确认。

## 主要文件列表

| 文件/目录 | 说明 |
|:------------------:|-------------------------------------------------|
|  PhdThesis.tex   | 主文档，在其中设置编译选项与增减包含的章节文件 |
|     WHUThesis.cls     | 定义博士论文文档格式的 class file，包含中英文封面的具体定义格式  |
|spine.tex | 单独生成书脊 |
|includefile/frontmatter.tex | 无页码部分，包含中英文封面、论文原创性声明、学位论文使用授权协议书和创新点  |
|includefile/midmatter.tex | 罗马数字页码部分，中英文摘要，目录，图表目录，缩略词（图表目录和缩略词只加书签，不列入目录） |
|includefile/backmatter.tex | 参考文献、攻博期间成果、致谢  |
|data/whusetup.tex | 封面信息，题目、作者、指导教师、学科专业等等信息  |
|data/innovations.tex | 博士生自认为的论文创新点           |
|data/cnabstract.tex | 中文摘要                                        |
|data/enabstract.tex | 英文摘要                                        |
|data/nomenclature.tex | 缩略词                                          |
|data/chap*.tex | 正文各章 |
|data/achievements.tex | 攻博期间发表的科研成果目录                                        |
|data/thanks.tex | 致谢                                            |
|ref/refs.bib|      参考文献列表                                   |
|figures/   | 存放图片文件                                  |
|attachment-pdf| 附件pdf，包括授权协议，授权书和原创声明 |
|ref-style   | 参考文献引用格式（默认gb7714-2015顺序编码制，另有gb7714-2015ay著者-出版年制和ieee）  |
|Fonts  | 存放中文字体文件                                  |
|博士论文格式要求 | 学校的《博士学位论文撰写及印制规格的规定》及附页原件 |

请特别注意：
- 源文件里的注释说明，主要包含了编译配置选项、命令；
- 源文件正文(或编译出来的 PhdThesis_backup.pdf)，给出了论文撰写格式说明

## 主要编译选项

在 PhdThesis.tex 的 `\documentclass[...]{WHUThesis}` 中设置：

- `output`：`electronic`（电子版，默认）、`print`（打印版，自动插入空白页以便双面打印）、`ppt`（省略图表编号，方便截图做PPT）；
- `review=true`：隐藏作者和导师信息，用于外审；
- `refstyle-file`：参考文献格式，默认 `ref-style/gb2015/gb7714-2015`（顺序编码制）；
- `entitle-entype`：英文题目页样式，`true` 按英文规范设计，`false` 与中文封面对应翻译；
- `statement-file`、`license-file`：使用扫描版的原创性声明、授权协议书pdf，留空则由模板生成。

## 编译环境

推荐使用texlive+texstudio进行编译，两点提醒：
- 默认编译器选择XeLaTex(编译中文);
- 默认文献工具选择Biber(否则可能出现引用格式错误)。


也可以使用texlive + vscode，需要安装插件Latex Workshop

推荐使用较新的texlive（本模板在TeX Live 2025下测试通过），并手动安装
- https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/
- 安装完成后需要重启

完整编译顺序为：XeLaTeX → Biber → makeindex（生成缩略词）→ XeLaTeX → XeLaTeX。其中缩略词列表需要在主文档目录手动运行一次：
```
makeindex PhdThesis.nlo -s nomencl.ist -o PhdThesis.nls
```
下文的vscode配置（包括"latexmk (xelatex)"）不会自动执行这一步，缩略词有改动时需要手动运行。

## linux需要配置环境变量

以TeX Live 2025为例，将路径中的年份换成实际安装的版本：
```
export MANPATH=${MANPATH}:/usr/local/texlive/2025/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2025/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2025/bin/x86_64-linux
```
## Linux下字体缺失(Windows无需此项操作)

1、将/Fonts文件中的四种字体拷贝到Linux中/usr/share/fonts目录下；

2、终端进入/usr/share/fonts，依次执行
```
sudo mkfontscale 
sudo mkfontdir 
sudo fc-cache -fv
```

3、西文字体使用Times New Roman，Linux下需另行安装（例如Debian/Ubuntu执行`sudo apt install ttf-mscorefonts-installer`），安装后可用`fc-list | grep "Times New Roman"`确认。

## vscode 编译配置
ctrl+shift + p， 打开Open User Settings (Json)

添加以下内容，并在左边TEX选项->Build LaTeX project，设置编译工具为："latexmk (xelatex)" 可以一次编译完成。
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
            "name": "xelatexmk",
            "command": "latexmk",
            "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-xelatex",
            "-outdir=%OUTDIR%",
            "%DOC%"
            ],
            "env": {}
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
            // "-l zh__pinyin",
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
            "name": "latexmk (xelatex)",
            "tools": [
                "xelatexmk"
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
    // End Latex workshop
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

使用\cite{}、\citeA{}分别引用参考文献，在默认的顺序编码制下得到形如 [编号]、作者[编号] 的样式。大括号内要填入由refs.bib 文件提供的字符串。

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