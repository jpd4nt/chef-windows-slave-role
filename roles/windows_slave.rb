name "windoes_slave"
description "CI Slave for Windows server"
all_env = [ 
  "recipe[windows::default]",
  "recipe[powershell::default]",
  "recipe[ms_dotnet45::default]",
  "recipe[chocolatey::default]",
  "recipe[windows_slave::default]",
]

run_list(all_env)

env_run_lists(
  "_default" => all_env, 
)