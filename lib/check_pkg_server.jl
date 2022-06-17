function check_environment_variable(name::String)
    if !haskey(ENV, name)
        msg = string(
            "The `$(name)` environment variable is not defined. ",
            "You must define the `$(name)` environment variable.",
        )
        throw(ErrorException(msg))
    end
    value = ENV[name]
    if isempty(value)
        msg = string(
            "The `$(name)` environment variable is defined, but it is empty. ",
            "You must provide a nonempty value for `$(name)`.",
        )
        throw(ErrorException(msg))
    end
    if isempty(strip(value))
        msg = string(
            "The `$(name)` environment variable is defined, but it consists ",
            "only of whitespace. ",
            "You must provide a nonempty value for `$(name)` that does not ",
            "consist only of whitespace.",
        )
        throw(ErrorException(msg))
    end
    return nothing
end

function main_check_pkg_server()
    name = "JULIA_PKG_SERVER"
    check_environment_variable(name)
    return nothing
end

main_check_pkg_server()
