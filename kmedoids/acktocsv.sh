#!/usr/bin/bash
 ack --ignore-file=ext:csv --ignore-file=ext:sh ARI -C 1 | perl -pe 's#^.*?/##g'| perl -pe 's/\s+.Txt//g'| perl -pe 's/(:|-)\d(:|-)//g' | perl -pe 's/^--\n//g' | sed '/ARI/d'| perl -pe 's/Distance/Distance,/g'| perl -pe 's/(\d\.\d+)/$1,/g' | perl -pe 's/,(?=$)//g' > complete.csv

