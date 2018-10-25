@shardizard=ARGV.first.to_i              # taking a single variable from the command prompt to get the shard value
system("color 0#{"CBAE7"[@shardizard,1]}")
system("title loading #{['Man','Sky','Earth','Star','Beast'][@shardizard]} LizBot")

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0

@prefix=['liz!','liZ!','lIz!','lIZ!','Liz!','LiZ!','LIz!','LIZ!',
         'liz?','liZ?','lIz?','lIZ?','Liz?','LiZ?','LIz?','LIZ?',
         'fgo!','fgO!','fg0!','fGo!','fGO!','fG0!','Fgo!','FgO!','Fg0!','FGo!','FGO!','FG0!',
         'fgo?','fgO?','fg0?','fGo?','fGO?','fG0?','Fgo?','FgO?','Fg0?','FGo?','FGO?','FG0?',
         'fate!','fatE!','faTe!','faTE!','fAte!','fAtE!','fATe!','fATE!','Fate!','FatE!','FaTe!','FaTE!','FAte!','FAtE!','FATe!','FATE!',
         'fate?','fatE?','faTe?','faTE?','fAte?','fAtE?','fATe?','fATE?','Fate?','FatE?','FaTe?','FaTE?','FAte?','FAtE?','FATe?','FATE?']

# The bot's token is basically their password, so is censored for obvious reasons
bot = Discordrb::Commands::CommandBot.new token: '>Main Token<', shard_id: @shardizard, num_shards: 4, client_id: 502288364838322176, prefix: @prefix

@servants=[]
@skills=[]
@crafts=[]
@aliases=[]
@embedless=[]
@spam_channels=[]
@server_data=[]
@ignored=[]
@embedless=[]

def normalize(str) # used by the majority of commands that accept input, to replace all non-ASCII characters with their ASCII counterparts
  str=str.gsub(/\s+/,' ').gsub(/[[:space:]]+/,' ').gsub(/[[:cntrl:]]/,' ').gsub("``",'')
  str=str.gsub("\u2019","'").gsub("`","'").gsub("\u2018","'")
  str=str.gsub("\u{1F1E6}","A").gsub("\u{1F1E7}","B").gsub("\u{1F1E8}","C").gsub("\u{1F1E9}","D").gsub("\u{1F1EA}","E").gsub("\u{1F1EB}","F").gsub("\u{1F1EC}","G").gsub("\u{1F1ED}","H").gsub("\u{1F1EE}","I").gsub("\u{1F1EF}","J").gsub("\u{1F1F0}","K").gsub("\u{1F1F1}","L").gsub("\u{1F1F2}","M").gsub("\u{1F1F3}","N").gsub("\u{1F1F4}","O").gsub("\u{1F1F5}","P").gsub("\u{1F1F6}","Q").gsub("\u{1F1F7}","R").gsub("\u{1F1F8}","S").gsub("\u{1F1F9}","T").gsub("\u{1F1FA}","U").gsub("\u{1F1FB}","V").gsub("\u{1F1FC}","W").gsub("\u{1F1FD}","X").gsub("\u{1F1FE}","Y").gsub("\u{1F1FF}","Z")
  str=str.gsub("\u{1F170}",'A').gsub("\u{1F171}",'B').gsub("\u{1F18E}",'AB').gsub("\u{1F191}",'CL').gsub("\u2B55",'O').gsub("\u{1F17E}",'O').gsub("\u{1F198}",'SOS')
  str=str.gsub("\u00E1",'a').gsub("\u00C1",'a').gsub("\u0103",'a').gsub("\u01CE",'a').gsub("\u00C2",'a').gsub("\u00E2",'a').gsub("\u00C4",'a').gsub("\u00E4",'a').gsub("\u0227",'a').gsub("\u1EA1",'a').gsub("\u0201",'a').gsub("\u00C0",'a').gsub("\u00E0",'a').gsub("\u1EA3",'a').gsub("\u0203",'a').gsub("\u0101",'a').gsub("\u0105",'a').gsub("\u1E9A",'a').gsub("\u00C5",'a').gsub("\u00E5",'a').gsub("\u1E01",'a').gsub("\u023A",'a').gsub("\u00C3",'a').gsub("\u00E3",'a').gsub("\u0363",'a').gsub("\u1D00",'a').gsub("\u0251",'a').gsub("\u0250",'a').gsub("\u0252",'a').gsub("\u22C0",'a')
  str=str.gsub("\u00C6",'ae').gsub("\u1D01",'ae').gsub("\u00E6",'ae').gsub("\u1D02",'ae')
  str=str.gsub("\u1E03",'b').gsub("\u1E05",'b').gsub("\u0181",'b').gsub("\u0253",'b').gsub("\u1E07",'b').gsub("\u0243",'b').gsub("\u0180",'b').gsub("\u0183",'b').gsub("\u0299",'b').gsub("\u1D03",'b').gsub("\u212C",'b').gsub("\u0185",'b')
  str=str.gsub("\u0107",'c').gsub("\u010D",'c').gsub("\u00C7",'c').gsub("\u00E7",'c').gsub("\u0109",'c').gsub("\u0255",'c').gsub("\u010B",'c').gsub("\u0189",'c').gsub("\u023B",'c').gsub("\u023C",'c').gsub("\u2183",'c').gsub("\u212D",'c').gsub("\u0368",'c').gsub("\u2102",'c').gsub("\u1D04",'c').gsub("\u0297",'c').gsub("\u2184",'c')
  str=str.gsub("\u212D",'d').gsub("\u0256",'d').gsub("\u010F",'d').gsub("\u1E11",'d').gsub("\u1E13",'d').gsub("\u0221",'d').gsub("\u1E0B",'d').gsub("\u1E0D",'d').gsub("\u018A",'d').gsub("\u0257",'d').gsub("\u1E0F",'d').gsub("\u0111",'d').gsub("\u0256",'d').gsub("\u018C",'d').gsub("\u0369",'d').gsub("\u2145",'d').gsub("\u2146",'d').gsub("\u0189",'d').gsub("\u1D05",'d')
  str=str.gsub("\u00C9",'e').gsub("\u00E9",'e').gsub("\u0115",'e').gsub("\u011B",'e').gsub("\u0229",'e').gsub("\u1E19",'e').gsub("\u00CA",'e').gsub("\u00EA",'e').gsub("\u00CB",'e').gsub("\u00EB",'e').gsub("\u0117",'e').gsub("\u1EB9",'e').gsub("\u0205",'e').gsub("\u00C8",'e').gsub("\u00E8",'e').gsub("\u1EBB",'e').gsub("\u025D",'e').gsub("\u0207",'e').gsub("\u0113",'e').gsub("\u0119",'e').gsub("\u0246",'e').gsub("\u0247",'e').gsub("\u1E1B",'e').gsub("\u1EBD",'e').gsub("\u0364",'e').gsub("\u2147",'e').gsub("\u0190",'e').gsub("\u018E",'e').gsub("\u1D07",'e').gsub("\u029A",'e').gsub("\u025E",'e').gsub("\u0153",'e').gsub("\u025B",'e').gsub("\u0258",'e').gsub("\u025C",'e').gsub("\u01DD",'e').gsub("\u1D08",'e').gsub("\u2130",'e').gsub("\u212F",'e').gsub("\u0259",'e').gsub("\u018F",'e').gsub("\u22FF",'e')
  str=str.gsub("\u1E1F",'f').gsub("\u0192",'f').gsub("\u2131",'f').gsub("\u2132",'f').gsub("\u214E",'f')
  str=str.gsub("\u2640",'(f)')
  str=str.gsub("\u01F5",'g').gsub("\u011F",'g').gsub("\u01E7",'g').gsub("\u0123",'g').gsub("\u011D",'g').gsub("\u0121",'g').gsub("\u0193",'g').gsub("\u029B",'g').gsub("\u0260",'g').gsub("\u1E21",'g').gsub("\u01E5",'g').gsub("\u0262",'g').gsub("\u0261",'g').gsub("\u210A",'g').gsub("\u2141",'g')
  str=str.gsub("\u210C",'h').gsub("\u1E2B",'h').gsub("\u021F",'h').gsub("\u1E29",'h').gsub("\u0125",'h').gsub("\u1E27",'h').gsub("\u1E23",'h').gsub("\u1E25",'h').gsub("\u02AE",'h').gsub("\u0266",'h').gsub("\u1E96",'h').gsub("\u0127",'h').gsub("\u210C",'h').gsub("\u036A",'h').gsub("\u210D",'h').gsub("\u029C",'h').gsub("\u0265",'h').gsub("\u2095",'h').gsub("\u02B0",'h').gsub("\u210B",'h')
  str=str.gsub("\u2111",'i').gsub("\u0197",'i').gsub("\u0130",'i').gsub("\u00CD",'i').gsub("\u00ED",'i').gsub("\u012D",'i').gsub("\u01D0",'i').gsub("\u00CE",'i').gsub("\u00EE",'i').gsub("\u00CF",'i').gsub("\u00EF",'i').gsub("\u0130",'i').gsub("\u1CEB",'i').gsub("\u0209",'i').gsub("\u00CC",'i').gsub("\u00EC",'i').gsub("\u1EC9",'i').gsub("\u020B",'i').gsub("\u012B",'i').gsub("\u012F",'i').gsub("\u0197",'i').gsub("\u0268",'i').gsub("\u1E2D",'i').gsub("\u0129",'i').gsub("\u2111",'i').gsub("\u0365",'i').gsub("\u2148",'i').gsub("\u026A",'i').gsub("\u0131",'i').gsub("\u1D09",'i').gsub("\u1D62",'i').gsub("\u2110",'i').gsub("\u2071",'i').gsub("\u2139",'i').gsub("\uFE0F",'i').gsub("\u1FBE",'i').gsub("\u03B9",'i').gsub("\u0399",'i')
  str=str.gsub("\u0133",'ij')
  str=str.gsub("\u01F0",'j').gsub("\u0135",'j').gsub("\u029D",'j').gsub("\u0248",'j').gsub("\u0249",'j').gsub("\u025F",'j').gsub("\u2149",'j').gsub("\u1D0A",'j').gsub("\u0237",'j').gsub("\u02B2",'j')
  str=str.gsub("\u1E31",'k').gsub("\u01E9",'k').gsub("\u0137",'k').gsub("\u1E33",'k').gsub("\u0199",'k').gsub("\u1E35",'k').gsub("\u1D0B",'k').gsub("\u029E",'k').gsub("\u2096",'k').gsub("\u212A",'k').gsub("\u0138",'k')
  str=str.gsub("\u013A",'l').gsub("\u023D",'l').gsub("\u019A",'l').gsub("\u026C",'l').gsub("\u013E",'l').gsub("\u013C",'l').gsub("\u1E3D",'l').gsub("\u0234",'l').gsub("\u1E37",'l').gsub("\u1E3B",'l').gsub("\u0140",'l').gsub("\u026B",'l').gsub("\u026D",'l').gsub("\u1D0C",'l').gsub("\u0142",'l').gsub("\u029F",'l').gsub("\u2097",'l').gsub("\u02E1",'l').gsub("\u2143",'l').gsub("\u2112",'l').gsub("\u2113",'l').gsub("\u2142",'l')
  str=str.gsub("\u2114",'lb')
  str=str.gsub("\u264C",'leo')
  str=str.gsub("\u1E3F",'m').gsub("\u1E41",'m').gsub("\u1E43",'m').gsub("\u0271",'m').gsub("\u0270",'m').gsub("\u036B",'m').gsub("\u019C",'m').gsub("\u1D0D",'m').gsub("\u1D1F",'m').gsub("\u026F",'m').gsub("\u2098",'m').gsub("\u2133",'m')
  str=str.gsub("\u2642",'(m)')
  str=str.gsub("\u0144",'n').gsub("\u0148",'n').gsub("\u0146",'n').gsub("\u1E4B",'n').gsub("\u0235",'n').gsub("\u1E45",'n').gsub("\u1E47",'n').gsub("\u01F9",'n').gsub("\u019D",'n').gsub("\u0272",'n').gsub("\u1E49",'n').gsub("\u0220",'n').gsub("\u019E",'n').gsub("\u0273",'n').gsub("\u00D1",'n').gsub("\u00F1",'n').gsub("\u2115",'n').gsub("\u0274",'n').gsub("\u1D0E",'n').gsub("\u2099",'n').gsub("\u22C2",'n').gsub("\u220F",'n')
  str=str.gsub("\u00F3",'o').gsub("\u00F0",'o').gsub("\u00D3",'o').gsub("\u014F",'o').gsub("\u01D2",'o').gsub("\u00D4",'o').gsub("\u00F4",'o').gsub("\u00D6",'o').gsub("\u00F6",'o').gsub("\u022F",'o').gsub("\u1ECD",'o').gsub("\u0151",'o').gsub("\u020D",'o').gsub("\u00D2",'o').gsub("\u00F2",'o').gsub("\u1ECF",'o').gsub("\u01A1",'o').gsub("\u020F",'o').gsub("\u014D",'o').gsub("\u019F",'o').gsub("\u01EB",'o').gsub("\u00D8",'o').gsub("\u00F8",'o').gsub("\u1D13",'o').gsub("\u00D5",'o').gsub("\u00F5",'o').gsub("\u0366",'o').gsub("\u019F",'o').gsub("\u0186",'o').gsub("\u1D0F",'o').gsub("\u1D10",'o').gsub("\u0275",'o').gsub("\u1D11",'o').gsub("\u2134",'o').gsub("\u25CB",'o').gsub("\u00A4",'o')
  str=str.gsub("\u1D14",'oe').gsub("\u0153",'oe').gsub("\u0276",'oe')
  str=str.gsub("\u01A3",'oi')
  str=str.gsub("\u0223",'ou').gsub("\u1D15",'ou')
  str=str.gsub("\u1E55",'p').gsub("\u1E57",'p').gsub("\u01A5",'p').gsub("\u2119",'p').gsub("\u1D18",'p').gsub("\u209A",'p').gsub("\u2118",'p').gsub("\u214C",'p')
  str=str.gsub("\u024A",'q').gsub("\u024B",'q').gsub("\u02A0",'q').gsub("\u211A",'q').gsub("\u213A",'q')
  str=str.gsub("\u0239",'qp')
  str=str.gsub("\u211C",'r').gsub("\u0155",'r').gsub("\u0159",'r').gsub("\u0157",'r').gsub("\u1E59",'r').gsub("\u1E5B",'r').gsub("\u0211",'r').gsub("\u027E",'r').gsub("\u027F",'r').gsub("\u027B",'r').gsub("\u0213",'r').gsub("\u1E5F",'r').gsub("\u027C",'r').gsub("\u027A",'r').gsub("\u024C",'r').gsub("\u024D",'r').gsub("\u027D",'r').gsub("\u036C",'r').gsub("\u211D",'r').gsub("\u0280",'r').gsub("\u0281",'r').gsub("\u1D19",'r').gsub("\u1D1A",'r').gsub("\u0279",'r').gsub("\u1D63",'r').gsub("\u02B3",'r').gsub("\u02B6",'r').gsub("\u02B4",'r').gsub("\u211B",'r').gsub("\u01A6",'r')
  str=str.gsub("\u301C",'roy')
  str=str.gsub("\u015B",'s').gsub("\u0161",'s').gsub("\u015F",'s').gsub("\u015D",'s').gsub("\u0219",'s').gsub("\u1E61",'s').gsub("\u1E63",'s').gsub("\u0282",'s').gsub("\u023F",'s').gsub("\u209B",'s').gsub("\u02E2",'s').gsub("\u1E9B",'s').gsub("\u223E",'s').gsub("\u017F",'s').gsub("\u00DF",'s')
  str=str.gsub("\u0165",'t').gsub("\u0163",'t').gsub("\u1E71",'t').gsub("\u021B",'t').gsub("\u0236",'t').gsub("\u1E97",'t').gsub("\u023E",'t').gsub("\u1E6B",'t').gsub("\u1E6D",'t').gsub("\u01AD",'t').gsub("\u1E6F",'t').gsub("\u01AB",'t').gsub("\u01AE",'t').gsub("\u0288",'t').gsub("\u0167",'t').gsub("\u036D",'t').gsub("\u1D1B",'t').gsub("\u0287",'t').gsub("\u209C",'t')
  str=str.gsub("\u00FE",'th')
  str=str.gsub("\u00FA",'u').gsub("\u028A",'u').gsub("\u22C3",'u').gsub("\u0244",'u').gsub("\u0289",'u').gsub("\u00DA",'u').gsub("\u1E77",'u').gsub("\u016D",'u').gsub("\u01D4",'u').gsub("\u00DB",'u').gsub("\u00FB",'u').gsub("\u1E73",'u').gsub("\u00DC",'u').gsub("\u00FC",'u').gsub("\u1EE5",'u').gsub("\u0171",'u').gsub("\u0215",'u').gsub("\u00D9",'u').gsub("\u00F9",'u').gsub("\u1EE7",'u').gsub("\u01B0",'u').gsub("\u0217",'u').gsub("\u016B",'u').gsub("\u0173",'u').gsub("\u016F",'u').gsub("\u1E75",'u').gsub("\u0169",'u').gsub("\u0367",'u').gsub("\u1D1C",'u').gsub("\u1D1D",'u').gsub("\u1D1E",'u').gsub("\u1D64",'u')
  str=str.gsub("\u22C1",'v').gsub("\u030C",'v').gsub("\u1E7F",'v').gsub("\u01B2",'v').gsub("\u028B",'v').gsub("\u1E7D",'v').gsub("\u036E",'v').gsub("\u01B2",'v').gsub("\u0245",'v').gsub("\u1D20",'v').gsub("\u028C",'v').gsub("\u1D65",'v')
  str=str.gsub("\u1E83",'w').gsub("\u0175",'w').gsub("\u1E85",'w').gsub("\u1E87",'w').gsub("\u1E89",'w').gsub("\u1E81",'w').gsub("\u1E98",'w').gsub("\u1D21",'w').gsub("\u028D",'w').gsub("\u02B7",'w')
  str=str.gsub("\u2715",'x').gsub("\u2716",'x').gsub("\u2A09",'x').gsub("\u033D",'x').gsub("\u0353",'x').gsub("\u1E8D",'x').gsub("\u1E8B",'x').gsub("\u2717",'x').gsub("\u036F",'x').gsub("\u2718",'x').gsub("\u2A09",'x').gsub("\u02E3",'x').gsub("\u2A09",'x')
  str=str.gsub("\u00DD",'y').gsub("\u00FD",'y').gsub("\u0177",'y').gsub("\u0178",'y').gsub("\u00FF",'y').gsub("\u1E8F",'y').gsub("\u1EF5",'y').gsub("\u1EF3",'y').gsub("\u1EF7",'y').gsub("\u01B4",'y').gsub("\u0233",'y').gsub("\u1E99",'y').gsub("\u024E",'y').gsub("\u024F",'y').gsub("\u1EF9",'y').gsub("\u028F",'y').gsub("\u028E",'y').gsub("\u02B8",'y').gsub("\u2144",'y').gsub("\u00A5",'y')
  str=str.gsub("\u01B6",'z').gsub("\u017A",'z').gsub("\u017E",'z').gsub("\u1E91",'z').gsub("\u0291",'z').gsub("\u017C",'z').gsub("\u1E93",'z').gsub("\u0225",'z').gsub("\u1E95",'z').gsub("\u0290",'z').gsub("\u01B6",'z').gsub("\u0240",'z').gsub("\u2128",'z').gsub("\u2124",'z').gsub("\u1D22",'z')
  return str
