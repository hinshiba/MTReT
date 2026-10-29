#import "@preview/codly:2.0.0" as codly

// --------------------------------
// Figureラッパー
// --------------------------------

// 画像用
#let fimg(
  path,
  caption: none,
  label: none,
  width: 100%,
  placement: bottom,
) = {
  [
    #figure(
      image(path, width: width),
      caption: caption,
      placement: placement,
    ) #label
  ]
}

// コードブロック
#let fcode(
  code,
  caption: none,
  label: none,
  placement: bottom,
) = {
  [
    #figure(
      block(
        // align要素はHTML出力で中身ごと捨てられるため，set ruleで寄せる
        {
          set align(left)
          code
        },
        breakable: true,
        stroke: 0.7pt,
        inset: 0.3em,
        width: 99%,
      ),
      caption: caption,
      kind: "src",
      placement: placement,
      supplement: "ソースコード",
    ) #label
  ]
}

// txtブロック
#let ftext(
  txt,
  caption: none,
  label: none,
  placement: bottom,
) = {
  show: codly.set_(number-enabled: false)
  [
    #figure(
      block(
        // align要素はHTML出力で中身ごと捨てられるため，set ruleで寄せる
        {
          set align(left)
          txt
        },
        breakable: true,
        stroke: 0.7pt,
        inset: 0.5em,
        width: 99%,
        radius: 0.5em,
      ),
      caption: caption,
      kind: "txt",
      placement: placement,
      supplement: "テキスト",
    ) #label
  ]
}
