## Alexa Skills kit authorized to request Rails API

A graceful implementation of Rails API responding to Alexa's custom skills requests.
Right now this is a successful connection sample. However it has a good ground to become
a Ruby(Rails based) library on top of Alexa's API. Will see...

So, let's see what we have here.

As a starting point use [How to Easily Create Custom Skills for Alexa][blog article],
but do not fully rely on. This is an old article.
[Alexa Skills Kit developer page](https://developer.amazon.com/alexa-skills-kit) has changed its interface since these article
was written, in addition, it's describes not the best authorization grant flow. The `authorization_code` is much better
choice than the `implicit` as for doorkeeper's configuration. Use the first one when you reach that step. You also need to
instruct doorkeeper to use refresh tokens. Simply uncomment `use_refresh_token` setting in `config/initializers/doorkeeper.rb`.
According to this choose `Auth Code Grant` as for authorization grant type option while setting up account linking configuration
for your custom skill. The below field values will be:

```
Authorization URI:            RAILS_SERVER_DOMAIN/oauth/authorize
Access Token URI:             RAILS_SERVER_DOMAIN/oauth/token
Client ID:                    DOORKEEPER_APPLICATION_ID
Client Secret:                DOORKEEPER_APPLICATION_SECRET
Client Authentication Scheme: the_recommended_on
```

This will allow Alexa to request a new refresh token after the current one has expired. So users don't have to authenticate
their Alexa account with their account in you service all the time long.

Now, when your custom Alexa skill is built and configured, let's see how Rails can handle requests from.

```ruby
handle_alexa_request do |handler|
  handler.on_unauthorized_request do
    msg = 'I want to help you but we can only give information to authenticated users. ' +
          'Please connect your Alexa app with your RubyLabs account first.'

    plain_text_response msg
  end

  handler.on_launch_request do |user|
    msg = "Hello #{user.full_name}, is there anything you want to ask? " +
          'You can try: Alexa, ask ruby labs to generate a PDF or a CSV or an XLSX. ' +
          'Or you can check for the existing process state, like: Alexa, ask ruby labs to '+
          'check the process state. Or: Alexa, ask ruby labs to check if my PDF is available.'

    plain_text_response msg
  end

  handler.on_intent_request do |user|
    msg = case request_intent_name
      when 'DataGenerationIntent'
        # Of course before responding the server should run some backend tasks in this case
        "#{user.full_name}, your file is on its way. Try to check the state after some time. Like: " +
        'Alexa, ask ruby labs to check the process state'
      when 'DataCheckerIntent'
        "#{user.full_name}, we working hard to make you happy. It is ready"
      else
        "This case won't be. But anyway: hello #{user.full_name}"
    end

    plain_text_response msg
  end
end
```

This is the top level functionality for now. It's not competed and can't response to all life situations.
However the [Alexa](app/helpers/alexa.rb) module provides a proper structure to easily do the rest.

Now it's just a helper module, but has all chances to be extended as a separate library.
And that is what I'm planning to do. Feel free to request any functionality :wink:


### Deployment
##### Ruby/Rails version
Ruby `2.3.1` Rails `4.2.7`

##### Configuration
```
cp config/database.template.yml config/database.yml
cp config/secrets.template.yml config/secrets.yml
```
Fill in these new files with appropriate data.

```
bundle install
rake db:setup
rails s
```

After creating custom skills put their names and applicationIDs as key/value
pairs in `config/alexa.yml`. This info need for SkillValidator. The only validator for now :boom:

Follow [this][blog article] instructions to make Alexa speaking.

Since the Rails part was initially created as a pure API, there are no views currently.
You have to use device's minimal sign up form to create a user. Under `localhost:3000/users/sign_up`.
And the root URL is pointed on doorkeeper's default applications page, where you can manage your applications.


### External resources

##### Some topics from Alexa Skills Kit documentation
* [Request and Response JSON Reference](https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html)
* [Handle Requests Sent by Alexa](https://developer.amazon.com/docs/custom-skills/handle-requests-sent-by-alexa.html)
* [Request Types Reference (LaunchRequest, CanFulfillIntentRequest, IntentRequest, SessionEndedRequest)](https://developer.amazon.com/docs/custom-skills/request-types-reference.html)
* [Validate and Use Access Tokens in Custom Skill Code](https://developer.amazon.com/docs/account-linking/add-account-linking-logic-custom-skill.html)
* [Account Linking for Custom Skills](https://developer.amazon.com/docs/account-linking/account-linking-for-custom-skills.html)
* [Send the User a Progressive Response](https://developer.amazon.com/docs/custom-skills/send-the-user-a-progressive-response.html). This is AWESOME :heart:
* [Configure Your Web Service to Use a Self-signed Certificate](https://developer.amazon.com/docs/custom-skills/configure-web-service-self-signed-certificate.html)

##### AWS echo device simulator
Use [online echo device simulator](https://echosim.io) if you don't have a real one.
This is necessary in order to access your Alexa app dashboard and connect Alexa with your app created with doorkeeper.
Otherwise you'll not be able to test the authenticated users requests flow.


[blog article]: https://blog.echobind.com/how-to-easily-create-custom-skills-for-alexa-b16ddd53e269
