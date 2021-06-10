# zs2021

This dataset accompanies the following research paper: XXX


## Tool settings

* Norma has been used with default settings, except for WLD's train_ngrams=4 (note that input files for Norma's WLD component have to be preprocessed in that initial and final '#' must be added)

## Datasets

* The diatopic dataset consists of texts from the same time period, from different regions.
* The diachronic dataset consists of texts from two time spans (13.2 = 1250-1300, 14.1. = 1300-1350), from mainly two different regions (schwaeb/alem and rip).


Type      | Charter | Time Period | Language Area
----------|---------|------------|---------------
diatopic  | M345 | 14.1 | alem
	  | M347 | 14.1 | alem
	  | M348 | 14.1 | thuer
	  | M350 | 14.1 | rip
	  | M351 | 14.1 | mbair
	  | M352 | 14.1 | rhfrk
	  | M353 | 14.1 | ofrk
----------|---------|------------|---------------
diachronic | M344 | 13.2 | schwaeb 
	   | M346 | 13.2 | alem
   	   | M349 | 13.2 | rip
           | M345 | 14.1 | alem
	   | M347 | 14.1 | alem
	   | M350 | 14.1 | rip


## Directories

* orig_REM: contains the original XML files from REM corpus
* training: contains pairs of <wofo1,wofo2>, where wofo1 is from one variety and wofo2 from another variety, and both normalize to the same standardized form in REM. This is the input for Norma.
* models: contains the replacement rules and WLD mappings learned by Norma. 'E' means the empty string, '#' denotes the word boundary
  1. files *.rules.noident: only contains non-identity rules (i.e. rules like {v->v/#_z} are filtered out); sorted according to their frequency (highest first)
  1. files *.wld.sorted: sorted according their weights (lowest first)
  1. files *.char_align.enriched: these are actually not models but pairs of <wofo1,wofo2> as in training, enriched with character-based alignments
* heatmap: contains the union sets used for calculating similarity scores between individual texts
