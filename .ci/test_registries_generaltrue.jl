import Pkg
using Test: @test, @testset

@testset "Check installed registries, including General" begin
    reachable_registries = Pkg.Registry.reachable_registries()
    @test length(reachable_registries) == 2
    test_registry_name = ENV["TEST_REGISTRY_NAME"] |> strip |> String
    test_registry_uuid = ENV["TEST_REGISTRY_UUID"] |> strip |> String
    expected_registries = [
        (; name = "General", uuid = Base.UUID("23338594-aafe-5451-b93e-139f81909106")),
        (; name = test_registry_name, uuid = Base.UUID(test_registry_uuid)),
    ]
    for expected_registry in expected_registries
        matching_registries =
            filter(x -> x.name == expected_registry.name, reachable_registries)
        @test length(matching_registries) == 1
        matching_registry = only(matching_registries)
        @test matching_registry.name == expected_registry.name
        @test matching_registry.uuid == expected_registry.uuid
    end
end
