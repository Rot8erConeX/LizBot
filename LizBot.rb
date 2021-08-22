Shardizard=ARGV.first.to_i # taking a single variable from the command prompt to get the shard value
system('color 0F')
Shards = 4                 # total number of shards

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0
require_relative 'rot8er_functs'       # functions I use commonly in bots
$location="C:/Users/#{@mash}/Desktop/"

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

# All the possible command prefixes
@prefixes={}
load "#{$location}devkit/FGOPrefix.rb"

prefix_proc = proc do |message|
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('liz!')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('liz?')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('iiz!')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('iiz?')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('fgo!')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('fgo?')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('fg0!')
  next pseudocase(message.text[4..-1]) if message.text.downcase.start_with?('fg0?')
  next pseudocase(message.text[5..-1]) if message.text.downcase.start_with?('fate!')
  next pseudocase(message.text[5..-1]) if message.text.downcase.start_with?('fate?')
  load "#{$location}devkit/FGOPrefix.rb"
  next if message.channel.server.nil? || @prefixes[message.channel.server.id].nil? || @prefixes[message.channel.server.id].length<=0
  prefix = @prefixes[message.channel.server.id]
  # We use [prefix.size..-1] so we can handle prefixes of any length
  next pseudocase(message.text[prefix.size..-1]) if message.text.downcase.start_with?(prefix.downcase)
end

# The bot's token is basically their password, so is censored for obvious reasons
if Shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: 431895561193390090, prefix: prefix_proc
elsif Shardizard>4
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: (Shardizard-1), num_shards: Shards, client_id: 502288364838322176, prefix: prefix_proc
else
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: Shardizard, num_shards: 4, client_id: 502288364838322176, prefix: prefix_proc
end
bot.gateway.check_heartbeat_acks = false

def shard_data(mode=0,ignoredebug=false,s=nil)
  s=Shards*1 if s.nil?
  full=['<:class_lancer_gold:523838511485419522> Gold Lancer','<:class_saber_gold:523838273479507989> Gold Saber',
        '<:class_archer_gold:523838461195714576> Gold Archer','<:class_rider_gold:523838542577664012> Gold Rider','<:Extra_y:526556105388720130> Debug',
        '<:class_caster_gold:523838570893672473> Gold Caster','<:class_assassin_gold:523838617693716480> Gold Assassin',
        '<:class_berserker_gold:523838648370724897> Gold Berserker','<:class_shielder_gold:523838231913955348> Gold Shielder',
        '<:class_avenger_gold:523838724753063956> Gold Avenger','<:class_foreigner_gold:523838834316935172> Gold Foreigner',
        '<:class_ruler_gold:523838688648495114> Gold Ruler','<:class_mooncancer_gold:523838798019166209> Gold Moon Cancer',
        '<:class_alterego_gold:523838749180821515> Gold Alter Ego','<:class_extra_gold:523838907591294977> Gold Extra',
        '<:class_unknown_gold:523838979825467392> Gold Unknown','<:class_saber_silver:523838265002950668> Silver Saber',
        '<:class_archer_silver:523838373698207760> Silver Archer','<:class_lancer_silver:523838477566083072> Silver Lancer',
        '<:class_rider_silver:523838533589532693> Silver Rider','<:class_caster_silver:523838556226060298> Silver Caster',
        '<:class_assassin_silver:523838605937082368> Silver Assassin','<:class_berserker_silver:523838636740050955> Silver Berserker',
        '<:class_shielder_silver:523838223202385940> Silver Shielder','<:class_avenger_silver:523838717799170058> Silver Avenger',
        '<:class_foreigner_silver:523838823747158018> Silver Foreigner','<:class_ruler_silver:523838680603820042> Silver Ruler',
        '<:class_mooncancer_silver:523838771964149770> Silver Moon Cancer','<:class_alterego_silver:523838741090140170> Silver Alter Ego',
        '<:class_extra_silver:523838899487768577> Silver Extra','<:class_unknown_silver:523838967058006027> Silver Unknown',
        '<:class_saber_bronze:523838251035787285> Bronze Saber','<:class_archer_bronze:523838364408086558> Bronze Archer',
        '<:class_lancer_bronze:523838470888882199> Bronze Lancer','<:class_rider_bronze:523838525423091713> Bronze Rider',
        '<:class_caster_bronze:523838549645197316> Bronze Caster','<:class_assassin_bronze:523838597632229386> Bronze Assassin',
        '<:class_berserker_bronze:523838628095590400> Bronze Berserker','<:class_shielder_bronze:523948997182750720> Bronze Shielder',
        '<:class_avenger_bronze:523948998088720405> Bronze Avenger','<:class_foreigner_bronze:523948997228888067> Bronze Foreigner',
        '<:class_ruler_bronze:523948997245927434> Bronze Ruler','<:class_mooncancer_bronze:523838763135270922> Bronze Moon Cancer',
        '<:class_alterego_bronze:523948997174493185> Bronze Alter Ego','<:class_extra_bronze:523838879854493709> Bronze Extra',
        '<:class_unknown_bronze:523948997430214666> Bronze Unknown']
  part=['<:class_saber_gold:523838273479507989> Gold Saber','<:class_archer_gold:523838461195714576> Gold Archer',
        '<:class_lancer_gold:523838511485419522> Gold Lancer','<:class_rider_gold:523838542577664012> Gold Rider',
        '<:class_caster_gold:523838570893672473> Gold Caster','<:class_assassin_gold:523838617693716480> Gold Assassin',
        '<:class_berserker_gold:523838648370724897> Gold Berserker','<:class_shielder_gold:523838231913955348> Gold Shielder',
        '<:class_avenger_gold:523838724753063956> Gold Avenger','<:class_foreigner_gold:523838834316935172> Gold Foreigner',
        '<:class_ruler_gold:523838688648495114> Gold Ruler','<:class_mooncancer_gold:523838798019166209> Gold Moon Cancer',
        '<:class_alterego_gold:523838749180821515> Gold Alter Ego','<:class_extra_gold:523838907591294977> Gold Extra',
        '<:class_unknown_gold:523838979825467392> Gold Unknown','<:class_saber_silver:523838265002950668> Silver Saber',
        '<:class_archer_silver:523838373698207760> Silver Archer','<:class_lancer_silver:523838477566083072> Silver Lancer',
        '<:class_rider_silver:523838533589532693> Silver Rider','<:class_caster_silver:523838556226060298> Silver Caster',
        '<:class_assassin_silver:523838605937082368> Silver Assassin','<:class_berserker_silver:523838636740050955> Silver Berserker',
        '<:class_shielder_silver:523838223202385940> Silver Shielder','<:class_avenger_silver:523838717799170058> Silver Avenger',
        '<:class_foreigner_silver:523838823747158018> Silver Foreigner','<:class_ruler_silver:523838680603820042> Silver Ruler',
        '<:class_mooncancer_silver:523838771964149770> Silver Moon Cancer','<:class_alterego_silver:523838741090140170> Silver Alter Ego',
        '<:class_extra_silver:523838899487768577> Silver Extra','<:class_unknown_silver:523838967058006027> Silver Unknown',
        '<:class_saber_bronze:523838251035787285> Bronze Saber','<:class_archer_bronze:523838364408086558> Bronze Archer',
        '<:class_lancer_bronze:523838470888882199> Bronze Lancer','<:class_rider_bronze:523838525423091713> Bronze Rider',
        '<:class_caster_bronze:523838549645197316> Bronze Caster','<:class_assassin_bronze:523838597632229386> Bronze Assassin',
        '<:class_berserker_bronze:523838628095590400> Bronze Berserker','<:class_shielder_bronze:523948997182750720> Bronze Shielder',
        '<:class_avenger_bronze:523948998088720405> Bronze Avenger','<:class_foreigner_bronze:523948997228888067> Bronze Foreigner',
        '<:class_ruler_bronze:523948997245927434> Bronze Ruler','<:class_mooncancer_bronze:523838763135270922> Bronze Moon Cancer',
        '<:class_alterego_bronze:523948997174493185> Bronze Alter Ego','<:class_extra_bronze:523838879854493709> Bronze Extra',
        '<:class_unknown_bronze:523948997430214666> Bronze Unknown']
  if mode==0 # shard icons + names
    k=['<:Buster_y:526556105422274580> Buster','<:Quick_y:526556106986618880> Quick','<:Arts_y:526556105489252352> Arts','','<:Extra_y:526556105388720130> Extra'] if s<=3
    k=['Man','Sky','Earth','Star','Beast'] if s==4
    k=['Man','Sky','Earth','Star','<:Extra_y:526556105388720130> Extra','Beast'] if s==5
    k=['<:class_lancer_gold:523838511485419522> Lancer','<:class_saber_gold:523838273479507989> Saber','<:class_archer_gold:523838461195714576> Archer','<:class_rider_gold:523838542577664012> Rider','<:class_unknown_gold:523838979825467392> Unknown','<:class_caster_gold:523838570893672473> Caster','<:class_assassin_gold:523838617693716480> Assassin','<:class_berserker_gold:523838648370724897> Berserker','<:class_shielder_gold:523838231913955348> Shielder','<:class_avenger_gold:523838724753063956> Avenger','<:class_foreigner_gold:523838834316935172> Foreigner','<:class_ruler_gold:523838688648495114> Ruler','<:class_mooncancer_gold:523838798019166209> Moon Cancer','<:class_alterego_gold:523838749180821515> Alter Ego','<:class_extra_gold:523838907591294977> Extra'][0,s+1] if s>5 && s<15
    k=['<:class_lancer_gold:523838511485419522> Lancer','<:class_saber_gold:523838273479507989> Saber','<:class_archer_gold:523838461195714576> Archer','<:class_rider_gold:523838542577664012> Rider','<:Extra_y:526556105388720130> Debug','<:class_caster_gold:523838570893672473> Caster','<:class_assassin_gold:523838617693716480> Assassin','<:class_berserker_gold:523838648370724897> Berserker','<:class_shielder_gold:523838231913955348> Shielder','<:class_avenger_gold:523838724753063956> Avenger','<:class_foreigner_gold:523838834316935172> Foreigner','<:class_ruler_gold:523838688648495114> Ruler','<:class_mooncancer_gold:523838798019166209> Moon Cancer','<:class_alterego_gold:523838749180821515> Alter Ego','<:class_extra_gold:523838907591294977> Extra','<:class_unknown_gold:523838979825467392> Unknown'][0,s+1] if s==15
    k=full.map{|q| q} if s>15
    if s>full.length-1
      k2=part.map{|q| q}
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q} #{i}"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==1 # shard icons without names
    k=['<:Buster_y:526556105422274580>','<:Quick_y:526556106986618880>','<:Arts_y:526556105489252352>','','<:Extra_y:526556105388720130>'] if s<=3
    k=['Man','Sky','Earth','Star','Beast'] if s==4
    k=['Man','Sky','Earth','Star','<:Extra_y:526556105388720130>','Beast'] if s==5
    k=['<:class_lancer_gold:523838511485419522>','<:class_saber_gold:523838273479507989>','<:class_archer_gold:523838461195714576>','<:class_rider_gold:523838542577664012>','<:class_unknown_gold:523838979825467392>','<:class_caster_gold:523838570893672473>','<:class_assassin_gold:523838617693716480>','<:class_berserker_gold:523838648370724897>','<:class_shielder_gold:523838231913955348>','<:class_avenger_gold:523838724753063956>','<:class_foreigner_gold:523838834316935172>','<:class_ruler_gold:523838688648495114>','<:class_mooncancer_gold:523838798019166209>','<:class_alterego_gold:523838749180821515>','<:class_extra_gold:523838907591294977>'][0,s+1] if s>5 && s<15
    k=['<:class_lancer_gold:523838511485419522>','<:class_saber_gold:523838273479507989>','<:class_archer_gold:523838461195714576>','<:class_rider_gold:523838542577664012>','<:Extra_y:526556105388720130>','<:class_caster_gold:523838570893672473>','<:class_assassin_gold:523838617693716480>','<:class_berserker_gold:523838648370724897>','<:class_shielder_gold:523838231913955348>','<:class_avenger_gold:523838724753063956>','<:class_foreigner_gold:523838834316935172>','<:class_ruler_gold:523838688648495114>','<:class_mooncancer_gold:523838798019166209>','<:class_alterego_gold:523838749180821515>','<:class_extra_gold:523838907591294977>','<:class_unknown_gold:523838979825467392>'][0,s+1] if s==15
    k=full.map{|q| q.split(' ')[0]} if s>15
    if s>full.length-1
      k2=part.map{|q| q.split(' ')[0]}
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q}#{i}"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==2 # shard names without icons
    k=['Buster','Quick','Arts','','Extra'] if s<=3
    k=['Man','Sky','Earth','Star','Beast'] if s==4
    k=['Man','Sky','Earth','Star','Extra','Beast'] if s==5
    k=['Lancer','Saber','Archer','Rider','Unknown','Caster','Assassin','Berserker','Shielder','Avenger','Foreigner','Ruler','Moon Cancer','Alter Ego','Extra'][0,s+1] if s>5 && s<15
    k=['Lancer','Saber','Archer','Rider','Debug','Caster','Assassin','Berserker','Shielder','Avenger','Foreigner','Ruler','Moon Cancer','Alter Ego','Extra','Unknown'][0,s+1] if s==15
    k=full.map{|q| q.split(' ')[1,q.split(' ').length-1].join(' ')} if s>15
    if s>full.length-1
      k2=part.map{|q| q.split(' ')[1,q.split(' ').length-1].join(' ')}
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q} #{i}"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==3 # bright command prompt text color
    k=['C','A','9','_','F'] if s<=3
    k=['C','B','A','E','7'] if s==4
    k=['C','B','A','E','F','7'] if s==5
    return 'F'*(s+1) if s>5
  elsif mode==4 # dark command prompt text color
    k=['4','2','1','_','0'] if s<=3
    k=['4','1','2','6','0'] if s==4
    k=['4','1','2','6','0','0'] if s==5
    return '0'*(s+1) if s>5
  end
  if ignoredebug
    k[4]=nil
    k.compact!
  end
  return k.join('') if mode>2
  return k
end

system("color 0#{shard_data(3)[Shardizard,1]}")
system("title loading #{shard_data(2)[Shardizard]} LizBot")

$servants=[]
$skills=[]; $nobles=[]
$crafts=[]
$codes=[]
$mats=[]
$clothes=[]
$aliases=[]
$dev_units=[]
$donor_units=[]; $donor_triggers=[]
$support_lineups=[]

$feh_units=[]
$dl_adventurers=[]
$dl_dragons=[]
$dl_wyrmprints=[]
$dl_npcs=[]

$spam_channels=[[],[]]
$server_data=[]
$ignored=[]
$embedless=[]
$avvie_info=['Liz','*Fate/Grand Order*','N/A']
$last_multi_reload=[0,0,0]

# primary entities

