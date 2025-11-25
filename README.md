# Social Mobility in Hungary (1780-2020): A Long-Term Analysis

This repository contains the code and data for a comprehensive study of social mobility patterns in Hungary spanning from 1780 to 2020, covering multiple political regimes and social transformations.

## Project Overview

This research analyzes social mobility trends across Hungarian elite groups using surname-based analysis techniques. The study tracks the representation of different social groups (nobility, ethnic minorities, common surnames) in various professional elites over a 240-year period, providing insights into how political regimes and institutional changes affected social mobility.

### Key Research Questions

- How did social mobility patterns change across different Hungarian political regimes?
- What was the impact of major historical events (1848 Revolution, WWI, WWII, Communist era, Democratic transition) on elite recruitment?
- How did different professional elites (doctors, lawyers, business leaders, politicians, military officers) exhibit varying patterns of social openness?

## Data Sources

The analysis draws from multiple historical datasets:

- **Medical professionals**: Historical records from Semmelweis University (1746-1991) and modern doctor registries
- **Legal professionals**: ELTE University law school alumni records (1849+)
- **Political representatives**: Historical records of Hungarian Parliament members
- **Military officers**: Army personnel records
- **Business elites**: Corporate leadership data from OPTEN and Compass databases
- **Population controls**: Census and demographic data for baseline comparisons

## Methodology

### Surname-Based Analysis
The study employs surname analysis to identify social group membership:

- **Noble surnames**: Names ending in "-y" (traditional nobility markers)
- **Top 20 surnames**: Most common Hungarian family names (representing general population)
- **Ethnic surnames**: German, Slavic, Romanian, and Jewish name patterns
- **Roma surnames**: Names associated with Romani communities

### Key Metrics
- **Relative Representation (RR)**: Ratio of group representation in elite vs. population
- **Log Relative Representation**: Logarithmic transformation for trend analysis
- **Decade averages**: Smoothed time series analysis

## Repository Structure

```
├── code/                           # Analysis scripts
│   ├── _do_everything.do          # Master script that runs all analyses
│   ├── set_directories.do         # Path configurations
│   ├── clean_*.do                 # Data cleaning scripts for each elite group
│   ├── calc_representation_*.do   # Calculate representation metrics
│   ├── figure_main_long.do        # Generate main visualization
│   └── misc/                      # Additional analysis scripts
├── data/                          # Processed datasets
│   ├── processed/                 # Clean, analysis-ready data
│   └── raw/                       # Original source data
├── figures/                       # Generated plots and visualizations
├── tables/                        # Regression results and summary statistics
└── README.md                      # This file
```

## Key Findings

### Historical Periods Analyzed

1. **Habsburg Empire** (1780-1867): Traditional aristocratic dominance
2. **Austria-Hungary** (1867-1919): Gradual liberalization and ethnic diversity
3. **Horthy Regime** (1920-1944): Conservative restoration and growing restrictions
4. **Communist Era** (1945-1989): Radical social restructuring
5. **Third Republic** (1989-2020): Democratic transition and market economy

### Main Results

- **Noble representation** declined significantly across all elites over the study period
- **Medical and legal professions** showed earlier democratization than political and business elites
- **Communist period** represented the most dramatic break in traditional elite reproduction patterns
- **Post-1989 transition** saw partial return of traditional patterns in some sectors

## Visualizations

The main results are presented in several key figures:

- `habil_ynames_en.pdf/png`: Noble surname representation trends (main results)
- `habil_top20_en.pdf/png`: Common surname representation trends
- Timeline plots showing institutional changes and their impact on mobility

## Running the Analysis

### Prerequisites
- Stata (version 14 or higher)
- Access to raw data files (paths configured in `set_directories.do`)

### Execution
```stata
cd "path/to/project/code"
do _do_everything.do
```

This master script will:
1. Clean all raw datasets
2. Calculate representation metrics
3. Generate main figures and tables
4. Perform statistical analyses

## Technical Details

### Data Processing Pipeline
1. **Raw data ingestion** from historical sources
2. **Name standardization** and surname extraction
3. **Social group classification** based on surname patterns
4. **Temporal aggregation** into decades and periods
5. **Relative representation calculation** vs. population baselines
6. **Statistical smoothing** and trend analysis

### Key Variables
- `relative_rep_noble_*`: Noble representation in each elite group
- `relative_rep_top20_*`: Common surname representation
- `*_share_in_*`: Raw percentage shares
- `y10`: Decade indicators for temporal analysis

## Statistical Analysis

The project includes regression analyses examining the relationship between:
- Institutional quality measures (V-Dem democracy indicators)
- Political regime characteristics
- Social mobility patterns

Results are presented in LaTeX tables in the `tables/` directory.

## Institutional Context

The analysis incorporates major institutional changes:
- **1848**: Liberal reforms and constitutional monarchy
- **1867**: Austro-Hungarian Compromise
- **1919**: End of monarchy, establishment of republic
- **1944**: German occupation and Arrow Cross regime
- **1948**: Communist takeover
- **1989**: Democratic transition

## Data Availability

Raw data files are stored in the referenced directory structure. Processed datasets are available in the `data/` folder. Due to privacy considerations, some individual-level data may be restricted.

## Citation

If you use this data or code in your research, please cite:

[Citation information to be added upon publication]

## Contact

**Attila Gáspár**  
[Contact information]

## Acknowledgments

This research builds on collaborative work with multiple data contributors and institutions. Special thanks to:
- Hungarian Society for Family History Research (MACSE)
- Semmelweis University Archives
- ELTE University Alumni Records
- Hungarian National Archives
- Arcanum
- Research collaborators and data collection teams

## License

[License information to be specified]

---

*Last updated: November 2025*