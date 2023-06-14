require "fileutils"
require "shellwords"

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("dunnas-start-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/isaahmdantas/dunnas-start.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{dunnas-start/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING)
end

def rails_5?
  Gem::Requirement.new("~> 5.0.0").satisfied_by? rails_version
end


def add_gems
 gem 'devise', '~> 4.8.1'
 gem 'devise-jwt', '~> 0.9.0'
 gem  "dunnas_endereco", git: "https://isaahmdantas:ATBBmRZFt7aVSpFtRSKuL5j2uKV8B645D6AA@bitbucket.org/dunnas/dunnas_endereco.git"
 gem  "dunnas_admin", git: "https://isaahmdantas:ATBBmRZFt7aVSpFtRSKuL5j2uKV8B645D6AA@bitbucket.org/dunnas/dunnas_admin.git"
 gem 'acts_as_paranoid'
 gem 'audited', '~> 5.0'
 gem 'exception_notification'
 gem 'whenever', require: false
 gem 'cancancan'
 gem 'carrierwave', '~> 2.0'
 gem 'carrierwave-base64'
 gem "mini_magick"
 gem 'kaminari'
 gem 'aws-sdk', '~> 3'
 gem 'fog-aws'
 gem 'asset_sync'
 gem 'email_validator'
 gem 'cpf_cnpj'
 gem 'credit_card_validations', git: 'https://github.com/arobsondev/credit_card_validations.git' 
 gem 'enum_attributes_validation'
 gem 'array_enum' 
 gem 'auto_increment'
 gem 'sidekiq'
 gem 'http'
 gem "cocoon"
 gem 'ckeditor'
 gem 'social-share-button',  :git => 'https://github.com/isaahmdantas/social-share-button.git'
 gem 'friendly_id', '~> 5.2.4'
 gem 'meta-tags'
 gem 'sitemap_generator'
 gem "recaptcha"
 gem 'rubyzip'
 gem 'caxlsx'
 gem 'caxlsx_rails'
 gem 'thinreports-rails'
 gem 'wicked_pdf'
 gem 'wkhtmltopdf-binary', '~> 0.12.4'
 gem 'money-rails', '~>1.12'
 gem 'protokoll',  :git => 'https://github.com/claudiotrindade/protokoll.git'
 gem "figaro"
 gem 'rack-cors', :require => 'rack/cors'
 gem 'serviceworker-rails'
 gem 'seed_migration'
 gem 'momentjs-rails'
 gem 'activerecord-import'
 gem 'brazilian-rails'
 gem 'smarter_csv'
end

def copy_templates
  copy_file "Procfile"
  copy_file "Procfile.dev"

  directory "app", force: true
  directory "config", force: true
  directory "lib", force: true
  directory "vendor", force: true
end

# 1 - Configuração da auditoria
def add_audited
  generate "audited:install"
end

#  2 - Configuração do seed migrate
def add_seed_migration
  rails_command "seed_migration:install:migrations"
end

# 4 - Configuracao do sistema de autenticacao
def add_auth
  rails_command "dunnas_endereco:install:migrations"
  generate "dunnas_admin:config"
  rails_command "dunnas_admin:install:migrations"
end

# 5 - URL amigavel 
def add_friendly_id
  generate "friendly_id"
end

# 6 - Rotina do cron 
def add_whenever
  run "wheneverize ."
end

# 7 - Configuração do sitemap
def add_sitemap
  rails_command "sitemap:install"
end

# 8 - Configuração do cancancan
def add_cancancan
  generate "cancan:ability"
end

# 9 - Configuração do ckeditor
def add_ckeditor
  generate "ckeditor:install --orm=active_record --backend=carrierwave"
end

# 10 - Configuração do social share button
def add_social_button
  generate "social_share_button:install"
end

# 11 - Configuração do figaro
def add_figaro
  run "bundle exec figaro install"
end

# 12 - configuração da linguagem do app
def add_language
  template = """
      config.time_zone = ActiveSupport::TimeZone.new('America/Recife')
      config.i18n.default_locale = :'pt-BR'

      # paginas de erros
      config.exceptions_app = self.routes
    """.strip
  insert_into_file "config/application.rb", "  " + template + "\n\n", after: "class Application < Rails::Application\n"
end


def add_finale
  generate "serviceworker:install"
  generate "protokoll:migration"
  generate "seed_migration:install:migrations"

  insert_into_file(
    Dir["db/migrate/**/*create_custom_auto_increments.rb"].first,
    "[5.2]",
    after: "ActiveRecord::Migration"
  )
end

# Main setup
add_template_repository_to_source_path

add_gems

after_bundle do
  copy_templates

  add_audited
  add_seed_migration
  add_auth
  add_friendly_id
  add_whenever
  add_sitemap
  add_cancancan
  add_ckeditor
  add_social_button
  add_figaro
  add_language
  add_finale

  # Commit everything to git
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }

  say
  say "dunnas-start app successfully created!", :blue
  say
  say "To get started with your new app:", :green
  say "cd #{app_name} - Switch to your new app's directory."
end
