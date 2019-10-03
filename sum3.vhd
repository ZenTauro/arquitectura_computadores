-- Test bench sumadores en cascada
entity sum_3bits is end;
architecture xxx of sum_3bits is
    signal a, b, ci, s: bit_vector (2 downto 0) := "000";
    signal cout, cin : bit := '0';

begin
    ci(0) <= cin;
    ss1: entity work.sum_elemental(RTL6)
      generic map (10 ns)
      port    map (a(0), b(0), ci(0), s(0), ci(1));

    ss2: entity work.sum_elemental(RTL6)
      generic map (10 ns)
      port    map (a(1), b(1), ci(1), s(1), ci(2));

    ss3: entity work.sum_elemental(RTL6)
      generic map (10 ns)
      port    map (a(2), b(2), ci(2), s(2), cout);

    process begin
        a <= "010"; b<="110"; cin<='1';
        wait for 100 ns;
        a <= "000"; b<="000"; cin<='0';
        wait for 100 ns;

        a <= "111"; b<="000"; cin<='1';
        wait for 100 ns;
        a <= "000"; b<="000"; cin<='0';
        wait for 100 ns;

        a <= "101"; b<="001"; cin<='1';
        wait for 100 ns;
        a <= "000"; b<="000"; cin<='0';
        wait for 100 ns;

        wait;
    end process;
end;

