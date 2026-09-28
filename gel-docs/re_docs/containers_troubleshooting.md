---
title: 'Troubleshooting with containers - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/containers_troubleshooting/
scraped_at: 2026-05-04T06:31:52Z
---

# Troubleshooting with containers

When working with containers, there are multiple potential sources of problems:

1. Interacting with the Genomics England HPC
2. Singularity
3. The container
4. The software within the container

Tracing the source of the error may require cross-referencing between the documentation for all these sources. Here, we will point you towards where you might look for information about different types of errors.

FATAL error on `pull`, `Unable to get library client`

When trying to pull a container, I received an error:

`FATAL: Unable to get library client configuration: unable to get library service URI: error making request to server:`

---

Â You need to modify the path to the container to include the [artifactory re-routing](../containers_step_by_step/#4-pull-the-container).

Genomics England use artifactory re-routing to allow containers to be pulled into the RE, but not be pushed out.

FATAL error on `pull`, `failed to get manifest`

When trying to pull a container, I received an error:

`FATAL: While pulling image from oci registry: error fetching image to cache: failed to get manifest for quay.io/nonexistent/repo`

---

Â Singularity cannot find a container with that name in the repository. Check that you have spelled the path correctly and that the container is not private.

FATAL error on `exec`

When trying to execute a container, I received an error:

`FATAL: While checking image: could not open image /path/to/your/working/folder/container.sif: failed to retrieve path for /path/to/your/working/folder/container.sif: lstat /path/to/your/working/folder/container.sif: no such file or directory`

---

Â Singularity cannot find a container with that name. Check that you have pulled it correctly, and that you have spelled the path and filename correctly in your `exec` command.

August 15, 2024