end

def longFormattedNumber(number,cardinal=false)
  if cardinal
    k='th'
    unless (number%100)/10==1
      k='st' if number%10==1
      k='nd' if number%10==2
      k='rd' if number%10==3
    end
    return "#{longFormattedNumber(number,false)}#{k}"
  end
  return "#{number}" if number<1000
  if number<1000
    bob="#{number%1000}"
  elsif number%1000<10
    bob="00#{number%1000}"
  elsif number%1000<100
    bob="0#{number%1000}"
  elsif number%1000<1000
    bob="#{number%1000}"
  end
  while number>1000
    number=number/1000
    if number<1000
      bob="#{number%1000},#{bob}"
    elsif number%1000<10
      bob="00#{number%1000},#{bob}"
    elsif number%1000<100
      bob="0#{number%1000},#{bob}"
    elsif number%1000<1000
      bob="#{number%1000},#{bob}"
    end
  end
  return bob
end

def create_embed(event,header,text,xcolor=nil,xfooter=nil,xpic=nil,xfields=nil,mode=0)
  ftrlnth=0
  ftrlnth=xfooter.length unless xfooter.nil?
  ch_id=0
  if event.is_a?(Array)
    ch_id=event[1]
    event=event[0]
  end
  if @embedless.include?(event.user.id) || (was_embedless_mentioned?(event) && ch_id==0)
    str=''
    if header.length>0
      if header.include?('*') || header.include?('_')
        str=header
      else
        str="__**#{header.gsub('!','')}**__"
      end
    end
    unless text.length<=0
      str="#{str}\n" unless text[0,2]=='<:'
      str="#{str}\n#{text}"
      str="#{str}\n" unless [text[text.length-1,1],text[text.length-2,2]].include?("\n")
    end
    unless xfields.nil?
      if mode.zero?
        for i in 0...xfields.length
          k="__#{xfields[i][0]}:__ #{xfields[i][1].gsub("\n",' / ')}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      elsif [-1,1].include?(mode)
        if mode==-1
          last_field=xfields[xfields.length-1][1].split("\n").join("\n")
          last_field_name=xfields[xfields.length-1][0].split("\n").join("\n")
          xfields.pop
        end
        atk=xfields[0][1].split("\n")[1].split(': ')[0]
        statnames=['<:HP_S:467037520538894336> HP: ',"#{atk}: ",'<:SpeedS:467037520534962186> Speed: ','<:DefenseS:467037520249487372> Defense: ','<:ResistanceS:467037520379641858> Resistance: ','BST: ']
        fields=[[],['**<:HP_S:467037520538894336> HP:**'],["**#{atk}:**"],['**<:SpeedS:467037520534962186> Speed:**'],['**<:DefenseS:467037520249487372> Defense:**'],['**<:ResistanceS:467037520379641858> Resistance:**'],['**BST:**']]
        for i in 0...xfields.length
          fields[0].push(xfields[i][0])
          flumb=xfields[i][1].split("\n")
          flumb[5]=nil
          flumb.compact!
          for j in 0...flumb.length
            if i.zero?
              fields[j+1][0]="#{fields[j+1][0]}  #{flumb[j].gsub(statnames[j],'').gsub('GPT: ','')}"
            else
              fields[j+1].push(flumb[j].gsub(statnames[j],'').gsub('GPT: ',''))
            end
          end
        end
        str="#{str}\n"
        for i in 0...fields.length
          k=fields[i].join(' / ')
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
        if mode==-1
          k="\n__**#{last_field_name.gsub('**','')}**__\n#{last_field}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      elsif mode==-2
        last_field=xfields[xfields.length-1][1].split("\n").join("\n")
        last_field_name=xfields[xfields.length-1][0].split("\n").join("\n")
        emo=last_field.split("\n")[1].split(' ')[0]
        xfields.pop
        atk=xfields[0][1].split("\n")[2].split(': ')[0]
        statnames=['HP: ',"#{atk}: ",'Speed: ','Defense: ','Resistance: ','BST: ']
        fields=[[],['**<:HP_S:467037520538894336> HP:**'],["**#{emo} #{atk}:**"],['**<:SpeedS:467037520534962186> Speed:**'],['**<:DefenseS:467037520249487372> Defense:**'],['**<:ResistanceS:467037520379641858> Resistance:**'],['**BST:**']]
        for i in 0...xfields.length
          fields[0].push(xfields[i][0])
          flumb=xfields[i][1].split("\n")
          flumb.shift
          flumb[5]=nil
          flumb.compact!
          for j in 0...flumb.length
            if i.zero?
              fields[j+1][0]="#{fields[j+1][0]}  #{flumb[j].gsub(statnames[j],'').gsub('GPT: ','')}"
            else
              fields[j+1].push(flumb[j].gsub(statnames[j],'').gsub('GPT: ',''))
            end
          end
        end
        str="#{str}\n"
        for i in 0...fields.length
          k=fields[i].join(' / ')
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
        str="#{str}\n"
        k="__**#{last_field_name.gsub('**','')}**__\n#{last_field}"
        if str.length+k.length>=1900
          if ch_id==1
            event.user.pm(str)
          else
            event.channel.send_message(str)
          end
          str=k
        else
          str="#{str}\n#{k}"
        end
      elsif mode==3
        for i in 0...xfields.length
          k="__#{xfields[i][0]}:__ #{xfields[i][1].gsub("\n",', ')}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      elsif mode==4
        for i in 0...xfields.length
          k="**#{xfields[i][0]}:** #{xfields[i][1].gsub("\n",', ')}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      elsif mode==5
        for i in 0...xfields.length-1
          k="**#{xfields[i][0]}:** #{xfields[i][1].gsub("\n",' / ')}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
        i=xfields.length-1
        str="#{str}\n**#{xfields[i][0]}:**"
        m=xfields[i][1].split("\n\n").map{|q| q.split("\n")}
        for i in 0...m.length
          if m[i].length<=1
            k="*#{m[i][0]}*"
          else
            k="*#{m[i][0]}*: #{m[i][1,m[i].length-1].join(' / ')}"
          end
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str)
            else
              event.channel.send_message(str)
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      else
        for i in 0...xfields.length
          k="\n#{xfields[i][0]}\n#{xfields[i][1]}"
          if str.length+k.length>=1900
            if ch_id==1
              event.user.pm(str.gsub("```\n\n","```"))
            else
              event.channel.send_message(str.gsub("```\n\n","```"))
            end
            str=k
          else
            str="#{str}\n#{k}"
          end
        end
      end
    end
    k=''
    k="\n#{xfooter}" unless xfooter.nil?
    if str.length+k.length>=1900
      if ch_id==1
        event.user.pm(str.gsub("```\n\n","```"))
        event.user.pm(k.gsub("```\n\n","```"))
      else
        event.channel.send_message(str.gsub("```\n\n","```"))
        event.channel.send_message(k.gsub("```\n\n","```"))
      end
    elsif ch_id==1
      event.user.pm("#{str}\n#{k}".gsub("```\n\n","```"))
    else
      event.channel.send_message("#{str}\n#{k}".gsub("```\n\n","```"))
    end
  elsif !xfields.nil? && ftrlnth+header.length+text.length+xfields.map{|q| "#{q[0]}\n\n#{q[1]}"}.length>=1950 && ch_id==1
    event.user.pm.send_embed(header) do |embed|
      embed.description=text
      embed.color=xcolor unless xcolor.nil?
    end
    event.user.pm.send_embed('') do |embed|
      embed.description=''
      embed.thumbnail=Discordrb::Webhooks::EmbedThumbnail.new(url: xpic) unless xpic.nil?
      embed.color=xcolor unless xcolor.nil?
      embed.footer={"text"=>xfooter} unless xfooter.nil?
      unless xfields.nil?
        for i in 0...xfields.length
          embed.add_field(name: xfields[i][0].gsub('**',''), value: xfields[i][1], inline: xfields[i][2].nil?)
        end
      end
    end
  elsif !xfields.nil? && ftrlnth+header.length+text.length+xfields.map{|q| "#{q[0]}\n\n#{q[1]}"}.length>=1950
    event.channel.send_embed(header) do |embed|
      embed.description=text
      embed.color=xcolor unless xcolor.nil?
    end
    event.channel.send_embed('') do |embed|
      embed.description=''
      embed.thumbnail=Discordrb::Webhooks::EmbedThumbnail.new(url: xpic) unless xpic.nil?
      embed.color=xcolor unless xcolor.nil?
      embed.footer={"text"=>xfooter} unless xfooter.nil?
      unless xfields.nil?
        for i in 0...xfields.length
          embed.add_field(name: xfields[i][0].gsub('**',''), value: xfields[i][1], inline: xfields[i][2].nil?)
        end
      end
    end
  elsif ch_id==1
    event.user.pm.send_embed(header) do |embed|
      embed.description=text
      embed.color=xcolor unless xcolor.nil?
      embed.footer={"text"=>xfooter} unless xfooter.nil?
      unless xfields.nil?
        for i in 0...xfields.length
          embed.add_field(name: xfields[i][0].gsub('**',''), value: xfields[i][1], inline: xfields[i][2].nil?)
        end
      end
      embed.thumbnail=Discordrb::Webhooks::EmbedThumbnail.new(url: xpic) unless xpic.nil?
    end
  else
    event.channel.send_embed(header) do |embed|
      embed.description=text
      embed.color=xcolor unless xcolor.nil?
      embed.footer={"text"=>xfooter} unless xfooter.nil?
      unless xfields.nil?
        for i in 0...xfields.length
          embed.add_field(name: xfields[i][0].gsub('**',''), value: xfields[i][1], inline: xfields[i][2].nil?)
        end
      end
      embed.thumbnail=Discordrb::Webhooks::EmbedThumbnail.new(url: xpic) unless xpic.nil?
    end
  end
  return nil
