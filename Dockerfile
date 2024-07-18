# syntax=docker/dockerfile:1
FROM ruby:3.3.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client build-essential libpq-dev

# Set an environment variable where the Rails app is installed to inside of Docker image
WORKDIR /parking-manager

# Set argument for port
ARG PORT=3000
ENV PORT=$PORT

# Copy the Gemfile and Gemfile.lock from app root directory into the image
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the main application into the Docker image
COPY . .

# Expose port 3000 to the Docker host, so we can access it from the outside
EXPOSE $PORT

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]