;;;; Ubuntu only
(ext:cd #P"/home/heitor/commonlisp/experimental/")

(with-html-to-file ("outfile-2016-07-08.html")
  (html (:p (loop repeat 10 do (html (:print (random 1000)) " ")))
        (:p (:print (subseq "abcdefg" 2 5)))))
