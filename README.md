# Helix not respecting language formatter

Helix built from main (sha: e844a4365d8556dc53b72b67206a6dca8742be80)

This repo represents a typical typescript project, which uses prettier to format files, in this case `tsconfig.json`.

The format prettier outputs is:

```json
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "lib": ["es2024", "ESNext.Array", "ESNext.Collection", "ESNext.Iterator"],
    "module": "nodenext",
    "target": "es2022",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "node16",
    "outDir": "dist"
  },
  "include": ["**.ts"],
  "exclude": ["node_modules", "dist"]
}
```

If helix is used to format the file, it outputs:

```json
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "lib": [
      "es2024",
      "ESNext.Array",
      "ESNext.Collection",
      "ESNext.Iterator"
    ],
    "module": "nodenext",
    "target": "es2022",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "node16",
    "outDir": "dist"
  },
  "include": [
    "**.ts"
  ],
  "exclude": [
    "node_modules",
    "dist"
  ]
}
```

Helix [.helix/languages.toml](.helix/languages.toml) configures the json language with: 

```toml
[[language]]
name = "json"
auto-format = true
formatter = { command = "npx", args = ["prettier", "--stdin-filepath", "%{buffer_name}"] }
language-servers = [{ name = "vscode-json-language-server" }]
```

However, when that is emulated without helix by running

```shell
cat tsconfig.json | npx prettier --stdin-filepath tsconfig.json
```

the output is again, which also matches to the output of more usual prettier CLI invocation like `npx prettier --write tsconfig.json`.

```json
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "lib": ["es2024", "ESNext.Array", "ESNext.Collection", "ESNext.Iterator"],
    "module": "nodenext",
    "target": "es2022",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "node16",
    "outDir": "dist"
  },
  "include": ["**.ts"],
  "exclude": ["node_modules", "dist"]
}
```

When prettier is uninstalled and json language configured to not use a custom formatter, the default vscode-json-languageserver formatter output matches to the output helix outputs with prettier configured.

In a smaller scale the same different behavior can be witnessed with the [.prettierrc.json](.prettierrc.json). Prettier adds a trailing new line but helix removes it.
