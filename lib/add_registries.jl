import Pkg

include(joinpath(@__DIR__, "check_pkg_server.jl"))

function main_add_registries()
    private_registry_name = ENV["PRIVATE_REGISTRY_NAME"] |> strip |> String
    private_registry_uuid = ENV["PRIVATE_REGISTRY_UUID"] |> strip |> String
    install_general_registry_s = ENV["INSTALL_GENERAL_REGISTRY"] |> strip |> String
    install_general_registry_b = parse(Bool, install_general_registry_s)
    general_registry =
        Pkg.RegistrySpec(name = "General", uuid = "23338594-aafe-5451-b93e-139f81909106")
    private_registry =
        Pkg.RegistrySpec(name = private_registry_name, uuid = private_registry_uuid)
    all_registries = [private_registry]
    if install_general_registry_b
        push!(all_registries, general_registry)
    end
    Pkg.Registry.add(all_registries)
    Pkg.Registry.update()
    Pkg.Registry.status()
    return nothing
end

main_add_registries()
