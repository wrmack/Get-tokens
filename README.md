#  Get tokens

Experimenting using the Solid platform in iOS.  Success is when the app retrieves an access token, id token and refresh token after authenticating with a provider.

The tokenrequest contains a key for exchange with a proof-of-possession (PoP) confirmation.  Solid-server does not yet have the functionality to load the confirmation into its internal request object.  An issues has been raised.

## Use case
### Authenticate with provider
User enters their provider's uri such as https://username.inrupt.net

The process of discoverying the provider's configuration, registering the client, getting an authorization grant and exchanging that for tokens, is displayed.





