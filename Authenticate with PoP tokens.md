#  Authenticate with Proof-of-Possession
When we present our access token to the protected resource server ('recipient') we prove that we are in possession of a key that was issued by the providers authorization server.

## Step 1
### Get our provider's configuration
(No change)

Firstly we need to get our provider's configuration so we know what 'end-points' to use when we register our client and later when we request authorization and request a token.
We have our provider's url from the textfield.  Providers keep their OIDC configuration at ".well-known/openid-configuration".

Using the provider's url and the path for the open-id configuration, we send an URLRequest to this endpoint.  The data that is received in the response contains a lot of info but our interest is in the values for the following:

* registration_endpoint
* authorization_endpoint
* token_endpoint
* issuer

This is stored in the ServiceProviderConfiguration class.

## Step 2
### Register our client app using our provider's registration end-point.
(No change)

We create an URLRequest as follows:

* its url is the registration end-point from the configuration obtained above
* it uses the http POST method
* content-type is application/json
* its http body includes the app's redirect uri 

The data that is returned in the response includes:

* client_id 
* client_secret (possibly)
* redirect_uri
* registration_access_token which contains the provider's url and the client id

## Step 3
### Authenticate with the authorization end-point
(No change)

Authorization is conducted through a web 'external user agent' for security.  
A view controller is launched with an url containing the authorization end-point and query parameters:

* state
* response_type
* scope
* code_challenge
* redirect_uri
* client_id
* nonce
* code\_challenge\_method

We are prompted to confirm we permit the app to have the ???

The provider's login screen is displayed.  We login with our username and password.

The external agent redirects back to the app with a callback url containing as query parameters:

* code  (the authorization code)
* state

## Step 4
### Request an access token
This changes from the basic OIDC process.  The token request includes a key to be confirmed by the server as a proof-of-possession (PoP) token.

Using asymmetric keys.


The app makes an URL request to the token end-point:

* http POST method
* content-type is "application/x-www-form-urlencoded; charset=UTF-8"
* the header "Authorization" has "Basic" with the client id and client secret encoded in base64
* http body contains: 
   * redirect\_uri 
   * code 
   * code\_verifier(?) 
   * grant\_type (being authorization_code) 
   * token_type (being pop) 
   * alg RS256
   * key 

The response data contains:

* id_token
* access_token
* expires_in
* refresh_token

The access and id tokens are signed JWT tokens.  Use [jwt.io](https://jwt.io) for decoding.


The access token payload contains the following claims:


	"iss": "https://xxxxxxxxxx",
	"sub": "https://xxxxxxxxxx/profile/card#me",
	"aud": "a2aed450dc0f05ba188c49f8c562adf3",
	"exp": 1550941718,
	"iat": 1549732118,
	"jti": "eec693cae9b34067",
	"scope": "openid profile webid"


The ID token payload contains the following claims, which includes a `cnf` claim:

	
	"iss": "https://xxxxxxxxxx",  
	"sub": "https://xxxxxxxx/profile/card#me",  
	"aud": "a2aed450dc0f05ba188c49f8c562adf3",
	"exp": 1550941718,
	"iat": 1549732118,
	"jti": "e4c78e616d5c6e80",
	"nonce": "XaCZg4a8nrdTtFY5MMqNFfhMr_RB_SQrOLbzqBxyrkM",
	"azp": "a2aed450dc0f05ba188c49f8c562adf3",
	"cnf": {
	    "jwk": {
	        "use": "sig",
	        "key_ops": [
	        "verify",
	        "verify"
	        ],
	        "ext": true,
	        "alg": "RS256",
	        "kty": "RSA",
	        "e": "AQAB",
	        "n": "p3-I0Yxxxxxxxxx
	    }
	},
	"at_hash": "PVw479Y3ntS1OVrIeacyyw"


## Step 5
### Store the tokens
Currently working on how to gain access to protected resources using the tokens.




