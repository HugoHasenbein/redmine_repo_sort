# encoding: utf-8
#
# Redmine plugin for sorting repositories entries
#
# Copyright © 2019 Stephan Wenzel <stephan.wenzel@drwpatent.de>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

module RedmineRepoSort
  module Patches
    module RepositoriesControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        
        base.class_eval do
          unloadable
          
          def show
            @repository.fetch_changesets if @project.active? && Setting.autofetch_changesets? && @path.empty?
        
            @entries = @repository.entries(@path, @rev) #entries are already sorted by name
            case params[:order_by]
              when "time"
                @entries.sort_by!{|e| e.lastrev ? e.lastrev.time.to_i : 0 }
              when "author"
                @entries.sort_by!{|e| e.author }
              when "filesize"
                @entries.sort_by!{|e| e.is_dir? ? 0 : (e.size ? e.size : 0) }
            end
            
            @entries.reverse! if params[:order] == "desc"
            
            @changeset = @repository.find_changeset_by_name(@rev)
            if request.xhr?
              @entries ? render(:partial => 'dir_list_content') : head(200)
            else
              (show_error_not_found; return) unless @entries
              @changesets = @repository.latest_changesets(@path, @rev)
              @properties = @repository.properties(@path, @rev)
              @repositories = @project.repositories
              render :action => 'show'
            end
          end
          
        end #base
        
      end #self
      
      module InstanceMethods
      end #module
      
    end
  end
end

unless RepositoriesController.included_modules.include?(RedmineRepoSort::Patches::RepositoriesControllerPatch)
  RepositoriesController.send(:include, RedmineRepoSort::Patches::RepositoriesControllerPatch)
end



