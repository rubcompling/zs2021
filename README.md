# zs2021

This dataset accompanies the following research paper: 

Sandra Waldenberger, Stefanie Dipper, and Ilka Lemke (2021). Towards a broad-coverage graphemic
analysis of large historical corpora. *Zeitschrift für Sprachwissenschaft*, Special Issue, 40(3), pp. 401–420. [PDF](https://doi.org/10.1515/zfs-2021-2037)

## Tool settings

* Norma has been used with default settings, except for WLD's train_ngrams=4 (note that input files for Norma's WLD component have to be preprocessed in that initial and final '#' must be added).

## Datasets

* The diatopic dataset consists of texts (charters) from the same time period, from different regions.
* The diachronic dataset consists of texts from two time spans (13.2 = 1250-1300, 14.1. = 1300-1350), from mainly two different regions (schwaeb/alem and rip).


Type      | Text | Time Period | Language Area
----------|---------|------------|---------------
diatopic  | M345 | 14.1 | alem
&nbsp; 	  | M347 | 14.1 | alem
&nbsp; 	  | M348 | 14.1 | thuer
&nbsp; 	  | M350 | 14.1 | rip
&nbsp;	  | M351 | 14.1 | mbair
&nbsp;	  | M352 | 14.1 | rhfrk
&nbsp;	  | M353 | 14.1 | ofrk
diachronic | M344 | 13.2 | schwaeb 
&nbsp;	   | M346 | 13.2 | alem
&nbsp;	   | M349 | 13.2 | rip
&nbsp;     | M345 | 14.1 | alem
&nbsp;	   | M347 | 14.1 | alem
&nbsp;	   | M350 | 14.1 | rip


### Directories

* orig_REM: contains the original XML files from the REM corpus
* training: contains pairs of <wofo1,wofo2>, where wofo1 is from one variety and wofo2 from another variety, and both normalize to the same standardized form in REM. This is the input for Norma.
* models: contains the replacement rules and WLD mappings learned by Norma. 'E' means the empty string, '#' denotes the word boundary
  1. files *.rules.noident: only contains non-identity rules (i.e. rules like {v->v/#_z} are filtered out); sorted according to their frequency (highest first)
  1. files *.wld.sorted: sorted according their weights (lowest first)
  1. files *.char_align.enriched: these are actually not models but pairs of <wofo1,wofo2> as in training, enriched with character-based alignments
* similarity: contains the union sets used for calculating similarity scores between individual texts


## Scripts

* similarity.R: calculates pairwise similarity between texts

## Acknowledgements

The development of this software was supported by Deutsche Forschungsgemeinschaft (DFG), Grants Nos. 1558/1, 1558/4 and 1558/5 (project IDs 89085660, 179943363, 200609649).

## License

All software (in the datasets/ and scripts/ directories) is provided under CC BY 4.0.

The original REM data is licensed under CC BY-SA 4.0 and provided by Klein et al. (2016).

Klein, Thomas; Wegera, Klaus-Peter; Dipper, Stefanie; Wich-Reif, Claudia (2016). Referenzkorpus Mittelhochdeutsch (1050–1350), Version 1.0, https://www.linguistics.ruhr-uni-bochum.de/rem/. ISLRN 332-536-136-099-5.

For questions or problems, feel free to file a GitHub issue, or contact me directly:

    Stefanie Dipper (stefanie.dipper@rub.de)

