architecture Bhv of TbFeedbackMux is

    signal D, En        :   std_ulogic := '0';
    signal QPrimImp     :   std_ulogic;
    signal QHazardfree  :   std_ulogic;

begin

    -- beide Modelle werden parallel mit denselben Eingaengen versorgt
    uutPrimImp : entity work.FeedbackMux(PrimImp)
        port map(
            iD  => D,
            iEn => En,
            oQ  => QPrimImp
        );

    uutHazardfree : entity work.FeedbackMux(Hazardfree)
        port map(
            iD  => D,
            iEn => En,
            oQ  => QHazardfree
        );

    Stimuli : process
    begin

        -- Init
        En <= '1';
        D  <= '0';
        wait for 30 ns;             -- t =  30 ns

        -- Teil 1: korrektes Verhalten
        D  <= '1';
        wait for 30 ns;             -- t =  60 ns
        D  <= '0';
        wait for 30 ns;             -- t =  90 ns
        En <= '0';                  -- '0' speichern
        wait for 30 ns;             -- t = 120 ns
        D  <= '1';                  -- Latch zu, Q bleibt '0'
        wait for 30 ns;             -- t = 150 ns
        D  <= '0';
        wait for 30 ns;             -- t = 180 ns

        -- Teil 2: Hazard
        En <= '1';
        wait for 30 ns;             -- t = 210 ns
        D  <= '1';
        wait for 30 ns;             -- t = 240 ns
        En <= '0';                  -- kritischer Uebergang: Q sollte eig. '1' bleiben
        wait for 60 ns;             -- t = 300 ns

        wait;
    end process;

end architecture Bhv;