end

def extend_message(msg1,msg2,event,enters=1,sym="\n")
  if "#{msg1}#{sym*enters}#{msg2}".length>=2000
    event.respond msg1
    return msg2
  else
    return "#{msg1}#{sym*enters}#{msg2}"
  end
end

def was_embedless_mentioned?(event) # used to detect if someone who wishes to see responses as plaintext is relevant to the information being displayed
  for i in 0...@embedless.length
    return true if event.user.id==@embedless[i]
    return true if event.message.text.include?("<@#{@embedless[i].to_s}>")
    return true if event.message.text.include?("<@!#{@embedless[i].to_s}>")
  end
  return false
end

def safe_to_spam?(event) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504].include?(event.server.id) # it is safe to spam in the emoji servers
  return true if ['bots','bot'].include?(event.channel.name.downcase) # channels named "bots" are safe to spam in
  return true if event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('spam') # it is safe to spam in any bot spam channel
  return true if event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('command') # it is safe to spam in any bot spam channel
  return true if event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('channel') # it is safe to spam in any bot spam channel
  return true if event.channel.name.downcase.include?('lizbot')  # it is safe to spam in channels designed specifically for LizBot
  return true if event.channel.name.downcase.include?('liz-bot')
  return true if event.channel.name.downcase.include?('liz_bot')
  return true if @spam_channels.include?(event.channel.id)
  return false
end

def first_sub(master,str1,str2,mode=0)
  master=master.gsub('!','') if mode==0
  posit=master.downcase.index(str1.downcase)
  return master if posit.nil?
  return "#{master[0,posit] if posit>0}#{str2}#{master[posit+str1.length,master.length] if posit+str1.length<master.length}"
end

def count_in(arr,str,mode=0) # used to count the number of times a skill is mentioned
  if str.is_a?(Array)
    return arr.count{|x| str.map{|y| y.downcase}.include?(x.downcase)}
  elsif arr.is_a?(String)
    return arr.chars.count{|x| x.downcase==str.downcase}
  end
  return arr.count{|x| x[0,str.length].downcase==str.downcase} if mode==1
  return arr.count{|x| x.downcase==str.downcase}
end

def remove_format(s,format)
  if format.length==1
    s=s.gsub("#{'\\'[0,1]}#{format}",'')
  else
    s=s.gsub("#{'\\'[0,1]}#{format}",format[1,format.length-1])
  end
  for i in 0...[s.length,25].min
    f=s.index(format)
    unless f.nil?
      f2=s.index(format,f+format.length)
      unless f2.nil?
        s="#{s[0,f]}|#{s[f2+format.length,s.length-f2-format.length+1]}"
      end
    end
  end
  return s
end

def list_lift(a,c)
  if a.length==1
    return a[0]
  elsif a.length==2
    return "#{a[0]} #{c} #{a[1]}"
  else
    b=a[a.length-1]
    a.pop
    a.uniq!
    return "#{a.join(', ')}, #{c} #{b}"
  end
end

def supersort(a,b,m,n=nil)
  unless n.nil?
    return supersort(a,b,0) if n<0
    if a[m][n].is_a?(String) && b[m][n].is_a?(String)
      return b[m][n].downcase <=> a[m][n].downcase
    elsif a[m][n].is_a?(String)
      return -1
    elsif b[m][n].is_a?(String)
      return 1
    else
      return a[m][n] <=> b[m][n]
    end
  end
  if a[m].is_a?(String) && b[m].is_a?(String)
    return b[m].downcase <=> a[m].downcase
  elsif a[m].is_a?(String)
    return -1
  elsif b[m].is_a?(String)
    return 1
  else
    return a[m] <=> b[m]
  end
end

def triple_finish(list,forcetwo=false) # used to split a list into three roughly-equal parts for use in embeds
  return [['.',list.join("\n")]] if list.length<5
  if list.length<10 || forcetwo
    l=0
    l=1 if list.length%2==1
    p1=list[0,list.length/2+l].join("\n")
    p2=list[list.length/2+l,list.length/2].join("\n")
    return [['.',p1],['.',p2]]
  end
  l=0
  l=1 if list.length%3==2
  m=0
  m=1 if list.length%3==1
  p1=list[0,list.length/3+l].join("\n")
  p2=list[list.length/3+l,list.length/3+m].join("\n")
  p3=list[2*(list.length/3)+l+m,list.length/3+l].join("\n")
  return [['.',p1],['.',p2],['.',p3]]
end

def data_load()
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][0]=b[i][0].to_f
    b[i][0]=b[i][0].to_i if b[i][0]>1.9
    b[i][3]=b[i][3].to_i
    b[i][5]=b[i][5].to_i
    b[i][6]=b[i][6].split(', ').map{|q| q.to_i}
    b[i][7]=b[i][7].split(', ').map{|q| q.to_i}
    for j in 0...3
      b[i][6][j]=0 if b[i][6][j].nil?
      b[i][7][j]=0 if b[i][7][j].nil?
    end
    b[i][8]=b[i][8].split(', ')
    b[i][8][0]=b[i][8][0].to_f
    b[i][8][1]=b[i][8][1].to_i
    b[i][8][2]=b[i][8][2].to_f unless b[i][8][2].nil?
    b[i][8][3]='NP' if b[i][8][3].nil? && !b[i][8][2].nil?
    b[i][9]=b[i][9].split(', ').map{|q| q.to_i}
    for j in 0...5
      b[i][9][j]=0 if b[i][9][j].nil?
    end
    b[i][10]=b[i][10].split(', ')
    b[i][10][0]=b[i][10][0].to_i
    b[i][10][1]=b[i][10][1].to_f
    for j in 0...2
      b[i][8][j]=0 if b[i][8][j].nil?
      b[i][10][j]=0 if b[i][10][j].nil?
    end
    b[i][11]=b[i][11].to_f
    b[i][13]=b[i][13].split(', ')
    b[i][14]=b[i][14].split('; ').map{|q| q.split(', ')}
    b[i][15]=b[i][15].split(', ')
    b[i][18]=b[i][18].split('; ').map{|q| q.split(', ')}
    b[i][19]=b[i][19].split('; ').map{|q| q.split(', ')}
    b[i][21]=b[i][21].to_i
    b[i][23]=b[i][23].to_i
  end
  @servants=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOSkills.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOSkills.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    if b[i][2]=='Skill'
      b[i][3]=b[i][3].to_i
      for i2 in 4...10
        b[i][i2]=b[i][i2].split(';; ')
      end
    elsif b[i][2]=='Noble'
      for i2 in 7...17
        b[i][i2]=b[i][i2].split(';; ')
      end
    end
  end
  @skills=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOCraftEssances.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOCraftEssances.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][0]=b[i][0].to_i
    b[i][2]=b[i][2].to_i
    b[i][3]=b[i][3].to_i
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(', ').map{|q| q.to_i}
  end
  @crafts=b.map{|q| q}
