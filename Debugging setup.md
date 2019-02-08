#  Debugging setup
How to setup a system for debugging the interaction of the app with solid server running on a Mac OS computer on the same network.

## Identify network name of computer
On computer, go to Settings - Sharing

Look for line which states computers  on the local network can access your computer.

The network name of your computer will be similar to:

`xxxxxxxx.local`

## Create certificate and keys
In order to interact over the network using https, keys are needed for solid server and a certificate is needed for each device you run your app on.

Follow the instructions here:
[Apple instructions](https://developer.apple.com/library/archive/technotes/tn2326/_index.html#//apple_ref/doc/uid/DTS40014136)

Ensure the dNS name is the network name you identified above.

You will end up exporting: a root certificate (.cer file), server.crt (containing the public key) and server.key (the private key).

## Setup solid server
npm must be installed - I used Homebrew.

Create directory and cd to it.

Install solid server locally.

`npm install solid-server`

Run {path to solid-server}/solid init

For example:
`/Users/{your home directory}/{path to directory you created}/node_modules/solid-server/bin/solid init`

You will be prompted for configuration settings.

For the server uri enter `https://{your network name}.local:8443`

Respond Y to multi-user mode.

Enter the full paths to your keys.

## Edit /etc/hosts
Your /etc/hosts file should include the following entries.  This file simply maps ip addresses to user-friendly names.  The * is a wildcard to allow sub-domains such as: `{username}.{your network name}.local`

```
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost
127.0.0.1       *{your network name}.local
```
For example use nano to edit it:
`sudo nano /etc/hosts`

A user that you register with solid-server has to be added as a subdomain:

```
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost
127.0.0.1       *{your network name}.local
127.0.0.1       {username}.{your network name}.local			
```

## Setup your device
Email the root certificate (*.cer) as an attachment

On device open the email and open the attachment.  In a simulator I used Safari for opening Gmail and then the email with the .cer attachment.

Install it.

Go to General - About - Certificate Trust Settings and enable trust for this certificate.

## Setup Visual Studio Code
In Visual Studio Code open the top level folder for the server. 

In VSC's terminal view, cd to the top level folder.

Run solid-server.

For example:
`/Users/{your home directory}/{path to directory you created}/node_modules/solid-server/bin/solid start`

In VSC go to: 
`View - Command Pallette...`

Then: 
`Debug: Attach to node process`

Select the process for solid-server.

You will now be able to debug interaction between the app and solid-server, for example by using breakpoints.

## Using a browser
As a separate exercise, simply use web inspector in Safari to view network requests and responses for the solid-auth-client.   The login popup makes this difficult so use the solid-auth-client demo app (as described on its README page)


