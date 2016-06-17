(load "util.lisp")

(defun read-and-write ()
  ;; open config file and generate new file based on option
  (with-open-file (config "caps-config.txt")
    (with-open-file (result "caps-output.txt" 
                            :direction :output
                            :if-exists :supersede)
      (let* ((line (read-line config))
             (caps-option (split-string #\= line))
             (caps-y-or-n (subseq (cadr caps-option) 0 1)))
        (if (string-equal caps-y-or-n "s")
            (format result "Config CAPS SIM")
            (format result "Config caps nao"))))))

(defun main ()
  (read-and-write)
  (format t "Pressione Enter para terminar.")
  (read-char)
  (ext:exit))
  
(create-exe "caps.exe")