end

def metadata_load()
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOSave.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOSave.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[[168592191189417984, 256379815601373184],[],[[0,0,0,0,0],[0,0,0,0,0]],[]]
  end
  @embedless=b[0]
  @embedless=[168592191189417984, 256379815601373184] if @embedless.nil?
  @ignored=b[1]
  @ignored=[] if @ignored.nil?
  @server_data=b[2]
  @server_data=[[0,0,0,0,0],[0,0,0,0,0]] if @server_data.nil?
  @spam_channels=b[3]
  @spam_channels=[] if @spam_channels.nil?
end

def metadata_save()
  x=[@embedless.map{|q| q}, @ignored.map{|q| q}, @server_data.map{|q| q}, @spam_channels.map{|q| q}]
  open('C:/Users/Mini-Matt/Desktop/devkit/FGOSave.txt', 'w') { |f|
    f.puts x[0].to_s
    f.puts x[1].to_s
    f.puts x[2].to_s
    f.puts x[3].to_s
    f.puts "\n"
  }
end

def nicknames_load(mode==1)
  if mode==2 && File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt').each_line do |line|
      b.push(eval line)
    end
    return b
  elsif File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  @aliases=b.reject{|q| q.nil? || q[1].nil?}.uniq
end

def micronumber(n)
  m=["\u2080","\u2081","\u2082","\u2083","\u2084","\u2085","\u2086","\u2087","\u2088","\u2089"]
  return "\uFE63#{micronumber(0-n)}" if n<0
  return "#{micronumber(n/10)}#{m[n%10]}" if n>9
  return m[n]
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Liz
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'FGO!reboot'
  exec "cd C:/Users/Mini-Matt/Desktop/devkit && LizBot.rb 0"
end

