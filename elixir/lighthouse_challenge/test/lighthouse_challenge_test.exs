defmodule LighthouseChallengeTest do
  use ExUnit.Case
  doctest LighthouseChallenge

  test "[Day1] on simple cases" do
    assert LighthouseChallenge.Day1.doorToDoor([1], [1]) == 1
  end
end
