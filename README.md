# isaahmdantas/dunnas-start


## Descrição
Este é o modelo de aplicação que recomendo para projetos Rails 7. Eu montei este modelo para incluir as melhores práticas, ajustes, documentação e preferencias dos projetos geralemnte desenvolvidos pela Dunnas Tecnologia.

Para versões mais antigas do Rails, use este arquivo:

* [Rails 5.x.x](https://github.com/isaahmdantas/dunnas-start/template_5.rb)

## Requisitos

Este modelo atualmente funciona com:

* Rails 7.x.x
* Ruby 3.1.1
* Bundler 2.x

## Instalação

Para gerar uma aplicação Rails usando este template, passe a opção `-m` para `rails new`, assim:

1.  Realizar o clone do script: 

```bash
$ git clone https://github.com/isaahmdantas/dunnas-start.git 
```

2.  <span style="color:red">Após realizar o clone do script é necessário realizar a "Senha de Aplicativo" do bitbucket para poder realizar a instalação das gem de autenticação</span>
*https://bitbucket.org/account/settings/app-passwords/*

3.  Ao gerar a senha só substituir no script template.rb pelo seu username e token:

```ruby 
# Antes
gem  "dunnas_endereco", git: "https://#{ENV['BITBUCKET_USERNAME']}:#{ENV['BITBUCKET_PASSWORD']}@bitbucket.org/dunnas/dunnas_endereco.git"
gem  "dunnas_admin", git: "https://#{ENV['BITBUCKET_USERNAME']}:#{ENV['BITBUCKET_PASSWORD']}@bitbucket.org/dunnas/dunnas_admin.git"

# Depois 
gem  "dunnas_endereco", git: "https://isaahmdantas:306442c6ae4f7d103@bitbucket.org/dunnas/dunnas_endereco.git"
gem  "dunnas_admin", git: "https://isaahmdantas:306442c6ae4f7d103@bitbucket.org/dunnas/dunnas_admin.git"

```

4.  E por fim já pode criar o projeto
```bash
$ rails new blog --database=postgresql -m ~/projects/dunnas-start/template.rb
```

## Configuração das cores do projeto

Para configurar a cor primaria do projeto é só alterar no arquivo 'app/assets/stylesheets/colors.css'

![colors.css](https://dunnas-cdn.s3.us-east-1.amazonaws.com/Captura-de-Tela-2022-08-04-a-s-16-01-04.png)

*--bs-x-x: #xxxxxx      (Configuração de cores do bootstrap)*

*--tagify-x-x: #xxxxxx  (Configuração de cores do tagify)*

*--fc-x-x: #xxxxxx      (Configuração de cores do fullcalendar)*

*--kt-x-x: #xxxxxx      (Configuração de cores do metronic)*

*--ic-x-x: #xxxxxx      (Configuração de cores do checkbox)*

## Configuração das logos utilizadas no projeto

Para configurar as logos é só alterar no arquivo de 'initializeres' (config/initializers/style.rb)


![style.rb](https://dunnas-cdn.s3.us-east-1.amazonaws.com/Captura-de-Tela-2022-08-05-a-s-15-58-27.png)


*Site para hospedar as imagens: https://imgbb.com/*


## Como rodar o scaffold 

```bash
rails g scaffold Post title:string description:text active:boolean deleted_at:datetime:index --no-assets --no-helper --no-test-framework
```

# <span style="color:red"> Informações importantes: </span>

1.   Utiliza o template metronic na versão 8.1.1
2.   O script se basea  no template 'demo01'.
3.   O script já configura o módulo de autenticação
4.   O módulo de autenticação utiliza o plugin criado para Dunnas.
5.   Já existe um plugin que gerencia os dados de cidade, estado e endereco nos padrões da Dunnas.
6.   Ao rodar o comando scaffold sempre colocar o atributo deleted_at:datetime:index pois já está pré-configurado a gem 'acts_as_paranoid' (que é utilizado para ocultar o objeto ao remover sem que remova do banco)
7.   O scaffold segue o layout que está dentro da pasta /lib/xxxx
8.   Exemplo de como utilizar o módulo de endereço (https://bitbucket.org/dunnas/dunnas_endereco)


------------------------------------------------------------------------    
			
## GEM's pré instaladas: 

* gem 'devise'
* gem 'devise-jwt'
* gem  "dunnas_endereco"
* gem  "dunnas_admin"
* gem 'acts_as_paranoid'
* gem 'audited'
* gem 'exception_notification'
* gem 'whenever'
* gem 'cancancan'
* gem 'carrierwave'
* gem 'carrierwave-base64'
* gem "mini_magick"
* gem 'kaminari'
* gem 'aws-sdk'
* gem 'fog-aws'
* gem 'asset_sync'
* gem 'email_validator'
* gem 'cpf_cnpj'
* gem 'credit_card_validations'
* gem 'enum_attributes_validation'
* gem 'array_enum' 
* gem 'auto_increment'
* gem 'sidekiq'
* gem 'http'
* gem "cocoon"
* gem 'ckeditor'
* gem 'social-share-button'
* gem 'friendly_id'
* gem 'meta-tags'
* gem 'sitemap_generator'
* gem "recaptcha"
* gem 'rubyzip'
* gem 'caxlsx'
* gem 'caxlsx_rails'
* gem 'thinreports-rails'
* gem 'wicked_pdf'
* gem 'wkhtmltopdf-binary'
* gem 'money-rails'
* gem 'protokoll'
* gem "figaro"
* gem 'rack-cors'
* gem 'serviceworker-rails'
* gem 'seed_migration'
* gem 'momentjs-rails'
* gem 'activerecord-import'
* gem 'brazilian-rails'
* gem 'smarter_csv'