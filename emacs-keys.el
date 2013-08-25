(add-hook 'lisp-mode-hook (lambda () (local-set-key [tab] 'slime-indent-and-complete-symbol) (local-set-key [return] 'newline-and-indent)))

(add-hook 'clojure-mode-hook (lambda () (local-set-key [tab] 'slime-indent-and-complete-symbol) (local-set-key [return] 'newline-and-indent)))
