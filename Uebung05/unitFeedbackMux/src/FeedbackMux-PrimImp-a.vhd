-------------------------------------------------------------------------------
-- Title : FeedbackMux
-------------------------------------------------------------------------------
-- Author :  markus.pfaff@fh-hagenberg.at
-- Created : 2015-11-05
-- Last update: 2015-11-10
-------------------------------------------------------------------------------
-- Copyright (c) Hagenberg/Austria 2015 - Time of last update
-------------------------------------------------------------------------------
-- Description:
-- Feedback multiplexer (multiplexer latch) with models for delay for each
-- single gate. Implementation of the multiplexer by prime implicands only.
-------------------------------------------------------------------------------

architecture PrimImp of FeedbackMux is

  signal Yc, Yn            : std_ulogic;
  signal nEn, Impl1, Impl2 : std_ulogic;

begin

  Yc <= Yn;

  -- Model this:
  --  Yn <= (Yc and not(iEn)) or
  --        (iEn and iD);
  -- like this:

  -- generate negated inputs
  nEn   <= not(iEn)       after 5 ns; -- fall 1: 6ns, fall 2: 6ns, fall 3: 5ns, fall 4-7: 6ns

  -- prime implicands
  Impl1 <= iEn and iD     after 5 ns; -- fall 1: 5ns, fall 2: 7ns, fall 3: 5ns, fall 4-7: 5ns
  Impl2 <= Yc and nEn     after 5 ns; -- fall 1-3: 5ns, fall 4: 3ns, fall 5: 5ns, fall 6: 4ns, fall 7: 7ns

  -- combine prime implicands
  Yn    <= Impl1 or Impl2 after 5 ns; -- fall 1-4: 5ns, fall 5: 7ns, fall 6: 5ns, fall 7: 5ns

  oQ <= Yc;

end architecture PrimImp;
