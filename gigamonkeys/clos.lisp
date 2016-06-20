(defgeneric speak (language)
  (:documentation "Say a number in the given language"))

(defmethod speak ((language english))
  (print "one"))

(defmethod speak ((language french))
  (print "un"))
