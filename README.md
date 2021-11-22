# DEPRECATED
We moved to a new approach for scaffolding applications. This approach is (not yet?) open source :-)


# Readme
## Description
The script `run.rb` will:
- download our default Rails 6 app: https://github.com/tractionengineering/traction-scaffold
- rename the app to whatever name you specify
- initialize a new git repository (locally)

```shell
# navigate to your desired destination, e.g. `~/Sites/traction/:client_name/`

# download this script & execute it
curl -LJO https://raw.githubusercontent.com/tractionengineering/rails_rename/master/run.rb
ruby run.rb
```

The script will ask you to enter the new app's name as well as a name for the git repository.

```shell
# example usage
ruby run.rb

Enter name of the app
MyTestApp

Enter name of the git repository
my-test-app
```
