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

entity RCAs is end;

architecture RCA_8x1 of RCAs is
  signal a,b,s : bit_vector (7 downto 0) := x"00";
  signal cout, cin : bit := '0';

begin
  s1: entity work.rca_nbits
    generic map (8, 10 ns)
    port    map (a, b, cin, s, cout);

  process begin
            a <= x"55"; b <= x"55"; cin <= '1'; -- pruebas tiempos etc
            wait for 250 ns;                    -- Segun calculos con 210 ns es
                                                -- suficiente
            a <= x"00"; b <= x"00"; cin <= '0'; -- clear input signals
            wait for 250 ns;
          end process;
          end;
