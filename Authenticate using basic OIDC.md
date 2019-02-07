#  Authenticate using OIDC

We want to get an access token from our provider that can be used to access 'protected resources' held by a third party protected resource server without having to log into the protected resource server separately.

## Step 1
### Get our provider's configuration

Firstly we need to get our provider's configuration so we know what 'end-points' to use when we register our client and later when we request authorization and request a token.
We have our provider's url from the textbox.  Providers keep their OIDC configuration at ".well-known/openid-configuration".

Using the provider's url and the path for the open-id configuration, we send an URLRequest to this endpoint.  The data that is received in the response contains a lot of info but our interest is in the values for the following:

* registration_endpoint
* authorization_endpoint
* token_endpoint
* issuer

This is stored in the ServiceProviderConfiguration class.

## Step 2
### Register our client app using our provider's registration end-point.

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

We create an URL request as follows:



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

The app makes an URL request to the token end-point:

* http POST method
* content-type is "application/x-www-form-urlencoded; charset=UTF-8"
* the header "Authorization" has "Basic" with the client id and client secret encoded in base64
*  http body contains the redirect\_uri, code, code\_verifier, grant\_type (being authorization_code)

The response data contains:

* id_token
* access_token
* expires_in
* refresh_token

The access and id tokens are signed JWT tokens and contain:

* iss
* sub
* aud
* exp
* iat
* jti
* nonce (id token)
* azp (id token)
* at_hash (id token)
* scope (access token)

## Step 5
### Store the access token
The access token is used to gain access to protected resources.


## Step 6
### Use the access token to access a protected resource.



View online: [Markdown Live Preview]( https://markdownlivepreview.com)

