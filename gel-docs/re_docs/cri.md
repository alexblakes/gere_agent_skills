---
title: 'Reporting potential diagnoses and contacting clinicians - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cri/
scraped_at: 2026-05-04T06:34:31Z
---

# Reporting potential diagnoses and contacting clinicians

Through your analyses in the Research Environment, you may discover a new genomic finding that could represent a potential diagnosis for a participant. You may wish to notify Genomics England of this potential new diagnosis so that relevant findings can be reported via the Diagnostic Discovery pathway back to the Genomic Laboratory Hubs for review

If your finding requires further investigation, you might like to contact the clinician for further information via the Clinical Collaboration pathway (for example to request more clinical information, additional samples or consent for publication)

In either of these cases, or where both apply, you should get in touch via the **Contact Clinical Team and/or Report Potential Diagnosis form**. You'll find this form within the [Airlock tool](../airlock_tool/).

The Diagnostic Discovery pathway returns potentially diagnostic variants in genes with established phenotypic associations to NHS GLHs for clinical evaluation and reporting. If your finding is a new research finding, for example, a novel gene-disease association, we recommend you submit a Clinical Collaboration request only.

## Filling in the form

Open Airlock from the desktop then click on **Forms** and open the **Contact Clinical Team and/or Report Potential Diagnosis Form**.

The fields on the form are all required to help the Clinical Research Interface team assess your request(s). The information you provide will be shared with the participantâs clinical team, and/or the GLH clinical scientists if your request is accepted.

| Field | Description |
| --- | --- |
| User Group | Select your group from the drop-down options. |
| RR Number (aka Project ID) | The identifier of your registered project. If you are unsure of this, please check the [Research Registry](https://research.genomicsengland.co.uk/research-registry/). If you have not already registered a project, you should do so before submitting a request by emailing [gecip-help@genomicsengland.co.uk](mailto:gecip-help@genomicsengland.co.uk). |
| What is your expertise in this area? | Please indicate your area of research. This can include the research group you are a member of. |
| Do you wish to be put in contact with the clinical team of the participant? | Yes or no. Please select âYesâ here if you would like to submit a Clinical Collaboration request. Please select âNoâ here if you would only like to submit a potential diagnosis only. |
| If yes, please outline why | Provide a description of what you would like to gain from this clinical collaboration and what you will contribute to it. Your comments here will be sent directly to the participant's clinician so please ensure you explain your goals clearly. If you are only submitting a potential diagnosis, you can leave this section blank. |
| Do you wish to report a potentially diagnostic variant? | Yes or no. Please select âYesâ if the variant is in a gene with an established gene:disease association and is not apparently known already. This could be checked by reviewing the existing Reported Outcome Questionnaires and the [submitted\_diagnostic\_discovery](../exit_questionnaire/)â¯table. |
| If Tier 1 or 2, why are you reporting the variant(s)? | If you are reporting associations with variants previously prioritised as Tier 1 or 2 variants by the bioinformatics pipeline, please detail any new publications or information that would not have been accessible previously and may help provide new evidence pertaining to the variant you are reporting. |
| What primary clinical feature(s) of the patient does the variant explain? | You should include specific phenotypes from the participant's medical history, listed as HPO terms or ICD10 codes where relevant. |
| Participant ID(s) and variant(s) | A list of participants, genes affected and variants. This should be in a specific format:  `participant ID, gene, chromosome:position:ref:alt` Examples for the correct format are listed as follows: SNV - `7:117530975:G:C` Deletion - `7:117531033:GC:G` Insertion - `7:117595038:T:TTA`  When submitting more than one variant for a single participant, please separate them by a space (please make sure NOT to separate them by a comma, as otherwise any other subsequent variants you are submitting for that participant will not be processed).  When submitting variants for multiple participants, please click on the â+â symbol. This will open a new âfieldâ. Each "field" corresponds to a specific participant. For multiple variants in the same gene for the same participant (e.g. compound heterozygous variants), the variants should be separated by a space in the same field. They should NOT be separated by a comma.   Example of a single variant submission (with fictitious ID and variants): `500000009, CFTR, 7:117530975:G:C`  Example of a multi variant submission (with fictitious ID and variants): `700000004, CFTR, 7:117530975:G:C 7:117595038:T:TTA` |
| Genome build | Please select the genome assembly that the variant details listed above refer to. If you have analysed data using different genome builds, please use a separate submission form for each build. |
| Transcript | We will assume that the transcript you are using to report the variant is the [MANE transcript](https://www.ensembl.org/info/genome/genebuild/mane.html). If you would prefer to report on an alternative transcript, please state the Ensembl ID of the transcript you're using and why. |
| Additional information | Please include any further information you would like to give to the internal reviewing team and any external reviewing bodies. If your findings could lead to an immediate change in the patientâs management, such as a treatable condition or one with a screening programme available, please include this here. You may also include evidence to support the finding, such as links to publications, or comment on any additional phenotyping required to confirm the diagnosis. |

## What happens next?

### Clinical collaboration requests

The Clinical Research Interface team reviews all requests to check they meet with the 100kGP or GMS consent requirements. The clinical and scientific basis for your request is also reviewed and we may contact you with additional questions if there is uncertainty. Collaboration requests are then shared with the participantâs clinical team to invite them to collaborate with you. Please note Genomics England will not directly copy you into correspondence with a clinician without this being agreed by all parties.

For some participants their clinician may no longer be responsible for the clinical care of the participant and it may take longer to identify an appropriate clinician to send the clinical collaboration request to. If you have not heard from the appropriate clinician for two weeks after the invitation was sent, a reminder can be sent upon your request. If you have not had a response after the second reminder and the collaboration is essential for your research, please contact Genomics England through the service desk or by emailing [clinicalcollaboration@genomicsengland.co.uk](mailto:clinicalcollaboration@genomicsengland.co.uk) to discuss appropriate further actions.

### Diagnostic discovery

The Diagnostic Discovery pathway is an approved process by which new putative diagnostic variants identified through research activities can be shared with NHS clinical teams. The pathway is overseen by the Diagnostic Discovery Oversight Group, comprising clinicians and clinical scientists from eachâ¯GLH, and is facilitated byâ¯NHSâ¯England andâ¯Genomics England staff. The aim of the group is to provide assurance to theâ¯NHSâ¯GLHs that the potential diagnoses returned are of high quality and clinical relevance.

New findings that meet the thresholds agreed with NHSE and NHS teams for being potentially diagnostic are returned to NHS GLHs directly by Genomics England on a monthly basis. Variants that do not meet this threshold require further review by the oversight group.

The NHS oversight group meets on alternate months to review variants that do not meet the threshold for direct return and recommend appropriate actions. This can lead to a recommendation to return variants to the GLHs, to contact the participantâs clinician for further information or not return the finding. If variants are approved, they will be returned to the appropriate GLHâ¯for assessment.

If you consider a finding to be potentially urgent, such as clinically actionable cancer variants in an affected living participant, or a clinically actionable variant for a rare disease participant that could guide alternative treatment options or screening pathways, these requests will be assessed more quickly. We would be grateful if you could include any such information in your request.

If your finding has been returned to the relevant GLH, it will be listed in theâ¯`submitted_diagnostic_discovery`â¯table. Any findings returned through the Diagnostic Discovery pathway that have been reported by the GLHs should be visible in an updated Summary of findings or Reported outcomes questionnaire, or will be after the next NGRL data release. Currently, direct feedback to the researcher is not expected for the Diagnostic Discovery pathway.

## Video tutorial

March 12, 2025
