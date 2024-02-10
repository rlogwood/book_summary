# README

1. Pull down book_summary repo and cd into the directory

2.`bin/bundle install`

3. `bin/bundle db:setup`

4. Add your OpenAPI key to the credentials

>- `EDITOR=(emacs|code|vi) bin/rails credentials:edit`
>- Update the `openai_api_key` with your OpenAI API token

>- Alternatively define an ENV variable by the same name with the key value.

5. bin/dev

6visit http://127.0.0.1:3000/ 
