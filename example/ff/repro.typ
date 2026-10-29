#import "../../src/lib.typ": *
#show: style
#set document(title: "t")
@fig:a @code:x @code:file @txt:file

#fimg(path("red.png"), caption: [img], label: <fig:a>, alt: "赤い正方形")
#fcode(caption: [long], label: "code:x")[#raw(read("long.py"), lang: "py", block: true)]
#fcode(path("long.py"), lang: "py", caption: [file], label: <code:file>)
#ftext(path("long.py"), caption: [txt], label: "txt:file", placement: none)
