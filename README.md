# Advance Manifesto
Today’s marketplace for software jobs is increasingly less favorable to those newer to tech and those in the unfortunate limbo of mid-level classification. The Advance Manifesto is a way to show your commitment to change that.

## Development
Before we begin, please note that the instructions to follow *assume a Mac development machine*. Feel free to open a PR if you'd like to include specific instructions for other operating systems. Thanks!

Now, let's get you set up:

1. Install [Docker Desktop](https://docs.docker.com/desktop/) on your local machine. This allows you to run the database, Redis store, and [Mailpit](https://mailpit.axllent.org/) containers locally. You can, of course, skip this step if Docker's not your thing. Oh whale 🐳!
1. Pull down this repository to your local machine.
1. At the root of the project, run `cp .env.example .env`. Then slide on over to your new `.env` file and fill out the empty environment variables. If you're using Docker, feel free to put whatever you want for `SMTP_USERNAME`, `SMTP_PASSWORD`, and `DB_PASSWORD`. Make sure to use reCAPTCHA v3 for all `G_RECAPTCHA_**` values. You can generate your own reCAPTCHA credentials at [https://www.google.com/recaptcha/](https://www.google.com/recaptcha/).
1. Open the Docker Desktop application. Then, in your termnial, run `docker compose up`. This will create and start the containers for PostgreSQL, Redis, and Mailpit.
1. In your terminal, run `bin/setup` to install your dependcies and set up your database.
1. In your terminal, run `bin/rails s` to fire up the development server.
1. In your browser, go to `http://localhost:3000` and start building features!
1. When you're done for the day, make sure to stop your Docker containers, Rails server, Sidekiq worker, and Tailwind process with `ctrl-c` in each of their respective terminals. You'll also probably want to run `docker compose down` to prevent Docker from eating your CPU for lunch.

### What about styling?
We use Tailwind CSS because we're fancy. Just kidding ... but no, seriously 🤓! So, in your terminal, run `bin/rails tailwindcss:watch` to build the Tailwind styles and watch for any changes made during development.

### What about emails?
Da da-da da 🪄 - Mailpit and Sidekiq unite!

You already started Mailpit with the Docker command in step 4 above. Now you'll need to run `bin/bundle exec sidekiq` to start the Sidekiq worker (which handles the mail jobs queued by Rails).

Then submit a pledge on the homepage to fire off a mail job and go to `http://localhost:8025` to see your inbox! Mailpit intercepts all emails so that you don't accidently send a message to someone. All emails are deleted when you spin down Mailpit's container.

## Deployment
We currently use [Render](https://render.com/) to deploy the Advance Manifesto app. You can take a peek at `render.yaml` and `bin/build.sh` to see our blueprints. Render re-deploys the app when we push to the `main` branch.
