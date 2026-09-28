---
title: 'Jupyter notebooks - combine live code, notes and results - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/jupyter/
scraped_at: 2026-05-04T06:32:53Z
---

# Jupyter notebooks - combine live code, notes and results

Jupyter notebooks can be used in the Research Environments. They need to started up via command line, using the Terminal application.

You can also run [Jupyter Lab on the HPC](../hpc_jupyter/).

> **Note:**
>
> Because Jupyter is always run as Python software (regardless of which kernel you then use in your notebooks, for example the R kernel), which Jupyter you use depends on which Python is in your command-line path; the default Python you get upon opening up the Terminal, and Python 3.6.5, are not good for this, so please use the version of Python from the command-line module python/3.11 - **please do not use the Python 2 kernel, this version of python reached End Of Life on the 31st December 2019**

To use Jupyter Notebooks, please follow the below steps in the Research Environment:

1. Launch Terminal Emulator
2. Run `module load python/3.11`. You will get the message: `python/3.11 has been loaded`
3. In case you need R, load it at this point, too, as usual
4. Run the command `jupyter notebook --port <port_number>`. This will launch the Jupyter UI with the Python 3 kernel available for use.

In case if you get: `PermissionError: [Errno13]Permission denied: /run/user...` error after executing step 4, then please follow the below steps instead:

1. Launch Terminal Emulator
2. Run `unset XDG_RUNTIMR_DIR`
3. proceed from step 2. above

By default Jupyter Lab will run on port 8888, which is the same default port used by a number of other tools such as Jupyter Notebooks and RStudio. You should choose your own port number to ensure access to other tools.

Choose your favourite kernel, and create and run a Jupyter notebook as usual.

The process can be simplified by adding an aliasing function to your .bashrc file.

> **.bashrc functions for Jupyter Notebooks:**
>
> ```
> function jupyter-notebook{
>     module load python/3.11
>     jupyter notebook --port 10001 # Example port
> }
>
> function jupyter-lab{
>     module load python/3.11
>     jupyter-lab --port 11011 # Example port
> }
> ```

Please note that for the above functions, Jupyter Lab may take a few minutes to initiate.

January 31, 2024
