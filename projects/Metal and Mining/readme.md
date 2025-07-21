# Plant Operations Power BI Reports

## Scope & Purpose

These dashboards provide a consolidated view of key technical metrics for three production business units at the country’s leading metal‑and‑mining company.  
They are designed for plant engineers, reliability teams, and management to monitor performance.

## Folder / File Structure

| Folder / File         | Contents                                                         |
| --------------------- | ---------------------------------------------------------------- |
| `SKZ`                 | Dashboards specific to the SKZ unit                              |
| `ZPDM`                | Dashboards specific to the ZPDM unit                             |
| `UKMK`                | Dashboards specific to the UKMK unit                             |
| `Small Elements`      | Focused views on the special project                             |
| `Others`              | Additional plant‑level reports that do not belong to a single BU |

## Data Coverage

* **Technical focus:** All reports center on operational health; *financial views are intentionally excluded*.
* **Core metrics:** pressure, temperature, and other performance and sensor‑based KPIs.

## Data Source & Refresh

* Source: **On‑premise SQL Server** connected via the on‑premises data gateway.
* Refresh cadence: configurable; default hourly for sensor‑heavy pages.
