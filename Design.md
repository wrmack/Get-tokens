#  App design

Based on Clean Swift architecture principles and the VIP pattern:

ViewController - Interactor - Presenter  (VIP)

[https://clean-swift.com/clean-swift-ios-architecture/](https://clean-swift.com/clean-swift-ios-architecture/)


## Use cases

### Authenticate with provider

**View controller responsibilities:**
_(AuthenticateWithProviderViewController class)_

* manages views
* receives user interaction
* passes provider url entered by user to Interactor
* when callback received after configuration obtained it asks Interactor to register client
* when registration callback received it asks Interactor to authenticate with the provider
* it also handles sending and receiving messages to the VIP chain


**Interactor responsibilities:**
_(AuthenticateWithProviderInteractor class)_

* works with request and response handlers to get configuration, register and authenticate the client

**Presenter responsibilities:**
_(AuthenticateWithProviderPresenter)_

* formats messages for presentation to the view controller 
* passes these in a view model to the view controller for display

