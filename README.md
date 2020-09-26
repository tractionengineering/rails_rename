## Description
The following script will:
- download our default Rails 6 app
- rename the app to whatever name you specified
- initialize a new git repository (locally)

```shell
# navigate to your desired destination, e.g. `~/Sites/traction/:client_name/`

# download default app
curl -LJO https://raw.githubusercontent.com/tractionengineering/rails_rename/master/run.rb
ruby run.rb
```

The script will ask you to enter the new app's name as well as a name for the git repository.
