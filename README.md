# Dee Management Systems

Dee Management system is bug tracking management file that used by proffesional teams which is developer, product managers and many person included the teams.

### Description
Dee Management Systems are build by **Ruby On Rails**. And use **PostgreSQL** for the database. To persistance our performance we used **RSpec** for unit testing.

### How To Use
Many steps to used this application for bootstapping only
  - ##### Configure Vagrantfile
      1. Install [Vagrant]
      2. Run ```vagrant up ```
      3. Wait until provision done
      4. Run ```vagrant ssh```
      
  > If the machine can't provision its self by doing instalation step just like this. Just in developement uses.
  > 
      1. Install ruby version with rbenv 2.3.0p0
      2. Install rails 4.2.6
      3. Install PostgreSQL 9.5

  - ##### Resolve Dependencies for this Project
    ```bundle exec install```

  - ##### Create and initialize the database
      1. ```rake db:create```
      2. ```rake db:migrate```
      3. ```rake db:seed```
  - ##### Run Server for first use
    ```rails s -b 0.0.0.0``` **uses -b to bind the address into localhost**

### Version
0.1.0

### Development use only
This readme for development environment only. We running in production with diffenrent case. So, we develop it and staging it and doing test on there. If all test passes, we run into production.

_Best Regards_

**Satrio Nugroho**

[Vagrant]: 'https://www.vagrantup.com/docs/vagrantfile/'
