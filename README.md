#  Get tokens

Experimenting using the Solid platform in iOS.  Success is when the app retrieves an access token, id token and refresh token after authenticating with a provider.

The token request contains a key for exchange with a proof-of-possession (PoP) confirmation.  Native apps use the authorization code flow (as compared to browsers, which use the implicit flow).  In the authorization code flow, tokens are requested from the token endpoint.  For token endpoint requests, solid-server does not yet have the functionality to load the confirmation into its internal request object.  An [issue](https://github.com/solid/oidc-op/issues/15#issue-407032755) has been raised. 

## Use case
### Authenticate with provider
User enters their provider's uri.  Both of these worked:  `https://username.inrupt.net`, `https://inrupt.net`

The process of discoverying the provider's configuration, registering the client, getting an authorization grant and exchanging that for tokens, is displayed.  Detailed information is printed to the console.


## Caveats
The key motivation is to simply share my own efforts with integrating Solid and iOS in order to give a leg-up to any other iOS developers.  

This is my [debugging setup](https://github.com/wrmack/Get-tokens/blob/master/Debugging%20setup.md).

The app has not been rigorously tested and does not have unit tests.




