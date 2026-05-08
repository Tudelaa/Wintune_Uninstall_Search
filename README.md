# Wintune_Uninstall_Search

Sometimes, when I am publishing a new Windows App in Microsoft Intune, I need to know the exactly detection rule if i am using MSI package or if I need create a rule to Uninstall the package. These values are in the regedit and my memory is bad... :(

For this reason, I created this simple PowerShell script designed to search for an application in registry and return the uninstall string for both 64 and 32 bits.

# How it works

If you run the PowerShell script, you will see a graphical interface where you can put the name of the software you want to uninstall:

<img width="423" height="192" alt="image" src="https://github.com/user-attachments/assets/9db7ee03-dd66-4710-8a84-a2fe2070d788" />

In the example, I want to search zscaler:

<img width="423" height="192" alt="image" src="https://github.com/user-attachments/assets/7394e474-9979-4f7b-9d9b-978dc3053237" />

in a few seconds, the key will be provided:

<img width="1390" height="187" alt="image" src="https://github.com/user-attachments/assets/1e011f35-f8dc-4b28-a1d9-5c46ccc34cc8" />




