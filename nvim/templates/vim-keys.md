# VIM Keys


## Marks
wegen easy clip auf gm + buchstaben geändert, weil m = move ist

        set = "gm",
        set_next = "m,",
        next = "m]",
        preview = "m:",
        delete = "dm",
        set_bookmark0 = "m0",
        zu mark a gehen = "'a"

dm + buchstabe

oder :delmarks + buchstabe  =native nvim

## Surround
visual mode markieren
St
- S für Surroud
- t für tag

#### umgebende Tags löschen
- cursor in den Tag platzieren, geht also auch wenn im Tag mehrere wörter sind
- dst 
delete surround tag
ds( umgebende Klammern löschen

Führe bei deinem Cursor auf dem "text" einfach folgende Tastenkombination aus:
cs"(ns()
ysiw"

#### umgebende Klammern ersetzen
cs(} ersetzt runde klammern durch eckige

2) Visual auswählen + S verwenden
Cursor an den Anfang des ersten Wortes
v2e → markiert bis Ende des zweiten Wortes
S" → umschließen mit "
(Alternativ: v → mit den üblichen Bewegungen genau die zwei Wörter markieren → S".)

html tags
ysiwtstrong
| Tastenkombination | Bedeutung                                  |
| ----------------- | ------------------------------------------ |
| `y`               | "yank" – beginne eine Surround-Operation   |
| `s`               | "surround"                                 |
| `iw`              | "inner word" – wähle das aktuelle Wort aus |
| `tstrong`         | füge ein HTML-Tag `<strong>` ein           |



## Ufo

## Oil
- refresh: ctrl + l und R in der lua definiert
