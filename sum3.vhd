--    This file is part of SumadoresPedro.
--
--    SumadoresPedro is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    SumadoresPedro is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with SumadoresPedro.  If not, see <https://www.gnu.org/licenses/>.

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

