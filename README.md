# redmine_repo_sort

Redmine plugin to add sort links in column header of repositories view

### Use case(s)

* Redmine's current repositories view only shows files sorted by name. This plugin adds clickable column headers by which repository entries can be sorted by name, file time, author and filesize. Sort can be ascending or descending.

Sort is maintained on clicking on a directory node.

![PNG that represents a quick overview](/doc/repo_example.png)

### Install

1. download plugin and copy plugin folder redmine_repo_sort to Redmine's plugins folder 

2. restart server f.i.  

`sudo /etc/init.d/apache2 restart`

(no migration is necessary)

### Uninstall

1. go to plugins folder, delete plugin folder  

`rm -r redmine_repo_sort`

2. restart server f.i. 

`sudo /etc/init.d/apache2 restart`

### Use

* Just install and go to your repository. Plugin has been tested extensively with filesystem repositories. Should work with github, bazaar, cvs as well.

**Have fun!**

### Localisations

* 1.0.2
  - English
  - German

### Change-Log* 

**1.0.2**
 - cleaned code, minor bug fixes
 
**1.0.1**
 - cleaned code
 
**1.0.0** 
  - running on Redmine 3.4.6, 3.4.11