bot.command([:help,:commands,:command_list,:commandlist]) do |event, command, subcommand|
  command='' if command.nil?
  k=0
  k=event.server.id unless event.server.nil?
  if ['help','commands','command_list','commandlist'].include?(command.downcase)
    event.respond "The `#{command.downcase}` command displays this message:"
    command=''
  end
  if command.downcase=='reboot'
    create_embed(event,'**reboot**',"Reboots this shard of the bot, installing any updates.\n\n**This command is only able to be used by Rot8er_ConeX**",0x008b8b)
  elsif command.downcase=='sendmessage'
    create_embed(event,'**sendmessage** __channel id__ __*message__',"Sends the message `message` to the channel with id `channel`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='leaveserver'
    create_embed(event,'**leaveserver** __server id number__',"Forces me to leave the server with the id `server id`.\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='shard'
    create_embed(event,'**shard**','Returns the shard that this server is served by.',0xED619A)
  elsif ['bugreport','suggestion','feedback'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __*message__",'PMs my developer with your username, the server, and the contents of the message `message`',0xED619A)
  elsif command.downcase=='addalias'
    create_embed(event,'**addalias** __new alias__ __servant__',"Adds `new alias` to `servant`'s aliases.\nIf the arguments are listed in the opposite order, the command will auto-switch them.\n\nInforms you if the alias already belongs to someone.\nAlso informs you if the servant you wish to give the alias to does not exist.",0xC31C19)
  elsif ['deletealias','removealias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __alias__",'Removes `alias` from the list of aliases, regardless of who it was for.',0xC31C19)
  elsif ['backupaliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Backs up the alias list.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['restorealiases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Restores the the alias, from last backup.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['safe','spam','safetospam','safe2spam','long','longreplies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __toggle__","Responds with whether or not the channel the command is invoked in is one in which I can send extremely long replies.\n\nIf the channel does not fill one of the many molds for acceptable channels, server mods can toggle the ability with the words \"on\" and \"off\".",0xED619A)
  elsif ['status'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*message__","Sets my status to `message`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['servant','data','unit'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and other relevant data.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Fou modifiers",0xED619A)
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(command.downcase) || (['stat','stats'].include?(command.downcase) && ['tiny','small','micro','smol','squashed','little'].include?("#{subcommand}".downcase))
    create_embed(event,"**#{command.downcase}#{" #{subcommand.downcase}" if ['stat','stats'].include?(command.downcase)}** __name__","Shows `name`'s stats, in a condensed format.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Silver Fou modifiers.\nInclude the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['stats','stat'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Fou modifiers.\n\nIf it is not safe to spam, this command automatically reverts to the `smol` command, and thus you need to include the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['traits','trait'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s traits.",0xED619A)
  elsif ['skills'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s skills.\n\nIf it is safe to spam, each skill will also be given additional information.",0xED619A)
  elsif ['np','noble','phantasm','noblephantasm'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Noble Phantasm.\n\nIf it is not safe to spam, I will show the effects for only the default NP level, and it can be adjusted to show other NP levels based on included arguments in the format \"NP#{rand(5)+1}\"\nIf it is safe to spam, I will show all the effects naturally.",0xED619A)
  elsif ['embed','embeds'].include?(command.downcase)
    event << '**embed**'
    event << ''
    event << 'Toggles whether I post as embeds or plaintext when the invoker triggers a response from me.  By default, I display embeds for everyone.'
    event << 'This command is useful for people who, in an attempt to conserve phone data, disable the automatic loading of images, as this setting also affects their ability to see embeds.'
    unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
      event << ''
      event << 'This help window is not in an embed so that people who need this command can see it.'
    end
    return nil
  elsif ['aliases','checkaliases','seealiases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __servant__","Responds with a list of all `servant`'s aliases.\nIf no servant is listed, responds with a list of all aliases and who they are for.\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
  elsif command.downcase=='snagstats'
    subcommand='' if subcommand.nil?
    if ['server','servers','member','members','shard','shards','users','user'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",'Returns the number of servers and unique members each shard reaches.',0xED619A)
    elsif ['unit','char','character','units','chars','charas','chara','servant','servants'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",">Currently unavailable<",0xED619A)
    elsif ['alias','aliases','name','names','nickname','nicknames'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of aliases in each of the two categories - global single-servant, and server-specific single-servant.\nAlso returns specifics about the most frequent instances of each category",0xED619A)
    elsif ['code','lines','line','sloc'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the specifics about my code, including number of commands and functions, as well as - if in PM - loops, statements, and conditionals.",0xED619A)
    else
      create_embed(event,"**#{command.downcase}**","Returns:\n- the number of servers I'm in\n- the numbers of servants in the game\n- the numbers of aliases I keep track of\n- how long of a file I am.\n\nYou can also include the following words to get more specialized data:\nServer(s), Member(s), Shard(s), User(s)\nServant(s), Unit(s), Character(s), Char(a)(s)\nAlias(es), Name(s), Nickname(s)\nCode, Line(s), SLOC#{"\n\nAs the bot developer, you can also include a server ID number to snag the shard number, owner, and my nickname in the specified server." if event.user.id==167657750971547648}",0xED619A)
    end
  else
    x=0
    x=1 unless safe_to_spam?(event)
    if command.downcase=='here'
      x=0
      command=''
    end
    event.respond "#{command.downcase} is not a command" if command!='' && command.downcase != 'devcommands'
    create_embed([event,x],"Command Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0')}.map {|s| "`#{s}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n__**Liz Bot help**__","__**Servant data**__\n`servant` __name__ - displays all info about a servant (*also `data`*)\n`stats` __name__ - displays a servant's stats\n`traits` __name__ - displays a servant's traits\n`skills` __name__ - displays a servant's skills\n`np` __name__ - displays a servant's Noble Phantasm\n`aliases` __name__ - displays a servant's aliases\n\n__**Meta Data**__\n`invite` - for a link to invite me to your server\n`snagstats` __type__ - to receive relevant bot stats\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)\n\n__**Developer Information**__\n`bugreport` __\\*message__ - to send my developer a bug report\n`suggestion` __\\*message__ - to send my developer a feature suggestion\n`feedback` __\\*message__ - to send my developer other kinds of feedback\n~~the above three commands are actually identical, merely given unique entries to help people find them~~",0xED619A)
    create_embed([event,x],"__**Server Admin Commands**__","__**Unit Aliases**__\n`addalias` __new alias__ __unit__ - Adds a new server-specific alias\n~~`aliases` __unit__ (*also `checkaliases` or `seealiases`*)~~\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias",0xC31C19) if is_mod?(event.user,event.server,event.channel)
    create_embed([event,x],"__**Bot Developer Commands**__","__**Mjolnr, the Hammer**__\n`ignoreuser` __user id number__ - makes me ignore a user\n`leaveserver` __server id number__ - makes me leave a server\n\n__**Communication**__\n`status` __\\*message__ - sets my status\n`sendmessage` __channel id__ __\\*message__ - sends a message to a specific channel\n`sendpm` __user id number__ __\\*message__ - sends a PM to a user\n\n__**Server Info**__\n`snagstats` - snags relevant bot stats\n\n__**Shards**__\n`reboot` - reboots this shard\n\n__**Meta Data Storage**__\n`backupaliases` - backs up the alias list\n`restorealiases` - restores the alias list from last backup\n`sortaliases` - sorts the alias list by servant",0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || @shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0')}.map {|s| "`#{s}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0')}.map {|s| "`#{s}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `FGO!help here`." if x==1
  end
end

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['help','servant','addalias','aliases','checkaliases','seealiases','deletealias','removealias','sortaliases','status','bugreport','suggestion','feedback',
     'sendmessage','sendpm','leaveserver','cleanupaliases','serveraliases','saliases','backupaliases','snagstats','reboot','help','commands','command_list',
     'commandlist','tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed',
     'statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small',
     'micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little','stats','stat','traits','trait','skills','np','noble','phantasm',
     'noblephantasm']
  k=['addalias','deletealias','removealias'] if permissions==1
  k=['sortaliases','status','sendmessage','sendpm','leaveserver','cleanupaliases','backupaliases','reboot'] if permissions==2
  k.push(nil) if include_nil
  return k
end

def find_servant(name,event)
  data_load()
  name=normalize(name)
  if name.to_i.to_s==name && name.to_i<=@servants[-1][0]
    return @servants[@servants.find_index{|q| q[0]==name.to_i}]
  elsif name.to_f.to_s==name && name.to_f<2
    return @servants[@servants.find_index{|q| q[0]==name.to_f}]
  end
  if name[0,1]=='#'
    name2=name[1,name.length-1]
    if name2.to_i.to_s==name2 && name2.to_i<=@servants[-1][0]
      return @servants[@servants.find_index{|q| q[0]==name2.to_i}]
    elsif name2.to_f.to_s==name2 && name2.to_f<2
      return @servants[@servants.find_index{|q| q[0]==name2.to_f}]
    end
  end
  return [] if name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').length<2
  k=@servants.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')==name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')}
  return @servants[k] unless k.nil?
  nicknames_load()
  g=0
  g=event.server.id unless event.server.nil?
  k=@aliases.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')==name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','') && (q[2].nil? || q[2].include?(g))}
  return @servants[@servants.find_index{|q| q[0]==@aliases[k][1]}] unless k.nil?
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')
  k=@servants.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')[0,name.length]==name}
  return @servants[k] unless k.nil?
  nicknames_load()
  for i in name.length...@aliases.map{|q| q[0].length}.max
    k=@aliases.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return @servants[@servants.find_index{|q| q[0]==@aliases[k][1]}] unless k.nil?
  end
  return []
end

def find_servant_ex(name,event)
  k=find_servant(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_servant(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def disp_servant_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  if dispstr.include?('tiny') || dispstr.include?('small') || dispstr.include?('smol') || dispstr.include?('micro') || dispstr.include?('little') || !safe_to_spam?(event)
    disp_tiny_stats(bot,event,args)
    return nil
  end
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  dispfou=false
  dispfou=true if dispstr.include?('fou')
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0xED619A
  xcolor=0x21BC2C if k[17][6,1]=='Q'
  xcolor=0x0B4DDF if k[17][6,1]=='A'
  xcolor=0xFE2116 if k[17][6,1]=='B'
  text="<:Icon_Rarity_5:448266417553539104>"*k[3]
  text="**0-star**" if k[3]==0
  np="*"
  np=":* #{@skills[@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}][3]}" unless @skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}.nil?
  kx=@crafts.find_index{|q| q[0]==k[23]}
  bond=">No Bond CE<"
  bond="**Bond CE:** >Unknown<" if k[0]<2
  bond="**Bond CE:** #{@crafts[kx][1]}" unless kx.nil?
  text="#{text}\n**Maximum default level:** *#{k[5]}* (#{k[4]} growth curve)\n**Team Cost:** #{k[21]}\n**Availability:** *#{k[20]}*\n\n**Class:** *#{k[2]}*\n**Attribute:** *#{k[12]}*\n**Alignment:** *#{k[22]}*\n\n**Command Deck:** #{k[17][0,5]} (NP type: #{k[17][6,1]})\n**Noble Phantasm:** *#{k[16]}#{np}\n\n#{bond}\n\n**Death Rate:** #{k[11]}%"
  fou=990
  fou=1000 if dispstr.include?('fou') && dispstr.include?('jp')
  fou=1000 if dispstr.include?('jpfou') || dispstr.include?('jp_fou') || dispstr.include?('foujp') || dispstr.include?('fou_jp')
  fou=1000 if dispstr.include?('fou-jp') || dispstr.include?('jp-fou')
  flds=[["Combat stats","__**Level 1**__\n*HP* - #{longFormattedNumber(k[6][0])}  \n*Atk* - #{longFormattedNumber(k[7][0])}  \n\n__**Level #{k[5]}**__\n*HP* - #{longFormattedNumber(k[6][1])}  \n*Atk* - #{longFormattedNumber(k[7][1])}  \n\n__**Level 100**__\n*HP* - #{longFormattedNumber(k[6][2])}  \n*Atk* - #{longFormattedNumber(k[7][2])}  "]]
  flds=[["Combat stats","__**Level 1**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][0]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][0]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][0]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][0]+2000)}  \n\n__**Level #{k[5]}**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][1]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][1]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][1]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][1]+2000)}  \n\n__**Level 100**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][2]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][2]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][2]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][2]+2000)}"]] if dispfou
  flds.push(["Attack Parameters","__**Hit Counts**__\n*Quick*: #{k[9][0]}\n*Arts*: #{k[9][1]}\n*Buster*: #{k[9][2]}\n*Extra*: #{k[9][3]}\n*NP*: #{k[9][4]}\n\n__**NP Gain**__\n*Attack:* #{k[8][0]}%#{"\n*Alt. Atk.:* #{k[8][2]}% (#{k[8][3]})" unless k[8][2].nil?}\n*Defense:* #{k[8][1]}%\n\n__**Crit Stars**__\n*Weight:* #{k[10][0]}\n*Drop Rate:* #{k[10][1]}%"])
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  create_embed(event,"__**#{k[1]}**__ [##{k[0]}]",text,xcolor,ftr,xpic,flds)
end

def disp_tiny_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  dispfou=0
  dispfou=990 if dispstr.include?('fou')
  dispfou=990 if dispstr.include?('fou') && dispstr.include?('silver')
  dispfou=990 if dispstr.include?('silverfou') || dispstr.include?('silver_fou') || dispstr.include?('fousilver') || dispstr.include?('fou_silver')
  dispfou=990 if dispstr.include?('fou-silver') || dispstr.include?('silver-fou')
  dispfou=1000 if dispstr.include?('fou') && dispstr.include?('jp')
  dispfou=1000 if dispstr.include?('jpfou') || dispstr.include?('jp_fou') || dispstr.include?('foujp') || dispstr.include?('fou_jp')
  dispfou=1000 if dispstr.include?('fou-jp') || dispstr.include?('jp-fou') || dispstr.include?('fou') && dispstr.include?('gold')
  dispfou=1000 if dispstr.include?('fou') && dispstr.include?('golden')
  dispfou=2000 if dispstr.include?('goldfou') || dispstr.include?('gold_fou') || dispstr.include?('fougold') || dispstr.include?('fou_gold')
  dispfou=2000 if dispstr.include?('fou-gold') || dispstr.include?('gold-fou') || dispstr.include?('goldenfou') || dispstr.include?('golden_fou')
  dispfou=2000 if dispstr.include?('fougolden') || dispstr.include?('fou_golden') || dispstr.include?('fou-golden') || dispstr.include?('golden-fou')
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0xED619A
  xcolor=0x21BC2C if k[17][6,1]=='Q'
  xcolor=0x0B4DDF if k[17][6,1]=='A'
  xcolor=0xFE2116 if k[17][6,1]=='B'
  text="<:Icon_Rarity_5:448266417553539104>"*k[3]
  text="**0-star**" if k[3]==0
  if dispfou==2000
    text="#{text}\u00A0\u00B7\u00A0<:GoldenFou:503453297068212224>"
  elsif dispfou>0
    text="#{text}\u00A0\u00B7\u00A0<:Fou:503453296242196500>"
  end
  kx=@crafts.find_index{|q| q[0]==k[23]}
  bond=">No Bond CE<"
  bond="**Bond CE:** >Unknown<" if k[0]<2
  bond="**Bond CE:** #{@crafts[kx][1]}" unless kx.nil?
  text="#{text}\n**Max. default level:** *#{k[5]}*\u00A0\u00B7\u00A0**Team Cost:** #{k[21]}\n**Availability:** *#{k[20]}*\n\n**Class:** *#{k[2]}*\u00A0\u00B7\u00A0**Attribute:** *#{k[12]}*\n**Alignment:** *#{k[22]}*\n\n**Command Deck:** #{k[17][0,5]} (NP type: #{k[17][6,1]})\n**Noble Phantasm:** #{k[16]}\n\n#{bond}\n\n**HP:**\u00A0\u00A0#{longFormattedNumber(k[6][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][2]+dispfou)}\u00A0Grail\n**Atk:**\u00A0\u00A0#{longFormattedNumber(k[7][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][2]+dispfou)}\u00A0Grail\n**Death Rate:**\u00A0#{k[11]}%\n\n**Hit Counts**:\u00A0\u00A0*Q:*\u00A0#{k[9][0]}\u00A0\u00A0\u00B7\u00A0\u00A0*A:*\u00A0#{k[9][1]}\u00A0\u00A0\u00B7\u00A0\u00A0*B:*\u00A0#{k[9][2]}  \u00B7  *EX:*\u00A0#{k[9][3]}\u00A0\u00A0\u00B7\u00A0\u00A0*NP:*\u00A0#{k[9][4]}\n**NP\u00A0Gain:**\u00A0\u00A0*Attack:*\u00A0#{k[8][0]}%#{"  \u00B7  *Alt.Atk.:*\u00A0#{k[8][2]}%\u00A0(#{k[8][3].gsub(' ',"\u00A0")})" unless k[8][2].nil?}  \u00B7  *Defense:*\u00A0#{k[8][1]}%\n**Crit Stars:**\u00A0\u00A0*Weight:*\u00A0#{k[10][0]}\u00A0\u00A0\u00B7\u00A0\u00A0*Drop Rate:*\u00A0#{k[10][1]}%"
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou>0
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  create_embed(event,"__**#{k[1]}**__ [##{k[0]}]",text,xcolor,ftr,xpic)
end

def disp_servant_traits(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=0xED619A
  xcolor=0x21BC2C if k[17][6,1]=='Q'
  xcolor=0x0B4DDF if k[17][6,1]=='A'
  xcolor=0xFE2116 if k[17][6,1]=='B'
  text="<:Icon_Rarity_5:448266417553539104>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  text="#{text}\n**Attribute:** *#{k[12]}*"
  text="#{text}\n**Gender:** *#{k[13][0]}*" if ['Female','Male'].include?(k[13][0])
  text="#{text}\n~~**Gender:** *Effeminate*~~" if [10,94,143].include?(k[0])
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}",text,xcolor,nil,xpic,triple_finish(k[13].reject{|q| ['Female','Male'].include?(q)}))
end

def disp_servant_skills(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=0xED619A
  xcolor=0x21BC2C if k[17][6,1]=='Q'
  xcolor=0x0B4DDF if k[17][6,1]=='A'
  xcolor=0xFE2116 if k[17][6,1]=='B'
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  text="<:Icon_Rarity_5:448266417553539104>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  actsklz=[]
  if k[14][0][0]=='-'
    actsklz.push('>None<')
  else
    for i in 0...k[14].length
      str="#{'__' if safe_to_spam?(event)}**Skill #{i+1}: #{k[14][i][0]}**#{'__' if safe_to_spam?(event)}"
      if safe_to_spam?(event)
        k2=@skills.find_index{|q| q[2]=='Skill' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[14][i][0]}
        str="#{str}\n*Cooldown:* #{@skills[k2][3]}\u00A0L#{micronumber(1)}  \u00B7  #{@skills[k2][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{@skills[k2][3]-2}\u00A0L#{micronumber(10)}"
        for i2 in 4...@skills[k2].length
          unless @skills[k2][i2][0]=='-'
            str="#{str}\n#{@skills[k2][i2][0]}"
            unless @skills[k2][i2][1].nil?
              x=@skills[k2][i2][1]
              x2=@skills[k2][i2][6]
              x3=@skills[k2][i2][10]
              if x==x2 && x==x3
                str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0Constant #{x}"
              else
                str="#{str}  \u00B7  #{x} L#{micronumber(1)}  \u00B7  #{x2} L#{micronumber(6)}  \u00B7  #{x3} L#{micronumber(10)}"
              end
            end
          end
        end
      end
      unless k[14][i][1].nil?
        str="#{str}\n#{"\n__" if safe_to_spam?(event)}*When upgraded: #{k[14][i][1]}*#{'__' if safe_to_spam?(event)}"
        if safe_to_spam?(event)
          k2=@skills.find_index{|q| q[2]=='Skill' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[14][i][1]}
          str="#{str}\n*Cooldown:* #{@skills[k2][3]}\u00A0L#{micronumber(1)}  \u00B7  #{@skills[k2][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{@skills[k2][3]-2}\u00A0L#{micronumber(10)}"
          for i2 in 4...@skills[k2].length
            unless @skills[k2][i2][0]=='-'
              str="#{str}\n#{@skills[k2][i2][0]}"
              unless @skills[k2][i2][1].nil?
                x=@skills[k2][i2][1]
                x2=@skills[k2][i2][6]
                x3=@skills[k2][i2][10]
                if x.to_f<1
                  x="#{(x.to_f*1000).to_i/10.0}%" 
                  x2="#{(x2.to_f*1000).to_i/10.0}%"
                  x3="#{(x3.to_f*1000).to_i/10.0}%"
                end
                if x==x2 && x==x3
                  str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0Constant #{x}"
                else
                  str="#{str}  \u00B7  #{x}\u00A0L#{micronumber(1)}  \u00B7  #{x2}\u00A0L#{micronumber(6)}  \u00B7  #{x3}\u00A0L#{micronumber(10)}"
                end
              end
            end
          end
        end
      end
      actsklz.push(str)
    end
  end
  passklz=[]
  if k[15][0]=='-'
    passklz.push('>None<')
  else
    for i in 0...k[15].length
      str="*#{k[15][i]}*"
      k2=@skills.find_index{|q| q[2]=='Passive' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[15][i]}
      str="#{str}: #{@skills[k2][3]}"
      passklz.push(str)
    end
  end
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  ftr=nil
  ftr='For skill descriptions, use this command in PM or a bot spam channel.' unless safe_to_spam?(event)
  if actsklz.join("\n\n").length+passklz.join("\n").length+text.length+"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}".length>=1700
    create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}","#{text}\n\n#{actsklz.join("\n\n")}",xcolor,nil,xpic)
    create_embed(event,'__*Passive Skills*__',passklz.join("\n"),xcolor,ftr)
  else
    create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}","#{text}\n\n#{actsklz.join("\n\n")}\n\n__**Passive Skills**__\n#{passklz.join("\n")}",xcolor,ftr,xpic)
  end
end

def disp_servant_np(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=0xED619A
  xcolor=0x21BC2C if k[17][6,1]=='Q'
  xcolor=0x0B4DDF if k[17][6,1]=='A'
  xcolor=0xFE2116 if k[17][6,1]=='B'
  text="<:Icon_Rarity_5:448266417553539104>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  np="*"
  nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}
  unless nophan.nil?
    nophan=@skills[nophan]
    np="#{':* ' unless chain}#{nophan[3]}"
  end
  text="#{text}\n**Noble Phantasm:** *#{k[16]}#{np}" unless chain
  npl=1
  npl=2 if event.message.text.downcase.split(' ').include?('np2')
  npl=3 if event.message.text.downcase.split(' ').include?('np3')
  npl=4 if event.message.text.downcase.split(' ').include?('np4')
  npl=5 if event.message.text.downcase.split(' ').include?('np5')
  unless nophan.nil?
    l=[nophan[5],nophan[6]]
    text="#{text}\n**Type:** #{nophan[5]}\n**Target:** #{nophan[6]}\n\n**Rank:** #{nophan[4]}\n__**Effects**__"
    for i in 7...17
      unless nophan[i][0]=='-'
        text="#{text}\n*#{nophan[i][0]}*"
        if nophan[i][0].include?('<OVERCHARGE>') || (nophan[i][0].include?('<LEVEL>') && safe_to_spam?(event))
          text="#{text} - #{nophan[i][1]}\u00A0/\u00A0#{nophan[i][2]}\u00A0/\u00A0#{nophan[i][3]}\u00A0/\u00A0#{nophan[i][4]}\u00A0/\u00A0#{nophan[i][5]}" unless nophan[i][1].nil? || nophan[i][1]=='-'
        else
          text="#{text} - #{nophan[i][npl]}" unless nophan[i][npl].nil? || nophan[i][npl]=='-'
        end
      end
    end
    nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]=="#{k[0].to_s}u"}
    unless nophan.nil?
      nophan=@skills[nophan]
      text="#{text}#{"\n" if nophan[5]!=l[0] || nophan[6]!=l[1]}#{"\n**Type:** #{nophan[5]}" if nophan[5]!=l[0]}#{"\n**Target:** #{nophan[6]}" if nophan[6]!=l[1]}\n\n**Rank:** #{nophan[4]}\n__**Effects**__"
      for i in 7...17
        unless nophan[i][0]=='-'
          text="#{text}\n*#{nophan[i][0]}*"
          if nophan[i][0].include?('<OVERCHARGE>') || (nophan[i][0].include?('<LEVEL>') && safe_to_spam?(event))
            text="#{text} - #{nophan[i][1]}\u00A0/\u00A0#{nophan[i][2]}\u00A0/\u00A0#{nophan[i][3]}\u00A0/\u00A0#{nophan[i][4]}\u00A0/\u00A0#{nophan[i][5]}" unless nophan[i][1].nil? || nophan[i][1]=='-'
          else
            text="#{text} - #{nophan[i][npl]}" unless nophan[i][npl].nil? || nophan[i][npl]=='-'
          end
        end
      end
    end
  end
  ftr='You can also include NP# to show relevant stats at other merge counts.' if npl==1
  ftr=nil if safe_to_spam?(event)
  create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]#{" - NP#{npl}" if npl>1 && !safe_to_spam?(event)}" unless chain}#{"**#{k[16]}:** *#{np}*#{"\nLevel #{npl}" if npl>1 && !safe_to_spam?(event)}" if chain}",text,xcolor,ftr,nil)
end

def get_donor_list()
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHDonorList.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHDonorList.txt').each_line do |line|
      b.push(line.gsub("\n",'').split('\\'[0]))
    end
    for i in 0...b.length
      b[i][0]=b[i][0].to_i
      b[i][2]=b[i][2].to_i
      b[i][3]=b[i][3].split('/').map{|q| q.to_i} unless b[i][3].nil?
    end
  else
    b=[]
  end
  return b
end

def is_mod?(user,server,channel,mode=0) # used by certain commands to determine if a user can use them
  return true if user.id==167657750971547648 # bot developer is always a LizMod
  return false if server.nil? # no one is a LizMod in PMs
  return true if user.id==server.owner.id # server owners are LizMods by default
  for i in 0...user.roles.length # certain role names will count as LizMods even if they don't have legitimate mod powers
    return true if ['mod','mods','moderator','moderators','admin','admins','administrator','administrators','owner','owners'].include?(user.roles[i].name.downcase.gsub(' ',''))
  end
  return true if user.permission?(:manage_messages,channel) # legitimate mod powers also confer LizMod powers
  return false if mode>0
  return true if get_donor_list().reject{|q| q[2]<1}.map{|q| q[0]}.include?(user.id) # people who donate to the laptop fund will always be EliseMods
  return false
end

def disp_aliases(bot,event,args=nil,mode=0)
  event.channel.send_temporary_message('Calculating data, please wait...',2)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  data_load()
  nicknames_load()
  unless args.length.zero?
    if find_servant_ex(args.join(''),event).length<=0
      event.respond "#{args.join(' ')} is not a servant name or an alias."
      return nil
    end
  end
  unit=find_servant_ex(args.join(''),event)
  unit=nil if unit.length<=0 || args.length.zero?
  f=[]
  n=@aliases.map{|a| a}
  h=''
  if unit.nil?
    if safe_to_spam?(event) || mode==1
      n=n.reject{|q| q[2].nil?} if mode==1
      unless event.server.nil?
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        if n.length>25 && !safe_to_spam?(event)
          event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
          return nil
        end
        msg=''
        for i in 0...n.length
          untnme=@servants[@servants.find_index{|q| q[0]==n[i][1]}][1]
          msg=extend_message(msg,"#{n[i][0]} = #{untnme} [##{n[i][1]}]#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        event.respond msg
        return nil
      end
      for i in 0...n.length
        untnme=@servants[@servants.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    else
      event.respond 'Please either specify a unit name or use this command in PM.'
      return nil
    end
  else
    k=0
    k=event.server.id unless event.server.nil?
    f.push("__**#{unit[1]}**__ [##{unit[0]}]#{"'s server-specific aliases" if mode==1}")
    f.push(unit[1].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if unit[1].include?('(') || unit[1].include?(')') || unit[1].include?(' ') || unit[1].include?('!') || unit[1].include?('_') || unit[1].include?('?') || unit[1].include?("'") || unit[1].include?('"')
    f.push(unit[0])
    for i in 0...n.length
      if n[i][1]==unit[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  end
  f.uniq!
  if f.length>50 && !safe_to_spam?(event)
    event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
    return nil
  end
  msg=''
  for i in 0...f.length
    msg=extend_message(msg,f[i],event)
  end
  event.respond msg
  return nil
end

bot.command([:embeds,:embed]) do |event|
  return nil if overlap_prevent(event)
  metadata_load()
  if @embedless.include?(event.user.id)
    for i in 0...@embedless.length
      @embedless[i]=nil if @embedless[i]==event.user.id
    end
    @embedless.compact!
    event.respond 'You will now see my replies as embeds again.'
  else
    @embedless.push(event.user.id)
    event.respond 'You will now see my replies as plaintext.'
  end
  metadata_save()
  return nil
end

bot.command(:addalias) do |event, newname, unit, modifier, modifier2|
  data_load()
  nicknames_load()
  if newname.nil? || unit.nil?
    event.respond 'You must specify both a new alias and a servant to give the alias to.'
    return nil
  elsif event.user.id != 167657750971547648 && event.server.nil?
    event.respond 'Only my developer is allowed to use this command in PM.'
    return nil
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665].include?(event.user.id)) && event.channel.id != 502288368777035777
    event.respond 'You are not a mod.'
    return nil
  elsif newname.include?('"') || newname.include?("\n")
    event.respond 'Full stop.  " is not allowed in an alias.'
    return nil
  elsif !event.server.nil? && event.server.id==363917126978764801
    event.respond "You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra.  Even if that was an alias for FEH instead of FGO."
    return nil
  elsif find_servant(newname,event).length>0
    if find_servant(unit,event).length>0
      event.respond "Someone already has the name #{newname}"
      return nil
    elsif [167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) && !modifier.nil?
    else
      x=newname
      newname=unit
      unit=x
    end
  elsif find_servant(unit,event).length<=0
    event.respond "#{unit} is not a servant."
    return nil
  end
  logchn=502288368777035777
  newname=newname.gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  checkstr=normalize(newname)
  k=event.message.emoji
  for i in 0...k.length
    checkstr=checkstr.gsub("<:#{k[i].name}:#{k[i].id}>",k[i].name)
  end
  unt=find_servant(unit,event)
  checkstr2=checkstr.downcase.gsub(unt[12].split(', ')[0].gsub('*','').downcase,'')
  cck=nil
  cck=unt[12].split(', ')[1][0,1].downcase if unt[12].split(', ').length>1
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/
    event.respond "That name has __***NOT***__ been added to #{unt[0]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**Alias:** #{newname} for #{unt[1]} [##{unt[0]}]~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{unt[0]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**Alias:** >Censored< for #{unt[1]} [##{unt[0]}]~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname)
  m=nil
  m=[event.server.id] unless event.server.nil?
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
    m=[modifier.to_i]
    modifier=nil
  end
  chn=event.channel.id
  chn=modifier2.to_i if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
  m=nil if [167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) && !modifier.nil?
  m=nil if event.channel.id==502288368777035777 && !modifier.nil?
  unit=unt[0]
  double=false
  for i in 0...@aliases.length
    if @aliases[i][2].nil?
    elsif @aliases[i][0].downcase==newname.downcase && @aliases[i][1]==unit
      if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?
        @aliases[i][2]=nil
        @aliases[i][3]=nil
        @aliases[i].compact!
        bot.channel(chn).send_message("The alias #{newname} for #{unt[1]} [##{unt[0]}] exists in a server already.  Making it global now.")
        event.respond "The alias #{newname} for #{unt[1]} [##{unt[0]}] exists in a server already.  Making it global now.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**Alias:** #{newname} for #{unt[1]} [##{unt[0]}] - gone global.")
        double=true
      else
        @aliases[i][2].push(srv)
        bot.channel(chn).send_message("The alias #{newname} for #{unt[1]} [##{unt[0]}] exists in another server already.  Adding this server to those that can use it.")
        event.respond "The alias #{newname} for #{unt[1]} [##{unt[0]}] exists in another server already.  Adding this server to those that can use it.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        bot.user(167657750971547648).pm("The alias **#{@aliases[i][0]}** for the character **#{unt[1]} [##{unt[0]}]** is used in quite a few servers.  It might be time to make this global") if @aliases[i][2].length >= bot.servers.length / 20 && @aliases[i][3].nil?
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**Alias:** #{newname} for #{unt[1]} [##{unt[0]}] - gained a new server that supports it.")
        double=true
      end
    end
  end
  unless double
    @aliases.push([newname,unit,m].compact)
    @aliases.sort! {|a,b| (a[1] <=> b[1]) == 0 ? (a[0].downcase <=> b[0].downcase) : (a[1] <=> b[1])}
    bot.channel(chn).send_message("#{newname} has been added to #{unt[1]} [##{unt[0]}]'s aliases#{" globally" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?}.\nPlease test to be sure that the alias stuck.")
    event.respond "#{newname} has been added to #{unt[1]} [##{unt[0]}]'s aliases#{" globally" if event.user.id==167657750971547648 && !modifier.nil?}." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
    bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**Alias:** #{newname} for #{unt[1]} [##{unt[0]}]#{" - global alias" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?}")
  end
  @aliases.uniq!
  nzzz=@aliases.map{|a| a}
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...nzzz.length
      f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
    end
  }
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][1]>=nzz[nzz.length-1][1]
    bot.channel(logchn).send_message('Alias list saved.')
    open('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt', 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
  return nil
end

bot.command([:checkaliases,:aliases,:seealiases]) do |event, *args|
  disp_aliases(bot,event,args)
end

bot.command([:serveraliases,:saliases]) do |event, *args|
  disp_aliases(bot,event,args,1)
end

bot.command([:deletealias,:removealias]) do |event, name|
  nicknames_load()
  if name.nil?
    event.respond "I can't delete nothing!" if name.nil?
    return nil
  elsif event.user.id != 167657750971547648 && event.server.nil?
    event.respond 'Only my developer is allowed to use this command in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  elsif find_servant(name,event).length<=0
    event.respond "#{name} is not anyone's alias!"
    return nil
  end
  j=find_servant(name,event)
  k=0
  k=event.server.id unless event.server.nil?
  for izzz in 0...@aliases.length
    if @aliases[izzz][0].downcase==name.downcase
      if @aliases[izzz][2].nil? && event.user.id != 167657750971547648
        event.respond 'You cannot remove a global alias'
        return nil
      elsif @aliases[izzz][2].nil? || @aliases[izzz][2].include?(k)
        unless @aliases[izzz][2].nil?
          for izzz2 in 0...@aliases[izzz][2].length
            @aliases[izzz][2][izzz2]=nil if @aliases[izzz][2][izzz2]==k
          end
          @aliases[izzz][2].compact!
        end
        @aliases[izzz]=nil if @aliases[izzz][2].nil? || @aliases[izzz][2].length<=0
      end
    end
  end
  @aliases.uniq!
  @aliases.compact!
  logchn=502288368777035777
  srv=0
  srv=event.server.id unless event.server.nil?
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n~~**Alias:** #{name} for #{j[1]} [##{j[0]}]~~ **DELETED**.")
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][1]>=nzz[nzz.length-1][1]
    bot.channel(logchn).send_message("Alias list saved.")
    open('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt', 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message("Alias list has been backed up.")
  end
  return nil
end

bot.command([:servant,:data,:unit]) do |event, *args|
  disp_servant_stats(bot,event,args)
  if safe_to_spam?(event)
    disp_servant_traits(bot,event,args,true)
    disp_servant_skills(bot,event,args,true)
    disp_servant_np(bot,event,args,true)
  end
  return nil
end

bot.command([:stats,:stat]) do |event, *args|
  disp_servant_stats(bot,event,args)
  return nil
end

bot.command([:traits,:trait]) do |event, *args|
  disp_servant_traits(bot,event,args)
  return nil
end

bot.command([:np,:NP,:noble,:phantasm,:noblephantasm]) do |event, *args|
  disp_servant_np(bot,event,args)
  return nil
end

bot.command(:skills) do |event, *args|
  disp_servant_skills(bot,event,args)
  return nil
end

bot.command([:tinystats,:smallstats,:smolstats,:microstats,:squashedstats,:sstats,:statstiny,:statssmall,:statssmol,:statsmicro,:statssquashed,:statss,:stattiny,:statsmall,:statsmol,:statmicro,:statsquashed,:sstat,:tinystat,:smallstat,:smolstat,:microstat,:squashedstat,:tiny,:small,:micro,:smol,:squashed,:littlestats,:littlestat,:statslittle,:statlittle,:little]) do |event, *args|
  disp_tiny_stats(bot,event,args)
  return nil
end

bot.command([:safe,:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f|
  f='' if f.nil?
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504].include?(event.server.id)
    event.respond 'It is safe for me to send long replies here because this is one of my emoji servers.'
  elsif @shardizard==4
    event.respond 'It is safe for me to send long replies here because this is my debug mode.'
  elsif ['bots','bot'].include?(event.channel.name.downcase)
    event.respond "It is safe for me to send long replies here because the channel is named `#{event.channel.name.downcase}`."
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('spam')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "spam".'
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('command')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "command".'
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('channel')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "channel".'
  elsif event.channel.name.downcase.include?('lizbot') || event.channel.name.downcase.include?('liz-bot') || event.channel.name.downcase.include?('liz_bot')
    event.respond 'It is safe for me to send long replies here because the channel name specifically calls attention to the fact that it is made for me.'
  elsif @spam_channels.include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      @spam_channels.delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send long replies to.'
      event << ''
      event << 'If you wish to change that, ask a server mod to type `FGO!spam off` in this channel.'
    end
  elsif is_mod?(event.user,event.server,event.channel,1) && ['on','yes','true'].include?(f.downcase)
    metadata_load()
    @spam_channels.push(event.channel.id)
    metadata_save()
    event.respond 'This channel is now marked as safe for me to send long replies to.'
  else
    event << 'It is not safe for me to send long replies here.'
    event << ''
    event << 'If you wish to change that, try one of the following:'
    event << '- Change the channel name to "bots".'
    event << '- Change the channel name to include the word "bot" and one of the following words: "spam", "command(s)", "channel".'
    event << '- Have a server mod type `FGO!spam on` in this channel.'
  end
end

bot.command([:bugreport, :suggestion, :feedback]) do |event, *args|
  s5=event.message.text.downcase
  s5=s5[4,s5.length-4] if ['fgo!','fgo?','fg0!','fg0?','liz!','liz?'].include?(event.message.text.downcase[0,4])
  s5=s5[5,s5.length-5] if ['fate!','fate?'].include?(event.message.text.downcase[0,5])
  a=s5.split(' ')
  s3='Bug Report'
  s3='Suggestion' if a[0]=='suggestion'
  s3='Feedback' if a[0]=='feedback'
  if args.nil? || args.length.zero?
    event.respond "You did not include a description of your #{s3.downcase}.  Please retry the command like this:\n```#{event.message.text} here is where you type the description of yout #{s3.downcase}```"
    if event.server.nil?
      s="**#{s3} sent by PM**"
    else
      s="**Server:** #{event.server.name} (#{event.server.id}) - #{["<:Shard_Colorless:443733396921909248> Transparent","<:Shard_Red:443733396842348545> Scarlet","<:Shard_Blue:443733396741554181> Azure","<:Shard_Green:443733397190344714> Verdant"][(event.server.id >> 22) % 4]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})"
    end
    bot.user(167657750971547648).pm("#{s}\n#{event.user.distinct} (#{event.user.id}) just tried to use the #{s3.downcase} command but gave no arguments.")
    return nil
  elsif event.server.nil?
    s="**#{s3} sent by PM**"
  else
    s="**Server:** #{event.server.name} (#{event.server.id}) - #{["<:Shard_Colorless:443733396921909248> Transparent","<:Shard_Red:443733396842348545> Scarlet","<:Shard_Blue:443733396741554181> Azure","<:Shard_Green:443733397190344714> Verdant"][(event.server.id >> 22) % 4]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})"
  end
  f=event.message.text.split(' ')
  f="#{f[0]} "
  bot.user(167657750971547648).pm("#{s}\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{s3}:** #{first_sub(event.message.text,f,'',1)}")
  s3='Bug' if s3=='Bug Report'
  t=Time.now
  event << "Your #{s3.downcase} has been logged."
  return nil
end

bot.command(:invite) do |event, user|
  usr=event.user
  txt="You can invite me to your server with this link: <https://goo.gl/ox9CxB>\nTo look at my source code: <https://github.com/Rot8erConeX/LizBot/blob/master/LizBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: ~~(link not available yet)~~"
  user_to_name="you"
  unless user.nil?
    if /<@!?(?:\d+)>/ =~ user
      usr=event.message.mentions[0]
      txt="This message was sent to you at the request of #{event.user.distinct}.\n\n#{txt}"
      user_to_name=usr.distinct
    else
      usr=bot.user(user.to_i)
      txt="This message was sent to you at the request of #{event.user.distinct}.\n\n#{txt}"
      user_to_name=usr.distinct
    end
  end
  usr.pm(txt)
  event.respond "A PM was sent to #{user_to_name}." unless event.server.nil? && user_to_name=="you"
end

bot.command(:sortaliases, from: 167657750971547648) do |event, *args|
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[1] <=> b[1]) == 0 ? (a[0].downcase <=> b[0].downcase) : (a[1] <=> b[1])}
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command(:status, from: 167657750971547648) do |event, *args|
  return nil unless event.user.id==167657750971547648
  bot.game=args.join(' ')
  event.respond 'Status set.'
end

bot.command(:backupaliases, from: 167657750971547648) do |event|
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[1] <=> b[1]) == 0 ? (a[0].downcase <=> b[0].downcase) : (a[1] <=> b[1])}
  if @aliases[@aliases.length-1].length<=1 || @aliases[@aliases.length-1][1]<nzz[nzz.length-1][1]
    event.respond 'Alias list has __***NOT***__ been backed up, as alias list has been corrupted.'
    bot.gateway.check_heartbeat_acks = true
    event.respond 'FGO!restorealiases'
    return nil
  end
  nzzzzz=@aliases.map{|a| a}
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt', 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event.respond 'Alias list has been backed up.'
end

bot.command(:restorealiases, from: 167657750971547648) do |event|
  return nil unless [167657750971547648,bot.profile.id].include?(event.user.id) || event.channel.id==502288368777035777
  bot.gateway.check_heartbeat_acks = false
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  nzzzzz=b.uniq
  if nzzzzz[nzzzzz.length-1][1]<225
    event << 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGONames3.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FGONames3.txt').each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    nzzzzz=b.uniq
  else
    event << 'Last backup of the alias list being used.'
  end
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event << 'Alias list has been restored from backup.'
end

bot.command(:sendmessage, from: 167657750971547648) do |event, channel_id, *args| # sends a message to a specific channel
  return nil unless event.server.nil? || [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504].include?(event.server.id)
  if event.user.id==167657750971547648
  else
    event.respond 'Are you trying to use the `bugreport`, `suggestion`, or `feedback` command?'
    bot.user(167657750971547648).pm("#{event.user.distinct} (#{event.user.id}) tried to use the `sendmessage` command.")
    return nil
  end
  f=event.message.text.split(' ')
  f="#{f[0]} #{f[1]} "
  bot.channel(channel_id).send_message(first_sub(event.message.text,f,'',1))
  event.respond 'Message sent.'
  return nil
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user
  return nil unless event.server.nil?
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  f=event.message.text.split(' ')
  f="#{f[0]} #{f[1]} "
  bot.user(user_id.to_i).pm(first_sub(event.message.text,f,'',1))
  event.respond 'Message sent.'
end

bot.command(:leaveserver, from: 167657750971547648) do |event, server_id| # forces Liz to leave a server
  return nil unless event.server.nil?
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  chn=bot.server(server_id.to_i).general_channel
  if chn.nil?
    chnn=[]
    for i in 0...bot.server(server_id.to_i).channels.length
      chnn.push(bot.server(server_id.to_i).channels[i]) if bot.user(bot.profile.id).on(server_id.to_i).permission?(:send_messages,bot.server(server_id.to_i).channels[i]) && bot.server(server_id.to_i).channels[i].type.zero?
    end
    chn=chnn[0] if chnn.length>0
  end
  chn.send_message("My coder would rather that I not associate with you guys.  I'm sorry.  If you would like me back, please take it up with him.") rescue nil
  bot.server(server_id.to_i).leave
  return nil
end

bot.command(:cleanupaliases, from: 167657750971547648) do |event|
  event.channel.send_temporary_message('Please wait...',10)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  nicknames_load()
  nmz=@aliases.map{|q| q}
  k=0
  k2=0
  for i in 0...nmz.length
    if nmz[i][2].nil?
      if nmz[i][0]==@servants[@servants.find_index{|q| q[0]==nmz[i][1]}][1].gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')
        k2+=1
        nmz[i]=nil
      end
    else
      for i2 in 0...nmz[i][2].length
        srv=(bot.server(nmz[i][2][i2]) rescue nil)
        if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
          k+=1
          nmz[i][2][i2]=nil
        end
      end
      nmz[i][2].compact!
      nmz[i]=nil if nmz[i][2].length<=0
    end
  end
  nmz.compact!
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:snagstats) do |event, f, f2|
  nicknames_load()
  data_load()
  metadata_load()
  f='' if f.nil?
  f2='' if f2.nil?
  bot.servers.values(&:members)
  k=bot.servers.values.reject{|q| [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504].include?(q.id)}.length
  k=1 if @shardizard==4 # Debug shard shares the five emote servers with the main account
  @server_data[0][@shardizard]=k
  @server_data[1][@shardizard]=bot.users.size
  metadata_save()
  if ['servers','server','members','member','shard','shards','user','users'].include?(f.downcase)
    event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} servers, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
    event << "#{longFormattedNumber(@server_data[0][0])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the Man attribute, reaching #{longFormattedNumber(@server_data[1][0])} unique members."
    event << "#{longFormattedNumber(@server_data[0][1])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the Sky attribute, reaching #{longFormattedNumber(@server_data[1][1])} unique members."
    event << "#{longFormattedNumber(@server_data[0][2])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the Earth attribute, reaching #{longFormattedNumber(@server_data[1][2])} unique members."
    event << "#{longFormattedNumber(@server_data[0][3])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the Star attribute, reaching #{longFormattedNumber(@server_data[1][3])} unique members."
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    b=[[],[]]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb').each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[0].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command('}.length)} commands, invoked with #{longFormattedNumber(all_commands().length)} different phrases.**"
    event << 'This includes:'
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || !q.include?('from: 167657750971547648')}.length)} dev-only commands, invoked with #{longFormattedNumber(all_commands(false,2).length)} different phrases."
    event << ''
    event << "**There are #{longFormattedNumber(@prefix.map{|q| q.downcase}.uniq.length)} command prefixes**, but because I am faking case-insensitivity it's actually #{longFormattedNumber(@prefix.length)} prefixes."
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,4]!='def '}.length)} functions the commands use.**"
    if safe_to_spam?(event) || " #{event.message.text.downcase} ".include?(" all ")
      b=b[0].map{|q| q.gsub('  ','')}.reject{|q| q.length<=0}
      for i in 0...b.length
        b[i]=b[i][1,b[i].length-1] if b[i][0,1]==' '
      end
      event << ''
      event << 'There are:'
      event << "#{longFormattedNumber(b.reject{|q| q[0,4]!='for '}.length)} `for` loops."
      event << "#{longFormattedNumber(b.reject{|q| q[0,6]!='while '}.length)} `while` loops."
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]!='if '}.length)} `if` trees, along with #{longFormattedNumber(b.reject{|q| q[0,6]!='elsif '}.length)} `elsif` branches and #{longFormattedNumber(b.reject{|q| q[0,4]!='else'}.length)} `else` branches."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='unless '}.length)} `unless` trees."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'[')<=count_in(q,']')}.length)} multi-line arrays."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'{')<=count_in(q,'}')}.length)} multi-line hashes."
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]=='if ' || !remove_format(remove_format(q,"'"),'"').include?(' if ')}.length)} single-line `if` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]=='unless ' || !remove_format(remove_format(q,"'"),'"').include?(' unless ')}.length)} single-line `unless` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='return '}.length)} `return` lines."
    end
    return nil
  elsif ['alias','aliases','name','names','nickname','nicknames'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',1)
    glbl=@aliases.reject{|q| !q[2].nil?}
    srv_spec=@aliases.reject{|q| q[2].nil?}
    all_units=@servants.map{|q| [q[0],q[1],0,0]}
    for j in 0...all_units.length
      all_units[j][2]+=glbl.reject{|q| q[1]!=all_units[j][0]}.length
      all_units[j][3]+=srv_spec.reject{|q| q[1]!=all_units[j][0]}.length
    end
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event)
    str="**There are #{longFormattedNumber(glbl.length)} global aliases.**\nThe servant#{"s" unless k.length==1} with the most global aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[2]}.max} global aliases#{" each" unless k.length==1}."
    k=all_units.reject{|q| q[2]>0}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[2]>0}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event) 
    str="#{str}\nThe following servant#{"s" unless k.length==1} have no global aliases: #{list_lift(k,"and")}." if k.length>0
    str2="**There are #{longFormattedNumber(srv_spec.length)} server-specific aliases.**"
    if event.server.nil? && @shardizard==4
      str2="#{str2}\nDue to being the debug version, I cannot show more information."
    elsif event.server.nil?
      str2="#{str2}\nServers you and I share account for #{@aliases.reject{|q| q[2].nil? || q[2].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{@aliases.reject{|q| q[2].nil? || !q[2].include?(event.server.id)}.length} of those."
    end
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event)
    str2="#{str2}\nThe servant#{"s" unless k.length==1} with the most server-specific aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[3]}.max} server-specific aliases#{" each" unless k.length==1}."
    k=srv_spec.map{|q| q[2].length}.inject(0){|sum,x| sum + x }
    str2="#{str2}\nCounting each alias/server combo as a unique alias, there are #{longFormattedNumber(k)} server-specific aliases"
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif event.user.id==167657750971547648 && !f.nil? && f.to_i.to_s==f
    srv=(bot.server(f.to_i) rescue nil)
    if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      s2="I am not in that server, but it would be assigned a#{[' Man',' Sky','n Earth',' Star'][(f.to_i >> 22) % 4]} attribute."
    else
      s2="__**#{srv.name}** (#{srv.id})__\n*Owner:* #{srv.owner.distinct} (#{srv.owner.id})\n*Attribute:* #{['Man','Sky','Earth','Star'][(f.to_i >> 22) % 4]}\n*My nickname:* #{bot.user(502288364838322176).on(srv.id).display_name}"
    end
    event.respond s2
    return nil
  end
  glbl=@aliases.reject{|q| !q[2].nil?}
  srv_spec=@aliases.reject{|q| q[2].nil?}
  b=[]
  File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb').each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} *servers*, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
  event << "This shard is in #{longFormattedNumber(@server_data[0][@shardizard])} server#{"s" unless @server_data[0][@shardizard]==1}, reaching #{longFormattedNumber(bot.users.size)} unique members."
  event << ''
  event << "**There are #{longFormattedNumber(@servants.length)} *servants*.**"
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end

