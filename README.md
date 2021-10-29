# `ucasproposal` 国科大开题报告 LaTeX 模板

## 模板下载

* 页面右边点击：**Clone or download -> Download Zip**
* [Overleaf](https://github.com/mohuangrui/ucasthesis/wiki/字体配置#linuxoverleaf-系统的字体配置)

## 重要建议

* 关于 ucasproposal 的使用，参见 [ucasthesis：中国科学院大学学位论文 LaTeX 模板](https://github.com/mohuangrui/ucasthesis)。

<h1 align="center">
<img width="50%" src="https://github.com/mohuangrui/mohuangrui/blob/main/gallery/ucasproposal.gif" alt="ucasproposal">
</h1>

## 模板简介
 
* ucasproposal 用于撰写中国科学院大学开题报告，面向对象为国科大学生（硕、博及留学生）。

## 重要通知

* `2020-01-09` 模板样式进行了修改，请查看下面的修改描述，以决定是否需要更新。

## 更新记录

* `2021-09-27` [benkwoook, issue #359](https://github.com/mohuangrui/ucasthesis/issues/359)，增强 artratex.sty，提供去掉“引言”类章节的章节编号的功能。

* `2020-07-28` [Tony, issue #299](https://github.com/mohuangrui/ucasthesis/issues/299)，更新 bibtex 样式。文献样式更多讨论可见：[文献样式](https://github.com/mohuangrui/ucasthesis/wiki/%E6%96%87%E7%8C%AE%E6%A0%B7%E5%BC%8F)。

* `2020-07-22` [hushidong, zepinglee, issue #296](https://github.com/mohuangrui/ucasthesis/issues/296)，完善 biblatex 和 bibtex 样式。

* `2020-07-17` [GitatHub, hushidong, issue #296](https://github.com/mohuangrui/ucasthesis/issues/296)，更新 bibtex 国标样式 [gbt7714-bibtex-style](https://github.com/CTeX-org/gbt7714-bibtex-style) ，增加 biblatex 国标样式 [biblatex-gb7714-2015](https://github.com/hushidong/biblatex-gb7714-2015)。

* `2020-05-22` [lipcaty, issue #281](https://github.com/mohuangrui/ucasthesis/issues/281) 修复 ctex 移除 xeCJKfntef 后对 ulem 的加载。

* `2020-03-20` [zepinglee, issue #250](https://github.com/mohuangrui/ucasthesis/issues/250) 增加 LaTeX 和依赖宏包版本检测功能。

* `2020-02-11` [ck2019ML, issue #182](https://github.com/mohuangrui/ucasthesis/issues/182)、[univeryinli, issue #229](https://github.com/mohuangrui/ucasthesis/issues/229) 将 ucasproposal 在 [Overleaf](https://github.com/mohuangrui/ucasthesis/wiki/字体配置#linuxoverleaf-系统的字体配置) 发布并支持调用外部字体，详见[字体配置](https://github.com/mohuangrui/ucasthesis/wiki/字体配置)。

* `2020-01-09` [NineSH, issue #223](https://github.com/mohuangrui/ucasthesis/issues/223) 修复`bicaption`错误。

* `2019-10-12` [huiwenzhang, issue #198](https://github.com/mohuangrui/ucasthesis/issues/198) 修复`mainmatter`下`\chapter*`的页眉错误。

* `2019-10-12` [Fancy0609, muzimuzhi, issue #195](https://github.com/mohuangrui/ucasthesis/issues/195) 调整由`AutoFakeBold`控制的伪粗体加粗程度。

* `2019-10-11` [Pantrick, issue #190](https://github.com/mohuangrui/ucasthesis/issues/190) 采用 [muzimuzhi](https://github.com/muzimuzhi) 提供的方法实现`\advisor{}`和`\institute{}`的自动换行功能。

* `2019-08-01` [vectorliu, issue #183](https://github.com/mohuangrui/ucasthesis/issues/183) 修改英文模式下的`plain`选项为`scheme=plain`以消除对`Algorithm`样式的修改。

* `2019-06-15` [HaorenWang, issue #177](https://github.com/mohuangrui/ucasthesis/issues/177) 调整矢量、矩阵、张量字体样式。

* `2019-06-09` [DRjy, issue #170](https://github.com/mohuangrui/ucasthesis/issues/170) 轻微缩减目录中编号与标题的间距；[e71828, issue #174](https://github.com/mohuangrui/ucasthesis/issues/174) 轻微增加页眉中编号与标题的间距。

* `2019-05-25` [CDMA2019, issue #169](https://github.com/mohuangrui/ucasthesis/issues/169) 提供横排图表环境下页眉页脚的横排，具体使用见 [横排图表](https://github.com/mohuangrui/ucasthesis/wiki/横排图表)。

* `2019-04-24` 修复 [gsp2014, issue #156](https://github.com/mohuangrui/ucasthesis/issues/156) 文献引用中的连字符的间断显示和上标引用中逗号下沉。

* `2019-04-19` 修复 [nihaomiao, issue #117](https://github.com/mohuangrui/ucasthesis/issues/117) `\mathbf` 失效问题。

* `2019-04-09` 对部分宏命令进行调整，无功能及样式上的修改。若需更新，建议参考 [更新指南](https://github.com/mohuangrui/ucasthesis/wiki/更新指南)。

* `2019-04-04` [liuy334, songchunlin, issue #134](https://github.com/mohuangrui/ucasthesis/issues/134) ，调整行距使 LaTeX 版与 Word 版的行数和每行字数相一致。

* `2019-03-28` [zssasa, allenwoods, issue #49](https://github.com/mohuangrui/ucasthesis/issues/49) ，修复 bicaption 对 longtable 的兼容性。

* `2019-03-25` [muzimuzhi, issue #130](https://github.com/mohuangrui/ucasthesis/issues/130) ，修正对 \voffset 的使用。

* `2019-03-14` [opt-gaobin, issue #121](https://github.com/mohuangrui/ucasthesis/issues/121) ，修正中文标点使下划线断掉的问题。[Guoqiang Zhang, email; weili-ict, issue #120](https://github.com/mohuangrui/ucasthesis/issues/120) ，修复 \proofname 命令对2015年及更早 LaTeX 编译器的兼容性问题。

* `2019-02-20` [opt-gaobin, issue #100](https://github.com/mohuangrui/ucasthesis/issues/100) ，增加定理、定义、证明等数学环境。[DRjy, issue #102](https://github.com/mohuangrui/ucasthesis/issues/102) ，调整 \mathcal 字体样式。[zike Liu, email] ，适当缩减目录列表的缩进。[xiaoyaoE, issue #105](https://github.com/mohuangrui/ucasthesis/issues/105) ，使数字字体和英文字体一致。完善中文版和国际版之间的中英格式切换。

* `2018-04-02` 模板进行了重大更新，修复了样式、字体、格式等许多问题。

* `2018-02-06` 将模板的兼容性进一步扩展。当前模板兼容操作系统 Windows，Linux，MacOS 和 LaTeX 编译引擎 pdflatex，xelatex，lualatex。

* `2017-05-31` [张宇航同, email] ，修正题目换行，标题居中对齐，一级标题使用汉字，二级标题用阿拉伯数字。

* `2016-10-02` [刘晓彤, email] 提供 Word 版本和测试帮助下，发布此 LaTeX 模板.

## 用户指南

* 模板的使用说明参见 [ucasthesis：中国科学院大学学位论文 LaTeX 模板](https://github.com/mohuangrui/ucasthesis)
