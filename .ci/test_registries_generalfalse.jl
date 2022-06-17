import Pkg
using Test: @test, @testset

@testset "Check installed registries, excluding General" begin
    reachable_registries = Pkg.Registry.reachable_registries()
    @test length(reachable_registries) == 1
    test_registry_name = ENV["TEST_REGISTRY_NAME"] |> strip |> String
    test_registry_uuid = ENV["TEST_REGISTRY_UUID"] |> strip |> String
    expected_registry = (; name = test_registry_name, uuid = Base.UUID(test_registry_uuid))
    only_reachable_registry = only(reachable_registries)
    @test only_reachable_registry.name == expected_registry.name
    @test only_reachable_registry.uuid == expected_registry.uuid
end
