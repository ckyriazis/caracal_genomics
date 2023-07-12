#!/bin/bash

. /u/local/Modules/default/init/modules.sh
module load R/3.4.4

Rscript ConvertToGDS.Hoffman.R
