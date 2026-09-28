---
title: 'Job dependencies - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_dependencies/
scraped_at: 2026-05-04T06:32:33Z
---

# Job dependencies

Sometimes, whether a job should start depends on the result of another job. To submit a job that depends on another job:

1. use the `-w` option to bsub (it is lowercase w)
2. Select dependency expression
3. select dependency condition

**Example 1:**

```
bsub -q medium -R "rusage [mem=1000] span[hosts=1]" -J"dependent-1" -o ~/job.output myjob  
Job <9773> is submitted to queue <medium>

bsub -q medium -R ârusage [mem=1000] span[hosts=1â âJâdependent-2â-o ~/job.output -w 'done("dependent-1")' myjob
Job <9774> is submitted to queue <medium>

bsub -q medium -R ârusage [mem=1000] span[hosts=1]â -o ~/job.output -w 'ended(9773)' myjob
Job <9775> is submitted to queue <medium>
```

**Example 2:**

```
bsub -J "dependency_1" -q medium -R ârusage [mem=1000] span[hosts=1â -o ~/lsf.output myjob
Job <9776> is submitted to queue <medium>

bsub -J "dependency_2" -q medium -R ârusage [mem=1000] span[hosts=1â -o ~/output -w 'exit("dependent_1")&&post_done("dependency_2")' myjob
Job <9777> is submitted to queue <medium>

bsub -J "dependent_3" -q medium -R ârusage [mem=1000] span[hosts=1â -o ~/lsf.output myjob
Job <9778> is submitted to queue <medium>

bsub -J "dependency_4" -q medium -R ârusage [mem=1000] span[hosts=1]â -o ~/lsf.output -w 'exit("dependent_3")||post_done("dependent_3")' myjob
```

July 12, 2024
