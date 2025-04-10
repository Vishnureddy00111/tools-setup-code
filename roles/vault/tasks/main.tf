- name: Set Prompt
  ansible.builtin.shell: set-prompt {{ tool_name }}

- name: Set Prompt
  ansible.builtin.shell: set-prompt {{ tool_name }}

- name: Download Hashicorp repo file
  ansible.builtin.get_url:
  url: https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
  dest: /etc/yum.repos.d/hashicorp.repo

- name: Install Vault
  ansible.builtin.dnf:
  name: vault
  state: installed

- name: Copy Vault config
  ansible.builtin.copy:
  src: vault.hcl
  dest: /etc/vault.d/vault.hcl

- name: Start Vault Service
  ansible.builtin.systemd_service:
  name: vault
  state: restarted
  enabled: yes