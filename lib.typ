#import "@preview/cjk-unbreak:0.2.0": remove-cjk-break-space

// --------------------------------
// 各種変数
// --------------------------------
#let serif = ("New Computer Modern", "Harano Aji Mincho")
#let sans = ("New Computer Modern Sans", "Harano Aji Gothic")
#let title_size = 1.6em
#let subtitle_size = 1.2em
#let title_subcontent_size = 1.1em
#let date_format = "[year]年[month padding:zero]月[day padding:zero]日"

// 基本的なスタイルの設定
#let style(doc) = {
  set page(paper: "a4", numbering: "— 1/1 —")
  set text(11pt, font: serif, lang: "ja")
  set par(
    first-line-indent: (
      all: true,
      amount: 1em,
    ),
    leading: 0.7em,
    spacing: 0.8em,
  )

  show heading: set text(font: sans)
  set heading(numbering: "1.")
  show heading: it => {
    it
    v(5pt)
  }
  doc
}

// 全角コンマ等への変更
#let repl_full-en_punctuation() = {
  show "、": "，"
  show "。": "．"
}

#let report() = {}

// タイトルの出力
#let titles(title, subtitle: none) = {
  set document(title: title)

  // タイトル生成
  set align(center)
  text(weight: "bold", size: title_size, font: sans)[#title]
  linebreak()
  v(-1pt)
  text(weight: "regular", size: subtitle_size, font: sans)[#subtitle]
}


// 名前の出力
#let name(id: none, author) = {
  set document(author: author)

  // 名前生成
  set text(size: title_subcontent_size)
  set align(right)
  id
  h(1em)
  author
}

// 日付の出力
#let date_info(qdate: none) = {
  let today = datetime.today()
  set document(date: today)

  // 日付欄設定
  set align(right)
  set text()
  if qdate == none {
    today.display(date_format)
  } else {
    [#qdate.display("出題日" + date_format)
      \
      #today.display("提出日" + date_format)]
  }
}

#let report_(
  title: "無題のレポート",
  author: "著者名",
  date: datetime.today().display("[year]年[month]月[day]日"),
  body,
) = {
  // -------------------------------------------
  // 1. ページ設定 (set page)
  // -------------------------------------------
  // 用紙サイズ: A4
  // 余白: 上下 30mm, 左右 25mm
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 30mm, left: 25mm, right: 25mm),
    // フッターにページ番号を中央揃えで表示
    footer: align(center)[
      #counter(page).display("1")
    ],
  )

  // -------------------------------------------
  // 2. フォント設定 (set text)
  // -------------------------------------------
  // 基本フォント: New Computer Modern (Typstのデフォルトに近い)
  // フォントサイズ: 11pt
  //
  // ※ 日本語フォントを使用する場合、お使いのPCにインストールされている
  //    フォント名を指定してください。
  // 例:
  // set text(font: ("Hiragino Kaku Gothic ProN", "New Computer Modern"), lang: "ja", size: 11pt)
  set text(font: "New Computer Modern", lang: "ja", size: 11pt)


  // -------------------------------------------
  // 3. 段落設定 (set par)
  // -------------------------------------------
  // 行間: 1.65 (フォントサイズの1.65倍)
  // 両端揃え: 有効
  // 1行目のインデント: 1文字分
  set par(
    leading: 0.65em,
    justify: true,
    first-line-indent: 1em,
  )


  // -------------------------------------------
  // 4. 見出し設定 (set heading / show heading)
  // -------------------------------------------
  // 見出しに番号を振る (例: 1., 1.1., 1.1.1.)
  set heading(numbering: "1.1.")

  // レベル1見出し (=) のスタイル
  show heading.where(level: 1): it => {
    set block(above: 2.5em, below: 1.2em)
    align(left)[
      #text(1.6em, weight: "bold", it.body)
    ]
    line(length: 100%, stroke: 0.5pt) // 見出しの下に線を入れる
  }

  // レベル2見出し (==) のスタイル
  show heading.where(level: 2): it => {
    set block(above: 1.8em, below: 1em)
    align(left)[
      #text(1.3em, weight: "bold", it.body)
    ]
  }

  // レベル3見出し (===) のスタイル
  show heading.where(level: 3): it => {
    set block(above: 1.5em, below: 0.8em)
    align(left)[
      #text(1.1em, weight: "bold", it.body)
    ]
  }


  // -------------------------------------------
  // レポート本体の生成
  // -------------------------------------------

  // タイトル、著者、日付を中央に表示
  align(center)[
    #text(2em, weight: "bold")[#title]
    #v(2em)
    #text(1.2em)[#author]
    #v(1em)
    #date
  ]

  // タイトルの後に改ページ
  pagebreak()

  // 目次を自動生成
  outline()

  // 本文
  body
}
