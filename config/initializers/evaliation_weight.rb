EVALUATION_WEIGHT_NORMAL = {
  self: 0.1,
  peer: 0.15,
  manager: 0.45,
  supervisor: 0.30
}

EVALUATION_WEIGHT_WITHOUT_PEER = {
  self: 0.1,
  manager: 0.60,
  supervisor: 0.30
}

EVALUATION_WEIGHT_WITHOUT_SUPER = {
  self: 0.1,
  manager: 0.75,
  peer: 0.15
}

EVALUATION_WEIGHT_WITHOUT_SUPER_AND_PEER = {
  self: 0.1,
  manager: 0.90
}