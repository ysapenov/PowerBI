# Engineering Management with Data‑Driven Delivery

## Project Overview

* Over 20 teams contributed across multiple engineering sub‑projects.
* Hierarchy of work items: **Epic → Capability → Feature → Story**.
* All activities and work items tracked in **Azure DevOps**.
* **Power BI** reports built on top of the Azure DevOps data to monitor project progress and engineering performance metrics, including QE and Risks.

## Data Sources & Integration

* **Primary source:** Azure DevOps Analytics database
* **Access methods**

  * **OData** connections for structured, tabular entities.
  * **Azure DevOps REST API** for retrieving specific or complex datasets not available through OData.

## Architecture

1. **Extraction**

   * Scheduled OData queries and REST calls pull raw work‑item snapshots.
2. **Transformation**

   * Power BI Dataflows reshape data, flatten hierarchies, and add date dimensions.
3. **Loading**

   * Cleaned data model loaded into a Power BI semantic model.
4. **Reporting**

   * Interactive dashboards with row‑level security and drill‑through.

## Key Dashboards & Metrics

| Dashboard           | Highlights                                  |
| ------------------- | ------------------------------------------- |
| Delivery Pulse      | Burn‑up, sprint velocity, cycle time        |
| Quality Engineering | Defect density, automated test coverage     |
| Risk Radar          | Overdue items, blocker age, high‑risk Epics |