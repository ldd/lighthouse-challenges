/** DAY 1 */
const doorToDoor = (volunteers, neighbourhoods) =>
  Math.ceil(neighbourhoods.length / volunteers.length);

/** DAY 2 */
const interviewAnswer = topic => {
  switch (topic) {
    case "arts funding":
      return "We'll have to get creative!";
    case "economy":
      return "Time is money.";
    case "transportation":
      return "It's going to be a long road, so we better get moving.";
    default:
      return "QUACK!";
  }
};

/**
 * DAY 3
 * Remember, the possible candidates are: Tim, Sally, and Beth (in that order)
 */
const castVote = (name, votes) => {
  const nameDic = { Tim: 0, Sally: 1, Beth: 2 };
  const castedVoteIndex = nameDic[name];
  return votes.map((vote, i) => (i === castedVoteIndex ? vote + 1 : vote));
};

/** DAY4 */
const registerToVote = (name, unregisteredVoters) =>
  unregisteredVoters.filter(voter => voter !== name);

/** DAY 5 */
const chooseStations = stations =>
  stations
    .filter(
      ([name, capacity, type]) =>
        capacity >= 20 && (type === "school" || type === "community centre")
    )
    .map(([name]) => name);

/** DAY 6 */
const voterTurnout = (voter_signatures, voter_ids) => {
  const VALID = "All clear, we can count the votes!";
  const INVALID = "FRAUD!";
  if (voter_signatures.length !== voter_ids.length) return false;
  return voter_signatures.every((signature, i) => signature === voter_ids[i])
    ? VALID
    : INVALID;
};

/** DAY 7 */
const termTopics = interviews => {
  return interviews.reduce(
    ([countA, countB, countC], interview) => {
      switch (interview) {
        case "smart city":
          return [countA + 1, countB, countC];
        case "arts funding":
          return [countA, countB + 1, countC];
        case "transportation":
          return [countA, countB, countC + 1];
        default:
          return [countA, countB, countC];
      }
    },
    [0, 0, 0]
  );
};

/** DAY 8 */
const smartGarbage = (trash, bins) => ({ ...bins, [trash]: bins[trash] + 1 });

/** DAY 9 */
const carPassing = (cars, speed) => [...cars, { speed, time: Date.now() }];

/** DAY 10 */
{
  const filterMap = {
    regular: spot => spot === "R",
    small: spot => spot === "R" || spot === "S",
    motorcycle: spot => spot === "R" || spot === "S" || spot === "M"
  };

  const defaultFilter = () => false;

  const whereCanIPark = (spots, vehicle) => {
    const index = spots.flat().findIndex(filterMap[vehicle] || defaultFilter);
    const l = spots[0].length;
    return index === -1 ? false : [index % l, Math.floor(index / l)];
  };
}
/** DAY 11 */
const busTimes = buses =>
  Object.entries(buses).reduce(
    (dic, [key, value]) => ({
      ...dic,
      [key]: value.distance / value.speed
    }),
    {}
  );

/** DAY 12 */
const checkAir = (samples, threshold) => {
  let dirtyCount = 0;
  for (let i = 0; i < samples.length; i++) {
    if (samples[i] === "dirty") {
      dirtyCount += 1;
      if (dirtyCount > threshold * samples.length) {
        return "Polluted";
      }
    }
  }
  return "Clean";
};

/** DAY 13 */
const lightsOn = lights => toggleLights(lights, false);
const lightsOff = lights => toggleLights(lights, true);

const toggleLights = (lights, lightsAreOn) =>
  lights.map(light => ({ ...light, on: !lightsAreOn }));

/** DAY 14 */
const dynamicPricing = (numberOfPeople, distanceTraveled) => {
  const extraCharge = numberOfPeople >= 30 ? 0.25 : 0;
  const cost = 1 + distanceTraveled * 0.25 + extraCharge;
  return `\$${cost.toFixed(2)}`;
};

/** DAY 15 */
const finalPosition = moves =>
  moves.reduce(
    ([x, y], next) => {
      switch (next) {
        case "north":
          return [x, y + 1];
        case "south":
          return [x, y - 1];
        case "east":
          return [x + 1, y];
        case "west":
          return [x - 1, y];
        default:
          return [x, y];
      }
    },
    [0, 0]
  );

/** DAY 16 */
const festivalColours = color0 => {
  const color1 = (color0 + 150) % 360;
  const color2 = (color0 + 210) % 360;
  return color1 < color2 ? [color1, color2] : [color2, color1];
};

/** DAY 17 */
const judgeVegetable = (vegetables, metric) =>
  vegetables.reduce((pickedVegetable, vegetable) =>
    pickedVegetable[metric] > vegetable[metric] ? pickedVegetable : vegetable
  ).submitter;

/**DAY 18 */
const countTickets = tickets =>
  tickets.reduce((acc, next) => ({ ...acc, [next]: acc[next] + 1 }), {
    red: 0,
    green: 0,
    blue: 0
  });

const generateMessage = color =>
  `You have the best odds of winning the ${color} raffle.`;

const bestOdds = (tickets, raffleEntries) => {
  const allCount = countTickets(tickets);
  const redCount = allCount.red / raffleEntries.red;
  const greenCount = allCount.green / raffleEntries.green;
  const blueCount = allCount.blue / raffleEntries.blue;

  if (redCount > greenCount) {
    if (redCount > blueCount) return generateMessage("red");
    return generateMessage("blue");
  } else {
    if (greenCount > blueCount) return generateMessage("green");
    return generateMessage("blue");
  }
};

/** DAY 19 */
const pumpkinSpice = money => {
  const pieCount = Math.floor(money / 5);
  const latteCount = Math.floor((money - pieCount * 5) / 3);
  const macaronCount = Math.floor(money - pieCount * 5 - latteCount * 3);
  const spiceConsumed = pieCount * 30 + latteCount * 15 + macaronCount * 3;
  return [pieCount, latteCount, macaronCount, spiceConsumed];
};

/** DAY 20 */
{
  const PI = 3.14159;

  const sphereVolume = function(radius) {
    return (4 / 3) * PI * Math.pow(radius, 3);
  };

  const coneVolume = function(radius, height) {
    return (PI * Math.pow(radius, 2) * height) / 3;
  };

  const prismVolume = function(height, width, depth) {
    return height * width * depth;
  };

  const getVolume = solid => {
    switch (solid.type) {
      case "sphere":
        return sphereVolume(solid.radius);
      case "cone":
        return coneVolume(solid.radius, solid.height);
      case "prism":
        return prismVolume(solid.height, solid.width, solid.depth);
      default:
        return 0;
    }
  };

  const totalVolume = function(solids) {
    return solids.reduce((acc, solid) => acc + getVolume(solid), 0);
  };
}

/** DAY 21 */
{
  const makeDic = A => A.reduce((acc, next) => ({ ...acc, [next]: true }), {});

  const chooseRecipe = function(bakeryA, bakeryB, recipes) {
    const [aDic, bDic] = [makeDic(bakeryA), makeDic(bakeryB)];
    return recipes.find(
      ({ ingredients }) =>
        (aDic[ingredients[0]] && bDic[ingredients[1]]) ||
        (aDic[ingredients[1]] && bDic[ingredients[0]])
    ).name;
  };
}
