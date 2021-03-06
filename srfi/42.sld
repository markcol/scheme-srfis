(define-library (srfi 42)
  (export
   :
   :-dispatch-ref
   :-dispatch-set!
   :char-range
   :dispatched
   :do
   :generator-proc
   :integers
   :let
   :list
   :parallel
   :port
   :range
   :real-range
   :string
   :until
   :vector
   :while
   any?-ec
   append-ec
   dispatch-union
   do-ec
   every?-ec
   first-ec
   fold-ec
   fold3-ec
   last-ec
   list-ec
   make-initial-:-dispatch
   max-ec
   min-ec
   product-ec
   string-append-ec
   string-ec
   sum-ec
   vector-ec
   vector-of-length-ec
   )
  (import
   (scheme base)
   (scheme cxr)
   (scheme read))
  (include "42.body.scm"))