class FGOServant
  attr_accessor :id
  attr_accessor :name
  attr_accessor :artist
  attr_accessor :voice_jp
  attr_accessor :clzz
  attr_accessor :rarity
  attr_accessor :grow_curve
  attr_accessor :max_level
  attr_accessor :hp,:atk
  attr_accessor :np_gain,:hit_count,:crit_star
  attr_accessor :death_rate
  attr_accessor :attribute
  attr_accessor :traits,:gender
  attr_accessor :actives,:passives,:np,:appends
  attr_accessor :deck
  attr_accessor :ascension_mats,:skill_mats
  attr_accessor :availability
  attr_accessor :team_cost
  attr_accessor :alignment
  attr_accessor :bond_ce,:valentines_ce
  attr_accessor :alts
  attr_accessor :costumes
  attr_accessor :owner,:nationality
  attr_accessor :fixed_ascension_mats,:fixed_costume_mats,:fixed_skill_mats
  attr_accessor :sort_data
  
  def initialize(val)
    @id=val.to_f
    @id=val.to_i unless val.to_f<2 || val.to_i==81
    @gender='~~Genderless~~'
  end
  
  def name=(val); @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def artist=(val); @artist=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def voice_jp=(val); @voice_jp=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def clzz=(val); @clzz=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def rarity=(val); @rarity=val.to_i; end
  def grow_curve=(val); @grow_curve=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def max_level=(val); @max_level=val.to_i; end
  def hp=(val); @hp=val.split(', ').map{|q| q.to_i}; end
  def atk=(val); @atk=val.split(', ').map{|q| q.to_i}; end
  def hit_count=(val); @hit_count=val.split(', ').map{|q| q.to_i}; end
  def death_rate=(val); @death_rate=val.to_f; end
  def passives=(val); @passives=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', '); end
  def np=(val); @np=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def deck=(val); @deck=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def ascension_mats=(val); @ascension_mats=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split('; ').map{|q| q.split(', ')}; end
  def skill_mats=(val); @skill_mats=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split('; ').map{|q| q.split(', ')}; end
  def availability=(val); @availability=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', '); end
  def team_cost=(val); @team_cost=val.to_i; end
  def alignment=(val); @alignment=val.gsub('┬á','').gsub('ΓÇï',''); end
  def bond_ce=(val); @bond_ce=val.to_i; end
  def valentines_ce=(val); @valentines_ce=val.split(', ').map{|q| q.to_i}; end
  def alts=(val); @alts=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', '); end
  def costumes=(val); @costumes=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(';; '); end
  def sort_data=(val); @sort_data=val; end
  def base_servant; return self; end
  def objt; return 'Servant'; end
  def objt2; return 'Servant'; end
  
  def tags; return @traits; end
  def tags=(val); @traits=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', '); end
  
  def tid
    return @id.to_f if @id.to_i<2
    return @id.to_i
  end
  
  def actives=(val)
    val=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split('; ').map{|q| q.split(', ')}
    @actives=val[0,3]
    @appends=val[3,val.length-3] if val.length>3
  end
  
  def np_gain=(val)
    @np_gain=val.split(', ').map{|q| q.to_f}
    @np_gain[3]=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', ')[3] if @np_gain.length>2
  end
  
  def crit_star=(val)
    @crit_star=val.split(', ')
    @crit_star[0]=@crit_star[0].to_i
    @crit_star[1]=@crit_star[1].to_f
  end
  
  def attribute=(val)
    @attribute=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
    @traits.push('Earth or Sky') if ['Sky','Earth'].include?(@attribute) && !val.include?('Earth or Sky') && !@traits.nil?
  end
  
  def traits=(val)
    val=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', ')
    @gender='Male' if val.include?('Male')
    @gender='Female' if val.include?('Female')
    val.push('Earth or Sky') if ['Sky','Earth'].include?(@attribute) && !val.include?('Earth or Sky')
    @traits=val.reject{|q| ['Male','Female'].include?(q)}
  end
  
  def disp_color(chain=0,mode=0)
    x=[237,97,154]
    x=[33,188,44] if @deck[6,1]=='Q'
    x=[11,77,223] if @deck[6,1]=='A'
    x=[254,33,22] if @deck[6,1]=='B'
    m=[]
    m.push([33,188,44]) if @deck[1,1]=='Q'
    m.push([33,188,44]) if @deck[1,2]=='QQ'
    m.push([11,77,223]) if @deck.include?('AA')
    m.push([11,77,223]) if @deck.include?('AAA')
    m.push([254,33,22]) if @deck[3,1]=='B'
    m.push([254,33,22]) if @deck[2,2]=='BB'
    mq=m.clone; mq.push([33,188,44]); mq.push([33,188,44]); mq.push([33,188,44])
    ma=m.clone; ma.push([11,77,223]); ma.push([11,77,223]); ma.push([11,77,223])
    mb=m.clone; mb.push([254,33,22]); mb.push([254,33,22]); mb.push([254,33,22])
    mq=avg_color(mq); ma=avg_color(ma); mb=avg_color(mb)
    m.push(x); m.push(x)
    if @deck.include?('[') # servants whose NP type varies based on skill have specific color mechanics
      m.push([33,188,44]) if @deck.split('[')[1].include?('Q') && @deck[6,1]!='Q'
      m.push([11,77,223]) if @deck.split('[')[1].include?('A') && @deck[6,1]!='A'
      m.push([254,33,22]) if @deck.split('[')[1].include?('B') && @deck[6,1]!='B'
      m.push([33,188,44]) if @deck[1,1]=='Q'
      m.push([33,188,44]) if @deck[1,2]=='QQ'
      m.push([11,77,223]) if @deck.include?('AA')
      m.push([11,77,223]) if @deck.include?('AAA')
      m.push([254,33,22]) if @deck[3,1]=='B'
      m.push([254,33,22]) if @deck[2,2]=='BB'
      m.push([33,188,44]) if @deck.split('[')[1].include?('Q') && @deck[6,1]!='Q'
      m.push([11,77,223]) if @deck.split('[')[1].include?('A') && @deck[6,1]!='A'
      m.push([254,33,22]) if @deck.split('[')[1].include?('B') && @deck[6,1]!='B'
      m.push([0,0,0])
    else
      m.push(x)
    end
    f=[]
    f.push(avg_color(m))
    if @deck.include?('[')
      f.push(mq) if @deck[6,1]=='Q'
      f.push(ma) if @deck[6,1]=='A'
      f.push(mb) if @deck[6,1]=='B'
      f.push(mq) if @deck.split('[')[1].include?('Q')
      f.push(ma) if @deck.split('[')[1].include?('A')
      f.push(mb) if @deck.split('[')[1].include?('B')
    end
    # Special colors
    xcolor=f[chain]
    xcolor=f[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
  
  def thumbnail(event,art=0)
    smoleresh=false
    smoleresh=true if event.user.id==167657750971547648
    smoleresh=true if [163952551237124097,243525860232003595].include?(event.user.id) && rand(5)==0
    smoleresh=true if rand(500)==0
    return "https://media.discordapp.net/attachments/397786370367553538/627221736261419028/image0.jpg" if @id==196 && smoleresh
    oart=art*1
    if art==0
      art=1
      art=2 if event.user.id==167657750971547648 && @id==74
      art=4 if event.user.id==78649866577780736 && @id==127
    end
    art=6 if @id==1.2
    dispnum="#{'0' if @id<100}#{'0' if @id<10}#{@id.to_i}#{art}"
    dispnum="#{'0' if @id<100}#{'0' if @id<10}#{@id.to_i}2" if @id==74 && oart=0 && rand(100)<5
    dispnum="001#{art}" if @id<2
    dispnum="1001#{art}" if @id==81.1
    return "https://github.com/Rot8erConeX/LizBot/blob/master/Emotes/10014.png?raw=true" if dispnum=='10014'
    unless art<=1
      m=false
      IO.copy_stream(open("http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"), "#{$location}devkit/FGOTemp#{Shardizard}.png") rescue m=true
      return self.thumbnail(event,art-1) if File.size("#{$location}devkit/FGOTemp#{Shardizard}.png")<=10 || m
    end
    return "http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
  end
  
  def superclass(bot,event,mode=0)
    clsmoji=''
    color='gold'
    color='silver' if @rarity<4
    color='bronze' if @rarity<3
    color='black' if @rarity<1
    if @id.to_i==81 && mode%4<2
      data_load()
      srv=$servants.map{|q| q}
      k2=srv[srv.find_index{|q| q.id==81.0}]
      k3=srv[srv.find_index{|q| q.id==81.1}]
      moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k2.clzz.downcase.gsub(' ','')}_#{color}"}
      moji2=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k3.clzz.downcase.gsub(' ','')}_#{color}"}
      unless moji.length>0 || moji2.length>0
        moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_unknown_#{color}"}
        if moji.length>0
          clsmoji=moji[0].mention
        else
          clsmoji='<:class_unknown_blue:523948997229019136>'
        end
      end
      str="**Class:** #{moji[0].mention if moji.length>0 && mode%2==1}*#{k2.clzz}*"
      str="#{str} \u2192 *#{moji2[0].mention if moji2.length>0 && mode%2==1}#{k3.clzz}*" unless k2.clzz==k3.clzz
      str="#{str}\n**Attribute:** *#{k2.attribute}*"
      str="#{str} \u2192 *#{k3.attribute}*" unless k2.attribute==k3.attribute
      str="#{str}\n**Alignment:** *#{k2.alignment}*"
      str="#{str} \u2192 *#{k3.alignment}*" unless k2.alignment==k3.alignment
      return str
    elsif mode%2==1
      moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{@clzz.downcase.gsub(' ','')}_#{color}"}
      if moji.length>0
        clsmoji=moji[0].mention
      else
        moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_unknown_#{color}"}
        if moji.length>0
          clsmoji=moji[0].mention
        else
          clsmoji='<:class_unknown_blue:523948997229019136>'
        end
      end
    end
    return "**Class:** #{clsmoji}*#{@clzz}*\n**Attribute:** *#{@attribute}*\n**Alignment:** *#{@alignment}*"
  end
  
  def rarity_colors; return ['black','bronze','silver','gold']; end
  
  def emoji(bot,event,mode=0,clrshift=0)
    color=3
    color=2 if @rarity<4
    color=1 if @rarity<3
    color=0 if @rarity<1
    color+=clrshift
    color=[color,self.rarity_colors.length].min
    color=self.rarity_colors[color]
    srvr=523821178670940170
    srvr=691616574393811004 if ['red','pink'].include?(color) || ['Pretender'].include?(@clzz)
    moji=bot.server(srvr).emoji.values.reject{|q| q.name.downcase != "class_#{@clzz.downcase.gsub(' ','')}_#{color}"}
    if moji.length>0
      clsmoji=moji[0].mention
    else
      moji=bot.server(srvr).emoji.values.reject{|q| q.name.downcase != "class_unknown_#{color}"}
      if moji.length>0
        clsmoji=moji[0].mention
      else
        clsmoji='<:class_unknown_blue:523948997229019136>'
      end
    end
    if @id.to_i==81 && mode%8<4
      data_load()
      srv=$servants.map{|q| q}
      k2=srv[srv.find_index{|q| q.id==81.0}]
      k3=srv[srv.find_index{|q| q.id==81.1}]
      moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k2.clzz.downcase.gsub(' ','')}_#{color}"}
      moji2=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k3.clzz.downcase.gsub(' ','')}_#{color}"}
      if moji.length>0
        clsmoji="#{moji[0].mention}#{moji2[0].mention unless moji2.length<=0 || moji[0]==moji2[0]}"
      elsif moji2.length>0
        clsmoji=moji2[0].mention
      else
        moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_unknown_#{color}"}
        if moji.length>0
          clsmoji=moji[0].mention
        else
          clsmoji='<:class_unknown_blue:523948997229019136>'
        end
      end
    end
    clsmoji='<:class_beast_gold:562413138356731905>' if @clzz=='Beast'
    if @traits.include?('FEH Servant')
      clr='Colorless'
      clr='Green' if @deck[6,1]=='Q'
      clr='Blue' if @deck[6,1]=='A'
      clr='Red' if @deck[6,1]=='B'
      clr='Red' if @clzz=='Saber'
      clr='Blue' if @clzz=='Lancer'
      clr='Green' if @clzz=='Berserker'
      wpn='Unknown'
      wpn='Blade' if ['Saber','Lancer','Berserker'].include?(@clzz)
      wpn='Bow' if @clzz=='Archer'
      wpn='Beast' if @clzz=='Rider'
      wpn='Staff' if @clzz=='Caster'
      wpn='Dagger' if @clzz=='Assassin'
      wpn='Tome' if @clzz=='Alter Ego'
      wpn='Dragon' if @clzz=='Foreigner'
      moji=bot.server(443172595580534784).emoji.values.reject{|q| q.name != "#{clr}_#{wpn}"}
      clsmoji="#{['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][@rarity] unless mode%4>1}#{moji[0].mention unless moji.length<=0}"
    elsif @traits.include?('DL Servant')
      clr='Staff'
      clr='Sword' if @clzz=='Saber'
      clr='Lance' if @clzz=='Lancer'
      clr='Axe' if @clzz=='Berserker'
      clr='Bow' if @clzz=='Archer'
      clr='Rider' if @clzz=='Rider'
      clr='Wand' if @clzz=='Caster'
      clr='Dagger' if @clzz=='Assassin'
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{clr}"}
      clsmoji="#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][@rarity] unless mode%4>1}#{moji[0].mention unless moji.length<=0}"
    end
    return clsmoji if mode%2==1
    deckmoji=''
    m=@deck[0,5]
    if m.include?('QQQ')
      deckmoji="#{deckmoji}<:Quick_x3:523975575866572800>"
    elsif m.include?('QQ')
      deckmoji="#{deckmoji}<:Quick_x2:523975575933812746>"
    else
      deckmoji="#{deckmoji}<:Quick_x:523975575329701902>"
    end
    if m.include?('AAA')
      deckmoji="#{deckmoji}<:Arts_x3:523975575656857611>"
    elsif m.include?('AA')
      deckmoji="#{deckmoji}<:Arts_x2:523975575849926665>"
    else
      deckmoji="#{deckmoji}<:Arts_x:523975575552000000>"
    end
    if m.include?('BBB')
      deckmoji="#{deckmoji}<:Buster_x3:523975575648469020>"
    elsif m.include?('BB')
      deckmoji="#{deckmoji}<:Buster_x2:523975576294260737>"
    else
      deckmoji="#{deckmoji}<:Buster_x:523975575359193089>"
    end
    semoji=''
    semoji='<:Great_Badge_Golden:443704781068959744>' if @traits.include?('FEH Servant')
    semoji='<:Tribe_Dragon:549947361745567754>' if @traits.include?('DL Servant')
    npmoji=@deck[6,1].gsub('Q','<:Quick_xNP:523979766731243527>').gsub('A','<:Arts_xNP:523979767016325121>').gsub('B','<:Buster_xNP:523979766911598632>')
    npmoji='' if @traits.include?('FEH Servant')
    return "#{clsmoji}#{deckmoji}#{npmoji}#{semoji}"
  end
  
  def rarity_row
    str="<:fgo_icon_rarity:523858991571533825>"*@rarity
    if @traits.include?('FEH Servant')
      str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][@rarity]*@rarity
    elsif @traits.include?('DL Servant')
      str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][@rarity]*@rarity
    end
    str="\u200B#{str}\u200B"
    str="**0-star**" if @rarity==0
    return str
  end
  
  def stat_emotes
    return ['<:FEHQuick:574760823340400665>','<:FEHArts:574760822149218304>','<:FEHBuster:574760822136635402>','<:Heroic_Grail:574798333898653696>','<:Aether_Stone:510776805746278421>','<:Refining_Stone:453618312165720086>','<:Heavenly_Dew:510776806396395530>','<:Divine_Dew:453618312434417691>','<:FEHQuick:574760823340400665>','<:FEHArts:574760822149218304>','<:FEHBuster:574760822136635402>','<:FEHExtra:574760822191161384>','<:FEH_NP:574760823403315200>','<:Godly_Grail:612717339611496450>'] if @traits.include?('FEH Servant')
    return ['<:DLQuick:575062116172693559>','<:DLArts:575064722551078922>','<:Type_Attack:532107867520630784>','<:holy_grail:523842742992764940>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Energy:534451856286679040>','<:Energize:559629242137051155>','<:DLQuick:575062116172693559>','<:DLArts:575064722551078922>','<:Type_Attack:532107867520630784>','<:DLExtra:575084966162202644>','<:DL_NP:575084966245957647>','<:Holier_Grail:612717994769907723>'] if @traits.include?('DL Servant')
    return ['<:quick:523854796692783105>','<:arts:523854803013730316>','<:buster:523854810286391296>','<:holy_grail:523842742992764940>','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Fou:544138629694619648>','<:GoldenFou:544138629832769536>','<:Quick_y:526556106986618880>','<:Arts_y:526556105489252352>','<:Buster_y:526556105422274580>','<:Extra_y:526556105388720130>','<:NP:523858635843960833>','<:Holier_Grail:612717994769907723>']
  end
  
  def ce_display
    data_load(['craft'])
    c=$crafts.find_index{|q| q.id==@bond_ce}
    unless c.nil?
      c=$crafts[c]
      return "**Bond CE:** #{c.name} [CE-##{c.id}]"
    end
    return "**Bond CE:** ~~Unknown~~" if @id<2
    return '~~No Bond CE~~'
  end
  
  def disp_stats(dispfou=0,effatk=false,jhmod=false)
    h=@hp.map{|q| q+dispfou}
    a=@atk.map{|q| q+dispfou}
    if effatk
      if jhmod && @id.to_i==81 # used by Jekyll & Hyde
        a=a.map{|q| (q*11)/10}
      elsif ['Caster','Assassin'].include?(@clzz)
        a=a.map{|q| (q*9)/10}
      elsif ['Archer'].include?(@clzz)
        a=a.map{|q| (q*19)/20}
      elsif ['Lancer'].include?(@clzz)
        a=a.map{|q| (q*21)/20}
      elsif ['Berserker','Ruler','Avenger'].include?(@clzz)
        a=a.map{|q| (q*11)/10}
      end
    end
    statnames=['HP','Atk']
    statnames[1]='EffAtk' if effatk
    if @traits.include?('FEH Servant')
      statnames[0]="<:HP_S:514712247503945739>#{statnames[0]}"
      if ['Saber','Archer','Lancer','Assassin','Berserker'].include?(@clzz)
        statnames[1]="<:StrengthS:514712248372166666>#{statnames[1]}"
      elsif ['Caster'].include?(@clzz)
        statnames[1]="<:MagicS:514712247289774111>#{statnames[1]}"
      elsif @traits.include?('Dragon') || @clzz=='Beast'
        statnames[1]="<:FreezeS:514712247474585610>#{statnames[1]}"
      else
        statnames[1]="<:GenericAttackS:514712247587569664>#{statnames[1]}"
      end
    elsif @traits.include?('DL Servant')
      statnames[0]="<:HP:573344832307593216>#{statnames[0]}"
      statnames[1]="<:Strength:573344931205349376>#{statnames[1]}"
    end
    return [statnames,h,a]
  end
  
  def stat_grid(dispfou=0,effatk=false,jhmod=false)
    if jhmod && effatk && @id.to_i==81
      m=self.disp_stats(dispfou,true,false)
      m2=self.disp_stats(dispfou,true,true)
      for i in 0...m[2].length
        m[2][i]="#{longFormattedNumber(m[2][i])} (J) - #{longFormattedNumber(m2[2][i])} (H)"
      end
    elsif dispfou>0
      m=self.disp_stats(1000,effatk)
      m2=self.disp_stats(2000,effatk)
      for i in 0...m[1].length
        m[1][i]="#{self.stat_emotes[6]}#{longFormattedNumber(m[1][i])} - #{self.stat_emotes[7]}#{longFormattedNumber(m2[1][i])}"
      end
      for i in 0...m[2].length
        m[2][i]="#{self.stat_emotes[6]}#{longFormattedNumber(m[2][i])} - #{self.stat_emotes[7]}#{longFormattedNumber(m2[2][i])}"
      end
    else
      m=self.disp_stats(dispfou,effatk)
      m[1]=m[1].map{|q| longFormattedNumber(q)}
      m[2]=m[2].map{|q| longFormattedNumber(q)}
    end
    str="__#{self.stat_emotes[4]}**Level 1**__\n*#{m[0][0]}:* #{m[1][0]}\n*#{m[0][1]}:* #{m[2][0]}"
    str="#{str}\n\n__#{self.stat_emotes[5]}**Level #{@max_level}**__\n*#{m[0][0]}:* #{m[1][1]}\n*#{m[0][1]}:* #{m[2][1]}"
    str="#{str}\n\n__#{self.stat_emotes[3]}**Level 90**__\n*#{m[0][0]}:* #{m[1][2]}\n*#{m[0][1]}:* #{m[2][2]}" if m[1].length>4 && m[2].length>4
    str="#{str}\n\n__#{self.stat_emotes[13]}**Level 100**__\n*#{m[0][0]}:* #{m[1][-2]}\n*#{m[0][1]}:* #{m[2][-2]}"
    str="#{str}\n\n__#{self.stat_emotes[13]}**Level 120**__\n*#{m[0][0]}:* #{m[1][-1]}\n*#{m[0][1]}:* #{m[2][-1]}"
    return str
  end
  
  def stat_stanza(dispfou=0,effatk=false,jhmod=false)
    m=self.disp_stats(dispfou,effatk)
    m=self.disp_stats(dispfou,true,false) if jhmod && effatk && @id.to_i==81
    m[1]=m[1].map{|q| longFormattedNumber(q)}
    m[2]=m[2].map{|q| longFormattedNumber(q)}
    str="**#{m[0][0]}:**\u00A0\u00A0#{m[1][0]}\u00A0L#{micronumber(1)}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][1]}\u00A0max"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][2]}\u00A0L#{micronumber(90)}" if m[1].length>4
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][-2]}#{self.stat_emotes[13]}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][-1]}#{self.stat_emotes[13]}+"
    str="#{str}\n**#{m[0][1]}#{" (Jekyll)" if jhmod && effatk && @id.to_i==81}:**\u00A0\u00A0#{m[2][0]}\u00A0L#{micronumber(1)}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][1]}\u00A0max"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][2]}\u00A0L#{micronumber(90)}" if m[1].length>4
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][-2]}#{self.stat_emotes[13]}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][-1]}#{self.stat_emotes[13]}+"
    if jhmod && effatk && @id.to_i==81
      m2=self.disp_stats(dispfou,true,true)
      m2[1]=m2[1].map{|q| longFormattedNumber(q)}
      m2[2]=m2[2].map{|q| longFormattedNumber(q)}
      str="#{str}\n**#{m[0][1]} (Hyde):**\u00A0\u00A0#{m2[2][0]}\u00A0L#{micronumber(1)}"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][1]}\u00A0max"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][2]}\u00A0L#{micronumber(90)}" if m2[1].length>4
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][-2]}#{self.stat_emotes[13]}"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][-1]}#{self.stat_emotes[13]}+"
    end
    if jhmod && @id.to_i==81
      k2=$servants[$servants.find_index{|q| q.id==81.0}]
      kk2=$servants[$servants.find_index{|q| q.id==81.1}]
      str="#{str}\n**Death Rate:**\u00A0#{k2.death_rate}%\u00A0(Jekyll)\u00A0\u00A0\u00B7\u00A0\u00A0#{kk2.death_rate}%\u00A0(Hyde)"
      str="#{str}\n\n**Hit Counts**:\u00A0\u00A0#{self.hit_count_disp(1)}"
      str="#{str}\n\n**NP\u00A0Gain\u00A0(Jekyll):**  *Attack:*\u00A0#{k2.np_gain[0]}%"
      str="#{str}  \u00B7  *Alt. Atk.:*\u00A0#{k2.np_gain[2]}%#{"\u00A0(#{k2.np_gain[3]})" unless k2.np_gain.length<4}" unless k2.np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{k2.np_gain[1]}%"
      str="#{str}\n**NP\u00A0Gain\u00A0(Hyde):**  *Attack:*\u00A0#{kk2.np_gain[0]}%"
      str="#{str}  \u00B7  *Alt. Atk.:*\u00A0#{kk2.np_gain[2]}%#{"\u00A0(#{kk2.np_gain[3]})" unless kk2.np_gain.length<4}" unless kk2.np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{kk2.np_gain[1]}%"
      str="#{str}\n\n**Crit\u00A0Stars\u00A0(Jekyll):**  *Weight:*\u00A0#{k2.crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{k2.crit_star[1]}%"
      str="#{str}\n**Crit\u00A0Stars\u00A0(Hyde):**  *Weight:*\u00A0#{kk2.crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{kk2.crit_star[1]}%"
    else
      str="#{str}\n**Death Rate:** #{@death_rate}%"
      str="#{str}\n\n**Hit Counts**:\u00A0\u00A0#{self.hit_count_disp(1)}"
      str="#{str}\n**NP\u00A0Gain:**  *Attack:*\u00A0#{@np_gain[0]}%"
      str="#{str}  \u00B7  *Alt.\u00A0Atk.:*\u00A0#{@np_gain[2]}%#{"\u00A0(#{@np_gain[3].gsub(' ',"\u00A0")})" unless @np_gain.length<4}" unless @np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{@np_gain[1]}%"
      str="#{str}\n**Crit\u00A0Stars:**  *Weight:*\u00A0#{@crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{@crit_star[1]}%"
    end
    return str
  end
  
  def hit_count_disp(mode=0)
    return "#{self.stat_emotes[8]}#{self.hit_count[0]}\u00A0\u00A0\u00B7\u00A0\u00A0#{self.stat_emotes[9]}#{self.hit_count[1]}\u00A0\u00A0\u00B7\u00A0\u00A0#{self.stat_emotes[10]}#{self.hit_count[2]}#{["\n<:Blank:676220519690928179>","\u00A0\u00A0\u00B7\u00A0\u00A0"][mode]}#{self.stat_emotes[11]}#{self.hit_count[3]}\u00A0\u00A0\u00B7\u00A0\u00A0#{self.stat_emotes[12]}#{self.hit_count[4]}"
  end
  
  def attack_params(chain=false)
    if @id.to_i==81 && chain
      s="**Death Rate:** #{@death_rate}%"
    else
      s="__**Hit Counts**__\n#{self.hit_count_disp}"
    end
    s="#{s}\n\n__**NP Gain**__\n*Attack:* #{@np_gain[0]}%"
    s="#{s}\n*Alt. Atk.:* #{@np_gain[2]}%#{" (#{@np_gain[3]})" unless @np_gain.length<4}" unless @np_gain.length<3
    s="#{s}\n*Defense:* #{@np_gain[1]}%"
    s="#{s}\n\n__**Crit Stars**__\n*Weight:* #{@crit_star[0]}\n*Drop Rate:* #{@crit_star[1]}%"
    return s
  end
  
  def grab_a(str)
    return @actives if str=='Active'
    return @actives if str=='Append'
  end
  
  def active_bracket
    m=[]
    data_load(['skills'])
    skz=$skills.map{|q| q.clone}
    for i in 0...@actives.length
      m.push([])
      for i2 in 0...@actives[i].length
        x=skz.find_index{|q| q.type=='Active' && q.fullName==@actives[i][i2]}
        m[i].push(skz[x]) unless x.nil?
      end
    end
    return m
  end
  
  def append_bracket
    m=[]
    data_load(['skills'])
    skz=$skills.map{|q| q.clone}
    for i in 0...@appends.length
      m.push([])
      for i2 in 0...@appends[i].length
        x=skz.find_index{|q| q.type=='Append' && q.fullName==@appends[i][i2]}
        m[i].push(skz[x]) unless x.nil?
      end
    end
    return m
  end
  
  def passive_bracket
    m=[]
    data_load(['skills'])
    skz=$skills.map{|q| q.clone}
    for i in 0...@passives.length
      x=skz.find_index{|q| q.type=='Passive' && q.fullName==@passives[i]}
      m.push(skz[x]) unless x.nil?
    end
    return m
  end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse} [Srv-#{@id}]#{fullformat.reverse}"
  end
  
  def fix_mats
    data_load(['mats'])
    m=@ascension_mats.map{|q| q}
    for i in 0...m.length
      for i2 in 0...m[i].length
        unless m[i][i2][0,14]=='Story Unlock: '
          x=m[i][i2].split(' ')
          x=[x[0,x.length-1].join(' '),x[-1].gsub('x','').to_i]
          y=$mats.find_index{|q| q.name==x[0]}
          if y.nil?
            m[i][i2]=nil
          else
            m[i][i2]=$mats[y].clone
            m[i][i2].value=x[1]*1
          end
        end
      end
    end
    @fixed_ascension_mats=m[0,4].map{|q| q}
    @fixed_costume_mats=[]
    @fixed_costume_mats=m[4,m.length-4].map{|q| q} if m.length>4
    m=@skill_mats.map{|q| q}
    for i in 0...m.length
      for i2 in 0...m[i].length
        unless m[i][i2][0,14]=='Story Unlock: '
          x=m[i][i2].split(' ')
          x=[x[0,x.length-1].join(' '),x[-1].gsub('x','').to_i]
          y=$mats.find_index{|q| q.name==x[0]}
          if y.nil?
            m[i][i2]=nil
          else
            m[i][i2]=$mats[y].clone
            m[i][i2].value=x[1]*1
          end
        end
      end
    end
    @fixed_skill_mats=m.map{|q| q}
  end
  
  def disp_ascension_data(bot,event)
    m=@fixed_ascension_mats.map{|q| q}
    qp=[10000,30000,90000,300000]
    qp=[15000,45000,150000,450000] if [2,0].include?(@rarity)
    qp=[30000,100000,300000,900000] if @rarity==3
    qp=[50000,150000,500000,1500000] if @rarity==4
    qp=[100000,300000,1000000,3000000] if @rarity==5
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    str="__**Ascension Materials** (#{numabr(qp[0,4].inject(0){|sum,x| sum + x })}#{qpe} total)__"
    for i in 0...m.length
      str="#{str}\n*#{['First','Second','Third','Final'][i]} Ascension:* #{m[i].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}"
      str="#{str}  \u00B7  #{numabr(qp[i])}#{qpe}" unless @id<2
    end
    return str
  end
  
  def disp_skill_data(bot,event,mode=0)
    m=@fixed_skill_mats.map{|q| q}
    qp=[10000,20000,60000,80000,200000,250000,500000,600000,1000000]
    qp=[20000,40000,120000,160000,400000,500000,1000000,1200000,2000000] if [2,0].include?(@rarity)
    qp=[50000,100000,300000,400000,1000000,1250000,2500000,3000000,5000000] if @rarity==3
    qp=[100000,200000,600000,800000,2000000,2500000,5000000,6000000,10000000] if @rarity==4
    qp=[200000,400000,1200000,1600000,4000000,5000000,10000000,12000000,20000000] if @rarity==5
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    str="__**#{['Active','Append'][mode]} Skill Materials** "
    str2=''
    f=0
    for i in 0...m.length/2
      str2="#{str2}\n*Level #{i+1}\u2192#{i+2}:* #{m[i+(m.length/2)*mode].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}  \u00B7  #{numabr(qp[i])}#{qpe}"
      f+=qp[i]
    end
    str="#{str} (#{numabr(f)}#{qpe} per skill, #{numabr(f*3)}#{qpe} total)__#{str2}"
    return str
  end
  
  def disp_costume_data(bot,event)
    return nil if @fixed_costume_mats.nil? || @fixed_costume_mats.length<=0
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    m=@fixed_costume_mats.map{|q| q}
    str="__**Costume Materials**__"
    for i in 0...m.length
      str="#{str}\n*#{['First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth'][i]} Costume"
      str="#{str} [#{@costumes[i]}]" if !@costumes.nil? && @costumes.length>i
      str="#{str}:* #{m[i].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}"
      if @id==1.2 && i==0
      elsif @id<1.2 && [1,2].include?(i)
        str="#{str}\n~~the second costume is listed in this bot as Servant #1.2~~" if i==1
        str="#{str}\n~~the third costume is listed in this bot as Servant #1.2 costume 1~~" if i==2
      else
        str="#{str}  \u00B7  #{numabr(3000000)}#{qpe}"
      end
    end
    return str
  end
  
  def disp_mat_summary(bot,event,mat_types=[])
    qp=[10000,30000,90000,300000,10000,20000,60000,80000,200000,250000,500000,600000,1000000]
    qp=[15000,45000,150000,450000,20000,40000,120000,160000,400000,500000,1000000,1200000,2000000] if [2,0].include?(@rarity)
    qp=[30000,100000,300000,900000,50000,100000,300000,400000,1000000,1250000,2500000,3000000,5000000] if @rarity==3
    qp=[50000,150000,500000,1500000,100000,200000,600000,800000,2000000,2500000,5000000,6000000,10000000] if @rarity==4
    qp=[100000,300000,1000000,3000000,200000,400000,1200000,1600000,4000000,5000000,10000000,12000000,20000000] if @rarity==5
    m=[]; m2=[]; x=[]; qpt=0
    if mat_types.length<=0 || mat_types.include?('Ascension')
      m.push(@fixed_ascension_mats.map{|q| q})
      qpt+=qp[0,4].inject(0){|sum,x| sum + x } unless @id<2
    end
    if mat_types.length<=0 || mat_types.include?('Costume')
      m2.push(@fixed_costume_mats.map{|q| q})
      if @id<2
        qpt+=3000000*(@fixed_costume_mats.length-2)
      else
        qpt+=3000000*(@fixed_costume_mats.length)
      end
    end
    if mat_types.length<=0 || mat_types.include?('Skill')
      m.push([@fixed_skill_mats.map{|q| q},@fixed_skill_mats.map{|q| q},@fixed_skill_mats.map{|q| q}])
      qpt+=qp[4,qp.length-4].inject(0){|sum,x| sum + x }*3
    end
    m.flatten!; m2.flatten!
    m=m.reject{|q| q.is_a?(String)}; m2=m2.reject{|q| q.is_a?(String)}
    x2=[m,m2].flatten.reject{|q| q.is_a?(String)}.map{|q| q.name}.uniq.sort
    for i in 0...x2.length
      bob4=FGOMat.new(x2[i])
      bob4.value=0; bob4.value2=0
      f=m.reject{|q| x2[i]!=q.name}
      bob4.value=f.map{|q| q.value}.inject(0){|sum,xx| sum + xx } unless f.nil? || f.length<=0
      f=m2.reject{|q| x2[i]!=q.name}
      bob4.value2=f.map{|q| q.value}.inject(0){|sum,xx| sum + xx } unless f.nil? || f.length<=0
      x.push(bob4.clone)
    end
    x=x.map{|q| q.emoji(bot,event,1)}
    if @id<2
      x2=nil
      x2='**Story progress**: 7 singulariries' if mat_types.length<=0 || mat_types.include?('Ascension')
      x2='**Story progress**: 8 singulariries + 5 lostbelts' if mat_types.length<=0 || mat_types.include?('Costume')
      x.unshift(x2) unless x2.nil?
    end
    x.push("\u00B7\u00A0\u00A0**#{longFormattedNumber(qpt)} QP**<:QP:523842660407181324>") if qpt>0
    return x
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Servant' || q[2]!=@id}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    a=['Default art','First/Second Ascension','Third Ascension','Final Ascension','First Costume','Second Costume','Third Costume','Fourth Costume','Fifth Costume','Sixth Costume','Seventh Costume',
       'Eighth Costume','Ninth Costume','Tenth Costume']
    for i in 0...10
      a[i+4]="#{a[i+4]} [#{@costumes[i]}]" unless @costumes.nil? || @costumes[i].nil?
    end
    if event.server.nil?
      for i in 0...k.length
        asc=k[i][5]
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
          k[i]="#{k[i]} (forces #{a[asc]} in the `art` command)" unless asc.nil?
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{" *(forces #{a[q[5]]} in the `art` command)*" unless q[5].nil?}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}** [Srv-#{@id}]#{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
  
  def skill_tags(includepassive=false,match=[])
    return has_any?(self.passive_bracket.map{|q| q.tags}.flatten,match) if match.length>0 && includepassive==1
    act=self.active_bracket.map{|q| q.map{|q2| q2.tags}}
    pas=[]; pas=self.passive_bracket.map{|q| q.tags} if includepassive
    app=self.append_bracket.map{|q| q.map{|q2| q2.tags}}
    nob=$nobles.reject{|q| q.id.split('u')[0].to_f != @id}.map{|q| q.tags}
    return [act,pas,app,nob].flatten if match.length<=0
    typ=[[],[],[],[]]
    for i in 0...act.length
      if has_any?(act[i][0],match) && has_any?(act[i][-1],match)
        typ[0].push("#{i+1}")
      elsif has_any?(act[i][0],match)
        typ[0].push("#{i+1}b")
      elsif has_any?(act[i][-1],match)
        typ[0].push("#{i+1}u")
      elsif act[i].reject{|q| !has_any?(q,match)}.length>0
        typ[0].push("#{i+1}s")
      end
    end
    typ[0]="S#{typ[0].join('/')}" if typ[0].length>0
    typ[1]='Psv' if has_any?(pas.flatten,match)
    for i in 0...app.length
      if has_any?(app[i][0],match) && has_any?(app[i][-1],match)
        typ[2].push("#{i+1}")
      elsif has_any?(app[i][0],match)
        typ[2].push("#{i+1}b")
      elsif has_any?(app[i][-1],match)
        typ[2].push("#{i+1}u")
      elsif app[i].reject{|q| !has_any?(q,match)}.length>0
        typ[2].push("#{i+1}s")
      end
    end
    typ[2]="A#{typ[2].join('/')}" if typ[2].length>0
    if has_any?(nob[0],match) && has_any?(nob[-1],match)
      typ[3]="NP"
    elsif has_any?(nob[0],match)
      typ[3]="NPb"
    elsif has_any?(nob[-1],match)
      typ[3]="NPu"
    elsif nob.reject{|q| !has_any?(q,match)}.length>0
      typ[3]="NPs"
    end
    return "*[#{typ.reject{|q| q.length<=0}.join('+')}]*"
  end
end

class SuperServant < FGOServant # attributes shared by Dev- and Donor- Servants but not included in basic servants
  attr_accessor :base_servant
  attr_accessor :fous
  attr_accessor :codes
  attr_accessor :skill_levels,:np_level
  attr_accessor :ce_equip
  attr_accessor :bond_level
  attr_accessor :ascend
  
  def fous=(val); @fous=val.split('\\'[0]).map{|q| q.to_i}; end
  def codes=(val); @codes=val.split('\\'[0]).map{|q| q.to_i}; end
  def skill_levels=(val); @skill_levels=val.split('\\'[0]); end
  def np_level=(val); @np_level=val; end
  def ce_equip=(val); @ce_equip=val.to_i; end
  def bond_level=(val); @bond_level=val.to_i; end
  def ascend=(val); @ascend=val.split('\\'[0]).map{|q| q.to_i}; end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{@owner}'s #{"Japanese " if @nationality=='JP'}#{format}#{@name}#{format.reverse} [Srv-#{@id}]#{fullformat.reverse}"
  end
  
  def active_bracket
    ret=@base_servant.active_bracket.map{|q| q}
    for i in 0...3
      f=0
      f=1 if @skill_levels[i].include?('u')
      f=@skill_levels[i].split('u')[1].to_i if @skill_levels[i].include?('u') && @skill_levels[i].split('u')[1].to_i>1
      ret[i]=[ret[i][f]]
    end
    return ret
  end
  
  def append_bracket
    ret=@base_servant.append_bracket.map{|q| q}
    for i in 0...3
      f=0
      f=1 if @skill_levels[i+3].include?('u')
      f=@skill_levels[i+3].split('u')[1].to_i if @skill_levels[i+3].include?('u') && @skill_levels[i+3].split('u')[1].to_i>1
      ret[i]=[ret[i][f]]
    end
    return ret
  end
  
  def passive_bracket; return @base_servant.passive_bracket.map{|q| q}; end
  def fix_mats; @base_servant.fix_mats; end
  
  def stat_grid(dispfou=0,effatk=false,jhmod=false)
    if jhmod && effatk && @id.to_i==81
      m=self.disp_stats(0,true,false)
      m2=self.disp_stats(0,true,true)
      for i in 0...m[2].length
        m[2][i]="#{longFormattedNumber(m[2][i]+@fous[1])} (J) - #{longFormattedNumber(m2[2][i]+@fous[1])} (H)"
      end
      m[1]=m[1].map{|q| longFormattedNumber(q+@fous[0])}
    else
      m=self.disp_stats(0,effatk)
      m[1]=m[1].map{|q| longFormattedNumber(q+@fous[0])}
      m[2]=m[2].map{|q| longFormattedNumber(q+@fous[1])}
    end
    str="__#{self.stat_emotes[4]}**Level 1**__\n*#{m[0][0]}:* #{m[1][0]}\n*#{m[0][1]}:* #{m[2][0]}"
    str="#{str}\n\n__#{self.stat_emotes[5]}**Level #{@max_level}**__\n*#{m[0][0]}:* #{m[1][1]}\n*#{m[0][1]}:* #{m[2][1]}"
    str="#{str}\n\n__#{self.stat_emotes[3]}**Level 90**__\n*#{m[0][0]}:* #{m[1][2]}\n*#{m[0][1]}:* #{m[2][2]}" if m[1].length>4 && m[2].length>4
    str="#{str}\n\n__#{self.stat_emotes[13]}**Level 100**__\n*#{m[0][0]}:* #{m[1][-2]}\n*#{m[0][1]}:* #{m[2][-2]}"
    str="#{str}\n\n__#{self.stat_emotes[13]}**Level 120**__\n*#{m[0][0]}:* #{m[1][-1]}\n*#{m[0][1]}:* #{m[2][-1]}"
    return str
  end
  
  def stat_stanza(dispfou=0,effatk=false,jhmod=false)
    m=self.disp_stats(0,effatk)
    m=self.disp_stats(0,true,false) if jhmod && effatk && @id.to_i==81
    m[1]=m[1].map{|q| longFormattedNumber(q+@fou[0])}
    m[2]=m[2].map{|q| longFormattedNumber(q+@fou[1])}
    str="**#{m[0][0]}:**\u00A0\u00A0#{m[1][0]}\u00A0L#{micronumber(1)}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][1]}\u00A0max"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][2]}\u00A0L#{micronumber(90)}" if m[1].length>4
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][-2]}#{self.stat_emotes[13]}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[1][-1]}#{self.stat_emotes[13]}+"
    str="#{str}\n**#{m[0][1]}#{" (Jekyll)" if jhmod && effatk && @id.to_i==81}:**\u00A0\u00A0#{m[2][0]}\u00A0L#{micronumber(1)}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][1]}\u00A0max"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][2]}\u00A0L#{micronumber(90)}" if m[1].length>4
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][-2]}#{self.stat_emotes[13]}"
    str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m[2][-1]}#{self.stat_emotes[13]}+"
    if jhmod && effatk && @id.to_i==81
      m2=self.disp_stats(0,true,true)
      m2[1]=m2[1].map{|q| longFormattedNumber(q+@fou[0])}
      m2[2]=m2[2].map{|q| longFormattedNumber(q+@fou[1])}
      str="#{str}\n**#{m[0][1]} (Hyde):**\u00A0\u00A0#{m2[2][0]}\u00A0L#{micronumber(1)}"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][1]}\u00A0max"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][2]}\u00A0L#{micronumber(90)}" if m2[1].length>4
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][-2]}#{self.stat_emotes[13]}"
      str="#{str}\u00A0\u00A0\u00B7\u00A0\u00A0#{m2[2][-1]}#{self.stat_emotes[13]}+"
    end
    if jhmod && @id.to_i==81
      k2=$servants[$servants.find_index{|q| q.id==81.0}]
      kk2=$servants[$servants.find_index{|q| q.id==81.1}]
      str="#{str}\n**Death Rate:**\u00A0#{k2.death_rate}%\u00A0(Jekyll)\u00A0\u00A0\u00B7\u00A0\u00A0#{kk2.death_rate}%\u00A0(Hyde)"
      str="#{str}\n\n**Hit Counts**:\u00A0\u00A0#{self.hit_count_disp(1)}"
      str="#{str}\n\n**NP\u00A0Gain\u00A0(Jekyll):**  *Attack:*\u00A0#{k2.np_gain[0]}%"
      str="#{str}  \u00B7  *Alt. Atk.:*\u00A0#{k2.np_gain[2]}%#{"\u00A0(#{k2.np_gain[3]})" unless k2.np_gain.length<4}" unless k2.np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{k2.np_gain[1]}%"
      str="#{str}\n**NP\u00A0Gain\u00A0(Hyde):**  *Attack:*\u00A0#{kk2.np_gain[0]}%"
      str="#{str}  \u00B7  *Alt. Atk.:*\u00A0#{kk2.np_gain[2]}%#{"\u00A0(#{kk2.np_gain[3]})" unless kk2.np_gain.length<4}" unless kk2.np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{kk2.np_gain[1]}%"
      str="#{str}\n\n**Crit\u00A0Stars\u00A0(Jekyll):**  *Weight:*\u00A0#{k2.crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{k2.crit_star[1]}%"
      str="#{str}\n**Crit\u00A0Stars\u00A0(Hyde):**  *Weight:*\u00A0#{kk2.crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{kk2.crit_star[1]}%"
    else
      str="#{str}\n**Death Rate:** #{@death_rate}%"
      str="#{str}\n\n**Hit Counts**:\u00A0\u00A0#{self.hit_count_disp(1)}"
      str="#{str}\n**NP\u00A0Gain:**  *Attack:*\u00A0#{@np_gain[0]}%"
      str="#{str}  \u00B7  *Alt.\u00A0Atk.:*\u00A0#{@np_gain[2]}%#{"\u00A0(#{@np_gain[3].gsub(' ',"\u00A0")})" unless @np_gain.length<4}" unless @np_gain.length<3
      str="#{str}  \u00B7  *Defense:*\u00A0#{@np_gain[1]}%"
      str="#{str}\n**Crit\u00A0Stars:**  *Weight:*\u00A0#{@crit_star[0]}  \u00B7  *Drop\u00A0Rate:*\u00A0#{@crit_star[1]}%"
    end
    return str
  end
  
  def disp_ascension_data(bot,event)
    m=@base_servant.fixed_ascension_mats.map{|q| q}
    qp=[10000,30000,90000,300000]
    qp=[15000,45000,150000,450000] if [2,0].include?(@rarity)
    qp=[30000,100000,300000,900000] if @rarity==3
    qp=[50000,150000,500000,1500000] if @rarity==4
    qp=[100000,300000,1000000,3000000] if @rarity==5
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    str="__**Ascension Materials** (#{numabr(qp[@ascend[0],4-@ascend[0]].inject(0){|sum,x| sum + x })}#{qpe} total)__"
    unless @ascend[0]>=4
      for i in @ascend[0]...m.length
        str="#{str}\n*#{['First','Second','Third','Final'][i]} Ascension:* #{m[i].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}"
        str="#{str}  \u00B7  #{numabr(qp[i])}#{qpe}" unless @id<2
      end
    end
    return str
  end
  
  def disp_skill_data(bot,event,mode=0)
    m=@base_servant.fixed_skill_mats.map{|q| q}
    qp=[10000,20000,60000,80000,200000,250000,500000,600000,1000000]
    qp=[20000,40000,120000,160000,400000,500000,1000000,1200000,2000000] if [2,0].include?(@rarity)
    qp=[50000,100000,300000,400000,1000000,1250000,2500000,3000000,5000000] if @rarity==3
    qp=[100000,200000,600000,800000,2000000,2500000,5000000,6000000,10000000] if @rarity==4
    qp=[200000,400000,1200000,1600000,4000000,5000000,10000000,12000000,20000000] if @rarity==5
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    str="__**#{['Active','Append'][mode]} Skill Materials** "
    str2=''
    f=0
    for i in 0...m.length/2
      str2="#{str2}\n*Level #{i+1}\u2192#{i+2}:* #{m[i+(m.length/2)*mode].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}  \u00B7  #{numabr(qp[i])}#{qpe}" unless @skill_levels[3*mode,3].map{|q| q.split('u')[0].to_i}.min>i
      f+=qp[i] if @skill_levels[0+3*mode].split('u')[0].to_i<=i
      f+=qp[i] if @skill_levels[1+3*mode].split('u')[0].to_i<=i
      f+=qp[i] if @skill_levels[2+3*mode].split('u')[0].to_i<=i
    end
    str="#{str} (#{numabr(f)}#{qpe} total)__#{str2}"
    return str
  end
  
  def disp_costume_data(bot,event)
    return nil if @fixed_costume_mats.nil? || @fixed_costume_mats.length<=0
    qpe='<:QP:523842660407181324>'
    qpe=' QP' if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats'])
    m=@base_servant.fixed_costume_mats.map{|q| q}
    str="__**Costume Materials**__"
    for i in 0...m.length
      str="#{str}\n*#{['First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth'][i]} Costume"
      str="#{str} [#{@costumes[i]}]" if !@costumes.nil? && @costumes.length>i
      str="#{str}:* #{m[i].map{|q| "#{q if q.is_a?(String)}#{q.emoji(bot,event) if q.is_a?(FGOMat)}"}.join(', ')}"
      if @id==1.2 && i==0
      elsif @id<1.2 && [1,2].include?(i)
        str="#{str}\n~~the second costume is listed in this bot as Servant #1.2~~" if i==1
        str="#{str}\n~~the third costume is listed in this bot as Servant #1.2 costume 1~~" if i==2
      else
        str="#{str}  \u00B7  #{numabr(3000000)}#{qpe}"
      end
    end
    return str
  end
  
  def emoji(bot,event,mode=0,clrshift=0)
    m=super(bot,event,mode,@ascend[2])
    m="#{m}\u{1F4A0}" if @owner=='Mathoo' && clrshift<=0
    m="#{m}<:FGO_Favorite:679278523009204226>" if @owner=='Mathoo' && self.fav? # Rhyme, Beni, Habetrot
    m="#{m}<:Ace_Staff:875102524829478912>" if @owner=='Ace' && clrshift<=0
    m="#{m}<:FGO_Favorite:679278523009204226>" if @owner=='Ace' && self.fav?
    return m
  end
  
  def ce_display
    data_load(['craft','support'])
    x=$support_lineups.find_index{|q| q.owner==@owner && q.nationality==@nationality}
    x=$support_lineups.find_index{|q| q.owner==@owner} if x.nil?
    unless x.nil?
      x=$support_lineups[x].lineup
      m=x.find_index{|q| q.servant_id==@id.to_i}
      unless m.nil?
        m=x[m]
        c2=$crafts.find_index{|q| q.id==m.ce_id}
      end
    end
    c=$crafts.find_index{|q| q.id==@ce_equip}
    return @base_servant.ce_display if c.nil? && c2.nil?
    c=$crafts[c] unless c.nil?
    c2=$crafts[c2] unless c.nil?
    return "**Equipped CE** *(local)*: #{c.name} [CE-##{c.id}]" if c2.nil?
    return "**Equipped CE** *(support)*: #{c2.name} [CE-##{c2.id}]" if c.nil?
    return "**Equipped CE:** #{c.name} [CE-##{c.id}]" if c2.id==c.id
    return "__**Equipped CE**__\n*Local:* #{c.name} [CE-##{c.id}]\n*Support:* #{c2.name} [CE-##{c2.id}]"
  end
  
  def storage_string
    x="#{@id} # #{@name}"
    x="#{x}\n#{@fous.join('\\'[0])}"
    x="#{x}\n#{@codes.join('\\'[0])}"
    x="#{x}\n#{@skill_levels[0,3].join('\\'[0])} \\ #{@skill_levels[3,3].join('\\'[0])}"
    x="#{x}\n#{@np_level}"
    c=$crafts.find_index{|q| q.id==@ce_equip}
    if c.nil?
      x="#{x}\n0"
    else
      x="#{x}\n#{@ce_equip} # #{$crafts[c].name}"
    end
    x="#{x}\n#{@bond_level}"
    x="#{x}\n#{@ascend.join('\\'[0])}"
    return x
  end
  
  def creation_string(bot,event)
    return "#{'Japanese ' if @nationality=='JP'}#{@name} [Srv-#{@id}] #{self.emoji(bot,event)}"
  end
end

class DevServant < SuperServant
  def initialize(val)
    @id=val.to_i
    @id=val.to_f if val.to_f<2 || val.to_i==81
    u=$servants.find_index{|q| q.id==@id}
    @base_servant=$servants[u].clone
    @name="#{@base_servant.name}"
    @artist="#{@base_servant.artist}"
    @voice_jp="#{@base_servant.voice_jp}"
    @clzz="#{@base_servant.clzz}"
    @grow_curve="#{@base_servant.grow_curve}"
    @rarity=@base_servant.rarity*1
    @max_level=@base_servant.max_level*1
    @hp=@base_servant.hp.map{|q| q}
    @atk=@base_servant.atk.map{|q| q}
    @np_gain=@base_servant.np_gain.map{|q| q}
    @hit_count=@base_servant.hit_count.map{|q| q}
    @crit_star=@base_servant.crit_star.map{|q| q}
    @death_rate=@base_servant.death_rate*1
    @attribute="#{@base_servant.attribute}"
    @gender="#{@base_servant.gender}"
    @traits=@base_servant.traits.map{|q| q}
    @deck="#{@base_servant.deck}"
    @availability=@base_servant.availability.map{|q| q}
    @team_cost=@base_servant.team_cost*1
    @alignment="#{@base_servant.alignment}"
    @bond_ce=@base_servant.bond_ce*1
    @valentines_ce=@base_servant.valentines_ce.map{|q| q} unless @base_servant.valentines_ce.nil?
    @alts=@base_servant.alts.map{|q| q} unless @base_servant.alts.nil?
    @costumes=@base_servant.costumes.map{|q| q} unless @base_servant.costumes.nil?
    @owner='Mathoo'
    @nationality='NA'
    if @id==182
      @traits.push('Doll *[Added]*')
    elsif @gender=='Female'
      @traits.push('Smol *[Added]*')
    end
    @traits.push('Cuddly *[Added]*') if self.fav? && @gender=='Female'
    @alignment='Chaotic Good' if @id==74 # Rhyme's canon is that she takes her morality from her master.  Thus, my developer's Rhyme should canonically be Chaotic Good even if she's true Neutral in gameplay.
  end
  
  def disp_color(chain=0,mode=0)
    f=super(-1,1).map{|q| q}
    f2=f.map{|q| q}
    f.unshift(0x00DAFA)
    f.unshift(0xFFABAF) if self.fav?
    # Special colors
    xcolor=f[chain]
    xcolor=f2[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
end

class DonorServant < SuperServant
  attr_accessor :owner_id
  attr_accessor :color_name,:color_tag
  
  def initialize(val,owner='',ownerid=0)
    @nationality='NA'
    @nationality='JP' if val.include?('j')
    val=val.gsub('j','')
    @id=val.to_i
    @id=val.to_f if val.to_f<2 || val.to_i==81
    u=$servants.find_index{|q| q.id==@id}
    @base_servant=$servants[u].clone
    @name="#{@base_servant.name}"
    @artist="#{@base_servant.artist}"
    @voice_jp="#{@base_servant.voice_jp}"
    @clzz="#{@base_servant.clzz}"
    @grow_curve="#{@base_servant.grow_curve}"
    @rarity=@base_servant.rarity*1
    @max_level=@base_servant.max_level*1
    @hp=@base_servant.hp.map{|q| q}
    @atk=@base_servant.atk.map{|q| q}
    @np_gain=@base_servant.np_gain.map{|q| q}
    @hit_count=@base_servant.hit_count.map{|q| q}
    @crit_star=@base_servant.crit_star.map{|q| q}
    @death_rate=@base_servant.death_rate*1
    @attribute="#{@base_servant.attribute}"
    @gender="#{@base_servant.gender}"
    @traits=@base_servant.traits.map{|q| q}
    @deck="#{@base_servant.deck}"
    @availability=@base_servant.availability.map{|q| q}
    @team_cost=@base_servant.team_cost*1
    @alignment="#{@base_servant.alignment}"
    @bond_ce=@base_servant.bond_ce*1
    @valentines_ce=@base_servant.valentines_ce.map{|q| q} unless @base_servant.valentines_ce.nil?
    @alts=@base_servant.alts.map{|q| q} unless @base_servant.alts.nil?
    @costumes=@base_servant.costumes.map{|q| q} unless @base_servant.costumes.nil?
    owner=owner.split('\\'[0])
    @owner=owner[0]
    @color_tag=owner[1].hex
    @owner_id=ownerid
  end
  
  def disp_color(chain=0,mode=0)
    f=super(-1,1).map{|q| q}
    f2=f.map{|q| q}
    f.unshift(@color_tag) if get_donor_list().reject{|q| q[2][1]<5}.map{|q| q[0]}.include?(@owner_id)
    # Special colors
    xcolor=f[chain]
    xcolor=f2[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
end

class FGO_CE
  attr_accessor :id
  attr_accessor :name
  attr_accessor :rarity,:cost
  attr_accessor :stats_1,:stats_max
  attr_accessor :effect
  attr_accessor :availability
  attr_accessor :artist,:voice_jp
  attr_accessor :tags
  attr_accessor :servants
  attr_accessor :comment
  attr_accessor :sort_data
  
  def initialize(val)
    @id=val.to_i
    @tags=[]
  end
  
  def name=(val); @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def rarity=(val); @rarity=val.to_i; end
  def cost=(val); @cost=val.to_i; end
  def stats_1=(val); @stats_1=val.split(', ').map{|q| q.to_i}; end
  def stats_max=(val); @stats_max=val.split(', ').map{|q| q.to_i}; end
  def effect=(val); @effect=val.map{|q| q.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split('; ')}.reject{|q| q.length<=0}.compact.uniq; end
  def availability=(val); @availability=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def artist=(val); @artist=val; end
  def tags=(val); @tags=[]; @tags=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', ') unless val.nil? || val.length<=0; end
  def servants=(val); @servants=val.split(', ').map{|q| q.to_i}; end
  def comment=(val); @comment=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Craft'; end
  def type; return 'CE'; end
  def objt2; return 'Servant-Craft'; end
  def tid; return @id; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def servant_connection
    data_load(['servants'])
    srv=$servants.map{|q| q.clone}
    k=srv.find_index{|q| q.bond_ce==@id}
    return ['Bond',srv[k].clone] unless k.nil?
    k=srv.find_index{|q| q.valentines_ce.include?(@id)}
    return ['Valentines',srv[k].clone] unless k.nil?
    return nil
  end
  
  def disp_color(chain=0,mode=0)
    x=0x7D4529
    x=0x718F93 if @rarity>2
    x=0xF5D672 if @rarity>3
    f=[x]
    unless self.servant_connection.nil?
      f.unshift(self.servant_connection[1].disp_color(0))
      f.unshift(0xFF42AC) if self.servant_connection[0]=='Valentines'
    end
    # Special colors
    xcolor=f[chain]
    xcolor=f[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
  
  def rarity_row
    str="<:FGO_icon_rarity_mono:523903551144198145>"*@rarity
    m=[]
    m=self.servant_connection[1].traits.clone unless self.servant_connection.nil?
    if @tags.include?('FEH') || m.include?('FEH Servant')
      str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][@rarity]*@rarity
    elsif @tags.include?('DL') || m.include?('DL Servant')
      str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][@rarity]*@rarity
    end
    str="\u200B#{str}\u200B"
    str="**0-star**" if @rarity==0
    return str
  end
  
  def thumbnail(event,art=0)
    m=@id.to_s
    m="0#{m}" if @id<10
    m="0#{m}" if @id<100
    return "http://fate-go.cirnopedia.org/icons/essence_sample/craft_essence_#{m}.png"
  end
  
  def stat_emotes
    m=[]
    m=self.servant_connection[1].traits.clone unless self.servant_connection.nil?
    return ['<:RRAffinity:565064751780986890>','<:Icon_Support:448293527642701824>','<:Aether_Stone:510776805746278421>','<:Refining_Stone:453618312165720086>'] if @tags.include?('FEH') || m.include?('FEH Servant')
    return ['<:Type_Healing:532107867348533249>','<:HP:573344832307593216>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>'] if @tags.include?('DL') || m.include?('DL Servant')
    return ['<:Bond:613804021119189012>','<:Valentines:676941992768569374>','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>']
  end
  
  def stat_grid
    if @tags.include?('NewYear')
      str="__**Japan** stats__\n*HP:* #{@stats_1[0]}  \u00B7  *Atk:* #{@stats_1[1]}"
      str="#{str}\n\n__**North America** stats__\n*HP:* #{@stats_max[0]}  \u00B7  *Atk:* #{@stats_max[1]}"
      if @effect.length<=1
        str="#{str}\n\n**Effect:**\n#{@effect[0].join("\n")}"
      else
        str="#{str}\n\n__#{self.stat_emotes[2]}**Base Limit**__\n#{@effect[0].join("\n")}"
        str="#{str}\n\n__#{self.stat_emotes[3]}**Max Limit**__\n#{@effect[-1].join("\n")}"
      end
    elsif @stats_1==@stats_max && @effect.length<=1
      str="**HP:** #{@stats_1[0]}\n**Atk:** #{@stats_1[1]}\n**Effect:** #{@effect[0].join("\n")}"
    else
      str="__#{self.stat_emotes[2]}**Base Limit**__\n*HP:* #{@stats_1[0]}\n*Atk:* #{@stats_1[1]}\n*Effect:* #{@effect[0].join("\n")}"
      str="#{str}\n\n__#{self.stat_emotes[3]}**Max Limit**__\n*HP:* #{@stats_max[0]}\n*Atk:* #{@stats_max[1]}\n*Effect:* #{@effect[-1].join("\n")}"
    end
    return str
  end
  
  def emoji(bot,event,mode=0,clrshift=0)
    return '' if self.servant_connection.nil?
    return self.stat_emotes[0] if self.servant_connection[0]=='Bond'
    return self.stat_emotes[1] if self.servant_connection[0]=='Valentines'
    return ''
  end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse} [CE-#{@id}]#{fullformat.reverse}"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Craft' || q[2]!=@id}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}** [CE-#{@id}]#{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

# Skill-related data

class FGOSubskill
  attr_accessor :effect
  attr_accessor :power
  attr_accessor :np_related
  
  def initialize(val)
    @np_related=false
    val=val.split(';; ')
    @effect=val[0]
    @effect="> #{val[0][1,val[0].length-1]}" if val[0][0]=='>' && val[0][1]!=' '
    @power=val[1,val.length-1] if val.length>1
  end
  
  def np_related=(val); @np_related=val; end
  
  def disp_str(lvl=0)
    if @power.nil? || @power.length<=0 || (@power[0]=='-' && @power.uniq.length<=1)
      return @effect
    elsif @power.uniq.length<=1 # if all levels have the same result, let players know it's constant
      return "#{@effect} - Constant #{@power[0]}"
    elsif lvl>0 && !(@np_related && @effect.include?('<OVERCHARGE>')) # if a level is specified, show specifically that level
      return "#{@effect} - #{@power[lvl-1]}"
    elsif @np_related # np level data should display everything
      m=@power.map{|q| q}
      for i in 0...m.length
        m[i]="#{m[i]}\u00A0NP#{micronumber(i+1)}" unless @effect.include?('<OVERCHARGE>')
      end
      return "#{@effect} - #{m.join("\u00A0/\u00A0")}"
    else
      str="#{@effect} - #{@power[0]}\u00A0L#{micronumber(1)}"
      str="#{str}\u00A0/\u00A0#{@power[5]}\u00A0L#{micronumber(6)}" unless @power.length<6
      str="#{str}\u00A0/\u00A0#{@power[-1]}\u00A0L#{micronumber(@power.length)}"
      return str
    end
  end
end

class FGOSkill
  attr_accessor :name,:rank
  attr_accessor :type
  attr_accessor :tags
  attr_accessor :effects
  attr_accessor :id
  attr_accessor :cooldown,:target
  
  def initialize(val)
    @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
  end
  
  def name=(val); @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def rank=(val); @rank=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def type=(val); @type=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def effects=(val); @effects=val; end
  def objt; return @type; end
  
  def tags=(val)
    val=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(', ')
    for i in 0...val.length
      val[i]='Evasion' if val[i]=='Evade'
    end
    @tags=val
  end
  
  def fullName(format=nil,justlast=false,sklz=nil)
    x="#{@name}"
    x="#{format}#{x}#{format.reverse}" unless format.nil?
    return x if ['-'].include?(@rank) || @rank.nil?
    return x if ['example'].include?(@rank) && format.nil? && !justlast
    skz=$skills.reject{|q| q.name != @name || q.rank=='example' || q.type != @type}
    skz=sklz.reject{|q| q.name != @name || q.rank=='example' || q.type != @type} unless sklz.nil?
    char='/'
    char=' / ' if skz.reject{|q| !q.rank.include?('/')}.length>0
    if skz.length>5
      skz=[skz[0],skz[-1]]
      char=" \u2192 "
    end
    skz=[self.clone] if skz.nil? || skz.length<=0
    x="#{x} #{'+' if skz[-1].rank.include?('%')}" unless @name[-1]=='+'
    return "#{x}#{@rank}" unless @rank=='example'
    return "#{x}" if justlast && skz.length<=0
    return "#{x}#{skz[-1].rank}" if justlast
    return "#{x}#{skz.map{|q| q.rank}.join(char)}"
  end
  
  def emoji(bot,event,mode=0,clrshift=0); return ''; end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse}#{fullformat.reverse}"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    return nil if self.is_a?(FGO_NP)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}** #{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class FGOActive < FGOSkill
  def initialize(val)
    @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
    @type='Active'
  end
  
  def cooldown=(val); @cooldown=val.to_i; end
  def target=(val); @target=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(' / '); end
  
  def description(lvl=0,ignore='')
    if lvl>0 # if a level is specified, show that data specifically
      cd=[@cooldown*1]*5; cd.push([@cooldown-1]*4); cd.push(@cooldown-2); cd.flatten!
      cd="#{cd[lvl-1]}\u00A0L#{micronumber(lvl)}"
    else # Otherwise, show levels 1, 6, 10
      cd="#{@cooldown}\u00A0L#{micronumber(1)}"
      cd="#{cd}\u00A0/\u00A0#{@cooldown-1}\u00A0L#{micronumber(6)}"
      cd="#{cd}\u00A0/\u00A0#{@cooldown-2}\u00A0L#{micronumber(10)}"
    end
    str=''
    str="*Cooldown:* #{cd}" unless ignore.include?('C')
    str="#{str}#{"\n" unless str.length<=0}*Target:* #{@target.join(' / ')}" unless ignore.include?('T')
    for i in 0...@effects.length
      str="#{str}#{"\n" unless str.length<=0}#{@effects[i].disp_str(lvl)}"
    end
    return str
  end
  
  def disp_color(chain=0,mode=0)
    r=[64+12*chain,255].min
    g=[4*chain,255].min
    b=[128+16*chain,255].min
    return [0x400080] if chain<0
    return [r, g, b] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return 256*256*r+256*g+b
  end
end

class FGOPassive < FGOSkill
  def initialize(val)
    @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
    @type='Passive'
    @tags=[]
  end
  
  def description(lvl=0,ignore=''); return @effects; end
  
  def disp_color(chain=0,mode=0)
    r=[4*chain,255].min
    g=[64+12*chain,255].min
    b=[128+16*chain,255].min
    return [0x400080] if chain<0
    return [r, g, b] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return 256*256*r+256*g+b
  end
end

class FGOClothingSkill < FGOSkill
  def initialize(val)
    @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
    @type='ClothingSkill'
  end
  
  def cooldown=(val); @cooldown=val.to_i; end
  
  def description(lvl=0,ignore='')
    if lvl>0 # if a level is specified, show that data specifically
      cd=[@cooldown*1]*5; cd.push([@cooldown-1]*4); cd.push(@cooldown-2); cd.flatten!
      cd="#{cd[lvl-1]}\u00A0L#{micronumber(lvl)}"
    else # Otherwise, show levels 1, 6, 10
      cd="#{@cooldown}\u00A0L#{micronumber(1)}"
      cd="#{cd}\u00A0/\u00A0#{@cooldown-1}\u00A0NP#{micronumber(6)}"
      cd="#{cd}\u00A0/\u00A0#{@cooldown-2}\u00A0NP#{micronumber(10)}"
    end
    str=''
    str="*Cooldown:* #{cd}" unless ignore.include?('C')
    for i in 0...@effects.length
      str="#{str}#{"\n" unless str.length<=0}#{@effects[i].disp_str(lvl)}"
    end
    return str
  end
  
  def disp_color(chain=0,mode=0)
    r=[128+16*chain,255].min
    g=[64+12*chain,255].min
    b=[4*chain,255].min
    return [0x400080] if chain<0
    return [r, g, b] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return 256*256*r+256*g+b
  end
end

class FGO_NP < FGOSkill
  attr_accessor :subtitle
  attr_accessor :alt_name
  
  def subtitle=(val); @subtitle=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def id=(val); @id=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def alt_name=(val); @alt_name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(': '); end
  def target=(val); @target=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(' / '); end
  def type=(val); @type=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').split(' / '); end
  def objt; return 'NP'; end
  
  def disp_color(chain=0,mode=0)
    data_load(['servant'])
    srv=$servants.map{|q| q.clone}
    s=srv.find_index{|q| q.id==@id.split('u')[0].to_f}
    return 0x02010a if s.nil?
    s=srv[s].clone
    x=[237,97,154]
    x=[33,188,44] if s.deck[6,1]=='Q'
    x=[11,77,223] if s.deck[6,1]=='A'
    x=[254,33,22] if s.deck[6,1]=='B'
    m=[x]
    if s.deck.include?('[') # servants with variable NP card type
      m.push(x)
      m.push(x)
      m.push([33,188,44]) if s.deck.split('[')[1].include?('Q') && s.deck[6,1]!='Q'
      m.push([11,77,223]) if s.deck.split('[')[1].include?('A') && s.deck[6,1]!='A'
      m.push([254,33,22]) if s.deck.split('[')[1].include?('B') && s.deck[6,1]!='B'
    end
    xcolor=avg_color(m)
    return [xcolor] if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
  
  def card_type
    data_load(['servant'])
    srv=$servants.map{|q| q.clone}
    s=srv.find_index{|q| q.id==@id.split('u')[0].to_f}
    return '<:extra:523854816766590987> Extra' if s.nil?
    s=srv[s].clone
    x="#{s.stat_emotes[0]} Quick" if s.deck[6,1]=='Q'
    x="#{s.stat_emotes[1]} Arts" if s.deck[6,1]=='A'
    x="#{s.stat_emotes[2]} Buster" if s.deck[6,1]=='B'
    if s.deck.include?('[')
      m=[]
      m.push("#{s.stat_emotes[0]}Q") if s.deck.split('[')[1].include?('Q') && s.deck[6,1]!='Q'
      m.push("#{s.stat_emotes[1]}A") if s.deck.split('[')[1].include?('A') && s.deck[6,1]!='A'
      m.push("#{s.stat_emotes[2]}B") if s.deck.split('[')[1].include?('B') && s.deck[6,1]!='B'
      m.reject!{|q| q==x}
      x="#{x} (changeable to #{m.join(' or ')})"
    end
    return x
  end
  
  def description(lvl=0,ignore='')
    for i in 0...@effects.length
      str="#{str}\n#{@effects[i].disp_str(lvl)}"
    end
    return str
  end
end

class FGOAppend < FGOSkill
  def initialize(val)
    @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
    @type='Append'
  end
  
  def description(lvl=0,ignore='')
    str=''
    for i in 0...@effects.length
      str="#{str}#{"\n" unless str.length<=0}#{@effects[i].disp_str(lvl)}"
    end
    return str
  end
  
  def disp_color(chain=0,mode=0)
    r=[8*chain,255].min
    g=[8*chain,255].min
    b=[160+16*chain,255].min
    return [0x400080] if chain<0
    return [r, g, b] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return 256*256*r+256*g+b
  end
end

# Secondary entities

class FGOCommandCode
  attr_accessor :id,:name
  attr_accessor :rarity
  attr_accessor :effect
  attr_accessor :comment
  attr_accessor :artist,:voice_jp
  
  def initialize(val)
    @id=val.to_i
  end
  
  def name=(val); @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def rarity=(val); @rarity=val.to_i; end
  def effect=(val); @effect=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def comment=(val); @comment=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def objt; return 'Command'; end
  def tid; return @id; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def disp_color(chain=0,mode=0)
    x=0x7D4529
    x=0x718F93 if @rarity>2
    x=0xF5D672 if @rarity>3
    f=[x]
    # Special colors
    xcolor=f[chain]
    xcolor=f[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
  
  def rarity_row
    str="<:FGO_icon_rarity_rust:676942902953377802>"*@rarity
    str="\u200B#{str}\u200B"
    str="**0-star**" if @rarity==0
    return str
  end
  
  def thumbnail(event,art=0)
    num="#{'0' if @id<100}#{'0' if @id<10}#{@id}"
    return "http://fate-go.cirnopedia.org/icons/ccode/ccode_#{num}.png"
  end
  
  def emoji(bot,event,mode=0,clrshift=0); return ''; end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse} [Cmd-#{@id}]#{fullformat.reverse}"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Command' || q[2]!=@id}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}** [Cmd-#{@id}]#{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class FGOMysticCode
  attr_accessor :name
  attr_accessor :acquisition
  attr_accessor :skills
  attr_accessor :exp
  attr_accessor :id
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def acquisition=(val); @acquisition=val.encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï',''); end
  def skills=(val); @skills=val; end
  def exp=(val); @exp=val.split(', ').map{|q| q.to_i}; end
  def objt; return 'Clothes'; end
  def tid; return 0; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def disp_color(chain=0,mode=0)
    x=0xF08000
    f=[x]
    # Special colors
    xcolor=f[chain]
    xcolor=f[0] if chain>=f.length
    return f if chain<0
    return [xcolor/256/256, (xcolor/256)%256, xcolor%256] if mode==1 # in mode 1, return as three single-channel numbers - used when averaging colors
    return xcolor
  end
  
  def thumbnail(event,art=0); return nil; end
  def emoji(bot,event,mode=0,clrshift=0); return ''; end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse}#{fullformat.reverse}"
  end
  
  def skill_bracket
    m=[]
    data_load(['skills'])
    skz=$skills.map{|q| q.clone}
    for i in 0...@skills.length
      x=skz.find_index{|q| q.type=='ClothingSkill' && q.fullName==@skills[i]}
      m.push(skz[x]) unless x.nil?
    end
    return m
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Clothes' || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}**#{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class FGOMat
  attr_accessor :name
  attr_accessor :value,:value2
  attr_accessor :id
  
  def initialize(val)
    @name=val
  end
  
  def value=(val); @value=val.to_i; end
  def value2=(val); @value2=val.to_i; end
  
  def emoji(bot,event,mode=0,forcemoji=false)
    unless mode==1
      return "#{@name} x#{@value}" if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats']) && !@value.nil? && !forcemoji
      return @name if has_any?(event.message.text.downcase.split(' '),['colorblind','colourblind','textmats']) && !forcemoji
    end
    m="#{@name}"
    moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    moji=bot.server(523830882453422120).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    moji=bot.server(523824424437415946).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    moji=bot.server(523825319916994564).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    moji=bot.server(523822789308841985).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    moji=bot.server(691616574393811004).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    m=moji[0].mention if moji.length>0
    m="#{m}#{@name}" if m != @name && mode==1
    return "#{m} **x#{longFormattedNumber(@value)}** (#{longFormattedNumber(@value+@value2)})" if mode==1 && @value2>0
    return "#{m} **x#{longFormattedNumber(@value)}**" if !@value.nil? && mode==1
    return "#{m}x#{longFormattedNumber(@value)}" unless @value.nil?
    return m
  end
  
  def thumbnail(event,bot)
    moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    moji=bot.server(523830882453422120).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    moji=bot.server(523824424437415946).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    moji=bot.server(523825319916994564).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    moji=bot.server(523822789308841985).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    moji=bot.server(691616574393811004).emoji.values.reject{|q| q.name.downcase != @name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return moji[0].icon_url if moji.length>0
    return nil
  end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def dispName(format='',fullformat='')
    return "#{fullformat}#{format}#{@name}#{format.reverse} [Srv-#{@id}]#{fullformat.reverse}"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Material' || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}**#{self.emoji(bot,true)}#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class FGOSupportServant
  attr_accessor :servant_id,:ce_id
  attr_accessor :owner,:nationality
  
  def initialize(val,owr,ntn='')
    val=val.split('\\'[0])
    @servant_id=val[0].to_i
    @ce_id=val[1].to_i
    @owner=owr
    @nationality='NA'
    @nationality='JP' if ntn=='j'
  end
  
  def servant_id=(val); @servant_id=val.to_i; end
  def ce_id=(val); @ce_id=val.to_i; end
  
  def disp_str(bot,event,pos=0)
    clzz=['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]
    if @servant_id==0
      str="~~**#{clzz}:** >Empty<~~"
    elsif @owner=='Mathoo'
      u=$dev_units.find_index{|q| q.id.to_i==@servant_id}
      u=$dev_units[u].clone
    else
      u=$donor_units.find_index{|q| q.id.to_i==@servant_id && q.owner==@owner}
      u2=$donor_units.find_index{|q| q.id.to_i==@servant_id && q.owner==@owner && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && @nationality=='JP'
      u=$donor_units[u].clone
    end
    unless u.nil?
      str=u.name
      str=u.name.gsub(" (#{clzz})",'') unless ['All','Extra'].include?(clzz)
      str="**#{clzz}:** #{str} [Srv-##{u.id}]#{u.emoji(bot,event,0,1)}"
      if safe_to_spam?(event)
        str="#{str}\n*NP#{u.np_level}*  \u00B7  "
        if u.skill_levels[3,3].map{|q| q.split('u')[0].to_i}.max==0
          str="#{str}*Skills:* #{u.skill_levels[0,3].join('/')}  \u00B7  "
        else
          str="#{str}*Actives:* #{u.skill_levels[0,3].join('/')}  \u00B7  *Appends:* #{u.skill_levels[3,3].join('/')}\n"
        end
        str="#{str}*Fous:* #{u.fous[0]} HP / #{u.fous[1]} Atk"
      end
    end
    return str unless safe_to_spam?(event,nil,1)
    c=$crafts.find_index{|q| q.id==@ce_id}
    str="#{str}\n*CE:* #{$crafts[c].name} [CE-##{$crafts[c].id}]" unless c.nil?
    return str
  end
end

class FGOSupport
  attr_accessor :owner,:owner_id
  attr_accessor :nationality
  attr_accessor :friend_code
  attr_accessor :lineup
  attr_accessor :color
  
  def initialize(val,owrid,nat='n')
    val=val.split('\\'[0])
    @owner=val[0]
    @owner_id=owrid
    @nationality='NA'
    @nationality='JP' if nat=='j'
    @friend_code=val[2].to_i
    @friend_code=val[3].to_i if @nationality=='JP'
    @color=val[1].hex
    @lineup=[]
  end
  
  def header
    str="**Friend Code:** #{longFormattedNumber(@friend_code)}\n**Server:** "
    str="#{str}North America" if @nationality=='NA'
    str="#{str}Japan" if @nationality=='JP'
    return str
  end
  
  def thumbnail(bot)
    return bot.user(@owner_id).avatar_url if !bot.user(@owner_id).nil?
    return ''
  end
  
  def title(bot)
    str="**#{@owner}**"
    str="#{str} (#{bot.user(@owner_id).name})" unless bot.user(@owner_id).nil? || bot.user(@owner_id).name==@owner
    str="\u{1F4A0}#{str}" if @owner=='Mathoo'
    str="<:Ace_Staff:875102524829478912>#{str}" if @owner=='Ace'
    return str
  end
  
  def disp_str(bot,event)
    str=''
    for i in 0...@lineup.length
      str="#{str}#{"\n" if str.length>0}#{"\n" if str.length>0 && safe_to_spam?(event)}#{@lineup[i].disp_str(bot,event,i)}"
    end
    return str
  end
  
  def storage_string; return @lineup.map{|q| "#{q.servant_id}\\#{q.ce_id}"}.join("\n"); end
end

class FEHUnit
  attr_accessor :name
  attr_accessor :artist,:voice_na,:voice_jp
  attr_accessor :id
  
  def initialize(val)
    @name=val
    @id=-1
  end
  
  def name=(val); @name=val; end
  def artist=(val); @artist=val; end
  def id=(val); @id=val; end
  def tid; return 0; end
  def objt2; return 'Z-FEH-Unit'; end
  
  def voice=(val)
    @voice_na=val[0] unless val[0].nil? || val[0].length<=0
    @voice_jp=val[1] unless val[1].nil? || val[1].length<=0
  end
end

class DLSentient
  attr_accessor :name
  attr_accessor :voice_na
  attr_accessor :voice_jp
  
  def initialize(val)
    @name=val
  end
  
  def voice_na=(val); @voice_na=val; end
  def voice_jp=(val); @voice_jp=val; end
  def tid; return 0; end
  def objt2; return 'Z-Z-DL'; end
end

class DLAdventurer < DLSentient; end
class DLDragon < DLSentient; end
class DL_NPC < DLSentient; end

class DLPrint
  attr_accessor :name
  attr_accessor :artist
  
  def initialize(val)
    @name=val
  end
  
  def artist=(val); @artist=val; end
  def tid; return 0; end
  def objt2; return 'Z-Z-DL'; end
end

def data_load(to_reload=[])
  to_reload=[to_reload] if to_reload.is_a?(String)
  reload_everything=false
  if has_any?(to_reload.map{|q| q.downcase},['everything','all'])
    reload_everything=true
    to_reload=[]
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['servant','servants'])
    $servants=[]
    if File.exist?("#{$location}devkit/FGOServants.txt")
      b=[]
      File.open("#{$location}devkit/FGOServants.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $servants=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGOServant.new(b[i][0])
      bob4.name=b[i][1]
      bob4.clzz=b[i][2]
      bob4.rarity=b[i][3]
      bob4.grow_curve=b[i][4]
      bob4.max_level=b[i][5]
      bob4.hp=b[i][6]
      bob4.atk=b[i][7]
      bob4.np_gain=b[i][8]
      bob4.hit_count=b[i][9]
      bob4.crit_star=b[i][10]
      bob4.death_rate=b[i][11]
      bob4.attribute=b[i][12]
      bob4.traits=b[i][13]
      bob4.actives=b[i][14]
      bob4.passives=b[i][15]
      bob4.np=b[i][16]
      bob4.deck=b[i][17]
      bob4.ascension_mats=b[i][18]
      bob4.skill_mats=b[i][19]
      bob4.availability=b[i][20]
      bob4.team_cost=b[i][21]
      bob4.alignment=b[i][22]
      bob4.bond_ce=b[i][23] unless b[i][23].nil?
      bob4.valentines_ce=b[i][26] unless b[i][26].nil?
      bob4.artist=b[i][24] unless b[i][24].nil?
      bob4.voice_jp=b[i][25] unless b[i][25].nil?
      bob4.alts=b[i][28] unless b[i][28].nil?
      bob4.costumes=b[i][29] unless b[i][29].nil?
      $servants.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['craft','crafts'])
    if File.exist?("#{$location}devkit/FGOCraftEssances.txt")
      b=[]
      File.open("#{$location}devkit/FGOCraftEssances.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $crafts=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGO_CE.new(b[i][0])
      bob4.name=b[i][1]
      bob4.rarity=b[i][2]
      bob4.cost=b[i][3]
      bob4.stats_1=b[i][4]
      bob4.stats_max=b[i][5]
      bob4.effect=[b[i][6],b[i][7]].uniq
      bob4.availability=b[i][8] unless b[i][8].nil?
      bob4.artist=b[i][9] unless b[i][9].nil?
      bob4.tags=b[i][10]
      bob4.servants=b[i][11] unless b[i][11].nil?
      bob4.comment=b[i][12] unless b[i][12].nil?
      $crafts.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['skill','skills','noble','np','nobles','nps'])
    if File.exist?("#{$location}devkit/FGOSkills.txt")
      b=[]
      File.open("#{$location}devkit/FGOSkills.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $skills=[]; $nobles=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if b[i][2]=='Noble'
        bob4=FGO_NP.new(b[i][0])
        bob4.id=b[i][1]
        bob4.subtitle=b[i][3]
        bob4.rank=b[i][4]
        bob4.type=b[i][5]
        bob4.target=b[i][6]
        bob4.tags=b[i][7]
        bob4.alt_name=b[i][8] unless b[i][8].nil? || b[i][8].length<=0
        bob4.effects=[]
        for i2 in 9...b[i].length
          unless b[i][i2].nil? || b[i][i2].length<=0 || b[i][i2]=='-' || b[i][i2].gsub(';; ','').length<=0
            m=FGOSubskill.new(b[i][i2])
            m.np_related=true
            bob4.effects.push(m.clone)
          end
        end
        $nobles.push(bob4.clone)
      elsif b[i][2]=='Skill'
        bob4=FGOActive.new(b[i][0])
        bob4.rank=b[i][1]
        bob4.cooldown=b[i][3]
        bob4.target=b[i][4]
        bob4.tags=b[i][5]
        bob4.effects=[]
        for i2 in 6...b[i].length
          unless b[i][i2].nil? || b[i][i2].length<=0 || b[i][i2]=='-'
            m=FGOSubskill.new(b[i][i2])
            bob4.effects.push(m.clone)
          end
        end
        $skills.push(bob4.clone)
      elsif b[i][2]=='Append'
        bob4=FGOAppend.new(b[i][0])
        bob4.tags=b[i][3]
        bob4.effects=[]
        for i2 in 4...b[i].length
          unless b[i][i2].nil? || b[i][i2].length<=0 || b[i][i2]=='-'
            m=FGOSubskill.new(b[i][i2])
            bob4.effects.push(m.clone)
          end
        end
        $skills.push(bob4.clone)
      elsif b[i][2]=='Passive'
        bob4=FGOPassive.new(b[i][0])
        bob4.rank=b[i][1]
        bob4.effects=b[i][3]
        bob4.tags=b[i][4] unless b[i][4].nil? || b[i][4].length<=0
        $skills.push(bob4.clone)
      elsif b[i][2]=='Clothes'
        bob4=FGOClothingSkill.new(b[i][0])
        bob4.cooldown=b[i][1]
        bob4.tags=b[i][3]
        bob4.effects=[]
        for i2 in 4...b[i].length
          unless b[i][i2].nil? || b[i][i2].length<=0 || b[i][i2]=='-'
            m=FGOSubskill.new(b[i][i2])
            bob4.effects.push(m.clone)
          end
        end
        $skills.push(bob4.clone)
      end
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['command','commandcode','commands','commandcodes'])
    if File.exist?("#{$location}devkit/FGOCommandCodes.txt")
      b=[]
      File.open("#{$location}devkit/FGOCommandCodes.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $codes=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGOCommandCode.new(b[i][0])
      bob4.name=b[i][1]
      bob4.rarity=b[i][2]
      bob4.effect=b[i][3]
      bob4.comment=b[i][4] unless b[i][4].nil? || b[i][4].length<=0
      $codes.push(bob4.clone)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['mystic','mysticcode','mystics','mysticcodes','clothing','clothes'])
    if File.exist?("#{$location}devkit/FGOClothes.txt")
      b=[]
      File.open("#{$location}devkit/FGOClothes.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $clothes=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGOMysticCode.new(b[i][0])
      bob4.acquisition=b[i][1]
      bob4.skills=b[i][2,3]
      bob4.exp=b[i][5]
      $clothes.push(bob4.clone)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['mat','mats','materials','material'])
    x=$servants.map{|q| [q.skill_mats,q.ascension_mats].flatten.map{|q2| q2.split(' ')}.map{|q2| q2[0,q2.length-1].join(' ')}}.flatten.uniq.sort
    $mats=[]
    for i in 0...x.length
      $mats.push(FGOMat.new(x[i]))
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['devunits','devservants'])
    # DEV UNIT DATA
    if File.exist?("#{$location}devkit/FGODevServants.txt")
      b=[]
      File.open("#{$location}devkit/FGODevServants.txt").each_line do |line|
        b.push(line.gsub("\n",''))
      end
    else
      b=[]
    end
    $dev_units=[]
    b=b.join("\n").split("\n\n")
    b.shift
    b.shift
    b=b.map{|q| q.split("\n").map{|q2| q2.split(' # ')[0]}}
    for i in 0...b.length
      bob4=DevServant.new(b[i][0])
      bob4.fous=b[i][1]
      bob4.codes=b[i][2]
      bob4.skill_levels=b[i][3]
      bob4.np_level=b[i][4]
      bob4.ce_equip=b[i][5]
      bob4.bond_level=b[i][6]
      bob4.ascend=b[i][7]
      $dev_units.push(bob4.clone)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['donorunits','donorservants'])
    d=Dir["#{$location}devkit/LizUserSaves/*.txt"]
    $donor_units=[]
    $donor_triggers=[]
    for i in 0...d.length
      b=[]
      File.open(d[i]).each_line do |line|
        b.push(line.gsub("\n",''))
      end
      d[i]=d[i].gsub("#{$location}devkit/LizUserSaves/",'').gsub('.txt','').to_i
      if get_donor_list().reject{|q| q[2][1]<4}.map{|q| q[0]}.include?(d[i])
        owr="#{b[0]}"
        $donor_triggers.push([owr.split('\\'[0])[0],d[i],owr.split('\\'[0])[1]])
        b=b.join("\n").split("\n\n")
        b.shift; b.shift; b.shift
        b=b.map{|q| q.split("\n").map{|q2| q2.split(' # ')[0]}}
        for i2 in 0...b.length
          bob4=DonorServant.new(b[i2][0],owr,d[i])
          bob4.fous=b[i2][1]
          bob4.codes=b[i2][2]
          bob4.skill_levels=b[i2][3]
          bob4.np_level=b[i2][4]
          bob4.ce_equip=b[i2][5]
          bob4.bond_level=b[i2][6]
          bob4.ascend=b[i2][7]
          $donor_units.push(bob4.clone)
        end
      end
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['support','supports','lineups'])
    # DEV UNIT DATA
    $support_lineups=[]
    if File.exist?("#{$location}devkit/FGODevServants.txt")
      b=[]
      File.open("#{$location}devkit/FGODevServants.txt").each_line do |line|
        b.push(line.gsub("\n",''))
      end
    else
      b=[]
    end
    b=b.join("\n").split("\n\n")
    m="Mathoo\\0x00DAFA\\#{b[0]}"
    b[1]=b[1].split("\n")
    bob4=FGOSupport.new(m,167657750971547648,'n')
    for i in 0...b[1].length
      bob4.lineup.push(FGOSupportServant.new(b[1][i],'Mathoo','n'))
    end
    $support_lineups.push(bob4.clone)
    d=Dir["#{$location}devkit/LizUserSaves/*.txt"]
    for i in 0...d.length
      b=[]
      File.open(d[i]).each_line do |line|
        b.push(line.gsub("\n",''))
      end
      d[i]=d[i].gsub("#{$location}devkit/LizUserSaves/",'').gsub('.txt','').to_i
      if get_donor_list().reject{|q| q[2][1]<4}.map{|q| q[0]}.include?(d[i])
        b=b.join("\n").split("\n\n")
        unless b[1].gsub('\\'[0],'').gsub("\n",'').gsub('0','').length<=0 # North American lineup
          b[1]=b[1].split("\n")
          bob4=FGOSupport.new(b[0],d[i],'n')
          for i2 in 0...b[1].length
            bob4.lineup.push(FGOSupportServant.new(b[1][i2],b[0].split('\\'[0])[0],'n'))
          end
          $support_lineups.push(bob4.clone)
        end
        unless b[2].gsub('\\'[0],'').gsub("\n",'').gsub('0','').length<=0 # Japanese lineup
          b[2]=b[2].split("\n")
          bob4=FGOSupport.new(b[0],d[i],'j')
          for i2 in 0...b[2].length
            bob4.lineup.push(FGOSupportServant.new(b[2][i2],b[0].split('\\'[0])[0],'j'))
          end
          $support_lineups.push(bob4.clone)
        end
      end
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['libraries','library','librarys'])
    rtime=5
    rtime=1 if Shardizard==4
    rtime=60 if to_reload.length<=0
    t=Time.now
    if t-$last_multi_reload[0]>rtime*60
      puts 'reloading LizClassFunctions'
      load "#{$location}devkit/LizClassFunctions.rb"
      $last_multi_reload[0]=t
    end
  end
  if has_any?(to_reload.map{|q| q.downcase},['feh','unit','units'])
    # UNIT DATA
    if File.exist?("#{$location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{$location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $feh_units=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FEHUnit.new(b[i][0])
      bob4.artist=b[i][6].split(';; ') if b[i][6].length>0
      bob4.voice=b[i][7].split(';; ') if b[i][7].length>0
      bob4.id=b[i][8].to_i
      $feh_units.push(bob4) if b[i][13].nil?
    end
  end
  if has_any?(to_reload.map{|q| q.downcase},['dl','dragalia','adventurer','adventurers','wyrm','wyrms','print','prints'])
    $dl_adventurers=[]
    if File.exist?("#{$location}devkit/DLAdventurers.txt")
      b=[]
      File.open("#{$location}devkit/DLAdventurers.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLAdventurer.new(b[i][0])
      bob4.voice_na=b[i][11] unless b[i][11].nil?
      bob4.voice_jp=b[i][10] unless b[i][10].nil?
      $dl_adventurers.push(bob4)
    end
    $dl_dragons=[]
    if File.exist?("#{$location}devkit/DLDragons.txt")
      b=[]
      File.open("#{$location}devkit/DLDragons.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLDragon.new(b[i][0])
      bob4.voice_na=b[i][14] unless b[i][14].nil?
      bob4.voice_jp=b[i][13] unless b[i][13].nil?
      $dl_dragons.push(bob4)
    end
    $dl_npcs=[]
    if File.exist?("#{$location}devkit/DL_NPCs.txt")
      b=[]
      File.open("#{$location}devkit/DL_NPCs.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DL_NPC.new(b[i][0])
      bob4.voice_na=b[i][3] unless b[i][3].nil?
      bob4.voice_jp=b[i][4] unless b[i][4].nil?
      $dl_npcs.push(bob4)
    end
    $dl_wyrmprints=[]
    if File.exist?("#{$location}devkit/DLWyrmprints.txt")
      b=[]
      File.open("#{$location}devkit/DLWyrmprints.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLPrint.new(b[i][0])
      bob4.artist=b[i][7] unless b[i][7].nil?
      $dl_wyrmprints.push(bob4)
    end
  end
end

def prefixes_save()
  x=@prefixes
  open("#{$location}devkit/FGOPrefix.rb", 'w') { |f|
    f.puts x.to_s.gsub('=>',' => ').gsub(', ',",\n  ").gsub('{',"@prefixes = {\n  ").gsub('}',"\n}")
  }
end

def donate_trigger_word(event,str=nil)
  str=event.message.text if str.nil?
  str=str.downcase
  data_load(['donorunits'])
  b=$donor_triggers.map{|q| q}
  for i in 0...b.length
    return b[i][1] if str.split(' ').include?("#{b[i][0].downcase}'s")
    return b[i][1] if event.user.id==b[i][1] && str.split(' ').include?('my')
  end
  return 0
end

def metadata_load()
  if File.exist?("#{$location}devkit/FGOSave.txt")
    b=[]
    File.open("#{$location}devkit/FGOSave.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[[168592191189417984, 256379815601373184],[],[[0,0,0,0,0],[0,0,0,0,0]],[]]
  end
  $embedless=b[0]
  $embedless=[168592191189417984, 256379815601373184] if $embedless.nil?
  $ignored=b[1]
  $ignored=[] if $ignored.nil?
  $server_data=b[2]
  $server_data=[[0,0,0,0,0],[0,0,0,0,0]] if $server_data.nil?
  if $server_data[0].length<Shards+1
    for i in 0...Shards+1
      $server_data[0][i]=0 if $server_data[0][i].nil?
    end
  end
  if $server_data[1].length<Shards+1
    for i in 0...Shards+1
      $server_data[1][i]=0 if $server_data[1][i].nil?
    end
  end
  $spam_channels=b[3]
  $spam_channels=[[],[]] if $spam_channels.nil?
end

def metadata_save()
  if $server_data[0].length<Shards+1
    for i in 0...Shards+1
      $server_data[0][i]=0 if $server_data[0][i].nil?
    end
  end
  if $server_data[1].length<Shards+1
    for i in 0...Shards+1
      $server_data[1][i]=0 if $server_data[1][i].nil?
    end
  end
  x=[$embedless.map{|q| q}, $ignored.map{|q| q}, $server_data.map{|q| q}, $spam_channels.map{|q| q}]
  open("#{$location}devkit/FGOSave.txt", 'w') { |f|
    f.puts x[0].to_s
    f.puts x[1].to_s
    f.puts x[2].to_s
    f.puts x[3].to_s
    f.puts "\n"
  }
  data_load()
  k=$servants.map{|q| "#{q.ascension_mats.join("\n")}\n#{q.skill_mats.join("\n")}"}.join("\n").split("\n").map{|q| q.split(' ')}
  for i in 0...k.length
    k[i].pop
  end
  k=k.map{|q| q.join(' ')}.uniq.sort
  open("#{$location}devkit/FGOMats.txt", 'w') { |f|
    f.puts k.join("\n")
    f.puts "\n"
  }
end

def nicknames_load(mode=1)
  if mode==2 && File.exist?("#{$location}devkit/FGONames2.txt")
    b=[]
    File.open("#{$location}devkit/FGONames2.txt").each_line do |line|
      b.push(eval line)
    end
    return b
  elsif File.exist?("#{$location}devkit/FGONames.txt")
    b=[]
    File.open("#{$location}devkit/FGONames.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  $aliases=b.reject{|q| q.nil? || q[1].nil? || q[2].nil?}.uniq
end

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['restorealiases','cleanupaliases','statssquashed','squashedstats','serveraliases','noblephantasm','backupaliases','valentinesce','today_in_fgo','statsquashed','squashedstat','spamchannels','aliases',
     'craftessence','craftessance','command_list','checkaliases','cevalentines','valentinece','statslittle','sortaliases','sendmessage','resistances','removealias','longreplies','littlestats','affinitys',
     'leaveserver','enhancement','deletealias','commandlist','commandcode','channellist','cevalentine','valentines','todayinfgo','suggestion','statssmall','statsmicro','statlittle','smallstats','celevel',
     'seealiases','safetospam','resistance','mysticcode','microstats','littlestat','ignoreuser','channelist','affinities','valentine','tommorrow','tinystats','statstiny','statssmol','statsmall','clothes',
     'statmicro','snagstats','smolstats','smallstat','safe2spam','resources','mysticode','microstat','materials','effective','chocolate','bugreport','attribute','ascension','tomorrow','tinystat','artist',
     'supports','stattiny','statsmol','squashed','spamlist','smolstat','schedule','saliases','resource','phantasm','material','feedback','donation','dev_edit','clothing','affinity','addalias','alt','art',
     'tomorow','support','servant','profile','pllevel','friends','essence','essance','enhance','dailies','command','update','traits','status','statss','sstats','slevel','skills','sendpm','search','alias',
     'resist','reboot','random','prefix','plevel','mystic','lookup','little','invite','friend','donate','clevel','bondce','avatar','trait','tools','today','stats','sstat','small','skils','shard','reload',
     'plexp','noble','micro','links','level','daily','craft','ceexp','avvie','unit','tool','tiny','stat','spam','sort','smol','skil','sexp','safe','riyo','rand','plxp','pexp','next','mats','ce','xp','np',
     'long','list','link','help','find','edit','deck','data','code','cexp','boop','bond','sxp','srv','res','pxp','now','mat','exp','eff','cxp','alts']
  k=['addalias','deletealias','removealias','prefix'] if permissions==1
  k=['sortaliases','status','sendmessage','sendpm','leaveserver','cleanupaliases','backupaliases','reboot','snagchannels','devedit','dev_edit','reload','update'] if permissions==2
  k.push(nil) if include_nil
  return k
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Liz
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'FGO!reboot'
  exec "cd #{$location}devkit && LizBot.rb.rb #{Shardizard}"
end

bot.command(:help, aliases: [:command_list,:commandlist]) do |event, command, subcommand, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  help_text(event,bot,command,subcommand,args)
end

def overlap_prevent(event) # used to prevent servers with both Liz and her debug form from receiving two replies
  if event.server.nil? # failsafe code catching PMs as not a server
    return false
  elsif event.message.text.downcase.split(' ').include?('debug') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id)
    return Shardizard != 4 # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id) # emoji servers will use default Elise otherwise
    return Shardizard == 4
  end
  return false
end

def safe_to_spam?(event,chn=nil,mode=0) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return false if event.user.id==213048998678888448
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,877171831835066391].include?(event.server.id) # it is safe to spam in the emoji servers
  chn=event.channel if chn.nil?
  return false if event.message.text.downcase.split(' ').include?('semi') && mode==0 && Shardizard==4
  return false if event.message.text.downcase.split(' ').include?('semi') && mode==0 && chn.id==502288368777035777
  return false if event.message.text.downcase.split(' ').include?('smol') && Shardizard==4
  return false if event.message.text.downcase.split(' ').include?('smol') && chn.id==502288368777035777
  return true if Shardizard==4
  return true if ['bots','bot'].include?(chn.name.downcase) # channels named "bots" are safe to spam in
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('spam') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('command') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('channel') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('lizbot')  # it is safe to spam in channels designed specifically for LizBot
  return true if chn.name.downcase.include?('liz-bot')
  return true if chn.name.downcase.include?('liz_bot')
  return true if $spam_channels[0].include?(chn.id)
  return false if mode==0
  return true if chn.name.downcase.include?('fate') && chn.name.downcase.include?('grand') && chn.name.downcase.include?('order')
  return true if chn.name.downcase.include?('fate') && chn.name.downcase.include?('go')
  return true if chn.name.downcase.include?('fgo')
  return true if $spam_channels[1].include?(chn.id)
  return false
end

def numabr(n)
  return "#{n/1000000000000}tril" if n>=1000000000000 && n%1000000000000==0
  return "#{n.to_f/1000000000000}tril" if n>=1000000000000
  return "#{n/1000000000}bil" if n>=1000000000 && n%1000000000==0
  return "#{n.to_f/1000000000}bil" if n>=1000000000
  return "#{n/1000000}mil" if n>=1000000 && n%1000000==0
  return "#{n.to_f/1000000}mil" if n>=1000000
  return "#{n/1000}k" if n>=1000 && n%1000==0
  return "#{n.to_f/1000}k" if n>=1000
  return n
end

def spaceship_order(x)
  return 1 if x=='Servant'
  return 2 if x=='Craft'
  return 3 if x=='Command'
  return 4 if x=='Clothes'
  return 5 if x=='Active'
  return 6 if x=='Passive'
  return 7 if x=='Append'
  return 8 if x=='ClothingSkill'
  return 9 if x=='Skill'
  return 10 if x=='Material'
  return 1300
end

def log_channel
  return 431862993194582036 if Shardizard==4
  return 502288368777035777
end

def find_data_ex(callback,name,event,fullname=false,buffer=nil,buffer2=nil,includematch=false)
  if buffer2.nil?
    k=method(callback).call(name,event,true,buffer)
  else
    k=method(callback).call(name,event,true,buffer,buffer2)
  end
  return [k,name] if !k.nil? && includematch
  return k unless k.nil?
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      if buffer2.nil?
        k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true,buffer)
      else
        k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true,buffer,buffer2)
      end
      return [k,args[i,args.length-i-i2].join(' ')] if !k.nil? && args[i,args.length-i-i2].length>0 && includematch
      return k if !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  return nil if fullname || name.length<=2
  if buffer2.nil?
    k=method(callback).call(name,event,false,buffer)
  else
    k=method(callback).call(name,event,false,buffer,buffer2)
  end
  return [k,name] if !k.nil? && includematch
  return k unless k.nil?
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      if buffer2.nil?
        k=method(callback).call(args[i,args.length-i-i2].join(' '),event,false,buffer)
      else
        k=method(callback).call(args[i,args.length-i-i2].join(' '),event,false,buffer,buffer2)
      end
      return [k,args[i,args.length-i-i2].join(' ')] if !k.nil? && args[i,args.length-i-i2].length>0 && includematch
      return k if !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  return nil
end

def find_best_match(name,bot,event,fullname=false,ext=false,mode=1)
  #            base item     default behavior    art command   code command
  functions=[[:find_servant,:disp_servant_all,  ''],
             [:find_ce,     :disp_ce_card,      ''],
             [:find_skill,  :disp_skill_data],
             [:find_clothes,:disp_clothing_data,nil,           :disp_clothing_data],
             [:find_code,   :disp_code_data,    '',            :disp_code_data],
             [:find_mat,    :disp_mat_data]]
  functions=functions.reject{|q| q[mode].nil?} if mode>0
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,true,ext)
    k=nil if k.is_a?(Array) && k.length<=0
    return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      for i3 in 0...functions.length
        k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,true,ext)
        k=nil if k.is_a?(Array) && k.length<=0
        return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
        return method(functions[i3][mode]).call(bot,event,args,ext) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
      end
    end
  end
  event.respond 'No matches found.' if (fullname || name.length<=2) && mode>1 && !functions[0][mode].is_a?(String)
  return nil if fullname || name.length<=2
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,false,ext)
    k=nil if k.is_a?(Array) && k.length<=0
    return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      k=nil if k.is_a?(Array) && k.length<=0
      return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
      return method(functions[i3][mode]).call(bot,event,args,ext) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  event.respond 'No matches found.' unless functions[0][mode].is_a?(String) || mode==0
  return nil
