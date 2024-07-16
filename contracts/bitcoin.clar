;; title: bitcoin
;; version:
;; summary:
;; description:

;; traits
(impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
(define-constant TOTAL_SUPPLY u4200000000)
(define-fungible-token bitcoin TOTAL_SUPPLY)

;; constants
(define-constant ERR_OWNER_ONLY (err u100))
(define-constant ERR_NOT_TOKEN_OWNER (err u101))

(define-constant CONTRACT_OWNER tx-sender)
(define-constant TOKEN_NAME "NakamotoWizardMemePartyTime21 Inu")
(define-constant TOKEN_SYMBOL "BITCOIN")
(define-constant TOKEN_DECIMALS u0)
;; (define-constant TOKEN_URI u"ipfs://tokenUri")

;; data vars
(define-data-var token-uri (string-utf8 256) u"ipfs://tokenUri") ;; TODO: update with correct URI

;; data maps
;;

;; public functions
(define-read-only (get-balance (owner principal))
  (begin
    (ok (ft-get-balance bitcoin owner))))

(define-read-only (get-total-supply)
  (ok (ft-get-supply bitcoin)))

(define-read-only (get-name)
  (ok TOKEN_NAME))

(define-read-only (get-symbol)
  (ok TOKEN_SYMBOL))

(define-read-only (get-decimals)
  (ok TOKEN_DECIMALS))

(define-public (transfer
  (amount uint)
  (sender principal)
  (recipient principal)
  (memo (optional (buff 34)))
)
  (begin
    ;; #[filter(amount, recipient)]
    (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)
    (try! (ft-transfer? bitcoin amount sender recipient))
    (match memo to-print (print to-print) 0x)
    (ok true)
  )
)

(define-public (get-token-uri)
  (ok (some (var-get token-uri))))

;; #[allow(unchecked_data)]
(define-public (set-token-uri (uri (string-utf8 256)))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (begin
      (var-set token-uri uri)
      (ok true))
    (err ERR_NOT_TOKEN_OWNER)))

;; read only functions
;;

;; private functions
;;
