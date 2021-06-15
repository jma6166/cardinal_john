[Mesh]
  type = FileMesh
  file = sphere_in_cm.e
[]

[AuxVariables]
  [cell_id]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_instance]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_temperature]
    family = MONOMIAL
    order = CONSTANT
  []
  [material_id]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_density]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [material_id]
    type = CellMaterialIDAux
    variable = material_id
  []
  [cell_id]
    type = CellIDAux
    variable = cell_id
  []
  [cell_instance]
    type = CellInstanceAux
    variable = cell_instance
  []
  [cell_temperature]
    type = CellTemperatureAux
    variable = cell_temperature
    execute_on = 'timestep_end'
  []
  [cell_density]
    type = CellDensityAux
    variable = cell_density
    execute_on = 'timestep_end'
  []
[]

[Problem]
  type = OpenMCCellAverageProblem
  power = 1e6
  fluid_blocks = '1'
  tally_blocks = '1'
  verbose = true
  tally_type = cell
  tally_filter = cell
  fluid_cell_level = 0
[]

[Executioner]
  type = Transient

  # we need this to match the quadrature used in the receiving MOOSE app
  # (does not exist in this input file) so that the elem->volume() computed
  # for normalization within OpenMCCellAverageProblem is the same as in the
  # receiving MOOSE app.
  [Quadrature]
    type = GAUSS
    order = THIRD
  []
[]

[Postprocessors]
  [heat_source]
    type = ElementIntegralVariablePostprocessor
    variable = heat_source
  []
[]

[Outputs]
  exodus = true
[]