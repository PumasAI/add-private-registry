import Pkg
using Test: @testset, @test

@testset "Install a private test package from the test registry" begin
    ENV["JULIA_PKG_PRECOMPILE_AUTO"] = "0"
    Pkg.activate(; temp = true)
    test_package_name = ENV["TEST_PACKAGE_NAME"] |> strip |> String
    test_package_uuid = ENV["TEST_PACKAGE_UUID"] |> strip |> String
    test_package = Pkg.PackageSpec(name = test_package_name, uuid = test_package_uuid)
    @test isempty(Pkg.dependencies())
    @time Pkg.add(test_package)
    @test !isempty(Pkg.dependencies())
    @test haskey(Pkg.dependencies(), Base.UUID(test_package_uuid))
    pkginfo = Pkg.dependencies()[Base.UUID(test_package_uuid)]
    @test pkginfo.name == test_package_name
end
