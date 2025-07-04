# Solar–Heat Misalignment Diagnostic (India)

This is a state-level diagnostic tool assessing the alignment between heatwave exposure and solar infrastructure rollout across 19 Indian states. It uses public datasets to generate a Gap Score — a simple metric of misalignment — and classifies states into exposure-capacity typologies.

## Project Summary

- **Timespan:** 2000–2023 (heatwave exposure), 2017–2023 (solar capacity)
- **Method:** Scoring logic using ranked quintiles and infrastructure-risk Gap Scores
- **Frameworks Referenced:** ISO 14097, TCFD, SEforALL
- **Tools Used:** R (scoring logic, data cleaning, visualisation)

This diagnostic is built to replicate the logic of sustainability frameworks by surfacing physical risk misalignment at the sub-national level. It informs infrastructure planning, policy analysis, and investor-aligned screening.

## Files

- `diagnostic.R` – Cleaned and annotated R script
- `solar_heat_gap_scores.csv` – Main cleaned dataset (optional if not public)
- `heatmap_plot.png` – Output visualisation (optional)

## Usage

This script is standalone. You can run it with any updated heatwave and solar capacity data structured in the same format. Outputs include ranked scores, typologies, and basic visuals for presentation.

## Notes

- Based on data from Indian Meteorological Department and Ministry of New and Renewable Energy  
- This is an independent CapCorPro project by Sonya, developed as a portfolio demonstration

## License

MIT License — open for reuse with credit.
