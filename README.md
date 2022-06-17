# add-private-registry

[![Continuous Integration](https://github.com/PumasAI/add-private-registry/actions/workflows/ci.yml/badge.svg "Continuous Integration")](https://github.com/PumasAI/add-private-registry/actions/workflows/ci.yml)

Add a private Julia package registry.

## Usage

```yml
- uses: PumasAI/add-private-registry
  with:
    juliahub_token_encoded: ${{ secrets.JULIAHUB_TOKEN_ENCODED }}
    private_registry_name: MyPrivateRegistry
    private_registry_uuid: 00000000-0000-0000-0000-000000000000
  env:
    JULIA_PKG_SERVER: https://my-pkg-server.example.com/
```
