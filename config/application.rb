require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ScavengerHunt
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Turn off timestamped migration prefix for ActiveRecord migrations
    config.active_record.timestamped_migrations = false
  end

=begin
= ABOUT

    Welcome to UNLV's QR Code Scavenger Hunt Site! This application was originally
    conceived at the UNLV Computer Science Department by Ed Jorgensen and Guymon
    Hall to help students familiarize themselves with various locations around the
    UNLV campus.

= CONTRIBUTORS

    Thank you to the following individuals for their contributions:
    
    * Megan Freeman
    * Reiley Porter
    * Carmon Wong
    * Beverly Wood

    To contribute to this project, please contact <code>g u y m o n . h a l l @ u n l v . e d u</code>.

= LICENSE

    This application and its source code are licensed under the MIT License:

    Copyright (c) 2016 Guymon Hall

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=end

=begin
= USER
    
= CREATE AN ACCOUNT
        
    On the homepage, click "signup".  Enter your information and click "submit".  Once your account is created, you will be redirected to your homepage (Dashboard).
    
    
= JOIN AN EVENT
    
    When logged in, go to the main Homepage.  This will display a list of the active events.  Select an event to join.  Go to your Dashboard to confirm you have joined the event.
    
    
= VISIT LOCATIONS
    
    Visit each event location.  When you arrive at a given location, scan the available QR code.  When prompted, input your credentials to check in are mark the location as "visited".    
    
    
= VIEW YOUR DASHBOARD
    
    When logged in, click "Dashboard".  This page displays all events you are participating in, event you own, and items you own.  To view your account details, click on the dropdown tab labelled with your email address.  This will display your account details.  Input any information you wish to update.

=end

=begin
= DEVELOPER

= DEVELOPMENT PROCESS

    The development process for this project is relatively straightforward. The main development code is housed as a
    repository on Bitbucket.org as part of the UNLV Scavenger Hunt team. To begin coding on this project, do the following:

    * fork the UNLV Scavenger Hunt repository into your own account
    * clone the repository from your own account into your development environment
    * change to the main app directory and run <code>./start-developing.sh</code>.
    * start working!

    After completing your code and verifying that all tests pass, make sure to add, commit, and push your changes to
    your Bitbucket.org account. Then, create a pull request to merge your changes from your account into
    the UNLV Scavenger Hunt repository. The project administrators will review your changes and either merge or decline
    your pull request.

= ENTITY DIAGRAM

    <img src="/images/ERdiagram.png" style="display: block; margin: auto; border: thin solid;">

    The E-R diagram above describes the relationships between the various models. The core models for this app consist of
    events, locations, and users, and they are related to one another as follows:

    An event contains a series of 0 or more locations, and each location can belong to 0 or more events. This is facilitated
    through the use of a Rails has-and-belongs-to-many association.

    A user can own many events, and each event belongs to 1 or more users. This is accomplished through a Rails has-and-belongs-to-many
    association. A user can also participate in many events, and an event contains 0 or more participants. This happens
    through the use of a Rails has-many/through association reflected in the Join model.

    A user can also own many locations, and each location belongs to 1 or more users. As before, this is a Rails has-and-belongs-to-many
    association. A user can also check-in at many locations, and a location can have 0 or more visitors. This relationship
    uses the Visit model to implement a Rails has-many/through association.

    Users can have 1 or more roles; each role is comprised of 1 or more permissions, and each permission contains 1 or
    more tasks. A task is simply a triplet consisting of an HTTP request method, a controller, and an action.

=end
end
