-------------------------------------------------------------------------------
-- Aufgabe 2: Mehrkomponentenuebergaenge -> Funktions-Hazard, Setup/Hold
-------------------------------------------------------------------------------

architecture Bhv of TbFeedbackMuxSetupHold is

    signal D, En  : std_ulogic := '0';
    signal Q      : std_ulogic;
    signal Shift  : integer := 0;   -- Versatz von D zu En in ns (negativ = D vor En)

begin

    uut : entity work.FeedbackMux(Hazardfree)
        port map(
            iD  => D,
            iEn => En,
            oQ  => Q
        );

    Stimuli : process

        -- Startzustand herstellen, dann En und D mit Versatz wechseln
        procedure Transition(EnStart, DStart, DNew : std_ulogic; offset : integer) is
        begin
            En <= '1';                  -- Q = DStart
            D  <= DStart;
            wait for 40 ns;
            En <= EnStart;
            wait for 40 ns;

            if offset >= 0 then         -- D nach En
                En <= not EnStart;
                wait for offset * 1 ns;
                D  <= DNew;
            else                        -- D vor En
                D  <= DNew;
                wait for -offset * 1 ns;
                En <= not EnStart;
            end if;
            wait for 50 ns;
        end procedure;

    begin

        for offset in -10 to 10 loop
            Shift <= offset;
            Transition('1', '0', '1', offset);   -- En faellt, D steigt
            Transition('1', '1', '0', offset);   -- En faellt, D faellt
            Transition('0', '0', '1', offset);   -- En steigt, D steigt
            Transition('0', '1', '0', offset);   -- En steigt, D faellt
        end loop;

        wait;
    end process;

end architecture Bhv;
