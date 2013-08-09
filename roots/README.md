# Salt Root

This directory serves as /srv on the provisioned server and so the dirs

  - salt -> /srv/salt (for salt states `sls`)
  - pillar -> /srv/pillar (for pillar data)

`git submodule` your working state into the salt directory and use your pillars
by doing the same into the pillar directory, or into the Vagrantfile at the root
of the repo:

    config.vm.provision :salt do |salt|

      # Export hostnames for webserver config
      salt.pillar({
        "hostnames" => {
          "www" => "www.example.com",
          "intranet" => "intranet.example.com"
        }
      })

      # Export database credentials
      salt.pillar({
        "database" => {
          "user" => "jdoe",
          "password" => "topsecret"
        }
      })

      salt.run_highstate = true
    end


See the vagrant-salt/salty-vagrant [repository][salty-repo] and
[documentation][salty-repo] for more options that can be adjusted in
the Vagrantfile.

[salty-repo]: https://github.com/saltstack/salty-vagrant