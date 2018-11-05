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
         'Iiz!','IiZ!','IIz!','IIZ!','Iiz?','IiZ?','IIz?','IIZ?',
         'fgo!','fgO!','fg0!','fGo!','fGO!','fG0!','Fgo!','FgO!','Fg0!','FGo!','FGO!','FG0!',
         'fgo?','fgO?','fg0?','fGo?','fGO?','fG0?','Fgo?','FgO?','Fg0?','FGo?','FGO?','FG0?',
         'fate!','fatE!','faTe!','faTE!','fAte!','fAtE!','fATe!','fATE!','Fate!','FatE!','FaTe!','FaTE!','FAte!','FAtE!','FATe!','FATE!',
         'fate?','fatE?','faTe?','faTE?','fAte?','fAtE?','fATe?','fATE?','Fate?','FatE?','FaTe?','FaTE?','FAte?','FAtE?','FATe?','FATE?']

# The bot's token is basically their password, so is censored for obvious reasons
bot = Discordrb::Commands::CommandBot.new token: '>Main Token<', shard_id: @shardizard, num_shards: 4, client_id: 502288364838322176, prefix: @prefix

@servants=[]
@skills=[]
@crafts=[]
@codes=[]
@clothes=[]
@enemies=[]
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
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,508792801455243266,508793141202255874,508793425664016395].include?(event.server.id) # it is safe to spam in the emoji servers
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

def has_any?(arr1,arr2) # used to determine if two arrays share any members
  return true if arr1.nil? && arr2.nil?
  return true if arr1.nil? && !arr2.nil? && arr2.include?(nil)
  return true if arr2.nil? && !arr1.nil? && arr1.include?(nil)
  return false if arr1.nil? || arr2.nil?
  if arr1.is_a?(String)
    arr1=arr1.downcase.chars
  elsif arr1.is_a?(Array)
    arr1=arr1.map{|q| q.downcase rescue q}
  end
  if arr2.is_a?(String)
    arr2=arr2.downcase.chars
  elsif arr2.is_a?(Array)
    arr2=arr2.map{|q| q.downcase rescue q}
  end
  return true if (arr1 & arr2).length>0
  return false
end

def micronumber(n)
  m=["\u2080","\u2081","\u2082","\u2083","\u2084","\u2085","\u2086","\u2087","\u2088","\u2089"]
  return "\uFE63#{micronumber(0-n)}" if n<0
  return "#{micronumber(n/10)}#{m[n%10]}" if n>9
  return m[n]
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
      for i2 in 5...11
        b[i][i2]=b[i][i2].split(';; ')
      end
    elsif b[i][2]=='Clothes'
      b[i][1]=b[i][1].to_i
      for i2 in 3...6
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
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOCommandCodes.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOCommandCodes.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][0]=b[i][0].to_i
    b[i][2]=b[i][2].to_i
  end
  @codes=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOEnemies.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOEnemies.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][2]=b[i][2].split(', ')
  end
  @enemies=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOClothes.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOClothes.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][5]=b[i][5].split(', ').map{|q| q.to_i}
  end
  @clothes=b.map{|q| q}
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

