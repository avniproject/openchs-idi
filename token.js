var Cognito = require('amazon-cognito-identity-js');
global.navigator = () => null;

const tokenCache = {};

module.exports = function (config) {
    const {poolId, clientId, user: username, password} = config;
    if (tokenCache[username]) return Promise.resolve(tokenCache[username]);

    var authenticationDetails = new Cognito.AuthenticationDetails({
        Username: username,
        Password: password
    });
    var userPool = new Cognito.CognitoUserPool({
        UserPoolId: poolId,
        ClientId: clientId
    });
    var cognitoUser = new Cognito.CognitoUser({Username: username, Pool: userPool});
    return new Promise((res,rej)=>{
        cognitoUser.authenticateUser(authenticationDetails, {
            onSuccess: function (result) {
                res(result.getIdToken().getJwtToken());
            },
            onFailure: function (error) {
                rej("Authentication failure. Check credentials. " + "PoolId=" + poolId + " ClientId=" + clientId + " Username=" + username + " Password=" + password);
            },
            newPasswordRequired: function (_userAttributes, requiredAttributes) {
                const userAttributes = Object.assign({}, _userAttributes);
                delete userAttributes.phone_number_verified;
                delete userAttributes.email_verified;
                cognitoUser.completeNewPasswordChallenge(password, userAttributes, this);
            }
        });
    });
};
