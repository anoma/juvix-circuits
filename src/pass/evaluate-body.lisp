(in-package :alu.pass.evaluate-body)

(-> evaluate-and-cache-body (ir:circuit) list)
(defun evaluate-and-cache-body (circuit)
  "This function evals the given circuit body and returns the cached
arguments"
  (values
   (if (properly-chachedp circuit)
       (ir:exec circuit)
       (let ((exec-body (evaluate-circuit-body (ir:body circuit))))
         (setf (ir:exec circuit) exec-body)
         exec-body))))

(-> evaluate-circuit-body (list) list)
(defun evaluate-circuit-body (frozen-term)
  ;; need a cons to start with, so make a cons
  (let ((new-body (list nil)))
    (emit:with-circuit-body new-body
      ;; we have actual frozen code, we must eval!
      (eval frozen-term))))

(-> properly-chachedp (ir:circuit) boolean)
(defun properly-chachedp (circuit)
  "checks if the circuit's execution body is properly cached"
  (declare (ignore circuit))
  ;; Currently we have no good tracking, so just return that it is not
  ;; cached!
  nil)