def nicknames_load(mode=1)
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

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Liz
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'FGO!reboot'
  exec "cd C:/Users/Mini-Matt/Desktop/devkit && LizBot.rb #{@shardizard}"
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
  elsif ['shard','attribute'].include?(command.downcase)
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
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats.  If you include the word \"Fou\", the combat stats will be displayed with Fou modifiers\n\nIf it is safe to spam, also shows information on `name`s skills, traits, Noble Phantasm, and Bond CE.",0xED619A)
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(command.downcase) || (['stat','stats'].include?(command.downcase) && ['tiny','small','micro','smol','squashed','little'].include?("#{subcommand}".downcase))
    create_embed(event,"**#{command.downcase}#{" #{subcommand.downcase}" if ['stat','stats'].include?(command.downcase)}** __name__","Shows `name`'s stats, in a condensed format.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Silver Fou modifiers.\nInclude the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['stats','stat'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Fou modifiers.\n\nIf it is not safe to spam, this command automatically reverts to the `smol` command, and thus you need to include the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['traits','trait'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s traits.\n\nUnlike other servant-based commands, this one also accepts enemy fighter names.",0xED619A)
  elsif ['skills'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s skills.\n\nIf it is safe to spam, each skill will also be given additional information.",0xED619A)
  elsif ['skill'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the skill data for the skill `name`.\nIf no rank is given and `name` is a skill with multiple ranks, shows all.",0xED619A)
  elsif ['np','noble','phantasm','noblephantasm'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Noble Phantasm.\n\nIf it is not safe to spam, I will show the effects for only the default NP level, and it can be adjusted to show other NP levels based on included arguments in the format \"NP#{rand(5)+1}\"\nIf it is safe to spam, I will show all the effects naturally.",0xED619A)
  elsif ['bond','bondce'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Bond CE.",0xED619A)
  elsif ['art'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s art.\n\nDefaults to their normal art, but can be modified to other arts based on the following words:\nFirst/1st/FirstAscension/1stAscension\nSecond/2nd/SecondAscension/2ndAscension\nThird/3rd/ThirdAscension/3rdAscension\nFinal/Fourth/4th/FinalAscension/FourthAscension/4thAscension\nCostume/FirstCostume/1stCostume\nSecondCostume/2ndCostume\nRiyo/AprilFool's\n\nIf the requested art doesn't exist, reverts back to default art.",0xED619A)
  elsif ['riyo'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Riyo art, which is shown on April Fool's.",0xED619A)
  elsif ['ce','craft','essance','craftessance'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is the name of a CE, shows that CE's info.\nIf `name` is the name of a servant, shows that servant's Bond CE.\n\nIf `name` is a number, prioritizes servant ID over Craft Essence ID.",0xED619A)
  elsif ['commandcode','command'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the information about the command code named `name`.",0xED619A)
  elsif ['mysticcode','mysticode','mystic','clothing','clothes'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the information about the mystic code named `name`.",0xED619A)
  elsif ['code'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is the name or ID number of a command code, shows that command code's info.",0xED619A)
  elsif ['mats','ascension','enhancement','enhance','materials'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Ascension, Skill Enhancement, and Costume Creation materials.",0xED619A)
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
  elsif ['find','list','search'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*filters__","Displays all servants that fit `filters`.\n\nYou can search by:\n- Class\n- Growth Curve\n- Attribute\n- Traits\n- Availability\n- Alignment\n\nIf too many servants are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
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
    create_embed([event,x],"Command Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0') || q.include?('II')}.map {|s| "`#{s.gsub('FATE','Fate').gsub('LIZ','Liz')}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n__**Liz Bot help**__","__**Servant data**__\n`servant` __name__ - displays all info about a servant (*also `data`*)\n`stats` __name__ - displays a servant's stats\n`skills` __name__ - displays a servant's skills\n`traits` __name__ - displays a servant's traits\n`np` __name__ - displays a servant's Noble Phantasm\n`bondCE` __name__ - displays a servant's Bond CE (*also `ce`*)\n`mats` __name__ - displays a servant's materials (*also `ascension` or `enhancement`*)\n`aliases` __name__ - displays a servant's aliases\n`art` __name__ - displays a servant's art\n\n__**Other data**__\n`ce` __name__ - displays data for a Craft Essence\n`commandcode` __name__ - displays data for a Command Code\n`mysticcode` __name__ - displays data for a Mystic Code (*also `clothing` or `clothes`*)\n`skill` __name__ - displays a skill's effects\n`find` __\*filters__ - search for servants (*also `list` or `search`*)\n\n__**Meta Data**__\n`invite` - for a link to invite me to your server\n`snagstats` __type__ - to receive relevant bot stats\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)\n\n__**Developer Information**__\n`bugreport` __\\*message__ - to send my developer a bug report\n`suggestion` __\\*message__ - to send my developer a feature suggestion\n`feedback` __\\*message__ - to send my developer other kinds of feedback\n~~the above three commands are actually identical, merely given unique entries to help people find them~~",0xED619A)
    create_embed([event,x],"__**Server Admin Commands**__","__**Unit Aliases**__\n`addalias` __new alias__ __unit__ - Adds a new server-specific alias\n~~`aliases` __unit__ (*also `checkaliases` or `seealiases`*)~~\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias",0xC31C19) if is_mod?(event.user,event.server,event.channel)
    create_embed([event,x],"__**Bot Developer Commands**__","__**Mjolnr, the Hammer**__\n`ignoreuser` __user id number__ - makes me ignore a user\n`leaveserver` __server id number__ - makes me leave a server\n\n__**Communication**__\n`status` __\\*message__ - sets my status\n`sendmessage` __channel id__ __\\*message__ - sends a message to a specific channel\n`sendpm` __user id number__ __\\*message__ - sends a PM to a user\n\n__**Server Info**__\n`snagstats` - snags relevant bot stats\n\n__**Shards**__\n`reboot` - reboots this shard\n\n__**Meta Data Storage**__\n`backupaliases` - backs up the alias list\n`restorealiases` - restores the alias list from last backup\n`sortaliases` - sorts the alias list by servant",0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || @shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0') || q.include?('II')}.map {|s| "`#{s.gsub('FATE','Fate').gsub('LIZ','Liz')}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
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
     'noblephantasm','ce','bond','bondce','mats','ascension','enhancement','enhance','materials','art','riyo','code','command','commandcode','craft','find',
     'essance','craftessance','list','search','skill','mysticcode','mysticode','mystic','clothes','clothing']
  k=['addalias','deletealias','removealias'] if permissions==1
  k=['sortaliases','status','sendmessage','sendpm','leaveserver','cleanupaliases','backupaliases','reboot'] if permissions==2
  k.push(nil) if include_nil
  return k
end

def find_servant(name,event,fullname=false)
  data_load()
  name=normalize(name)
  if name.to_i.to_s==name && name.to_i<=@servants[-1][0] && name.to_i>0
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
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@servants.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @servants[k] unless k.nil?
  nicknames_load()
  g=0
  g=event.server.id unless event.server.nil?
  k=@aliases.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @servants[@servants.find_index{|q| q[0]==@aliases[k][1]}] unless k.nil?
  return [] if fullname
  k=@servants.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @servants[k] unless k.nil?
  nicknames_load()
  for i in name.length...@aliases.map{|q| q[0].length}.max
    k=@aliases.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return @servants[@servants.find_index{|q| q[0]==@aliases[k][1]}] unless k.nil?
  end
  return []
end

def find_servant_ex(name,event,fullname=false)
  k=find_servant(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_servant(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
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

def find_ce(name,event,fullname=false)
  data_load()
  name=normalize(name)
  if name.to_i.to_s==name && name.to_i<=@servants[-1][0] && name.to_i>0
    return []
  elsif name.to_i.to_s==name && name.to_i<=@crafts[-1][0] && name.to_i>0
    return @crafts[@crafts.find_index{|q| q[0]==name.to_f}]
  elsif name.to_i==2030
    return @crafts[@crafts.find_index{|q| q[1].include?('2030')}]
  end
  if name[0,1]=='#'
    name2=name[1,name.length-1]
    if name2.to_i.to_s==name2 && name2.to_i<=@servants[-1][0] && name2.to_i>0
      return []
    elsif name2.to_i.to_s==name2 && name2.to_i<=@crafts[-1][0] && name2.to_i>0
      return @crafts[@crafts.find_index{|q| q[0]==name2.to_f}]
    elsif name2.to_i==2030
      return @crafts[@crafts.find_index{|q| q[1].include?('2030')}]
    end
  end
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="the#{name}" && q[1][0,4].downcase=='the '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="a#{name}" && q[1][0,2].downcase=='a '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="an#{name}" && q[1][0,3].downcase=='an '}
  return @crafts[k] unless k.nil?
  return [] if fullname
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('the ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,4].downcase=='the '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('a ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,2].downcase=='a '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('an ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,3].downcase=='an '}
  return @crafts[k] unless k.nil?
  return []
end

def find_ce_ex(name,event,fullname=false)
  k=find_ce(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_ce(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
  k=find_ce(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_ce(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def find_code(name,event,fullname=false)
  data_load()
  name=normalize(name)
  if name.to_i.to_s==name && name.to_i<=@codes[-1][0] && name.to_i>0
    return @codes[@codes.find_index{|q| q[0]==name.to_i}]
  end
  if name[0,1]=='#'
    name2=name[1,name.length-1]
    if name2.to_i.to_s==name2 && name2.to_i<=@codes[-1][0] && name2.to_i>0
      return @codes[@codes.find_index{|q| q[0]==name2.to_i}]
    end
  end
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@codes.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @codes[k] unless k.nil?
  k=@codes.find_index{|q| q[1].gsub('Code: ','').downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @codes[k] unless k.nil?
  return [] if fullname
  k=@codes.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @codes[k] unless k.nil?
  k=@codes.find_index{|q| q[1].gsub('Code: ','').downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @codes[k] unless k.nil?
  return []
end

def find_code_ex(name,event,fullname=false)
  k=find_code(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_code(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
  k=find_code(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_code(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def find_enemy(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@enemies.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @enemies[k] unless k.nil?
  return [] if fullname
  k=@enemies.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @enemies[k] unless k.nil?
  return []
end

def find_enemy_ex(name,event,fullname=false)
  k=find_enemy(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_enemy(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
  k=find_enemy(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_enemy(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def find_skill(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  sklz=@skills.reject{|q| q[2]=='Noble'}
  return [] if name.length<2
  return sklz.reject{|q| q[0][0,17]!='Primordial Rune ('} if name=='primordialrune'
  return sklz.reject{|q| q[0]!='Innocent Monster' || q[1][0,2]!='EX'} if name=='innocentmonsterex'
  k=sklz.find_index{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz[k] unless k.nil?
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz.reject{|q| q[0]!=sklz[k][0] || q[2]!=sklz[k][2]} unless k.nil?
  return [] if fullname
  return sklz.reject{|q| q[0][0,17]!='Primordial Rune ('} if name=='primordialrune'[0,name.length]
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz.reject{|q| q[0]!=sklz[k][0] || q[2]!=sklz[k][2]} unless k.nil?
  return []
end

def find_skill_ex(name,event,fullname=false)
  k=find_skill(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_skill(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
  k=find_skill(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_skill(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def find_clothes(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@clothes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @clothes[k] unless k.nil?
  return [] if fullname
  k=@clothes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @clothes[k] unless k.nil?
  return []
end

def find_clothes_ex(name,event,fullname=false)
  k=find_clothes(name,event,true)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_clothes(args[i,args.length-1-i-i2].join(' '),event,true)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return [] if fullname
  k=find_clothes(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length-1
    for i2 in 0...args.length-i
      k=find_clothes(args[i,args.length-1-i-i2].join(' '),event)
      k=[] if args[i,args.length-1-i-i2].length<=0
      return k if k.length>0
    end
  end
  return []
end

def find_emote(bot,event,item)
  k=event.message.text.downcase.split(' ')
  return item if k.include?('colorblind') || k.include?('textmats')
  k=item.split(' ')[-1]
  item=item.split(' ')
  item.pop
  item=item.join(' ')
  moji=bot.server(508792801455243266).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(508793141202255874).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(508793425664016395).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  return "#{item} #{k}"
end

def avg_color(c,mode=0)
  m=[0,0,0]
  for i in 0...c.length
    m[0]+=c[i][0]
    m[1]+=c[i][1]
    m[2]+=c[i][2]
  end
  m[0]/=c.length
  m[1]/=c.length
  m[2]/=c.length
  return m if mode==1
  return 256*256*m[0]+256*m[1]+m[2]
end

def servant_color(k)
  xcolor=[237,97,154]
  xcolor=[33,188,44] if k[17][6,1]=='Q'
  xcolor=[11,77,223] if k[17][6,1]=='A'
  xcolor=[254,33,22] if k[17][6,1]=='B'
  m=[]
  m.push(xcolor)
  m.push(xcolor)
  m.push([33,188,44]) if k[17][1,1]=='Q'
  m.push([33,188,44]) if k[17][1,2]=='QQ'
  m.push([254,33,22]) if k[17][3,1]=='B'
  m.push([254,33,22]) if k[17][2,2]=='BB'
  m.push([11,77,223]) if k[17].include?('AA')
  m.push([11,77,223]) if k[17].include?('AAA')
  return avg_color(m)
end

def numabr(n)
  return "#{n/1000000000}bil" if n>=1000000000 && n%1000000000==0
  return "#{n.to_f/1000000000}bil" if n>=1000000000
  return "#{n/1000000}mil" if n>=1000000 && n%1000000==0
  return "#{n.to_f/1000000}mil" if n>=1000000
  return "#{n/1000}k" if n>=1000 && n%1000==0
  return "#{n.to_f/1000}k" if n>=1000
  return n
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
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
  text="**0-star**" if k[3]==0
  np="*"
  np=":* #{@skills[@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}][3]}" unless @skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}.nil?
  kx=@crafts.find_index{|q| q[0]==k[23]}
  bond=">No Bond CE<"
  bond="**Bond CE:** >Unknown<" if k[0]<2
  bond="**Bond CE:** #{@crafts[kx][1]}" unless kx.nil?
  text="#{text}\n**Maximum default level:** *#{k[5]}* (#{k[4]} growth curve)\n**Team Cost:** #{k[21]}\n**Availability:** *#{k[20]}*\n\n**Class:** *#{k[2]}*\n**Attribute:** *#{k[12]}*\n**Alignment:** *#{k[22]}*\n\n**Command Deck:** #{k[17][0,5].gsub('Q','<:quick:509064606438653992>').gsub('A','<:arts:509064605830742016>').gsub('B','<:buster:509064606233133056>')} (#{k[17][0,5]})\n**Noble Phantasm:** #{k[17][6,1].gsub('Q','<:quick:509064606438653992>').gsub('A','<:arts:509064605830742016>').gsub('B','<:buster:509064606233133056>')} *#{k[16]}#{np}\n\n#{bond}\n\n**Death Rate:** #{k[11]}%"
  fou=990
  fou=1000 if dispstr.include?('fou') && dispstr.include?('jp')
  fou=1000 if dispstr.include?('jpfou') || dispstr.include?('jp_fou') || dispstr.include?('foujp') || dispstr.include?('fou_jp')
  fou=1000 if dispstr.include?('fou-jp') || dispstr.include?('jp-fou')
  flds=[["Combat stats","__**Level 1**__\n*HP* - #{longFormattedNumber(k[6][0])}  \n*Atk* - #{longFormattedNumber(k[7][0])}  \n\n__**Level #{k[5]}**__\n*HP* - #{longFormattedNumber(k[6][1])}  \n*Atk* - #{longFormattedNumber(k[7][1])}  \n\n__**Level 100<:holy_grail:508802653829070886>**__\n*HP* - #{longFormattedNumber(k[6][2])}  \n*Atk* - #{longFormattedNumber(k[7][2])}  "]]
  flds=[["Combat stats","__**Level 1**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][0]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][0]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][0]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][0]+2000)}  \n\n__**Level #{k[5]}**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][1]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][1]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][1]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][1]+2000)}  \n\n__**Level 100<:holy_grail:508802653829070886>**__\n*HP* - <:Fou:503453296242196500>#{longFormattedNumber(k[6][2]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[6][2]+2000)}  \n*Atk* - <:Fou:503453296242196500>#{longFormattedNumber(k[7][2]+fou)} - <:GoldenFou:503453297068212224>#{longFormattedNumber(k[7][2]+2000)}"]] if dispfou
  flds.push(["Attack Parameters","__**Hit Counts**__\n*Quick*: #{k[9][0]}\n*Arts*: #{k[9][1]}\n*Buster*: #{k[9][2]}\n*Extra*: #{k[9][3]}\n*NP*: #{k[9][4]}\n\n__**NP Gain**__\n*Attack:* #{k[8][0]}%#{"\n*Alt. Atk.:* #{k[8][2]}% (#{k[8][3]})" unless k[8][2].nil?}\n*Defense:* #{k[8][1]}%\n\n__**Crit Stars**__\n*Weight:* #{k[10][0]}\n*Drop Rate:* #{k[10][1]}%"])
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  create_embed(event,"__**#{k[1]}**__ [##{k[0]}]",text,xcolor,ftr,xpic,flds,2)
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
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
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
  text="#{text}\n**Max. default level:** *#{k[5]}*\u00A0\u00B7\u00A0**Team Cost:** #{k[21]}\n**Availability:** *#{k[20]}*\n\n**Class:** *#{k[2]}*\u00A0\u00B7\u00A0**Attribute:** *#{k[12]}*\n**Alignment:** *#{k[22]}*\n\n**Command Deck:** #{k[17][0,5].gsub('Q','<:quick:509064606438653992>').gsub('A','<:arts:509064605830742016>').gsub('B','<:buster:509064606233133056>')} (#{k[17][0,5]})\n**Noble Phantasm:** #{k[17][6,1].gsub('Q','<:quick:509064606438653992>').gsub('A','<:arts:509064605830742016>').gsub('B','<:buster:509064606233133056>')} #{k[16]}\n\n#{bond}\n\n**HP:**\u00A0\u00A0#{longFormattedNumber(k[6][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][2]+dispfou)}<:holy_grail:508802653829070886>\n**Atk:**\u00A0\u00A0#{longFormattedNumber(k[7][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][2]+dispfou)}<:holy_grail:508802653829070886>\n**Death Rate:**\u00A0#{k[11]}%\n\n**Hit Counts**:\u00A0\u00A0<:quick:509064606438653992>#{k[9][0]}\u00A0\u00A0\u00B7\u00A0\u00A0<:arts:509064605830742016>#{k[9][1]}\u00A0\u00A0\u00B7\u00A0\u00A0<:buster:509064606233133056>#{k[9][2]}  \u00B7  <:extra:509064605729816578>#{k[9][3]}\u00A0\u00A0\u00B7\u00A0\u00A0*NP:*\u00A0#{k[9][4]}\n**NP\u00A0Gain:**\u00A0\u00A0*Attack:*\u00A0#{k[8][0]}%#{"  \u00B7  *Alt.Atk.:*\u00A0#{k[8][2]}%\u00A0(#{k[8][3].gsub(' ',"\u00A0")})" unless k[8][2].nil?}  \u00B7  *Defense:*\u00A0#{k[8][1]}%\n**Crit Stars:**\u00A0\u00A0*Weight:*\u00A0#{k[10][0]}\u00A0\u00A0\u00B7\u00A0\u00A0*Drop Rate:*\u00A0#{k[10][1]}%"
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
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  text="#{text}\n**Attribute:** *#{k[12]}*\n**Alignment:** *#{k[22]}*"
  text="#{text}\n**Gender:** *#{k[13][0]}*" if ['Female','Male'].include?(k[13][0])
  text="#{text}\n~~**Gender:** *Effeminate*~~" if [10,94,143].include?(k[0])
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}",text,xcolor,nil,xpic,triple_finish(k[13].reject{|q| ['Female','Male'].include?(q)}))
end

def disp_enemy_traits(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_enemy_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  create_embed(event,"__**#{k[0]}**__ [Enemy]","**Attribute:** *#{k[1]}*",0x800000,nil,nil,triple_finish(k[2]))
end

def disp_servant_skills(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
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
        str="#{str}\n*Cooldown:* #{@skills[k2][3]}\u00A0L#{micronumber(1)}  \u00B7  #{@skills[k2][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{@skills[k2][3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{@skills[k2][4]}"
        for i2 in 5...@skills[k2].length
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
          k2=@skills.find_index{|q| q[2]=='Skill' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[14][i][1] && @skills[k2]!=q}
          str="#{str}\n*Cooldown:* #{@skills[k2][3]}\u00A0L#{micronumber(1)}  \u00B7  #{@skills[k2][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{@skills[k2][3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{@skills[k2][4]}"
          for i2 in 5...@skills[k2].length
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
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  np="*"
  nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}
  unless nophan.nil?
    nophan=@skills[nophan]
    np="#{':* ' unless chain}#{nophan[3].encode(Encoding::UTF_8).gsub('┬á','')}"
  end
  text="#{text}\n**Noble Phantasm:** *#{k[16].encode(Encoding::UTF_8).gsub('┬á','')}#{np}" unless chain
  npl=1
  npl=2 if event.message.text.downcase.split(' ').include?('np2')
  npl=3 if event.message.text.downcase.split(' ').include?('np3')
  npl=4 if event.message.text.downcase.split(' ').include?('np4')
  npl=5 if event.message.text.downcase.split(' ').include?('np5')
  unless nophan.nil?
    l=[nophan[5],nophan[6]]
    text="#{text}\n**Type:** #{nophan[5].encode(Encoding::UTF_8).gsub('┬á','')}\n**Target:** #{nophan[6].encode(Encoding::UTF_8).gsub('┬á','')}\n\n**Rank:** #{nophan[4].encode(Encoding::UTF_8).gsub('┬á','')}\n__**Effects**__"
    for i in 7...17
      unless nophan[i][0]=='-'
        text="#{text}\n*#{nophan[i][0].encode(Encoding::UTF_8).gsub('┬á','')}*"
        if nophan[i][0].include?('<OVERCHARGE>') || (nophan[i][0].include?('<LEVEL>') && safe_to_spam?(event))
          text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','')}\u00A0/\u00A0#{nophan[i][2].encode(Encoding::UTF_8).gsub('┬á','')}\u00A0/\u00A0#{nophan[i][3].encode(Encoding::UTF_8).gsub('┬á','')}\u00A0/\u00A0#{nophan[i][4].encode(Encoding::UTF_8).gsub('┬á','')}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','')}" unless nophan[i][1].nil? || nophan[i][1]=='-'
        else
          text="#{text} - #{nophan[i][npl].encode(Encoding::UTF_8).gsub('┬á','')}" unless nophan[i][npl].nil? || nophan[i][npl]=='-'
        end
      end
    end
    nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]=="#{k[0].to_s}u"}
    unless nophan.nil?
      nophan=@skills[nophan]
      nophan[5]=nophan[5].encode(Encoding::UTF_8).gsub('┬á','')
      nophan[6]=nophan[6].encode(Encoding::UTF_8).gsub('┬á','')
      l[0]=(nophan[5]!=l[0] rescue (nophan[5].encode(Encoding::UTF_8)!=l[0].encode(Encoding::UTF_8)))
      l[1]=(nophan[6]!=l[1] rescue (nophan[6].encode(Encoding::UTF_8)!=l[1].encode(Encoding::UTF_8)))
      text="#{text}#{"\n" if l[0] || l[1]}"
      text="#{text}#{"\n**Type:** #{nophan[5].encode(Encoding::UTF_8)}" if l[0]}"
      text="#{text}#{"\n**Target:** #{nophan[6].encode(Encoding::UTF_8)}" if l[1]}"
      text="#{text}\n\n**Rank:** #{nophan[4].encode(Encoding::UTF_8)}"
      text="#{text}\n__**Effects**__"
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

def disp_servant_ce(bot,event,args=nil,chain=false,skipftr=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  text=''
  ce=@crafts.find_index{|q| q[0]==k[23]}
  ce=@crafts[ce] unless ce.nil?
  ftr=nil
  if event.message.text.split(' ').include?(k[0].to_s) && k[0]>=2 && !skipftr
    cex=@crafts[k[0]-1]
    ftr="This is the Bond CE for servant ##{k[0]}.  For the CE numbered #{k[0]}, it is named \"#{cex[1]}\"."
  elsif event.message.text.split(' ').include?('1') && k[0]<2 && !skipftr
    cex=@crafts[0]
    ftr="This is the Bond CE for servant ##{k[0]}.  For the CE numbered #{k[0].to_i}, it is named \"#{cex[1]}\"."
  end
  if ce.nil?
    xpic=nil
    text=">No CE information known<"
    return nil if chain
  else
    ce[7]="#{ce[6]}" if ce[7].nil? || ce[7].length<=0
    xpic="https://fate-go.cirnopedia.org/icons/essence/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.jpg"
    text="#{"<:FGO_icon_star_mono:509072675344351232>"*ce[2]}\n**Cost:** #{ce[3]}"
    text="#{text}\n**Bond CE for:** *#{k[1]} [##{k[0]}]*" unless chain
    if ce[4]==ce[5] && ce[6]==ce[7]
      text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6]}"
    else
      text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6]}"
      text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7]}"
    end
    text="#{text}\n\n__**Artist**__\n#{ce[9]}" unless ce[9].nil? || ce[9].length.zero?
    text="#{text}\n\n__**Additional info**__\n#{ce[10]}" unless ce[10].nil? || ce[10].length.zero?
  end
  create_embed(event,"#{"**#{ce[1]}** [CE ##{ce[0]}]" unless ce.nil?}",text,xcolor,ftr,xpic)
end

def disp_servant_mats(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:509064606166155304>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  xpic="http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  if k[18][4].nil? && !k[18][5].nil?
    k[18][4]=k[18][5].map{|q| q}
    k[18][5]=nil
  end
  qp=[10000,30000,90000,300000,10000,20000,60000,80000,200000,250000,500000,600000,1000000]
  qp=[15000,45000,150000,450000,20000,40000,120000,160000,400000,500000,1000000,1200000,2000000] if k[3]==2 || k[3]==0
  qp=[30000,100000,300000,900000,50000,100000,300000,400000,1000000,1250000,2500000,3000000,5000000] if k[3]==3
  qp=[50000,150000,500000,1500000,100000,200000,600000,800000,2000000,2500000,5000000,6000000,10000000] if k[3]==4
  qp=[100000,300000,1000000,3000000,200000,400000,1200000,1600000,4000000,5000000,10000000,12000000,20000000] if k[3]==5
  k[18]=k[18].map{|q| q.map{|q2| find_emote(bot,event,q2)}}
  k[19]=k[19].map{|q| q.map{|q2| find_emote(bot,event,q2)}}
  # <:QP:508802778982907920>
  qpd='<:QP:508802778982907920>'
  qpd=' QP' if event.message.text.downcase.split(' ').include?('colorblind') || event.message.text.downcase.split(' ').include?('textmats')
  flds=[['Ascension materials',"**First Ascension:** #{k[18][0].join(', ')}  \u00B7  #{numabr(qp[0])}#{qpd}\n**Second Ascension:** #{k[18][1].join(', ')}  \u00B7  #{numabr(qp[1])}#{qpd}\n**Third Ascension:** #{k[18][2].join(', ')}  \u00B7  #{numabr(qp[2])}#{qpd}\n**Final Ascension:** #{k[18][3].join(', ')}  \u00B7  #{numabr(qp[3])}#{qpd}"]]
  flds[0]=['Ascension',"**First Ascension:** #{k[18][0].join(', ')}\n**Second Ascension:** #{k[18][1].join(', ')}\n**Third Ascension:** #{k[18][2].join(', ')}\n**Final Ascension:** #{k[18][3].join(', ')}"] if k[0]<2
  flds.push(['Costume materials',"**First Costume:** #{k[18][4].join(', ')}  \u00B7  3mil#{qpd}#{"\n**Second Costume:** #{k[18][5].join(', ')}  \u00B7  3mil#{qpd}" unless k[18][5].nil?}"]) unless k[18][4].nil? || k[0]<2
  flds.push(['Costume materials',"**First Costume:** #{k[18][4].join(', ')}  \u00B7  3mil#{qpd}#{"\n**Second Costume:** #{k[18][5].join(', ')}" unless k[18][5].nil?}"]) unless k[18][4].nil? || k[0]>=2
  flds.push(['Skill Enhancement materials',"**Level 1\u21922:** #{k[19][0].join(', ')}  \u00B7  #{numabr(qp[4])}#{qpd}\n**Level 2\u21923:** #{k[19][1].join(', ')}  \u00B7  #{numabr(qp[5])}#{qpd}\n**Level 3\u21924:** #{k[19][2].join(', ')}  \u00B7  #{numabr(qp[6])}#{qpd}\n**Level 4\u21925:** #{k[19][3].join(', ')}  \u00B7  #{numabr(qp[7])}#{qpd}\n**Level 5\u21926:** #{k[19][4].join(', ')}  \u00B7  #{numabr(qp[8])}#{qpd}\n**Level 6\u21927:** #{k[19][5].join(', ')}  \u00B7  #{numabr(qp[9])}#{qpd}\n**Level 7\u21928:** #{k[19][6].join(', ')}  \u00B7  #{numabr(qp[10])}#{qpd}\n**Level 8\u21929:** #{k[19][7].join(', ')}  \u00B7  #{numabr(qp[11])}#{qpd}\n**Level 9\u219210:** #{k[19][8].join(', ')}  \u00B7  #{numabr(qp[12])}#{qpd}"]) unless k[19].nil? || k[19][0].nil? || k[19][0][0].nil? || k[19][0][0].length<=0 || k[19][0][0]=='-'
  ftr=nil
  ftr='If you have trouble seeing the material icons, try the command again with the word "TextMats" included in your message.' unless event.message.text.downcase.split(' ').include?('colorblind') || event.message.text.downcase.split(' ').include?('textmats')
  if flds.map{|q| "__**#{q[0]}**__\n#{q[1]}"}.join("\n\n").length>=1500
    create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}",text,xcolor,nil,xpic,flds[0,flds.length-1],1)
    k=flds[-1][1].split("\n")
    str="__**#{flds[-1][0]}**__"
    respo=false
    for i in 0...k.length
      str=extend_message(str,k[i],event)
      respo=true if str[0,1]!='_'
    end
    str=extend_message(str,"\n#{ftr}",event)
    respo=true if str[0,1]!='_'
    if respo
      event.respond str
    else
      create_embed(event,'',str,xcolor)
    end
  else
    create_embed(event,"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}",text,xcolor,ftr,xpic,flds,2)
  end
end

def disp_servant_art(bot,event,args=nil,riyodefault=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_servant_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=servant_color(k)
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_s.gsub('.','p')}"
  disptext=event.message.text.downcase
  artist=nil
  artist=k[24] unless k[24].nil? || k[24].length<=0
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}1.png"
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}2.png" if disptext.split(' ').include?('first') || disptext.split(' ').include?('firstascension') || disptext.split(' ').include?('first_ascension') || " #{disptext} ".include?(" first ascension ") || disptext.split(' ').include?('1st') || disptext.split(' ').include?('1stascension') || disptext.split(' ').include?('1st_ascension') || " #{disptext} ".include?(" 1st ascension ") || disptext.split(' ').include?('second') || disptext.split(' ').include?('secondascension') || disptext.split(' ').include?('second_ascension') || " #{disptext} ".include?(" second ascension ") || disptext.split(' ').include?('2nd') || disptext.split(' ').include?('2ndascension') || disptext.split(' ').include?('2nd_ascension') || " #{disptext} ".include?(" 2nd ascension ")
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}3.png" if disptext.split(' ').include?('third') || disptext.split(' ').include?('thirdascension') || disptext.split(' ').include?('third_ascension') || " #{disptext} ".include?(" third ascension ") || disptext.split(' ').include?('3rd') || disptext.split(' ').include?('3rdascension') || disptext.split(' ').include?('3rd_ascension') || " #{disptext} ".include?(" 3rd ascension ")
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}4.png" if disptext.split(' ').include?('fourth') || disptext.split(' ').include?('fourthascension') || disptext.split(' ').include?('fourth_ascension') || " #{disptext} ".include?(" fourth ascension ") || disptext.split(' ').include?('4th') || disptext.split(' ').include?('4thascension') || disptext.split(' ').include?('4th_ascension') || " #{disptext} ".include?(" 4th ascension ") || disptext.split(' ').include?('final') || disptext.split(' ').include?('finalascension') || disptext.split(' ').include?('final_ascension') || " #{disptext} ".include?(" final ascension ")
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}5.png" if disptext.split(' ').include?('costume') || disptext.split(' ').include?('firstcostume') || disptext.split(' ').include?('first_costume') || " #{disptext} ".include?(" first costume ") || disptext.split(' ').include?('1stcostume') || disptext.split(' ').include?('1st_costume') || " #{disptext} ".include?(" 1st costume ")
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}6.png" if disptext.split(' ').include?('secondcostume') || disptext.split(' ').include?('second_costume') || " #{disptext} ".include?(" second costume ") || disptext.split(' ').include?('2ndcostume') || disptext.split(' ').include?('2nd_costume') || " #{disptext} ".include?(" 2nd costume ")
  if riyodefault || disptext.split(' ').include?('riyo') || disptext.split(' ').include?('aprilfools') || disptext.split(' ').include?("aprilfool's") || disptext.split(' ').include?("april_fool's") || disptext.split(' ').include?("april_fools") || " #{disptext} ".include?(" april fool's ") || " #{disptext} ".include?(" april fools ")
    xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/servant_#{dispnum}.png"
    artist='Riyo'
  end
  text=''
  m=false
  IO.copy_stream(open(xpic), "C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png") rescue m=true
  if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
    xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}1.png"
    text='Requested art not found.  Default art shown.'
  end
  f=[[],[],[]]
  f[2]=@servants.reject{|q| q[24]!=artist || q[25]!=k[25] || q[0]==k[0]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"} unless artist.nil? || k[25].nil? || k[25].length<=0
  f[0]=@servants.reject{|q| q[24]!=artist || q[0]==k[0]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.reject{|q| f[2].include?(q)} unless artist.nil?
  f[1]=@servants.reject{|q| q[25]!=k[25] || q[0]==k[0]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.reject{|q| f[2].include?(q)} unless k[25].nil? || k[25].length<=0
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    f[2]=@servants.reject{|q| q[24]!=artist || q[25]!=k[25] || q[0]==k[0]}.map{|q| q[0]} unless artist.nil? || k[25].nil? || k[25].length<=0
    f[0]=@servants.reject{|q| q[24]!=artist || q[0]==k[0]}.map{|q| q[0]}.reject{|q| f[2].include?(q)} unless artist.nil?
    f[1]=@servants.reject{|q| q[25]!=k[25] || q[0]==k[0]}.map{|q| q[0]}.reject{|q| f[2].include?(q)} unless k[25].nil? || k[25].length<=0
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    if !b[i][6].nil? && b[i][6].length>0 && !b[i][8].nil? && b[i][8].length>0
      f[2].push("#{b[i][0]}#{' *[FEH]*' unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)}") if b[i][6].split(' as ')[-1]==artist && b[i][8].split(' as ')[0]==k[25]
    end
    if !b[i][6].nil? && b[i][6].length>0
      f[0].push("#{b[i][0]}#{' *[FEH]*' unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)}") if b[i][6].split(' as ')[-1]==artist && b[i][8].split(' as ')[0]!=k[25]
    end
    if !b[i][8].nil? && b[i][8].length>0
      f[1].push("#{b[i][0]}#{' *[FEH]*' unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)}") if b[i][6].split(' as ')[-1]!=artist && b[i][8].split(' as ')[0]==k[25]
    end
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    event.respond "#{text}#{"\n\n**Artist:** #{artist}" unless artist.nil?}#{"\n\n**VA (Japanese):** #{k[25]}" unless k[25].nil? || k[25].length<=0}\n#{xpic}"
  else
    f=[['Same Artist',f[0]],['Same VA',f[1]],['Same everything',f[2],1]]
    for i in 0...f.length
      f[i][1]=f[i][1].join("\n")
      f[i]=nil if f[i][1].length<=0
    end
    f.compact!
    f=nil if f.length<=0
    text="#{text}\n" if !artist.nil? || !(k[25].nil? || k[25].length<=0)
    text="#{text}\n**Artist:** #{artist}" unless artist.nil?
    text="#{text}\n**VA (Japanese):** #{k[25]}" unless k[25].nil? || k[25].length<=0
    if f.nil?
    elsif f.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      event.channel.send_embed("__**#{k[1]}**__ [##{k[0]}]") do |embed|
        embed.description=text
        embed.color=xcolor
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
      end
      if f.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...f.length
          event.channel.send_embed('') do |embed|
            embed.color=xcolor
            embed.add_field(name: f[i][0], value: f[i][1], inline: true)
          end
        end
      else
        event.channel.send_embed('') do |embed|
          embed.color=xcolor
          unless f.nil?
            for i in 0...f.length
              embed.add_field(name: f[i][0], value: f[i][1], inline: true)
            end
          end
        end
      end
      return nil
    elsif f.map{|q| q.join("\n")}.join("\n\n").length>=1800
      text="#{text}\nThe list of units with the same artist and/or VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      f=nil
    else
      f[-1][2]=nil if f.length<3
      f[-1].compact!
    end
    event.channel.send_embed("__**#{k[1]}**__ [##{k[0]}]") do |embed|
      embed.description=text
      embed.color=xcolor
      unless f.nil?
        for i in 0...f.length
          embed.add_field(name: f[i][0], value: f[i][1], inline: f[i][2].nil?)
        end
      end
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
    end
  end
end

def disp_ce_card(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  ce=find_ce_ex(args.join(' '),event)
  if ce.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0x7D4529
  xcolor=0x718F93 if ce[2]>2
  xcolor=0xF5D672 if ce[2]>3
  k=@servants.find_index{|q| q[23]==ce[0]}
  k=@servants[k] unless k.nil?
  xcolor=servant_color(k) unless k.nil?
  text=''
  ce[7]="#{ce[6]}" if ce[7].nil? || ce[7].length<=0
  xpic="https://fate-go.cirnopedia.org/icons/essence/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.jpg"
  text="#{"<:FGO_icon_star_mono:509072675344351232>"*ce[2]}\n**Cost:** #{ce[3]}"
  text="#{text}\n**Bond CE for:** *#{k[1]} [##{k[0]}]*" unless k.nil?
  text="#{text}\n**Availability:** #{ce[8]}" if k.nil?
  if ce[4]==ce[5] && ce[6]==ce[7]
    text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6]}"
  else
    text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6]}"
    text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7]}"
  end
  text="#{text}\n\n__**Artist**__\n#{ce[9]}" unless ce[9].nil? || ce[9].length.zero?
  text="#{text}\n\n__**Additional info**__\n#{ce[10]}" unless ce[10].nil? || ce[10].length.zero?
  ftr=nil
  ftr='For the other CE given the title "Heaven\'s Feel" in-game, it has been given the name "Heaven\'s Feel (Anime Japan)".' if ce[0]==35
  create_embed(event,"**#{ce[1]}** [CE ##{ce[0]}]",text,xcolor,ftr,xpic)
end

def disp_code_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  ce=find_code_ex(args.join(' '),event)
  if ce.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0x7D4529
  xcolor=0x718F93 if ce[2]>2
  xcolor=0xF5D672 if ce[2]>3
  text="#{"<:FGO_icon_star_bronze:509072674970927117>"*ce[2]}"
  text="#{text}\n\n**Effect:** #{ce[3]}"
  text="#{text}\n\n**Additional Info:** #{ce[4]}" unless ce[4].nil? || ce[4].length<=0
  xpic="http://fate-go.cirnopedia.org/icons/ccode/ccode_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
  create_embed(event,"**#{ce[1]}** [Command Code ##{ce[0]}]",text,xcolor,nil,xpic)
end

def disp_skill_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_skill_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  k=k[0] if k.length<2 && k[0].is_a?(Array)
  header=''
  text=''
  ftr=nil
  if k[0].is_a?(Array)
    header="__**#{k[0][0]}**__ [#{'Active' if k[0][2]=='Skill'}#{'Passive' if k[0][2]=='Passive'}#{'Clothing' if k[0][2]=='Clothes'} Skill Family]"
    xcolor=0x0080B0
    xcolor=0xB08000 if k[0][2]=='Clothes'
    xcolor=0x008000 if k[0][2]=='Passive'
    if k.reject{|q| q[0][0,17]=='Primordial Rune ('}.length<=0 && k.map{|q| q[0]}.uniq.length>1
      header='__**Primordial Rune**__ [Active Skill Family]'
      xcolor=0x5000A0
      text2=''
      for i in 0...k.length
        text2="__**Version: #{k[i][0].gsub('Primordial Rune (','').gsub(')','')}**__\n*Rank:* #{k[i][1]}\n*Cooldown:* #{k[i][3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{k[i][4]}"
        for i2 in 5...k[i].length
          unless k[i][i2][0]=='-'
            text2="#{text2}\n*#{k[i][i2][0]}*"
            if k[i][i2][1].nil? || k[i][i2][1].length<=0 || k[i][i2][1]=='-'
            elsif k[i][i2][1,10].uniq.length<=1
              text2="#{text2}  \u00B7  Constant #{k[i][i2][1]}"
            else
              text2="#{text2}  \u00B7  #{k[i][i2][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][i2][6]}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][i2][10]}\u00A0L#{micronumber(10)}"
            end
          end
        end
        if text2.length+text.length>=1900
          create_embed(event,header,text,xcolor)
          header=''
          text="#{text2}"
        else
          text="#{text}\n\n#{text2}"
        end
      end
      create_embed(event,header,text,xcolor)
      return nil
    elsif k[0][0]=='Innocent Monster' && k.reject{|q| q[1][0,2]=='EX'}.length<=0
      header='__**Innocent Monster EX**__ [Active Skill Subfamily]'
      xcolor=0x5000A0
    end
    if k[0][2]=='Skill'
      text="#{text}\n*Cooldown:* #{k[0][3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[0][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[0][3]-2}\u00A0L#{micronumber(10)}" if k.map{|q| q[3]}.uniq.length<=1
      text="#{text}\n*Target:* #{k[0][4]}" if k.map{|q| q[4]}.uniq.length<=1
    elsif k[0][2]=='Clothes'
      text="#{text}\n*Cooldown:* #{k[0][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[0][1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[0][1]-2}\u00A0L#{micronumber(10)}" if k.map{|q| q[3]}.uniq.length<=1
    end
    ftr='For a list of servants who have these skills, look a particular rank up in PM.'
    m=@skills.reject{|q| q[0][0,k[0][0].length+2]!="#{k[0][0]} ("}.map{|q| q[0]}.uniq
    m.push('Innocent Kaiju') if k[0][0]=='Innocent Monster'
    ftr="You may also mean: #{list_lift(m,'or')}" if m.length>0
    for i in 0...k.length
      if k[i][2]=='Passive'
        text="#{text}\n**Rank #{k[i][1]}:** #{k[i][3]}"
      elsif k[i][2]=='Clothes'
        text="#{text}\n*Cooldown:* #{k[i][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][1]-2}\u00A0L#{micronumber(10)}" unless k.map{|q| q[1]}.uniq.length<=1
        for i2 in 3...k[i].length
          unless k[i][i2][0]=='-'
            text="#{text}\n*#{k[i][i2][0]}*"
            if k[i][i2][1].nil? || k[i][i2][1].length<=0 || k[i][i2][1]=='-'
            elsif k[i][i2][1,10].uniq.length<=1
              text="#{text}  \u00B7  Constant #{k[i][i2][1]}"
            else
              text="#{text}  \u00B7  #{k[i][i2][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][i2][6]}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][i2][10]}\u00A0L#{micronumber(10)}"
            end
          end
        end
      else
        if k[0][0]=='Innocent Monster' && k.reject{|q| q[1][0,2]=='EX'}.length<=0
          text="#{text}\n\n__**Variation: #{k[i][1].gsub('EX(','').gsub(')','')}**__"
        else
          text="#{text}\n\n__**Rank: #{k[i][1]}**__"
        end
        text="#{text}\n*Cooldown:* #{k[i][3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][3]-2}\u00A0L#{micronumber(10)}" unless k.map{|q| q[3]}.uniq.length<=1
        text="#{text}\n*Target:* #{k[i][4]}" unless k.map{|q| q[4]}.uniq.length<=1
        for i2 in 5...k[i].length
          unless k[i][i2][0]=='-'
            text="#{text}\n*#{k[i][i2][0]}*"
            if k[i][i2][1].nil? || k[i][i2][1].length<=0 || k[i][i2][1]=='-'
            elsif k[i][i2][1,10].uniq.length<=1
              text="#{text}  \u00B7  Constant #{k[i][i2][1]}"
            else
              text="#{text}  \u00B7  #{k[i][i2][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][i2][6]}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][i2][10]}\u00A0L#{micronumber(10)}"
            end
          end
        end
      end
    end
  elsif k[2]=='Passive'
    header="__**#{k[0]} #{k[1]}**__ [Passive Skill]"
    xcolor=0x006000
    text="**Effect:** #{k[3]}"
  elsif k[2]=='Clothes'
    header="__**#{k[0]}**__ [Clothing Skill]"
    xcolor=0x806000
    text="**Cooldown:** #{k[1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[1]-2}\u00A0L#{micronumber(10)}"
    mx=@skills.reject{|q| q[0][0,k[0].length+2]!="#{k[0]} (" || q[1]!=k[1]}.map{|q| "#{q[0]} #{q[1]}"}.uniq
    ftr="You may also mean: #{list_lift(mx,'or')}" if mx.length>0
    m=0
    for i in 3...k.length
      unless k[i][0]=='-'
        m+=1
        text="#{text}\n\n**Effect #{m}:** #{k[i][0]}"
        if k[i][1].nil? || k[i][1].length<=0 || k[i][1]=='-'
        elsif k[i][1,10].uniq.length<=1
          text="#{text}\nConstant #{k[i][1]}"
        elsif !safe_to_spam?(event)
          text="#{text}\n#{k[i][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][6]}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][10]}\u00A0L#{micronumber(10)}"
        else
          text="#{text}\n#{k[i][1]}\u00A0L#{micronumber(1)}"
          for i2 in 2...11
            text="#{text}  \u00B7  #{k[i][i2]}\u00A0L#{micronumber(i2)}"
          end
        end
      end
    end
  else
    header="__**#{k[0]}#{" #{k[1]}" unless k[1]=='-'}**__ [Active Skill]"
    xcolor=0x006080
    text="**Cooldown:** #{k[3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[3]-2}\u00A0L#{micronumber(10)}\n**Target:** #{k[4]}"
    ftr='Use this command in PM for a list of servants who have this skill.' unless safe_to_spam?(event)
    mx=@skills.reject{|q| q[0][0,k[0].length+2]!="#{k[0]} (" || q[1]!=k[1]}.map{|q| "#{q[0]} #{q[1]}"}.uniq
    ftr="You may also mean: #{list_lift(mx,'or')}" if mx.length>0
    m=0
    for i in 5...k.length
      unless k[i][0]=='-'
        m+=1
        text="#{text}\n\n**Effect #{m}:** #{k[i][0]}"
        if k[i][1].nil? || k[i][1].length<=0 || k[i][1]=='-'
        elsif k[i][1,10].uniq.length<=1
          text="#{text}\nConstant #{k[i][1]}"
        elsif !safe_to_spam?(event)
          text="#{text}\n#{k[i][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][6]}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][10]}\u00A0L#{micronumber(10)}"
        else
          text="#{text}\n#{k[i][1]}\u00A0L#{micronumber(1)}"
          for i2 in 2...11
            text="#{text}  \u00B7  #{k[i][i2]}\u00A0L#{micronumber(i2)}"
          end
        end
      end
    end
  end
  create_embed(event,header,text,xcolor,ftr)
  if safe_to_spam?(event)
    srv=[]
    srv2=[]
    if k[0].is_a?(Array)
    elsif k[2]=='Skill'
      srv=@servants.reject{|q| !q[14].map{|q2| q2[0]}.include?("#{k[0]}#{" #{k[1]}" unless k[1]=='-'}")}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}
      srv2=@servants.reject{|q| !q[14].map{|q2| q2[1]}.include?("#{k[0]}#{" #{k[1]}" unless k[1]=='-'}")}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}
    elsif k[2]=='Passive'
      srv=@servants.reject{|q| !q[15].include?("#{k[0]}#{" #{k[1]}" unless k[1]=='-'}")}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}
    end
    flds=[]
    flds.push(['Servants who have it by default',srv.join("\n")]) if srv.length>0
    flds.push(['Servants who have it after upgrading',srv2.join("\n")]) if srv2.length>0
    text=''
    if flds.length==1
      text=flds[0][0]
      flds=triple_finish(flds[0][1].split("\n"),true)
    end
    create_embed(event,'',text,xcolor,nil,nil,flds) if flds.length>0
  end
end

def disp_clothing_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_clothes_ex(args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0xF08000
  text="**Availability:** #{k[1]}"
  if safe_to_spam?(event)
    for i in 2...5
      text="#{text}\n\n__Skill #{i-1}: **#{k[i]}**__"
      skl=@skills.find_index{|q| q[2]=='Clothes' && q[0]==k[i]}
      if skl.nil?
        text="#{text}\n~~No data found~~"
      else
        skl=@skills[skl]
        text="#{text}\n*Cooldown:* #{skl[1]}\u00A0L#{micronumber(1)}  \u00B7  #{skl[1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{skl[1]-2}\u00A0L#{micronumber(10)}"
        for i2 in 3...skl.length
          unless skl[i2][0]=='-'
            text="#{text}\n*#{skl[i2][0]}*"
            if skl[i2][1].nil? || skl[i2][1].length<=0 || skl[i2][1]=='-'
            elsif skl[i2][1,10].uniq.length<=1
              text="#{text}  \u00B7  Constant #{skl[i2][1]}"
            else
              text="#{text}  \u00B7  #{skl[i2][1]}\u00A0L#{micronumber(1)}  \u00B7  #{skl[i2][6]}\u00A0L#{micronumber(6)}  \u00B7  #{skl[i2][10]}\u00A0L#{micronumber(10)}"
            end
          end
        end
      end
    end
    text="#{text}\n\n__**Experience**__"
    for i in 0...k[5].length
      text="#{text}\n*Level #{i+1}\u2192#{i+2}:*  #{longFormattedNumber(k[5][i])}"
    end
  else
    text="#{text}\n\n__**Skills:**__\n#{k[2,3].map{|q| "*#{q}*"}.join("\n")}\n\n**Total EXP to reach level 10:** #{longFormattedNumber(k[5].inject(0){|sum,x| sum + x })}"
  end
  create_embed(event,"__**#{k[0]}**__",text,xcolor)
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

def find_servants(event,args=nil)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  clzz=[]
  curves=[]
  attributes=[]
  traits=[]
  avail=[]
  align1=[]
  align2=[]
  align=[]
  for i in 0...args.length
    clzz.push('Alter Ego') if ['alterego','alter','ego','alteregoes','alters','egoes','alteregos','egos','extra','extras'].include?(args[i])
    clzz.push('Archer') if ['archer','bow','sniper','archa','archers','bows','snipers','archas'].include?(args[i])
    clzz.push('Assassin') if ['assassin','assasshin','assassins','assasshins'].include?(args[i])
    clzz.push('Avenger') if ['avenger','avengers','extra','extras'].include?(args[i])
    clzz.push('Beast') if ['beastclass'].include?(args[i])
    clzz.push('Berserker') if ['berserker','berserkers','berserk','berserks'].include?(args[i])
    clzz.push('Caster') if ['caster','casters','castor','castors','mage','mages','magic'].include?(args[i])
    clzz.push('Foreigner') if ['foreigner','foreigners','extra','extras'].include?(args[i])
    clzz.push('Lancer') if ['lancer','lancers','lance','lances'].include?(args[i])
    clzz.push('Moon Cancer') if ['mooncancer','mooncanser','mooncancers','mooncansers','moonkancer','moonkanser','moonkancers','moonkansers','moon','moons','cancer','cancers','canser','cansers','kancer','kancers','kanser','kansers','extra','extras'].include?(args[i])
    clzz.push('Rider') if ['rider','riders','raida','raidas'].include?(args[i])
    clzz.push('Ruler') if ['ruler','rulers','king','kings','queen','queens','leader','leaders','extra','extras'].include?(args[i])
    clzz.push('Saber') if ['saber','sabers','seiba','seibas'].include?(args[i])
    clzz.push('Shielder') if ['shielder','shielders','shield','shields','sheilder','sheilders','sheild','sheilds','extra','extras'].include?(args[i])
    curves.push('Linear') if ['linear','linear','line','lines'].include?(args[i])
    curves.push('Reverse S') if ['reverses','reverse','backwards','backward'].include?(args[i])
    curves.push('S') if ['s','ess','ses','esses'].include?(args[i])
    curves.push('Semi Reverse S') if ['semireverses','semireverse','semibackwards','semibackward','halfreverses','halfreverse','halfbackwards','halfbackward'].include?(args[i])
    curves.push('Semi S') if ['semi','semis','half','halfs'].include?(args[i])
    attributes.push('Beast') if ['beasts','beast'].include?(args[i])
    attributes.push('Earth') if ['earth','earths','earthers','earthlings','dirt','dirty','terra','terrafirma'].include?(args[i])
    attributes.push('Man') if ['man','men'].include?(args[i])
    attributes.push('Sky') if ['sky','skies','cloud','clouds','skys','sora','ventus'].include?(args[i])
    attributes.push('Star') if ['star','stars','space','spaces'].include?(args[i])
    traits.push('Altria Face') if ['altriaface','altria','altrias','face','saberface','saberfaces'].include?(args[i])
    traits.push('Arthur') if ['arthur','arthurs','kingarthur','kingarthurs'].include?(args[i])
    traits.push("Brynhild's Beloved") if ["brynhild'sbeloved","brynhild'sbeloveds",'brynhildsbeloved','brynhildsbeloveds',"brynhild's",'brynhilds','beloved','beloveds'].include?(args[i])
    traits.push('Demi-Servant') if ['demi-servant','demiservant','demi','demi-servants','demiservants','demis'].include?(args[i])
    traits.push('Divine') if ['divine','devine','godly','god','divines','devines','godlies','godlys','gods'].include?(args[i])
    traits.push('Demonic') if ['demonic','demon','demonics','demons'].include?(args[i])
    traits.push('Dragon') if ['dragon','wyrm','manakete','draco','draconic','dragons','wyrms','manaketes','dracos','draconics'].include?(args[i])
    traits.push('Earth or Sky') if ['earthorsky','earthsky','earthorskys','earthskys','earthorskies','earthskies','earthorskyservant','earthskyservant','earthorskyservants','earthskyservants'].include?(args[i])
    traits.push('Female') if ['female','woman','girl','f','females','women','girls'].include?(args[i])
    traits.push('Humanoid') if ['human','humanoid','humans','humanoids'].include?(args[i])
    traits.push('Male') if ['male','boy','m','males','boys'].include?(args[i])
    traits.push('Mecha') if ['mecha','mech','mechanical','machine','mechas','mechs','mechanicals','machines'].include?(args[i])
    traits.push('Man of Greek Mythology') if ['manofgreekmythology','menofgreekmythology','greekman','greekmen','greek','greeks','mythology','mythologies','myth','myths','mythological'].include?(args[i])
    traits.push('Not Weak to Enuma Elish') if ['notweaktoenumaelish','notweak2enumaelish','safefromenumaelish','notweaktoenuma','notweak2enuma','safefromenuma','notweaktoelish','notweak2elish','safefromelish','notweak'].include?(args[i])
    traits.push('Pseudo-Servant') if ['pseudo-servant','pseudoservant','pseudo','pseudo-servants','pseudoservants','pseudos'].include?(args[i])
    traits.push('Riding') if ['riding','horse','pony','cavalry','cavalier','cav','horses','ponys','ponies','cavalrys','cavalries','cavaliers','cavs'].include?(args[i])
    traits.push('Roman') if ['roman','romans'].include?(args[i])
    traits.push('Servant') if ['servants','servant'].include?(args[i])
    traits.push('Sovereign') if ['sovereign','soveriegn','reign','riegn'].include?(args[i])
    traits.push('Threat to Humanity') if ['threattohumanity','threat','threatening','threat2humanity','threattohumans','threat2humans'].include?(args[i])
    traits.push('Weak to Enuma Elish') if ['weaktoenumaelish','weak2enumaelish','weaktoenuma','weak2enuma','weaktoelish','weak2elish','weak'].include?(args[i])
    traits.push('Wild Beast') if ['wildbeast','wild','beastattribute'].include?(args[i])
    avail.push('Event') if ['event','event','welfare','welfares'].include?(args[i])
    avail.push('Limited') if ['limited','limit','limits','seasonal','seasonals'].include?(args[i])
    avail.push('NonLimited') if ['nonlimited','nonlimit','notlimits','notlimited','notlimit','notlimits','nolimits','limitless','default','non'].include?(args[i])
    avail.push('Starter') if ['starter','starters','start','starting'].include?(args[i])
    avail.push('StoryLocked') if ['story','stories','storylocked','storylock','storylocks','locked','lock','locks'].include?(args[i])
    avail.push('StoryPromo') if ['storypromo','storypromos','storypromotion','promotion','promotions','storypromotions'].include?(args[i])
    avail.push('Unavailable') if ['unavailable','enemy','enemy-only','enemyonly','enemies'].include?(args[i])
    align1.push('Lawful') if ['lawful','law','lawfuls','laws'].include?(args[i])
    align1.push('Neutral') if ['neutral1'].include?(args[i])
    align1.push('Chaotic') if ['chaotic','chaos','chaotics','chaoses'].include?(args[i])
    align2.push('Good') if ['good','light'].include?(args[i])
    align2.push('Neutral') if ['neutral2'].include?(args[i])
    align2.push('Evil') if ['evil','dark','bad'].include?(args[i])
    align2.push('Bride') if ['bride','bridals','bridal','brides','wedding','weddings','waifu','waifus'].include?(args[i])
    align2.push('Summer') if ['summer','summers','swimsuit','swimsuits','beach','beaches','beachs'].include?(args[i])
    align2.push('Mad') if ['mad','angry','angery','insane','insanity','insanitys','insanities','insanes'].include?(args[i])
    align.push('Lawful Good') if ['lawfulgood','lawgood','lawfullight','lawlight','lawfulight','goodlawful','goodlaw','lightlawful','lightlaw','lawfulgoods','lawgoods','lawfullights','lawlights','lawfulights','goodlawfuls','goodlaws','lightlawfuls','lightlaws'].include?(args[i])
    align.push('Lawful Neutral') if ['lawfulneutral','lawneutral','neutrallawful','neutrallaw','neutralawful','neutralaw','lawfulneutrals','lawneutrals','neutrallawfuls','neutrallaws','neutralawfuls','neutralaws'].include?(args[i])
    align.push('Lawful Evil') if ['lawfulevil','lawfuldark','lawfulbad','lawevil','lawdark','lawbad','evillawful','evilawful','evillaw','evilaw','darklawful','darklaw','badlawful','badlaw','lawfulevils','lawfuldarks','lawfulbads','lawevils','lawdarks','lawbads','evillawfuls','evilawfuls','evillaws','evilaws','darklawfuls','darklaws','badlawfuls','badlaws'].include?(args[i])
    align.push('Lawful Bride') if ['lawfulbride','lawfulbridal','lawfulwedding','lawbride','lawbridal','lawwedding','lawedding','bridelawful','bridallawful','bridalawful','weddinglawful','bridelaw','bridallaw','bridalaw','weddinglaw','lawfulbrides','lawfulbridals','lawfulweddings','lawbrides','lawbridals','lawweddings','laweddings','bridelawfuls','bridallawfuls','bridalawfuls','weddinglawfuls','bridelaws','bridallaws','bridalaws','weddinglaws','lawfulwaifu','lawwaifu','lawaifu','waifulawful','waifulaw','lawfulwaifus','lawwaifus','lawaifus','waifulawfuls','waifulaws'].include?(args[i])
    align.push('Lawful Summer') if ['lawfulsummer','lawfulswimsuit','lawfulbeach','lawsummer','lawswimsuit','lawbeach','summerlawful','swimsuitlawful','beachlawful','summerlaw','swimsuitlaw','beachlaw','lawfulsummers','lawfulswimsuits','lawfulbeachs','lawfulbeaches','lawsummers','lawswimsuits','lawbeaches','lawbeachs','summerlawfuls','swimsuitlawfuls','beachlawfuls','summerlaws','swimsuitlaws','beachlaws'].include?(args[i])
    align.push('Lawful Mad') if ['lawfulmad','lawfulangry','lawfulangery','lawmad','lawangry','lawangery','madlawful','angrylawful','angerylawful','madlaw','angrylaw','angerylaw','lawfulmads','lawfulangrys','lawfulangries','lawfulangerys','lawfulangeries','lawmads','lawangrys','lawangries','lawangerys','lawangeries','madlawfuls','angrylawfuls','angerylawfuls','madlaws','angrylaws','angerylaws','lawfulinsane','lawfulinsanity','lawinsane','lawinsanity','lawfulinsanes','lawfulinsanitys','lawfulinsanities','lawinsanes','lawinsanitys','lawinsanities','insanelawful','insanitylawful','insanelaw','insanitylaw','insanelawfuls','insanitylawfuls','insanelaws','insanitylaws'].include?(args[i])
    align.push('Neutral Good') if ['neutralgood','neutrallight','neutralight','goodneutral','lightneutral','neutralgoods','neutrallights','neutralights','goodneutrals','lightneutrals'].include?(args[i])
    align.push('True Neutral') if ['neutralneutral','neutralsquared','trueneutral','neutraltrue','neutraltruth','neutralneutrals','neutralsquareds','trueneutrals','neutraltrues','neutraltruths'].include?(args[i])
    align.push('Neutral Evil') if ['nautralevil','neutraldark','neutralbad','evilneutral','darkneutral','badneutral','nautralevils','neutraldarks','neutralbads','evilneutrals','darkneutrals','badneutrals'].include?(args[i])
    align.push('Neutral Bride') if ['neutralbride','neutralbridal','neutralwedding','brideneutral','bridalneutral','weddingneutral','neutralbrides','neutralbridals','neutralweddings','brideneutrals','bridalneutrals','weddingneutrals','neutralwaifu','waifuneutral','neutralwaifus','waifuneutrals'].include?(args[i])
    align.push('Neutral Summer') if ['neutralsummer','neutralswimsuit','neutralbeach','summerneutral','swimsuitneutral','beachneutral','neutralsummers','neutralswimsuits','neutralbeachs','neutralbeaches','summerneutrals','swimsuitneutrals','beachneutrals'].include?(args[i])
    align.push('Neutral Mad') if ['neutralmad','neutralangry','neutralangery','madneutral','angryneutral','angerynautral','neutralmads','neutralangrys','neutralangries','neutralangerys','neutralangeries','madneutrals','angryneutrals','angerynautrals','neutralinsane','neutralinsanity','insaneneutral','insanityneutral','insaneutral','neutralinsanes','neutralinsanitys','neutralinsanities','insaneneutrals','insanityneutrals','insaneutrals'].include?(args[i])
    align.push('Chaotic Good') if ['chaoticgood','chaosgood','chaoticlight','chaoslight','goodchaotic','goodchaos','lightchaotic','lightchaos','chaoticgoods','chaosgoods','chaoticlights','chaoslights','goodchaotics','goodchaoses','lightchaotics','lightchaoses'].include?(args[i])
    align.push('Chaotic Neutral') if ['chaoticneutral','chaosneutral','neutralchaotic','neutralchaos','chaoticneutrals','chaosneutrals','neutralchaotices','neutralchaoses'].include?(args[i])
    align.push('Chaotic Evil') if ['chaoticevil','chaoticdark','chaoticbad','chaosevil','chaosdark','chaosbad','evilchaotic','darkchaotic','badchaotic','evilchaos','darkchaos','badchaos','chaoticevils','chaoticdarks','chaoticbads','chaosevils','chaosdarks','chaosbads','evilchaotics','darkchaotics','badchaotics','evilchaoses','darkchaoses','badchaoses'].include?(args[i])
    align.push('Chaotic Bride') if ['chaoticbride','chaoticbridal','chaoticwedding','chaoticwaifu','chaosbride','chaosbridal','chaoswedding','chaoswaifu','bridechaotic','bridalchaotic','weddingchaotic','waifuchaotic','bridechaos','bridalchaos','weddingchaos','waifuchaos','chaoticbrides','chaoticbridals','chaoticweddings','chaoticwaifus','chaosbrides','chaosbridals','chaosweddings','chaoswaifus','bridechaotics','bridalchaotics','weddingchaotics','waifuchaotics','bridechaoses','bridalchaoses','weddingchaoses','waifuchaoses'].include?(args[i])
    align.push('Chaotic Summer') if ['chaoticsummer','chaoticswimsuit','chaoticbeach','chaossummer','chaosummer','chaosbeach','summerchaotic','swimsuitchaotic','beachchaotic','beachaotic','summerchaos','swimsuitchaos','beachchaos','beachaos','chaoticsummers','chaoticswimsuits','chaoticbeachs','chaoticbeaches','chaossummers','chaosummers','chaosbeachs','chaosbeaches','summerchaotics','swimsuitchaotics','beachchaotics','beachaotics','summerchaoses','swimsuitchaoses','beachchaoses','beachaoses'].include?(args[i])
    align.push('Chaotic Mad') if ['chaoticmad','chaoticangry','chaoticangery','chaosmad','chaosangry','chaosangery','madchaotic','angrychaotic','angerychaotic','madchaos','angrychaos','angerychaos','chaoticmads','chaoticangrys','chaoticangries','chaoticangerys','chaoticangeries','chaosmads','chaosangrys','chaosangries','chaosangerys','chaosangeries','madchaotics','angrychaotics','angerychaotics','madchaoses','angrychaoses','angerychaoses','chaoticinsane','chaoticinsanity','chaosinsane','chaosinsanity','insanechaotic','insanitychaotic','insanechaos','insanitychaos','chaoticinsanes','chaoticinsanitys','chaoticinsanities','chaosinsanes','chaosinsanitys','chaosinsanities','insanechaotics','insanitychaotics','insanechaoses','insanitychaoses'].include?(args[i])
    align.push('None') if ['noalignment','nonealignment','none'].include?(args[i])
  end
  textra=''
  for i in 0...args.length
    if args[i]=='neutral'
      if i>0 && args[i-1]=='true'
      elsif (align1.length<=0 && align2.length<=0) || (align1.length>0 && align2.length>0)
        align.push('Chaotic Neutral')
        align.push('Lawful Neutral')
        align.push('Neutral Good')
        align.push('Neutral Evil')
        align.push('Neutral Bride')
        align.push('Neutral Summer')
        align.push('Neutral Mad')
        align.push('True Neutral')
        textra="#{textra}\n\nAll neutral alignments were added.  If you would like only the *True Neutral* alignment, please use the term \"TrueNeutral\" instead." if align1.length<=0 && align2.length<=0
      elsif align1.length<=0
        align1.push('Neutral')
      elsif align2.length<=0
        align2.push('Neutral')
      end
    end
  end
  if curves.include?('Semi S') && curves.include?('Reverse S') && !curves.include?('Semi Reverse S')
    curves.push('Semi Reverse S')
    x=[true,true]
    for i in 0...curves.length
      if curves[i]=='Semi S' && x[0]
        x[0]=false
        curves[i]=nil
      elsif curves[i]=='Reverse S' && x[1]
        x[1]=false
        curves[i]=nil
      end
    end
    curves.compact!
    textra="#{textra}\n\nThe searches for \"Semi S\" and \"Reverse S\" were combined into a single search for \"Semi Reverse S\".  If you would like to search for \"Semi S\" and \"Reverse S\", please do each search individually." if !curves.include?('Semi S') && !curves.include?('Reverse S')
  end
  clzz.uniq!
  curves.uniq!
  attributes.uniq!
  traits.uniq!
  avail.uniq!
  align1.uniq!
  align2.uniq!
  align.uniq!
  char=@servants.map{|q| q}.uniq
  search=[]
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2])}.uniq
    search.push("*Classes*: #{clzz.join(', ')}")
  end
  if curves.length>0
    char=char.reject{|q| !curves.include?(q[4])}.uniq
    search.push("*Growth curves*: #{curves.join(', ')}")
  end
  if attributes.length>0
    char=char.reject{|q| !attributes.include?(q[12])}.uniq
    search.push("*Attributes*: #{attributes.join(', ')}")
    textra="#{textra}\n\nThe search term \"Beast\" is being interpreted as a search for the Beast attribute.\nIf you meant the Beast class, please include the word \"BeastClass\" in your message instead.\nIf you meant the trait *Wild Beast*, please include the word \"Wild\" in your message instead." if attributes.include?('Beast') && !(clzz.include?('Beast') || traits.include?('Wild Beast'))
    textra="#{textra}\n\nThe search term \"Man\" is being interpreted as a search for the Man attribute.\nIf you meant the trait *Male*, please include the word \"Male\" in your message instead." if attributes.include?('Man') && !traits.include?('Male')
  end
  if traits.length>0
    search.push("*Traits*: #{traits.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for servants with any listed trait)" if traits.length>1
      char=char.reject{|q| !has_any?(traits,q[13])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for servants with all listed traits)" if traits.length>1
      textra="#{textra}\n\nTraits searching defaults to searching for servants with all listed traits.  To search for servants with any of the listed traits, perform the search again with the word \"any\" in your message." if traits.length>1
      for i in 0...traits.length
        char=char.reject{|q| !q[13].include?(traits[i])}.uniq
      end
    end
  end
  if avail.length>0
    char=char.reject{|q| !avail.include?(q[20])}.uniq
    search.push("*Availability*: #{avail.join(', ')}")
  end
  textra=textra[2,textra.length-2] if [textra[0,1],textra[0,2]].include?("\n")
  search.push("*Horizontal Alignment*: #{align1.join(', ')}") if align1.length>0
  search.push("*Vertical Alignment*: #{align2.join(', ')}") if align2.length>0
  search.push("*#{'Complete ' if align1.length>0 || align2.length>0}Alignment*: #{align.join(', ')}") if align.length>0
  if align1.length>0 || align2.length>0
    align1=['Lawful','Neutral','Chaotic'] if align1.length<=0
    align2=['Good','Neutral','Evil','Mad','Summer','Bride'] if align2.length<=0
    for i in 0...align1.length
      for j in 0...align2.length
        align.push("#{align1[i]} #{align2[j]}")
      end
    end
  end
  char=char.reject{|q| !has_any?(q[22].split(' / '),align)}.uniq if align.length>0
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.uniq
  if (char.length>50 || char.join("\n").length+search.join("\n").length+textra.length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  elsif @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length+textra.length>=1900
    str="__**Search**__\n#{search.join("\n")}#{"\n\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char,true) unless char.length<=0
    textra="#{textra}\n\n**No servants match your search**" if char.length<=0
    create_embed(event,"__**Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xED619A,"#{char.length} total",nil,flds)
  end
end

bot.command(:skill) do |event, *args|
  disp_skill_data(bot,event,args)
end

bot.command([:find,:list,:search]) do |event, *args|
  find_servants(event,args)
end

bot.command([:embeds,:embed]) do |event|
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
  disp_servant_skills(bot,event,args,true)
  if safe_to_spam?(event)
    disp_servant_traits(bot,event,args,true)
    disp_servant_np(bot,event,args,true)
    disp_servant_ce(bot,event,args,true,true)
    disp_servant_mats(bot,event,args,true)
  end
  return nil
end

bot.command([:stats,:stat]) do |event, *args|
  disp_servant_stats(bot,event,args)
  return nil
end

bot.command([:traits,:trait]) do |event, *args|
  name=args.join(' ')
  if find_servant_ex(name,event,true).length>0
    disp_servant_traits(bot,event,args)
  elsif find_enemy_ex(name,event,true).length>0
    disp_enemy_traits(bot,event,args)
  elsif find_servant_ex(name,event).length>0
    disp_servant_traits(bot,event,args)
  elsif find_enemy_ex(name,event).length>0
    disp_enemy_traits(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:art]) do |event, *args|
  disp_servant_art(bot,event,args)
  return nil
end

bot.command([:riyo,:Riyo]) do |event, *args|
  disp_servant_art(bot,event,args,true)
  return nil
end

bot.command([:np,:NP,:noble,:phantasm,:noblephantasm]) do |event, *args|
  disp_servant_np(bot,event,args)
  return nil
end

bot.command([:ce,:CE,:craft,:essance,:craftessance]) do |event, *args|
  name=args.join(' ')
  if find_ce_ex(name,event,true).length>0
    disp_ce_card(bot,event,args)
  elsif find_servant_ex(name,event,true).length>0
    disp_servant_ce(bot,event,args)
  elsif find_ce_ex(name,event).length>0
    disp_ce_card(bot,event,args)
  elsif find_servant_ex(name,event).length>0
    disp_servant_ce(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:command,:commandcode]) do |event, *args|
  disp_code_data(bot,event,args)
end

bot.command([:code]) do |event, *args|
  name=args.join(' ')
  if find_clothes_ex(name,event,true).length>0
    disp_clothing_data(bot,event,args)
  elsif find_code_ex(name,event,true).length>0
    disp_code_data(bot,event,args)
  elsif find_clothes_ex(name,event).length>0
    disp_clothing_data(bot,event,args)
  elsif find_code_ex(name,event).length>0
    disp_code_data(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:mysticcode,:mysticode,:mystic,:clothes,:clothing]) do |event, *args|
  disp_clothing_data(bot,event,args)
end

bot.command([:bond,:bondce,:bondCE]) do |event, *args|
  disp_servant_ce(bot,event,args,false,true)
  return nil
end

bot.command([:mats,:ascension,:enhancement,:enhance,:materials]) do |event, *args|
  disp_servant_mats(bot,event,args)
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
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,508792801455243266,508793141202255874,508793425664016395].include?(event.server.id)
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
    s="**Server:** #{event.server.name} (#{event.server.id}) - #{['Man','Sky','Earth','Star','Beast'][(event.server.id >> 22) % 4]} Attribute\n**Channel:** #{event.channel.name} (#{event.channel.id})"
  end
  f=event.message.text.split(' ')
  f="#{f[0]} "
  bot.user(167657750971547648).pm("#{s}\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{s3}:** #{first_sub(event.message.text,f,'',1)}")
  bot.user(239973891626237952).pm("#{s}\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{s3}:** #{first_sub(event.message.text,f,'',1)}")
  bot.channel(502288368777035777).send_message("#{s}\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{s3}:** #{first_sub(event.message.text,f,'',1)}")
  s3='Bug' if s3=='Bug Report'
  t=Time.now
  event << "Your #{s3.downcase} has been logged."
  return nil
end

bot.command(:invite) do |event, user|
  usr=event.user
  txt="You can invite me to your server with this link: <https://goo.gl/ox9CxB>\nTo look at my source code: <https://github.com/Rot8erConeX/LizBot/blob/master/LizBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/MarketingLiz.png"
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

bot.command([:shard,:attribute]) do |event, i|
  if i.to_i.to_s==i && i.to_i.is_a?(Integer) && @shardizard != 4
    srv=(bot.server(i.to_i) rescue nil)
    if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      event.respond "I am not in that server, but it would be assigned #{['Man','Sky','Earth','Star','Beast'][(i.to_i >> 22) % 4]} Attribute."
    else
      event.respond "#{srv.name} is assigned #{['Man','Sky','Earth','Star','Beast'][(i.to_i >> 22) % 4]} Attribute."
    end
    return nil
  end
  event.respond 'This is the debug mode, which is assigned the Beast Attribute.' if @shardizard==4
  event.respond 'PMs always are assigned the Man Attribute.' if event.server.nil?
  event.respond "This server is assigned #{['Man','Sky','Earth','Star','Beast'][(event.server.id >> 22) % 4]} Attribute." unless event.server.nil? || @shardizard==4
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
  return nil unless event.server.nil? || [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,508792801455243266,508793141202255874,508793425664016395].include?(event.server.id)
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
  k=bot.servers.values.reject{|q| [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,508792801455243266,508793141202255874,508793425664016395].include?(q.id)}.length
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
    event << "**There are #{longFormattedNumber(@prefix.map{|q| q.downcase}.reject{|q| q.include?('0') || q.include?('ii')}.uniq.length)} command prefixes**, but because I am faking case-insensitivity it's actually #{longFormattedNumber(@prefix.length)} prefixes."
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
  event << "**There are #{longFormattedNumber(@servants.length)} servants.**"
  event << "There are also #{longFormattedNumber(@enemies.length)} non-servant enemy types."
  event << ''
  event << "**There are #{longFormattedNumber(@skills.length)} skills.**"
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Skill'}.length)} active skills, split into #{longFormattedNumber(@skills.reject{|q| q[2]!='Skill'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Passive'}.length)} passive skills, split into #{longFormattedNumber(@skills.reject{|q| q[2]!='Passive'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Clothes'}.length)} clothing skills."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Noble'}.length)} Noble Phantasms."
  event << ''
  event << "**There are #{longFormattedNumber(@crafts.length)} Craft Essences.**"
  event << ''
  event << "There are #{longFormattedNumber(@clothes.length)} Mystic Codes."
  event << "There are #{longFormattedNumber(@codes.length)} Command Codes."
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
  if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,508792801455243266,508793141202255874,508793425664016395].include?(event.server.id) && @shardizard==4
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
  puts event.message.text
  args=event.message.text.downcase.split(' ')
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  name=args.join(' ')
  m=true
  m=false if event.user.bot_account?
  if !m
  elsif ['find','list','search'].include?(args[0].downcase)
    args.shift
    find_servants(event,args)
    m=false
  elsif ['servant','data','unit'].include?(args[0].downcase)
    args.shift
    disp_servant_stats(bot,event,args)
    disp_servant_skills(bot,event,args,true)
    if safe_to_spam?(event)
      disp_servant_traits(bot,event,args,true)
      disp_servant_np(bot,event,args,true)
      disp_servant_ce(bot,event,args,true,true)
      disp_servant_mats(bot,event,args,true)
    end
    m=false
  elsif ['stats','stat'].include?(args[0])
    args.shift
    disp_servant_stats(bot,event,args)
    m=false
  elsif ['skills'].include?(args[0])
    args.shift
    disp_servant_skills(bot,event,args)
    m=false
  elsif ['skill'].include?(args[0])
    args.shift
    disp_skill_sata(bot,event,args)
    m=false
  elsif ['traits','trait'].include?(args[0])
    args.shift
    disp_servant_traits(bot,event,args)
    m=false
  elsif ['np','noble','phantasm','noblephantasm'].include?(args[0])
    args.shift
    disp_servant_np(bot,event,args)
    m=false
  elsif ['bond','bondce'].include?(args[0])
    args.shift
    disp_servant_ce(bot,event,args)
    m=false
  elsif ['mats','ascension','enhancement','materials'].include?(args[0])
    args.shift
    disp_servant_mats(bot,event,args)
    m=false
  elsif ['command','commandcode'].include?(args[0])
    args.shift
    disp_code_data(bot,event,args)
    m=false
  elsif ['mysticcode','mysticode','mystic','clothing','clothes'].include?(args[0])
    args.shift
    disp_clothing_data(bot,event,args)
    m=false
  elsif ['code'].include?(args[0])
    args.shift
    if find_clothes_ex(args.join(' '),event,true).length>0
      disp_clothing_data(bot,event,args)
    elsif find_code_ex(args.join(' '),event,true).length>0
      disp_code_data(bot,event,args)
    elsif find_clothes_ex(args.join(' '),event).length>0
      disp_clothing_data(bot,event,args)
    elsif find_code_ex(args.join(' '),event).length>0
      disp_code_data(bot,event,args)
    else
      event.respond "No matches found."
    end
    m=false
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(args[0])
    args.shift
    disp_tiny_stats(bot,event,args)
    m=false
  elsif ['ce','craft','essance','craftessance'].include?(args[0])
    args.shift
    if find_ce_ex(args.join(' '),event,true).length>0
      disp_ce_card(bot,event,args)
    elsif find_servant_ex(args.join(' '),event,true).length>0
      disp_servant_ce(bot,event,args)
    elsif find_ce_ex(args.join(' '),event).length>0
      disp_ce_card(bot,event,args)
    elsif find_servant_ex(args.join(' '),event).length>0
      disp_servant_ce(bot,event,args)
    else
      event.respond "No matches found."
    end
    m=false
  end
  if m
    if find_ce_ex(name,event,true).length>0
      disp_ce_card(bot,event,args)
    elsif find_servant_ex(name,event,true).length>0
      disp_servant_stats(bot,event,args)
      disp_servant_skills(bot,event,args,true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,args,true)
        disp_servant_np(bot,event,args,true)
        disp_servant_ce(bot,event,args,true,true)
        disp_servant_mats(bot,event,args,true)
      end
    elsif find_skill_ex(name,event,true).length>0
      disp_skill_data(bot,event,args)
    elsif find_clothes_ex(s,event,true).length>0
      disp_clothing_data(bot,event,args)
    elsif find_code_ex(name,event,true).length>0
      disp_code_data(bot,event,args)
    elsif find_enemy_ex(name,event,true).length>0
      disp_enemy_traits(bot,event,args)
    elsif find_ce_ex(name,event).length>0
      disp_ce_card(bot,event,args)
    elsif find_servant_ex(name,event).length>0
      disp_servant_stats(bot,event,args)
      disp_servant_skills(bot,event,args,true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,args,true)
        disp_servant_np(bot,event,args,true)
        disp_servant_ce(bot,event,args,true,true)
        disp_servant_mats(bot,event,args,true)
      end
    elsif find_skill_ex(name,event).length>0
      disp_skill_data(bot,event,args)
    elsif find_clothes_ex(s,event).length>0
      disp_clothing_data(bot,event,args)
    elsif find_code_ex(name,event).length>0
      disp_code_data(bot,event,args)
    elsif find_enemy_ex(name,event).length>0
      disp_enemy_traits(bot,event,args)
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
    if find_ce_ex(s,event,true).length>0
      disp_ce_card(bot,event,s.split(' '))
    elsif find_servant_ex(s,event,true).length>0
      disp_servant_stats(bot,event,s.split(' '))
      disp_servant_skills(bot,event,s.split(' '),true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,s.split(' '),true)
        disp_servant_np(bot,event,s.split(' '),true)
        disp_servant_ce(bot,event,s.split(' '),true,true)
        disp_servant_mats(bot,event,s.split(' '),true)
      end
    elsif find_skill_ex(s,event,true).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_clothes_ex(s,event,true).length>0
      disp_clothing_data(bot,event,s.split(' '))
    elsif find_code_ex(s,event,true).length>0
      disp_code_data(bot,event,s.split(' '))
    elsif find_enemy_ex(s,event,true).length>0
      disp_enemy_traits(bot,event,s.split(' '))
    elsif find_ce_ex(s,event).length>0
      disp_ce_card(bot,event,s.split(' '))
    elsif find_servant_ex(s,event).length>0
      disp_servant_stats(bot,event,s.split(' '))
      disp_servant_skills(bot,event,s.split(' '),true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,s.split(' '),true)
        disp_servant_np(bot,event,s.split(' '),true)
        disp_servant_ce(bot,event,s.split(' '),true,true)
        disp_servant_mats(bot,event,s.split(' '),true)
      end
    elsif find_skill_ex(s,event).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_clothes_ex(s,event).length>0
      disp_clothing_data(bot,event,s.split(' '))
    elsif find_code_ex(s,event).length>0
      disp_code_data(bot,event,s.split(' '))
    elsif find_enemy_ex(s,event).length>0
      disp_enemy_traits(bot,event,s.split(' '))
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
