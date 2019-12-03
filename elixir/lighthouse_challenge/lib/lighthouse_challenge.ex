defmodule LighthouseChallenge do
  defmodule Day1 do
    def doorToDoor([_v_head | _v_tail] = volunteers, [_n_head | _n_tail] = neighbourhoods) do
      ceil(Enum.count(neighbourhoods) / Enum.count(volunteers))
    end

    def doorToDoor(_volunteers, _neighbourhoods), do: 0
  end

  defmodule Day2 do
    def interviewAnswer("arts funding"), do: "We'll have to get creative!"
    def interviewAnswer("economy"), do: "Time is money."

    def interviewAnswer("transportation"),
      do: "It's going to be a long road, so we better get moving."

    def interviewAnswer(_), do: "QUACK!"
  end

  defmodule Day3 do
    @name_dic %{"Tim" => 0, "Sally" => 1, "Beth" => 2}
    def castVote(name, votes) do
      casted_vote_index = @name_dic[name]

      votes
      |> Enum.with_index()
      |> Enum.map(fn
        {count, ^casted_vote_index} -> count + 1
        {count, _index} -> count
      end)
    end
  end

  defmodule Day4 do
    def registerToVote(name, unregisteredVoters) do
      unregisteredVoters |> Enum.filter(&(&1 != name))
    end
  end

  defmodule Day5 do
    def chooseStations(stations) do
      stations
      |> Enum.filter(fn [_name, capacity, type] ->
        (capacity >= 20 && type == "school") || type == "community centre"
      end)
      |> Enum.map(&Enum.at(&1, 0))
    end
  end

  defmodule Day6 do
    @valid "All clear, we can count the votes!"
    @invalid "FRAUD!"

    def voterTurnout(voter_signatures, voter_signatures) when is_list(voter_signatures),
      do: @valid

    def voterTurnout(voter_signatures, voter_ids) do
      if Enum.count(voter_signatures) == Enum.count(voter_ids) do
        @invalid
      else
        false
      end
    end
  end

  defmodule Day7 do
    def termTopics(interviews) do
      interviews
      |> Enum.reduce([0, 0, 0], fn
        "smart city", [countA, countB, countC] ->
          [countA + 1, countB, countC]

        "arts funding", [countA, countB, countC] ->
          [countA, countB + 1, countC]

        "transportation", [countA, countB, countC] ->
          [countA, countB, countC + 1]

        _interview, [countA, countB, countC] ->
          [countA, countB, countC]
      end)
    end
  end

  defmodule Day8 do
    def smartGarbage(trash, bins) do
      Map.update(bins, trash, 0, &(&1 + 1))
    end
  end

  defmodule Day9 do
    def carPassing(cars, speed) do
      now = DateTime.to_unix(DateTime.utc_now())
      cars ++ %{speed: speed, time: now}
    end
  end

  defmodule Day10 do
    defp get_finder_by_vehicle_type("regular"), do: &(&1 == "R")
    defp get_finder_by_vehicle_type("small"), do: &(&1 == "R" || &1 == "S")
    defp get_finder_by_vehicle_type("motorcycle"), do: &(&1 == "R" || &1 == "S" || &1 == "M")
    defp get_finder_by_vehicle_type(_vehicle), do: fn _ -> false end

    def whereCanIPark(spots, vehicle) do
      finder = get_finder_by_vehicle_type(vehicle)

      result =
        Enum.reduce_while(spots, 0, fn innerList, column ->
          case Enum.find_index(innerList, &finder.(&1)) do
            nil -> {:cont, column + 1}
            row -> {:halt, [row, column]}
          end
        end)

      if is_list(result), do: result, else: false
    end
  end

  # > LighthouseChallenge.Day11.busTimes(%{someBus: %{distance: 5, speed: 9}})
  defmodule Day11 do
    def busTimes(buses) do
      buses
      |> Enum.into(%{}, fn
        {key,
         %{
           distance: distance,
           speed: speed
         }} ->
          {key, distance / speed}

        {key, value} ->
          {key, value}
      end)
    end
  end

  defmodule Day12 do
    def checkAir(samples, threshold) do
      count_threshold = threshold * Enum.count(samples)

      {status, _dirtyCount} =
        samples
        |> Enum.reduce_while({"Clean", 0}, fn
          "dirty", {_status, dirtyCount} when dirtyCount > count_threshold ->
            {:halt, {"Polluted", dirtyCount}}

          "dirty", {status, dirtyCount} ->
            {:cont, {status, dirtyCount + 1}}

          _sample, accumulator ->
            {:cont, accumulator}
        end)

      status
    end
  end

  defmodule Day13 do
    def lightsOn(lights), do: toggleLights(lights, false)
    def lightsOff(lights), do: toggleLights(lights, true)

    def toggleLights(lights, lightsAreOn) do
      lights |> Enum.map(&Map.put(&1, :on, !lightsAreOn))
    end
  end

  defmodule Day14 do
    def dynamicPricing(numberOfPeople, distanceTraveled) do
      extraCharge = if numberOfPeople >= 30, do: 0.25, else: 0
      cost = 1 + distanceTraveled * 0.25 + extraCharge

      # cleanest way to handle cents from: https://stackoverflow.com/a/43537269
      "$" <> :erlang.float_to_binary(cost, decimals: 2)
    end
  end

  defmodule Day15 do
    def finalPosition(moves) do
      moves
      |> Enum.reduce([0, 0], fn
        "north", [x, y] -> [x, y + 1]
        "south", [x, y] -> [x, y - 1]
        "east", [x, y] -> [x + 1, y]
        "west", [x, y] -> [x - 1, y]
        _next, [x, y] -> [x, y]
      end)
    end
  end

  defmodule Day16 do
    def festivalColours(color0) do
      color1 = rem(color0 + 150, 360)
      color2 = rem(color0 + 210, 360)
      if color1 < color2, do: [color1, color2], else: [color2, color1]
    end
  end

  # iex(37)> LighthouseChallenge.Day17.judgeVegetable(
  #   [%{submitter: "john", redness: 9},%{submitter: "jack", redness: 34}], :redness)
  #   "jack"
  defmodule Day17 do
    def judgeVegetable(vegetables, metric) do
      %{submitter: submitter} =
        vegetables
        |> Enum.reduce(fn
          vegetable, pickedVegetable ->
            if pickedVegetable[metric] > vegetable[metric], do: pickedVegetable, else: vegetable
        end)

      submitter
    end
  end

  defmodule Day18 do
    @lol %{red: 0, blue: 0, green: 0}
    defp countTickets(tickets) do
      tickets |> Enum.reduce(@lol, fn key, acc -> Map.update(acc, key, 0, &(&1 + 1)) end)
    end

    defp generateMessage(color) do
      "You have the best odds of winning the #{color} raffle"
    end

    # iex> LighthouseChallenge.Day18.bestOdds([:red,:red,:green],%{red: 2, blue: 9, green: 5})
    #   "You have the best odds of winning the red raffle"
    def bestOdds(tickets, raffleEntries) do
      allCount = countTickets(tickets)
      redCount = allCount.red / raffleEntries.red
      greenCount = allCount.green / raffleEntries.green
      blueCount = allCount.blue / raffleEntries.blue

      if redCount > greenCount do
        if redCount > blueCount, do: generateMessage("red"), else: generateMessage("blue")
      else
        if greenCount > blueCount, do: generateMessage("green"), else: generateMessage("blue")
      end
    end
  end

  defmodule Day19 do
    def pumpkinSpice(money) do
      pieCount = floor(money / 5)
      latteCount = floor((money - pieCount * 5) / 3)
      macaronCount = floor(money - pieCount * 5 - latteCount * 3)
      spiceConsumed = pieCount * 30 + latteCount * 15 + macaronCount * 3
      [pieCount, latteCount, macaronCount, spiceConsumed]
    end
  end

  # iex> LighthouseChallenge.Day20.totalVolume([
  #   %{type: "sphere", radius: 1},
  #   %{type: "sphere", radius: 1},
  #   %{type: "prism", width: 1, height: 1, depth: 1
  #   }])
  # 9.377573333333332
  defmodule Day20 do
    @pi 3.14159

    defp sphereVolume(radius), do: 4 / 3 * @pi * :math.pow(radius, 3)
    defp coneVolume(radius, height), do: @pi * radius * radius * height / 3
    defp prismVolume(height, width, depth), do: height * width * depth

    defp getVolume(%{type: "sphere"} = solid), do: sphereVolume(solid.radius)
    defp getVolume(%{type: "cone"} = solid), do: coneVolume(solid.radius, solid.height)

    defp getVolume(%{type: "prism"} = solid),
      do: prismVolume(solid.height, solid.width, solid.depth)

    defp getVolume(_solid), do: 0

    def totalVolume(solids) do
      solids |> Enum.reduce(0, &(&2 + getVolume(&1)))
    end
  end

  defmodule Day21 do
    defp makeDic(ingredientList) do
      ingredientList |> Map.new(&{&1, true})
    end

    def chooseRecipe(bakeryA, bakeryB, recipes) do
      [aDic, bDic] = [makeDic(bakeryA), makeDic(bakeryB)]

      %{name: name} =
        Enum.find(recipes, fn %{ingredients: ingredients} ->
          first_ingredient = Enum.at(ingredients, 0)
          second_ingredient = Enum.at(ingredients, 1)

          (aDic[first_ingredient] && bDic[second_ingredient]) ||
            (aDic[second_ingredient] && bDic[first_ingredient])
        end)

      name
    end
  end
end
