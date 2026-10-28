# Context

This is the TechStyle team repository for the TBZ HF DevOps project. It adopted the Day 13 reference implementation and adds the Day 14 AWS deployment. Earlier course artifacts are inherited; do not present their existence as proof of completed team exercises.

**Purpose**  
Keep the current application and AWS delivery path understandable and maintainable. README.md is the entry point, DEPLOYMENT.md is the current operations guide, and docs/PROJECT_AUDIT_DAYS_01_12.md records earlier project requirements and missing evidence.

**Key Characteristics**
- Real-world Flask eCommerce application
- Iterative development and testing workflow
- Clear separation of concerns (frontend, backend, data layers)
- CI/CD pipeline integration ready
- Deployment automation examples included

**Target Audience**  
Students completing the DevOps & Infrastructure module block at TBZ.

**Important Notes**
- Run the app-health-check-agent after each change to verify application health
- When updating a solution branch, propagate changes to the corresponding checkpoint branch
- Preserve honest evidence: do not invent workflow runs, measurements, completed retrospectives or cloud resources.
- Historical deployment examples live under docs/archive/ and must not be reactivated as part of routine cleanup.
