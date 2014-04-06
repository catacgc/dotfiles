dotfiles
========

Sane, basic default configs for unix terminals for new users

What's inside
-------------

- Check https://github.com/catacgc/dotfiles/blob/master/ansible/roles/common/tasks/main.yml to see the list of tasks
- Install virtualenv and activates it at each login (.bashrc)
- Install ffind, ack in this virtualenv
- Overwrites existing configs configs for: `~/.vimrc, ~/.gitconfig, ~/.bashrc`

Setup on a single machine
-------------------------

````
curl https://raw.githubusercontent.com/catacgc/dotfiles/master/setup.sh | sh
````

Setup on multiple machines at once
----------------------------------

Create an [Ansible Inventory File](http://docs.ansible.com/intro_inventory.html)

Clone the repo `git clone https://github.com/catacgc/dotfiles.git`
Run ansible: 

````
cd dotfiles/ansible
ansible-playbook -i your_inventory_file site.yml --limit hostgroup
````

