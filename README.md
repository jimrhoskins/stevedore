# Stevedore - An open-source private docker registry and index.

Stevedore allows you to run your own private registry and index that is
only accessible to the users in your own organization. All repositories
require the credentials of a user that has been invited to your
stevedore installation. Data is stored in your own s3 bucket.

# Stability

Stevedore is under active development and real-world use. The functions
of acting as a docker registry and index are working reliably, but the
web interface still needs some work.

Use at your own risk. Contributions welcome.

# Deploying

Stevedore is a ruby on rails app that can be run easily on herokue, or
any other environment you wish.

```bash
# Clone the repository and cd into it
git clone https://github.com/jimrhoskins/stevedore.git
cd stevedore

# Create the heroku app and push to it
heroku create YOUR_DESIRED_HEROKU_APP_NAME
git push heroku master

# Migrate the database
heroku run rake db:migrate

# Setup the configs
heroku config:add \
  AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY \
  AWS_SECRET_ACCESS_KEY=YOUR_SECRET \
  AWS_S3_BUCKET=BUCKET_TO_STORE_IMAGES_IN \
  DEFAULT_HOST=THE_HOST_OF_THIS_APP

```

The `DEFAULT_HOST` is used in the mailer and should be the domain name
where your instance is deployed.

Then visit your application `/users/sign_up` and create your first
account. Once an account has been set up, the registration process will
require an invite code that can be created at `/invites`

# Pushing and pulling
To push and pull from your repository, you will need an account on your
stevedore instance. We will assume your stevedore instance is at
`docker.example.com` for demonstration purpposes.

You can authenticate your docker client using `docker login docker.example.com`.
The username and password will be the same as what you used to register
on your app. The email is ignored.

**The docker client will say the account was created if the
authentication is succesful. This is unfortunate wording coded in the
docker client, in fact the account was already created, docker really
verified it is valid**

Now to push, simply tag or commit an image like so

```bash
# Commit a container as an image to the repository
docker commit CONTAINER_ID docker.example.com/NAMESPACE/NAME:TAG

# ... or commit an existing image to the repository
docker tag IMAGE_ID docker.example.com/NAMESPACE/NAME:TAG

# ... or build from dockerfile and tag it to the repository
docker build -t docker.example.com/NAMESPACE/NAME:TAG

# ... then push to stevedore
docker push docker.example.com/NAMESPACE/NAME:TAG
```

In this example the repositories took the form of
`$STEVEDORE_HOST/$NAMESPACE/$NAME:$TAG`. Since you control all
namespaces on your host, the `$NAMESPACE` may be whatever your want,
with the exception of `library` which is what docker uses behind the
scense for repos without a namespace. If you don't want to use a
namespace you don't have too. You can use `$STEVEDORE_HOST/$NAME:$TAG`
as well. 

You may also omit `:$TAG` and the tag will be `latest` by default.

Pulling is as easy as on any machine running 

```bash
docker run [OPTIONS] docker.example.com/NAMESPACE/NAME:TAG [...]
```

If you wish to pull from the repository the latest image

```bash
docker pull docker.example.com/NAMESPACE/NAME:TAG
```





