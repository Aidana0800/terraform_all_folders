output "remote_state" {
  value = data.terraform_remote_state.networking
}

output "remote_state_ec2" {
  value = data.terraform_remote_state.ec2
}
