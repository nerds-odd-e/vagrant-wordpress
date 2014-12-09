# WordPress in Vagrant

## Quickstart

Download and install [Vagrant](https://www.vagrantup.com/) & [VirtualBox](https://www.virtualbox.org/).

Clone this repository and run command `vagrant up`.

``` console
$ git clone https://github.com/nerds-odd-e/vagrant-wordpress.git
$ cd vagrant-wordpress
$ vagrant up
```

Once you back to the command prompt and everything is OK. Open your brower, Chrome of Safari, visit [http://wordpress.local](http://wordpress.local)

## Default account information

 * WordPress admin account
   - Username: odd-e
   - Password: s3cr3t
 * MySQL account
   - Username: wordpress
   - Password: wordpress
   - Database: wordpress

## How To

### Using wp-cli
#### Create WordPress user

Create a user named "tom" and password "toms3cr3t"

``` console
$ wp user create tom tom@example.com --role=editor --user_pass=toms3cr3t --display_name="Tom Hanks"
```

#### Reset WordPress user password

Reset "tom"'s password to "toms3cr3t"

``` console
$ wp user update tom --user_pass=toms3cr3t
```

### Backup WordPress database

``` console
$ vagrant ssh -c 'mysqldump -uwordpress -pwordpress wordpress' > wordpress.sql
```

## What's inside?

 * Git
 * Apache
 * PHP
 * MySQL
 * WordPress
 * [wp-cli](http://wp-cli.org/)