bot.server_create do |event|
  chn=event.server.general_channel
  if chn.nil?
    chnn=[]
    for i in 0...event.server.channels.length
      chnn.push(event.server.channels[i]) if bot.user(bot.profile.id).on(event.server.id).permission?(:send_messages,event.server.channels[i]) && event.server.channels[i].type.zero?
    end
    chn=chnn[0] if chnn.length>0
  end
  if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504].include?(event.server.id) && @shardizard==4
    (chn.send_message("I am Mathoo's personal debug bot.  As such, I do not belong here.  You may be looking for one of my two facets, so I'll drop both their invite links here.\n\n**EliseBot** allows you to look up stats and skill data for characters in *Fire Emblem: Heroes*\nHere's her invite link: <https://goo.gl/HEuQK2>\n\n**FEIndex**, also known as **RobinBot**, is for *Fire Emblem: Awakening* and *Fire Emblem Fates*.\nHere's her invite link: <https://goo.gl/v3ADBG>") rescue nil)
    event.server.leave
  else
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['Man','Sky','Earth','Star'][(event.server.id >> 22) % 4]} attribute")
    bot.user(239973891626237952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['Man','Sky','Earth','Star'][(event.server.id >> 22) % 4]} attribute")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % 4)] += 1
    metadata_save()
    chn.send_message("Are you the new server?\nNice to meet you and please take care of me\u2661\nIn response to queries beginning with `FGO!`, `Liz!`, or `Fate!`, I will be summoned to show data on *Fate/Grand Order*!") rescue nil
  end
