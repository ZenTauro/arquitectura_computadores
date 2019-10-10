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

-- Sumador de 8 bit implementado usando 8 sumadores de 1 bit interconectados
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

            a <= x"AA"; b <= x"55"; cin <= '1'; -- pruebas tiempos etc
            wait for 250 ns;                    -- Segun calculos con 210 ns es
                                                -- suficiente
            a <= x"00"; b <= x"00"; cin <= '0'; -- clear input signals
            wait for 250 ns;
            wait;
          end process;
          end;

-- Sumador de 16 bit generado a partir de dos bloques de sumadores de 8 bit
architecture RCA_8x2 of RCAs is
  signal a,b,s : bit_vector (15 downto 0) := x"0000";
  signal cout, cin, c1 : bit := '0';

begin
  s1: entity work.rca_nbits -- Sumador de 8 bits encargado de sumar los bit mas bajos
    generic map (8, 10 ns)
    port    map (a (7 downto 0), b (7 downto 0), cin, s (7 downto 0), c1);
  s2: entity work.rca_nbits -- Sumador de 8 bits encargado de sumar los bit mas altos
    generic map (8, 10 ns)
    port    map (a (15 downto 8), b (15 downto 8), c1, s (15 downto 8), cout);

  process begin
            a <= x"5555"; b <= x"5555"; cin <= '1'; -- pruebas tiempos etc
            wait for 500 ns;

            a <= x"0000"; b <= x"0000"; cin <= '0'; -- clear input signals
            wait for 500 ns;

            a <= x"AAAA"; b <= x"5555"; cin <= '1'; -- pruebas tiempos etc
            wait for 500 ns;

            a <= x"0000"; b <= x"0000"; cin <= '0'; -- clear input signals
            wait for 500 ns;
            wait;
          end process;
          end;
