# FindCounterparts
Small PowerShell and batch project to copy jpg file counterparts after picking raw, cr3 or other.

## Usage
Once installed you'll get a new right click action in the "Send to" menu called "Trouver les jpg".
Right click on 1 or more images that you pick in whatever format (except jpg of course) and send them to the app.
Select the folder where your jpg are and it will copy them automagically to your handpicked folder.

- File must be named exactly the same as the original
- File extensions can be jpg or jpeg and are not case sensitive
- The files are copied, not moved
- The app is not recursive

## Building
You'll need Inno Setup Compiler to build this mini app.

In the Find-Counterparts.ps1 file you can edit the line 25 to find other extensions.
