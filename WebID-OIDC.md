#  OpenID Connect
**OpenID Connect**: builds on top of OAuth2

**OAuth2**:  authorises access by granting an access token

**OpenID Connect**:  authenticates the user

## OAuth2

[https://tools.ietf.org/html/rfc6749](https://tools.ietf.org/html/rfc6749)

```
+--------+                               +---------------+
|        |--(A)- Authorization Request ->|   Resource    |
|        |                               |     Owner     |
|        |<-(B)-- Authorization Grant ---|               |
|        |                               +---------------+
|        |
|        |                               +---------------+
|        |--(C)-- Authorization Grant -->| Authorization |
| Client |                               |     Server    |
|        |<-(D)----- Access Token -------|               |
|        |                               +---------------+ 
|        |
|        |                               +---------------+
|        |--(E)----- Access Token ------>|    Resource   |
|        |                               |     Server    |
|        |<-(F)--- Protected Resource ---|               |
+--------+                               +---------------+

```
Where Authorization Grant is one of: authorization code, implicit, resource owner password credentials, client credentials.

## OpenId Connect
[https://openid.net/specs/openid-connect-core-1_0.html](https://openid.net/specs/openid-connect-core-1_0.html)

The primary extension that OpenID Connect makes to OAuth 2.0 to enable End-Users to be Authenticated is the ID Token data structure.

The OpenID Connect protocol, in abstract, follows the following steps.

1. The RP (Client) sends a request to the OpenID Provider (OP).
2. The OP authenticates the End-User and obtains authorization.
3. The OP responds with an ID Token and usually an Access Token.
4. The RP can send a request with the Access Token to the UserInfo Endpoint.
5. The UserInfo Endpoint returns Claims about the End-User.

These steps are illustrated in the following diagram:

```
+--------+                                   +--------+
|        |                                   |        |
|        |---------(1) AuthN Request-------->|        |
|        |                                   |        |
|        |  +--------+                       |        |
|        |  |        |                       |        |
|        |  |  End-  |<--(2) AuthN & AuthZ-->|        |
|        |  |  User  |                       |        |
|   RP   |  |        |                       |   OP   |
|        |  +--------+                       |        |
|        |                                   |        |
|        |<--------(3) AuthN Response--------|        |
|        |                                   |        |
|        |---------(4) UserInfo Request----->|        |
|        |                                   |        |
|        |<--------(5) UserInfo Response-----|        |
|        |                                   |        |
+--------+                                   +--------+

```

The Authorization Code Flow goes through the following steps.

1. (A registered) Client prepares an Authentication Request containing the desired request parameters.
2. Client sends the request to the Authorization Server.
3. Authorization Server Authenticates the End-User.
4. Authorization Server obtains End-User Consent/Authorization.
5. Authorization Server sends the End-User back to the Client with an Authorization Code.
6. Client requests a response using the Authorization Code at the Token Endpoint.
7. Client receives a response that contains an ID Token and Access Token in the response body.
8. Client validates the ID token and retrieves the End-User's Subject Identifier


## SOLID summary

[https://github.com/solid/webid-oidc-spec](https://github.com/solid/webid-oidc-spec)

The WebID-OIDC protocol specifies a mechanism for getting a WebID URI from an OIDC ID Token.

1.  Initial Request: Alice (unauthenticated) makes a request to bob.com, receives an HTTP 401 Unauthorized response, and is presented with a 'Sign In With...' screen.
2.  Provider Selection: She selects her WebID service provider by clicking on a logo, typing in a URI (for example, alice.solidtest.space), or entering her email.
3.  Local Authentication: Alice gets redirected towards her service provider's own Sign In page, https://alice.solidtest.space/signin, and authenticates using her preferred method (password, WebID-TLS certificate, FIDO 2 / WebAuthn device, etc).
4.  User Consent: (Optional) She'd also be presented with a user consent screen, along the lines of "Do you wish to sign in to bob.com?".
5.  Authentication Response: She then gets redirected back towards https://bob.com/resource1 (the resource she was originally trying to request). The server, bob.com, also receives a signed ID Token from alice.solidtest.space, attesting that she has signed in.
6.  Deriving a WebID URI: bob.com (the server controlling the resource) validates the ID Token, and extracts Alice's WebID URI from inside it. She is now signed in to bob.com as user https://alice.solidtest.space/#i.
7.  WebID Provider Confirmation: bob.com confirms that solidtest.space is indeed Alice's authorized OIDC provider (by matching the provider URI from the iss claim with Alice's WebID).
