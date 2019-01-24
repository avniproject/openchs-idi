
hello:
	@echo world

_env:=
file:=

dev:
	$(eval _env:=dev)

uat:
	$(eval _env:=uat)

staging:
	$(eval _env:=staging)

prod:
	$(eval _env:=prod)

_grunt = \
	grunt deploy:$(1) --target=$(_env) $(if $(file),--only-file=$(file))

_all:; $(call _grunt,all)
_adminUsers:; $(call _grunt,adminUsers)
_locations:; $(call _grunt,locations)
_catchments:; $(call _grunt,catchments)
_users:; $(call _grunt,users)
_concepts:; $(call _grunt,concepts)
_operationalEncounterTypes:; $(call _grunt,operationalEncounterTypes)
_operationalPrograms:; $(call _grunt,operationalPrograms)
_operationalSubjectTypes:; $(call _grunt,operationalSubjectTypes)
_forms:; $(call _grunt,forms)
_formDeletions:; $(call _grunt,formDeletions)
_formAdditions:; $(call _grunt,formAdditions)
_checklistDetails:; $(call _grunt,checklistDetails)
_rules:; $(call _grunt,rules)

deploy-dev-all: dev _all
deploy-dev-adminUsers: dev _adminUsers
deploy-dev-locations: dev _locations
deploy-dev-catchments: dev _catchments
deploy-dev-users: dev _users
deploy-dev-concepts: dev _concepts
deploy-dev-operationalEncounterTypes: dev _operationalEncounterTypes
deploy-dev-operationalPrograms: dev _operationalPrograms
deploy-dev-operationalSubjectTypes: dev _operationalSubjectTypes
deploy-dev-forms: dev _forms
deploy-dev-formDeletions: dev _formDeletions
deploy-dev-formAdditions: dev _formAdditions
deploy-dev-checklistDetails: dev _checklistDetails
deploy-dev-rules: dev _rules

deploy-staging-all: staging _all
deploy-staging-adminUsers: staging _adminUsers
deploy-staging-locations: staging _locations
deploy-staging-catchments: staging _catchments
deploy-staging-users: staging _users
deploy-staging-concepts: staging _concepts
deploy-staging-operationalEncounterTypes: staging _operationalEncounterTypes
deploy-staging-operationalPrograms: staging _operationalPrograms
deploy-staging-operationalSubjectTypes: staging _operationalSubjectTypes
deploy-staging-forms: staging _forms
deploy-staging-formDeletions: staging _formDeletions
deploy-staging-formAdditions: staging _formAdditions
deploy-staging-checklistDetails: staging _checklistDetails
deploy-staging-rules: staging _rules

deploy-uat-all: uat _all
deploy-uat-adminUsers: uat _adminUsers
deploy-uat-locations: uat _locations
deploy-uat-catchments: uat _catchments
deploy-uat-users: uat _users
deploy-uat-concepts: uat _concepts
deploy-uat-operationalEncounterTypes: uat _operationalEncounterTypes
deploy-uat-operationalPrograms: uat _operationalPrograms
deploy-uat-operationalSubjectTypes: uat _operationalSubjectTypes
deploy-uat-forms: uat _forms
deploy-uat-formDeletions: uat _formDeletions
deploy-uat-formAdditions: uat _formAdditions
deploy-uat-checklistDetails: uat _checklistDetails
deploy-uat-rules: uat _rules

deploy-prod-all: prod _all
deploy-prod-adminUsers: prod _adminUsers
deploy-prod-locations: prod _locations
deploy-prod-catchments: prod _catchments
deploy-prod-users: prod _users
deploy-prod-concepts: prod _concepts
deploy-prod-operationalEncounterTypes: prod _operationalEncounterTypes
deploy-prod-operationalPrograms: prod _operationalPrograms
deploy-prod-operationalSubjectTypes: prod _operationalSubjectTypes
deploy-prod-forms: prod _forms
deploy-prod-formDeletions: prod _formDeletions
deploy-prod-formAdditions: prod _formAdditions
deploy-prod-checklistDetails: prod _checklistDetails
deploy-prod-rules: prod _rules
