architecture Hazardfree of FeedbackMux is

  signal Yc, Yn                   : std_ulogic;
  signal nEn, Impl1, Impl2, Impl3 : std_ulogic;

begin

  Yc <= Yn;

  -- Model this:
  --  Yn <= (Yc and not(iEn)) or
  --        (iEn and iD)      or
  --        (iD and Yc);              -- third prime implicand (consensus)
  -- like this:

  -- Verzoegerungszeiten: gleiche Werte wie in PrimImp eintragen (Faelle 1-7)

  -- generate negated inputs
  nEn   <= not(iEn)                after 6 ns;

  -- prime implicands
  Impl1 <= iEn and iD              after 5 ns;
  Impl2 <= Yc and nEn              after 5 ns;
  Impl3 <= iD and Yc               after 5 ns;

  -- combine prime implicands
  Yn    <= Impl1 or Impl2 or Impl3 after 5 ns;

  oQ <= Yc;

end architecture Hazardfree;
