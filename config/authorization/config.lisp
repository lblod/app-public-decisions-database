;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

(add-delta-logger)
(add-delta-messenger "http://deltanotifier/")

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* t)
(setf *backend* "http://virtuoso:8890/sparql")

(in-package :server)
(setf *log-incoming-requests-p* nil)

;;;;;;;;;;;;;;;;;
;;; access rights
(in-package :acl)

(defparameter *access-specifications* nil
  "All known ACCESS specifications.")

(defparameter *graphs* nil
  "All known GRAPH-SPECIFICATION instances.")

(defparameter *rights* nil
  "All known GRANT instances connecting ACCESS-SPECIFICATION to GRAPH.")

;; Prefixes used in the constraints below (not in the SPARQL queries)
(define-prefixes
  :cogs "http://vocab.deri.ie/cogs#"
  :reporting "http://lblod.data.gift/vocabularies/reporting/"
  :core "http://open-services.net/ns/core#"
  :besluit "http://data.vlaanderen.be/ns/besluit#"
  :adms "http://www.w3.org/ns/adms#"
  :nfo "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
  :prov "http://www.w3.org/ns/prov#"
  :skos "http://www.w3.org/2004/02/skos/core#"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  :foaf "http://xmlns.com/foaf/0.1/")

(type-cache::add-type-for-prefix "http://mu.semte.ch/sessions/" "http://mu.semte.ch/vocabularies/session/Session")

(define-graph public ("http://mu.semte.ch/graphs/public")
  ("foaf:Person" -> _)
  ("foaf:OnlineAccount" -> _)
  ("besluit:Bestuurseenheid" -> _))

(define-graph org ("http://mu.semte.ch/graphs/organizations/")
  ("foaf:Person" -> _)
  ("foaf:OnlineAccount" -> _)
  ("adms:Identifier" -> _))

(define-graph readers ("http://mu.semte.ch/graphs/access-for-role/PubliekeBesluitendatabank-BesluitendatabankLezer")
  ("besluit:Bestuurseenheid" -> _)
  ("foaf:Person" -> _)
  ("foaf:OnlineAccount" -> _)
  ("nfo:FileDataObject" -> _)
  ("nfo:RemoteDataObject" -> _)
  ("prov:Location" -> _)
  ("ext:BestuurseenheidClassificatieCode" -> _)
  ("besluit:Bestuursorgaan" -> _)
  ("ext:BestuursorgaanClassificatieCode" -> _)
  ("ext:ChartOfAccount" -> _)
  ("ext:AuthenticityType" -> _)
  ("ext:TaxType" -> _)
  ("skos:ConceptScheme" -> _)
  ("skos:Concept" -> _)
  ("foaf:Document" -> _)
  ("http://rdf.myexperiment.org/ontologies/base/Submission" -> _)
  ("ext:SubmissionDocument" -> _)
  ("http://lblod.data.gift/vocabularies/besluit/TaxRate" -> _)
  ("http://lblod.data.gift/vocabularies/automatische-melding/FormData" -> _))

(define-graph reports ("http://mu.semte.ch/graphs/reports")
  ("reporting:Report" -> _)
  ("core:Error" -> _)
  ("nfo:DataContainer" -> _)
  ("nfo:FileDataObject" -> _))

(define-graph jobs ("http://mu.semte.ch/graphs/system/jobs")
  ("cogs:Job" -> _)
  ("nfo:DataContainer" -> _)
  ("nfo:FileDataObject" -> _))

(supply-allowed-group "public")

(supply-allowed-group "logged-in-or-impersonating"
  :parameters ("session_group")
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
    PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
    SELECT ?session_group ?session_role WHERE {
      <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group.
    }")

(supply-allowed-group "BesluitendatabankGebruiker"
  :parameters ()
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
    PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
    SELECT DISTINCT ?session_group ?session_role WHERE {
      <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                   ext:sessionRole ?session_role.
      FILTER( ?session_role = \"BesluitendatabankGebruiker\" )
    }")

(supply-allowed-group "o-admin-rwf"
  :parameters ()
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
    SELECT DISTINCT ?session WHERE {
      <SESSION_ID> ext:sessionRole \"AdminDashboardPDD\" .
    }")


(grant (read)
  :to-graph (public)
  :for-allowed-group "public")

(grant (read)
  :to-graph (org)
  :for-allowed-group "logged-in-or-impersonating")

(grant (read)
  :to-graph (readers)
  :for-allowed-group "BesluitendatabankGebruiker")


(grant (read write)
  :to-graph (jobs)
  :for-allowed-group "o-admin-rwf")
(grant (read write)
  :to-graph (reports)
  :for-allowed-group "o-admin-rwf")