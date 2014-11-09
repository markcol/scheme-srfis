(define-library (srfi 41 derived)
  (export
   stream-null stream-cons stream? stream-null? stream-pair? stream-car
   stream-cdr stream-lambda define-stream list->stream port->stream stream
   stream->list stream-append stream-concat stream-constant stream-drop
   stream-drop-while stream-filter stream-fold stream-for-each stream-from
   stream-iterate stream-length stream-let stream-map stream-match _
   stream-of stream-range stream-ref stream-reverse stream-scan stream-take
   stream-take-while stream-unfold stream-unfolds stream-zip
   )
  (import
   (scheme base)
   (srfi 1)
   (srfi 41 primitive))
  (include "derived.body.scm"))
