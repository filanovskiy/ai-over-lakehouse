# PeakGear: from raw sources to governed answers with Codex

Estimated Time: 75 minutes, plus a 15-minute troubleshooting buffer.

This is a seven-lab Oracle LiveLabs workshop package. Participants begin as
`ADMIN`, prepare a safe PeakGear participant schema, connect real Iceberg and
Operations data, and then use Codex with Oracle Data Studio MCP. The same
business question becomes more useful as its governed context improves.

## Start here

* Learner entry: `workshops/sandbox/index.html`.
* Agenda and prerequisites: [workshop-details.md](workshop-details.md).
* TLF submission metadata and agent handoff: [tlf-workshop-submission-handoff.md](tlf-workshop-submission-handoff.md).
* Release checks and runtime gates: [author-review.md](author-review.md).
* Screenshot capture and provenance: [traceability.md](traceability.md).
* Instructor SQL: [scripts/00-admin-setup.sql](scripts/00-admin-setup.sql).
* Participant Codex package: [starter-kit](starter-kit/).

The participant performs the `ADMIN` setup in Lab 1. The default AI profile
is preconfigured for the lab: participants do not create, change, or validate
an AI profile.

## Local preview

Run the server **from the workshop directory**, not from your home directory:

```sh
cd /path/to/ai-over-lakehouse
python3 -m http.server 8000
```

Then open `http://localhost:8000/workshops/sandbox/`. A `404` at that URL
means the server was started from the wrong directory. The standard LiveLabs
loader requires internet access. Stop the server with Control-C.

## Publication boundary

Do not commit passwords, SAS tokens, OAuth client secrets, private URLs, or
screenshots that expose tenant identifiers without review. The workshop needs
a private participant handout for lab-only credentials and the assigned
database URL.

## Status

Workshop structure and learner flow are drafted. Runtime acceptance and the
UI screenshot set remain release gates recorded in `author-review.md`.

## Acknowledgements

* **Author** - Oracle AI Lakehouse workshop team
* **Last Updated By/Date** - Oracle AI Lakehouse workshop team, September 2026