end

bot.server_delete do |event|
  unless @shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**")
    bot.user(239973891626237952).pm("Left server **#{event.server.name}**")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % 4)] -= 1
    metadata_save()
  end
end

bot.mention do |event|
  args=event.message.text.downcase.split(' ')
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  name=args.join(' ')
  k=find_servant_ex(name,event)
  if k.length>0
    disp_servant_stats(bot,event,args)
    if safe_to_spam?(event)
      disp_servant_traits(bot,event,args,true)
      disp_servant_skills(bot,event,args,true)
      disp_servant_np(bot,event,args,true)
    end
  end
end

bot.message do |event|
  s=event.message.text.downcase
  m=false
  if ['liz!','liz?','fgo!','fgo?','fg0!','fg0?'].include?(s[0,4]) && s.length>4
    m=true
    puts event.message.text
    s=s[4,s.length-4]
  elsif ['fate!','fate?'].include?(s[0,5]) && s.length>5
    m=true
    puts event.message.text
    s=s[5,s.length-5]
  end
  if m && !all_commands().include?(s.split(' ')[0])
    if find_servant_ex(s,event).length>0
      disp_servant_stats(bot,event,s.split(' '))
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,s.split(' '),true)
        disp_servant_skills(bot,event,s.split(' '),true)
        disp_servant_np(bot,event,s.split(' '),true)
      end
    end
  end
end

bot.ready do |event|
  system("color 4#{"CBAE7"[@shardizard,1]}")
  bot.game='loading, please wait...'
  metadata_load()
  if @ignored.length>0
    for i in 0...@ignored.length
      bot.ignore_user(@ignored[i].to_i)
    end
  end
  metadata_save()
  metadata_load()
  data_load()
  system("color d#{"41260"[@shardizard,1]}")
  system("title #{['Man','Sky','Earth','Star','Beast'][@shardizard]} LizBot")
  bot.game='Fate/Grand Order'
end

bot.run
