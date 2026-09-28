---
title: 'VSCode - scripting with syntax highlighting - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/vscode/
scraped_at: 2026-05-04T06:34:15Z
---

# VSCode - scripting with syntax highlighting

VSCode is available in the RE for scripting. A number of extensions can be installed to aid with your writing.

The latest version of VSCode can be accessed from the desktop.

This base level install of VSCode will allow you to edit your code with syntax highlighting for a number of scripting languages (including R, Bash and Python), as well as providing you with access to an integrated terminal. More advanced features, such as debugging, will require the use of extensions.

## Installing VSCode Extensions

As the Research Environment is a secure environment we are not able to provide direct access to the VSCode marketplace; a curated set of compatible extensions has been compiled and make available to you at the following location:

`~/public_data_resources/vscode_extensions/vsix`

To install extensions:

1. Navigate to the Marketplace section of the editor, while the Marketplace itself is not whitelisted this will provide you with the path for installation
2. Find and open the "Views and More Actions" menu to access the expanded installation options
3. Select the "Install from VSIX ..." option from the resulting dropdown menu to be able to navigate to the internal extensions repository, the path you will need to navigate to will be `~/public_data_resources/vscode_extensions/vsix/`
4. Once you have opened up the repository, select the required extension and click on install to complete the process
5. Once the install is complete you will be able to see the extension in the list of included extensions which can be activated as needed

These steps will need to be repeated for each extension.

The repository is currently being populated with a default set of extensions to improve usability of the tool.

Should any additional extensions be needed please raise a Service Desk software request ticket for these

## Python development in VSCode

You will need to set the interpreter needed for your script. To do this it is best to use the CTRL + Shift + P keyboard shortcut combination to bring up VSCode's command panel.

Once visible you can se the interpreter with the command shown on the following screenshot:

You will then be able to enter or navigate to the path of the version of python that you need:

A python debugger is included in the MS Python extension

September 29, 2025
