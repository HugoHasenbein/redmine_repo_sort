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
    module RepositoriesHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        
        base.class_eval do
          unloadable
          
          def repo_column_header_link(caption, order_by)
          
            if params[:order]== "desc"
              css = 'sort '
              css << 'desc' if order_by == params[:order_by]
              order = 'asc'
            else
              css = 'sort '
              css << 'asc' if order_by == params[:order_by]
              order = 'desc'
            end
            
            url = url_for( 
              :action        => 'show',
              :id            => @project,
              :repository_id => @repository.identifier_param,
              :path          => nil,
              :rev           => @rev,
              :order         => order,
              :order_by      => order_by
            )
            
            link_to(caption, url, :class => css )
              
          end #def
          
        end #base
        
      end #self
      
      module InstanceMethods
      end #module
      
    end
  end
end

unless RepositoriesHelper.included_modules.include?(RedmineRepoSort::Patches::RepositoriesHelperPatch)
  RepositoriesHelper.send(:include, RedmineRepoSort::Patches::RepositoriesHelperPatch)
end



