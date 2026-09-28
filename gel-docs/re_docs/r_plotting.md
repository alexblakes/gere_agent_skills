---
title: 'Plotting in R on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/r_plotting/
scraped_at: 2026-05-04T06:33:27Z
---

# Plotting in R on the HPC

When R is run on the HPC as a module, it will not be able to output plots due to the absence of a Graphical User Interface within the HPC. You might see errors such as: `Unable to start device PNG` or `Unable to open connection to X11 display`.

This can be solved by using an X Virtual Frame Buffer to run R in. The below is an example of how to do this:

```
module load R/<version>
xvfb-run -a R
```

If, however, you do not want to write `xvfb-run R` each time, then you can set up an alias in your `.bashrc` file that will do this for you. Add the following line to your `.bashrc` file:

```
alias R='xvfb-run -a R'
```

Within your R script there are a number of possible ways of saving plots. The following example uses base R:

```
png("plot.png")
plot(1)
dev.off()
```

This will create a `.png` file called plot.png in the current working directory with your data plotted.

Alternatively, the tidyverse ggplot2 package can be used to save the plots to a variable which can be saved with the built-in ggsave() function. You should be able to save the generated plots bypassing the need to display them by using commands such as the following example within your RSCRIPT:

```
library(ggplot2)
fig_1 <- ggplot(cars, aes(x = speed, y = dist)) + geom_point()
ggsave(fig_1, type = "cairo", file="fig_1.<extension>")
```

Note that tidyverse and base R can at times interfere with each other so we would recommend selecting one strategy for your plotting needs.

If you will always be loading the same version of R you will be able to create a bash function that will help you access the the functionality with a single command:

```
function r_headless(){
module purge
module load lang/R/<version>
xvfb-run -a Rscript $1
}
```

The function can then be called on an R script as follows:

```
r_headless script.R
```

We would recommend that you save the function to your `.bashrc` file so that the function is globally available.

April 30, 2024
