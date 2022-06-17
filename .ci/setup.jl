temp_depot = joinpath(ENV["GITHUB_WORKSPACE"], "temp_depot")
rm(temp_depot; force = true, recursive = true)
mkpath(temp_depot)

# Set the `TEMP_DEPOT` environment variable for future steps
open(ENV["GITHUB_ENV"], "w") do io
    println(io, "TEMP_DEPOT=$(temp_depot)")
end