end

def find_thing(thing,xname,event,fullname=false,ext=false)
  data_load()
  xname=normalize(xname)
  if thing=='Servant'
    unless ext
      if xname.to_i.to_s==xname && xname.to_i<=$servants[-1].id && xname.to_i>0
        return $servants[$servants.find_index{|q| q.id==xname.to_i}]
      elsif xname.to_f.to_s==xname && (xname.to_f<2 || xname.to_i==81)
        return $servants[$servants.find_index{|q| q.id==xname.to_f}]
      end
    end
    if xname[0,1]=='#'
      xname2=xname[1,xname.length-1]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$servants[-1].id
        return $servants[$servants.find_index{|q| q.id==xname2.to_i}]
      elsif xname2.to_f.to_s==xname2 && (xname2.to_f<2 || xname2.to_i==81)
        return $servants[$servants.find_index{|q| q.id==xname2.to_f}]
      end
    elsif xname[0,5].downcase=='srv-#' || xname.downcase[0,5]=='srv_#'
      xname2=xname[5,xname.length-5]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$servants[-1].id
        return $servants[$servants.find_index{|q| q.id==xname2.to_i}]
      elsif xname2.to_f.to_s==xname2 && (xname2.to_f<2 || xname2.to_i==81)
        return $servants[$servants.find_index{|q| q.id==xname2.to_f}]
      end
    elsif ['srv-','srv_','srv#'].include?(xname[0,4].downcase)
      xname2=xname[4,xname.length-4]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$servants[-1].id
        return $servants[$servants.find_index{|q| q.id==xname2.to_i}]
      elsif xname2.to_f.to_s==xname2 && (xname2.to_f<2 || xname2.to_i==81)
        return $servants[$servants.find_index{|q| q.id==xname2.to_f}]
      end
    elsif xname[0,3].downcase=='srv'
      xname2=xname[3,xname.length-3]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$servants[-1].id
        return $servants[$servants.find_index{|q| q.id==xname2.to_i}]
      elsif xname2.to_f.to_s==xname2 && (xname2.to_f<2 || xname2.to_i==81)
        return $servants[$servants.find_index{|q| q.id==xname2.to_f}]
      end
    end
  elsif thing=='Craft'
    if xname.to_i.to_s==xname && xname.to_i<=$servants[-1].id && xname.to_i>0 && !ext
      return nil
    elsif xname.to_i.to_s==xname && xname.to_i<=$crafts[-1].id && xname.to_i>0
      return $crafts[$crafts.find_index{|q| q.id==xname.to_f}]
    end
    if xname[0,1]=='#'
      xname2=xname[1,xname.length-1]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$servants[-1].id && xname2.to_i>0 && !ext
        return nil
      elsif xname2.to_i.to_s==xname2 && xname2.to_i<=$crafts[-1].id && xname2.to_i>0
        return $crafts[$crafts.find_index{|q| q.id==xname2.to_f}]
      end
    elsif xname[0,4].downcase=='ce-#' || xname[0,4].downcase=='ce_#'
      xname2=xname[4,xname.length-4]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$crafts[-1].id && xname2.to_i>0
        return $crafts[$crafts.find_index{|q| q.id==xname2.to_f}]
      end
    elsif ['ce-','ce_','ce#'].include?(xname[0,3].downcase)
      xname2=xname[3,xname.length-3]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$crafts[-1].id && xname2.to_i>0
        return $crafts[$crafts.find_index{|q| q.id==xname2.to_f}]
      end
    elsif xname[0,2].downcase=='ce'
      xname2=xname[2,xname.length-2]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$crafts[-1].id && xname2.to_i>0
        return $crafts[$crafts.find_index{|q| q.id==xname2.to_f}]
      end
    end
  elsif thing=='Command'
    if xname.to_i.to_s==xname && xname.to_i<=$codes[-1].id && xname.to_i>0
      return $codes[$codes.find_index{|q| q.id==xname.to_i}]
    end
    if xname[0,1]=='#'
      xname2=xname[1,xname.length-1]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$codes[-1].id && xname2.to_i>0
        return $codes[$codes.find_index{|q| q.id==xname2.to_i}]
      end
    elsif xname[0,5].downcase=='cmd-#' || xname[0,5].downcase=='cmd_#'
      xname2=xname[5,xname.length-5]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$codes[-1][0] && xname2.to_i>0
        return $codes[$codes.find_index{|q| q.id==xname2.to_i}]
      end
    elsif ['cmd-','cmd_','cmd#'].include?(xname[0,4].downcase)
      xname2=xname[4,xname.length-4]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$codes[-1][0] && xname2.to_i>0
        return $codes[$codes.find_index{|q| q.id==xname2.to_i}]
      end
    elsif xname[0,3].downcase=='cmd'
      xname2=xname[3,xname.length-3]
      if xname2.to_i.to_s==xname2 && xname2.to_i<=$codes[-1][0] && xname2.to_i>0
        return $codes[$codes.find_index{|q| q.id==xname2.to_i}]
      end
    end
  elsif thing=='Skill'
    sklz=$skills.map{|q| q}
    return sklz.reject{|q| q.name[0,17]!='Primordial Rune ('} if xname=='primordialrune'
    return sklz.reject{|q| q.name !='Innocent Monster' || q.rank[0,2]!='EX'} if xname=='innocentmonsterex'
    return sklz.reject{|q| q.name !='Whim of the Goddess' || q.rank[0,1]!='A'} if xname=='whimofthegoddessa'
  end
  list=[]
  list=$servants.map{|q| q} if thing=='Servant'
  list=$skills.map{|q| q} if thing=='Skill'
  list=$crafts.map{|q| q} if thing=='Craft'
  list=$codes.map{|q| q} if thing=='Command'
  list=$enemies.map{|q| q} if thing=='Enemy'
  list=$clothes.map{|q| q} if thing=='Clothes'
  list=$mats.map{|q| q} if thing=='Material'
  data_load(['feh']) if thing=='FEH'
  list=$feh_units.map{|q| q} if thing=='FEH'
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xname.length<2
  k=list.find_index{|q| q.fullName.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return list[k] unless k.nil? || thing=='Skill'
  return [list[k]] unless k.nil?
  k=list.find_index{|q| q.fullName.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="the#{xname}" && q.name[0,4].downcase=='the '}
  return list[k] unless k.nil? || thing=='Skill'
  return [list[k]] unless k.nil?
  k=list.find_index{|q| q.fullName.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="a#{xname}" && q.name[0,2].downcase=='a '}
  return list[k] unless k.nil? || thing=='Skill'
  return [list[k]] unless k.nil?
  k=list.find_index{|q| q.fullName.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="an#{xname}" && q.name[0,3].downcase=='an '}
  return list[k] unless k.nil? || thing=='Skill'
  return [list[k]] unless k.nil?
  if thing=='Command'
    k=list.find_index{|q| q.name.downcase.gsub('code: ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && q.name[0,3].downcase=='code: '}
    return list[k] unless k.nil?
  elsif thing=='Material'
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "#{q.name.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Magic #{q.name.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Secret #{q.name.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "#{q.name.gsub('Secret Gem of ','')} Cookie".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "Blue #{q.name.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Red #{q.name.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Yellow #{q.name.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "Blue Gem of #{q.name.gsub('Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Red Gem of #{q.name.gsub('Magic Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Yellow Gem of #{q.name.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Cookie of #{q.name.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
    return $mats[k] unless k.nil?
  end
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!=thing}.map{|q| [q[1],q[2],q[3]]}
  alz=$aliases.reject{|q| !['Active','Append','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]} if thing=='Skill'
  g=0
  g=event.server.id unless event.server.nil?
  if thing=='FEH'
    if File.exist?("C:/Users/#{@mash}/Desktop/devkit/FEHNames.txt")
      alz=[]
      File.open("C:/Users/#{@mash}/Desktop/devkit/FEHNames.txt").each_line do |line|
        alz.push(eval line)
      end
    else
      alz=[]
    end
    alz.reject!{|q| !q[3].nil? && !q[3].include?(g)}; alz.reject!{|q| q[0]!='Unit' || q[2].is_a?(Array)}; alz.reject!{|q| q[2].is_a?(String) || q[2]<1}; alz=alz.map{|q| [q[1],q[2],q[3]]}
  end
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil? || alz[k][1].is_a?(String)
  return list[list.find_index{|q| q.fullName==alz[k][1]}] unless k.nil? || thing=='Skill'
  return [list[list.find_index{|q| q.fullName==alz[k][1]}]] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil? || alz[k][1].is_a?(String)
  return list[list.find_index{|q| q.fullName==alz[k][1]}] unless k.nil? unless k.nil? || thing=='Skill'
  return [list[list.find_index{|q| q.fullName==alz[k][1]}]] unless k.nil?
  return nil if fullname || xname.length<=2
  return list.reject{|q| q.name[0,17]!='Primordial Rune ('} if thing=='Skill' && xname=='primordialrune'[0,xname.length]
  k=list.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return list[k] unless k.nil? || thing=='Skill'
  return list.reject{|q| q.name != list[k].name || q.objt != list[k].objt} unless k.nil?
  k=list.find_index{|q| q.name.downcase.gsub('the ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q.name[0,4].downcase=='the '}
  return list[k] unless k.nil? || thing=='Skill'
  return list.reject{|q| q.name != list[k].name || q.objt != list[k].objt} unless k.nil?
  k=list.find_index{|q| q.name.downcase.gsub('a ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q.name[0,2].downcase=='a '}
  return list[k] unless k.nil? || thing=='Skill'
  return list.reject{|q| q.name != list[k].name || q.objt != list[k].objt} unless k.nil?
  k=list.find_index{|q| q.name.downcase.gsub('an ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q.name[0,3].downcase=='an '}
  return list[k] unless k.nil? || thing=='Skill'
  return list.reject{|q| q.name != list[k].name || q.objt != list[k].objt} unless k.nil?
  if thing=='Command'
    k=list.find_index{|q| q.name.downcase.gsub('code: ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q.name[0,3].downcase=='code: '}
    return list[k] unless k.nil?
  elsif thing=='Material'
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "#{q.name.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Magic #{q.name.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Secret #{q.name.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "#{q.name.gsub('Secret Gem of ','')} Cookie".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "Blue #{q.name.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Red #{q.name.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Yellow #{q.name.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,7]=='Gem of ' && "Blue Gem of #{q.name.gsub('Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,13]=='Magic Gem of ' && "Red Gem of #{q.name.gsub('Magic Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Yellow Gem of #{q.name.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
    k=$mats.find_index{|q| q.name[0,14]=='Secret Gem of ' && "Cookie of #{q.name.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
    return $mats[k] unless k.nil?
  end
  if thing=='Servant'
    for i in xname.length...alz.map{|q| q[0].length}.max
      k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
      return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil?
      k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
      return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil?
    end
  else
    k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
    return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil? || alz[k][1].is_a?(String)
    return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || thing=='Skill'
    return list.reject{|q| q.name != alz[k][1]} unless k.nil?
    k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
    return list[list.find_index{|q| q.id==alz[k][1]}] unless k.nil? || alz[k][1].is_a?(String)
    return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || thing=='Skill'
    return list.reject{|q| q.name != alz[k][1]} unless k.nil?
  end
  return nil
end

def find_servant(xname,event,fullname=false,ignoreid=false); return find_thing('Servant',xname,event,fullname,ignoreid); end
def find_ce(xname,event,fullname=false,ext=nil); return find_thing('Craft',xname,event,fullname,ext); end
def find_skill(xname,event,fullname=false,ext=nil); return find_thing('Skill',xname,event,fullname); end
def find_code(xname,event,fullname=false,ext=nil); return find_thing('Command',xname,event,fullname); end
def find_enemy(xname,event,fullname=false,ext=nil); return find_thing('Enemy',xname,event,fullname); end
def find_clothes(xname,event,fullname=false,ext=nil); return find_thing('Clothes',xname,event,fullname); end
def find_mat(xname,event,fullname=false,ext=nil); return find_thing('Material',xname,event,fullname); end
def find_FEH_unit(xname,event,fullname=false,bot=nil)
  return nil if !event.server.nil? && bot.user(312451658908958721).on(event.server.id).nil? && bot.user(627511537237491715).on(event.server.id).nil? && Shardizard !=4
  return find_thing('FEH',xname,event,fullname)
end

def find_emote(bot,event,item,mode=0,forcemoji=false)
  k2=event.message.text.downcase.split(' ')
  f=$mats.find_index{|q| q.name.downcase.gsub(' ','_').gsub('-','').gsub("'",'')==item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
  return '' if f.nil?
  return $mats[f].emoji(bot,event,0,true)
end

def add_new_alias(bot,event,newname,unit,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if !event.server.nil? && event.server.id==363917126978764801
    str="You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra."
    err=true
  elsif newname.nil? || unit.nil?
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, Append, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that object"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,78649866577780736].include?(event.user.id)) && event.channel.id != 532083509083373583
    str='You are not a mod.'
    err=true
  elsif newname.include?('"') || unit.include?('"')
    str='Full stop.  " is not allowed in an alias.'
    err=true
  elsif newname.include?("\n") || unit.include?("\n")
    str="Newlines aren't allowed in aliases"
    err=true
  end
  if err
    event.respond str if str.length>0 && mode==0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_aliases(event,args,bot) if mode==1
    return nil
  end
  str=''
  type=['Alias','Alias']
  matches=[0,0]
  matchnames=['','']
  newname=newname.gsub('!','').gsub('(','').gsub(')','').gsub('_','')
  k=find_best_match(newname,bot,event,true,false,0)
  if k.nil? || (k.is_a?(Array) && k[0].nil?)
    k=find_best_match(newname,bot,event,false,false,0)
    unless k.nil?
      k=k[0] if k.is_a?(Array)
      type[0]="#{k.objt}*"
      matches[0]=k.fullName
      matches[0]=k.id unless k.id.nil?
      matchnames[0]="#{k.dispName} #{k.emoji(bot,event)}"
    end
  else
    k=k[0] if k.is_a?(Array)
    type[0]="#{k.objt}"
    matches[0]=k.fullName
    matches[0]=k.id unless k.id.nil?
    matchnames[0]="#{k.dispName} #{k.emoji(bot,event)}"
  end
  unit=unit.gsub('!','').gsub('(','').gsub(')','').gsub('_','')
  k2=find_best_match(unit,bot,event,true,false,0)
  if k2.nil? || (k2.is_a?(Array) && k2[0].nil?)
    k2=find_best_match(unit,bot,event,false,false,0)
    unless k2.nil?
      k2=k2[0] if k2.is_a?(Array)
      type[1]="#{k2.objt}*"
      matches[1]=k2.fullName
      matches[1]=k2.id unless k2.id.nil?
      matchnames[1]="#{k2.dispName} #{k2.emoji(bot,event)}"
    end
  else
    k2=k2[0] if k2.is_a?(Array)
    type[1]="#{k2.objt}"
    matches[1]=k2.fullName
    matches[1]=k2.id unless k2.id.nil?
    matchnames[1]="#{k2.dispName} #{k2.emoji(bot,event)}"
  end
  checkstr=normalize(newname,true)
  if type.reject{|q| q != 'Alias'}.length<=0
    type[0]='Alias' if type[0].include?('*')
    type[1]='Alias' if type[1].include?('*') && type[0]!='Alias'
  end
  if type.reject{|q| q=='Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, Append, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nNeither #{newname} nor #{unit} is any of the above."
    err=true
  elsif type.reject{|q| q != 'Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    x=['a','a']
    x[0]='a piece of' if ['clothes'].include?(type[0].downcase)
    x[1]='a piece of' if ['clothes'].include?(type[1].downcase)
    x[0]='an' if ['active','append'].include?(type[0].downcase)
    x[1]='an' if ['active','append'].include?(type[1].downcase)
    str="#{alz1} is #{x[0]} #{type[0].downcase}\n#{alz2} is #{x[1]} #{type[1].downcase}"
    err=true
  end
  if type[1]=='Alias' && type[0]!='Alias'
    f="#{newname}"
    newname="#{unit}"
    unit="#{f}"
    type=type.reverse.map{|q| q.gsub('*','')}
    matches.reverse!
    matchnames.reverse!
    kk1=k2
    kk2=k
  else
    kk1=k
    kk2=k2
    type=type.map{|q| q.gsub('*','')}
  end
  if newname.include?("\\u{")
    err=true
    str="#{newname} contains an Extended Unicode character (a character with a Unicode ID beyond 65,535, almost all of which are emoji).\nDue to the way I store aliases and how Ruby parses strings from text files, I could theoretically store an Extended Unicode character but be unable to find a matching alias."
  end
  if err
    str=["#{str}\nPlease try again.","#{str}\nTrying to list aliases instead."][mode]
    event.respond str if str.length>0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_aliases(event,args,bot) if mode==1
    return nil
  end
  logchn=log_channel()
  str2=''
  if event.server.nil?
    str2="**PM with dev:**"
  elsif Shardizard<0
    str2="**Server:** #{event.server.name} (#{event.server.id}) - Smol Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  else
    str2="**Server:** #{event.server.name} (#{event.server.id}) - #{shard_data(0)[Shardizard]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  end
  str2="#{str2} #{event.user.distinct} (#{event.user.id})"
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/ && !(dispstr[1].include?('thot') && event.channel.id==532083509083373583)
    event.respond "#{newname} has __***NOT***__ been added to #{matchnames[1]}'s aliases."
    bot.channel(logchn).send_message("#{str2}\n~~**#{type[1].gsub('*','')} Alias:** #{newname} for #{unit}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{matchnames[1]}'s aliases."
    bot.channel(logchn).send_message("#{str2}\n~~**#{type[1].gsub('*','')} Alias:** >CENSORED< for #{unit}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname,true)
  glbl=10000000000000000000000
  glbl=event.server.id unless event.server.nil?
  if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
    glbl=0
    glbl=modifier.to_i unless bot.server(modifier.to_i).nil? || bot.on(modifier.to_i).nil?
  elsif [167657750971547648,78649866577780736].include?(event.user.id) && !modifier.nil?
    glbl=0
  end
  alz=$aliases.map{|q| q}
  x=alz.find_index{|q| q[0]==type[1].gsub('*','') && q[1].downcase==newname.downcase && q[2]==matches[1]}
  mewalias=false
  if x.nil?
    m=[type[1].gsub('*',''),newname,matches[1],[glbl]]
    m=[type[1].gsub('*',''),newname,matches[1]] if glbl<=0
    alz.push(m)
    newalias=true
  else
    alz[x][3].push(glbl)
    alz[x][3]=nil if glbl<=0
  end
  str="The alias **#{newname}** for the #{type[1].gsub('*','').downcase} *#{matchnames[1]}* exists in a server already."
  str="#{str}  Making it global now." if glbl<=0
  str="#{str}  Adding this server to those that can use it." unless glbl<=0
  str="**#{newname}** has been #{'globally ' if glbl<=0}added to the aliases for the #{type[1].gsub('*','').downcase} *#{matchnames[1]}*." if newalias
  str="#{str}\nPlease double-check that the alias stuck."
  event.respond str
  (bot.channel(modifier2).send_message(str) if !modifier2.nil? && modifier2.to_i.to_s==modifier2) rescue nil
  type[1]='Multiunit' if kk2.is_a?(Array)
  str2="#{str2}\n**#{type[1].gsub('*','')} Alias:** #{newname} for #{matchnames[1]}"
  str2="#{str2} - gained a new server that supports it" unless newalias || glbl<=0
  str2="#{str2} - gone global" if !newalias && glbl<=0
  str2="#{str2} - global alias" if newalias && glbl<=0
  bot.channel(logchn).send_message(str2)
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/FGONames.txt", 'w') { |f|
    f.puts alz.map{|q| q.to_s}.join("\n")
  }
  bot.channel(logchn).send_message('Alias list saved.')
  nicknames_load()
  unless !$aliases[-1][2].is_a?(String) || $aliases[-1][2]<"Warhorse's Young Horn"
    open("#{$location}devkit/FGONames2.txt", 'w') { |f|
      f.puts alz.map{|q| q.to_s}.join("\n")
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
  return nil
end

def disp_servant_all(bot,event,args=[])
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.nil?
    if !find_data_ex(:find_FEH_unit,args.join(' '),event,false,bot).nil?
      unt=find_data_ex(:find_FEH_unit,args.join(' '),event,false,bot)
      event.respond "FEH unit found: #{unt.name}\nTry `FGO!stats FEH #{unt.name}` if you wish to see what this unit's stats would be in FGO."
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
    u=$dev_units.find_index{|q| q.id==k.id}
    k=$dev_units[u].clone unless u.nil?
  elsif donate_trigger_word(event)>0
    mu=donate_trigger_word(event)
    u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
    u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
    u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
    k=$donor_units[u].clone unless u.nil?
  end
  disp_servant_stats(bot,event,k,0)
  m=disp_servant_skills(bot,event,k,1)
  if safe_to_spam?(event)
    m=disp_servant_traits(bot,event,k,m)
    m=disp_servant_np(bot,event,k,m)
    m=disp_servant_ce(bot,event,k,m)
    disp_servant_mats(bot,event,k,m)
  end
  return nil
end

def disp_servant_stats(bot,event,args=[],chain=-1,smol=false)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  sze='normal'
  sze='smol' if has_any?(args,['tiny','small','smol','micro','little','mini']) || smol || $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
  sze='smol' unless safe_to_spam?(event)
  dispfou=0
  dispfou=1000 if args.include?('fou')
  dispfou=1000 if args.include?('fou') && args.include?('silver')
  dispfou=1000 if has_any?(args,['silverfou','silver_fou','fousilver','fou_silver','fou-silver','silver-fou'])
  dispfou=2000 if has_any?(args,['goldfou','gold_fou','fougold','fou_gold','fou-gold','gold-fou','goldenfou','golden_fou','fougolden','fou_golden','fou-golden','golden-fou'])
  effatk=false
  effatk=true if has_any?(args,['eff','effective'])
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      if !find_data_ex(:find_FEH_unit,args.join(' '),event,false,bot).nil?
        unt=find_data_ex(:find_FEH_unit,args.join(' '),event,false,bot)
        event.respond "FEH unit found: #{unt.name}\nTry `FGO!stats FEH #{unt.name}` if you wish to see what this unit's stats would be in FGO."
      else
        event.respond 'No matches found.'
      end
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  if k.id.to_i==81 && chain>-1
    data_load()
    k=$servants[$servants.find_index{|q| q.id==81.0}]
    kk2=$servants[$servants.find_index{|q| q.id==81.1}]
  end
  str=k.rarity_row
  title=k.superclass(bot,event)
  title=k.superclass(bot,event,2) unless chain>-1
  if title.length>250
    h=title.split("\n")
    title=[h[0],'']
    j=0
    for i in 1...h.length
      if "#{title[j]}\n#{h[i]}".length>250 && j==0
        j+=1
        title[j]="#{h[i]}"
      else
        title[j]="#{title[j]}\n#{h[i]}"
      end
    end
  end
  if sze=='smol'
    str="#{str}\n**Max. default level:** #{k.max_level}\u00A0\u00B7\u00A0**Team Cost:** #{k.team_cost}"
  else
    str="#{str}\n**Maximum default level:** #{k.max_level}"
    str="#{str} (#{k.grow_curve} growth curve)" unless k.grow_curve.nil? || k.grow_curve.length<=0
    str="#{str}\n**Team Cost:** #{k.team_cost}"
  end
  str="#{str}\n**Availability:** #{k.availability.join(', ')}"
  str="#{str}  (*FPSummon* in JP)" if k.id==4 && !k.availability.include?('FP Summon')
  str="#{str}\n\n**Command Deck:** #{k.deck[0,5].gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])} (#{k.deck[0,5]})"
  npx="*#{k.np}*"
  n=$nobles.find_index{|q| q.id.to_f==k.id}
  npx="*#{$nobles[n].name}:* #{$nobles[n].subtitle}" unless n.nil? || sze=='smol'
  flurp=''
  flurp="[#{k.deck.split('[')[1].gsub(']','').gsub(k.deck[6,1],'').gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])}]" if k.deck.include?('[')
  str="#{str}\n**Noble Phantasm:** #{k.deck[6,1].gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])}#{flurp} #{npx}"
  str="#{str}\n\n#{k.ce_display}"
  flds=[]
  if sze=='smol'
    str="#{str}\n\n#{k.stat_stanza(dispfou,effatk,chain>-1)}"
  else
    flds.push(['Combat Stats',k.stat_grid(dispfou,effatk,chain>-1)])
    flds.push(['Attack Parameters',k.attack_params(chain>-1)])
    if k.id.to_i==81 && chain>-1
      str="#{str}\n\n**Hit Counts:** #{k.hit_count_disp(1)}"
      flds[-1][0]="#{flds[-1][0]} (Jekyll)"
      flds.push(['Attack Parameters (Hyde)',kk2.attack_params(chain>-1)])
    else
      str="#{str}\n\n**Death Rate:** #{k.death_rate}%"
    end
  end
  flds=nil if flds.length<=0
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou>0 || k.is_a?(SuperServant)
  ftr=k.generic_footer unless k.generic_footer.nil?
  k.id=k.id.to_i if k.id.to_i==81 && chain>-1
  create_embed(event,["#{k.dispName('**','__')} #{k.emoji(bot,event,3)}",title],str,k.disp_color,ftr,k.thumbnail(event),flds)
end

def disp_servant_skills(bot,event,args=[],chain=-1,smol=false)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  s2s=false
  s2s=true if safe_to_spam?(event,nil,1) # this command uses s2s level 1 rather than default s2s
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  if k.id.to_i==81 && chain>0
    data_load()
    k=$servants[$servants.find_index{|q| q.id==81.0}]
    kk2=$servants[$servants.find_index{|q| q.id==81.1}]
  end
  flds=[]
  str=''
  atv=k.active_bracket.clone
  lvl=[0,0,0,0,0,0]
  lvl=k.skill_levels.map{|q| q.split('u')[0].to_i} if k.is_a?(SuperServant)
  for i in 0...atv.length
    for i2 in 0...atv[i].length
      m=["**Skill #{i+1}:** *#{atv[i][i2].fullName}*"]*2
      if i2==1
        m[0]="*When upgraded:* #{atv[i][i2].fullName}"
        m[1]="*Skill #{i+1}u:* #{atv[i][i2].fullName}"
      elsif i2>1
        m[0]="*When upgraded again:* #{atv[i][i2].fullName}"
        m[1]="*Skill #{i+1}u#{i2}:* #{atv[i][i2].fullName}"
      end
      if s2s
        m2=atv[i][i2].description(lvl[i])
        m=["__#{m[0]}__","__#{m[1]}__","#{m2}"]
        m[2]="#{m2.split("\n")[0,2].join("\n")}\n\\> Lots of effects <" if !safe_to_spam?(event) && (m2.length>500 || m2.split("\n").length>8)
      end
      atv[i][i2]=m.map{|q| q}
    end
  end
  psv=k.passive_bracket.clone
  for i in 0...psv.length
    if s2s
      psv[i]="*#{psv[i].fullName}*: #{psv[i].effects}"
    else
      psv[i]=psv[i].fullName
    end
  end
  if k.id.to_i==81 && chain>0
    flds.push(['Passive Skills (Jekyll)',psv.join("\n"),1]) unless psv.length<=0
    psv=kk2.passive_bracket.clone
    for i in 0...psv.length
      if s2s
        psv[i]="*#{psv[i].fullName}*: #{psv[i].effects}"
      else
        psv[i]=psv[i].fullName
      end
    end
    flds.push(['Passive Skills (Hyde)',psv.join("\n"),1]) unless psv.length<=0
  else
    flds.push(['Passive Skills',psv.join("\n"),1]) unless psv.length<=0
  end
  app=k.append_bracket.clone
  for i in 0...app.length
    for i2 in 0...app[i].length
      m=["**Append #{i+1}:** *#{app[i][i2].fullName}*"]*2
      if i2==1
        m[0]="*When upgraded:* #{app[i][i2].fullName}"
        m[1]="*Append #{i+1}u:* #{app[i][i2].fullName}"
      elsif i2>1
        m[0]="*When upgraded again:* #{app[i][i2].fullName}"
        m[1]="*Append #{i+1}u#{i2}:* #{app[i][i2].fullName}"
      end
      if s2s
        m2=app[i][i2].description(lvl[i+3])
        m=[m[0],m[1],"#{m2}"]
        m[2]="#{m2.split("\n")[0,2].join("\n")}\n\\> Lots of effects <" if !safe_to_spam?(event) && (m2.length>500 || m2.split("\n").length>8)
      end
      app[i][i2]=m.map{|q| q}
    end
  end
  flds=nil if flds.length<=0
  hdr="#{k.dispName('**','__')} #{k.emoji(bot,event,2)}"
  title=k.rarity_row
  clr=[chain,0].max
  ftr=nil
  xpic=k.thumbnail(event)
  if chain>0
    hdr=''; title=nil; xpic=nil
    xpic="http://fate-go.cirnopedia.org/icons/servant/servant_10011.png" if k.id.to_i==81
  else
    ftr=k.generic_footer
  end
  embeds=[]
  if s2s
    appstr=app.map{|q| q.map{|q2| "#{q2[0]}#{"\n" if q2[2].include?("\n")}#{': ' unless q2[2].include?("\n")}#{q2[2]}"}}
    appstr=appstr.map{|q| q.join("\n#{"\n" if q.reject{|q2| !q2.include?("\n")}.length>0}")}
    appstr=appstr.join("\n#{"\n" if appstr.reject{|q2| !q2.include?("\n")}.length>0}")
    f=hdr.length
    f+=ftr.length unless ftr.nil?
    f+=flds.map{|q| "__**#{q[0]}**__\n#{q[1]}"}.join("\n\n").length unless flds.nil?
    f+=title.length unless title.nil?
    f+=atv.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n").length
    f+=appstr.length
    if f>1900
      hdr="__**#{k.name}** [Srv-#{k.id}] #{k.emoji(bot,event,3)}__"
      str=k.rarity_row
      str="#{str}\n**Command Deck:** #{k.deck[0,5].gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])} (#{k.deck[0,5]})"
      str="#{str}\n**Noble Phantasm:** #{k.deck[6,1].gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])} (#{k.deck[6,1]})"
      if k.deck.include?('[')
        flurp=k.deck.split('[')[1].gsub(']','').gsub(k.deck[6,1],'')
        str="#{str} [#{flurp.gsub('Q',k.stat_emotes[0]).gsub('A',k.stat_emotes[1]).gsub('B',k.stat_emotes[2])} (#{flurp}) also possible]"
      end
      title=k.superclass(bot,event)
      if atv.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n").length>1900
        for i in 0...atv.length
          if atv[i].map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n").length>1900
            for i2 in 0...atv[i].length
              embeds.push([atv[i][i2][1],atv[i][i2][2]])
            end
          else
            s=atv[i][0][2]
            for i2 in 1...atv[i].length
              s="#{s}\n\n#{atv[i][i2][0]}\n#{atv[i][i2][2]}"
            end
            embeds.push([atv[i][0][0],s])
          end
        end
      else
        embeds.push(['__**Active Skills**__',atv.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n")])
      end
      if k.id.to_i==81 && chain>0
        embeds.push(['__**Passive Skills**__',flds.map{|q| "__**#{q[0].gsub('Passive Skills (','').gsub(')','')}**__\n#{q[1]}"}.join("\n\n")])
      else
        embeds.push(['__**Passive Skills**__',flds[0][1]])
      end
      if app.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n").length>1900
        for i in 0...app.length
          if app[i].map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n").length>1900
            for i2 in 0...app[i].length
              embeds.push([app[i][i2][1],app[i][i2][2]])
            end
          else
            s=app[i][0][2]
            for i2 in 1...app[i].length
              s="#{s}\n\n#{app[i][i2][0]}\n#{app[i][i2][2]}"
            end
            embeds.push([app[i][0][0],s])
          end
        end
      else
        embeds.push(['__**Append Skills**__',app.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n")])
      end
      flds=nil
    else
      str=atv.map{|q| q.map{|q2| "#{q2[0]}\n#{q2[2]}"}.join("\n\n")}.join("\n\n")
      str="#{str}\n\n#{flds.map{|q| "__**#{q[0]}**__\n#{q[1]}"}.join("\n\n")}" unless flds.nil?
      str="#{str}\n\n#{appstr}"
      flds=nil
    end
  else
    str=atv.map{|q| q.map{|q2| q2[0]}.join("\n")}.join("\n\n")
    str="#{str}\n\n#{flds.map{|q| "__**#{q[0]}**__\n#{q[1]}"}.join("\n\n")}" unless flds.nil?
    str="#{str}\n\n#{app.map{|q| q.map{|q2| q2[0]}.join("\n")}.join("\n")}"
    flds=nil
  end
  xftr=nil
  if embeds.length>0
    hdr="__#{"#{k.owner}'s " unless k.owner.nil?}**#{k.name}** [Srv-#{k.id}] #{k.emoji(bot,event,3)}__"
    xftr="#{ftr}" unless ftr.nil?
    ftr=nil
  end
  create_embed(event,[hdr,title],str,k.disp_color(clr),ftr,xpic,flds,6) unless chain>0 && embeds.length>0
  if embeds.length>0
    for i in 0...embeds.length
      clr+=1 unless chain>0 && i==0
      create_embed(event,embeds[i][0],embeds[i][1],k.disp_color(clr))
    end
    event.respond xftr unless xftr.nil?
  end
  return clr+1 if chain>0
end

def disp_servant_traits(bot,event,args=[],chain=-1,smol=false)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  str=k.rarity_row
  str="#{str}\nThis servant's traits change upon transformation." if k.id.to_i==81
  title="**Attribute:** #{k.attribute}"
  title="#{title}\n**Alignment:** #{k.alignment}" unless k.id.to_i==81 && chain>0
  title="#{title}\n#{'**Gender:** ' unless k.gender.include?('~~')}#{k.gender}"
  hdr="#{k.dispName('**','__')} #{k.emoji(bot,event,2)}"
  hdr="__**Dr. Jekyll** [Srv-#{k.id}]__ #{k.emoji(bot,event,2)}" if k.id==81.0 && chain<0
  ftr=nil
  xpic=k.thumbnail(event)
  if chain>0
    xpic=nil
    hdr=''
  else
    ftr=k.generic_footer
  end
  m=k.traits.map{|q| q}
  for i in 0...m.length
    if m[i].include?('A]')
      x=m[i].split('[')[1].gsub('A]','').to_i
      m[i]="#{m[i].split(' [')[0]} *[#{['Zeroth','First','Second','Third','Final'][x]} Ascension]*"
    end
  end
  m.push('Evil *[Added]*') if k.id==74 && event.message.text.downcase.include?('crime')
  xflds=triple_finish(m)
  if k.id.to_i==81 && chain>0
    data_load()
    k=$servants[$servants.find_index{|q| q.id==81.0}]
    kk2=$servants[$servants.find_index{|q| q.id==81.1}]
    xflds=[]
    xflds.push(['**Dr. Jekyll**',"*#{k.alignment}*\n#{k.traits.join("\n")}"])
    xflds.push(['**Mr. Hyde**',"*#{kk2.alignment}*\n#{kk2.traits.join("\n")}"])
  end
  xflds=nil if xflds.length<=0
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    xflds=[['Traits',m.join("\n")]] unless xflds.map{|q| q[0]}.uniq.length>1
  elsif m.length<10 && xflds[0][0]=='.'
    str="#{str}#{"\n" if str.include?("\n")}\n#{m.join("\n")}"
    xflds=nil
  end
  create_embed(event,[hdr,title],str,k.disp_color([chain,0].max),ftr,xpic,xflds,4)
  return chain+1 if chain>0
  return nil
end

def disp_servant_np(bot,event,args=[],chain=-1,forcenpl=nil)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  n=$nobles.find_index{|q| q.id.to_f==k.id}
  nz=$nobles.reject{|q| q.id.split('u')[0].to_f !=k.id}
  n=$nobles.find_index{|q| q.id=="#{k.id}#{k.np_level[1,k.np_level.length-1]}"} if k.is_a?(SuperServant) && k.np_level.length>1
  nz=[$nobles[n].clone] if k.is_a?(SuperServant)
  if n.nil?
    return chain if chain>-1
    if k.np.nil? || k.np.length<=0
      event.respond "#{k.dispName('','*')}#{k.emoji(bot,event)} has no Noble Phantasm."
    else
      event.respond "No data exists for #{k.dispName('','*')}#{k.emoji(bot,event)}'s Noble Phantasm, **#{k.np}**."
    end
    return nil
  end
  n=$nobles[n]
  npl=-1
  npl=0 if ['Event','Welfare'].include?(k.availability)
  if forcenpl.nil?
    for i in 1...6
      npl=i*1 if args.include?("np#{i}")
      npl=i*1 if args.include?("kh#{i}") && k.id==154
    end
  else
    npl=forcenpl*1
  end
  npl=k.np_level.split('u')[0].to_i if k.is_a?(SuperServant)
  xpic=nil
  names=["#{n.name}","#{n.subtitle}"]
  names.push(n.alt_name.map{|q| q}) unless n.alt_name.nil? || n.alt_name.length<=0
  names.flatten!
  if k.is_a?(SuperServant)
    names=["#{n.name}","#{n.subtitle}"]
    names=n.alt_name.map{|q| q} if !n.alt_name.nil? && n.alt_name.length>1 && k.art_id>2
  end
  if chain>-1
    xcolor=k.disp_color(chain)
    hdr="__**#{names[0]}:** *#{names[1]}*__"
    title=''
  else
    xpic=k.thumbnail(event)
    xcolor=n.disp_color
    hdr="#{k.dispName('**','__')} #{k.emoji(bot,event,2)}"
    hdr="__**Dr. Jekyll** [Srv-#{k.id}]__ #{k.emoji(bot,event,2)}" if k.id==81.0 && chain<0
    title="**Noble Phantasm:** *#{names[0]}:* #{names[1]}"
  end
  unless names.length<=2
    title="#{title}#{"\n" unless title.length<=0}**Alt. Name:** *#{names[2]}"
    if names.length<=3
      title="#{title}*"
    else
      title="#{title}:* #{names[3]}"
    end
  end
  title="#{title}\n**Card Type:** #{n.card_type}"
  title="#{title}\n**Counter Type:** #{n.type.join(' / ')}" unless nz.map{|q| q.type.map{|q2| q2.gsub(' ','')}}.uniq.length>1
  title="#{title}\n**Target:** #{n.target.join(' / ')}" unless nz.map{|q| q.target.map{|q2| q2.gsub(' ','')}}.uniq.length>1
  title="#{title}\n**Hit Count:** #{k.hit_count[4]}"
  title="#{title}\n**Rank:** #{n.rank}" if nz.length<=1
  str=''
  str="__**Rank:** #{n.rank}__" if nz.length>1
  str="#{str}#{"\n" if str.length>0}**Counter Type:** #{n.type.join(' / ')}" if nz.map{|q| q.type.map{|q2| q2.gsub(' ','')}}.uniq.length>1
  str="#{str}#{"\n" if str.length>0}**Target:** #{n.target.join(' / ')}" if nz.map{|q| q.target.map{|q2| q2.gsub(' ','')}}.uniq.length>1
  str="#{str}#{"\n" if str.length>0}**Effects:**#{n.description(npl)}"
  ny=nz.reject{|q| q.id==n.id}
  if ny.length>0
    for i in 0...ny.length
      str="#{str}\n\n__**Rank:** #{ny[i].rank}__"
      str="#{str}\n**Counter Type:** #{ny[i].type.join(' / ')}" if nz.map{|q| q.type.map{|q2| q2.gsub(' ','')}}.uniq.length>1
      str="#{str}\n**Target:** #{ny[i].target.join(' / ')}" if nz.map{|q| q.target.map{|q2| q2.gsub(' ','')}}.uniq.length>1
      str="#{str}\n**Effects:**#{ny[i].description(npl)}"
    end
  end
  unless chain>-1
    m=nz.map{|q| q.tags}.flatten.uniq.sort
    t=[]; t2=[]; t3=[]
    for i in 0...m.length
      if nz.reject{|q| q.tags.include?(m[i])}.length<=0 # none of the versions of the NP lack this tag
        t.push("#{m[i]}")
      elsif nz[0].tags.include?(m[i]) && nz[-1].tags.include?(m[i]) # it exists in the first and last versions of the NP but was missing somewhere in the middle
        t.push("~~#{m[i]}~~")
        t3.push("*#{m[i]}*")
      elsif nz[0].tags.include?(m[i]) # it exists in the first version of the NP but not the last.
        t.push("~~#{m[i]}~~")
      elsif nz[-1].tags.include?(m[i]) # it exists in the last version of the NP but not the first.
        t3.push("*#{m[i]}*")
      else # it exists somewhere in the middle but not the beginning or the end
        t2.push("~~*#{m[i]}*~~")
      end
    end
    str="#{str}\n\n**Tags:** #{[t,t2,t3].flatten.join(', ')}"
  end
  embeds=[]
  if hdr.length+title.length+str.length>=1950
    embeds=str.split("\n\n")
    str="#{embeds[0]}"
    embeds.shift
  end
  if title.length>250
    title=title.split("\n")
    j=-1
    for i in 0...title.length
      j=i*1 if title[0,i+1].join("\n").length<250
    end
    str="#{title[j,title.length-j].join("\n")}\n\n#{str}"
    title=title[0,j].join("\n")
  end
  ftr='You can also include NP# to show relevant stats at other merge counts.' if npl==1
  ftr=k.generic_footer if safe_to_spam?(event)
  create_embed(event,[hdr,title],str,xcolor,ftr,xpic)
  if embeds.length>0
    for i in 0...embeds.length
      xcolor=n.disp_color
      xcolor=k.disp_color(chain+1+i) if chain>-1
      create_embed(event,"When upgraded#{' again' if i>0}",embeds[i],xcolor)
    end
  end
  return chain+1+embeds.length if chain>-1
  return nil
end

def disp_servant_ce(bot,event,args=[],chain=-1,valentines=false)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  m=[[k.bond_ce],'Bond']
  m=[k.valentines_ce,"Valentine's"] if valentines
  if m[0].nil? || m[0].length<=0
    return chain if chain>-1
    event.respond "#{k.dispName('','*')}#{k.emoji(bot,event)} has no #{m[1]} CE."
  end
  data_load(['craft'])
  c=m[0].map{|q| $crafts.find_index{|q2| q2.id==q}}.compact
  if c.nil? || c.length<=0
    return chain if chain>-1
    event.respond "No data exists for #{k.dispName('','*')}#{k.emoji(bot,event)}'s #{m[1]} CE."
    return nil
  end
  for i in 0...c.length
    disp_craft_essance(bot,event,$crafts[c[i]].clone,[chain,k.clone])
  end
  return chain+1 if chain>-1
  return nil
end

def disp_servant_mats(bot,event,args=[],chain=-1,forceskills=false)
  if args.is_a?(FGOServant)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_servant,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
    if has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
      u=$dev_units.find_index{|q| q.id==k.id}
      k=$dev_units[u].clone unless u.nil?
    elsif donate_trigger_word(event)>0
      mu=donate_trigger_word(event)
      u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
      u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
      u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
      k=$donor_units[u].clone unless u.nil?
    end
  end
  if k.id.to_i==81 && chain>-1
    data_load()
    k=$servants[$servants.find_index{|q| q.id==81.0}]
  end
  mat_types=[]; summary=false
  unless chain>-1
    for i in 0...args.length
      mat_types.push('Ascension') if ['ascension','ascensions','justascension','justascensions'].include?(args[i].downcase)
      mat_types.push('Costume') if ['costume','costumes','justcostume','justcostumes'].include?(args[i].downcase) && !k.fixed_costume_mats.nil? && k.fixed_costume_mats.length>0
      mat_types.push('Skill') if ['skill','skills','justskill','justskills'].include?(args[i].downcase) || forceskills
      mat_types.push('Active') if ['active','actives'].include?(args[i].downcase)
      mat_types.push('Append') if ['append'].include?(args[i].downcase)
      summary=true if ['total','totals','summary','summarized','summery','summerized'].include?(args[i].downcase)
    end
  end
  str=''; flds=[]
  k.fix_mats
  str=k.disp_ascension_data(bot,event) if mat_types.length<=0 || mat_types.include?('Ascension')
  str="#{str}#{"\n\n" if str.length>0}#{k.disp_costume_data(bot,event)}" if (mat_types.length<=0 && !k.fixed_costume_mats.nil? && k.fixed_costume_mats.length>0) || mat_types.include?('Costume')
  str="#{str}#{"\n\n" if str.length>0}#{k.disp_skill_data(bot,event)}" if mat_types.length<=0 || mat_types.include?('Skill') || mat_types.include?('Active')
  str="#{str}#{"\n\n" if str.length>0}#{k.disp_skill_data(bot,event,1)}" if mat_types.length<=0 || mat_types.include?('Skill') || mat_types.include?('Append')
  if summary
    str=''
    m=k.disp_mat_summary(bot,event,mat_types)
    if m.length<=10 || $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
      str=m.join("\n")
    else
      flds=triple_finish(m,true)
    end
  end
  str="#{str}#{"\n\n" if str.length>0}Please note that these mats never actually get used.  They are associated with Hyde's Berserker class, which can only be obtained in battle.  For this servant's actual ascension and skill mats, please look up servant #81.0" if k.id==81.1
  hdr="#{k.dispName('**','__')} #{k.emoji(bot,event,2)}"
  title=k.rarity_row
  xcolor=k.disp_color
  xpic=k.thumbnail(event)
  ftr=nil
  ftr='If you have trouble seeing the material icons, try the command again with the word "TextMats" included in your message.' unless has_any?(args.map{|q| q.downcase},['colorblind','colourblind','textmats']) || summary
  ftr='Numbars in parenthesis include costume materials.' if summary && !k.fixed_costume_mats.nil? && k.fixed_costume_mats.length>0 && (mat_types.length<=0 || mat_types.include?('Costume'))
  if chain>-1
    hdr=''
    title=nil
    xpic=nil if k.id.to_i==81
    xcolor=k.disp_color(chain)
    ftr=k.generic_footer unless k.generic_footer.nil?
  end
  f=hdr.length+str.length
  f+=ftr.length unless ftr.nil?
  f+=title.length unless title.nil?
  embeds=[]
  if summary
  elsif f>1950
    embeds=str.split("\n\n")
    str=embeds[0]
    embeds.shift
    if embeds.length>1 && "#{str}\n\n#{embeds[0]}".length<=1500
      str="#{str}\n\n#{embeds[0]}"
      embeds.shift
    elsif embeds.length>1 && "#{embeds[0]}\n\n#{embeds[1]}".length<=1500
      embeds[0]="#{embeds[0]}\n\n#{embeds[1]}"
      embeds.pop
    end
  end
  flds=nil if flds.length<=0
  if embeds.length>0
    xftr="#{ftr}"
    ftr=nil
  end
  create_embed(event,[hdr,title],str,xcolor,ftr,xpic,flds)
  if embeds.length>0
    for i in 0...embeds.length
      f=nil
      f=xftr if i==embeds.length-1
      xcolor=k.disp_color(i+1)
      xcolor=k.disp_color(chain+i+1) if chain>-1
      if embeds[i].include?("\n\n")
        x=''
        y=embeds[i]
      else
        x=embeds[i].split("\n")[0]
        y=embeds[i].gsub("#{x}\n",'')
      end
      create_embed(event,x,y,xcolor,f)
    end
  end
end

def disp_craft_essance(bot,event,args=[],chain=[],smol=false)
  if args.is_a?(FGO_CE)
    k=args.clone
    args=event.message.text.downcase.split(' ')
  else
    args=event.message.text.downcase.split(' ') if args.nil?
  end
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if k.nil?
    k=find_data_ex(:find_ce,args.join(' '),event).clone
    if k.nil?
      event.respond 'No matches found.'
      return nil
    end
  end
  hdr="#{k.dispName('**','__')} #{k.emoji(bot,event)}"
  title="#{k.rarity_row}\n**Cost:** #{k.cost}"
  str=k.stat_grid
  ftr=nil
  ftr='For the other CE given the title "Heaven\'s Feel" in-game, it has been given the name "Heaven\'s Feel (Anime Japan)".' if k.id==35
  ftr="For the other CE given the title \"#{k.name}\" in-game, it has been given the name \"#{k.name} [Lancer]\"." if [595,826].include?(k.id)
  xpic=k.thumbnail(event)
  xcolor=k.disp_color(0)
  if chain.length>0 # when called as a result of looking up a servant's Bond or Valentine's CE
    ftr=chain[1].generic_footer
    if k.servant_connection.nil? || k.servant_connection[0]!='Bond'
    elsif event.message.text.split(' ').include?(chain[1].id.to_s) && chain[1].id>=2 && chain[1].id.to_i != 81
      cex=$crafts.find_index{|q| q.id==chain[1].id}
      ftr="This is the Bond CE for servant ##{chain[1].id}.  For the CE numbered #{chain[1].id}, it is named \"#{$crafts[cex].name}\"."
    elsif event.message.text.split(' ').include?('1') && (chain[1].id<2 || chain[1].id.to_i==81)
      cex=$crafts.find_index{|q| q.id==chain[1].id.to_i}
      ftr="This is the Bond CE for servant ##{chain[1].id}.  For the CE numbered #{chain[1].id.to_i}, it is named \"#{$crafts[cex].name}\"."
    end
    ftr=nil if chain[0]>-1
    xcolor=chain[1].disp_color(chain[0]) unless chain[0]<0
  elsif k.servant_connection.nil?
  elsif k.servant_connection[0]=='Bond'
    str="#{k.stat_emotes[0]}**Bond CE for:** #{k.servant_connection[1].dispName('','*')}\n\n#{str}"
  elsif k.servant_connection[0]=='Valentines'
    str="#{k.stat_emotes[1]}**Valentine's CE for:** #{k.servant_connection[1].dispName('','*')}\n\n#{str}"
  end
  create_embed(event,[hdr,title],str,xcolor,ftr,xpic)
  return chain[0]+1 if chain.length>0
  return nil
end

def disp_skill_data(bot,event,args=nil,addmsg=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_skill,args.join(' '),event)
  if k.nil? || k.length.zero?
    sklz=$skills.reject{|q| q.type != 'Active'}
    if find_data_ex(:find_servant,args.join(' '),event).length>0 && has_any?(args,['s1','s2','s3','skill1','skill2','skill3','skl1','skl2','skl3','s1u','s2u','s3u','skill1u','skill2u','skill3u','skl1u','skl2u','skl3u','s1upgrade','s2upgrade','s3upgrade','skill1upgrade','skill2upgrade','skill3upgrade','skl1upgrade','skl2upgrade','skl3upgrade','s1u1','s2u1','s3u1','skill1u1','skill2u1','skill3u1','skl1u1','skl2u1','skl3u1','s1upgrade1','s2upgrade1','s3upgrade1','skill1upgrade1','skill2upgrade1','skill3upgrade1','skl1upgrade1','skl2upgrade1','skl3upgrade1','s1u2','s2u2','s3u2','skill1u2','skill2u2','skill3u2','skl1u2','skl2u2','skl3u2','s1upgrade2','s2upgrade2','s3upgrade2','skill1upgrade2','skill2upgrade2','skill3upgrade2','skl1upgrade2','skl2upgrade2','skl3upgrade2'])
      adv=find_data_ex(:find_servant,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','skill2','skl2','s2u','skill2u','skl2u','s2upgrade','skill2upgrade','skl2upgrade','s2u1','skill2u1','skl2u1','s2upgrade1','skill2upgrade1','skl2upgrade1','s2u2','skill2u2','skl2u2','s2upgrade2','skill2upgrade2','skl2upgrade2'])
      p=2 if has_any?(args,['s3','skill3','skl3','s3u','skill3u','skl3u','s3upgrade','skill3upgrade','skl3upgrade','s3u1','skill3u1','skl3u1','s3upgrade1','skill3upgrade1','skl3upgrade1','s3u2','skill3u2','skl3u2','s3upgrade2','skill3upgrade2','skl3upgrade2'])
      p2=0
      if adv.actives.nil? || adv.actives.length<=0 || adv.actives[p].length<=0 || adv.actives[p][0].nil?
        event.respond "#{adv.name} [Srv-##{adv.id}] does not have a #{['1st','2nd','3rd'][p]} skill."
        return nil
      elsif has_any?(args,['s1u','s2u','s3u','skill1u','skill2u','skill3u','skl1u','skl2u','skl3u','s1upgrade','s2upgrade','s3upgrade','skill1upgrade','skill2upgrade','skill3upgrade','skl1upgrade','skl2upgrade','skl3upgrade','upgrade','s1u1','s2u1','s3u1','skill1u1','skill2u1','skill3u1','skl1u1','skl2u1','skl3u1','s1upgrade1','s2upgrade1','s3upgrade1','skill1upgrade1','skill2upgrade1','skill3upgrade1','skl1upgrade1','skl2upgrade1','skl3upgrade1','upgrade1','u1'])
        if adv.actives[p][1].nil?
          event.respond "#{adv.name} [Srv-##{adv.id}] does not have an upgrading #{['1st','2nd','3rd'][p]} skill.  Showing default skill in that slot."
        elsif sklz.find_index{|q| q.fullName==adv.actives[p][1]}.nil?
          event.respond "#{adv.name} [Srv-##{adv.id}]'s upgraded #{['1st','2nd','3rd'][p]} skill, #{adv.actives[p][1]}, does not have skill data.  Showing default skill in that slot."
        else
          p2=1
        end
      elsif has_any?(args,['s1u2','s2u2','s3u2','skill1u2','skill2u2','skill3u2','skl1u2','skl2u2','skl3u2','s1upgrade2','s2upgrade2','s3upgrade2','skill1upgrade2','skill2upgrade2','skill3upgrade2','skl1upgrade2','skl2upgrade2','skl3upgrade2','upgrade2','u2'])
        if adv.actives[p][1].nil?
          event.respond "#{adv.name} [Srv-##{adv.id}] does not have an upgrading #{['1st','2nd','3rd'][p]} skill.  Showing default skill in that slot."
        elsif adv.actives[p][2].nil?
          event.respond "#{adv.name} [Srv-##{adv.id}] does not have a #{['1st','2nd','3rd'][p]} skill that upgrades twice.  Showing regular upgraded skill in that slot."
          p2=1
        elsif sklz.find_index{|q| q.fullName==adv.actives[p][2]}.nil?
          if sklz.find_index{|q| q.fullName==adv.actives[p][1]}.nil?
            event.respond "Neither of #{adv.name} [Srv-##{adv.id}]'s upgraded #{['1st','2nd','3rd'][p]} skill, #{adv.actives[p][1]} and #{adv.actives[p][2]}, have skill data.  Showing default skill in that slot."
          else
            event.respond "#{adv.name} [Srv-##{adv.id}]'s double-upgraded #{['1st','2nd','3rd'][p]} skill, #{adv.actives[p][2]}, does not have skill data.  Showing regular upgraded skill in that slot."
            p2=1
          end
        else
          p2=2
        end
      end
      if sklz.find_index{|q| q.fullName==adv.actives[p][p2]}.nil?
        event.respond "#{adv.name} [Srv-##{adv.id}]'s #{['1st','2nd','3rd'][p]} skill, #{adv.actives[p][p2]}, does not have skill data."
      else
        ftr=nil
        ftr="#{adv.name} [Srv-##{adv.id}]'s #{['1st','2nd','3rd'][p]} skill can be upgraded to #{adv.actives[p][p2+1]}" unless adv.actives[p][p2+1].nil? || adv.actives[p][p2+1].length<=0
        disp_skill_data(bot,event,adv.actives[p][p2].split(' '),ftr)
      end
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  k0=k[0].clone
  xcolor=k0.disp_color(k.length-1)
  hdr="__**#{k0.name}**#{" *#{k0.rank}*" if k.length==1 && ![nil,'','-'].include?(k0.rank)} [#{k0.type.gsub('ClothingSkill','Clothing')} Skill#{' Family' unless k.length<=1}]__"
  title=''
  title="**Rank:** #{k0.rank}" unless k.length<=1 || k0.rank.nil? || k.map{|q| q.rank}.uniq.length>1
  ignore=''
  unless k0.cooldown.nil? || k.map{|q| q.cooldown}.uniq.length>1
    title="#{title}#{"\n" if title.length>0}**Cooldown:** #{k0.cooldown}\u00A0L#{micronumber(1)}"
    title="#{title}\u00A0/\u00A0#{k0.cooldown-1}\u00A0L#{micronumber(6)}"
    title="#{title}\u00A0/\u00A0#{k0.cooldown-2}\u00A0L#{micronumber(10)}"
    ignore="#{ignore}C"
  end
  unless k0.target.nil? || k.map{|q| q.target.sort{|a,b| a<=>b}}.uniq.length>1
    title="#{title}#{"\n" if title.length>0}**Target:** #{k0.target.join(' / ')}"
    ignore="#{ignore}T"
  end
  title=nil if title.length<=0
  ftr=nil; str=''; flds=[]
  ftr='If you\'re looking for a skill\'s aliases, the command name is "aliases", not "skill alias".' if k0.name[0,5].downcase=='alias'
  if k.length<=1 && ['Active','ClothingSkill'].include?(k0.type)
    e=0
    for i in 0...k0.effects.length
      k0e=k0.effects[i].clone
      if k0e.effect[0,2]=='> '
        str="#{str}\n#{k0e.disp_str(0)}"
      else
        e+=1
        str="#{str}#{"\n\n" if str.length>0}**Effect #{e}:** #{k0e.disp_str(0)}"
      end
    end
  elsif k.length<=1
    str=k0.description(0,ignore)
  elsif k.reject{|q| q.name[0,17]=='Primordial Rune ('}.length<=0
    hdr="__**Primordial Rune** [Active Skill Superfamily]__"
    for i in 0...k.length
      if safe_to_spam?(event,nil,1)
        str="#{str}#{"\n\n" if str.length>0}__**Version: #{k[i].name.gsub('Primordial Rune (','').gsub(')','')}**__"
        str="#{str}\n*Rank:* #{k[i].rank}" unless k[i].rank.nil? || k[i].rank.length<=0 || k[i].rank=='-'
        str="#{str}\n#{k[i].description(0,ignore)}"
      else
        str="#{str}#{"\n" if str.length>0}**Version: #{k[i].name.gsub('Primordial Rune (','').gsub(')','')}**"
        str="#{str}  *Rank:* #{k[i].rank}" unless k[i].rank.nil? || k[i].rank.length<=0 || k[i].rank=='-'
      end
    end
  else
    m=k.map{|q| q.description(0,ignore).split("\n").length}.max
    for i in 0...k.length
      if m<=1
        str="#{str}#{"\n" if str.length>0}**Rank #{k[i].rank}:** #{k[i].description(0,ignore)}"
      elsif !safe_to_spam?(event,nil,1) && k[i].description(0,ignore).split("\n").length>3 && k.length>3
        str="#{str}#{"\n\n" if str.length>0}__**Rank #{k[i].rank}**__\n#{k[i].description(0,ignore).split("\n").reject{|q| q[0]!='*'}.join("\n")}#{"\n" unless ignore.length==2}Lots of effects"
      else
        str="#{str}#{"\n\n" if str.length>0}__**Rank #{k[i].rank}**__\n#{k[i].description(0,ignore)}"
      end
    end
  end
  if k.length<=1
    s=[]
    srv=$servants.map{|q| q.clone}
    if k0.type=='Passive'
      s.push(srv.reject{|q| !q.passives.include?(k0.fullName)}.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_s==81}) #{q.name}"})
    elsif ['Active','Append'].include?(k0.type)
      c='S'; c='A' if k0.type=='Append'
      f=srv.map{|q| q.grab_a(k0.type).map{|q| q.length}}.flatten.max
      for i in 0...f
        x=srv.reject{|q| !q.grab_a(k0.type).map{|q2| q2[i]}.include?(k0.fullName)}
        for i2 in 0...x.length
          m=x[i2].grab_a(k0.type).find_index{|q| q[i]==k0.fullName}
          x[i2]="#{x[i2].id}#{'.' unless x[i2].id<2 || x[i2].id.to_i==81}) #{x[i2].name}#{" - #{c}#{m+1}" unless m.nil?}"
        end
        s.push(x.map{|q| q})
      end
    end
    lim=3; lim=16 if safe_to_spam?(event,nil,1); lim=1600 if safe_to_spam?(event)
    for i in 0...s.length
      h="Servants with this skill #{'after upgrading ' if i>0}#{['','','twice','thrice'][i] if i<4}#{"#{i} times" if i>3}"
      if s[i].length<=0
      elsif s[i].join("\n").length>1000 || s[i].length>lim
        flds.push([h,"#{s[i].length} servants"])
      else
        flds.push([h,s[i].join("\n")])
      end
    end
  end
  tgs=[]; tgs=k0.tags.reject{|q| k.reject{|q2| q2.tags.include?(q)}.length>1}.sort{|a,b| a<=>b} unless k0.tags.nil? || k0.tags.length<=0
  flds.push(['Skill Tags',tgs.join("\n")]) unless tgs.length<=0 || !safe_to_spam?(event,nil,1)
  tgs=$skills.reject{|q| q.name[0,k0.name.length+2]!="#{k0.name} ("}
  if tgs.length<=0
  elsif list_lift(tgs.map{|q| q.name}.uniq,'or').length<=200 && ftr.nil?
    ftr="You may also mean: #{list_lift(tgs.map{|q| q.name}.uniq,'or')}"
  else
    flds.push(['You may also mean',tgs.map{|q| q.name}.uniq.join("\n")]) if safe_to_spam?(event) || flds.length==1
  end
  flds=nil if flds.length<=0
  create_embed(event,[hdr,title],str,xcolor,ftr,nil,flds)
end

def disp_code_data(bot,event,args=nil,ext=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_code,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  text="**Effect:** #{k.effect}"
  text="#{text}\n\n**Additional Info:** #{k.comment}" unless k.comment.nil?
  create_embed(event,[k.dispName('**','__'),k.rarity_row],text,k.disp_color,nil,k.thumbnail(event))
end

def disp_clothing_data(bot,event,args=nil,ext=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_clothes,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  text="**Availability:** #{k.acquisition}"
  if safe_to_spam?(event,nil,1)
    atv=k.skill_bracket.clone
    for i in 0...atv.length
      m=["**Skill #{i+1}:** *#{atv[i].fullName}*"]*2
      m2=atv[i].description(0)
      m=["__#{m[0]}__","__#{m[1]}__","#{m2}"]
      m[2]="#{m2.split("\n")[0,2].join("\n")}\n\\> Lots of effects <" if !safe_to_spam?(event) && (m2.length>500 || m2.split("\n").length>8)
      text="#{text}\n\n#{m[0]}\n#{m[2]}"
    end
    text="#{text}\n\n__**Experience**__"
    for i in 0...k.exp.length
      text="#{text}\n*Level #{i+1}\u2192#{i+2}:*  #{longFormattedNumber(k.exp[i])}"
    end
    text="#{text}\n**Total EXP to reach level 10:** #{longFormattedNumber(k.exp.inject(0){|sum,x| sum + x })}"
  else
    text="#{text}\n\n__**Skills:**__\n#{k.skills.map{|q| "*#{q}*"}.join("\n")}\n\n**Total EXP to reach level 10:** #{longFormattedNumber(k.exp.inject(0){|sum,x| sum + x })}"
  end
  create_embed(event,"__**#{k.name}**__",text,k.disp_color)
end

def disp_mat_data(bot,event,args=nil,ext=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_mat,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  ftr=nil
  lists=[false,false,false,false]
  lists[0]=true if has_any?(event.message.text.downcase.split(' '),['ascension','ascensions','justascension','justascensions'])
  lists[1]=true if has_any?(event.message.text.downcase.split(' '),['costume','costumes','justcostume','justcostumes'])
  lists[2]=true if has_any?(event.message.text.downcase.split(' '),['skill','skills','justskill','justskills','active','activeskill','activeskills'])
  lists[3]=true if has_any?(event.message.text.downcase.split(' '),['skill','skills','justskill','justskills','append','appendskill','appendskills'])
  lists=[true,true,true,true] if lists.reject{|q| !q}.length<=0
  lst=[[],[],[],[]]
  fff=[]; fff2=0; fff3=0; fff4=0
  srvs=$servants.map{|q| q}
  for i in 0...srvs.length
    srvs[i].sort_data=[0,0,0,0,0,0,0]
  end
  t=Time.now
  timeshift=1; timeshift-=1 unless t.dst?
  t_na=t-60*60*timeshift
  timeshift=-8; timeshift-=1 unless t.dst?
  t_jp=t-60*60*timeshift
  matz=["Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Eternal Gear, Shell of Reminiscence, Spirit Root, Saber Piece, Saber Monument, Gem of Saber, Magic Gem of Saber, Secret Gem of Saber",
        "Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Meteor Horseshoe, Tearstone of Blood, Archer Piece, Archer Monument, Gem of Archer, Magic Gem of Archer, Secret Gem of Archer",
        "Proof of Hero, Evil Bone, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Homunculus Baby, Warhorse's Young Horn, Lancer Piece, Lancer Monument, Gem of Lancer, Magic Gem of Lancer, Secret Gem of Lancer",
        "Proof of Hero, Void's Dust, Octuplet Crystals, Claw of Chaos, Berserker Piece, Berserker Monument, Gem of Berserker, Magic Gem of Berserker, Secret Gem of Berserker",
        "Dragon Fang, Void's Dust, Meteor Horseshoe, Dragon's Reverse Scale, Rider Piece, Rider Monument, Gem of Rider, Magic Gem of Rider, Secret Gem of Rider",
        "Serpent Jewel, Void's Dust, Forbidden Page, Heart of the Foreign God, Caster Piece, Caster Monument, Gem of Caster, Magic Gem of Caster, Secret Gem of Caster",
        "Dragon Fang, Void's Dust, Seed of Yggdrasil, Ghost Lantern, Eternal Gear, Black Beast Grease, Assassin Piece, Assassin Monument, Gem of Assassin, Magic Gem of Assassin, Secret Gem of Assassin"]
  matz=matz.map{|q| q.split(', ').reject{|q2| q2 != k.name}}
  m_na=matz.rotate(t_na.wday); m_jp=matz.rotate(t_jp.wday)
  for i in 0...m_na.length
    m_na[i]=[m_na[i][0],i]; m_jp[i]=[m_jp[i][0],i]
  end
  m_na.push([m_na[0][0],7]); m_jp.push([m_jp[0][0],7])
  nextstr=''
  m_na_x=m_na.find_index{|q| q[0]==k.name}; m_na_x2=m_na.find_index{|q| q[0]==k.name && q[1]!=m_na_x}
  m_jp_x=m_jp.find_index{|q| q[0]==k.name}; m_jp_x2=m_jp.find_index{|q| q[0]==k.name && q[1]!=m_jp_x}
  if m_na_x.nil?
  elsif disp_date(t_na)==disp_date(t_jp)
    if m_na_x==0
      nextstr='Today in both NA and JP'
      t2=t_na+m_na_x2*24*60*60
      if m_na_x2==1
        nextstr="#{nextstr} - Next available tomorrow (#{disp_date(t2,1)})"
      else
        nextstr="#{nextstr} - Next available #{m_na_x2} days from now (#{disp_date(t2,1)})"
      end
    elsif m_na_x==1
      t2=t+24*60*60
      nextstr="Tomorrow (#{disp_date(t2,1)}) in both NA and JP"
    else
      t2=t+m_na_x*24*60*60
      nextstr="#{m_na_x} days from now (#{disp_date(t2,1)}) in both NA and JP"
    end
  elsif m_na_x==0 && m_jp_x==0
    nextstr='Today in both NA and JP'
    t2=t_na+m_na_x2*24*60*60
    if m_na_x2==1
      nextstr="#{nextstr}\n*NA:* Next available tomorrow (#{disp_date(t2,1)})"
    else
      nextstr="#{nextstr}\n*NA:* Next available #{m_na_x2} days from now (#{disp_date(t2,1)})"
    end
    t2=t_jp+m_jp_x2*24*60*60
    if m_jp_x2==1
      nextstr="#{nextstr}\n*JP:* Next available tomorrow (#{disp_date(t2,1)})"
    else
      nextstr="#{nextstr}\n*JP:* Next available #{m_jp_x2} days from now (#{disp_date(t2,1)})"
    end
  elsif m_na_x==0
    nextstr='*NA:* Today'
    t2=t_na+m_na_x2*24*60*60
    if m_na_x2==1
      nextstr="#{nextstr} - Next available tomorrow (#{disp_date(t2,1)})"
    else
      nextstr="#{nextstr} - Next available #{m_na_x2} days from now (#{disp_date(t2,1)})"
    end
  elsif m_na_x==1
    t2=t_na+24*60*60
    nextstr="*NA:* Tomorrow (#{disp_date(t2,1)})"
  else
    t2=t_na+m_na_x*24*60*60
    nextstr="*NA:* #{m_na_x} days from now (#{disp_date(t2,1)})"
  end
  if m_jp_x.nil? || disp_date(t_na)==disp_date(t_jp)
  elsif m_na_x==0 && m_jp_x==0
  elsif m_jp_x==0
    nextstr="#{nextstr}\n*JP:* Today"
    t2=t_jp+m_jp_x2*24*60*60
    if m_jp_x2==1
      nextstr="#{nextstr} - Next available tomorrow (#{disp_date(t2,1)})"
    else
      nextstr="#{nextstr} - Next available #{m_jp_x2} days from now (#{disp_date(t2,1)})"
    end
  elsif m_jp_x==1
    t2=t_jp+24*60*60
    nextstr="#{nextstr}\n*JP:* Tomorrow (#{disp_date(t2,1)})"
  else
    t2=t_jp+m_jp_x*24*60*60
    nextstr="#{nextstr}\n*JP:* #{m_jp_x} days from now (#{disp_date(t2,1)})"
  end
  if has_any?(event.message.text.downcase.split(' '),['mine','self'])
    if event.user.id==167657750971547648
      data_load(['devservants'])
      srvs=$dev_units.map{|q| q.clone}
      for i in 0...srvs.length
        srvs[i].sort_data=srvs[i].skill_levels.map{|q| q.split('u')[0].to_i}
        srvs[i].sort_data.push(srvs[i].ascend[0])
      end
    elsif File.exist?("#{$location}devkit/LizUserSaves/#{event.user.id}.txt")
      data_load(['donorservants'])
      srvs=$donor_units.reject{|q| q.owner_id != event.user.id}.map{|q| q.clone}
      for i in 0...srvs.length
        srvs[i].sort_data=srvs[i].skill_levels.map{|q| q.split('u')[0].to_i}
        srvs[i].sort_data.push(srvs[i].ascend[0])
      end
    end
  end
  for i in 0...srvs.length
    if srvs[i].id.to_i==srvs[i].id || srvs[i].id==1.2
      mts=[]
      mts2=[]
      rnk=['First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth']
      x=srvs[i].base_servant.ascension_mats
      srvtot=[0,0,0,0]
      for i2 in 0...x.length
        for i3 in 0...x[i2].length
          m=x[i2][i3].split(' ')
          f=m.pop
          mts.push("**#{f.gsub('x','')}** for #{rnk[i2]}") if m.join(' ')==k.name && i2<3 && lists[0] && srvs[i].sort_data[6]<=i2
          mts.push("**#{f.gsub('x','')}** for Final") if m.join(' ')==k.name && i2==3 && lists[0] && srvs[i].sort_data[6]<=i2
          mts2.push("**#{f.gsub('x','')}** for #{rnk[i2-4]} Costume") if m.join(' ')==k.name && i2>3 && lists[1]
          fff3+=f.gsub('x','').to_i if m.join(' ')==k.name && !srvs[i].availability.include?('Unavailable') && !(i2<4 && srvs[i].sort_data[6]>i2) && lists[0]
          srvtot[0]+=f.gsub('x','').to_i if m.join(' ')==k.name && i2<4 && lists[0] && srvs[i].sort_data[6]<=i2
          srvtot[1]+=f.gsub('x','').to_i if m.join(' ')==k.name && i2>3 && lists[1]
        end
      end
      lst[0].push("#{'~~' if srvs[i].availability.include?('Unavailable')}*#{srvs[i].id}#{'.' if srvs[i].id>=2}#{'-1.1' if srvs[i].id==1})* #{srvs[i].name}  -  #{mts.join(', ')}#{"  -  __#{srvtot[0]}__ total#{'~~' if srvs[i].availability.include?('Unavailable')}" if mts.length>1}") if mts.length>0
      lst[1].push("#{'~~' if srvs[i].availability.include?('Unavailable')}*#{srvs[i].id}#{'.' if srvs[i].id>=2}#{'-1.1' if srvs[i].id==1})* #{srvs[i].name}  -  #{mts2.join(', ')}#{"  -  __#{srvtot[1]}__ total" if mts2.length>1}#{'~~' if srvs[i].availability.include?('Unavailable')}") if mts2.length>0
      fff.push(srvs[i].id) if mts.length>0 || mts2.length>0
      fff2+=mts.length+mts2.length unless srvs[i].availability.include?('Unavailable')
      fff4+=srvtot[1] unless srvs[i].availability.include?('Unavailable')
    end
    if srvs[i].id.to_i==srvs[i].id
      x=srvs[i].base_servant.skill_mats
      mts=[]
      mts2=[]
      for i2 in 0...x.length
        for i3 in 0...x[i2].length
          m=x[i2][i3].split(' ')
          f=m.pop
          if m.join(' ')==k.name && lists[2] && srvs[i].sort_data[0,3].reject{|q| q>i2+1}.length>0 && i2<10
            mts.push("**#{f.gsub('x','')}** to reach L#{i2+2}")
            fff3+=srvs[i].sort_data[0,3].reject{|q| q>i2+1}.length*f.gsub('x','').to_i if m.join(' ')==k.name
            srvtot[2]+=srvs[i].sort_data[0,3].reject{|q| q>i2+1}.length*f.gsub('x','').to_i if m.join(' ')==k.name
          elsif m.join(' ')==k.name && lists[3] && srvs[i].sort_data[3,3].reject{|q| q>i2-9+1}.length>0 && i2>9
            mts2.push("**#{f.gsub('x','')}** to reach L#{i2-9+2}")
            fff3+=srvs[i].sort_data[3,3].reject{|q| q>i2-9+1}.length*f.gsub('x','').to_i if m.join(' ')==k.name
            srvtot[3]+=srvs[i].sort_data[3,3].reject{|q| q>i2-9+1}.length*f.gsub('x','').to_i if m.join(' ')==k.name
          end
        end
      end
      lst[2].push("#{'~~' if srvs[i].availability.include?('Unavailable')}*#{srvs[i].id.to_i}.)* #{srvs[i].name} #{'~~(All forms)~~' if srvs[i].id==1}  -  #{mts.join(', ')}  -  __#{srvtot[2]}__ total for all skills#{'~~' if srvs[i].availability.include?('Unavailable')}") if mts.length>0
      lst[3].push("#{'~~' if srvs[i].availability.include?('Unavailable')}*#{srvs[i].id.to_i}.)* #{srvs[i].name} #{'~~(All forms)~~' if srvs[i].id==1}  -  #{mts2.join(', ')}  -  __#{srvtot[3]}__ total for all skills#{'~~' if srvs[i].availability.include?('Unavailable')}") if mts2.length>0
      fff.push(srvs[i].id) if (mts.length>0 || mts2.length>0) && !fff.include?(srvs[i].id)
      fff2+=mts.length+mts2.length unless srvs[i].availability.include?('Unavailable')
    end
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  s2s=false if has_any?(event.message.text.downcase.split(' '),['just','noinfo','justart','blank'])
  text=''
  title=''
  unless s2s
    ftr='For an actual list of servants who need this material, use this command in PM.' unless safe_to_spam?(event)
    title="#{lst[0].length} servant#{'s' unless lst[0].length==1} use#{'s' if lst[0].length==1} this material for Ascension"
    title="#{title}\n#{lst[2].length} servant#{'s' unless lst[2].length==1} use#{'s' if lst[2].length==1} this material for Active Skill Enhancement"
    title="#{title}\n#{lst[3].length} servant#{'s' unless lst[3].length==1} use#{'s' if lst[3].length==1} this material for Append Skill Enhancement"
    title="#{title}\n#{lst[1].length} servant#{'s' unless lst[1].length==1} use#{'s' if lst[1].length==1} this material for Costumes" if lst[1].length>0
    text="#{fff.length} total servants use this material"
    text="#{text}\n#{fff2} total uses for this material"
    text="#{text}\n#{fff3} total copies of this material are required to max everyone" if fff3>0
    text="#{text}\n#{fff4} total copies of this material are required to get all costumes" if fff4>0
    text="#{text} (not included in above total)" if fff4>0 && fff3>0
  end
  mmkk=[]
  if k.name[0,7]=='Gem of '
    mmkk.push("#{k.name.gsub('Gem of ','')} Gem")
    mmkk.push("Blue #{k.name.gsub('Gem of ','')} Gem")
    mmkk.push("Blue #{k.name}")
  elsif k.name[0,13]=='Magic Gem of '
    mmkk.push("Magic #{k.name.gsub('Magic Gem of ','')} Gem")
    mmkk.push("Red #{k.name.gsub('Magic Gem of ','')} Gem")
    mmkk.push("Red Gem of #{k.name.gsub('Magic Gem of ','')}")
  elsif k.name[0,14]=='Secret Gem of '
    mmkk.push("Secret #{k.name.gsub('Secret Gem of ','')} Gem")
    mmkk.push("Yellow #{k.name.gsub('Secret Gem of ','')} Gem")
    mmkk.push("Yellow Gem of #{k.name.gsub('Secret Gem of ','')}")
    mmkk.push("#{k.name.gsub('Secret Gem of ','')} Cookie")
    mmkk.push("Cookie of #{k.name.gsub('Secret Gem of ','')}")
  end
  text="__**Totals**__\n#{text}\n\n__**Availability through Training Grounds**__\n#{nextstr}" if !s2s && nextstr.length>0
  create_embed(event,["__**#{k.name}**__#{"\n#{mmkk.join("\n")}" if mmkk.length>0}",title],text,0xED619A,ftr,k.thumbnail(event,bot))
  return nil unless s2s
  str=''
  str="__**Ascension uses for #{k.name}**__ (#{lst[0].length} total)" if lists[0]
  markunknown=false
  if lst[0].length<=0
    str="~~**#{k.name} is not used for Ascension**~~" if lists[0]
  else
    for i in 0...lst[0].length
      str=extend_message(str,lst[0][i],event)
      markunknown=true if lst[0][i].include?('total~~')
    end
  end
  if lst[2].length<=0
    str=extend_message(str,"~~**#{k.name} is not used for Active Skill Enhancement**~~",event,2) if lists[2]
  else
    str=extend_message(str,"__**Active Skill Enhancement uses for #{k.name}**__ (#{lst[2].length} total)",event,2)
    for i in 0...lst[2].length
      str=extend_message(str,lst[2][i],event)
      markunknown=true if lst[2][i].include?('total~~')
    end
  end
  if lst[3].length<=0
    str=extend_message(str,"~~**#{k.name} is not used for Append Skill Enhancement**~~",event,2) if lists[3]
  else
    str=extend_message(str,"__**Append Skill Enhancement uses for #{k.name}**__ (#{lst[3].length} total)",event,2)
    for i in 0...lst[3].length
      str=extend_message(str,lst[3][i],event)
      markunknown=true if lst[3][i].include?('total~~')
    end
  end
  unless lst[1].length<=0
    str=extend_message(str,"__**Costume uses for #{k.name}**__ (#{lst[1].length} total)",event,2)
    for i in 0...lst[1].length
      str=extend_message(str,lst[1][i],event)
      markunknown=true if lst[1][i].include?('total~~')
    end
  end
  str=extend_message(str,"__*Totals*__\n#{fff.length} total servants use this material\n#{fff2} total uses for this material#{"\n#{longFormattedNumber(fff3)} total copies of this material are required to max everyone" if fff3>0}#{"\n#{longFormattedNumber(fff4)} total copies of this material are required to get all costumes#{' (not included in above total)' if fff3>0}" if fff4>0}#{"\n~~Unavailable servants aren't counted in the totals~~" if markunknown}",event,2)
  str=extend_message(str,"__*Availability through Training Grounds*__\n#{nextstr}",event,2) if nextstr.length>0
  event.respond str
end

bot.command(:servant, aliases: [:data,:unit,:srv]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif args[0].downcase=='feh' && !find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot).nil?
    unt=find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot)
    disp_FEH_based_stats(bot,event,unt)
    return nil
  end
  disp_servant_all(bot,event,args)
end

bot.command(:stats, aliases: [:stat]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif args[0].downcase=='feh' && !find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot).nil?
    unt=find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot)
    disp_FEH_based_stats(bot,event,unt)
    return nil
  end
  disp_servant_stats(bot,event,args)
end

bot.command(:tinystats, aliases: [:smallstats,:smolstats,:microstats,:squashedstats,:sstats,:statstiny,:statssmall,:statssmol,:statsmicro,:statssquashed,:statss,:stattiny,:statsmall,:statsmol,:statmicro,:statsquashed,:sstat,:tinystat,:smallstat,:smolstat,:microstat,:squashedstat,:tiny,:small,:micro,:smol,:squashed,:littlestats,:littlestat,:statslittle,:statlittle,:little]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif args[0].downcase=='feh' && find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot).length>0
    unt=find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot)
    disp_FEH_based_stats(bot,event,unt)
    return nil
  end
  disp_servant_stats(bot,event,args,-1,true)
end

bot.command(:skills, aliases: [:skils]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args[0].nil?
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  elsif ['mats','ascension','enhancement','enhance','materials','mat','material'].include?(args[0].downcase)
    args.shift
    disp_servant_mats(bot,event,args,-1,true)
    return nil
  end
  disp_servant_skills(bot,event,args)
  return nil
end

bot.command(:traits, aliases: [:trait]) do |event, *args|
  return nil if overlap_prevent(event)
  name=args.join(' ')
  if !find_data_ex(:find_servant,name,event,true).nil?
    disp_servant_traits(bot,event,args)
  elsif !find_data_ex(:find_enemy,name,event,true).nil?
    disp_enemy_traits(bot,event,args)
  elsif !find_data_ex(:find_servant,name,event).nil?
    disp_servant_traits(bot,event,args)
  elsif !find_data_ex(:find_enemy,name,event).nil?
    disp_enemy_traits(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command(:np, aliases: [:noble,:phantasm,:noblephantasm]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_np(bot,event,args)
  return nil
end

bot.command(:ce, aliases: [:craft,:essance,:craftessance,:essence,:craftessence]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args[0].nil?
  elsif ['valentines','valentine','chocolate',"valentine's"].include?(args[0])
      args.shift
      disp_servant_ce(bot,event,args,-1,true)
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args,true)
    return nil
  end
  name=args.join(' ')
  if !find_data_ex(:find_ce,name,event,true).nil?
    disp_craft_essance(bot,event,args)
  elsif !find_data_ex(:find_servant,name,event,true).nil?
    disp_servant_ce(bot,event,args)
  elsif !find_data_ex(:find_ce,name,event).nil?
    disp_craft_essance(bot,event,args)
  elsif !find_data_ex(:find_servant,name,event).nil?
    disp_servant_ce(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command(:bond, aliases: [:bondce]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_ce(bot,event,args)
  return nil
end

bot.command(:valentines, aliases: [:valentine,:valentinesce,:cevalentines,:valentinece,:cevalentine,:chocolate]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_ce(bot,event,args,-1,true)
end

bot.command(:mats, aliases: [:ascension,:enhancement,:enhance,:materials]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_mats(bot,event,args)
  return nil
end

bot.command(:skill, aliases: [:skil]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args[0].nil?
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  elsif ['mats','ascension','enhancement','enhance','materials','mat','material'].include?(args[0].downcase)
    args.shift
    disp_servant_mats(bot,event,args,false,true)
    return nil
  end
  disp_skill_data(bot,event,args)
end

bot.command(:command) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args[0].nil?
  elsif args[0].downcase=='list'
    args.shift
    help_text(event,bot,args[0],args[1]) if args.length<2
    help_text(event,bot,args[0],args[1],args[2,args.length-2]) if args.length>1
    return nil
  end
  disp_code_data(bot,event,args)
end

bot.command(:commandcode) do |event, *args|
  return nil if overlap_prevent(event)
  disp_code_data(bot,event,args)
end

bot.command(:mysticcode, aliases: [:mysticode,:mystic,:clothes,:clothing]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_clothing_data(bot,event,args)
end

bot.command(:code) do |event, *args|
  return nil if overlap_prevent(event)
  find_best_match(args.join(' '),bot,event,false,false,3)
end

bot.command(:find, aliases: [:search,:lookup]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  if args.nil? || args.length<=0
  elsif ['skill','skills','skil','skils'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  elsif ['ce','ces','craft','crafts','essence','essences'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args,true)
    return nil
  end
  find_servants(bot,event,args)
end

bot.command(:sort, aliases: [:list]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['aliases','alias'].include?(args[0].downcase) && event.user.id==167657750971547648
    data_load()
    nicknames_load()
    $aliases.uniq!
    $aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
    open("#{$location}devkit/FGONames.txt", 'w') { |f|
      for i in 0...$aliases.length
        f.puts "#{$aliases[i].to_s}#{"\n" if i<$aliases.length-1}"
      end
    }
    event.respond 'The alias list has been sorted alphabetically'
    return nil
  end
  data_load(['library'])
  sort_servants(bot,event,args)
end

bot.command(:mat, aliases: [:material]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_mat_data(bot,event,args)
  return nil
end

bot.command(:random, aliases: [:rand]) do |event|
  return nil if overlap_prevent(event)
  data_load(['library'])
  generate_random_servant(event,bot)
end

bot.command(:alts, aliases: [:alt]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_servant_alts(event,bot,args)
end

bot.command(:deck) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  generate_deck(event,bot,args)
end

bot.command(:addalias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  add_new_alias(bot,event,newname,unit,modifier,modifier2)
  return nil
end

bot.command(:alias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  data_load(['library'])
  add_new_alias(bot,event,newname,unit,modifier,modifier2,1)
  return nil
end

bot.command(:deletealias, aliases: [:removealias]) do |event, name|
  return nil if overlap_prevent(event)
  nicknames_load()
  if name.nil?
    event.respond "I can't delete nothing, silly!" if name.nil?
    return nil
  elsif event.user.id != 167657750971547648 && event.server.nil?
    event.respond 'Only my developer is allowed to use this command in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  end
  saliases=true
  saliases=false if event.user.id==167657750971547648 # only my developer can delete global aliases
  canremove=false
  k=find_best_match(name,bot,event,true,false,0)
  k=k[0] if !k.nil? && k.is_a?(Array)
  cmpr=[]
  if k.nil?
    k=find_best_match(name,bot,event,false,false,0)
    if k.nil?
      event.respond "#{name} is not an alias, silly!"
    else
      f=k.alias_list(bot,event,saliases,true)
      f=f.reject{|q| q[0,name.length].downcase != name.downcase}
      if f.length<=0
        event.respond "You cannot delete a global alias."
      else
        event.respond "Please use a whole alias, not a partial one.  The following aliases begin with the text you typed:\n#{f.join("\n")}"
      end
    end
    return nil
  elsif !k.alias_list(bot,event,saliases,true).map{|q| q.downcase}.include?(name.downcase) && event.user.id != 167657750971547648
    event.respond "You cannot delete a global alias."
    return nil
  else
    k2="#{k.objt}"
    baseunt="#{k.dispName}#{k.emoji(bot,true)}"
    cmpr.push(k.fullName)
    cmpr.push(k.id) unless k.id.nil?
  end
  kx=0
  kx=event.server.id unless event.server.nil?
  alz=$aliases.map{|q| q}
  globalattempt=false
  for i in 0...alz.length
    if alz[i][0]==k2 && alz[i][1].downcase==name.downcase && cmpr.include?(alz[i][2])
      if alz[i][3].nil?
        if event.user.id==167657750971547648
          alz[i]=nil
        else
          globalattempt=true
        end
      elsif alz[i][3].include?(kx)
        globalattempt=false
        alz[i][3]=alz[i][3].reject{|q| q==kx}
        alz[i]=nil if alz[i][3].length<=0
      end
    end
  end
  if globalattempt
    event.respond "You cannot delete a global alias."
    return nil
  end
  alz.uniq!
  alz.compact!
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  logchn=log_channel()
  str=''
  if event.server.nil?
    str="**PM with dev:**"
  elsif Shardizard<0
    str="**Server:** #{event.server.name} (#{event.server.id}) - Smol Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  else
    str="**Server:** #{event.server.name} (#{event.server.id}) - #{shard_data(0)[Shardizard]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  end
  str="#{str} #{event.user.distinct} (#{event.user.id})"
  str="#{str}\n~~**#{k2} Alias:** #{name} for #{baseunt}~~ "
  if rand(1000)==0
    str="#{str}**YEETED**"
  else
    str="#{str}**DELETED**"
  end
  bot.channel(logchn).send_message(str)
  event.respond "#{name} has been removed from #{baseunt}'s aliases."
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/FGONames.txt", 'w') { |f|
    f.puts alz.map{|q| q.to_s}.join("\n")
  }
  bot.channel(logchn).send_message('Alias list saved.')
  nicknames_load()
  unless !$aliases[-1][2].is_a?(String) || $aliases[-1][2]<"Warhorse's Young Horn"
    open("#{$location}devkit/FGONames2.txt", 'w') { |f|
      f.puts alz.map{|q| q.to_s}.join("\n")
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
  return nil
end

bot.command(:saliases, aliases: [:serveraliases]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  list_aliases(bot,event,args,1)
  return nil
end

bot.command(:aliases, aliases: [:checkaliases,:seealiases]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  list_aliases(bot,event,args)
  return nil
end

bot.command(:today, aliases: [:now,:todayinfgo,:today_in_fgo]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_next(bot,event,args,true)
end

bot.command(:tomorrow, aliases: [:tommorrow,:tomorow,:tommorrow]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_next(bot,event,args,-1)
end

bot.command(:dailies, aliases: [:daily]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_next(bot,event,args)
end

bot.command(:next, aliases: [:schedule]) do |event|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_next_2(bot,event)
end

bot.command(:xp, aliases: [:exp,:level]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  level(event,bot,args)
end

bot.command(:plxp, aliases: [:plexp,:pllevel,:plevel,:pxp,:pexp]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  level(event,bot,args,1)
end

bot.command(:sxp, aliases: [:sexp,:slevel]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  level(event,bot,args,2)
end

bot.command(:cxp, aliases: [:cexp,:ceexp,:clevel,:celevel]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  level(event,bot,args,3)
end

bot.command(:art, aliases: [:artist]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  disp_art(bot,event,args)
end

bot.command(:riyo) do |event, *args|
  return nil if overlap_prevent(event)
  disp_art(bot,event,args,true)
end

bot.command(:affinity,  aliases: [:affinities,:affinitys,:effective,:eff,:resist,:resistance,:resistances,:res]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  affinity_data(event,bot,args)
end

bot.command(:support, aliases: [:supports,:friends,:friend,:profile]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  support_lineup(event,bot,args)
end

bot.command(:embeds, aliases: [:embed]) do |event|
  return nil if overlap_prevent(event)
  metadata_load()
  if $embedless.include?(event.user.id)
    for i in 0...$embedless.length
      $embedless[i]=nil if $embedless[i]==event.user.id
    end
    $embedless.compact!
    event.respond 'You will now see my replies as embeds again.'
  else
    $embedless.push(event.user.id)
    event.respond 'You will now see my replies as plaintext.'
  end
  metadata_save()
  return nil
end

bot.command(:tools, aliases: [:links,:tool,:link,:resources,:resource]) do |event|
  return nil if overlap_prevent(event)
  data_load(['library'])
  show_tools(bot,event)
end

bot.command(:prefix) do |event, prefix|
  return nil if overlap_prevent(event)
  if prefix.nil?
    event.respond 'No prefix was defined.  Try again'
    return nil
  elsif event.server.nil?
    event.respond 'This command is not available in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  elsif ['feh!','feh?','f?','e?','h?','fgo!','fgo?','fg0!','fg0?','liz!','liz?','iiz!','iiz?','fate!','fate?','dl!','dl?','fe!','fe14!','fef!','fe13!','fea!','fe?','fe14?','fef?','fe13?','fea?'].include?(prefix.downcase)
    event.respond "That is a prefix that would conflict with either myself or another one of my developer's bots."
    return nil
  end
  @prefixes[event.server.id]=prefix
  prefixes_save()
  event.respond "This server's prefix has been saved as **#{prefix}**"
end

bot.command(:safe, aliases: [:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f|
  return nil if overlap_prevent(event)
  f='' if f.nil?
  metadata_load()
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529].include?(event.server.id)
    event.respond 'It is safe for me to send long replies here because this is one of my emoji servers.'
  elsif Shardizard==4
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
  elsif $spam_channels[0].include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      $spam_channels[0].delete(event.channel.id)
      $spam_channels[1].delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send long replies to.'
      event << ''
      event << 'If you wish to turn them partially off (so commands like `skills` show all data but commands like `art` do not), ask a server mod to type `FGO!spam semi` in this channel.'
      event << 'If you wish to turn them entirely off, ask a server mod to type `FGO!spam off` in this channel.'
    end
  elsif is_mod?(event.user,event.server,event.channel,1) && ['on','yes','true'].include?(f.downcase)
    metadata_load()
    $spam_channels[0].push(event.channel.id)
    $spam_channels[1].delete(event.channel.id)
    metadata_save()
    event.respond 'This channel is now marked as safe for me to send long replies to.'
  elsif event.channel.name.downcase.include?('fate') && event.channel.name.downcase.include?('grand') && event.channel.name.downcase.include?('order')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes the words "Fate", "Grand", and "Order".'
  elsif event.channel.name.downcase.include?('fate') && event.channel.name.downcase.include?('go')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes the words "Fate", "GO".'
  elsif event.channel.name.downcase.include?('fgo')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes "FGO".'
  elsif $spam_channels[1].include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      $spam_channels[0].delete(event.channel.id)
      $spam_channels[1].delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send __**certain**__ long replies to.'
      event << ''
      event << 'If you wish to turn them entirely on, ask a server mod to type `FGO!spam on` in this channel.'
      event << 'If you wish to turn them entirely off, ask a server mod to type `FGO!spam off` in this channel.'
    end
  elsif is_mod?(event.user,event.server,event.channel,1) && ['semi','demi','pseudo','half'].include?(f.downcase)
    metadata_load()
    $spam_channels[0].delete(event.channel.id)
    $spam_channels[1].push(event.channel.id)
    metadata_save()
    event.respond 'This channel is now marked as safe for me to send __**certain**__ long replies to.'
  else
    event << 'It is not safe for me to send long replies here.'
    event << ''
    event << 'If you wish to change that, try one of the following:'
    event << '- Change the channel name to "bots".'
    event << '- Change the channel name to include the word "bot" and one of the following words: "spam", "command(s)", "channel".'
    event << '- Have a server mod type `FGO!spam on` in this channel.'
    event << ''
    event << 'If you wish to make it so certain long replies appear, such as the longer form of the `skills` command, try one of the following:'
    event << '- Change the channel name to "FGO".'
    event << '- Change the channel name to include the word "Fate" and the word "GO".'
    event << '- Change the channel name to include the words "Fate", "Grand", and "Order".'
    event << '- Have a server mod type `FGO!spam semi` in this channel.'
  end
end

bot.command(:channellist, aliases: [:channelist,:spamchannels,:spamlist]) do |event|
  return nil if overlap_prevent(event)
  if event.server.nil?
    event.respond "Yes, it is safe to spam here."
    return nil
  end
  sfe=[[],[]]
  for i in 0...event.server.channels.length
    chn=event.server.channels[i]
    if safe_to_spam?(event,chn)
      sfe[0].push(chn.mention)
    elsif safe_to_spam?(event,chn,1)
      sfe[1].push(chn.mention)
    end
  end
  event << '__**All long replies are safe**__'
  event << sfe[0].join("\n")
  event << 'In PM with any user'
  if sfe[1].length>0
    event << ''
    event << '__**Certain long replies are safe**__'
    event << sfe[1].join("\n")
  end
end

bot.command(:bugreport, aliases: [:suggestion,:feedback]) do |event, *args|
  return nil if overlap_prevent(event)
  x=['liz!','liz?','fate!','fate?','fgo!','fgo?']
  x.push(@prefixes[event.server.id]) unless event.server.nil? || @prefixes[event.server.id].nil?
  bug_report(bot,event,args,Shards,shard_data(0),'Shard',x,502288368777035777)
end

bot.command(:invite) do |event, user|
  return nil if overlap_prevent(event)
  usr=event.user
  txt="**You can invite me to your server with this link: <https://goo.gl/ox9CxB>**\nTo look at my source code: <https://github.com/Rot8erConeX/LizBot/blob/master/LizBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/MarketingLiz.png"
  user_to_name="you"
  user=nil if event.message.mentions.length<=0 && user.to_i.to_s != user
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

bot.command(:donation, aliases: [:donate]) do |event, uid|
  return nil if overlap_prevent(event)
  uid="#{event.user.id}" if uid.nil? || uid.length.zero?
  if /<@!?(?:\d+)>/ =~ uid
    uid=event.message.mentions[0].id
  else
    uid=uid.to_i
    uid=event.user.id if uid==0
  end
  g=get_donor_list()
  if uid==167657750971547648
    n=["#{bot.user(uid).distinct} is","He"]
    n=["You are","You"] if uid==event.user.id
    create_embed(event,"#{n[0]} my developer.","#{n[1]} can have whatever permissions #{n[1].downcase} want#{'s' unless uid==event.user.id} to have.",0x00DAFA)
  elsif uid==78649866577780736
    n=["#{bot.user(uid).distinct} is","He"]
    n=["You are","You"] if uid==event.user.id
    create_embed(event,"#{n[0]} my data input guy.","#{n[1]} can have whatever permissions #{n[1].downcase} want#{'s' unless uid==event.user.id} to have.",0x9D2A2F)
  elsif g.map{|q| q[0]}.include?(uid)
    n="#{bot.user(uid).distinct} is"
    n="You are" if uid==event.user.id
    g=g[g.find_index{|q| q[0]==uid}]
    str=""
    n4=bot.user(uid).name
    n4=n4[0,[3,n4.length].min]
    n4=" #{n4}" if n4.length<2
    n2=n4.downcase
    n3=[]
    for i in 0...n2.length
      if "abcdefghijklmnopqrstuvwxyz".include?(n2[i])
        n3.push(9*("abcdefghijklmnopqrstuvwxyz".split(n2[i])[0].length)+25)
        n3[i]+=5 if n4[i]!=n2[i]
      elsif n2[i].to_i.to_s==n2[i]
        n3.push(n2[i].to_i*2+1)
      else
        n3.push(0)
      end
    end
    color=n3[0]*256*256+n3[1]*256+n3[2]
    str="**Tier 1:** Access to the donor-exclusive channel in my debug server.\n\u2713 This perk cannot be checked dynamically.\nYou can check if it was given to you by clicking this channel link: <#590642838497394689>" if g[2].max>=1
    str="#{str}\n\n**Tier 2:** Ability to give server-specific aliases in any server\n\u2713 Given" if g[2].max>=2
    if g[2][1]>=3
      if g[3].nil? || g[3].length.zero? || g[4].nil? || g[4].length.zero?
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected."
      elsif g[4][1]=='-'
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2713 May be given via another bot."
      elsif !File.exist?("#{$location}devkit/EliseImages/#{g[4][1]}.png")
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected.\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][1]}"
      else
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2713 Given\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][1]}"
      end
    end
    dul=$donor_triggers.find_index{|q| q[1]==uid}
    dul=$donor_triggers[dul].map{|q| q} unless dul.nil?
    dul=[] if dul.nil?
    if g[2][0]>=4
      if !File.exist?("#{$location}devkit/EliseUserSaves/#{uid}.txt")
        str="#{str}\n\n**Tier 4:** Servant tracking\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected."
      else
        str="#{str}\n\n**Tier 4:** Servant tracking\n\u2713 Given\n*Trigger word:* #{dul[0]}'s"
      end
    end
    if g[2][0]>=5
      if !File.exist?("#{$location}devkit/EliseUserSaves/#{uid}.txt")
        str="#{str}\n\n**Tier 5:** __*Colored*__ servant tracking\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected."
      elsif dul[2].nil?
        str="#{str}\n\n**Tier 5:** __*Colored*__ servant tracking\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected."
      else
        str="#{str}\n\n**Tier 5:** __*Colored*__ servant tracking\n\u2713 Given\n*Color of choice:* #{dul[2]}"
        color=dul[2].hex
      end
    end
    create_embed(event,"__**#{n} a Tier #{g[2][1]} donor.**__",str,color)
  end
  donor_embed(bot,event)
end

bot.command(:shard, aliases: [:attribute]) do |event, i, j|
  return nil if overlap_prevent(event)
  if j.to_i.to_s==j
    j=j.to_i
    if j>256*256 && i.to_i.to_s==i && i.to_i<=256*256
      k=j*1
      j=i.to_i
      i=k*1
    end
  else
    j=Shards*1
  end
  if (i.to_i.to_s==i || i.to_i==i) && i.to_i>256*256
    srv=(bot.server(i.to_i) rescue nil)
    if i.to_i==327237968047898624 && [4,5].include?(j)
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[0]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[0]} Shards." if j == Shards
    elsif i.to_i==327237968047898624 && j<=3
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[2]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[2]} Shards." if j == Shards
    elsif i.to_i==327237968047898624
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[4]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[4]} Shards." if j == Shards
    elsif Shardizard ==4 && j != Shards
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif Shardizard ==4
      event.respond "That server uses/would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      event.respond "I am not in that server, but it would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards #{"(in a system of #{j} shards)" if j != Shards}."
    elsif j != Shards
      event.respond "In a system of #{j} shards, *#{srv.name}* would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    else
      event.respond "*#{srv.name}* uses #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    end
    return nil
  elsif i.to_i.to_s==i
    j=i.to_i*1
    i=0
  end
  if event.server.id==327237968047898624 && [4,5].include?(j)
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[0]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[0]} Shards." if j == Shards
    return nil
  elsif event.server.id==327237968047898624 && j<=3
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[2]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[2]} Shards." if j == Shards
    return nil
  elsif event.server.id==327237968047898624
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[4]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[4]} Shards." if j == Shards
    return nil
  end
  event.respond "This is the debug mode, which uses #{shard_data(0,false,j)[4]} Shards." if Shardizard==4
  event.respond "PMs always use #{shard_data(0,true,j)[0]} Shards." if event.server.nil? && Shardizard != 4
  event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || Shardizard==4 || j == Shards
  event.respond "This server uses #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || Shardizard==4 || j != Shards
end

bot.command(:status, aliases: [:avatar,:avvie]) do |event, *args|
  return nil if overlap_prevent(event)
  t=Time.now
  timeshift=6
  t-=60*60*timeshift
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 # only work when used by the developer
    bot.game=args.join(' ')
    event.respond 'Status set.'
    return nil
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    event << "Current avatar: #{bot.user(502288364838322176).avatar_url}"
    event << "Servant in avatar: #{$avvie_info[0]}"
    event << ''
    event << "Current status:"
    event << "[Playing] #{$avvie_info[1]}"
    event << ''
    event << "Reason: #{$avvie_info[2]}" unless $avvie_info[2].length.zero?
    event << ''
    event << "Dev's timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}"
  else
    create_embed(event,'',"Servant in avatar: #{$avvie_info[0]}\n\nCurrent status:\n[Playing] #{$avvie_info[1]}#{"\n\nReason: #{$avvie_info[2]}" unless $avvie_info[2].length.zero?}\n\n[For a full calendar of avatars, click here](https://docs.google.com/spreadsheets/d/1j-tdpotMO_DcppRLNnT8DN8Ftau-rdQ-ZmZh5rZkZP0/edit?usp=sharing)",(t.day*7+t.month*21*256+(t.year-2000)*10*256*256),"Dev's timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}",bot.user(502288364838322176).avatar_url)
  end
  return nil
end

bot.command(:sendmessage, from: 167657750971547648) do |event, channel_id, *args| # sends a message to a specific channel
  return nil if overlap_prevent(event)
  dev_message(bot,event,channel_id,[78649866577780736])
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user
  return nil if overlap_prevent(event)
  dev_pm(bot,event,user_id,[78649866577780736])
end

bot.command(:ignoreuser, from: 167657750971547648) do |event, user_id| # causes Liz to ignore the specified user
  return nil if overlap_prevent(event)
  bliss_mode(bot,event,user_id)
end

bot.command(:leaveserver, from: 167657750971547648) do |event, server_id| # forces Liz to leave a server
  return nil if overlap_prevent(event)
  walk_away(bot,event,server_id)
end

bot.command(:backupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  $aliases.uniq!
  $aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  nzzzzz=$aliases.map{|a| a}
  open("#{$location}devkit/FGONames2.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event.respond 'Alias list has been backed up.'
end

bot.command(:restorealiases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,bot.profile.id].include?(event.user.id) || event.channel.id==502288368777035777
  if File.exist?("#{$location}devkit/FGONames2.txt")
    b=[]
    File.open("#{$location}devkit/FGONames2.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  nzzzzz=b.uniq
  nz=nzzzzz.reject{|q| q[0]!='Servant'}
  if nz[nz.length-1][2]<295
    event << 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
    if File.exist?("#{$location}devkit/FGONames3.txt")
      b=[]
      File.open("#{$location}devkit/FGONames3.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    nzzzzz=b.uniq
  else
    event << 'Last backup of the alias list being used.'
  end
  open("#{$location}devkit/FGONames.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event << 'Alias list has been restored from backup.'
end

bot.command(:cleanupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  event.channel.send_temporary_message('Please wait...',10) rescue nil
  nicknames_load()
  nmz=$aliases.map{|q| q}
  k=0
  k2=0
  for i in 0...nmz.length
    unless nmz[i][3].nil?
      for i2 in 0...nmz[i][3].length
        srv=(bot.server(nmz[i][3][i2]) rescue nil)
        if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
          k+=1
          nmz[i][3][i2]=nil
        end
      end
      nmz[i][3].compact!
      nmz[i]=nil if nmz[i][3].length<=0
    end
  end
  nmz.compact!
  open("#{$location}devkit/FGONames.txt", 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:sortaliases, from: 167657750971547648) do |event, *args|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  $aliases.uniq!
  $aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/FGONames.txt", 'w') { |f|
    for i in 0...$aliases.length
      f.puts "#{$aliases[i].to_s}#{"\n" if i<$aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command(:update) do |event|
  data_load(['library'])
  update_howto(event,bot)
end

bot.command(:devedit, aliases: [:dev_edit], from: 167657750971547648) do |event, cmd, *args|
  return nil if overlap_prevent(event)
  if File.exist?("#{$location}devkit/LizUserSaves/#{event.user.id}.txt")
    event.respond "This command is to allow the developer to edit his servants.  Your version of the command is `FGO!edit`"
  end
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  data_load(['library'])
  dev_edit(bot,event,args,cmd)
end

bot.command(:edit) do |event, cmd, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  donor_edit(bot,event,args,cmd)
end

bot.command(:snagstats) do |event, f, f2|
  return nil if overlap_prevent(event)
  data_load(['library'])
  snagstats(event,bot,f,f2)
end

bot.command(:reload, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,141260274144509952].include?(event.user.id) || [502288368777035777,532083509083373583].include?(event.channel.id)
  event.respond "Reload what?\n1.) Aliases, from backups#{" (unless includes the word \"git\")\n2.) Groups, from GitHub\n3.) Data, from GitHub (include \"subset\" in your message to also reload DLSkillSubsets)" if [167657750971547648,141260274144509952].include?(event.user.id)}#{"\n4.) Source code, from GitHub (include the word \"all\" to also reload rot8er_functs.rb)\n5.) Crossover data\n6.) Libraries, from code\n7.) Avatars, from GitHub" if event.user.id==167657750971547648}\nYou can include multiple numbers to load multiple things."
  event.channel.await(:bob, from: event.user.id) do |e|
    reload=false
    if e.message.text.include?('1')                                                                    # Aliases
      if e.message.text.downcase.include?('git') && [167657750971547648,141260274144509952].include?(event.user.id)
        download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGONames.txt")
        IO.copy_stream(download, "FGOTemp.txt")
        if File.size("FGOTemp.txt")>100 && Shardizard<0
          b=[]
          File.open("FGOTemp.txt").each_line.with_index do |line, idx|
            b.push(eval line)
          end
          nicknames_load(-1)
          b2=$aliases.reject{|q| !q[0].include?('*')}
          b3=$aliases.reject{|q| q[3].nil? || !q[3].include?(484574202226147334)}
          b=b.reject{|q| b2.map{|q2| [q2[0].gsub('*',''),q2[1],q2[2]]}.include?([q[0],q[1],q[2]])}
          b=b.reject{|q| b3.map{|q2| [q2[0],q2[1],q2[2]]}.include?([q[0],q[1],q[2]])}
          for i in 0...b2.length
            b.push(b2[i])
          end
          for i in 0...b3.length
            b.push(b3[i])
          end
          b.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
          b=b.map{|q| "#{q.to_s}\n"}
          open("DLNames.txt", 'w') { |f|
            f.puts b.join('')
          }
          open("DLNames2.txt", 'w') { |f|
            f.puts b.join('')
          }
          e.respond 'Alias list has been restored from GitHub, and placed in the backup as well.'
        elsif File.size("FGOTemp.txt")>100
          b=[]
          File.open("FGOTemp.txt").each_line.with_index do |line, idx|
            b.push(line)
          end
          open("FGONames.txt", 'w') { |f|
            f.puts b.join('')
          }
          open("FGONames2.txt", 'w') { |f|
            f.puts b.join('')
          }
          e.respond 'Alias list has been restored from GitHub, and placed in the backup as well.'
        else
          e.respond 'Alias list not loaded.  File too small.'
        end
        reload=true
      else
        if File.exist?("#{$location}devkit/FGONames2.txt")
          b=[]
          File.open("#{$location}devkit/FGONames2.txt").each_line do |line|
            b.push(eval line)
          end
        else
          b=[]
        end
        nzzzzz=b.uniq
        nz=nzzzzz.reject{|q| q[0]!='Adventurer'}
        if !nz[nz.length-1][2].is_a?(String) || nz[nz.length-1][2]<"Warhorse's Young Horn"
          e.respond 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
          if File.exist?("#{$location}devkit/FGONames3.txt")
            b=[]
            File.open("#{$location}devkit/FGONames3.txt").each_line do |line|
              b.push(eval line)
            end
          else
            b=[]
          end
          nzzzzz=b.uniq
        else
          e.respond 'Last backup of the alias list being used.'
        end
        open("#{$location}devkit/FGONames.txt", 'w') { |f|
          for i in 0...nzzzzz.length
            f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
          end
        }
        e.respond 'Alias list has been restored from backup.'
        reload=true
      end
    end
    if e.message.text.include?('3') && [167657750971547648,141260274144509952].include?(event.user.id) # Data
      event.channel.send_temporary_message('Loading.  Please wait 5 seconds...',3) rescue nil
      to_reload=['Servants','CraftEssences','CommandCodes','Skills','Enemies','SkillSubsets','Mats','DevServants','Clothes']
      stx=''
      for i in 0...to_reload.length
        download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/DL#{to_reload[i]}.txt")
        IO.copy_stream(download, "FGOTemp.txt")
        if to_reload[i]=='Skills' && File.size("FGOTemp.txt")<File.size("FGOSkills.txt")*2/3
          stx='Skills were not reloaded because the file was loaded from the wrong sheet.'
        elsif to_reload[i]=='SkillSubsets' && File.size("FGOTemp.txt")<File.size("FGOSkillSubsets.txt") && !e.message.text.downcase.include?('subset')
        elsif File.size("FGOTemp.txt")>100
          b=[]
          File.open("FGOTemp.txt").each_line.with_index do |line, idx|
            b.push(line)
          end
          open("FGO#{to_reload[i]}.txt", 'w') { |f|
            f.puts b.join('')
          }
        end
      end
      stx="#{stx}#{"\n" if stx.length>0}DLSkillSubsets also reloaded" if e.message.text.include?('subset')
      e.respond "New data loaded.\n#{stx}"
      reload=true
    end
    if e.message.text.include?('4') && [167657750971547648].include?(event.user.id)                    # Source Code
      download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/rot8er_functs.rb")
      IO.copy_stream(download, "FGOTemp.txt")
      if File.size("FGOTemp.txt")>100 && e.message.text.include?('all')
        b=[]
        File.open("FGOTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("rot8er_functs.rb", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/LizClassFunctions.rb")
      IO.copy_stream(download, "FGOTemp.txt")
      if File.size("FGOTemp.txt")>100
        b=[]
        File.open("FGOTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("LizClassFunctions.rb", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/LizBot.rb")
      IO.copy_stream(download, "FGOTemp.txt")
      if File.size("FGOTemp.txt")>100
        if File.exist?("#{$location}devkit/BotTokens.txt")
          b2=[]
          File.open("#{$location}devkit/BotTokens.txt").each_line do |line|
            b2.push(line.split(' # ')[0])
          end
        else
          b2=[]
        end
        if b2.length>0
          b=[]
          File.open("FGOTemp.txt").each_line.with_index do |line, idx|
            if idx<100
              b.push(line.gsub('>Token<',b2[2]).gsub('>Debug Token<',b2[-1]).gsub('>Smol Token<',b2[-3]).gsub('>Location<',$location))
            else
              b.push(line)
            end
          end
          open("LizBot.rb", 'w') { |f|
            f.puts b.join('')
          }
          e.respond 'New source code loaded.'
          reload=true
        end
      end
    end
    if e.message.text.include?('5') && [167657750971547648].include?(event.user.id)                    # Crossdata
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHUnits.txt")
      IO.copy_stream(download, "FGOTemp.txt")
      if File.size("FGOTemp.txt")>100
        b=[]
        File.open("FGOTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FEHUnits.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      to_reload=['Adventurers','Dragons','Wyrmprints']
      for i in 0...to_reload.length
        download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/DL#{to_reload[i]}.txt")
        IO.copy_stream(download, "FGOTemp.txt")
        if File.size("FGOTemp.txt")>100
          b=[]
          File.open("FGOTemp.txt").each_line.with_index do |line, idx|
            b.push(line)
          end
          open("DL#{to_reload[i]}.txt", 'w') { |f|
            f.puts b.join('')
          }
        end
      end
      e.respond 'New cross-data loaded.'
      reload=true
    end
    if e.message.text.include?('6') && [167657750971547648].include?(event.user.id)                    # Library
      puts 'reloading LizClassFunction'
      load "#{$location}devkit/LizClassFunctions.rb"
      t=Time.now
      $last_multi_reload[0]=t
      e.respond 'Libraries force-reloaded'
      reload=true
    end
    if e.message.text.include?('7') && [167657750971547648].include?(event.user.id)                    # Avatars
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHDonorList.txt")
      IO.copy_stream(download, "FGOTemp.txt")
      if File.size("FGOTemp.txt")>100
        b=[]
        File.open("FGOTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FEHDonorList.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHBotArtList.txt")
      IO.copy_stream(download, "FGOTemp.txt")
      x=[]
      if File.size("FGOTemp.txt")>100
        b=[]
        File.open("FGOTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        x=b[2].gsub("\n",'').split('\\'[0])
        for i in 0...x.length
          download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/EliseImages/#{x[i]}.png")
          IO.copy_stream(download, "DLTemp#{Shardizard}.png")
          if File.size("DLTemp#{Shardizard}.png")>100
            download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/EliseImages/#{x[i]}.png")
            IO.copy_stream(download, "EliseImages/#{x[i]}.png")
          end
        end
      end
      e.respond 'Avatars reloaded'
      reload=true
    end
    e.respond 'Nothing reloaded.  If you meant to use the command, please try it again.' unless reload
  end
  return nil
end

bot.command(:boop) do |event, nme|
  return nil if overlap_prevent(event)
  event.respond 'boop' if Shardizard==4
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
  if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440,877171831835066391].include?(event.server.id) && Shardizard==4
    (chn.send_message(get_debug_leave_message()) rescue nil)
    event.server.leave
  else
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned to the #{shard_data(0)[(event.server.id >> 22) % Shards]} Shard")
    bot.user(239973891626237952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned to the #{shard_data(0)[(event.server.id >> 22) % Shards]} Shard")
    metadata_load()
    $server_data[0][((event.server.id >> 22) % Shards)] += 1
    metadata_save()
    chn.send_message("Are you the new server?\nNice to meet you and please take care of me\u2661\nIn response to queries beginning with `FGO!`, `Liz!`, or `Fate!`, I will be summoned to show data on *Fate/Grand Order*!") rescue nil
  end
end

bot.server_delete do |event|
  unless Shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**\nThis server was using #{shard_data(0,true)[((event.server.id >> 22) % Shards)]} Shards")
    bot.user(239973891626237952).pm("Left server **#{event.server.name}**")
    metadata_load()
    $server_data[0][((event.server.id >> 22) % Shards)] -= 1
    metadata_save()
  end
end

bot.mention do |event|
  puts event.message.text
  args=event.message.text.downcase.split(' ')
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  m=!event.user.bot_account?
  data_load(['library'])
  if !m || args.nil? || args.length<=0
  elsif ['tools','tool','links','link','resources','resource'].include?(args[0].downcase)
    args.shift
    show_tools(bot,event)
    m=false
  elsif ['help','command_list','commandlist'].include?(args[0].downcase)
    args.shift
    help_text(event,bot,args[0],args[1])
    m=false
  elsif ['support','supports','friends','friend','profile'].include?(args[0].downcase)
    args.shift
    support_lineup(event,bot,args)
    m=false
  elsif ['affinity','affinities','affinitys','effective','eff','resist','resistance','resistances','res'].include?(args[0].downcase)
    args.shift
    affinity_data(event,bot,args)
    m=false
  elsif ['servant','data','unit'].include?(args[0].downcase)
    args.shift
    if args[0].downcase=='feh' && find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot).length>0
      unt=find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot)
      disp_FEH_based_stats(bot,event,unt)
    else
      disp_servant_all(bot,event,args)
    end
    m=false
  elsif ['stats','stat'].include?(args[0])
    args.shift
    if args[0].downcase=='feh' && find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot).length>0
      unt=find_data_ex(:find_FEH_unit,args[1,args.length-1].join(' '),event,false,bot)
      disp_FEH_based_stats(bot,event,unt)
    else
      disp_servant_stats(bot,event,args)
    end
    m=false
  elsif ['skills'].include?(args[0])
    args.shift
    if ['mats','ascension','enhancement','enhance','materials','mat','material'].include?(args[0].downcase)
      args.shift
      disp_servant_mats(bot,event,args,-1,true)
    elsif ['find','search'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args,true)
    else
      disp_servant_skills(bot,event,args)
    end
    m=false
  elsif ['skill'].include?(args[0])
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args,true)
    elsif ['mats','ascension','enhancement','enhance','materials','mat','material'].include?(args[0].downcase)
      args.shift
      disp_servant_mats(bot,event,args,false,true)
    else
      disp_skill_data(bot,event,args)
    end
    m=false
  elsif ['traits','trait'].include?(args[0])
    args.shift
    disp_servant_traits(bot,event,args)
    m=false
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(args[0])
    args.shift
    disp_tiny_stats(bot,event,args)
    m=false
  elsif ['np','noble','phantasm','noblephantasm'].include?(args[0])
    args.shift
    disp_servant_np(bot,event,args)
    m=false
  elsif args[0].length==3 && 'np'==args[0][0,2] && args[0][2,1].to_i.to_s==args[0][2,1] && args[0][2,1].to_i>0 && args[0][2,1].to_i<6
    args.shift
    disp_servant_np(bot,event,args,-1,args[0][2,1].to_i)
    m=false
  elsif args[0].length==3 && 'kh'==args[0][0,2] && args[0][2,1].to_i.to_s==args[0][2,1] && args[0][2,1].to_i>0 && args[0][2,1].to_i<6
    disp_servant_np(bot,event,$servants[$servants.find_index{|q| q.id==154}],-1,args[0][2,1].to_i)
    m=false
  elsif ['ce','craft','essance','craftessance','essence','craftessence'].include?(args[0])
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args,true)
    elsif ['valentines','valentine','chocolate',"valentine's"].include?(args[0])
      args.shift
      disp_servant_ce(bot,event,args,-1,true)
    elsif !find_data_ex(:find_ce,args.join(' '),event,true).nil?
      disp_craft_essance(bot,event,args)
    elsif !find_data_ex(:find_servant,args.join(' '),event,true).nil?
      disp_servant_ce(bot,event,args)
    elsif !find_data_ex(:find_ce,args.join(' '),event).nil?
      disp_craft_essance(bot,event,args)
    elsif !find_data_ex(:find_servant,args.join(' '),event).nil?
      disp_servant_ce(bot,event,args)
    else
      event.respond "No matches found."
    end
    m=false
  elsif ['bond','bonds'].include?(args[0])
    args.shift
    disp_servant_ce(bot,event,args)
    m=false
  elsif ['valentines','valentine','chocolate',"valentine's"].include?(args[0])
    args.shift
    disp_servant_ce(bot,event,args,-1,true)
    m=false
  elsif ['mats','ascension','enhancement','materials'].include?(args[0])
    args.shift
    disp_servant_mats(bot,event,args)
    m=false
  elsif ['art','artist'].include?(args[0])
    args.shift
    disp_art(bot,event,args)
    m=false
  elsif ['riyo'].include?(args[0])
    args.shift
    disp_art(bot,event,args,true)
    m=false
  elsif ['xp','exp','level'].include?(args[0].downcase)
    args.shift
    level(event,bot,args)
    m=false
  elsif ['pxp','pexp','plxp','plexp','plevel','pllevel','sxp','sexp','slevel','cxp','cexp','ceexp','clevel','celevel'].include?(args[0].downcase)
    level(event,bot,args)
    m=false
  elsif ['daily','dailies'].include?(args[0].downcase)
    args.shift
    show_next(bot,event,args)
    m=false
  elsif ['today','now','tomorrow','tommorrow','tomorow','tommorow','sunday','sundae','sun','su','sonday','sondae','son','u','mo','monday','mondae','mon','m','mo','monday','mondae','mon','m','tu','tuesday','tuesdae','tues','tue','t','we','wednesday','wednesdae','wednes','wed','w','th','thursday','thursdae','thurs','thu','thur','h','r','fr','friday','fridae','fri','fryday','frydae','fry','f','sa','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[0].downcase)
    show_next(bot,event,args)
    m=false
  elsif ['next','schedule'].include?(args[0].downcase)
    show_next_2(bot,event)
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
    find_best_match(args.join(' '),bot,event,false,false,3)
    m=false
  elsif ['aliases','seealiases','checkaliases'].include?(args[0].downcase)
    args.shift
    list_aliases(bot,event,args)
    k=1
  elsif ['saliases','serveraliases'].include?(args[0].downcase)
    args.shift
    list_aliases(bot,event,args,1)
    k=1
  elsif ['alts','alt'].include?(args[0].downcase)
    args.shift
    show_servant_alts(event,bot,args)
    m=false
  elsif ['deck'].include?(args[0].downcase)
    args.shift
    generate_deck(event,bot,args)
    m=false
  elsif ['random','rand'].include?(args[0].downcase)
    args.shift
    generate_random_servant(event,bot)
    m=false
  elsif ['mat','material'].include?(args[0])
    args.shift
    disp_mat_data(bot,event,args)
    m=false
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    if ['skill','skills','skil','skils'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args)
    elsif ['ce','ces','craft','crafts','essence','essences'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args,true)
    else
      find_servants(bot,event,args)
    end
    m=false
  elsif ['sort','list'].include?(args[0].downcase)
    args.shift
    sort_servants(bot,event,args)
    m=false
  end
  find_best_match(args.join(' '),bot,event) if m
end

bot.message do |event|
  s=event.message.text.downcase
  m=false
  data_load(['library'])
  if ['liz!','liz?','fgo!','fgo?','fg0!','fg0?'].include?(s[0,4]) && s.length>4
    m=true
    puts event.message.text
    s=s[4,s.length-4]
  elsif ['fate!','fate?'].include?(s[0,5]) && s.length>5
    m=true
    puts event.message.text
    s=s[5,s.length-5]
  elsif !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0
    prf=@prefixes[event.server.id]
    if prf.downcase==s[0,prf.length]
      m=true
      puts event.message.text
      s=s[prf.length,s.length-prf.length]
    end
  end
  str="#{s}"
  if Shardizard==4 && (['fea!','fef!','fea?','fef?'].include?(str[0,4]) || ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5]) || ['fe!','fe?'].include?(str[0,3])) && (event.server.nil? || event.server.id==285663217261477889)
    str=str[4,str.length-4] if ['fea!','fef!','fea?','fef?'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!','fe?'].include?(str[0,3])
    a=str.split(' ')
    if a[0].downcase=='reboot'
      event.respond 'Becoming Robin.  Please wait approximately ten seconds...'
      exec "cd #{$location}devkit && RobinBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond 'I am not Robin right now.  Please use `FE!reboot` to turn me into Robin.'
    end
  elsif (['feh!','feh?'].include?(str[0,4]) || ['f?','e?','h?'].include?(str[0,2])) && Shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['f?','e?','h?'].include?(event.message.text.downcase[0,2])
    s=s[4,s.length-4] if ['feh!','feh?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Elise.  Please wait approximately ten seconds..."
      exec "cd #{$location}devkit && PriscillaBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Elise right now.  Please use `FEH!reboot` to turn me into Elise."
    end
  elsif ['dl!','dl?'].include?(str[0,3]) && Shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[3,s.length-3]
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Botan.  Please wait approximately ten seconds..."
      exec "cd #{$location}devkit && BotanBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Botan right now.  Please use `DL!reboot` to turn me into Botan."
    end
  elsif (['!weak '].include?(str[0,6]) || ['!weakness '].include?(str[0,10]))
    if event.server.nil? || event.server.id==264445053596991498
    elsif !bot.user(304652483299377182).on(event.server.id).nil? # Robin
    elsif !bot.user(543373018303299585).on(event.server.id).nil? # Botan
    elsif !bot.user(206147275775279104).on(event.server.id).nil? || Shardizard==4 || event.server.id==330850148261298176 # Pokedex
      triple_weakness(bot,event)
    end
  elsif overlap_prevent(event)
  elsif ['kh1','kh2','kh3','kh4','kh5'].include?(s.split(' ')[0]) && m
    disp_servant_np(bot,event,$servants[$servants.find_index{|q| q.id==154}],-1,s[2,1].to_i)
  elsif ['np1','np2','np3','np4','np5'].include?(s.split(' ')[0]) && m
    a=s.split(' ')
    a.shift
    disp_servant_np(bot,event,a,-1,s[2,1].to_i)
  elsif m && !all_commands().include?(s.split(' ')[0])
    find_best_match(s,bot,event)
  elsif !event.server.nil? && (above_memes().include?("s#{event.server.id}") || above_memes().include?(event.server.id))
  elsif !event.channel.nil? && above_memes().include?("c#{event.channel.id}")
  elsif above_memes().include?("u#{event.user.id}") || above_memes().include?(event.user.id)
  elsif " #{event.message.text.downcase} ".include?(' the archer class ')
    s=event.message.text.downcase
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
    if event.channel.name.downcase.include?('3h')
    elsif event.channel.name.downcase.include?('spoil')
    elsif " #{s} ".include?(' the archer class ')
      puts s
      event.respond "#{"#{event.user.mention} " unless event.server.nil?}#{["It's really made out of archers.","What do you mean there's not many archers?","Archers use bows?  Are you insane?","Why would they use a feminine hair accessory to attack?","Archery is projectile dabbing, and *Fate* is trying to protect itself from what Nasu thinks are bad memes.  Which makes me wonder why they called them archers and not something more fitting."].sample}"
    end
  elsif has_any?(event.message.text.downcase.split(' '),['death','correct']) && !event.user.bot_account?
    s=event.message.text.downcase
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
    s=s.gsub("\n",' ').gsub("  ",'')
    chain=false
    if s.split(' ').include?('death')
      if has_any?(event.message.text.downcase.split(' '),['knight'])
      elsif event.channel.name.downcase.include?('3h')
      elsif event.channel.name.downcase.include?('spoil')
      elsif rand(1000)<13
        chain=true
        puts 'responded to death'
        event.respond 'People die when they are killed.'
      end
    end
    if s.split(' ').include?('correct') && !chain
      if event.channel.name.downcase.include?('3h')
      elsif event.channel.name.downcase.include?('spoil')
      elsif rand(1000)<13
        puts 'responded to correct'
        event.respond "Just because you're correct doesn't mean you're right."
      end
    end
  elsif event.message.text.include?('0x4') && !event.user.bot_account? && Shardizard==4
    s=event.message.text
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
    if s=='0x4' || s[0,4]=='0x4 ' || s[s.length-4,4]==' 0x4' || s.include?(' 0x4 ')
      event.respond "#{"#{event.user.mention} " unless event.server.nil?}I am not Elise right now, but I have responded in case you're checking my response time."
    end
  end
end

def next_holiday(bot,mode=0)
  t=Time.now
  t-=60*60*6
  holidays=[[0,1,1,'Mashu','alongside Mt. Fuji and a hawk',"New Year's Day"],
            [0,3,17,'DaVinci',"pretend that I'm a genius","Info gatherer's birthday"],
            [0,4,1,'RiyoLiz','Fate/Grand Order?',"April Fool's Day"],
            [0,4,24,'Rhyme','dressup as my last owner.',"Coder's birthday"],
            [0,5,10,'DaVinci(Maid)','errand-girl for Master','Maid Day'],
            [0,7,4,'Edison','games against my rival, Tesla',"4th of July"],
            [0,10,31,'Carmilla','as my spooky older self',"All Hallow's Eve"]]
  d=get_donor_list().reject{|q| q[2][1]<3 || q[4][1]=='-'}
  for i in 0...d.length
    if d[i][4][1]!='-' && d[i][0]!=78649866577780736
      holidays.push([0,d[i][3][0],d[i][3][1],d[i][4][1],"in recognition of contributions provided by #{bot.user(d[i][0]).distinct}","Donator's birthday"])
      holidays[-1][5]="Donator's Day" if d[i][0]==189235935563481088
    end
  end
  for i in 0...holidays.length
    if t.month>holidays[i][1] || (t.month==holidays[i][1] && t.day>holidays[i][2])
      holidays[i][0]=t.year+1
    else
      holidays[i][0]=t.year
    end
  end
  e=calc_easter()
 # holidays.push([e[0],e[1],e[2],'','','Easter'])
  t=Time.now
  t-=60*60*6
  y8=t.year
  j8=Time.new(y8,6,8)
  fsij=8-j8.wday
  fsij-=7 if j8.sunday?
  fd=fsij+14
  if (t.month==6 && t.day>fd) || t.month>6
    y8+=1
    j8=Time.new(y8,6,8)
    fsij=8-j8.wday
    fsij-=7 if j8.sunday?
    fd=fsij+14
  end
 # holidays.push([y8,6,fd,'','',"Father's Day"])
  t=Time.now
  t-=60*60*6
  y8=t.year
  m8=Time.new(y8,5,8)
  fsim=8-m8.wday
  fsim-=7 if m8.sunday?
  md=fsim+7
  if (t.month==5 && t.day>md) || t.month>5
    y8+=1
    m8=Time.new(y8,5,8)
    fsim=8-m8.wday
    fsim-=7 if m8.sunday?
    md=fsim+14
  end
 # holidays.push([y8,5,md,'','',"Mother's Day"])
  holidays.sort! {|a,b| supersort(a,b,0) == 0 ? (supersort(a,b,1) == 0 ? (supersort(a,b,2) == 0 ? (supersort(a,b,6) == 0 ? supersort(a,b,4) : supersort(a,b,6)) : supersort(a,b,2)) : supersort(a,b,1)) : supersort(a,b,0)}
  k=[]
  for i in 0...holidays.length
    k.push(holidays[i]) if holidays[i][0]==holidays[0][0] && holidays[i][1]==holidays[0][1] && holidays[i][2]==holidays[0][2]
  end
  div=[[],
       [[0,0]],
       [[0,0],[12,0]],
       [[0,0],[8,0],[16,0]],
       [[0,0],[6,0],[12,0],[18,0]],
       [[0,0],[4,48],[9,36],[14,24],[19,12]],
       [[0,0],[4,0],[8,0],[12,0],[16,0],[20,0]],
       [[0,0],[3,26],[6,52],[10,17],[13,43],[17,8],[18,34]],
       [[0,0],[3,0],[6,0],[9,0],[12,0],[15,0],[18,0],[21,0]]]
  t=Time.now
  t-=60*60*6
  if t.year==k[0][0] && t.month==k[0][1] && t.day==k[0][2]
    if k.length==1
      # Only one holiday is today.  Display new avatar, and set another check for midnight
      bot.game=k[0][4]
      if Shardizard.zero?
        bot.profile.avatar=(File.open("#{$location}devkit/EliseImages/#{k[0][3]}.png",'r')) rescue nil
      end
      $avvie_info=[k[0][3],k[0][4],k[0][5]]
      t2= Time.now + 18*60*60
      t=Time.now
      @scheduler.at "#{t2.year}/#{t2.month}/#{t2.day} 0000" do
        next_holiday(bot,1)
      end
    else
      # multiple holidays are today.  Change avatar based on time of day, using div as a reference
      fcod=div[k.length][k.length-1]
      if t.hour>fcod[0] || (t.hour==fcod[0] && t.min>=fcod[1])
        # in last area of day.  Set avatar to the last one for the day, then set a check for tomorrow at midnight
        bot.game=k[k.length-1][4]
        if Shardizard.zero?
          bot.profile.avatar=(File.open("#{$location}devkit/LizImages/#{k[k.length-1][3]}.png",'r')) rescue nil
        end
        $avvie_info=[k[k.length-1][3],k[k.length-1][4],k[k.length-1][5]]
        t2= Time.now + 18*60*60
        t=Time.now
        @scheduler.at "#{t2.year}/#{t2.month}/#{t2.day} 0000" do
          next_holiday(bot,1)
        end
      else
        # find when in the day it is and...
        j=0
        t=Time.now
        t-=60*60*6
        for i in 0...div[k.length].length-1
          j=i if t.hour<div[k.length][i+1][0] || (t.hour==div[k.length][i+1][0] && t.min<div[k.length][i+1][1])
        end
        # ...set avatar properly and set check for the beginning of the next chunk of the day
        bot.game=k[j][4]
        if Shardizard.zero?
          bot.profile.avatar=(File.open("#{$location}devkit/LizImages/#{k[j][3]}.png",'r')) rescue nil
        end
        $avvie_info=[k[j][3],k[j][4],k[j][5]]
        t=Time.now
        t-=60*60*6
        @scheduler.at "#{t.year}/#{t.month}/#{t.day} #{div[k.length][j+1][0].to_s.rjust(2, '0')}#{div[k.length][j+1][1].to_s.rjust(2, '0')}" do
          next_holiday(bot,1)
        end
      end
    end
  else
    t=Time.now
    t-=60*60*6
    bot.game='Fate/Grand Order (FGO!help for info)'
    if [1].include?(t.month)
      bot.profile.avatar=(File.open("#{$location}devkit/Liz(Eggplant).png",'r')) rescue nil if Shardizard.zero?
      $avvie_info=['Liz(Eggplant)','*Fate/Grand Order*','']
    elsif [4].include?(t.month)
      bot.profile.avatar=(File.open("#{$location}devkit/Liz(Mecha).png",'r')) rescue nil if Shardizard.zero?
      $avvie_info=['Liz(Mecha)','*Fate/Grand Order*','']
    elsif [7].include?(t.month)
      bot.profile.avatar=(File.open("#{$location}devkit/Liz(Brave).png",'r')) rescue nil if Shardizard.zero?
      $avvie_info=['Liz(Brave)','*Fate/Grand Order*','']
    elsif [10].include?(t.month)
      bot.profile.avatar=(File.open("#{$location}devkit/Liz(Halloween).png",'r')) rescue nil if Shardizard.zero?
      $avvie_info=['Liz(Halloween)','*Fate/Grand Order*','']
    else
      bot.profile.avatar=(File.open("#{$location}devkit/Liz.png",'r')) rescue nil if Shardizard.zero?
      $avvie_info=['Liz','*Fate/Grand Order*','']
    end
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  end
end

bot.ready do |event|
  if Shardizard==4
    for i in 0...bot.servers.values.length
      if bot.servers.values[i].nil?
      elsif ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440,877171831835066391].include?(bot.servers.values[i].id)
        bot.servers.values[i].general_channel.send_message(get_debug_leave_message()) rescue nil
        bot.servers.values[i].leave
      end
    end
  end
  system("color 4#{shard_data(3)[Shardizard,1]}")
  bot.game='loading, please wait...'
  data_load(['library'])
  metadata_load()
  if $ignored.length>0
    for i in 0...$ignored.length
      bot.ignore_user($ignored[i].to_i)
    end
  end
  metadata_save()
  metadata_load()
  data_load()
  $last_multi_reload[0]=Time.now
  $last_multi_reload[1]=Time.now
  puts 'reloading LizClassFunctions'
  load "#{$location}devkit/LizClassFunctions.rb"
  system("color d#{shard_data(4)[Shardizard,1]}")
  system("title #{shard_data(2)[Shardizard]} LizBot")
  bot.game='Fate/Grand Order (FGO!help for info)'
  if Shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='LizBot (Debug X)'
    bot.profile.avatar=(File.open("#{$location}devkit/DebugLiz.png",'r'))
  else
    next_holiday(bot)
  end
  if Shardizard==4
    if File.exist?("#{$location}devkit/DebugSav.txt")
      b=[]
      File.open("#{$location}devkit/DebugSav.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    bot.channel(285663217261477889).send_message("Hello #{['Puppy','Deerlet'].sample}!") if b[0]!='LizX'
    open("#{$location}devkit/DebugSav.txt", 'w') { |f|
      f.puts '"LizX"'
    }
  end
end

bot.run
