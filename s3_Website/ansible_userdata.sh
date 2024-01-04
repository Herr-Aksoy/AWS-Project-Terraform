#!/bin/bash

yum update -y
sudo amazon-linux-extras install ansible2 -y

# bunlari inventory file olusturup icerisine  yazarak yapmak daha mantikli.
sudo bash -c "cat << EOF > /home/ec2-user/ansible.cfg
[defaults]
host_key_checking = False
inventory = inventory
deprecation_warnings=False
interpreter_python=auto_silent
EOF"


sudo bash -c "cat << EOF > /home/ec2-user/inventory
[webservers]
node1 ansible_host=${ipp1} ansible_user=ubuntu
node2 ansible_host=${ipp2} ansible_user=ubuntu

[all:vars]
ansible_ssh_private_key_file=/home/ec2-user/${pem_key}.pem
EOF"



cat << EOF > /home/ec2-user/app_playbook.yml

---
- name: Proje2-Team Uygulaması Kurulumu
  hosts: webservers
  become: true

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install necessary packages
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - git
        - python3
        - python3-pip
        - python3-dev
        - default-libmysqlclient-dev

    - name: Clone repository
      git:
        repo: "https://@github.com/Herr-Aksoy/Proje2-Team.git"
        dest: "/home/ubuntu/Proje2-Team"

    - name: Install Python requirements
      pip:
        requirements: "/home/ubuntu/Proje2-Team/requirements.txt"

    - name: Run manage.py commands
      command: "screen -d -m bash -c '{{ item }}'"             
      args:
        chdir: "/home/ubuntu/Proje2-Team/src"
      loop:
        - "python3 manage.py collectstatic --noinput"
        - "python3 manage.py makemigrations"
        - "python3 manage.py migrate"
        - "python3 manage.py runserver 0.0.0.0:80"

EOF

sudo bash -c "cat << EOF > /home/ec2-user/${pem_key}.pem
${private_key_content}
EOF"





## üstekilerde test edildi onlarida yaziyor.

# cd /etc/ansible           ## Burada ansible.cfg  hosts  ve roles file lari var.
# sudo echo "[webservers]" >> hosts
# sudo echo "node1 ansible_host=Ec2 privat ip yazilacak ansible_user=ec2-user" >> hosts
# sudo echo "node2 ansible_host=Ec2 privat ip yazilacak ansible_user=ec2-user" >> hosts        ## Ec2 larin privar Ip leri eklenmeli.

# echo "[all:vars]" >> hosts
# echo "ansible_ssh_private_key_file=/home/ec2-user/${pem_key}.pem" >> hosts      ## Makinalarda ayni pemkey oldugundan bu yeterli.

# ## Bu ikisini de ekledi.
# sed -i '/module_set_locale = False/a interpreter_python=auto_silent' ansible.cfg    ## Bu yeni satir ekliyor. Uyarilari engelemek icin.
# sed -i 's/#host_key_checking = False/host_key_checking = False/g' ansible.cfg       ## sürekli yes sorusu gelmeyecek.


# yum  install git ## Bunu kontrol etmeyi unuttum


                                                        ## Buraya kadar tamamdir. 





chmod 400 {pem_key}.pem



# sudo bash -c "cat << EOF > /prometheus.yml
# # scrape_configs bölümünü bul ve düzenle
# scrape_configs:
#   - job_name: 'prometheus'
#     static_configs:
#       - targets: ['localhost:9090']

#   # Yeni bir scrape job ekle
#   - job_name: 'remote_collector'
#     scrape_interval: 10s
#     static_configs:
#       - targets: ['private_ip_value:9100']
# EOF"





# sudo bash -c "mkdir {pem_key}.arkadas"

# sudo touch {neyaptin}.asd      

# sudo mkdir manyak.txt                   ## Bu sekilde hepsini yapti

# mkdir kanka.nt        

# mkdir {neyaptin}.nachte