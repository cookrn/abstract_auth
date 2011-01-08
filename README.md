#AbstractAuth

##A Short Story
One day you, Sir Lucius Leftfoot, are hacking your little heart out, and
you realize that you're writing the same code over and over again to for
your clients. So, you think to yourself, "What if I packaged this up all
nice-like and set it free in the world for all the other knightly
developers to use in their apps?" Quickly, you realize that you can't go
calling...

    current_user.role? :king_of_the_hood

...all willy-nilly to make sure you're dealing with an administrator of
the host application, even though that's the API you're used to using.
What's one to do when the authentication procedures of the end-use host
application are unknown? Have no fear - AbstractAuth is here to save
you!

##Use Case

AbstractAuth is for developers creating reusable components (e.g. Rails
3 Engine gems) that require authentication information from their host
applications. It aims to provide a consistent and configurable API that
you, the component creator, can setup and use, which the developer of the
host application will need to implement, so that you can properly secure
your functionality.

##How It Works

AbstractAuth works by allowing the developers implementing your tools to
specify code blocks that will be executed to produce the desired
response. The blocks are executed when you call them, and in the context
in which you call them.

##Examples

AbstractAuth will only step in if you instruct it to. Therefore, by
default, nothing will happen. Oh, you wanted something to happen? Try
this somewhere in a setup area of your app...

    # Your setup code defining the API you expect your users to implement
    AbstractAuth.setup do |config|
      config.requires :authenticated_resource
    end

Then, when you need it, you should be able to call [[AbstractAuth.authenticated_resource]]
and expect the host application to have provided the code that will
return to you the resource object that is currently authenticated (e.g.
User). How do you go about making sure a host application complies with
your every whim? In a Rails application, for instance, you could
instruct them to setup an abstract_auth.rb initializer in [[config/initializers]]

    # The user's implementation of your desired API
    AbstractAuth.implement :authenticated_resource do
      current_user
    end

We'll hold on to that fancy block of code and execute it at the right
time so that we're returning you exactly what you need.

Maybe, you want to create a separate login page with access to a
super-secret web page. The part of the process that's different here is
how you instruct your users to implement the desired functionality.
Continuing the Rails application example, say you setup the following
in your code...

    # Your setup code defining the API you expect your users to implement
    AbstractAuth.setup do |config|
      config.requires :authenticate_resource, :authenticated_resource
    end

Thus, a developer might implement the following...

    # The user's implementation of your desired API
    AbstractAuth.implement :authenticated_resource do

      # A fancy helper method in the host app
      current_user

    end

    # The user's implementation of your desired API
    # Note the arguments
    AbstractAuth.implement :authenticate_resource do |username,password|

      # Your user's custom authentication procedure
      User.fancy_authenticate(username,password)

    end

Assuming everything goes as planned, you would be able to call...

    AbstractAuth.authenticate_resource(username,password)

...to determine whether a resource was authenticated.

Finally, if you make a call to expected API that the host app has not
implemented, an [[AbstractAuth::NotImplementedError]] will be thrown.

##Notes

Remember above, when I said that AbstractAuth will, by default, not
intrude on your code unless you set it up to do so? I lied just a
little bit. AbstractAuth does require another gem called ModuleExt,
which monkey-patches the Module class to add some convenience
attributes functions. Don't be mad.

##License

MIT. See the LICENSE file.
