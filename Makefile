# -*- makefile -*-
TEX=platex
DVI2PDF=dvipdfmx

SOURCES = \
	manuscript.tex \
	$(NULL)

MDSCRIPT = \
	contents.md \
	$(NULL)

all: convertmd dvi2pdf clean

convertmd: $(MDSCRIPT)
	@cat $^ \
	| sed s/.png/.eps/g \
	| pandoc -t latex \
	| sed 's/includegraphics/includegraphics[width=1.0\\columnwidth]/g' \
	| sed 's/\[htbp\]/\[t\]/g' \
	> $(MDSCRIPT:.md=.tex)

.tex.dvi: convertmd
	@${TEX} $<
	@${TEX} $<  

dvi2pdf: $(SOURCES:.tex=.dvi)
	@${DVI2PDF} $^ && evince $(SOURCES:.tex=.pdf)

clean: 
	@rm -f *.dvi *.aux *.log
