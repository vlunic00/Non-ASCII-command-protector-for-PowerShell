# PowerShell ASCII Guard

A lightweight security script for the Windows Terminal (PowerShell) that prevents the execution of commands containing non-ASCII characters.  
With the increased use of AI agents and AI suggestions for terminal execution, the danger of executing malicious commands is as high as ever.

##  Why use this?

This script protects your terminal from:
* **Homograph Attacks:** Malicious commands using characters that look like standard Latin letters (e.g., using a Cyrillic `а` instead of a Latin `a`).
* **Copy-Paste Errors:** Accidental execution of "Smart Quotes" or hidden formatting characters from web browsers or Word documents that can cause syntax errors.
* **Encoding Issues:** Preventing the execution of corrupted strings that might lead to unexpected behavior in scripts.

##  How It Works

The script hooks into the **PSReadLine** module, which handles keyboard input in PowerShell. 

1. It intercepts the `Enter` key.
2. It runs a Regular Expression (Regex) check: `[^\x00-\x7F]`.
3. If a character outside the standard 128-character ASCII set is detected, it blocks the command, clears the input buffer to prevent "ghosting" text, and alerts the user.



##  Installation

### 1. Locate your Profile
Open PowerShell and type the following to open your profile script in Notepad:
```powershell
notepad $PROFILE
```
Paste the code from PS hook.ps1 into the file and save it.  
If you haven't enabled local scripts on your machine yet, run this command as an Administrator:  
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```  
Restart your terminal.  
   
## Testing
Run the following:
```powershell
echo Hello
```
```powershell
echo Привет
```