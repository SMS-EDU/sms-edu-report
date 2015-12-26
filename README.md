# SMS-EDU-REPORT

At the moment, we handle sign-in/registration using Google OAuth. You'd need Google Dev credentials: a `CLIENT_ID` & `CLIENT_SECRET` for this. Google has [easy to follow instructions](https://developers.google.com/gmail/api/auth/web-server) for this here.

Alternatively, you could follow this [link](https://console.developers.google.com//start/api?id=gmail&credential=client_key) to enable the Gmail API - You'd need to sign in to Gmail first. Click "Go to credentials" and fill in the necessary forms. Click `Add credentials` -> `OAuth 2.0 client ID`. The rest should be easy. Save the `CLIENT_ID` & `CLIENT_SECRET` in the config_env.rb (See `config/config_env.rb.example`).

To get up and running, run `rake`.
You'll also need config keys, check config/config_env.rb.example for instructions.

Afterwards, `rackup` should get you going & the API should be up at localhost:9292

### Sample API Calls (Made using [HTTPie](https://github.com/jkbrzt/httpie))
> (/test_files/ contains sample files)

- Save several uploaders
  - `http -f POST localhost:9292/api/v1/uploader file@~/{absoulute_path_to_folder}/test_files/test_u.csv`
- Retrieve an uploader's info
  - `http localhost:9292/api/v1/uploader?email=taka@gmail.com`
- Save several guardians
  - `http -f POST localhost:9292/api/v1/guardian file@~/{absoulute_path_to_folder}/test_files/test_g.csv`
- Retrieve a guardian's info
  - `http localhost:9292/api/v1/guardian?phone_number=000738836292`
- Save a record
  - `http -f POST localhost:9292/api/v1/student_record file@~/{absoulute_path_to_folder}/test_files/test_r.csv uploader_email='taka@gmail.com' record_type='report_card'`
- Retrieve a record
  - `http localhost:9292/api/v1/student_record?uploader_email=taka@gmail.com`
