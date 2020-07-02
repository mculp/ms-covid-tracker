class Diff < Hanami::Entity
  attributes do
    attribute :cases, Types::Int
    attribute :deaths, Types::Int
  end
end
