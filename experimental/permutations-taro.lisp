(defun grow (branches new-leaves)
  (if (null branches)
      '()
      (append (add-leaves (car branches) new-leaves) (grow (cdr branches) new-leaves))))

(defun add-leaves (branch leaves)
  (if (null leaves)
      '()
      (if (not (member (car leaves) branch))  ;; add leaf only if it's not the same as branch
          (cons (cons (car leaves) branch) (add-leaves branch (cdr leaves)))
          (add-leaves branch (cdr leaves)))))

(defun permutation-tree (choices levels)
  (if (<= levels 1)
      (add-leaves '() choices)
      (grow (permutation-tree choices (- levels 1)) choices)))

(sort (mapcar #'(lambda (lst) (apply #'concatenate 'string lst)) (permutation-tree '("t" "a" "r" "o") 4)) #'string<)
'("aort" "aotr" "arot" "arto" "ator" "atro" "oart" "oatr" "orat" "orta" "otar" "otra" "raot" "rato" "roat" "rota" "rtao" "rtoa" "taor" "taro"
"toar" "tora" "trao" "troa")


" Python itertools permutations
print('\n'.join(sorted([''.join(w) for w in permutations(\"rota\", 4)])))

aort
aotr
arot
arto
ator
atro
oart
oatr
orat
orta
otar
otra
raot
rato
roat
rota
rtao
rtoa
taor
taro
toar
tora
trao
troa"

