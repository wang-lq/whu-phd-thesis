# 武汉大学博士论文LaTeX模板
本模版在[武大GNSS中心常乐的模版](http://172.20.99.0:3000/cl/PhdTemplate)的基础上修改，主要包含：


|  PhdTemplate.tex   | 主文档，在其中设置编译选项与增减包含的章节文件 |
|:------------------:|-------------------------------------------------|
|     WHUPhd.cls     | 定义文档格式的 class file            |
|includefile/frontmatter.tex | 无页码部分                                      |
|includefile/midmatter.tex | 罗马数字页码部分                                |
|includefile/backmatter.tex | 参考文献、致谢、作品列表                      |
|data/whusetup.tex | 题目与作者等等信息                              |
|data/innovations.tex | 创新点                                          |
|data/cnabstract.tex | 中文摘要                                        |
|data/enabstract.tex | 英文摘要                                        |
|data/nomenclature.tex | 缩略词                                          |
|data/achievements.tex | 成果列表                                        |
|data/thanks.tex | 致谢                                            |
|figures文件夹   | 存放图片文件                                  |
|ref/refs.bib|      参考文献列表                                   |

请特别注意：
- 源文件里的注释说明，主要包含了编译配置选项、命令；
- 源文件正文(或编译出来的PhdTemplate_bak.pdf)，给出了论文撰写格式说明

## 编译环境

推荐使用texlive+texstudio进行编译，两点提醒：
- 默认编译器选择XeLaTex(编译中文);
- 默认文献工具选择Biber(否则可能出现引用格式错误)。


## Linux下字体缺失(Windows无需此项操作)

1、将/Fonts文件中的四种字体拷贝到Linux中/usr/share/font目录下；

2、终端进入/usr/share/font，依次执行
```
sudo mkfontscale 
sudo mkfontdir 
sudo fc-cache -fv
```


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