## NYC Restaurant Grades 
With the NYC Restaurnt Grades daset, my data warehouse will aim to achieve the following business Requirements 

## Business Requirements

1. Identify NYC high risk areas based on Restaurant Grades 

 The data warehouse will help identify hotspots based on zip codes/ neighborhoods, where restaurants are consistently receiving grades less than an "A". 
 
 This would serve as a guide to NYC health inspectors in where to prioritize inspections and bring community awareness to create efforts around food safety/handling.

2. Analyze common factors influencing inspection grades 

Looking at the data and being able to parse through violation descriptions will give insight to some of the following questions: 

-   What are the most common violations/mistakes restaurants are making?
-   What violations are most associated with with receiving a "C" or "B".

This requirement will mainly focuse on the question, "How do I get my restaurant from a "C" to a "B" to an "A"?" This would be valuable to restaurant owners. 

3. Identify reccurring violations within different cuisine types
    Analyzing different inspection records to see if certain cuisine types have a commonality in specific violations.

This can help different restaurant ownders, food satefy educators, and restaurant consultants improve their operations and reduce the risk of violation. 

## Functional Requirements 

The following functional requirements are needed to help support in identifying high risk areas and analyzing factors that influence inspection grades: 

1. Aggregate grades by Location 
    The data warehouse would allow users to query inpsection grades by zip code and their neighborhoods to see which areas are considered high risk for grades less than an "A". 

2. Parse and Categorize Violations 
    The data warehouse must be able to extract and categorize violation descriptions to be able to identify all violations and then categorize to their most common violations across the city. 

3. Correlation from violation to grade 
    The data warehouse mst be able to correlate which specific violations are associated with receiving grades below and "A". 

4. Violation commonalities within specific cuisine types 
    The data warehouse must be able to analyze violations by cuisine type and be able to recognize whether there is a pattern within a specific cuisine type.
   
## Data Requirements 
#   Source: 

I will be using the [NYC Open Data: Restaurant Grades dataset](https://data.cityofnewyork.us/Health/Restaurant-Grades/gra9-xbjk/data_preview), which is based on the Department of Health and Mental Hygiene (DOHMH). Each row in the dataset represents a restaurant inspection done by the NYC Department of Health. 

The key fields I will be focusing on in my warehouse will be: 

- DBA (Restaurant Name)
- Cuisine Description 
- Boro
- Zipcode 
- Violation Code 
- Violation Description 
- Grade 
- Score 

## Data Sourcing 
Web API sourcing can be found in data folder under the data_dictionary.ipynb file along with a word document with further details of the data dictionary sourced from the [NYC Open Data: Restaurant Grades dataset](https://data.cityofnewyork.us/Health/Restaurant-Grades/gra9-xbjk/data_preview). 
## Information Architecture 

## Data Architecture 

## Dimensional Modeling
