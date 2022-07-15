import Base64
import Pkg
import TOML

include(joinpath(@__DIR__, "check_pkg_server.jl"))

function get_juliahub_token_toml()
    juliahub_token_encoded = ENV["JULIAHUB_TOKEN_ENCODED"] |> strip |> String
    juliahub_token_toml = String(Base64.base64decode(juliahub_token_encoded))
    return juliahub_token_toml
end

function check_auth_toml_file(token_file)
    # Sanity check to make sure that the `auth.toml` file is valid TOML
    d = TOML.parsefile(token_file)
    if !(d isa AbstractDict)
        msg = "The TOML file did not parse into a dictionary"
        @error msg typeof(d)
        throw(ErrorException(msg))
    end
    if isempty(d)
        msg = "The TOML file is empty"
        throw(ErrorException(msg))
    end
    return nothing
end

function main_create_auth_toml()
    juliahub_token_toml = get_juliahub_token_toml()
    pkg_server = Pkg.pkg_server()
    server_dir = Pkg.PlatformEngines.get_server_dir("$(pkg_server)/", pkg_server)
    token_file = joinpath(server_dir, "auth.toml")
    mkpath(dirname(token_file))
    open(token_file, "w") do io
        println(io, juliahub_token_toml)
        println(io)
    end
    check_auth_toml_file(token_file)
    return nothing
end

main_create_auth_toml()
