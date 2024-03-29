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

-- Definicion de sumador
entity sum_elemental is
  generic (tp: time);
  port (a,b,Cin: IN bit; S, Cout: OUT bit);
end;
architecture RTL6 of sum_elemental is
  signal g, p, x, y: bit;
begin
  g <= a and b   after tp;
  x <= a xor b   after tp;
  p <= a or  b   after tp;
  y <= p and Cin after tp;
  S <= x xor Cin after tp;

  Cout <= g or y after tp;
end;

-- Test Bench
entity sum_elemental_test is end;
architecture xxx of sum_elemental_test is
  signal a0, b0, s0, c0, c1 : bit := '0';
begin
  ss1: entity work.sum_elemental(RTL6) generic map (5 ns)
    port map(a0, b0, c0, s0, c1);

  process begin
            a0 <= '0'; b0 <= '0'; c0 <= '0';
            wait for 10 ns;
            a0 <= '0'; b0 <= '0'; c0 <= '1';
            wait;
  end process;
end;
