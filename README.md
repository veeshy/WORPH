# Well Organized Reactor Physics (WORPH)

### An MCNP and SERPENT infinite lattice input writer for comparing different fuels for hexagonal lattices surrounded by tie-tube moderating tubes. Initially created to study Nuclear Thermal Propulsion (NTP) reactor lattices.
### Capabilities include:
- Various fuel to moderator configurations
- Adjust fuel flat to flat, fuel channel sizing, tie-tube dimensions
- Any fuel material can be modeled
- Burnup input writing for MCNP

Running WORPH

1. Add WORPH to your your MATLAB path
2. WORPH('[path of your iput file here]')  will make a Serpent or MCNP output file at the location of the input file 

See SCCTE folder for example input files.

Contact Michael Eades with questions
mike.eades.15@gmail.com with questions

Thank you to Vishal Patel and Pete Husemeyer for their help.

WORPH uses catstruct by Jos van der Geest and mergestruct by Igor Kaufman downloaded form matlab file exchange.