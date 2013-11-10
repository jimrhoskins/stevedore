class RepositoriesController < ApplicationController
  def index
    @repos = Repository.all
  end

  def show
    @repo = Repository.find_by! name: repo_full_name
  end
end
