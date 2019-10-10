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

-- Sumador que combina n sumadores para poder sumar n bits e implementa el
-- acelerador CSK Carry SKip Adder

entity rca_nbits is
  generic (n: integer; tp: time);
  port (a, b: in  bit_vector (n - 1 downto 0); cin:  in bit;
           s: out bit_vector (n - 1 downto 0); cout: out bit);
end;

architecture xxx of sumador_csk_nbits is
  signal ci:  bit_vector (n downto 0);
  signal aux: bit_vector (n downto 0);
  signal P, and_skip: bit;
begin
  ci(0)  <= cin;
  aux(0) <= '1';

  gen: for I in 0 to n-1 generate
    add: entity work.sum_elemental(RTL6)
      generic  map(tp)
      port     map(a(I), b(I), ci(I), s(I), ci(I+1));
    aux(i+1) <= (a(i) or b(i)) and aux(i);
  end generate;

  P         <= aux(n)             after 2*tp;
  and_skip  <= P and cin          after   tp;
  cout      <= ci(n) or and_skip  after   tp;

  cout <= ci(n);
end xxx;
