require 'lua-nucleo'

local tstr = import 'lua-nucleo/tstr.lua' { 'tstr' }

local DATA =
{
  {
    type = 'glue';

    {
      { 'Раз ', 'Если ', 'Коль ', 'Ежели ' };
      { 'Когда ', 'Только ', 'Может ', 'Сперва ' };
    };

    {
      { 'камень ', 'гром ', 'ветер ', 'дуб ' };
      { 'человек ', 'воин ', 'гончар ', 'кузнец ' };
    };

    {
      { 'мил ', 'крепок ', 'ладен ', 'красен ' };
      { 'молчит ', 'спит ', 'куролесит ', 'бдит ' };
    };

    '- ';

    {
      {
        'волна ', 'буря ', 'вода ', 'хурма ';
        'весна ', 'зима ', 'долма ', 'тьма ';
      };
      {
        'жена ', 'тёща ', 'сватья ', 'кума ' ;
        'золовка ', 'невестка ', 'сестра ', 'золвица ' ;
      };
    };

    {
      '';
      'не ';
    };

    {
      { 'сурова', 'могуча', 'обильна', 'крепка' };
      { 'шумит', 'крепчает', 'смурнеет', 'растет' };
    };

    '.';
  };

  {
    type = 'glue';

    {
      { 'Хорошему ', 'Доброму ', 'Смелому ', 'Быстрому ' };
      { 'Красному ', 'Белому ', 'Серому ', 'Чёрному ' };
      { 'Трусливому ', 'Плохому ', 'Злому ', 'Худому ' };
      { 'Ветхому ', 'Гнилому ', 'Старому ', 'Слабому ' };

      { 'Умелому ', 'Умному ', 'Удалому ', 'Статному ' };
      { 'Растерянному ', 'Потерянному ', 'Безумному ', 'Дурному ' };
      { 'Неумелому ', 'Глупому ', 'Хилому ', 'Толстому ' };
      { 'Любому ', 'Тому ', 'Этому ', 'Никакому ' };
    };

    {
      { 'змею ', 'волку ', 'барану ', 'козлу ' };
      { 'судье ', 'дьяку ', 'стряпчему ', 'голове ' };
      { 'солдату ', 'капитану ', 'майору ', 'генералу ' };
      { 'старосте ', 'крестьянину ', 'кулаку ', 'купцу ' };
    };

    'и ';

    {
      { 'старый ', 'ветхий ', 'утлый ', 'худой ' };
      { 'новый ', 'свежий ', 'сильный ', 'красный ' };
      { 'деревянный ', 'дубовый ', 'березовый ', 'осиновый ' };
      { 'стальной ', 'железный ', 'медный ', 'чугунный ' };
    };

    {
      { 'плот ', 'корабль ', 'чёлн ', 'баркас ' };
      { 'тарантас ', 'кабриолет ', 'гомеотелевтон ', 'экипаж ' };
      { 'топор ', 'палаш ', 'ятаган ', 'клинок ' };
      { 'плуг ', 'лемех ', 'буккер ', 'сошник ' }
    };

    {
      '';
      'не ';
    };

    {
      { 'впрок', 'лаком', 'мил', 'даром' };
      { 'лишний', 'зря', 'плохо', 'попусту' };
      { 'мешает', 'нужен', 'добр', 'отвратен' };
      { 'радостен', 'приятен', 'противен', 'гадок' };
    };

    '.';
  };

  {
    type = 'glue';

    'О ';

    {
      { 'друзья ', 'братья ', 'люди ', 'человеки ' };
      { 'родные ', 'ближние ' };
    };

    {
      { 'мои', 'истинные' };
      { 'ненавистные', 'завистливые', 'неискренние', 'лживые' };
    };

    ', да ';

    {
      '';
      'не';
    };

    {
      { 'возгордимся', 'восхитимся', 'возмечатем', 'воспарим' };
      { 'помиримся', 'успокоимся', 'сроднимся', 'сблизимся' };
    };

    '! ';

    {
      { 'Ведь ', 'Ибо ' };
      { 'Иначе ' };
    };

    {
      { 'неестественно', 'больно', 'страшно', 'умилительно' };
      { 'смерть', 'счастье', 'радость', 'жизнь' };
    };

    '.';
  };

  {
    type = 'glue';

    {
      { 'Сон ', 'Полёт ', 'Шум ', 'Хайп ' };
      { 'Сокол ', 'Орёл ', 'Лев ', 'Ястреб ' };
    };

    {
      '';
      'не';
    };

    'похож на ';

    {
      { 'омелу', 'боярышник', 'черемшу', 'кинзу' };
      { 'выдру', 'осла', 'человека', 'лесничего' };
    };

    ': ';

    {
      { 'дарит ', 'преподносит ' };
      { 'крадёт ', 'забирает ', 'отнимает ', 'тащит ' };
    };

    {
      { 'лишь ', 'только '};
      { 'даже ' };
    };

    {
      { 'миг', 'мгновение', 'минуту', 'момент' };
      { 'час', 'год', 'век', 'столетие' };
    };

    '...';
  };
}

local log2 = function(v)
  return math.log(v) / math.log(2)
end

local is_pow2 = function(v)
  return log2(v) % 1 == 0
end

local function check(node)
  if type(node) ~= 'table' then
    return
  end

  if node.type ~= 'glue' then
    if not is_pow2(#node) then
      error('wrong number of alternatives in ' .. tstr(node))
    end
  end

  for i = 1, #node do
    check(node[i])
  end
end

check(DATA)

local fromhex = function(str)
  return (str:gsub('..', function (cc)
    return string.char(
      (assert(
        tonumber(cc, 16), 'invalid hex character'
      ))
    )
  end))
end

local hasbit = function(x, p)
  p = 2 ^ (p - 1)
  return x % (p + p) >= p
end

local bitstream = function(bytes, default)
  default = default or false

  local unread = #bytes * 8

  local bit = coroutine.wrap(function()
    for i = 1, #bytes do
      local byte = bytes:sub(i, i):byte()
      for j = 8, 1, -1 do
        unread = unread - 1
        coroutine.yield(hasbit(byte, j))
      end
    end

    while true do
      unread = unread - 1
      coroutine.yield(default)
    end
  end)

  return
  {
    read = function(n)
      n = n or 1
      local result = 0
      for i = 1, n do
        local v = bit()
        if v then
          result = result + math.pow(2, i - 1)
        end
      end
      return result
    end;

    unread = function()
      return unread
    end;
  }
end

local render
do
  local function impl(node, bits)
    if type(node) ~= 'table' then
      io.write(tostring(node))
      return
    end

    if node.type == 'glue' then
      for i = 1, #node do
        impl(node[i], bits)
      end
      return
    end

    assert(is_pow2(#node))
    if #node == 1 then
      impl(node[1])
      return
    end

    local choice = bits.read(log2(#node)) + 1
    impl(node[choice], bits)
  end

  render = function(data, bits)
    while bits.unread() > 0 do
      impl(data, bits)

      -- Useful for debugging
      -- io.write('\t| ', bits.unread())

      io.write('\n')
    end
  end
end

-- git rev-parse --short=6 HEAD | xargs lua textgen.lua

local hex = select(1, ...)
if not hex then
  error('expected a hash (hex) string as a first argument')
end

if #hex % 2 ~= 0 then
  error('odd number of characters in the hash string')
end

local bits = bitstream(fromhex(hex))

render(DATA, bits)
