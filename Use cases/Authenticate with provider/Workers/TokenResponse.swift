//
//  TokenResponse.swift
//  POD browser
//
//  Created by Warwick McNaughton on 19/01/19.
//  Copyright © 2019 Warwick McNaughton. All rights reserved.
//

import Foundation



fileprivate let kRequestKey = "request"
fileprivate let kAccessTokenKey = "access_token"
fileprivate let kExpiresInKey = "expires_in"
fileprivate let kTokenTypeKey = "token_type"
fileprivate let kIDTokenKey = "id_token"
fileprivate let kRefreshTokenKey = "refresh_token"
fileprivate let kScopeKey = "scope"
fileprivate let kAdditionalParametersKey = "additionalParameters"




class TokenResponse: NSObject, Codable {
    
    /*! @brief The request which was serviced.
     */
    private(set) var request: TokenRequest?
    /*! @brief The access token generated by the authorization server.
     @remarks access_token
     @see https://tools.ietf.org/html/rfc6749#section-4.1.4
     @see https://tools.ietf.org/html/rfc6749#section-5.1
     */
    private(set) var accessToken: String?
    /*! @brief The approximate expiration date & time of the access token.
     @remarks expires_in
     @seealso OIDTokenResponse.accessToken
     @see https://tools.ietf.org/html/rfc6749#section-4.1.4
     @see https://tools.ietf.org/html/rfc6749#section-5.1
     */
    private(set) var accessTokenExpirationDate: Date?
    /*! @brief Typically "Bearer" when present. Otherwise, another token_type value that the Client has
     negotiated with the Authorization Server.
     @remarks token_type
     @see https://tools.ietf.org/html/rfc6749#section-4.1.4
     @see https://tools.ietf.org/html/rfc6749#section-5.1
     */
    private(set) var tokenType: String?
    /*! @brief ID Token value associated with the authenticated session. Always present for the
     authorization code grant exchange when OpenID Connect is used, optional for responses to
     access token refresh requests. Note that AppAuth does NOT verify the JWT signature. Users
     of AppAuth are encouraged to verifying the JWT signature using the validation library of
     their choosing.
     @remarks id_token
     @see http://openid.net/specs/openid-connect-core-1_0.html#TokenResponse
     @see http://openid.net/specs/openid-connect-core-1_0.html#RefreshTokenResponse
     @see http://openid.net/specs/openid-connect-core-1_0.html#IDToken
     @see https://jwt.io
     @discussion @c OIDIDToken can be used to parse the ID Token and extract the claims. As noted,
     this class does not verify the JWT signature.
     */
    private(set) var idToken: String?
    /*! @brief The refresh token, which can be used to obtain new access tokens using the same
     authorization grant
     @remarks refresh_token
     @see https://tools.ietf.org/html/rfc6749#section-5.1
     */
    private(set) var refreshToken: String?
    /*! @brief The scope of the access token. OPTIONAL, if identical to the scopes requested, otherwise,
     REQUIRED.
     @remarks scope
     @see https://tools.ietf.org/html/rfc6749#section-5.1
     */
    private(set) var scope: String?
    /*! @brief Additional parameters returned from the token server.
     */
    private(set) var additionalParameters: [String : String ]?
    
  
    
    init(request: TokenRequest?, parameters: [String : Any ]?) {
        super.init()
        self.request = request
        
        for parameter in parameters! {
            switch parameter.key {
            case kAccessTokenKey:
                accessToken = parameters![kAccessTokenKey] as? String
            case kExpiresInKey:
                let rawDate = parameters![kExpiresInKey]
                accessTokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(Int64(truncating: rawDate as! NSNumber)))
            case kTokenTypeKey:
                tokenType = parameters![kTokenTypeKey] as? String
            case kIDTokenKey:
                idToken = parameters![kIDTokenKey] as? String
            case kRefreshTokenKey:
                refreshToken = parameters![kRefreshTokenKey] as? String
            case kScopeKey:
                scope = parameters![kScopeKey] as? String
                
            default:
                additionalParameters![parameter.key] = parameter.value as? String
            }
        }
    }
    
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case request
        case accessToken
        case accessTokenExpirationDate
        case tokenType
        case idToken
        case refreshToken
        case scope
        case additionalParameters
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(request, forKey: CodingKeys.request)
        try container.encode(accessToken, forKey: CodingKeys.accessToken)
        try container.encode(accessTokenExpirationDate, forKey: .accessTokenExpirationDate)
        try container.encode(tokenType, forKey: CodingKeys.tokenType)
        try container.encode(idToken, forKey: .idToken)
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode(scope, forKey: .scope)
        try container.encode(additionalParameters, forKey: .additionalParameters)
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        request = try values.decode(TokenRequest.self, forKey: .request)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        accessTokenExpirationDate = try values.decode(Date.self, forKey: .accessTokenExpirationDate)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        idToken = try values.decode(String.self, forKey: .idToken)
        scope = try? values.decode(String.self, forKey: .scope)
        refreshToken = try? values.decode(String.self, forKey: .refreshToken)
        additionalParameters = try? values.decode([String : String].self, forKey: .additionalParameters)
    }
    
    
    
    func description() -> String {
        return String(format: """
        <%@: %p, accessToken: "%@", accessTokenExpirationDate: %@, \
        tokenType: %@, idToken: "%@", refreshToken: "%@", \
        scope: "%@", additionalParameters: %@, request: %@>
        """, NSStringFromClass(type(of: self).self), self, TokenUtilities.redact(accessToken)!, accessTokenExpirationDate! as CVarArg, tokenType!, TokenUtilities.redact(idToken)!, TokenUtilities.redact(refreshToken)!, scope!, additionalParameters!, request!)
    }
}