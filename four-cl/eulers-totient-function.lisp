;;;; 75. Euler's Totient Function
;;;; 

(in-package :hc)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt after solving

(deftest test-eulers-totient
    ((= (__ 1) 1)
     (= (__ 10) (length '(1 3 7 9)) 4)
     (= (__ 40) 16)
     (= (__ 99) 60))
  eulers-totient)

(defun my-gcd (a b)
  (if (= b 0)
      a
      (my-gcd b (mod a b))))

(defun coprimep (a b)
  (= (gcd a b) 1))

(defun eulers-totient-helper (x i total)
  (if (= i x)
      total
      (eulers-totient-helper x (+ i 1) (+ total
                                          (if (coprimep x i)
                                              1
                                              0)))))

(defun eulers-totient (x)
  (if (= x 1)
      1
      (eulers-totient-helper x 1 0)))

(test-eulers-totient)
                                            
