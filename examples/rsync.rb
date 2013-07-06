# encoding: utf-8
#
# Cookbook Name:: backup
# Recipe:: default
#
# Copyright 2012, Scott M. Likens
# Copyright 2012, AJ Christensen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#
  backup_install node.name
  backup_generate_config node.name

  backup_generate_model "Downloads" do
	description "Backup of Downloads"
	backup_type "rsync"
	sync_with({
	  "engine" => "RSync::Pull",
	  #"engine" => "RSync::Push",
	  "settings" => {
		"rsync.mode" => ":ssh",
		"rsync.host" => "pullremotedata.com",
		"rsync.port" => 22,
		"rsync.ssh_user" => "change_to_your_user",
		#"rsync.additional_ssh_options" => "-i '/path/to/id_rsa'",
		"rsync.additional_rsync_options" => ["-rlptD --no-g --no-o --hard-links --one-file-system"], # do not preserve owner or group
		#"rsync.additional_rsync_options" => "--archive --hard-links --one-file-system", # preserve owner and group
		"rsync.mirror" => "true", 
		"rsync.compress" => "true",
		"rsync.rsync_user" => "your_backup_user",
		"rsync.path" => "/Backups/" 
	}
	})
	options({
	  "add" => ["~/Downloads"],
	  "exclude" => [
		  "*Library/Caches/",
		  "*.Trash/",
		  "*.DocumentRevisions-V100/",
		  "/tmp"
	],
	  #"tar_options" => "-p" 
	})
	mailto "sample@example.com"
	action :backup
  end
