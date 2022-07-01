# add-private-registry

[![Continuous Integration](https://github.com/PumasAI/add-private-registry/actions/workflows/ci.yml/badge.svg "Continuous Integration")](https://github.com/PumasAI/add-private-registry/actions/workflows/ci.yml)

Add a private Julia package registry.

## Usage

First add a `JULIA_PKG_SERVER` environment variable to the toplevel of your workflow file that references your private package server.

```yml
env:
  JULIA_PKG_SERVER: https://my-pkg-server.example.com/
```

Then add the following step after your job's [`setup-julia`](https://github.com/julia-actions/setup-julia) step.

```yml
- uses: PumasAI/add-private-registry@COMMIT
  with:
    juliahub_token_encoded: ${{ secrets.JULIAHUB_TOKEN_ENCODED }}
    private_registry_name: MyPrivateRegistry
    private_registry_uuid: 00000000-0000-0000-0000-000000000000
```

where `COMMIT` is the commit SHA of this action that you would like to use.
