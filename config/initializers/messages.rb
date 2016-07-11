module Messages
  class ErrorMessages
    InvalidEmailFormat = 'Invalid email format'
    InvalidEmailSpaces = 'Email address cannot contain spaces'
    PasswordTooShort = 'Password must be at least 8 characters long'
    InvalidPasswordSpaces = 'Password cannot contain spaces'
    CreateInitialAdminAcct = 'Please create an initial admin account'
    MustBeLoggedIn = 'You must be logged in'
    UnauthorizedAccess = 'You are not authorized to access that page!'
    AccountNotCreated = 'Account not created!'
    AccountNotUpdated = 'Account not updated'
    UnableToDeleteEvent = 'Unable to delete event'
    YouMustBeLoggedInToJoinAnEvent ='You must be logged in to join an event'
    UnableToLeaveEvent = 'Unable to leave event'
    ErrorCheckingIn = 'Error checking in'
    UnableToJoinEvent = 'Unable to join event'
    InvalidEmailOrPassword = 'Invalid email or password'
    OptionsNotSaved = 'Options not saved!'
    UnableToCreateLocation = 'Unable to create location'
    LocationNotUpdated = 'Location not updated'
    UnableToDeleteLocation = 'Unable to delete location'
    EventNotCreated = 'Event not created'
    EventNotUpdated = 'Event not updated'
  end
  
  class InfoMessages
    AccountUpdatedSuccessfully = 'Account updated successfully'
    AccountDeleted = 'Account deleted'
    SuccessfulCheckIn = 'Successful check in'
    OptionsSaved = 'Options saved!'
    LocationUpdatedSuccessfully = 'Location updated successfully'
    LocationDeleted = 'Location deleted'
    EventUpdatedSuccessfully = 'Event updated successfully'
    EventDeleted = 'Event deleted'
  end
  
  class InteractiveMessages
    AreYouSure = 'Are you sure?'
  end
end