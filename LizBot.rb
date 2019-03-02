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
require_relative 'rot8er_functs'       # functions I use commonly in bots

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

@prefix=['liz!','liZ!','lIz!','lIZ!','Liz!','LiZ!','LIz!','LIZ!',
         'liz?','liZ?','lIz?','lIZ?','Liz?','LiZ?','LIz?','LIZ?',
         'Iiz!','IiZ!','IIz!','IIZ!','Iiz?','IiZ?','IIz?','IIZ?',
         'fgo!','fgO!','fg0!','fGo!','fGO!','fG0!','Fgo!','FgO!','Fg0!','FGo!','FGO!','FG0!',
         'fgo?','fgO?','fg0?','fGo?','fGO?','fG0?','Fgo?','FgO?','Fg0?','FGo?','FGO?','FG0?',
         'fate!','fatE!','faTe!','faTE!','fAte!','fAtE!','fATe!','fATE!','Fate!','FatE!','FaTe!','FaTE!','FAte!','FAtE!','FATe!','FATE!',
         'fate?','fatE?','faTe?','faTE?','fAte?','fAtE?','fATe?','fATE?','Fate?','FatE?','FaTe?','FaTE?','FAte?','FAtE?','FATe?','FATE?']

# The bot's token is basically their password, so is censored for obvious reasons
if @shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: 431895561193390090, prefix: @prefix
else
  bot = Discordrb::Commands::CommandBot.new token: '>Main Token<', shard_id: @shardizard, num_shards: 4, client_id: 502288364838322176, prefix: @prefix
end
bot.gateway.check_heartbeat_acks = false

@servants=[]
@skills=[]
@crafts=[]
@codes=[]
@mats=[]
@clothes=[]
@enemies=[]
@aliases=[]
@spam_channels=[[],[]]
@server_data=[]
@ignored=[]
@embedless=[]
@avvie_info=['Liz','*Fate/Grand Order*','N/A']

def safe_to_spam?(event,chn=nil,mode=0) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) # it is safe to spam in the emoji servers
  chn=event.channel if chn.nil?
  return true if ['bots','bot'].include?(chn.name.downcase) # channels named "bots" are safe to spam in
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('spam') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('command') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('channel') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('lizbot')  # it is safe to spam in channels designed specifically for LizBot
  return true if chn.name.downcase.include?('liz-bot')
  return true if chn.name.downcase.include?('liz_bot')
  return true if @spam_channels[0].include?(chn.id)
  return false if mode==0
  return true if chn.name.downcase.include?('fate') && chn.name.downcase.include?('grand') && chn.name.downcase.include?('order')
  return true if chn.name.downcase.include?('fate') && chn.name.downcase.include?('go')
  return true if chn.name.downcase.include?('fgo')
  return true if @spam_channels[1].include?(chn.id)
  return false
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
    b[i][26]=b[i][26].split(', ').map{|q| q.to_i} unless b[i][26].nil?
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
      b[i][5]=b[i][5].split(', ') unless b[i][5].nil?
      for i2 in 6...13
        b[i][i2]=b[i][i2].split(';; ')
      end
    elsif b[i][2]=='Passive'
      b[i][4]=b[i][4].split(', ') unless b[i][4].nil?
    elsif b[i][2]=='Noble'
      b[i][7]=b[i][7].split(', ') unless b[i][7].nil?
      for i2 in 8...18
        b[i][i2]=b[i][i2].split(';; ')
      end
    elsif b[i][2]=='Clothes'
      b[i][1]=b[i][1].to_i
      b[i][3]=b[i][3].split(', ') unless b[i][3].nil?
      for i2 in 4...7
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
    b[i][10]='' if b[i][10].nil?
    b[i][10]=b[i][10].split(', ')
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
  k=@servants.map{|q| "#{q[18].join("\n")}\n#{q[19].join("\n")}"}.join("\n").split("\n").map{|q| q.split(' ')}
  for i in 0...k.length
    k[i].pop
  end
  k=k.reject{|q| q.length<=0}.map{|q| q.join(' ')}.uniq.sort
  open('C:/Users/Mini-Matt/Desktop/devkit/FGOMats.txt', 'w') { |f|
    f.puts k.join("\n")
    f.puts "\n"
  }
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOMats.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOMats.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'')
  end
  @mats=b.map{|q| q}
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
  @spam_channels=[[],[]] if @spam_channels.nil?
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
  data_load()
  k=@servants.map{|q| "#{q[18].join("\n")}\n#{q[19].join("\n")}"}.join("\n").split("\n").map{|q| q.split(' ')}
  for i in 0...k.length
    k[i].pop
  end
  k=k.map{|q| q.join(' ')}.uniq.sort
  open('C:/Users/Mini-Matt/Desktop/devkit/FGOMats.txt', 'w') { |f|
    f.puts k.join("\n")
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
  @aliases=b.reject{|q| q.nil? || q[1].nil? || q[2].nil?}.uniq
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Liz
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'FGO!reboot'
  exec "cd C:/Users/Mini-Matt/Desktop/devkit && LizBot.rb #{@shardizard}"
end

bot.command([:help,:commands,:command_list,:commandlist,:Help]) do |event, command, subcommand|
  return nil if overlap_prevent(event)
  command='' if command.nil?
  subcommand='' if subcommand.nil?
  k=0
  k=event.server.id unless event.server.nil?
  if ['help','commands','command_list','commandlist'].include?(command.downcase)
    event.respond "The `#{command.downcase}` command displays this message:"
    command=''
  end
  if command.downcase=='reboot'
    create_embed(event,'**reboot**',"Reboots this shard of the bot, installing any updates.\n\n**This command is only able to be used by Rot8er_ConeX**",0x008b8b)
  elsif ['donation','donate'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Responds with information regarding potential donations to my developer.',0xED619A)
  elsif command.downcase=='sendmessage'
    create_embed(event,'**sendmessage** __channel id__ __*message__',"Sends the message `message` to the channel with id `channel`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='sendpm'
    create_embed(event,'**sendpm** __user id__ __*message__',"Sends the message `message` to the user with id `user`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='ignoreuser'
    create_embed(event,'**ignoreuser** __user id__',"Causes me to ignore the user with id `user`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='leaveserver'
    create_embed(event,'**leaveserver** __server id number__',"Forces me to leave the server with the id `server id`.\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif ['shard','attribute'].include?(command.downcase)
    create_embed(event,'**shard**','Returns the shard that this server is served by.',0xED619A)
  elsif ['bugreport','suggestion','feedback'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __*message__",'PMs my developer with your username, the server, and the contents of the message `message`',0xED619A)
  elsif command.downcase=='addalias'
    create_embed(event,'**addalias** __new alias__ __name__',"Adds `new alias` to `name`'s aliases.\nIf the arguments are listed in the opposite order, the command will auto-switch them.\n\nAliases can be added to:\n- Servants\n- Skills (Active, Passive, or Clothing skills)\n- Craft Essances\n- Ascension/Skill Enhancement Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nInforms you if the alias already belongs to someone/something.\nAlso informs you if the servant you wish to give the alias to does not exist.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['deletealias','removealias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __alias__","Removes `alias` from the list of aliases, regardless of who/what it was for.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['backupaliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Backs up the alias list.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['restorealiases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Restores the the alias, from last backup.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['safe','spam','safetospam','safe2spam','long','longreplies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __toggle__","Responds with whether or not the channel the command is invoked in is one in which I can send extremely long replies.\n\nIf the channel does not fill one of the many molds for acceptable channels, server mods can toggle the ability with the words \"on\", \"semi\", and \"off\".",0xED619A)
  elsif ['status'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*message__","Sets my status to `message`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['today','todayinfgo','today_in_fgo','now'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the day's in-game daily events.\nIf in PM, will also show tomorrow's.",0xED619A)
  elsif ['tomorrow','tommorrow','tommorow','tomorow'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the next day's in-game daily events.",0xED619A)
  elsif ['daily','dailies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the day's in-game daily events.\nIf in PM, will also show tomorrow's.\n\nYou can also show include the word \"tomorrow\" to force the next day's data.\nYou can also include a day of the week and force that to show instead.",0xED619A)
  elsif ['next','schedule'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __type__","Shows the next time in-game daily events of the type `type` will happen.\nIf in PM and `type` is unspecified, shows the entire schedule.\n\n__*Accepted Inputs*__\nTraining / Ground(s)\nEmber(s) / Gather(ing)\nMat(s) / Material(s) ~~this one only works fully in PM.~~",0xED619A)
  elsif ['exp','level','xp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.\n\nIn PM, shows everything unless you specify a particular type of EXP.\nOtherwise, only works if you specify a particular type of EXP:\n- Player\n- Servant\n- Craft Essence",0xED619A)
  elsif ['plxp','plexp','pllevel','plevel','pxp','pexp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a player from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xED619A)
  elsif ['sxp','sexp','slevel'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a servant from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xED619A)
  elsif ['cxp','cexp','ceexp','clevel','celevel'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a Craft Essence from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xED619A)
  elsif command.downcase=='invite'
    create_embed(event,'**invite**','PMs the invoker with a link to invite me to their server.',0xED619A)
  elsif ['tools','tool','links','link','resources','resource'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Responds with a list of links useful to players of *Fate/Grand Order*.',0xED619A)
  elsif ['mat','material'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is the name of a material, shows information about the servants who require that material for ascension or for skill enhancement.\n\nIf it is safe to spam, the servants' names and uses for the material will be shown.\nIf not, only the *quantity* of servants that require the material will be shown.",0xED619A)
  elsif ['servant','data','unit'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats.  If you include the word \"Fou\", the combat stats will be displayed with Fou modifiers\n\nIf it is safe to spam, also shows information on `name`s skills, traits, Noble Phantasm, and Bond CE.",0xED619A)
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(command.downcase) || (['stat','stats'].include?(command.downcase) && ['tiny','small','micro','smol','squashed','little'].include?("#{subcommand}".downcase))
    create_embed(event,"**#{command.downcase}#{" #{subcommand.downcase}" if ['stat','stats'].include?(command.downcase)}** __name__","Shows `name`'s stats, in a condensed format.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Silver Fou modifiers.\nInclude the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['stats','stat'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats.\n\nIf you include the word \"Fou\", the combat stats will be displayed with Fou modifiers.\n\nIf it is not safe to spam, this command automatically reverts to the `smol` command, and thus you need to include the word \"GoldenFou\" to display combat stats with Golden Fou modifiers.",0xED619A)
  elsif ['traits','trait'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s traits.\n\nUnlike other servant-based commands, this one also accepts enemy fighter names.",0xED619A)
  elsif ['skills','skils'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s skills.\n\nIf it is safe to spam, each skill will also be given additional information.",0xED619A)
  elsif ['skill','skil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the skill data for the skill `name`.\nIf no rank is given and `name` is a skill with multiple ranks, shows all.",0xED619A)
  elsif ['np','noble','phantasm','noblephantasm'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Noble Phantasm.\n\nIf it is not safe to spam, I will show the effects for only the default NP level, and it can be adjusted to show other NP levels based on included arguments in the format \"NP#{rand(5)+1}\"\nIf it is safe to spam, I will show all the effects naturally.",0xED619A)
  elsif ['bond','bondce'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Bond CE.",0xED619A)
  elsif ['art','artist'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s art.\n\nDefaults to their normal art, but can be modified to other arts based on the following words:\nFirst/1st/FirstAscension/1stAscension\nSecond/2nd/SecondAscension/2ndAscension\nThird/3rd/ThirdAscension/3rdAscension\nFinal/Fourth/4th/FinalAscension/FourthAscension/4thAscension\nCostume/FirstCostume/1stCostume/Costume1\nSecondCostume/2ndCostume/Costume2\nRiyo/AprilFool's\n\nIf the requested art doesn't exist, reverts back to default art.",0xED619A)
  elsif ['riyo'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Riyo art, which is shown on April Fool's.",0xED619A)
  elsif ['ce','craft','essance','craftessance'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is the name of a CE, shows that CE's info.\nIf `name` is the name of a servant, shows that servant's Bond CE.\n\nIf `name` is a number, prioritizes servant ID over Craft Essence ID.",0xED619A)
  elsif ['valentines','valentine','chocolate','cevalentine','cevalentines','valentinesce','valentinece',"valentine's"].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is the name of a servant, shows that servant's Valentine's CE.",0xED619A)
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
  elsif ['find','search','lookup'].include?(command.downcase)
    lookout=[]
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOSkillSubsets.txt')
      lookout=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOSkillSubsets.txt').each_line do |line|
        lookout.push(eval line)
      end
    end
    lookout=lookout.map{|q| q[0]}
    if ['skill','skills','skil','skils'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all skills and CE effects that fit `filters`.\n\nYou can search by:\n- Skill type (Active, Passive, CE, Clothing, NP)\n- Effect tag#{' (seen below)' if safe_to_spam?(event)}\n\nIf too many skills and/or CEs are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
      if safe_to_spam?(event)
        if lookout.join("\n").length>=1900
          str=lookout[0]
          for i in 1...lookout.length
            str=extend_message(str,lookout[i],event,1,',  ')
          end
          event.respond str
        else
          create_embed(event,'Skill tags','',0x40C0F0,nil,nil,triple_finish(lookout)) if safe_to_spam?(event)
        end
      end
    elsif ['ce','ces','craft','crafts','essence','essences'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays CEs effects that fit `filters`.\n\nYour search options can be #{'seen below' if safe_to_spam?(event)}#{'shown if you repeat this command in PM' unless safe_to_spam?(event)}\n\nIf too many CEs are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
      if safe_to_spam?(event)
        if lookout.join("\n").length>=1900
          str=lookout[0]
          for i in 1...lookout.length
            str=extend_message(str,lookout[i],event,1,',  ')
          end
          event.respond str
        else
          create_embed(event,'Skill tags','',0x40C0F0,nil,nil,triple_finish(lookout)) if safe_to_spam?(event)
        end
      end
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all servants that fit `filters`.\n\nYou can search by:\n- Class\n- Growth Curve\n- Rarity\n- Attribute\n- Traits\n- Noble Phantasm card type\n- Noble Phantasm target(s)\n- Availability\n- Alignment\n\nIf too many servants are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
    end
  elsif ['sort','list'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*filters__","Sorts all servants that fit `filters`.\n\nYou can search by:\n- Class\n- Growth Curve\n- Rarity\n- Attribute\n- Traits\n- Noble Phantasm card type\n- Noble Phantasm target(s)\n- Availability\n- Alignment\n\nYou can sort by:\n- HP\n- Atk\n\nYou can adjust the level sorted by using the following words:\n- Base\n- Max\n- Grail\n\nIf too many servants are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xED619A)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Servants\n- Skills (Active, Passive, or Clothing skills)\n- Craft Essances\n- Ascension/Skill Enhancement Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Servants\n- Skills (Active, Passive, or Clothing skills)\n- Craft Essances\n- Ascension/Skill Enhancement Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
  elsif command.downcase=='snagstats'
    subcommand='' if subcommand.nil?
    if ['server','servers','member','members','shard','shards','users','user'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",'Returns the number of servers and unique members each shard reaches.',0xED619A)
    elsif ['servant','servants','unit','units','character','characters','chara','charas','char','chars'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of servants, sorted in each of the following ways:\n- Class\n- Rarity\n- Attribute\n- Growth Curve (in PM)\n- Deck contents (in PM)\n- Noble Phantasm card type (in PM)",0xED619A)
    elsif ['ce','craft','essance','craftessance','ces','crafts','essances','craftessances'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of Craft Essences, sorted in each of the following ways:\n- Rarity\n- Grouping",0xED619A)
    elsif ['command','commandcode','commands','commandcodes'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of Command Codes, sorted by rarity",0xED619A)
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
    str="__**Servant data**__"
    str="#{str}\n`servant` __name__ - displays all info about a servant (*also `data`*)"
    str="#{str}\n`stats` __name__ - displays a servant's stats"
    str="#{str}\n`skills` __name__ - displays a servant's skills"
    str="#{str}\n`traits` __name__ - displays a servant's traits"
    str="#{str}\n`np` __name__ - displays a servant's Noble Phantasm"
    str="#{str}\n`bondCE` __name__ - displays a servant's Bond CE (*also `ce`*)"
    str="#{str}\n`mats` __name__ - displays a servant's materials (*also `ascension` or `enhancement`*)"
    str="#{str}\n\n`aliases` __name__ - displays a servant's aliases"
    str="#{str}\n`serveraliases` __name__ - displays a servant's server-specific aliases"
    str="#{str}\n`art` __name__ - displays a servant's art"
    str="#{str}\n\n__**Other data**__"
    str="#{str}\n`ce` __name__ - displays data for a Craft Essence"
    str="#{str}\n`commandcode` __name__ - displays data for a Command Code"
    str="#{str}\n`mysticcode` __name__ - displays data for a Mystic Code (*also `clothing` or `clothes`*)"
    str="#{str}\n`skill` __name__ - displays a skill's effects"
    str="#{str}\n`mat` __name__ - displays a material (*also `material`*)"
    str="#{str}\n`find` __\*filters__ - search for servants (*also `search`*)"
    str="#{str}\n`sort` __\*filters__ - sort servants by HP or Atk (*also `list`*)"
    str="#{str}\n`today` - to see today's events (*also `daily` or `todayInFGO`*)"
    str="#{str}\n`next` - to see when cyclical events happen next"
    str="#{str}\n\n__**Meta Data**__"
    str="#{str}\n`invite` - for a link to invite me to your server"
    str="#{str}\n`tools` - for a list of tools aside from me that may aid you"
    str="#{str}\n`snagstats` __type__ - to receive relevant bot stats"
    str="#{str}\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n`shard` (*also `attribute`*)"
    str="#{str}\n\n__**Developer Information**__"
    str="#{str}\n`bugreport` __\\*message__ - to send my developer a bug report"
    str="#{str}\n`suggestion` __\\*message__ - to send my developer a feature suggestion"
    str="#{str}\n`feedback` __\\*message__ - to send my developer other kinds of feedback"
    str="#{str}\n~~the above three commands are actually identical, merely given unique entries to help people find them~~"
    create_embed([event,x],"Command Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0') || q.include?('II')}.map {|s| "`#{s.gsub('FATE','Fate').gsub('LIZ','Liz')}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n__**Liz Bot help**__",str,0xED619A)
    str="__**Aliases**__"
    str="#{str}\n`addalias` __new alias__ __target__ - Adds a new server-specific alias"
    str="#{str}\n~~`aliases` __target__ (*also `checkaliases` or `seealiases`*)~~"
    str="#{str}\n~~`serveraliases` __target__ (*also `saliases`*)~~"
    str="#{str}\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias"
    str="#{str}\n\n__**Channels**__"
    str="#{str}\n`spam` __toggle__ - to allow the current channel to be safe to send long replies to (*also `safetospam` or `safe2spam`*)"
    create_embed([event,x],"__**Server Admin Commands**__",str,0xC31C19) if is_mod?(event.user,event.server,event.channel)
    str="__**Mjolnr, the Hammer**__"
    str="#{str}\n`ignoreuser` __user id number__ - makes me ignore a user"
    str="#{str}\n`leaveserver` __server id number__ - makes me leave a server"
    str="#{str}\n\n__**Communication**__"
    str="#{str}\n`status` __\\*message__ - sets my status"
    str="#{str}\n`sendmessage` __channel id__ __\\*message__ - sends a message to a specific channel"
    str="#{str}\n`sendpm` __user id number__ __\\*message__ - sends a PM to a user"
    str="#{str}\n\n__**Server Info**__"
    str="#{str}\n`snagstats` - snags relevant bot stats"
    str="#{str}\n\n__**Shards**__"
    str="#{str}\n`reboot` - reboots this shard"
    str="#{str}\n\n__**Meta Data Storage**__"
    str="#{str}\n`backupaliases` - backs up the alias list"
    str="#{str}\n`restorealiases` - restores the alias list from last backup"
    str="#{str}\n`sortaliases` - sorts the alias list by type of alias"
    create_embed([event,x],"__**Bot Developer Commands**__",str,0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || @shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0') || q.include?('II')}.map {|s| "`#{s.gsub('FATE','Fate').gsub('LIZ','Liz')}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.reject{|q| q.include?('0')}.map {|s| "`#{s}`"}.join(', ')}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `FGO!help here`." if x==1
  end
end

def overlap_prevent(event) # used to prevent servers with both Liz and her debug form from receiving two replies
  if event.server.nil? # failsafe code catching PMs as not a server
    return false
  elsif event.message.text.downcase.split(' ').include?('debug') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id)
    return @shardizard != 4 # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) # emoji servers will use default Elise otherwise
    return @shardizard == 4
  end
  return false
end

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['help','servant','addalias','aliases','checkaliases','seealiases','deletealias','removealias','sortaliases','status','bugreport','suggestion','feedback',
     'sendmessage','sendpm','leaveserver','cleanupaliases','serveraliases','saliases','backupaliases','snagstats','reboot','help','commands','command_list',
     'commandlist','tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed',
     'statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small',
     'micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little','stats','stat','traits','trait','skills','np','noble','phantasm',
     'noblephantasm','ce','bond','bondce','mats','ascension','enhancement','enhance','materials','art','riyo','code','command','commandcode','craft','find',
     'essance','craftessance','list','search','skill','mysticcode','mysticode','mystic','clothes','clothing','artist','channellist','chanelist','spamchannels',
     'spamlist','snagchannels','boop','mat','material','donation','donate','ignoreuser','spam','sort','tools','links','resources','resource','link','tool',
     'boop','valentines','valentine','chocolate','cevalentine','cevalentines','valentinesce','valentinece','tags','skil','skils','today','next','daily',
     'dailies','today_in_fgo','todayinfgo','schedule','safe','safe2spam','s2s','safetospam','long','longreplies','tomorrow','tommorrow','tomorow','tommorow',
     'lookup','invite','exp','xp','sexp','sxp','servantexp','servantxp','level','plxp','plexp','pllevel','plevel','pxp','pexp','sxp','sexp','slevel','cxp',
     'cexp','ceexp','clevel','celevel']
  k=['addalias','deletealias','removealias'] if permissions==1
  k=['sortaliases','status','sendmessage','sendpm','leaveserver','cleanupaliases','backupaliases','reboot','snagchannels'] if permissions==2
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
  elsif name[0,4].downcase=='srv-' || name.downcase[0,4]=='srv_'
    name2=name[4,name.length-4]
    if name2.to_i.to_s==name2 && name2.to_i<=@servants[-1][0]
      return @servants[@servants.find_index{|q| q[0]==name2.to_i}]
    elsif name2.to_f.to_s==name2 && name2.to_f<2
      return @servants[@servants.find_index{|q| q[0]==name2.to_f}]
    end
  elsif name[0,3].downcase=='srv'
    name2=name[3,name.length-3]
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
  alz=@aliases.reject{|q| q[0]!='Servant'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @servants[@servants.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @servants[@servants.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@servants.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @servants[k] unless k.nil?
  nicknames_load()
  for i in name.length...alz.map{|q| q[0].length}.max
    k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return @servants[@servants.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
    k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return @servants[@servants.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
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
  end
  if name[0,1]=='#'
    name2=name[1,name.length-1]
    if name2.to_i.to_s==name2 && name2.to_i<=@servants[-1][0] && name2.to_i>0
      return []
    elsif name2.to_i.to_s==name2 && name2.to_i<=@crafts[-1][0] && name2.to_i>0
      return @crafts[@crafts.find_index{|q| q[0]==name2.to_f}]
    end
  elsif name[0,3].downcase=='ce-' || name[0,3].downcase=='ce_'
    name2=name[3,name.length-3]
    if name2.to_i.to_s==name2 && name2.to_i<=@crafts[-1][0] && name2.to_i>0
      return @crafts[@crafts.find_index{|q| q[0]==name2.to_f}]
    end
  elsif name[0,2].downcase=='ce'
    name2=name[2,name.length-2]
    if name2.to_i.to_s==name2 && name2.to_i<=@crafts[-1][0] && name2.to_i>0
      return @crafts[@crafts.find_index{|q| q[0]==name2.to_f}]
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
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Craft'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @crafts[@crafts.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @crafts[@crafts.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@crafts.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('the ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,4].downcase=='the '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('a ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,2].downcase=='a '}
  return @crafts[k] unless k.nil?
  k=@crafts.find_index{|q| q[1].downcase.gsub('an ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[1][0,3].downcase=='an '}
  return @crafts[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @crafts[@crafts.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @crafts[@crafts.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
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
  elsif name[0,4].downcase=='cmd-'
    name2=name[4,name.length-4]
    if name2.to_i.to_s==name2 && name2.to_i<=@codes[-1][0] && name2.to_i>0
      return @codes[@codes.find_index{|q| q[0]==name2.to_i}]
    end
  elsif name[0,3].downcase=='cmd'
    name2=name[3,name.length-3]
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
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Command'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @codes[@codes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @codes[@codes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@codes.find_index{|q| q[1].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @codes[k] unless k.nil?
  k=@codes.find_index{|q| q[1].gsub('Code: ','').downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @codes[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @codes[@codes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @codes[@codes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
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
  return find_enemy('Roman Soldier',event,fullname) if name=='rory' || name=='rorywilliams' || name=='plasticrory'
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
  return sklz.reject{|q| q[0]!='Whim of the Goddess' || q[1][0,1]!='A'} if name=='whimofthegoddessa'
  k=sklz.find_index{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz[k] unless k.nil?
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz.reject{|q| q[0]!=sklz[k][0] || q[2]!=sklz[k][2]} unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3],q[0]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1] && q[2]==alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1] || q[2]!=alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')}
  end
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1] && q[2]==alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1] || q[2]!=alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')}
  end
  return [] if fullname
  return sklz.reject{|q| q[0][0,17]!='Primordial Rune ('} if name=='primordialrune'[0,name.length]
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz.reject{|q| q[0]!=sklz[k][0] || q[2]!=sklz[k][2]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz.reject{|q| q[0]!=alz[k][1] || q[2]!=alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz.reject{|q| q[0]!=alz[k][1] || q[2]!=alz[k][3].gsub('ClothingSkill','Clothes').gsub('Active','Skill')} unless k.nil?
  return []
end

def find_clothes(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@clothes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @clothes[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Clothes'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @clothes[@clothes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @clothes[@clothes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@clothes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @clothes[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @clothes[@clothes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @clothes[@clothes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_mat(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@mats.find_index{|q| q.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "#{q.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Magic #{q.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Secret #{q.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "#{q.gsub('Secret Gem of ','')} Cookie".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "Blue #{q.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "Blue Gem of #{q.gsub('Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Red #{q.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Red Gem of #{q.gsub('Magic Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Yellow #{q.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Yellow Gem of #{q.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Cookie of #{q.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return alz[k][1] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return alz[k][1] unless k.nil?
  return [] if fullname
  k=@mats.find_index{|q| q.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "#{q.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Magic #{q.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Secret #{q.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "#{q.gsub('Secret Gem of ','')} Cookie".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "Blue #{q.gsub('Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,7]=='Gem of ' && "Blue Gem of #{q.gsub('Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Red #{q.gsub('Magic Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,13]=='Magic Gem of ' && "Red Gem of #{q.gsub('Magic Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Yellow #{q.gsub('Secret Gem of ','')} Gem".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Yellow Gem of #{q.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=@mats.find_index{|q| q[0,14]=='Secret Gem of ' && "Cookie of #{q.gsub('Secret Gem of ','')}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  for i in name.length...alz.map{|q| q[0].length}.max
    k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return alz[k][1] unless k.nil?
    k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0].length<=i && (q[2].nil? || q[2].include?(g))}
    return alz[k][1] unless k.nil?
  end
  return []
end

def find_data_ex(callback,name,event,fullname=false)
  k=method(callback).call(name,event,true)
  return k if k.length>0
  blank=[]
  blank='' if [:find_mat].include?(callback)
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true)
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank if fullname
  k=method(callback).call(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event)
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank
end

def find_emote(bot,event,item,mode=0,forcemote=false)
  if mode==1
    moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return "#{moji[0].icon_url}" if moji.length>0
    moji=bot.server(523830882453422120).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return "#{moji[0].icon_url}" if moji.length>0
    moji=bot.server(523824424437415946).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return "#{moji[0].icon_url}" if moji.length>0
    moji=bot.server(523825319916994564).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return "#{moji[0].icon_url}" if moji.length>0
    moji=bot.server(523822789308841985).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
    return "#{moji[0].icon_url}" if moji.length>0
    return ''
  end
  k=event.message.text.downcase.split(' ')
  return item if (k.include?('colorblind') || k.include?('textmats')) && !forcemote
  k=item.split(' ')[-1]
  if mode==2
    k=''
  else
    item=item.split(' ')
    item.pop
    item=item.join(' ')
  end
  moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(523830882453422120).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(523824424437415946).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(523825319916994564).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
  return "#{moji[0].mention}#{k}" if moji.length>0
  moji=bot.server(523822789308841985).emoji.values.reject{|q| q.name.downcase != item.downcase.gsub(' ','_').gsub('-','').gsub("'",'')}
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

def servant_superclass(bot,event,k)
  color='gold'
  color='silver' if k[3]<4
  color='bronze' if k[3]<3
  color='black' if k[3]<1
  moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k[2].downcase.gsub(' ','')}_#{color}"}
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
  return "**Class:** *#{k[2].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*\n**Attribute:** *#{k[12].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*\n**Alignment:** *#{k[22].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
end

def servant_moji(bot,event,k,mode=0)
  color='gold'
  color='silver' if k[3]<4
  color='bronze' if k[3]<3
  color='black' if k[3]<1
  moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{k[2].downcase.gsub(' ','')}_#{color}"}
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
  return clsmoji if mode==1
  deckmoji=''
  m=k[17][0,5]
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
  return "#{clsmoji}#{deckmoji}#{k[17][6,1].gsub('Q','<:Quick_xNP:523979766731243527>').gsub('A','<:Arts_xNP:523979767016325121>').gsub('B','<:Buster_xNP:523979766911598632>')}"
end

def servant_icon(k,event)
  return "https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Alice.png" if k[0]==74 && event.user.id==167657750971547648
  return "https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Alice.png" if k[0]==74 && rand(100)<5
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  return "http://fate-go.cirnopedia.org/icons/servant/servant_#{dispnum}.png"
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
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  np="*"
  np=":* #{@skills[@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}][3]}" unless @skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}.nil?
  kx=@crafts.find_index{|q| q[0]==k[23]}
  bond=">No Bond CE<"
  bond="**Bond CE:** >Unknown<" if k[0]<2
  bond="**Bond CE:** #{@crafts[kx][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless kx.nil?
  text="#{text}\n**Maximum default level:** *#{k[5]}* (#{k[4]} growth curve)\n**Team Cost:** #{k[21]}\n**Availability:** *#{k[20].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*\n\n#{servant_superclass(bot,event,k)}\n\n**Command Deck:** #{k[17][0,5].gsub('Q','<:quick:523854796692783105>').gsub('A','<:arts:523854803013730316>').gsub('B','<:buster:523854810286391296>')} (#{k[17][0,5]})\n**Noble Phantasm:** #{k[17][6,1].gsub('Q','<:quick:523854796692783105>').gsub('A','<:arts:523854803013730316>').gsub('B','<:buster:523854810286391296>')} *#{k[16].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}#{np}\n\n#{bond}\n\n**Death Rate:** #{k[11]}%"
  fou=990
  fou=1000 if dispstr.include?('fou') && dispstr.include?('jp')
  fou=1000 if dispstr.include?('jpfou') || dispstr.include?('jp_fou') || dispstr.include?('foujp') || dispstr.include?('fou_jp')
  fou=1000 if dispstr.include?('fou-jp') || dispstr.include?('jp-fou')
  flds=[["Combat stats","__**Level 1**__\n*HP* - #{longFormattedNumber(k[6][0])}  \n*Atk* - #{longFormattedNumber(k[7][0])}  \n\n__**Level #{k[5]}**__\n*HP* - #{longFormattedNumber(k[6][1])}  \n*Atk* - #{longFormattedNumber(k[7][1])}  \n\n__**Level 100<:holy_grail:523842742992764940>**__\n*HP* - #{longFormattedNumber(k[6][2])}  \n*Atk* - #{longFormattedNumber(k[7][2])}  "]]
  flds=[["Combat stats","__**Level 1**__\n*HP* - <:Fou:544138629694619648>#{longFormattedNumber(k[6][0]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[6][0]+2000)}  \n*Atk* - <:Fou:544138629694619648>#{longFormattedNumber(k[7][0]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[7][0]+2000)}  \n\n__**Level #{k[5]}**__\n*HP* - <:Fou:544138629694619648>#{longFormattedNumber(k[6][1]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[6][1]+2000)}  \n*Atk* - <:Fou:544138629694619648>#{longFormattedNumber(k[7][1]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[7][1]+2000)}  \n\n__**Level 100<:holy_grail:523842742992764940>**__\n*HP* - <:Fou:544138629694619648>#{longFormattedNumber(k[6][2]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[6][2]+2000)}  \n*Atk* - <:Fou:544138629694619648>#{longFormattedNumber(k[7][2]+fou)} - <:GoldenFou:544138629832769536>#{longFormattedNumber(k[7][2]+2000)}"]] if dispfou
  flds.push(["Attack Parameters","__**Hit Counts**__\n<:Quick_y:526556106986618880>#{k[9][0]}\u00A0\u00A0\u00B7\u00A0\u00A0<:Arts_y:526556105489252352>#{k[9][1]}\u00A0\u00A0\u00B7\u00A0\u00A0<:Buster_y:526556105422274580>#{k[9][2]}\n<:Blank:509232907555045386><:Extra_y:526556105388720130>#{k[9][3]}\u00A0\u00A0\u00B7\u00A0\u00A0<:NP:523858635843960833>#{k[9][4]}\n\n__**NP Gain**__\n*Attack:* #{k[8][0]}%#{"\n*Alt. Atk.:* #{k[8][2]}% (#{k[8][3]})" unless k[8][2].nil?}\n*Defense:* #{k[8][1]}%\n\n__**Crit Stars**__\n*Weight:* #{k[10][0]}\n*Drop Rate:* #{k[10][1]}%"])
  xpic=servant_icon(k,event)
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  create_embed(event,"__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k,1)}",text,xcolor,ftr,xpic,flds,2)
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
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  if dispfou==2000
    text="#{text}\u00A0\u00B7\u00A0<:GoldenFou:544138629832769536>"
  elsif dispfou>0
    text="#{text}\u00A0\u00B7\u00A0<:Fou:544138629694619648>"
  end
  kx=@crafts.find_index{|q| q[0]==k[23]}
  bond=">No Bond CE<"
  bond="**Bond CE:** >Unknown<" if k[0]<2
  bond="**Bond CE:** #{@crafts[kx][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless kx.nil?
  text="#{text}\n**Max. default level:** *#{k[5]}*\u00A0\u00B7\u00A0**Team Cost:** #{k[21]}\n**Availability:** *#{k[20].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*\n\n#{servant_superclass(bot,event,k)}\n\n**Command Deck:** #{k[17][0,5].gsub('Q','<:quick:523854796692783105>').gsub('A','<:arts:523854803013730316>').gsub('B','<:buster:523854810286391296>')} (#{k[17][0,5]})\n**Noble Phantasm:** #{k[17][6,1].gsub('Q','<:quick:523854796692783105>').gsub('A','<:arts:523854803013730316>').gsub('B','<:buster:523854810286391296>')} #{k[16].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\n\n#{bond}\n\n**HP:**\u00A0\u00A0#{longFormattedNumber(k[6][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[6][2]+dispfou)}<:holy_grail:523842742992764940>\n**Atk:**\u00A0\u00A0#{longFormattedNumber(k[7][0]+dispfou)}\u00A0L#{micronumber(1)}\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][1]+dispfou)}\u00A0max\u00A0\u00A0\u00B7\u00A0\u00A0#{longFormattedNumber(k[7][2]+dispfou)}<:holy_grail:523842742992764940>\n**Death Rate:**\u00A0#{k[11]}%\n\n**Hit Counts**:\u00A0\u00A0<:Quick_y:526556106986618880>#{k[9][0]}\u00A0\u00A0\u00B7\u00A0\u00A0<:Arts_y:526556105489252352>#{k[9][1]}\u00A0\u00A0\u00B7\u00A0\u00A0<:Buster_y:526556105422274580>#{k[9][2]}  \u00B7  <:Extra_y:526556105388720130>#{k[9][3]}\u00A0\u00A0\u00B7\u00A0\u00A0<:NP:523858635843960833>\u00A0#{k[9][4]}\n**NP\u00A0Gain:**\u00A0\u00A0*Attack:*\u00A0#{k[8][0]}%#{"  \u00B7  *Alt.Atk.:*\u00A0#{k[8][2]}%\u00A0(#{k[8][3].gsub(' ',"\u00A0")})" unless k[8][2].nil?}  \u00B7  *Defense:*\u00A0#{k[8][1]}%\n**Crit Stars:**\u00A0\u00A0*Weight:*\u00A0#{k[10][0]}\u00A0\u00A0\u00B7\u00A0\u00A0*Drop Rate:*\u00A0#{k[10][1]}%"
  xpic=servant_icon(k,event)
  ftr=nil
  ftr='You can include the word "Fou" to show the values with Fou modifiers' unless dispfou>0
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  create_embed(event,"__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k,1)}",text,xcolor,ftr,xpic)
end

def disp_servant_traits(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  text="#{text}\n**Attribute:** *#{k[12].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*\n**Alignment:** *#{k[22].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
  text="#{text}\n**Gender:** *#{k[13][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*" if ['Female','Male'].include?(k[13][0])
  text="#{text}\n~~**Gender:** *Effeminate*~~" if [10,94,143].include?(k[0])
  xpic=servant_icon(k,event)
  ftr=nil
  unless chain
    ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
    ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
    ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
    ftr="For the other servant named Solomon, try servant #152." if k[0]==83
    ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  end
  create_embed(event,"#{"__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k)}" unless chain}",text,xcolor,ftr,xpic,triple_finish(k[13].reject{|q| ['Female','Male'].include?(q)}))
end

def disp_enemy_traits(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_enemy,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  create_embed(event,"__**#{k[0]}**__ [Enemy]","**Attribute:** *#{k[1]}*",0x800000,nil,nil,triple_finish(k[2]))
end

def disp_servant_skills(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_i}1"
  dispnum="0012" if k[0]<2
  dispnum="0016" if k[0]==1.2
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  actsklz=[]
  if k[14][0][0]=='-'
    actsklz.push('>None<')
  else
    for i in 0...k[14].length
      str="#{'__' if safe_to_spam?(event,nil,1)}**Skill #{i+1}: #{k[14][i][0]}**#{'__' if safe_to_spam?(event,nil,1)}"
      str="#{str}\n*Obtained in Interlude or Rank-Up Quest*" if [19,21,9,32,42,28,23,29,35,31,15,34,16,53,56,13,25,22,36,48,45,54,46,41,5,103].include?(k[0]) && i==k[14].length-1
      if safe_to_spam?(event,nil,1)
        k2=@skills[@skills.find_index{|q| q[2]=='Skill' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[14][i][0]}].map{|q| q}
        str="#{str}\n*Cooldown:* #{k2[3]}\u00A0L#{micronumber(1)}  \u00B7  #{k2[3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k2[3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{k2[4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
        for i2 in 6...k2.length
          unless k2[i2][0]=='-'
            str="#{str}\n#{k2[i2][0]}"
            unless k2[i2][1].nil?
              x=k2[i2][1]
              x2=k2[i2][6]
              x3=k2[i2][10]
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
        str="#{str}\n#{"\n__" if safe_to_spam?(event,nil,1)}*When upgraded: #{k[14][i][1]}*#{'__' if safe_to_spam?(event,nil,1)}"
        if safe_to_spam?(event,nil,1)
          k2=@skills[@skills.find_index{|q| q[2]=='Skill' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[14][i][1] && k2 != q}].map{|q| q}
          str="#{str}\n*Cooldown:* #{k2[3]}\u00A0L#{micronumber(1)}  \u00B7  #{k2[3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k2[3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{k2[4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
          for i2 in 6...k2.length
            unless k2[i2][0]=='-'
              str="#{str}\n#{k2[i2][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
              unless k2[i2][1].nil?
                x=k2[i2][1]
                x2=k2[i2][6]
                x3=k2[i2][10]
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
      str="*#{k[15][i].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
      k2=@skills[@skills.find_index{|q| q[2]=='Passive' && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}"==k[15][i]}]
      str="#{str}: #{k2[3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
      passklz.push(str)
    end
  end
  xpic=servant_icon(k,event)
  ftr=nil
  unless chain
    ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
    ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
    ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
    ftr="For the other servant named Solomon, try servant #152." if k[0]==83
    ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  end
  ftr='For skill descriptions, use this command in PM or a bot spam channel.' unless safe_to_spam?(event)
  if actsklz.join("\n\n").length+passklz.join("\n").length+text.length+"#{"__**#{k[1]}**__ [##{k[0]}]" unless chain}".length>=1700
    create_embed(event,"#{"__**#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__ [##{k[0]}]" unless chain}","#{text}\n\n#{actsklz.join("\n\n")}",xcolor,nil,xpic)
    create_embed(event,'__*Passive Skills*__',passklz.join("\n"),xcolor,ftr)
  else
    create_embed(event,"#{"__**#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k)}" unless chain}","#{text}\n\n#{actsklz.join("\n\n")}\n\n__**Passive Skills**__\n#{passklz.join("\n")}",xcolor,ftr,xpic)
  end
end

def disp_servant_np(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  np="*"
  nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]==k[0].to_s}
  unless nophan.nil?
    nophan=@skills[nophan]
    np="#{':* ' unless chain}#{nophan[3].encode(Encoding::UTF_8).gsub('ΓÇï','').gsub('┬á','')}" if nophan[3].length>0
  end
  text="#{text}\n\n**Noble Phantasm:** *#{k[16].encode(Encoding::UTF_8).gsub('ΓÇï','').gsub('┬á','')}#{np}" unless chain
  npl=1
  npl=0 if ['Event','Welfare'].include?(k[20])
  npl=1 if event.message.text.downcase.split(' ').include?('np1')
  npl=2 if event.message.text.downcase.split(' ').include?('np2')
  npl=3 if event.message.text.downcase.split(' ').include?('np3')
  npl=4 if event.message.text.downcase.split(' ').include?('np4')
  npl=5 if event.message.text.downcase.split(' ').include?('np5')
  npl=1 if event.message.text.downcase.split(' ').include?('kh1') && k[0]==154
  npl=2 if event.message.text.downcase.split(' ').include?('kh2') && k[0]==154
  npl=3 if event.message.text.downcase.split(' ').include?('kh3') && k[0]==154
  npl=4 if event.message.text.downcase.split(' ').include?('kh4') && k[0]==154
  npl=5 if event.message.text.downcase.split(' ').include?('kh5') && k[0]==154
  unless nophan.nil?
    l=[nophan[5],nophan[6]]
    text="#{text}\n**Card Type:** #{k[17][6,1].gsub('Q','<:quick:523854796692783105> Quick').gsub('A','<:arts:523854803013730316> Arts').gsub('B','<:buster:523854810286391296> Buster')}\n**Counter Type:** #{nophan[5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\n**Target:** #{nophan[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\n\n**Rank:** #{nophan[4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\n__**Effects**__"
    for i in 8...18
      unless nophan[i][0]=='-'
        text="#{text}\n*#{nophan[i][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
        if nophan[i][0].include?('<LEVEL>') && safe_to_spam?(event)
          text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(1)}\u00A0/\u00A0#{nophan[i][2].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(2)}\u00A0/\u00A0#{nophan[i][3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(3)}\u00A0/\u00A0#{nophan[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(4)}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(5)}" unless nophan[i][1].nil? || nophan[i][1]=='-'
        elsif nophan[i][0].include?('<OVERCHARGE>')
          text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][2].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless nophan[i][1].nil? || nophan[i][1]=='-'
        elsif npl==0 && nophan[i][0].include?('<LEVEL>')
          text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(1)}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(5)}" unless nophan[i][1].nil? || nophan[i][1]=='-'
        elsif nophan[i].length<=1
        else
          text="#{text} - #{nophan[i][npl].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless nophan[i][npl].nil? || nophan[i][npl]=='-'
        end
      end
    end
    tags=nophan[7]
    nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]=="#{k[0].to_s}u"}
    if nophan.nil?
      text="#{text}\n\n**Skill tags:** #{tags.join(', ')}" if tags.length>0
    else
      nophan=@skills[nophan]
      nophan[5]=nophan[5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
      nophan[6]=nophan[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')
      l[0]=(nophan[5]!=l[0] rescue (nophan[5].encode(Encoding::UTF_8)!=l[0].encode(Encoding::UTF_8)))
      l[1]=(nophan[6]!=l[1] rescue (nophan[6].encode(Encoding::UTF_8)!=l[1].encode(Encoding::UTF_8)))
      text="#{text}#{"\n" if l[0] || l[1]}"
      text="#{text}#{"\n**Counter Type:** #{nophan[5].encode(Encoding::UTF_8)}" if l[0]}"
      text="#{text}#{"\n**Target:** #{nophan[6].encode(Encoding::UTF_8)}" if l[1]}"
      text="#{text}#{"\n" unless l[1] || l[0]}\n**Rank:** #{nophan[4].encode(Encoding::UTF_8)}"
      text="#{text}\n__**Effects**__"
      for i in 8...18
        unless nophan[i][0]=='-'
          text="#{text}\n*#{nophan[i][0]}*"
          if nophan[i][0].include?('<LEVEL>') && safe_to_spam?(event)
            text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(1)}\u00A0/\u00A0#{nophan[i][2].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(2)}\u00A0/\u00A0#{nophan[i][3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(3)}\u00A0/\u00A0#{nophan[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(4)}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(5)}" unless nophan[i][1].nil? || nophan[i][1]=='-'
          elsif nophan[i][0].include?('<OVERCHARGE>')
            text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][2].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless nophan[i][1].nil? || nophan[i][1]=='-'
          elsif npl==0 && nophan[i][0].include?('<LEVEL>')
            text="#{text} - #{nophan[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(1)}\u00A0/\u00A0#{nophan[i][5].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\u00A0NP#{micronumber(5)}" unless nophan[i][1].nil? || nophan[i][1]=='-'
          elsif nophan[i].length<=1
          else
            text="#{text} - #{nophan[i][npl]}" unless nophan[i][npl].nil? || nophan[i][npl]=='-'
          end
        end
      end
      tags2=nophan[7]
      tags3="#{tags.join("\n")}\n#{tags2.join("\n")}".split("\n").uniq
      for i in 0...tags3.length
        if tags.include?(tags3[i]) && tags2.include?(tags3[i])
          tags3[i]="*#{tags3[i]}*"
        elsif tags.include?(tags3[i])
          tags3[i]="~~#{tags3[i]}~~"
        end
      end
      text="#{text}\n\n**Skill tags:** #{tags3.join(', ')}" if tags3.length>0
    end
  end
  ftr='You can also include NP# to show relevant stats at other merge counts.' if npl==1
  if safe_to_spam?(event)
    ftr=nil
    unless chain
      ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
      ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
      ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
      ftr="For the other servant named Solomon, try servant #152." if k[0]==83
      ftr="For the other servant named Solomon, try servant #83." if k[0]==152
    end
  end
  return nil if chain && text.length<=0
  create_embed(event,"#{"__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k)}#{" - NP#{npl}" if npl>1 && !safe_to_spam?(event)}#{" - NPWelfare" if npl<1 && !safe_to_spam?(event)}" unless chain}#{"**#{k[16]}#{":** *#{np}*" unless np.length<2}#{'**' if np.length<2}#{"\nLevel #{npl}" if npl>1 && !safe_to_spam?(event)}" if chain}",text,xcolor,ftr,nil)
end

def disp_servant_ce(bot,event,args=nil,chain=false,skipftr=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  end
  xcolor=servant_color(k)
  text=''
  ce=@crafts.find_index{|q| q[0]==k[23]}
  ce=@crafts[ce] unless ce.nil?
  ftr=nil
  unless chain
    ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
    ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
    ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
    ftr="For the other servant named Solomon, try servant #152." if k[0]==83
    ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  end
  if event.message.text.split(' ').include?(k[0].to_s) && k[0]>=2 && !skipftr
    cex=@crafts[k[0]-@crafts[0][0]]
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
    xpic="http://fate-go.cirnopedia.org/icons/essence_sample/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
    text="#{"<:FGO_icon_rarity_mono:523903551144198145>"*ce[2]}\n**Cost:** #{ce[3]}"
    text="#{text}\n**<:Bond:523903660913197056> Bond CE for:** *#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [##{k[0]}]*" unless chain
    if ce[4]==ce[5] && ce[6]==ce[7]
      text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    else
      text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
      text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    end
    text="#{text}\n\n__**Artist**__\n#{ce[9].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[9].nil? || ce[9].length.zero?
    text="#{text}\n\n__**Additional info**__\n#{ce[11].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[11].nil? || ce[11].length.zero?
  end
  create_embed(event,"#{"**#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}** [CE-##{ce[0]}]" unless ce.nil?}",text,xcolor,ftr,xpic)
end

def disp_servant_ce2(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  puts k.map{|q| q.to_s}
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[26].nil? || k[26].length<=0
    event.respond "#{k[1]} [Srv-##{k[0]}] has no Valentine's CEs"
    return nil
  end
  xcolor=servant_color(k)
  xcolor=0xFF42AC
  text=''
  ce=@crafts.find_index{|q| q[0]==k[26][0]}
  ce=@crafts[ce] unless ce.nil?
  ftr=nil
  ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
  ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  if ce.nil?
    xpic=nil
    text=">No CE information known<"
  else
    ce[7]="#{ce[6]}" if ce[7].nil? || ce[7].length<=0
    xpic="http://fate-go.cirnopedia.org/icons/essence_sample/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
    text="#{"<:FGO_icon_rarity_mono:523903551144198145>"*ce[2]}\n**Cost:** #{ce[3]}"
    text="#{text}\n**<:Valentines:523903633453219852> Valentine's CE for:** *#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [##{k[0]}]*"
    if ce[4]==ce[5] && ce[6]==ce[7]
      text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    else
      text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
      text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    end
    text="#{text}\n\n__**Artist**__\n#{ce[9].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[9].nil? || ce[9].length.zero?
    text="#{text}\n\n__**Additional info**__\n#{ce[11].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[11].nil? || ce[11].length.zero?
  end
  create_embed(event,"#{"**#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}** [CE ##{ce[0]}]" unless ce.nil?}",text,xcolor,ftr,xpic)
  if k[26].length>1
    text=''
    ce=@crafts.find_index{|q| q[0]==k[26][1]}
    ce=@crafts[ce] unless ce.nil?
    ftr=nil
    ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
    ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
    ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
    ftr="For the other servant named Solomon, try servant #152." if k[0]==83
    ftr="For the other servant named Solomon, try servant #83." if k[0]==152
    if ce.nil?
      xpic=nil
      text=">No CE information known<"
    else
      ce[7]="#{ce[6]}" if ce[7].nil? || ce[7].length<=0
      xpic="http://fate-go.cirnopedia.org/icons/essence_sample/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
      text="#{"<:FGO_icon_rarity_mono:523903551144198145>"*ce[2]}\n**Cost:** #{ce[3]}"
      text="#{text}\n**<:Valentines:523903633453219852> Valentine's CE for:** *#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [##{k[0]}]*"
      if ce[4]==ce[5] && ce[6]==ce[7]
        text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
      else
        text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
        text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
      end
      text="#{text}\n\n__**Artist**__\n#{ce[9].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[9].nil? || ce[9].length.zero?
      text="#{text}\n\n__**Additional info**__\n#{ce[11].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[11].nil? || ce[11].length.zero?
    end
    create_embed(event,"#{"**#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}** [CE-##{ce[0]}]" unless ce.nil?}",text,xcolor,ftr,xpic)
  end
end

def disp_servant_mats(bot,event,args=nil,chain=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.' unless chain
    return nil
  elsif k[20]=='Unavailable' && chain
    return nil
  end
  xcolor=servant_color(k)
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  text='' if chain
  xpic=servant_icon(k,event)
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
  qpd='<:QP:523842660407181324>'
  qpd=' QP' if event.message.text.downcase.split(' ').include?('colorblind') || event.message.text.downcase.split(' ').include?('textmats')
  flds=[["Ascension materials (#{numabr(qp[0,4].inject(0){|sum,x| sum + x })}#{qpd} total)","*First Ascension:* #{k[18][0].join(', ')}  \u00B7  #{numabr(qp[0])}#{qpd}\n*Second Ascension:* #{k[18][1].join(', ')}  \u00B7  #{numabr(qp[1])}#{qpd}\n*Third Ascension:* #{k[18][2].join(', ')}  \u00B7  #{numabr(qp[2])}#{qpd}\n*Final Ascension:* #{k[18][3].join(', ')}  \u00B7  #{numabr(qp[3])}#{qpd}"]]
  flds[0]=['Ascension',"*First Ascension:* #{k[18][0].join(', ')}\n*Second Ascension:* #{k[18][1].join(', ')}\n*Third Ascension:* #{k[18][2].join(', ')}\n*Final Ascension:* #{k[18][3].join(', ')}"] if k[0]<2
  flds.push(['Costume materials',"#{'*First Costume:* ' unless k[18][5].nil?}#{k[18][4].join(', ')}  \u00B7  3mil#{qpd}#{"\n*Second Costume:* #{k[18][5].join(', ')}  \u00B7  3mil#{qpd}" unless k[18][5].nil?}"]) unless k[18][4].nil? || k[0]<2
  flds.push(['Costume materials',"#{'*First Costume:* ' unless k[18][5].nil?}#{k[18][4].join(', ')}  \u00B7  3mil#{qpd}#{"\n*Second Costume:* #{k[18][5].join(', ')}\n~~the second costume is listed in this bot as Servant #1.2~~" unless k[18][5].nil?}"]) unless k[18][4].nil? || k[0]>=2
  flds.push(["Skill Enhancement materials (#{numabr(3*(qp[4,9].inject(0){|sum,x| sum + x }))}#{qpd} total)","*Level 1\u21922:* #{k[19][0].join(', ')}  \u00B7  #{numabr(qp[4])}#{qpd}\n*Level 2\u21923:* #{k[19][1].join(', ')}  \u00B7  #{numabr(qp[5])}#{qpd}\n*Level 3\u21924:* #{k[19][2].join(', ')}  \u00B7  #{numabr(qp[6])}#{qpd}\n*Level 4\u21925:* #{k[19][3].join(', ')}  \u00B7  #{numabr(qp[7])}#{qpd}\n*Level 5\u21926:* #{k[19][4].join(', ')}  \u00B7  #{numabr(qp[8])}#{qpd}\n*Level 6\u21927:* #{k[19][5].join(', ')}  \u00B7  #{numabr(qp[9])}#{qpd}\n*Level 7\u21928:* #{k[19][6].join(', ')}  \u00B7  #{numabr(qp[10])}#{qpd}\n*Level 8\u21929:* #{k[19][7].join(', ')}  \u00B7  #{numabr(qp[11])}#{qpd}\n*Level 9\u219210:* #{k[19][8].join(', ')}  \u00B7  #{numabr(qp[12])}#{qpd}"]) unless k[20]=='Unavailable' || k[19].nil? || k[19][0].nil? || k[19][0]=='-' || k[19][0][0].nil? || k[19][0][0].length<=0 || k[19][0][0]=='-'
  ftr=nil
  ftr='If you have trouble seeing the material icons, try the command again with the word "TextMats" included in your message.' unless event.message.text.downcase.split(' ').include?('colorblind') || event.message.text.downcase.split(' ').include?('textmats')
  if chain
    ftr='For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if k[0]==1.0
    ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
    ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
    ftr="For the other servant named Solomon, try servant #152." if k[0]==83
    ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  end
  str="#{text}\n\n#{flds[0,flds.length-1].map{|q| "__**#{q[0]}**__\n#{q[1]}"}.join("\n\n")}"
  hdr="#{"__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k)}" unless chain}"
  if hdr.length+(ftr.length rescue 0)+str.length+"__**#{flds[-1][0]}**__\n#{flds[-1][1]}".length>=1900
    create_embed(event,hdr,str,xcolor,nil,xpic,nil,1)
    str="__**#{flds[-1][0]}**__"
    hdr=''
    xpic=''
  else
    str=extend_message(str,"__**#{flds[-1][0]}**__",event,2)
  end
  k=flds[-1][1].split("\n")
  respo=false
  respo=true if str[0,1]!='_' && str[0,2]!='**' && str[0,2]!='<:' && ![str[0,1],str[0,2]].include?("\n")
  for i in 0...k.length
    str=extend_message(str,k[i],event)
    respo=true if str[0,1]!='_' && str[0,2]!='**' && str[0,2]!='<:' && ![str[0,1],str[0,2]].include?("\n")
  end
  if respo
    str=extend_message(str,ftr,event,2)
    event.respond str
  else
    create_embed(event,hdr,str,xcolor,ftr,xpic,nil,1)
  end
end

def disp_servant_art(bot,event,args=nil,riyodefault=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=servant_color(k)
  dispnum="#{'0' if k[0]<100}#{'0' if k[0]<10}#{k[0].to_s.gsub('.','p')}"
  disptext=event.message.text.downcase
  if has_any?(disptext.split(' '),['bondce','bond','bond_ce','bonds','bond-ce'])
    ce=@crafts.find_index{|q| q[0]==k[23]}
    unless ce.nil?
      disp_ce_art(bot,event,["CE#{k[23]}"])
      return nil
    end
  elsif has_any?(disptext.split(' '),["valentine's",'valentines','valentine','chocolate',"valentine'sce",'valentinesce','valentinece',"valentine's-ce",'valentines-ce','valentine-ce'])
    unless k[26].nil? || k[26].length<=0
      ce=@crafts.find_index{|q| q[0]==k[26][0]}
      unless ce.nil?
        for i in 0...k[26].length
          disp_ce_art(bot,event,["CE#{k[26][i]}"])
        end
        return nil
      end
    end
  end
  artist=nil
  artist=k[24] unless k[24].nil? || k[24].length<=0
  t=Time.now
  riyodefault= !riyodefault if t.month==4 && t.day==1
  censor=true
  censor=false if disptext.split(' ').include?('jp') || disptext.split(' ').include?('nsfw')
  asc=1
  asc=2 if has_any?(disptext.split(' '),['first','firstascension','first_ascension','1st','1stascension','1st_ascension','second','secondascension','2nd','second_ascension','2ndascension','2nd_ascension']) || " #{disptext} ".include?(" first ascension ") || " #{disptext} ".include?(" 1st ascension ") || " #{disptext} ".include?(" second ascension ") || " #{disptext} ".include?(" 2nd ascension ")
  asc=3 if has_any?(disptext.split(' '),['third','thirdascension','third_ascension','3rd','3rdascension','3rd_ascension']) || " #{disptext} ".include?(" third ascension ") || " #{disptext} ".include?(" 3rd ascension ")
  asc=4 if has_any?(disptext.split(' '),['fourth','fourthascension','fourth_ascension','4th','4thascension','4th_ascension','final','finalascension','final_ascension']) || " #{disptext} ".include?(" fourth ascension ") || " #{disptext} ".include?(" 4th ascension ") || " #{disptext} ".include?(" final ascension ")
  asc=5 if has_any?(disptext.split(' '),['costume','firstcostume','first_costume','1stcostume','1st_costume','costume1']) || " #{disptext} ".include?(" first costume ") || " #{disptext} ".include?(" 1st costume ") || " #{disptext} ".include?(" costume 1 ")
  asc=6 if has_any?(disptext.split(' '),['secondcostume','second_costume','2ndcostume','2nd_costume','costume2']) || " #{disptext} ".include?(" second costume ") || " #{disptext} ".include?(" 2nd costume ") || " #{disptext} ".include?(" costume 2 ")
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}#{asc}.png"
  if riyodefault || has_any?(disptext.split(' '),['riyo','aprilfools']) || disptext.split(' ').include?("aprilfool's") || disptext.split(' ').include?("april_fool's") || disptext.split(' ').include?("april_fools") || " #{disptext} ".include?(" april fool's ") || " #{disptext} ".include?(" april fools ")
    asc=0
    xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/servant_#{dispnum}.png"
    artist='Riyo'
  end
  if censor
    m=false
    IO.copy_stream(open(xpic.gsub('.png','c.png')), "C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png") rescue m=true
    if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
      censor=false
    else
      censor='Censored NA version'
      xpic=xpic.gsub('.png','c.png')
    end
  else
    m=false
    IO.copy_stream(open(xpic.gsub('.png','c.png')), "C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png") rescue m=true
    unless File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
      censor='Default JP version'
    end
  end
  ftr=nil
  ftr="This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if k[0]==1.1
  ftr="This servant can switch to servant #1.1 at her Master's wish." if k[0]==1.2
  ftr="For the other servant named Solomon, try servant #152." if k[0]==83
  ftr="For the other servant named Solomon, try servant #83." if k[0]==152
  if event.message.text.split(' ').include?(k[0].to_s) && k[0]>=2
    cex=@crafts[k[0]-@crafts[0][0]]
    ftr="This is the art for servant ##{k[0]}.  For the CE numbered #{k[0]}, it is named \"#{cex[1]}\"."
  elsif event.message.text.split(' ').include?('1') && k[0]<2
    cex=@crafts[0]
    ftr="This is the art for servant ##{k[0]}.  For the CE numbered #{k[0].to_i}, it is named \"#{cex[1]}\"."
  end
  text="<:fgo_icon_rarity:523858991571533825>"*k[3]
  text="**0-star**" if k[3]==0
  m=false
  IO.copy_stream(open(xpic), "C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png") rescue m=true
  toptext=''
  midtext=''
  if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
    midtext="~~#{["April Fool's Art",'Default (Zeroth Ascension)','First/Second Ascension','Third Ascension','Final Ascension','First Costume','Second Costume'][asc]}~~\n"
    xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{dispnum}1.png"
    artist=k[24] unless k[24].nil? || k[24].length<=0
    asc=1
    text="#{text}\n\nRequested art not found.  Default art shown."
  elsif k[0]<1.2 && asc==6
    toptext="~~__**#{k[1]}**__ [Srv-##{k[0]}]\nSecond Costume~~\n\n"
    asc=1
    k=@servants[@servants.find_index{|q| q[0]==1.2}].map{|q| q}
    text="#{"<:fgo_icon_rarity:523858991571533825>"*k[3]}\n\nThis costume is considered Servant #1.2 by this bot."
  end
  f=[[],[],[]]
  f[2]=@servants.reject{|q| q[24]!=artist || q[25]!=k[25] || q[0]==k[0]}.map{|q| "Srv-#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"} unless artist.nil? || k[25].nil? || k[25].length<=0
  f[0]=@servants.reject{|q| q[24]!=artist || q[0]==k[0]}.map{|q| "Srv-#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.reject{|q| f[2].include?(q)} unless artist.nil?
  f[1]=@servants.reject{|q| q[25]!=k[25] || q[0]==k[0]}.map{|q| "Srv-#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.reject{|q| f[2].include?(q)} unless k[25].nil? || k[25].length<=0
  f[0].push("~~Every servant's April Fool's Day art~~") if artist=='Riyo'
  crf=@crafts.map{|q| q}
  for i in 0...crf.length
    f[0].push("CE-#{crf[i][0]}.) #{crf[i][1]}") if crf[i][9]==artist
  end
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    if !b[i][6].nil? && b[i][6].length>0 && !b[i][8].nil? && b[i][8].length>0
      f[2].push("#{b[i][0]} *[FEH]*") if b[i][6].split(' as ')[-1]==artist && b[i][8].split(' as ')[0]==k[25]
    end
    if !b[i][6].nil? && b[i][6].length>0
      f[0].push("#{b[i][0]} *[FEH]*") if b[i][6].split(' as ')[-1]==artist && b[i][8].split(' as ')[0]!=k[25]
    end
    if !b[i][8].nil? && b[i][8].length>0
      f[1].push("#{b[i][0]} *[FEH]*") if b[i][6].split(' as ')[-1]!=artist && b[i][8].split(' as ')[0]==k[25]
    end
  end
  f=[['Same Artist',f[0]],['Same VA',f[1]],['Same everything',f[2],1]]
  if k[25].include?(' & ')
    m=k[25].split(' & ')
    for i in 0...m.length
      f[1][1].push(@servants.reject{|q| q[25]!=m[i]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]} *[voice #{i+1}]*"}.join("\n"))
    end
  end
  for i in 0...f.length
    f[i][1]=f[i][1].join("\n")
    f[i]=nil if f[i][1].length<=0
  end
  f.compact!
  f=nil if f.length<=0
  asc=["April Fool's Art",'Default (Zeroth Ascension)','First/Second Ascension','Third Ascension','Final Ascension','First Costume','Second Costume'][asc]
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    str=''
    for i in 0...f.length
      str=extend_message(str,"__**#{f[i][0]}**__",event,2)
      f[i][1]=f[i][1].split("\n")
      for i2 in 0...f[i][1].length
        ff='  -  '
        ff="\n" if i2==0
        str=extend_message(str,f[i][1][i2].gsub(' ',"\u00A0").gsub('-',"\u2011"),event,1,ff)
      end
    end
    str=extend_message(str,ftr,event,2) unless ftr.nil?
    str=extend_message(str,"#{text}#{"#{"\n\n" if text.length>0}**Artist:** #{artist}" unless artist.nil?}#{"\n**VA (Japanese):** #{k[25]}" unless k[25].nil? || k[25].length<=0}\n#{xpic}",event,2)
    event.respond str
  else
    text="#{text}\n" if !artist.nil? || !(k[25].nil? || k[25].length<=0)
    text="#{text}\n**Artist:** #{artist}" unless artist.nil?
    text="#{text}\n**VA (Japanese):** #{k[25]}" unless k[25].nil? || k[25].length<=0
    if f.nil?
    elsif f.map{|q| q.join("\n")}.join("\n\n").length>=1400 && safe_to_spam?(event)
      if f.map{|q| q.join("\n")}.join("\n\n").length>=1400
        str=''
        for i in 0...f.length
          str=extend_message(str,"__**#{f[i][0]}**__",event,2)
          f[i][1]=f[i][1].split("\n")
          for i2 in 0...f[i][1].length
            ff='  -  '
            ff="\n" if i2==0
            str=extend_message(str,f[i][1][i2].gsub(' ',"\u00A0").gsub('-',"\u2011"),event,1,ff)
          end
        end
        event.respond str
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
      event.channel.send_embed("#{toptext}__**#{k[1]}**__ [Srv-##{k[0]}]\n#{midtext}#{asc}#{"\n#{censor}" if censor.is_a?(String)}") do |embed|
        embed.description=text
        embed.color=xcolor
        embed.footer={"text"=>ftr} unless ftr.nil?
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
      end
      return nil
    elsif f.map{|q| q.join("\n")}.join("\n\n").length>=1400 || (f.map{|q| q[1].split("\n").length}.max>12 && !safe_to_spam?(event))
      text="#{text}\nThe list of servants and CEs with the same artist and/or VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      f=nil
    end
    unless f.nil?
      for i in 0...f.length
        text="#{text}\n\n__**#{f[i][0]}**__\n#{f[i][1]}"
      end
    end
    event.channel.send_embed("#{toptext}__**#{k[1]}**__ [Srv-##{k[0]}] #{servant_moji(bot,event,k)}\n#{midtext}#{asc}#{"\n#{censor}" if censor.is_a?(String)}") do |embed|
      embed.description=text
      embed.color=xcolor
      embed.footer={"text"=>ftr} unless ftr.nil?
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
    end
  end
end

def disp_ce_card(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  ce=find_data_ex(:find_ce,args.join(' '),event)
  if ce.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0x7D4529
  xcolor=0x718F93 if ce[2]>2
  xcolor=0xF5D672 if ce[2]>3
  k=@servants.find_index{|q| q[23]==ce[0]}
  k2=@servants.find_index{|q| !q[26].nil? && q[26].include?(ce[0])}
  k=@servants[k] unless k.nil?
  k2=@servants[k2] unless k2.nil?
  xcolor=servant_color(k) unless k.nil?
  xcolor=0xFF42AC unless k2.nil?
  text=''
  ce[7]="#{ce[6]}" if ce[7].nil? || ce[7].length<=0
  xpic="http://fate-go.cirnopedia.org/icons/essence_sample/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
  text="#{"<:FGO_icon_rarity_mono:523903551144198145>"*ce[2]}\n**Cost:** #{ce[3]}"
  text="#{text}\n**<:Bond:523903660913197056> Bond CE for:** *#{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [##{k[0]}]*" unless k.nil?
  text="#{text}\n**<:Valentines:523903633453219852> Valentine's CE for:** *#{k2[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [##{k2[0]}]*" unless k2.nil?
  text="#{text}\n**Availability:** #{ce[8].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" if k.nil?
  if !ce[10].nil? && ce[10].include?('NewYear')
    text="#{text}\n\n__**Japan** stats__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}"
    text="#{text}\n\n__**North America** stats__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}"
    if ce[6]==ce[7]
      text="#{text}\n\n__**Effect**__\n#{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    else
      text="#{text}\n\n__**Base Limit**__\n#{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
      text="#{text}\n\n__**Max Limit**__\n#{ce[7].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    end
  elsif ce[4]==ce[5] && ce[6]==ce[7]
    text="#{text}\n\n**HP:** #{ce[4][0]}\n**Atk:** #{ce[4][1]}\n**Effect:** #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
  else
    text="#{text}\n\n__**Base Limit**__\n*HP:* #{ce[4][0]}  \u00B7  *Atk:* #{ce[4][1]}\n*Effect:* #{ce[6].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
    text="#{text}\n\n__**Max Limit**__\n*HP:* #{ce[5][0]}  \u00B7  *Atk:* #{ce[5][1]}\n*Effect:* #{ce[7].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('; ',"\n")}"
  end
  text="#{text}\n\n__**Artist**__\n#{ce[9].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[9].nil? || ce[9].length.zero?
  text="#{text}\n\n__**Additional info**__\n#{ce[11].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless ce[11].nil? || ce[11].length.zero?
  ftr=nil
  ftr='For the other CE given the title "Heaven\'s Feel" in-game, it has been given the name "Heaven\'s Feel (Anime Japan)".' if ce[0]==35
  ftr="For the other CE given the title \"#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}\" in-game, it has been given the name \"#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} [Lancer]\"." if [595,826].include?(ce[0])
  create_embed(event,"**#{ce[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}** [CE-##{ce[0]}]",text,xcolor,ftr,xpic)
end

def disp_ce_art(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  ce=find_data_ex(:find_ce,args.join(' '),event)
  if ce.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0x7D4529
  xcolor=0x718F93 if ce[2]>2
  xcolor=0xF5D672 if ce[2]>3
  xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Crafts/craft_essence_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
  text="<:FGO_icon_rarity_mono:523903551144198145>"*ce[2]
  m=false
  IO.copy_stream(open(xpic), "C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png") rescue m=true
  text='Requested art not found.' if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
  artist=nil
  artist=ce[9] unless ce[9].nil? || ce[9].length<=0
  f=[]
  unless artist.nil? || artist=='-'
    f=@servants.reject{|q| q[24]!=artist}.map{|q| "Srv-#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}
    f.push("~~Every servant's April Fool's Day art~~") if artist=='Riyo'
    crf=@crafts.map{|q| q}
    for i in 0...crf.length
      f.push("CE-#{crf[i][0]}.) #{crf[i][1]}") if crf[i][9]==artist && crf[i][0]!=ce[0]
    end
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if !b[i][6].nil? && b[i][6].length>0
        f.push("#{b[i][0]} *[FEH]*") if b[i][6].split(' as ')[-1]==artist
      end
    end
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    str=''
    unless artist.nil?
      str='__**Same artist**__'
      for i in 0...f.length
        ff='  -  '
        ff="\n" if i==0
        str=extend_message(str,f[i].gsub(' ',"\u00A0").gsub('-',"\u2011"),event,1,ff)
      end
    end
    str=extend_message(str,"#{text}#{"#{"\n\n" if text.length>0}**Artist:** #{artist}" unless artist.nil?}\n#{xpic}",event,2)
    event.respond str
  else
    unless artist.nil?
      text="#{text}\n\n**Artist:** #{artist}"
    end
    if f.nil?
    elsif f.join("\n").length>=1400 && safe_to_spam?(event)
      if f.join("\n").length>=1400
        str='__**Same Artist**__'
        puts f.map{|q| q.to_s}
        for i in 0...f.length
          ff='  -  '
          ff="\n" if i==0
          str=extend_message(str,f[i].gsub(' ',"\u00A0").gsub('-',"\u2011"),event,1,ff)
        end
        event.respond str
      else
        event.channel.send_embed('') do |embed|
          embed.color=xcolor
          unless f.nil?
            embed.add_field(name: 'Same VA', value: f.join("\n"), inline: true)
          end
        end
      end
      event.channel.send_embed("__**#{ce[1]}**__ [CE ##{ce[0]}]") do |embed|
        embed.description=text
        embed.color=xcolor
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
      end
      return nil
    elsif f.join("\n").length>=1400 || (f.length>12 && !safe_to_spam?(event))
      text="#{text}\nThe list of servants/CEs with the same artist is so long that I cannot fit it into a single embed. Please use this command in PM."
      f=nil
    end
    text="#{text}\n\n__**Same Artist**__\n#{f.join("\n")}" unless f.nil? || f.length<=0
    event.channel.send_embed("__**#{ce[1]}**__ [CE-##{ce[0]}]") do |embed|
      embed.description=text
      embed.color=xcolor
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
    end
  end
end

def disp_code_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  ce=find_data_ex(:find_code,args.join(' '),event)
  if ce.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0x7D4529
  xcolor=0x718F93 if ce[2]>2
  xcolor=0xF5D672 if ce[2]>3
  text="#{"<:FGO_icon_rarity_rust:523903558928826372>"*ce[2]}"
  text="#{text}\n\n**Effect:** #{ce[3]}"
  text="#{text}\n\n**Additional Info:** #{ce[4]}" unless ce[4].nil? || ce[4].length<=0
  xpic="http://fate-go.cirnopedia.org/icons/ccode/ccode_#{'0' if ce[0]<100}#{'0' if ce[0]<10}#{ce[0]}.png"
  create_embed(event,"**#{ce[1]}** [Cmd-##{ce[0]}]",text,xcolor,nil,xpic)
end

def disp_skill_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_skill,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  k=k[0] if k.length<2 && k[0].is_a?(Array)
  header=''
  text=''
  ftr=nil
  tags=[]
  if k[0].is_a?(Array)
    header="__**#{k[0][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__ [#{'Active' if k[0][2]=='Skill'}#{'Passive' if k[0][2]=='Passive'}#{'Clothing' if k[0][2]=='Clothes'} Skill Family]"
    xcolor=0x0080B0
    xcolor=0xB08000 if k[0][2]=='Clothes'
    xcolor=0x008000 if k[0][2]=='Passive'
    if k.reject{|q| q[0][0,17]=='Primordial Rune ('}.length<=0 && k.map{|q| q[0]}.uniq.length>1
      header='__**Primordial Rune**__ [Active Skill Family]'
      xcolor=0x5000A0
      text2=''
      for i in 0...k.length
        text2="__**Version: #{k[i][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('Primordial Rune (','').gsub(')','')}**__\n*Rank:* #{k[i][1]}\n*Cooldown:* #{k[i][3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][3]-2}\u00A0L#{micronumber(10)}\n*Target:* #{k[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
        for i2 in 6...k[i].length
          unless k[i][i2][0]=='-'
            text2="#{text2}\n*#{k[i][i2][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
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
        text="#{text}\n**Rank #{k[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}:** #{k[i][3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
      elsif k[i][2]=='Clothes'
        text="#{text}\n*Cooldown:* #{k[i][1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][1]-2}\u00A0L#{micronumber(10)}" unless k.map{|q| q[1]}.uniq.length<=1
        for i2 in 3...k[i].length
          unless k[i][i2][0]=='-'
            text="#{text}\n*#{k[i][i2][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
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
          text="#{text}\n\n__**Variation: #{k[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','').gsub('EX(','').gsub(')','')}**__"
        else
          text="#{text}\n\n__**Rank: #{k[i][1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__"
        end
        text="#{text}\n*Cooldown:* #{k[i][3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[i][3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[i][3]-2}\u00A0L#{micronumber(10)}" unless k.map{|q| q[3]}.uniq.length<=1
        text="#{text}\n*Target:* #{k[i][4].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless k.map{|q| q[4]}.uniq.length<=1
        for i2 in 6...k[i].length
          unless k[i][i2][0]=='-'
            text="#{text}\n*#{k[i][i2][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
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
    ftr='If you\'re looking for a servants\' aliases, the command name is "aliases", not "alias".' if k[0][0][0,5].downcase=='alias'
  elsif k[2]=='Passive'
    header="__**#{k[0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')} #{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__ [Passive Skill]"
    tags=k[4]
    xcolor=0x006000
    text="**Effect:** #{k[3].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
    ftr='If you\'re looking for a servants\' aliases, the command name is "aliases", not "alias".' if k[0][0,5].downcase=='alias'
  elsif k[2]=='Clothes'
    header="__**#{k[0]}**__ [Clothing Skill]"
    xcolor=0x806000
    tags=k[3]
    text="**Cooldown:** #{k[1]}\u00A0L#{micronumber(1)}  \u00B7  #{k[1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[1]-2}\u00A0L#{micronumber(10)}"
    mx=@skills.reject{|q| q[0][0,k[0].length+2]!="#{k[0]} (" || q[1]!=k[1]}.map{|q| "#{q[0]} #{q[1]}"}.uniq
    ftr="You may also mean: #{list_lift(mx,'or')}" if mx.length>0
    ftr='If you\'re looking for a servants\' aliases, the command name is "aliases", not "alias".' if k[0][0,5].downcase=='alias'
    m=0
    for i in 3...k.length
      unless k[i][0]=='-'
        m+=1
        text="#{text}\n\n**Effect #{m}:** #{k[i][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
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
    header="__**#{k[0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}#{" #{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}" unless k[1]=='-'}**__ [Active Skill]"
    tags=k[5]
    xcolor=0x006080
    text="**Cooldown:** #{k[3]}\u00A0L#{micronumber(1)}  \u00B7  #{k[3]-1}\u00A0L#{micronumber(6)}  \u00B7  #{k[3]-2}\u00A0L#{micronumber(10)}\n**Target:** #{k[4]}"
    ftr='Use this command in PM for a list of servants who have this skill.' unless safe_to_spam?(event)
    mx=@skills.reject{|q| q[0][0,k[0].length+2]!="#{k[0]} (" || q[1]!=k[1]}.map{|q| "#{q[0]} #{q[1]}"}.uniq
    ftr="You may also mean: #{list_lift(mx,'or')}" if mx.length>0
    ftr='If you\'re looking for a servants\' aliases, the command name is "aliases", not "alias".' if k[0][0,5].downcase=='alias'
    m=0
    for i in 6...k.length
      unless k[i][0]=='-'
        m+=1 unless k[i][0][0,1]=='>'
        text="#{text}\n\n#{"**Effect #{m}:** " unless k[i][0][0,1]=='>'}#{k[i][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
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
  if safe_to_spam?(event,nil,1)
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
    flds.push(['Servants who have this skill by default',srv.join("\n")]) if srv.length>0
    flds.push(['Servants who have this skill after upgrading',srv2.join("\n")]) if srv2.length>0
    flds.push(['Skill tags',tags.join("\n")]) if safe_to_spam?(event) && tags.length>0
    text=''
    if flds.length==1
      text=flds[0][0]
      flds=triple_finish(flds[0][1].split("\n"),true)
    end
    create_embed(event,'',text,xcolor,nil,nil,flds) if flds.length>0 && (safe_to_spam?(event) || srv.length+srv2.length<=25)
  end
end

def disp_clothing_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_clothes,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=0xF08000
  text="**Availability:** #{k[1].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}"
  if safe_to_spam?(event,nil,1)
    for i in 2...5
      text="#{text}\n\n__Skill #{i-1}: **#{k[i].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__"
      skl=@skills.find_index{|q| q[2]=='Clothes' && q[0]==k[i]}
      if skl.nil?
        text="#{text}\n~~No data found~~"
      else
        skl=@skills[skl]
        text="#{text}\n*Cooldown:* #{skl[1]}\u00A0L#{micronumber(1)}  \u00B7  #{skl[1]-1}\u00A0L#{micronumber(6)}  \u00B7  #{skl[1]-2}\u00A0L#{micronumber(10)}"
        for i2 in 4...skl.length
          unless skl[i2][0]=='-'
            text="#{text}\n*#{skl[i2][0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}*"
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
    text="#{text}\n**Total EXP to reach level 10:** #{longFormattedNumber(k[5].inject(0){|sum,x| sum + x })}"
  else
    text="#{text}\n\n__**Skills:**__\n#{k[2,3].map{|q| "*#{q}*"}.join("\n")}\n\n**Total EXP to reach level 10:** #{longFormattedNumber(k[5].inject(0){|sum,x| sum + x })}"
  end
  create_embed(event,"__**#{k[0].encode(Encoding::UTF_8).gsub('┬á','').gsub('ΓÇï','')}**__",text,xcolor)
end

def disp_mat_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_mat,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  ftr=nil
  lst=[[],[],[]]
  fff=[]
  fff2=0
  fff3=0
  srvs=@servants.map{|q| q}
  for i in 0...srvs.length
    if srvs[i][0].to_i==srvs[i][0] || srvs[i][0]==1.2
      mts=[]
      mts2=[]
      rnk=['First','Second','Third','Final']
      x=srvs[i][18]
      srvtot=[0,0,0]
      for i2 in 0...x.length
        for i3 in 0...x[i2].length
          m=x[i2][i3].split(' ')
          f=m.pop
          mts.push("**#{f.gsub('x','')}** for #{rnk[i2]}") if m.join(' ')==k && i2<4
          mts2.push("**#{f.gsub('x','')}** for #{rnk[i2-4]} Costume") if m.join(' ')==k && i2>3
          fff3+=f.gsub('x','').to_i if m.join(' ')==k
          srvtot[0]+=f.gsub('x','').to_i if m.join(' ')==k && i2<4
          srvtot[1]+=f.gsub('x','').to_i if m.join(' ')==k && i2>3
        end
      end
      lst[0].push("*#{srvs[i][0]}#{'.' if srvs[i][0]>=2}#{'-1.1' if srvs[i][0]==1})* #{srvs[i][1]}  -  #{mts.join(', ')}#{"  -  __#{srvtot[0]}__ total" if mts.length>1}") if mts.length>0
      lst[1].push("*#{srvs[i][0]}#{'.' if srvs[i][0]>=2}#{'-1.1' if srvs[i][0]==1})* #{srvs[i][1]}  -  #{mts2.join(', ')}#{"  -  __#{srvtot[1]}__ total" if mts2.length>1}") if mts2.length>0
      fff.push(srvs[i][0]) if mts.length>0 || mts2.length>0
      fff2+=mts.length+mts2.length
    end
    if srvs[i][0].to_i==srvs[i][0]
      x=srvs[i][19]
      mts=[]
      for i2 in 0...x.length
        for i3 in 0...x[i2].length
          m=x[i2][i3].split(' ')
          f=m.pop
          mts.push("**#{f.gsub('x','')}** to reach L#{i2+2}") if m.join(' ')==k
          fff3+=3*f.gsub('x','').to_i if m.join(' ')==k
          srvtot[2]+=3*f.gsub('x','').to_i if m.join(' ')==k
        end
      end
      lst[2].push("*#{srvs[i][0].to_i}.)* #{srvs[i][1]} #{'~~(All forms)~~' if srvs[i][0]==1}  -  #{mts.join(', ')}  -  __#{srvtot[2]}__ total for all skills") if mts.length>0
      fff.push(srvs[i][0]) if mts.length>0 && !fff.include?(srvs[i][0])
      fff2+=mts.length
    end
  end
  text=''
  unless safe_to_spam?(event)
    ftr='For an actual list of servants who need this material, use this command in PM.'
    text="#{text}\n#{lst[0].length} servants use this material for Ascension"
    text="#{text}\n#{lst[2].length} servants use this material for Skill Enhancement"
    text="#{text}\n#{lst[1].length} servants use this material for Costumes" if lst[1].length>0
    text="#{text}\n\n#{fff.length} total servants use this material"
    text="#{text}\n#{fff2} total uses for this material"
    text="#{text}\n#{fff3} total copies of this material are required to max everyone"
  end
  mmkk=[]
  if k[0,7]=='Gem of '
    mmkk.push("#{k.gsub('Gem of ','')} Gem")
    mmkk.push("Blue #{k.gsub('Gem of ','')} Gem")
    mmkk.push("Blue #{k}")
  elsif k[0,13]=='Magic Gem of '
    mmkk.push("Magic #{k.gsub('Magic Gem of ','')} Gem")
    mmkk.push("Red #{k.gsub('Magic Gem of ','')} Gem")
    mmkk.push("Red Gem of #{k.gsub('Magic Gem of ','')}")
  elsif k[0,14]=='Secret Gem of '
    mmkk.push("Secret #{k.gsub('Secret Gem of ','')} Gem")
    mmkk.push("Yellow #{k.gsub('Secret Gem of ','')} Gem")
    mmkk.push("Yellow Gem of #{k.gsub('Secret Gem of ','')}")
    mmkk.push("#{k.gsub('Secret Gem of ','')} Cookie")
    mmkk.push("Cookie of #{k.gsub('Secret Gem of ','')}")
  end
  create_embed(event,"__**#{k}**__#{"\n#{mmkk.join("\n")}" if mmkk.length>0}",text,0x162C6E,ftr,find_emote(bot,event,k,1))
  return nil unless safe_to_spam?(event)
  str="__**Ascension uses for #{k}**__ (#{lst[0].length} total)"
  if lst[0].length<=0
    str="~~**#{k} is not used for Ascension**~~"
  else
    for i in 0...lst[0].length
      str=extend_message(str,lst[0][i],event)
    end
  end
  if lst[2].length<=0
    str=extend_message(str,"~~**#{k} is not used for Skill Enhancement**~~",event,2)
  else
    str=extend_message(str,"__**Enhancement uses for #{k}**__ (#{lst[2].length} total)",event,2)
    for i in 0...lst[2].length
      str=extend_message(str,lst[2][i],event)
    end
  end
  unless lst[1].length<=0
    str=extend_message(str,"__**Costume uses for #{k}**__ (#{lst[1].length} total)",event,2)
    for i in 0...lst[1].length
      str=extend_message(str,lst[1][i],event)
    end
  end
  str=extend_message(str,"#{fff.length} total servants use this material\n#{fff2} total uses for this material\n#{longFormattedNumber(fff3)} total copies of this material are required to max everyone",event,2)
  event.respond str
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
    if find_data_ex(:find_servant,args.join(''),event).length>0
    elsif find_data_ex(:find_skill,args.join(''),event).length>0
    elsif find_data_ex(:find_ce,args.join(''),event).length>0
    elsif find_data_ex(:find_mat,args.join(''),event).length>0
    elsif find_data_ex(:find_clothes,args.join(''),event).length>0
    elsif find_data_ex(:find_code,args.join(''),event).length>0
    elsif has_any?(args,['servant','servants','unit','units','character','characters','chara','charas','char','chars','skill','skills','skil','skils','ce','ces','craft','crafts','essance','essances','craftessance','craftessances','craft_essance','craft_essances','craft-essance','craft-essances','mat','mats','materials','material','mysticcode','mystic_code','mystic-code','mysticode','mystic','mysticcodes','mystic_codes','mystic-codes','mysticodes','mystics','clothes','clothing','commandcode','command_code','command-code','command','commandcodes','command_codes','command-codes','commands'])
    else
      event.respond "The alias system can cover:\n- Servants\n- Skills (Active, Passive, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\n#{args.join(' ')} does not fall into any of these categories."
      return nil
    end
  end
  unit=find_data_ex(:find_servant,args.join(''),event)
  unit=nil if unit.length<=0 || args.length.zero?
  skl=find_data_ex(:find_skill,args.join(''),event)
  skl=nil if skl.length<=0 || args.length.zero?
  ce=find_data_ex(:find_ce,args.join(''),event)
  ce=nil if ce.length<=0 || args.length.zero?
  mat=find_data_ex(:find_mat,args.join(''),event)
  mat=nil if mat.length<=0 || args.length.zero?
  cloth=find_data_ex(:find_clothes,args.join(''),event)
  cloth=nil if cloth.length<=0 || args.length.zero?
  ccode=find_data_ex(:find_code,args.join(''),event)
  ccode=nil if ccode.length<=0 || args.length.zero?
  f=[]
  n=@aliases.reject{|q| q[0]!='Servant' || (q[2]==154 && q[1][0,2]=='KH' && q[1][2,1].to_i>0 && q[1][2,1].to_i<6)}.map{|q| [q[1],q[2],q[3]]}
  h=''
  if unit.nil? && skl.nil? && ce.nil? && mat.nil? && cloth.nil? && ccode.nil?
    if has_any?(args,['servant','servants','unit','units','character','characters','chara','charas','char','chars'])
      n=n.reject{|q| q[2].nil?} if mode==1
      f.push('__**Servant Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        untnme=@servants[@servants.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['skill','skills','skil','skils'])
      f.push('__**Skill Aliases**__')
      n=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['ce','ces','craft','crafts','essance','essances','craftessance','craftessances','craft_essance','craft_essances','craft-essance','craft-essances'])
      f.push('__**Craft Essance Aliases**__')
      n=@aliases.reject{|q| q[0]!='Craft'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        untnme=@crafts[@crafts.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['mat','mats','materials','material'])
      f.push('__**Material Aliases**__')
      n=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
      mmkk=['Archer','Assassin','Berserker','Caster','Lancer','Rider','Saber']
      for i in 0...mmkk.length
        n.push(["#{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
        n.push(["Blue #{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
        n.push(["Blue Gem of #{mmkk[i]}","Gem of #{mmkk[i]}"])
        n.push(["Magic #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
        n.push(["Red #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
        n.push(["Red Gem of #{mmkk[i]}","Magic Gem of #{mmkk[i]}"])
        n.push(["Secret #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
        n.push(["Yellow #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
        n.push(["Yellow Gem of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
        n.push(["#{mmkk[i]} Cookie","Secret Gem of #{mmkk[i]}"])
        n.push(["Cookie of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
      end
      n=n.reject{|q| q[2].nil?} if mode==1
      n.sort! {|a,b| (a[1]<=>b[1]) == 0 ? (a[0]<=>b[0]) : (a[1]<=>b[1])}
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['mysticcode','mystic_code','mystic-code','mysticode','mystic','mysticcodes','mystic_codes','mystic-codes','mysticodes','mystics','clothes','clothing'])
      f.push('__**Mystic Code** (Clothing) **Aliases**__')
      n=@aliases.reject{|q| !['Clothes'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['commandcode','command_code','command-code','command','commandcodes','command_codes','command-codes','commands'])
      f.push('__**Command Code Aliases**__')
      n=@aliases.reject{|q| q[0]!='Command'}.map{|q| [q[1],q[2],q[3]]}
      for i in 0...n.length
        untnme=@codes[@codes.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif safe_to_spam?(event) || mode==1
      n=n.reject{|q| q[2].nil?} if mode==1
      unless event.server.nil?
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        if n.length>25 && !safe_to_spam?(event)
          event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
          return nil
        end
        msg='__**Servant Aliases**__'
        for i in 0...n.length
          untnme=@servants[@servants.find_index{|q| q[0]==n[i][1]}][1]
          msg=extend_message(msg,"#{n[i][0]} = #{untnme} [Srv-##{n[i][1]}]#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Skill Aliases**__',event,2)
        n=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Craft Essance Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Craft'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          untnme=@crafts[@crafts.find_index{|q| q[0]==n[i][1]}][1]
          msg=extend_message(msg,"#{n[i][0]} = #{untnme} [CE-##{n[i][1]}]#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Material Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
        mmkk=['Archer','Assassin','Berserker','Caster','Lancer','Rider','Saber']
        for i in 0...mmkk.length
          n.push(["#{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
          n.push(["Blue #{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
          n.push(["Blue Gem of #{mmkk[i]}","Gem of #{mmkk[i]}"])
          n.push(["Magic #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
          n.push(["Red #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
          n.push(["Red Gem of #{mmkk[i]}","Magic Gem of #{mmkk[i]}"])
          n.push(["Secret #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
          n.push(["Yellow #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
          n.push(["Yellow Gem of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
          n.push(["#{mmkk[i]} Cookie","Secret Gem of #{mmkk[i]}"])
          n.push(["Cookie of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
        end
        n.sort! {|a,b| (a[1]<=>b[1]) ? (a[0]<=>b[0]) : (a[1]<=>b[1])}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Mystic Code** (Clothing) **Aliases**__',event,2)
        n=@aliases.reject{|q| !['Clothes'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Command Code Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Command'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          untnme=@codes[@codes.find_index{|q| q[0]==n[i][1]}][1]
          msg=extend_message(msg,"#{n[i][0]} = #{untnme} [Cmd-##{n[i][1]}]#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        event.respond msg
        return nil
      end
      f.push('__**Servant Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        untnme=@servants[@servants.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Srv-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Skill Aliases**__")
      n=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Craft Essance Aliases**__")
      n=@aliases.reject{|q| q[0]!='Craft'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        untnme=@crafts[@crafts.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [CE-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Material Aliases**__")
      n=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
      mmkk=['Archer','Assassin','Berserker','Caster','Lancer','Rider','Saber']
      for i in 0...mmkk.length
        n.push(["#{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
        n.push(["Blue #{mmkk[i]} Gem","Gem of #{mmkk[i]}"])
        n.push(["Blue Gem of #{mmkk[i]}","Gem of #{mmkk[i]}"])
        n.push(["Magic #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
        n.push(["Red #{mmkk[i]} Gem","Magic Gem of #{mmkk[i]}"])
        n.push(["Red Gem of #{mmkk[i]}","Magic Gem of #{mmkk[i]}"])
        n.push(["Secret #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
        n.push(["Yellow #{mmkk[i]} Gem","Secret Gem of #{mmkk[i]}"])
        n.push(["Yellow Gem of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
        n.push(["#{mmkk[i]} Cookie","Secret Gem of #{mmkk[i]}"])
        n.push(["Cookie of #{mmkk[i]}","Secret Gem of #{mmkk[i]}"])
      end
      n=n.reject{|q| q[2].nil?} if mode==1
      n.sort! {|a,b| (a[1]<=>b[1]) == 0 ? (a[0]<=>b[0]) : (a[1]<=>b[1])}
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Mystic Code** (Clothing) **Aliases**__")
      n=@aliases.reject{|q| !['Clothes'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Command Code Aliases**__")
      n=@aliases.reject{|q| q[0]!='Command'}.map{|q| [q[1],q[2],q[3]]}
      for i in 0...n.length
        untnme=@codes[@codes.find_index{|q| q[0]==n[i][1]}][1]
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}]")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}]#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{untnme} [Cmd-##{n[i][1]}] (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    else
      event.respond "The alias system can cover:\n- Servants\n- Skills (Active, Passive, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nPlease either specify a member of one of these categories or use this command in PM."
      return nil
    end
  elsif !unit.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    k=0
    k=event.server.id unless event.server.nil?
    f.push("__**#{unit[1]}**__ [Srv-##{unit[0]}]#{servant_moji(bot,event,unit)}#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(unit[1].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if unit[1].include?('(') || unit[1].include?(')') || unit[1].include?(' ') || unit[1].include?('!') || unit[1].include?('_') || unit[1].include?('?') || unit[1].include?("'") || unit[1].include?('"')
      f.push(unit[0])
    end
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
  elsif !skl.nil?
    skl=skl[0] if skl[0].is_a?(Array)
    n=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{skl[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(skl[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if skl[0].include?('(') || skl[0].include?(')') || skl[0].include?(' ') || skl[0].include?('!') || skl[0].include?('_') || skl[0].include?('?') || skl[0].include?("'") || skl[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==skl[0]
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
  elsif !ce.nil?
    n=@aliases.reject{|q| q[0]!='Craft' || q[2]!=ce[0]}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{ce[1]}**__ [CE-##{ce[0]}]#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(ce[1].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if ce[1].include?('(') || ce[1].include?(')') || ce[1].include?(' ') || ce[1].include?('!') || ce[1].include?('_') || ce[1].include?('?') || ce[1].include?("'") || ce[1].include?('"')
      f.push(ce[0]) if ce[0]>@servants.map{|q| q[0]}.max
    end
    for i in 0...n.length
      if n[i][1]==ce[0]
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
  elsif !mat.nil?
    f.push("__**#{mat}**__ #{find_emote(bot,event,mat,2,true)}#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      if mat[0,7]=='Gem of '
        f.push("#{mat.gsub('Gem of ','')} Gem")
        f.push("Blue #{mat.gsub('Gem of ','')} Gem")
        f.push("Blue #{mat}")
      elsif mat[0,13]=='Magic Gem of '
        f.push("Magic #{mat.gsub('Magic Gem of ','')} Gem")
        f.push("Red #{mat.gsub('Magic Gem of ','')} Gem")
        f.push("Red Gem of #{mat.gsub('Magic Gem of ','')}")
      elsif mat[0,14]=='Secret Gem of '
        f.push("Secret #{mat.gsub('Secret Gem of ','')} Gem")
        f.push("Yellow #{mat.gsub('Secret Gem of ','')} Gem")
        f.push("Yellow Gem of #{mat.gsub('Secret Gem of ','')}")
        f.push("#{mat.gsub('Secret Gem of ','')} Cookie")
        f.push("Cookie of #{mat.gsub('Secret Gem of ','')}")
      end
    end
    n=@aliases.reject{|q| q[0]!='Material' || q[2]!=mat}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    for i in 0...n.length
      if n[i][1]==mat
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
  elsif !cloth.nil?
    n=@aliases.reject{|q| !['Clothes'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{cloth[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(cloth[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if cloth[0].include?('(') || cloth[0].include?(')') || cloth[0].include?(' ') || cloth[0].include?('!') || cloth[0].include?('_') || cloth[0].include?('?') || cloth[0].include?("'") || cloth[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==cloth[0]
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
  elsif !ccode.nil?
    n=@aliases.reject{|q| q[0]!='Craft' || q[2]!=ccode[0]}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{ccode[1]}**__ [Cmd-##{ccode[0]}]#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(ccode[1].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if ccode[1].include?('(') || ccode[1].include?(')') || ccode[1].include?(' ') || ccode[1].include?('!') || ccode[1].include?('_') || ccode[1].include?('?') || ccode[1].include?("'") || ccode[1].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==ccode[0]
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

def add_new_alias(bot,event,newname=nil,unit=nil,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if newname.nil? || unit.nil?
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that item"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665].include?(event.user.id)) && event.channel.id != 502288368777035777
    str='You are not a mod.'
    err=true
  elsif newname.include?('"') || newname.include?("\n")
    str='Full stop.  " is not allowed in an alias.'
    err=true
  elsif !event.server.nil? && event.server.id==363917126978764801
    err="You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra.  Even if that was an alias for FEH instead of FGO."
    str=true
  end
  if err
    event.respond str if str.length>0 && mode==0
    args=event.message.text.downcase.split(' ')
    args.shift
    disp_aliases(bot,event,args) if mode==1
    return nil
  end
  type=['Alias','Alias']
  if find_servant(newname,event,true).length>0
    type[0]='Servant'
  elsif find_skill(newname,event,true).length>0
    type[0]='Skill'
  elsif find_ce(newname,event,true).length>0
    type[0]='CE'
  elsif find_mat(newname,event,true).length>0
    type[0]='Material'
  elsif find_clothes(newname,event,true).length>0
    type[0]='Clothes'
  elsif find_code(newname,event,true).length>0
    type[0]='Command'
  elsif find_servant(newname,event).length>0
    type[0]='Servant*'
  elsif find_skill(newname,event).length>0
    type[0]='Skill*'
  elsif find_ce(newname,event).length>0
    type[0]='CE*'
  elsif find_mat(newname,event).length>0
    type[0]='Material*'
  elsif find_clothes(newname,event).length>0
    type[0]='Clothes*'
  elsif find_code(newname,event).length>0
    type[0]='Command*'
  end
  if find_servant(unit,event,true).length>0
    type[1]='Servant'
  elsif find_skill(unit,event,true).length>0
    type[1]='Skill'
  elsif find_ce(unit,event,true).length>0
    type[1]='CE'
  elsif find_mat(unit,event,true).length>0
    type[1]='Material'
  elsif find_clothes(unit,event,true).length>0
    type[1]='Clothes'
  elsif find_code(unit,event,true).length>0
    type[1]='Command'
  elsif find_servant(unit,event).length>0
    type[1]='Servant*'
  elsif find_skill(unit,event).length>0
    type[1]='Skill*'
  elsif find_ce(unit,event).length>0
    type[1]='CE*'
  elsif find_mat(unit,event).length>0
    type[1]='Material*'
  elsif find_clothes(unit,event).length>0
    type[1]='Clothes*'
  elsif find_code(unit,event).length>0
    type[1]='Command*'
  end
  checkstr=normalize(newname,true)
  if type.reject{|q| q != 'Alias'}.length<=0
    type[0]='Alias' if type[0].include?('*')
    type[1]='Alias' if type[1].include?('*') && type[0]!='Alias'
  end
  if type.reject{|q| q == 'Alias'}.length<=0
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes\n\nNeither #{newname} nor #{unit} fall into any of these categories."
    err=true
  elsif type.reject{|q| q != 'Alias'}.length<=0
    event.respond "#{newname} is a #{type[0].downcase}\n#{unit} is a #{type[1].downcase}"
    err=true
  end
  if err
    str=["#{str}\nPlease try again.","#{str}\nTrying to list aliases instead."][mode]
    event.respond str if str.length>0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_unit_aliases(event,args,bot) if mode==1
    return nil
  end
  if type[1]=='Alias' && type[0]!='Alias'
    f="#{newname}"
    newname="#{unit}"
    unit="#{f}"
    type=type.reverse.map{|q| q.gsub('*','')}
  else
    type=type.map{|q| q.gsub('*','')}
  end
  if type[1]=='Servant'
    unit=find_servant(unit,event)
    dispstr=['Servant',"#{unit[1]} [Srv-##{unit[0]}]",'Servant',unit[0]]
  elsif type[1]=='Skill'
    unit=find_skill(unit,event)
    if unit[0].is_a?(Array) && unit.length<=1
      dispstr=[unit[0][2],"#{unit[0][0]} #{unit[0][1]}",'Skill',"#{unit[0][0]} #{unit[0][1]}"]
    elsif unit[0].is_a?(Array)
      dispstr=[unit[0][2],"#{unit[0][0]}",'Skill',"#{unit[0][0]}"]
    else
      dispstr=[unit[2],"#{unit[0]} #{unit[1]}",'Skill',"#{unit[0]} #{unit[1]}"]
    end
    dispstr[2]='Active Skill' if dispstr[0]=='Skill'
    dispstr[2]='Passive Skill' if dispstr[0]=='Passive'
    dispstr[2]='Clothing Skill' if dispstr[0]=='Clothes'
    dispstr[0]='Active' if dispstr[0]=='Skill'
    dispstr[0]='ClothingSkill' if dispstr[0]=='Clothes'
  elsif type[1]=='CE'
    unit=find_ce(unit,event)
    dispstr=['Craft',"#{unit[1]} [CE-##{unit[0]}]",'Craft Essance',unit[0]]
  elsif type[1]=='Material'
    unit=find_mat(unit,event)
    dispstr=['Material',"#{unit}",'Material',unit]
  elsif type[1]=='Clothes'
    unit=find_clothes(unit,event)
    dispstr=['Clothes',"#{unit[0]}",'Mytic Code',"#{unit[0]}"]
  elsif type[1]=='Command'
    unit=find_code(unit,event,true)
    dispstr=['Command',"#{unit[1]} [Cmd-##{unit[0]}]",'Command Code',unit[0]]
  end
  logchn=502288368777035777
  logchn=431862993194582036 if @shardizard==4
  newname=newname.gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  checkstr=normalize(newname,true)
  k=event.message.emoji
  for i in 0...k.length
    checkstr=checkstr.gsub("<:#{k[i].name}:#{k[i].id}>",k[i].name)
  end
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases.#{"\nhttps://cdn.discordapp.com/attachments/344355510281043969/514973942218227722/Storylineatroriaisagirlposing_c4361e8dc51f0451389bd016c9796bab.jpg" if unt[0]==99}"
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** >Censored< for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname,true)
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
  double=false
  for i in 0...@aliases.length
    if @aliases[i][3].nil?
    elsif @aliases[i][1].downcase==newname.downcase && @aliases[i][2]==dispstr[3]
      if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?
        @aliases[i][3]=nil
        @aliases[i][4]=nil
        @aliases[i].compact!
        bot.channel(chn).send_message("The alias **#{newname}** for the #{dispstr[2].downcase} *#{dispstr[1]}* exists in a server already.  Making it global now.")
        event.respond "The alias #{newname} for #{dispstr[1]} exists in a server already.  Making it global now.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]} - gone global.")
        double=true
      else
        @aliases[i][3].push(srv)
        bot.channel(chn).send_message("The alias **#{newname}** for the #{dispstr[2].downcase} *#{dispstr[1]}* exists in another server already.  Adding this server to those that can use it.")
        event.respond "The alias #{newname} for #{dispstr[1]} exists in another server already.  Adding this server to those that can use it.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        metadata_load()
        bot.user(167657750971547648).pm("The alias **#{@aliases[i][0]}** for the #{type[1]} **#{dispstr[1]}** is used in quite a few servers.  It might be time to make this global") if @aliases[i][3].length >= @server_data[0].inject(0){|sum,x| sum + x } / 20 && @aliases[i][3].length>=5 && @aliases[i][4].nil?
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]} - gained a new server that supports it.")
        double=true
      end
    end
  end
  unless double
    @aliases.push([dispstr[0],newname,dispstr[3],m].compact)
    @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
    bot.channel(chn).send_message("**#{newname}** has been#{" globally" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?} added to the aliases for the #{dispstr[2].downcase} *#{dispstr[1]}*.\nPlease test to be sure that the alias stuck.")
    event.respond "#{newname} has been added to #{dispstr[1]}'s aliases#{" globally" if event.user.id==167657750971547648 && !modifier.nil?}." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
    bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}#{" - global alias" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?}")
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
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    bot.channel(logchn).send_message('Alias list saved.')
    open('C:/Users/Mini-Matt/Desktop/devkit/FGONames2.txt', 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
end

def show_next(bot,event,args=nil,ignoreinputs=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  msg=event.message.text.downcase.split(' ')
  jp=(msg.include?('jp') || msg.include?('japan') || msg.include?('japanese'))
  mat_block=''
  mat_block=', ' if msg.include?('colorblind') || msg.include?('textmats')
  t=Time.now
  timeshift=-5
  timeshift-=1 unless t.dst?
  t_na=t-60*60*timeshift
  timeshift=-14
  timeshift-=1 unless t.dst?
  t_jp=t-60*60*timeshift
  sftday=-2
  for i in 0...args.length
    stfday=-3 if ['today','now'].include?(args[i]) && sftday==-2
    sftday=-1 if ['tomorrow','tommorrow','tomorow','tommorow','next'].include?(args[i]) && sftday==-2
    sftday=0 if ['sunday','sundae','sun','su','sonday','sondae','son','u'].include?(args[i]) && sftday==-2
    sftday=1 if ['mo','monday','mondae','mon','m'].include?(args[i]) && sftday==-2
    sftday=2 if ['tu','tuesday','tuesdae','tues','tue','t'].include?(args[i]) && sftday==-2
    sftday=3 if ['we','wednesday','wednesdae','wednes','wed','w'].include?(args[i]) && sftday==-2
    sftday=4 if ['th','thursday','thursdae','thurs','thu','thur','h','r'].include?(args[i]) && sftday==-2
    sftday=5 if ['fr','friday','fridae','fri','fryday','frydae','fry','f'].include?(args[i]) && sftday==-2
    sftday=6 if ['sa','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[i]) && sftday==-2
  end
  sftday=ignoreinputs*1 if ignoreinputs.is_a?(Numeric)
  training=['<:class_saber_gold:523838273479507989>Saber',
            '<:class_archer_gold:523838461195714576>Archer',
            '<:class_lancer_gold:523838511485419522>Lancer',
            '<:class_berserker_gold:523838648370724897>Berserker',
            '<:class_rider_gold:523838542577664012>Rider',
            '<:class_caster_gold:523838570893672473>Caster',
            '<:class_assassin_gold:523838617693716480>Assassin']
  ember=['<:class_unknown_gold:523838979825467392>Random',
         '<:class_lancer_gold:523838511485419522>Lancer + <:class_assassin_gold:523838617693716480>Assassin',
         '<:class_saber_gold:523838273479507989>Saber + <:class_rider_gold:523838542577664012>Rider',
         '<:class_archer_gold:523838461195714576>Archer + <:class_caster_gold:523838570893672473>Caster',
         '<:class_lancer_gold:523838511485419522>Lancer + <:class_assassin_gold:523838617693716480>Assassin',
         '<:class_saber_gold:523838273479507989>Saber + <:class_rider_gold:523838542577664012>Rider',
         '<:class_archer_gold:523838461195714576>Archer + <:class_caster_gold:523838570893672473>Caster']
  matz=["Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Eternal Gear, Shell of Reminiscence, Spirit Root, Saber Piece, Saber Monument, Gem of Saber, Magic Gem of Saber, Secret Gem of Saber",
        "Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Meteor Horseshoe, Tearstone of Blood, Archer Piece, Archer Monument, Gem of Archer, Magic Gem of Archer, Secret Gem of Archer",
        "Proof of Hero, Evil Bone, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Homunculus Baby, Warhorse's Young Horn, Lancer Piece, Lancer Monument, Gem of Lancer, Magic Gem of Lancer, Secret Gem of Lancer",
        "Proof of Hero, Void's Dust, Octuplet Crystals, Claw of Chaos, Berserker Piece, Berserker Monument, Gem of Berserker, Magic Gem of Berserker, Secret Gem of Berserker",
        "Dragon Fang, Void's Dust, Meteor Horseshoe, Dragon's Reverse Scale, Rider Piece, Rider Monument, Gem of Rider, Magic Gem of Rider, Secret Gem of Rider",
        "Serpent Jewel, Void's Dust, Forbidden Page, Heart of the Foreign God, Caster Piece, Caster Monument, Gem of Caster, Magic Gem of Caster, Secret Gem of Caster",
        "Dragon Fang, Void's Dust, Seed of Yggdrasil, Ghost Lantern, Eternal Gear, Black Beast Grease, Assassin Piece, Assassin Monument, Gem of Assassin, Magic Gem of Assassin, Secret Gem of Assassin"]
  if sftday>-2 && (!ignoreinputs || ignoreinputs.is_a?(Numeric))
    if sftday<0
      t=t_na+24*60*60
      t=t_jp+24*60*60 if jp
      t2=Time.new(2017,6,25)-6*60*60
      t2=Time.new(2015,7,29)-9*60*60 if jp
      t2=t-t2
      date=(((t2.to_i/60)/60)/24)
      str2='Tomorrow'
      str3=" (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
      str5="~~This is displaying North America's *tomorrow*.  To show Japan's, include the word \"JP\" alongside the word \"tomorrow\".~~" unless jp || disp_date(t_na)==disp_date(t_jp)
    else
      t=t_na
      tmw=(sftday==t.wday+1)
      tmw=true if sftday==0 && t.wday==6
      t+=7*24*60*60 if sftday<t.wday
      t+=(sftday-t.wday)*24*60*60
      t2=Time.new(2017,6,25)-6*60*60
      t2=Time.new(2015,7,29)-9*60*60 if jp
      t2=t-t2
      date=(((t2.to_i/60)/60)/24)
      str2="Next #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}"
      str3="#{' (Tomorrow)' if tmw}"
    end
    t2=Time.new(2017,6,25)-6*60*60
    t3=t-t2
    t2=Time.new(2015,7,29)-9*60*60
    t4=t-t2
    datex=[(((t3.to_i/60)/60)/24),(((t4.to_i/60)/60)/24)]
    str4="#{str2[0,1].downcase}#{str2[1,str2.length-1]}"
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n~~*Date assuming mat reset is at midnight:* #{disp_date(t_na)}~~" unless disp_date(t_na)==disp_date(t_jp)
    str="#{str}\n~~*Days since game release*: #{longFormattedNumber(date)}~~"
    str="#{str}\n*Days since game release, come #{str4}:* #{longFormattedNumber(datex[0])}"
    str="#{str}\n\n__**Japan**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n~~*Date assuming mat reset is at midnight:* #{disp_date(t_jp)}~~" unless disp_date(t_na)==disp_date(t_jp)
    str="#{str}\n~~*Days since game release:* #{longFormattedNumber(date)}~~"
    str="#{str}\n*Days since game release, come #{str4}:* #{longFormattedNumber(datex[1])}"
    str="#{str}\n\n__**Both**__"
    str="#{str}\n~~*Date assuming mat reset is at midnight:* #{disp_date(t_na)}~~" if disp_date(t_na)==disp_date(t_jp)
    str="#{str}\n*#{str2}'s date:* #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year}#{str3}"
    str="#{str}\n*#{str2}'s Training Ground:* #{training[t.wday]}"
    str="#{str}\n*Mats available #{str4}:* #{matz[t.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str="#{str}\n*#{str2}'s Ember Gathering:* #{ember[t.wday]}"
    str="#{str}\n\n#{str5}" unless str5.nil?
  elsif disp_date(t_na)==disp_date(t_jp) && safe_to_spam?(event,nil,1)
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Days since game release*: #{longFormattedNumber(date)}"
    str="#{str}\n\n__**Japan**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str="#{str}\n\n__**Both**__"
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str="#{str}\n*Training Ground:* #{training[t_na.wday]}"
    str="#{str}\n*Available Mats:* #{matz[t_na.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str="#{str}\n*Ember Gathering:* #{ember[t_na.wday]}"
    str2="__(tomorrow)__"
    m=(t_na.wday+1)%7
    str2="#{str2}\n*Training Ground:* #{training[m]}"
    str2="#{str2}\n*Available Mats:* #{matz[m].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str2="#{str2}\n*Ember Gathering:* #{ember[m]}"
    str=extend_message(str,str2,event,2)
  elsif safe_to_spam?(event)
    str="__**North America** (today)__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str="#{str}\n*Training Ground:* #{training[t_na.wday]}"
    str="#{str}\n*Available Mats:* #{matz[t_na.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str="#{str}\n*Ember Gathering:* #{ember[t_na.wday]}"
    str2="__**Japan**__"
    str2="#{str2}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str2="#{str2}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str2="#{str2}\n*Date assuming mat reset is at midnight:* #{disp_date(t_jp)}"
    str2="#{str2}\n*Days since game release:* #{longFormattedNumber(date)}"
    str2="#{str2}\n*Training Ground:* #{training[t_jp.wday]}"
    str2="#{str2}\n*Available Mats:* #{matz[t_jp.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str2="#{str2}\n*Ember Gathering:* #{ember[t_jp.wday]}"
    str2="#{str2}\n~~the above data also counts as tomorrow's data in NA~~"
    str=extend_message(str,str2,event,2)
    str2="__**Japan** (tomorrow)__"
    m=(t_jp.wday+1)%7
    str2="#{str2}\n*Training Ground:* #{training[m]}"
    str2="#{str2}\n*Available Mats:* #{matz[m].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str2="#{str2}\n*Ember Gathering:* #{ember[m]}"
    str=extend_message(str,str2,event,2)
  elsif jp
    str="__**Japan**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_jp)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str="#{str}\n\n*Training Ground:* #{training[t_jp.wday]}"
    str="#{str}\n*Available Mats:* #{matz[t_jp.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str="#{str}\n*Ember Gathering:* #{ember[t_jp.wday]}"
  else
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str="#{str}\n\n*Training Ground:* #{training[t_na.wday]}"
    str="#{str}\n*Available Mats:* #{matz[t_na.wday].split(', ').map{|q| find_emote(bot,event,q,2)}.join(mat_block)}"
    str="#{str}\n*Ember Gathering:* #{ember[t_na.wday]}"
    str="#{str}\n\n~~You can include the word \"JP\" in your message to show JP data.~~"
  end
  event.respond str
end

def show_next_2(bot,event)
  msg=event.message.text.downcase.split(' ')
  jp=(msg.include?('jp') || msg.include?('japan') || msg.include?('japanese'))
  mat_block=''
  mat_block=', ' if msg.include?('colorblind') || msg.include?('textmats')
  tx=-1
  for i in 0...msg.length
    unless tx>0
      tx=1 if ['training','ground','grounds','train','traininggrounds','trainingground','trainingrounds','traininground','training-grounds','training-ground','training_grounds','training_ground'].include?(msg[i])
      tx=2 if ['ember','embers','gathering','gather','embergathering','embergather','ember_gathering','ember_gather','ember-gathering','ember-gather'].include?(msg[i])
      tx=3 if ['mats','mat','materials','material'].include?(msg[i])
    end
  end
  if tx<0 && !safe_to_spam?(event,nil,1)
    event.respond "Too much data is trying to be displayed.  Please try again with one of the following modifiers, or try again in PM.\n- Training / Ground(s)\n- Ember(s) / Gather(ing)\n- Mat(s) / Material(s) ~~this one only works fully in PM.~~"
    return nil
  end
  t=Time.now
  timeshift=-5
  timeshift-=1 unless t.dst?
  t_na=t-60*60*timeshift
  timeshift=-14
  timeshift-=1 unless t.dst?
  t_jp=t-60*60*timeshift
  training=['<:class_saber_gold:523838273479507989>Saber',
            '<:class_archer_gold:523838461195714576>Archer',
            '<:class_lancer_gold:523838511485419522>Lancer',
            '<:class_berserker_gold:523838648370724897>Berserker',
            '<:class_rider_gold:523838542577664012>Rider',
            '<:class_caster_gold:523838570893672473>Caster',
            '<:class_assassin_gold:523838617693716480>Assassin']
  ember=['<:class_unknown_gold:523838979825467392>Random Ember Gather',
         '<:class_lancer_gold:523838511485419522>Lancer + <:class_assassin_gold:523838617693716480>Assassin',
         '<:class_saber_gold:523838273479507989>Saber + <:class_rider_gold:523838542577664012>Rider',
         '<:class_archer_gold:523838461195714576>Archer + <:class_caster_gold:523838570893672473>Caster',
         '<:class_lancer_gold:523838511485419522>Lancer + <:class_assassin_gold:523838617693716480>Assassin',
         '<:class_saber_gold:523838273479507989>Saber + <:class_rider_gold:523838542577664012>Rider',
         '<:class_archer_gold:523838461195714576>Archer + <:class_caster_gold:523838570893672473>Caster']
  matz=["Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Eternal Gear, Shell of Reminiscence, Spirit Root, Saber Piece, Saber Monument, Gem of Saber, Magic Gem of Saber, Secret Gem of Saber",
        "Proof of Hero, Evil Bone, Dragon Fang, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Meteor Horseshoe, Tearstone of Blood, Archer Piece, Archer Monument, Gem of Archer, Magic Gem of Archer, Secret Gem of Archer",
        "Proof of Hero, Evil Bone, Void's Dust, Seed of Yggdrasil, Phoenix Feather, Homunculus Baby, Warhorse's Young Horn, Lancer Piece, Lancer Monument, Gem of Lancer, Magic Gem of Lancer, Secret Gem of Lancer",
        "Proof of Hero, Void's Dust, Octuplet Crystals, Claw of Chaos, Berserker Piece, Berserker Monument, Gem of Berserker, Magic Gem of Berserker, Secret Gem of Berserker",
        "Dragon Fang, Void's Dust, Meteor Horseshoe, Dragon's Reverse Scale, Rider Piece, Rider Monument, Gem of Rider, Magic Gem of Rider, Secret Gem of Rider",
        "Serpent Jewel, Void's Dust, Forbidden Page, Heart of the Foreign God, Caster Piece, Caster Monument, Gem of Caster, Magic Gem of Caster, Secret Gem of Caster",
        "Dragon Fang, Void's Dust, Seed of Yggdrasil, Ghost Lantern, Eternal Gear, Black Beast Grease, Assassin Piece, Assassin Monument, Gem of Assassin, Magic Gem of Assassin, Secret Gem of Assassin"]
  jp_shift=false
  if disp_date(t_na)==disp_date(t_jp) && safe_to_spam?(event,nil,1)
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Days since game release*: #{longFormattedNumber(date)}"
    str="#{str}\n\n__**Japan**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str="#{str}\n\n__**Both**__"
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str3=''
    t_tot=t_na
  elsif safe_to_spam?(event)
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str2="__**Japan**__"
    str2="#{str2}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str2="#{str2}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str2="#{str2}\n*Date assuming mat reset is at midnight:* #{disp_date(t_jp)}"
    str2="#{str2}\n*Days since game release:* #{longFormattedNumber(date)}"
    str=extend_message(str,str2,event,2)
    str3=''
    t_tot=t_na
    jp_shift=true
  elsif jp
    str="__**Japan**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_jp.hour} hours, " if t_jp.hour>0}#{"#{'0' if t_jp.min<10}#{t_jp.min} minutes, " if t_jp.hour>0 || t_jp.min>0}#{'0' if t_jp.sec<10}#{t.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_jp.hour} hours, " if 23-t_jp.hour>0}#{"#{'0' if 59-t_jp.min<10}#{59-t_jp.min} minutes, " if 23-t_jp.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2015,7,29)-9*60*60
    t2=t_jp-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_jp)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str3=''
    t_tot=t_jp
  else
    str="__**North America**__"
    str="#{str}\n*Time elapsed since today's mat reset:* #{"#{t_na.hour} hours, " if t_na.hour>0}#{"#{'0' if t_na.min<10}#{t.min} minutes, " if t_na.hour>0 || t_na.min>0}#{'0' if t_na.sec<10}#{t_na.sec} seconds"
    str="#{str}\n*Time until tomorrow's mat reset:* #{"#{23-t_na.hour} hours, " if 23-t_na.hour>0}#{"#{'0' if 59-t_na.min<10}#{59-t.min} minutes, " if 23-t_na.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
    t2=Time.new(2017,6,25)-6*60*60
    t2=t_na-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n*Date assuming mat reset is at midnight:* #{disp_date(t_na)}"
    str="#{str}\n*Days since game release:* #{longFormattedNumber(date)}"
    str3="~~You can include the word \"JP\" in your message to show JP data.~~"
    t_tot=t_na
  end
  if [-1,1].include?(tx)
    training=training.rotate(t_tot.wday)
    t_d=t_tot+24*60*60
    str2="__**Training Grounds**__"
    if jp_shift
      str2="#{str2}\n*#{training[0]}* - #{disp_date(t_tot,1)} - Today in NA - ~~Yesterday in JP~~\n*#{training[1]}* - #{disp_date(t_d,1)} - Tomorrow in NA - Today in JP"
    else
      str2="#{str2}\n*#{training[0]}* - Today\n*#{training[1]}* - Tomorrow (#{disp_date(t_d,1)})"
    end
    for i in 2...7
      t_d=t_tot+i*24*60*60
      if jp_shift
        if i==2
          str2="#{str2}\n*#{training[i]}* - #{disp_date(t_d,1)} - #{i} days from now in NA - Tomorrow in JP"
        else
          str2="#{str2}\n*#{training[i]}* - #{disp_date(t_d,1)} - #{i} days from now in NA - #{i-1} days from now in JP"
        end
      else
        str2="#{str2}\n*#{training[i]}* - #{i} days from now (#{disp_date(t_d,1)})"
      end
    end
    t_d=t_tot+7*24*60*60
    if jp_shift
      str2="#{str2}\n*#{training[0]}* - #{disp_date(t_d,1)} - 7 days from now in NA - 6 days from now in JP"
      t_d=t_tot+8*24*60*60
      str2="#{str2}\n*#{training[1]}* - #{disp_date(t_d,1)} - ~~8 days from now in NA~~ - 7 days from now in JP"
    else
      str2="#{str2}\n*#{training[0]}* - 7 days from now (#{disp_date(t_d,1)})"
    end
    str=extend_message(str,str2,event,2)
  end
  if [-1,2].include?(tx)
    t_d=t_tot+24*60*60
    ember=ember.rotate(t_tot.wday)
    str2="__**Ember Gathering**__"
    if jp_shift
      ember.push(ember[0])
      ember.push(ember[1]) if ember[1]=='<:class_unknown_gold:523838979825467392>Random Ember Gather'
      str2="#{str2}\n*#{ember[0]}* - #{disp_date(t_tot,1)} - Today in NA - ~~Yesterday in JP~~\n*#{ember[1]}* - #{disp_date(t_d,1)} - Tomorrow in NA - Today in JP"
      for i in 2...ember.length
        t_d=t_tot+i*24*60*60
        if ember[i]==ember[1]
          str2="#{str2}\n*#{ember[i]}* - #{disp_date(t_d,1)} - ~~#{i} days from now in NA~~ - #{i-1} days from now in JP"
        elsif ember[i]==ember[2] && i>2
        elsif ember[i]==ember[3] && i>3
        elsif ember[i]==ember[4] && i>4
        elsif ember[i]==ember[5] && i>5
        elsif i==2
          str2="#{str2}\n*#{ember[i]}* - #{disp_date(t_d,1)} - #{i} days from now in NA - Tomorrow in JP"
        else
          str2="#{str2}\n*#{ember[i]}* - #{disp_date(t_d,1)} - #{i} days from now in NA - #{i-1} days from now in JP"
        end
      end
    else
      for i in 0...ember.length
        ember[i]=[ember[i],i]
      end
      ember.push([ember[0][0],7])
      ember.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1]<=>b[1]) : (a[0]<=>b[0])}
      for i in 1...ember.length
        ember[i]=nil if !ember[i-1].nil? && ember[i][0]==ember[i-1][0] && ember[i-1][1]>0
      end
      ember.compact!
      ember.sort!{|a,b| (a[1]<=>b[1])}
      for i in 0...ember.length
        if ember[i][1]==0
          str2="#{str2}\n*#{ember[i][0]}* - Today"
        elsif ember[i][1]==1
          t_d=t_tot+24*60*60
          str2="#{str2}\n*#{ember[i][0]}* - Tomorrow (#{disp_date(t_d,1)})"
        else
          t_d=t_tot+ember[i][1]*24*60*60
          str2="#{str2}\n*#{ember[i][0]}* - #{ember[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
    end
    str=extend_message(str,str2,event,2)
  end
  if [-1,3].include?(tx)
    matz=matz.rotate(t_tot.wday)
    if !safe_to_spam?(event)
      if tx<0
        str=extend_message(str,'Materials available in Training Grounds makes this list so long I would rather you tried this command in PM.',event,2)
      else
        str2="__**Materials** found in the Training Grounds__\nI will not display every mat available in the Training Grounds as that is a lot of data.\nIf you wish to see the whole list, please try the command again in PM.\nOtherwise, here are today's and tomorrow's mats."
        str4=['**Today**','**Tomorrow**']
        str4=['**North America** (today)','**Japan** (today) - also doubles as NA tomorrow'] if jp_shift
        str2="#{str2}\n\n__#{str4[0]}__\n#{matz[0].split(', ').sort.map{|q| "#{find_emote(bot,event,q,2,true)}#{q}"}.join('  -  ')}"
        str=extend_message(str,str2,event,2)
        str2="__#{str4[1]}__\n#{matz[1].split(', ').sort.map{|q| "#{find_emote(bot,event,q,2,true)}#{q}"}.join('  -  ')}"
        str=extend_message(str,str2,event,2)
        if jp_shift
          str2="__**Japan** (tomorrow)__\n#{matz[2].split(', ').sort.map{|q| "#{find_emote(bot,event,q,2,true)}#{q}"}.join('  -  ')}"
          str=extend_message(str,str2,event,2)
        end
      end
    elsif jp_shift
      mmzz=[]
      for i in 0...matz.length
        m=matz[i].split(', ')
        for i2 in 0...m.length
          mmzz.push([m[i2],[i]])
          mmzz.push([m[i2],[7]]) if i==0
        end
      end
      mmzz.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1][0]<=>b[1][0]) : (a[0]<=>b[0])}
      mmzz.reverse!
      for i in 0...mmzz.length-1
        if mmzz[i][0]==mmzz[i+1][0]
          mmzz[i+1][1][1]=mmzz[i][1][0]*1 unless mmzz[i+1][1][0]>0
          mmzz[i]=nil
        end
      end
      mmzz.compact!
      mmzz.reverse!
      matz=matz.rotate(1)
      mmzz2=[]
      for i in 0...matz.length
        m=matz[i].split(', ')
        for i2 in 0...m.length
          mmzz2.push([m[i2],[i]])
          mmzz2.push([m[i2],[7]]) if i==0
        end
      end
      mmzz2.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1][0]<=>b[1][0]) : (a[0]<=>b[0])}
      mmzz2.reverse!
      for i in 0...mmzz2.length-1
        if mmzz2[i][0]==mmzz2[i+1][0]
          mmzz2[i+1][1][1]=mmzz2[i][1][0]*1 unless mmzz2[i+1][1][0]>0
          mmzz2[i]=nil
        end
      end
      mmzz2.compact!
      mmzz2.reverse!
      for i in 0...mmzz.length
        mmzz[i][2]=mmzz2[i][1].map{|q| q}
      end
      str2="__**Materials** found in the Training Grounds__"
      str=extend_message(str,str2,event,2)
      strpost=false
      for i in 0...mmzz.length
        str2="#{find_emote(bot,event,mmzz[i][0],2,true)}*#{mmzz[i][0]}* -"
        if mmzz[i][1][0]==0 && mmzz[i][2][0]==0 # today in NA and JP
          str2="#{str2} **Today in both NA and JP**"
          if mmzz[i][1][1]==mmzz[i][2][1]
            if mmzz[i][1][1].nil? || mmzz[i][1][1]<=0
            elsif mmzz[i][1][1]==1
              t_d=t_tot+1*24*60*60
              t_d2=t_tot+2*24*60*60
              str2="#{str2} - Next available tomorrow (#{disp_date(t_d,2)} in NA, #{disp_date(t_d2,2)} in JP)"
            else
              t_d=t_tot+mmzz[i][1][1]*24*60*60
              t_d2=t_tot+(mmzz[i][1][1]+1)*24*60*60
              str2="#{str2} - Next available #{mmzz[i][1][1]} days from now (#{disp_date(t_d,2)} in NA, #{disp_date(t_d2,2)} in JP)"
            end
          else
            unless mmzz[i][1][1].nil? || mmzz[i][1][1]<=0
              t_d=t_tot+mmzz[i][1][1]*24*60*60
              if mmzz[i][1][1]==1
                str2="#{str2} - Next available tomorrow (#{disp_date(t_d,2)}) in NA"
              else
                str2="#{str2} - Next available #{mmzz[i][1][1]} days from now (#{disp_date(t_d,2)}) in NA"
              end
            end
            unless mmzz[i][2][1].nil? || mmzz[i][2][1]<=0
              t_d=t_tot+(1+mmzz[i][2][1])*24*60*60
              if mmzz[i][2][1]==1
                str2="#{str2} - Next available tomorrow (#{disp_date(t_d,2)}) in JP"
              else
                str2="#{str2} - Next available #{mmzz[i][2][1]} days from now (#{disp_date(t_d,2)}) in JP"
              end
            end
          end
        elsif mmzz[i][1][0]==0 # today in NA but not JP
          if mmzz[i][1][1]==mmzz[i][2][0]+1
            t_d=t_tot+mmzz[i][1][1]*24*60*60
            str2="#{str2} #{disp_date(t_tot,1)} - **Today in NA** - ~~Yesterday in JP~~ - Next available #{disp_date(t_d,2)} (#{mmzz[i][1][1]} days left in NA, #{mmzz[i][2][0]} days left in JP)"
          else
            str2="#{str2} #{disp_date(t_tot,1)} - **Today in NA**"
            unless mmzz[i][1][1].nil? || mmzz[i][1][1]<=0
              t_d=t_tot+mmzz[i][1][1]*24*60*60
              str2="#{str2}, next available #{mmzz[i][1][1]} days from now (#{disp_date(t_d,2)})"
            end
            str2="#{str2} - ~~Yesterday in JP~~, next available"
            t_d=t_tot+(1+mmzz[i][2][0])*24*60*60
            if mmzz[i][2][0]==1
              str2="#{str2} tomorrow (#{disp_date(t_d,2)})"
            else
              str2="#{str2} #{mmzz[i][2][0]} days from now (#{disp_date(t_d,2)})"
            end
          end
        elsif mmzz[i][2][0]==0 # today in JP but not NA
          t_d=t_tot+1*24*60*60
          str2="#{str2} #{disp_date(t_tot,1)} - Tomorrow in NA - **Today in JP**"
          t_d=t_tot+(1+mmzz[i][2][1])*24*60*60
          if mmzz[i][2][1]==1
            str2="#{str2}, next available tomorrow (#{disp_date(t_d,2)})"
          else
            str2="#{str2}, next available #{mmzz[i][2][1]} days from now (#{disp_date(t_d,2)})"
          end
        else # today in neither JP nor NA
          t_d=t_tot+mmzz[i][1][0]*24*60*60
          str2="#{str2} #{disp_date(t_d,1)} -"
          if mmzz[i][1][0]==1
            str2="#{str2} Tomorrow in NA -"
          else
            str2="#{str2} #{mmzz[i][1][0]} days from now in NA -"
          end
          if mmzz[i][2][0]==1
            str2="#{str2} Tomorrow in JP"
          else
            str2="#{str2} #{mmzz[i][2][0]} days from now in JP"
          end
        end
        str=extend_message(str,str2,event)
      end
    else
      mmzz=[]
      for i in 0...matz.length
        m=matz[i].split(', ')
        for i2 in 0...m.length
          mmzz.push([m[i2],i])
          mmzz.push([m[i2],7]) if i==0
        end
      end
      mmzz.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1]<=>b[1]) : (a[0]<=>b[0])}
      mmzz.reverse!
      for i in 0...mmzz.length-1
        if mmzz[i][0]==mmzz[i+1][0]
          mmzz[i+1][2]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
          mmzz[i]=nil
        end
      end
      mmzz.compact!
      mmzz.reverse!
      str2="__**Materials** found in the Training Grounds__"
      str=extend_message(str,str2,event,2)
      strpost=false
      for i in 0...mmzz.length
        str2="#{find_emote(bot,event,mmzz[i][0],2,true)}*#{mmzz[i][0]}* -"
        if mmzz[i][1]==0
          str2="#{str2} **Today**#{' - Next available' unless mmzz[i][2].nil? || mmzz[i][2]<=0}"
          if mmzz[i][2].nil? || mmzz[i][2]<=0
          else
            t_d=t_tot+mmzz[i][2]*24*60*60
            if mmzz[i][2]==1
              str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
            else
              str2="#{str2} #{mmzz[i][2]} days from now (#{disp_date(t_d,1)})"
            end
          end
        else
          t_d=t_tot+mmzz[i][1]*24*60*60
          if mmzz[i][1]==1
            str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
          end
        end
        str=extend_message(str,str2,event)
      end
    end
  end
  str=extend_message(str,str3,event,2)
  event.respond str
end

def find_in_servants(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  clzz=[]
  rarity=[]
  curves=[]
  attributes=[]
  traits=[]
  nps=[]
  targets=[]
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
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>=0 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6
    rarity.push(5) if ['ssr','supersuperrare','supersuperare','super-super-rare','super-super_rare','super_super-rare','super_super_rare','super-superare','super_superare'].include?(args[i])
    rarity.push(4) if ['sr','superrare','super-rare','super_rare','superare'].include?(args[i])
    rarity.push(3) if ['r','rare'].include?(args[i])
    rarity.push(2) if ['uc','uncommon','uncomon','un-common','un-comon','un_common','un_comon'].include?(args[i])
    rarity.push(1) if ['c','common','comon'].include?(args[i])
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
    traits.push('Divine') if ['divine','devine','divinity','devinity','godly','god','divines','devines','godlies','godlys','gods'].include?(args[i])
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
    nps.push('Quick') if ['quick','q'].include?(args[i])
    nps.push('Arts') if ['arts','a'].include?(args[i])
    nps.push('Buster') if ['buster','b'].include?(args[i])
    targets.push('Self') if ['self'].include?(args[i])
    targets.push('All Enemies') if ['enemies','allenemies','all_enemies','all-enemies','aoe','areaofeffect','area_of_effect','area_of-effect','area-of_effect','area-of-effect'].include?(args[i])
    targets.push('Enemy') if ['enemy','singleenemy','single_enemy','single-enemy','singlenemy','oneenemy','one_enemy','one-enemy','onenemy','st','singletarget','single-target','single_target','single'].include?(args[i])
    targets.push('All Allies') if ['allies','allallies','all_allies','all-allies'].include?(args[i])
    targets.push('Ally') if ['ally','singleally','single_ally','single-ally','oneally','one_ally','one-ally'].include?(args[i])
    avail.push('Event') if ['event','event','welfare','welfares'].include?(args[i])
    avail.push('Limited') if ['limited','limit','limits','seasonal','seasonals'].include?(args[i])
    avail.push('NonLimited') if ['nonlimited','nonlimit','notlimits','notlimited','notlimit','notlimits','nolimits','limitless','non'].include?(args[i])
    avail.push('Starter') if ['starter','starters','start','starting'].include?(args[i])
    avail.push('StoryLocked') if ['story','stories','storylocked','storylock','storylocks','locked','lock','locks'].include?(args[i])
    avail.push('StoryPromo') if ['storypromo','storypromos','storypromotion','promotion','promotions','storypromotions'].include?(args[i])
    avail.push('Unavailable') if ['unavailable','enemy-only','enemyonly'].include?(args[i])
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
  nps.uniq!
  targets.uniq!
  avail.uniq!
  align1.uniq!
  align2.uniq!
  align.uniq!
  char=@servants.map{|q| q}.uniq
  search=[]
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2])}.uniq
    for i in 0...clzz.length
      moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{clzz[i].downcase.gsub(' ','')}_gold"}
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Classes*: #{clzz.join(', ')}")
  end
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[3])}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}<:fgo_icon_rarity:523858991571533825>"}.join(', ')}")
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
      textra="#{textra}\n\nTraits searching defaults to searching for servants with all listed traits.\nTo search for servants with any of the listed traits, perform the search again with the word \"any\" in your message." if traits.length>1
      for i in 0...traits.length
        char=char.reject{|q| !q[13].include?(traits[i])}.uniq
      end
    end
  end
  if nps.length>0
    char=char.reject{|q| !nps.map{|q| q[0]}.include?(q[17][6,1])}.uniq
    for i in 0...nps.length
      nps[i]='<:Quick_y:526556106986618880>Quick' if nps[i]=='Quick'
      nps[i]='<:Arts_y:526556105489252352>Arts' if nps[i]=='Arts'
      nps[i]='<:Buster_y:526556105422274580>Buster' if nps[i]=='Buster'
    end
    search.push("*Noble Phantasm card types*: #{nps.join(', ')}")
  end
  if targets.length>0
    char2=[]
    for i in 0...char.length
      nophan=@skills.find_index{|q| q[2]=='Noble' && q[1]==char[i][0].to_s}
      nophan2=@skills.find_index{|q| q[2]=='Noble' && q[1]=="#{char[i][0].to_s}u"}
      if nophan.nil?
      elsif has_any?(@skills[nophan][6].split(' / '),targets)
        char2.push(char[i])
      elsif !nophan2.nil? && has_any?(@skills[nophan2][6].split(' / '),targets)
        char[i][1]="#{char[i][1]} *[Upgrade]*"
        char2.push(char[i])
      end
    end
    textra="#{textra}\n\nThe word \"Enemy\" is being interpreted as a search for NPs that target a single enemy.\nIf you would like to find a list of enemy-exclusive servants, use the search term \"Unavailable\" instead." if targets.include?('Enemy') && !avail.include?('Unavailable') && event.message.text.downcase.split(' ').include?('enemy')
    textra="#{textra}\n\nThe word \"Enemies\" is being interpreted as a search for NPs that target all enemies.\nIf you would like to find a list of enemy-exclusive servants, use the search term \"Unavailable\" instead." if targets.include?('All Enemies') && !avail.include?('Unavailable') && event.message.text.downcase.split(' ').include?('enemies')
    char=char2.map{|q| q}
    search.push("*Noble Phantasm target(s)*: #{targets.join(', ')}")
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
  if (char.length>50 || char.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.join("\n").length+search.join("\n").length+textra.length>=1900) && !safe_to_spam?(event) && mode==0
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  else
    return [search,textra,char]
  end
end

def find_skills(bot,event,args=nil,ces_only=false)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase).gsub('-','').gsub('_','')}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  types=[]
  tags=[]
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  for i in 0...args.length
    types.push('Skill') if ['active','activeskill','activeskil'].include?(args[i])
    types.push('Passive') if ['passive','passiveskill','passiveskil'].include?(args[i])
    types.push('Noble') if ['np','noble','phantasm','noblephantasm'].include?(args[i])
    types.push('Clothes') if ['clothes','clothing','clothingskill','clothesskill','clothingskil','clothesskil','clotheskil','clotheskill','mystic','mysticcode'].include?(args[i])
    types.push('CEs') if ['ce','ces','craft','crafts','essence','essences'].include?(args[i])
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  types=['CEs'] if ces_only
  types.uniq!
  tags.uniq!
  str="__**Search**__"
  skz=@skills.map{|q| q}
  if types.length>0
    skz=skz.reject{|q| !types.include?(q[2])}
    for i in 0...types.length
      types[i]='Active' if types[i]=='Skill'
      types[i]='Noble Phantasm' if types[i]=='Noble'
      types[i]='Craft Essence' if types[i]=='CEs'
    end
    str="#{str}\n*Skill types:* #{types.join(', ')}"
  end
  for i in 0...skz.length
    skz[i]=[skz[i][0],skz[i][1],skz[i][2],skz[i][5]] if skz[i][2]=='Skill'
    skz[i]=[skz[i][0],skz[i][1],skz[i][2],skz[i][4]] if skz[i][2]=='Passive'
    if skz[i][2]=='Noble'
      skz[i][1]="#{skz[i][1]}b" if i<skz.length-1 && skz[i+1][2]=='Noble' && skz[i+1][1]=="#{skz[i][1]}u"
      skz[i]=[skz[i][0],skz[i][1],skz[i][2],skz[i][7]]
    end
    skz[i]=[skz[i][0],skz[i][1],skz[i][2],skz[i][3]] if skz[i][2]=='Clothes'
  end
  ces=@crafts.map{|q| [q[1],q[0],'CE',q[10]]}
  if types.length<=0 || types.include?('CEs') || types.include?('Craft Essence')
    for i in 0...ces.length
      skz.push(ces[i])
    end
  end
  if tags.length>0
    skz=skz.reject{|q| !has_any?(tags,q[3])}
    str="#{str}\n*Tags:* #{tags.join(', ')}"
  end
  str="#{str}\n\n__**Results**__"
  m=[['Active Skills',[]],['Passive Skills',[]],['Noble Phantasms',[]],['Craft Essances',[]],['Clothing Skills',[]],['Other',[]]]
  for i in 0...skz.length
    if skz[i][2]=='Skill'
      if i>0 && skz[i-1][2]=='Skill' && skz[i-1][0]==skz[i][0]
      elsif skz[i][1]=='-'
        m[0][1].push(skz[i][0])
      else
        m[0][1].push("#{skz[i][0]} #{skz.reject{|q| q[2]!='Skill' || q[0]!=skz[i][0]}.map{|q| q[1]}.join('/')}")
      end
    elsif skz[i][2]=='Passive'
      if i>0 && skz[i-1][2]=='Passive' && skz[i-1][0]==skz[i][0]
      elsif skz[i][1]=='-'
        m[1][1].push(skz[i][0])
      else
        m[1][1].push("#{skz[i][0]} #{skz.reject{|q| q[2]!='Passive' || q[0]!=skz[i][0]}.map{|q| q[1]}.join('/')}")
      end
    elsif skz[i][2]=='Noble'
      if i>0 && skz[i-1][2]=='Noble' && skz[i-1][1]==skz[i][1].gsub('u','b')
      elsif i<skz.length-1 && skz[i+1][2]=='Noble' && skz[i+1][1]==skz[i][1].gsub('b','u')
        m[2][1].push("NP-#{skz[i][1].gsub('u','').gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]}")
      elsif skz[i][1].include?('b')
        m[2][1].push("NP-#{skz[i][1].gsub('u','').gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]} *[Before Upgrading]*")
      elsif skz[i][1].include?('u')
        m[2][1].push("NP-#{skz[i][1].gsub('u','').gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]} *[After Upgrading]*")
      else
        m[2][1].push("NP-#{skz[i][1].gsub('u','').gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]}")
      end
    elsif skz[i][2]=='CE'
      m[3][1].push("CE-#{skz[i][1]}.) #{skz[i][0]}")
    elsif skz[i][2]=='Clothes'
      m[4][1].push(skz[i][0])
    end
  end
  ftr="#{m.map{|q| q[1]}.join("\n").split("\n").reject{|q| q.nil? || q.length<=0}.length} Total (#{m[0][1].length} Active, #{m[1][1].length} Passive, #{m[2][1].length} Noble, #{m[3][1].length} CE, #{m[4][1].length} Clothing)"
  f=m.map{|q| q[1].length}
  for i in 0...5
    if f[i]<=f.max/3 && f[i]>0
      m[5][1].push("__**#{m[i][0]}**__\n#{m[i][1].join("\n")}\n")
      m[i][1]=[]
    end
  end
  m=m.reject{|q| q[1].length<=0}
  if m.length<=0
    event.respond "#{str}\n~~none~~"
    return nil
  elsif m.length==1
    m=triple_finish(m[0][1])
  else
    m=m.map{|q| [q[0],q[1].join("\n")]}
  end
  if m.map{|q| q.join("\n")}.join("\n\n").length+str.length+ftr.length>1900
    if !safe_to_spam?(event,nil,1)
      event.respond 'There are too many skills trying to be displayed.  Please retry this command in PM.'
    else
      str=str.gsub("\n\n","\n\n\n")
      for i in 0...m.length
        str=extend_message(str,"__*#{m[i][0]}*__",event,2)
        f=m[i][1].split("\n")
        for i2 in 0...f.length
          str=extend_message(str,f[i2],event)
        end
      end
    end
    event.respond str
    return nil
  end
  create_embed(event,str,'',0xED619A,ftr,nil,m)
end

def find_servants(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_servants(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]}"}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length+textra.length>=1900
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

def sort_servants(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_servants(bot,event,args,1)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  srt=[4,4,4]
  srtt=0
  lvl=-1
  for i in 0...args.length
    lvl=0 if ['lvl1','level1','base','1level','1lvl'].include?(args[i].downcase)
    lvl=1 if ['max','default'].include?(args[i].downcase)
    lvl=2 if ['lvl100','level100','grail','100level','100lvl'].include?(args[i].downcase)
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(6)
      srt[srtt]=6
      srtt+=1
    elsif ['atk','att','attack'].include?(args[i].downcase) && !srt.include?(7)
      srt[srtt]=7
      srtt+=1
    end
  end
  unless textra.include?('Unavailable') || event.message.text.downcase.split(' ').include?('all')
    char2=char.reject{|q| q[20]=='Unavailable'}.uniq
    textra="#{textra}\n\nFor usefulness, I have removed servants that are unavailable to Masters.\nIf you would like to include those servants, include the word \"all\" in your message." unless char2.length==char.length
    char=char2.map{|q| q}
  end
  if lvl<0 && srt.reject{|q| q==2}.length>0
    textra="#{textra}\n\nNo level was included, so I am sorting by default maximum level.\nIf you wish to change that, include the word \"Base\" (for level 1) or \"Grail\" (for level 100)."
    lvl=1
  end
  for i in 0...char.length
    char[i][4]=@servants.length+100-char[i][0]
    char[i][6]=char[i][6][lvl]
    char[i][7]=char[i][7][lvl]
  end
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? supersort(a,b,srt[2]) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  d=['ID','Name','Servant ID','Rarity','Growth','Level','HP','Atk']
  disp=[]
  for i in 0...char.length
    m=[]
    for i2 in 0...srt.length
      m.push("#{longFormattedNumber(char[i][srt[i2]])} #{d[srt[i2]]}") if srt[i2]>4
    end
    disp.push("Srv-#{char[i][0]}#{'.' if char[i][0]>=2}) #{char[i][1]}#{servant_moji(bot,event,char[i],1)}#{"  -  #{m.join('  -  ')}" if m.length>0}")
  end
  str="__**Search**__#{"\n#{search.join("\n")}" if search.length>0}#{"\n*Sorted by:* #{srt.reject{|q| q==4}.uniq.map{|q| d[q]}.join(', ')}\n*Sorted at:* #{['Base','Default Max','Grailed Max'][lvl]} Level" if srt.reject{|q| q==2}.length>0}#{"\n\n__**Additional notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
  str="__**Results**__" if str=="__**Search**__\n\n__**Results**__"
  if str.length+disp.join("\n").length>1900 && !safe_to_spam?(event)
    textra="#{textra}\n\nToo much data is trying to be displayed.\nShowing top ten results."
    disp=disp[0,[10,disp.length].min]
  end
  t=textra.split("\n")
  for i in 0...5
    t.shift if t.length>0 && t[0].length<=0
  end
  textra=t.join("\n")
  str="__**Search**__#{"\n#{search.join("\n")}" if search.length>0}#{"\n*Sorted by:* #{srt.uniq.map{|q| d[q]}.join(', ')}\n*Sorted at:* #{['Base','Default Max','Grailed Max'][lvl]} Level" if srt.reject{|q| q==2}.length>0}#{"\n\n__**Additional notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
  str="__**Results**__" if str=="__**Search**__\n\n__**Results**__"
  for i in 0...disp.length
    str=extend_message(str,disp[i],event)
  end
  event.respond str
end

def exp_shift(m,mode=0)
  if m==0
    return '-'
  elsif m%97200==0 && mode==1
    return "#{longFormattedNumber(m/97200)} <:FGO_rarity_5:544583774965596171> Hellfire#{'s' unless m/97200==1}"
  elsif m>97200 && mode==1
    return "#{longFormattedNumber(m/97200)} <:FGO_rarity_5:544583774965596171> Hellfire#{'s' unless m/97200==1}, #{exp_shift(m-(m/97200)*97200,2)}"
  elsif m%32400==0
    return "#{longFormattedNumber(m/32400)} <:FGO_rarity_4:544583774923653140> RFlame#{'s' unless m/32400==1}"
  elsif m>32400
    return "#{longFormattedNumber(m/32400)} <:FGO_rarity_4:544583774923653140> RFlame#{'s' unless m/32400==1}, #{exp_shift(m-(m/32400)*32400,2)}"
  elsif m%10800==0
    return "#{longFormattedNumber(m/10800)} <:FGO_rarity_3:544583774944624670> Blaze#{'s' unless m/10800==1}"
  elsif m>10800
    return "#{longFormattedNumber(m/10800)} <:FGO_rarity_3:544583774944624670> Blaze#{'s' unless m/10800==1}, #{exp_shift(m-(m/10800)*10800,2)}"
  elsif m%3600==0
    return "#{longFormattedNumber(m/3600)} <:FGO_rarity_2:544583776148258827> Torch#{'s' unless m/3600==1}"
  elsif m>3600
    return "#{longFormattedNumber(m/3600)} <:FGO_rarity_2:544583776148258827> Torch#{'s' unless m/3600==1}, #{exp_shift(m-(m/3600)*3600,2)}"
  elsif m%1200==0
    return "#{longFormattedNumber(m/1200)} <:FGO_rarity_1:544583775330369566> Ember#{'s' unless m/1200==1}"
  elsif m>1200
    return "#{longFormattedNumber(m/1200)} <:FGO_rarity_1:544583775330369566> Ember#{'s' unless m/1200==1}, #{exp_shift(m-(m/1200)*1200,2)}"
  elsif m%1000==0
    return "#{longFormattedNumber(m/1000)} <:FGO_rarity_off:544583775208603688> off-class Ember#{'s' unless m/1000==1}"
  else
    return "#{longFormattedNumber(m/1000+1)} <:FGO_rarity_off:544583775208603688> off-class Ember#{'s' unless m/1000==0}"
  end
end

def level(event,bot,args=nil,mode=0)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  nums=[]
  g=0
  for i in 0...args.length
    nums.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0
    mode=1 if mode==0 && ['player','pxp','pexp','plxp','plexp','plevel','pllevel'].include?(args[i])
    mode=2 if mode==0 && ['servant','servants','unit','units','sexp','sxp','slevel','servantexp','servantxp','servantlevel','unitexp','unitxp','unitlevel'].include?(args[i])
    mode=3 if mode==0 && ['craft','crafts','essence','essences','ceexp','cexp','cxp','celevel','clevel','craftexp','craftxp','craftlevel','essenceexp','essencexp','essencelevel','craftessence','craftessences','craft-essence','craft-essences','craft_essences','craft_essence'].include?(args[i])
    g=1 if ['ssr','gold','hellfire'].include?(args[i])
  end
  if mode==0 && !safe_to_spam?(event)
    event.respond "Please either specify an EXP type or use this command in PM.\n\nAvailable EXP types include:\n- Player\n- Servant\n- Craft Essance"
    return nil
  end
  nums.uniq!
  str=''
  if [1,0].include?(mode)
    pxp=[[31,20,10,25],[32,21,11,26],[59,22,12,27],[87,23,13,28],[287,24,14,31],[419,25,15,32],[629,26,16,33],[829,27,17,34],[1234,28,18,35],[1634,31,19,38],
         [2129,32,20,39],[2569,33,21,40],[3254,34,22,41],[3884,35,23,42],[4742,38,24,45],[5266,39,25,46],[5869,40,26,47],[6679,41,27,48],[7534,42,28,49],
         [8434,45,29,52],[9379,46,29,53],[10369,47,30,53],[11404,48,30,54],[12484,49,31,54],[13609,50,31,55],[14779,51,32,55],[15994,52,32,56],
         [17254,53,33,56],[18559,54,33,56],[19909,55,34,59],[21304,56,34,60],[22744,57,35,60],[24249,58,35,61],[25759,59,36,61],[27334,60,36,62],
         [28954,61,37,62],[30619,62,37,63],[32329,63,38,63],[34084,64,38,63],[35884,65,39,66],[37729,66,39,67],[39619,67,40,67],[41554,68,40,68],
         [43534,69,41,68],[45559,70,41,69],[47629,71,42,69],[49744,72,42,70],[51904,73,43,70],[54109,74,43,70],[56359,75,44,73],[58654,76,44,74],
         [60994,77,45,74],[63379,78,45,75],[65809,79,46,75],[68284,80,46,76],[70804,81,47,76],[73369,82,47,77],[75979,83,48,77],[78634,84,48,78],
         [81334,85,49,78],[84079,86,49,79],[86869,87,50,79],[89704,88,50,80],[92584,89,50,80],[95509,90,50,81],[98479,91,50,81],[101494,92,50,82],
         [104554,93,50,82],[107659,94,50,83],[110809,95,50,83],[114004,96,50,84],[113244,97,50,84],[120529,98,50,85],[123859,99,50,85],[127234,100,50,86],
         [130654,101,50,86],[134119,102,50,87],[137629,103,50,87],[141184,104,50,88],[144784,105,50,88],[148429,106,50,89],[152119,107,50,89],
         [155854,108,50,90],[159634,109,50,90],[163459,110,50,91],[167329,111,50,91],[171244,112,50,92],[175204,113,50,92],[179209,114,50,93],
         [183259,115,50,93],[187354,116,50,94],[191494,117,50,94],[195679,118,50,95],[199909,119,50,95],[204184,120,50,96],[208504,121,50,96],
         [212869,122,50,97],[217279,123,50,97],[221734,124,50,98],[226234,125,50,98],[428234,126,51,99],[560834,126,52,100],[694734,127,53,100],
         [798734,127,54,101],[903734,128,55,101],[1009734,128,56,102],[1138134,129,57,102],[1267734,129,58,103],[1398534,130,59,103],[1563534,130,60,104],
         [1674534,131,60,104],[1786534,131,60,105],[1899534,132,60,105],[2013534,132,60,106],[2140034,133,60,106],[2267634,133,60,107],[2396334,134,60,107],
         [2490734,134,60,108],[2609734,135,60,108],[2741734,135,60,109],[3001884,136,61,109],[3197084,136,62,109],[3400034,136,63,110],[3620134,136,64,110],
         [3842009,137,65,110],[4034159,137,66,110],[4259584,137,67,111],[4464384,137,68,111],[4677234,138,69,111],[4919315,138,70,111],[5705315,138,71,111],
         [6761315,138,72,111],[8224315,139,73,111],[9430315,139,74,111],[10915315,139,75,111],[12207315,139,76,111],[13919815,140,77,111],
         [15368815,140,78,111],[16897815,140,79,111],[18857815,140,80,112],[18870505,140,81,112],[18883285,140,82,112],[18896155,141,83,112],
         [18909115,141,84,112],[18922165,141,85,112],[18935305,141,86,112],[18948535,142,87,112],[18961855,142,88,112],[18975265,142,89,112],
         [18988765,142,90,113]]
    na_max=140
    str2="__**Player EXP**__"
    if nums.length<=0
      str2="#{str2}\n\n*To get from level 1 to level #{na_max}:*  \u200B  \u200B  #{longFormattedNumber(pxp[0,na_max-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
      str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[na_max-1][1]-pxp[0][1]} points of increase ~~(from #{pxp[0][1]} to #{pxp[na_max-1][1]})~~"
      str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[na_max-1][2]-pxp[0][2]} more friends ~~(from #{pxp[0][2]} to #{pxp[na_max-1][2]})~~"
      str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[na_max-1][3]-pxp[0][3]} points of increase ~~(from #{pxp[0][3]} to #{pxp[na_max-1][3]})~~"
      str2="#{str2}\n\n*To get from level 1 to level #{pxp.length}:*  \u200B  \u200B  #{longFormattedNumber(pxp.map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
      str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[pxp.length-1][1]-pxp[0][1]} points of increase ~~(from #{pxp[0][1]} to #{pxp[pxp.length-1][1]})~~"
      str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[pxp.length-1][2]-pxp[0][2]} more friends ~~(from #{pxp[0][2]} to #{pxp[pxp.length-1][2]})~~"
      str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[pxp.length-1][3]-pxp[0][3]} points of increase ~~(from #{pxp[0][3]} to #{pxp[pxp.length-1][3]})~~"
    elsif nums.length==1
      n=[nums[0],pxp.length].min
      unless n==1
        str2="#{str2}\n\n*To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(pxp[0,n-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
        str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[n-1][1]-pxp[0][1]} points of increase ~~(from #{pxp[0][1]} to #{pxp[n-1][1]})~~"
        str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[n-1][2]-pxp[0][2]} more friends ~~(from #{pxp[0][2]} to #{pxp[n-1][2]})~~"
        str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[n-1][3]-pxp[0][3]} points of increase ~~(from #{pxp[0][3]} to #{pxp[n-1][3]})~~"
      end
      unless n==na_max
        str2="#{str2}\n\n*To get from level #{n} to level #{na_max}:*  \u200B  \u200B  #{longFormattedNumber(pxp[n-1,na_max-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
        str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[na_max-1][1]-pxp[n-1][1]} points of increase ~~(from #{pxp[n-1][1]} to #{pxp[na_max-1][1]})~~"
        str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[na_max-1][2]-pxp[n-1][2]} more friends ~~(from #{pxp[n-1][2]} to #{pxp[na_max-1][2]})~~"
        str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[na_max-1][3]-pxp[n-1][3]} points of increase ~~(from #{pxp[n-1][3]} to #{pxp[na_max-1][3]})~~"
      end
      unless n==pxp.length
        str2="#{str2}\n\n*To get from level #{n} to level #{pxp.length}:*  \u200B  \u200B  #{longFormattedNumber(pxp[n-1,pxp.length-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
        str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[pxp.length-1][1]-pxp[n-1][1]} points of increase ~~(from #{pxp[n-1][1]} to #{pxp[pxp.length-1][1]})~~"
        str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[pxp.length-1][2]-pxp[n-1][2]} more friends ~~(from #{pxp[n-1][2]} to #{pxp[pxp.length-1][2]})~~"
        str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[pxp.length-1][3]-pxp[n-1][3]} points of increase ~~(from #{pxp[n-1][3]} to #{pxp[pxp.length-1][3]})~~"
      end
    else
      n=[nums[0,2].min,1].max
      m=[nums[0,2].max,pxp.length].min
      str2="#{str2}\n*To get from level #{n} to level #{m}:*  \u200B  \u200B  #{longFormattedNumber(pxp[n-1,m-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
      str2="#{str2}\n*Resulting AP increase:*  \u200B  \u200B  #{pxp[m-1][1]-pxp[n-1][1]} points of increase ~~(from #{pxp[n-1][1]} to #{pxp[m-1][1]})~~"
      str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[m-1][2]-pxp[n-1][2]} more friends ~~(from #{pxp[n-1][2]} to #{pxp[m-1][2]})~~"
      str2="#{str2}\n*Resulting party cost increase:*  \u200B  \u200B  #{pxp[m-1][3]-pxp[n-1][3]} points of increase ~~(from #{pxp[n-1][3]} to #{pxp[m-1][3]})~~"
    end
    str=extend_message(str,str2,event,2)
  end
  if [2,0].include?(mode)
    axp=[1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136,153,171,190,210,231,253,276,300,325,351,378,406,435,465,496,528,561,595,630,666,703,741,780,820,861,
         903,946,990,1035,1081,1128,1176,1225,1275,1326,1378,1431,1485,1540,1596,1653,1711,1770,1830,1891,1953,2016,2080,2145,2211,2278,2346,2415,2485,2556,
         2628,2701,2775,2850,2926,3300,3081,3160,3240,3321,3403,3486,3570,3655,3741,3828,3916,4005,4185,4549,5101,5845,6785,7925,9269,10821,12585,14565,0]
    str=extend_message(str,"__**Servant EXP**__",event,2)
    if nums.length<=0
      m=axp[0,60].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_bronze:523948997430214666> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      m=axp[0,65].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_bronze:523948997430214666> *To get from level 1 to level 65:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      m=axp[0,70].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_silver:523838967058006027> *To get from level 1 to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      m=axp[0,80].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_gold:523838979825467392> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      m=axp[0,90].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_gold:523838979825467392> *To get from level 1 to level 90:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      m=axp[0,100].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:holy_grail:523842742992764940> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
    elsif nums.length==1
      n=[nums[0],axp.length].min
      m=axp[0,n].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:class_unknown_blue:523948997229019136> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      if n<60
        m=axp[n-1,60-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:class_unknown_bronze:523948997430214666> *To get from level #{n} to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
      if n<65
        m=axp[n-1,65-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:class_unknown_bronze:523948997430214666> *To get from level #{n} to level 65:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
      if n<70
        m=axp[n-1,70-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:class_unknown_silver:523838967058006027> *To get from level #{n} to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
      if n<80
        m=axp[n-1,80-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:class_unknown_gold:523838979825467392> *To get from level #{n} to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
      if n<90
        m=axp[n-1,90-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:class_unknown_gold:523838979825467392> *To get from level #{n} to level 90:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
      if n<100
        m=axp[n-1,100-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:holy_grail:523842742992764940> *To get from level #{n} to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
      end
    else
      n=[nums[0,2].min,1].max
      n2=[nums[0,2].max,axp.length].min
      m=axp[n-1,n2-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str="#{str}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}"
    end
    str=extend_message(str,"This only includes up to <:FGO_rarity_4:544583774923653140> Embers in its calculations.\nIf you wish to include <:FGO_rarity_5:544583774965596171> Embers as well, include the word \"SSR\" in your message.",event,2) unless g==1
  end
  if [3,0].include?(mode)
    dxp=[1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136,153,171,190,210,231,253,276,300,325,351,378,406,435,465,496,528,561,595,630,666,703,741,780,820,861,
         903,946,990,1035,1081,1128,1176,1225,1275,1326,1378,1431,1485,1540,1596,1653,1711,1770,1830,1891,1953,2016,2080,2145,2211,2278,2346,2415,2485,2556,
         2628,2701,2775,2850,2926,3003,3081,3160,3240,3321,3403,3486,3570,3655,3741,3828,3916,4005,4095,4186,4278,4371,4465,4560,4656,4753,4851,4950,5050,0]
    str=extend_message(str,"__**Craft Essence EXP**__",event,2)
    if nums.length<=0
      m=dxp[0,10].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 10:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_1:544583775330369566>D" if safe_to_spam?(event)}",event)
      m=dxp[0,15].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 15:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>D" if safe_to_spam?(event)}",event)
      m=dxp[0,20].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 20:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_3:544583774944624670>D, <:FGO_rarity_4:544583774923653140>D, <:FGO_rarity_5:544583774965596171>D, <:FGO_rarity_1:544583775330369566>LB1" if safe_to_spam?(event)}",event)
      m=dxp[0,25].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 25:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>LB1" if safe_to_spam?(event)}",event)
      m=dxp[0,30].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 30:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_3:544583774944624670>LB1, <:FGO_rarity_1:544583775330369566>LB2" if safe_to_spam?(event)}",event)
      m=dxp[0,35].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 35:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB1, <:FGO_rarity_2:544583776148258827>LB2" if safe_to_spam?(event)}",event)
      m=dxp[0,40].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 40:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB1, <:FGO_rarity_3:544583774944624670>LB2, <:FGO_rarity_1:544583775330369566>LB3" if safe_to_spam?(event)}",event)
      m=dxp[0,45].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 45:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>LB3" if safe_to_spam?(event)}",event)
      m=dxp[0,50].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 50:*  <:FGO_rarity_1:544583775330369566>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB2, <:FGO_rarity_3:544583774944624670>LB3, <:FGO_rarity_1:544583775330369566>max" if safe_to_spam?(event)}",event)
      m=dxp[0,55].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 55:*  <:FGO_rarity_2:544583776148258827>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>MLB" if safe_to_spam?(event)}",event)
      m=dxp[0,60].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 60:*  <:FGO_rarity_3:544583774944624670>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB2, <:FGO_rarity_3:544583774944624670>MLB" if safe_to_spam?(event)}",event)
      m=dxp[0,65].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 65:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB3" if safe_to_spam?(event)}",event)
      m=dxp[0,80].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 80:*  <:FGO_rarity_4:544583774923653140>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB3, <:FGO_rarity_4:544583774923653140>MLB" if safe_to_spam?(event)}",event)
      m=dxp[0,100].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level 100:*  <:FGO_rarity_5:544583774965596171>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>MLB" if safe_to_spam?(event)}",event)
    elsif nums.length==1
      n=[nums[0],dxp.length].min
      m=dxp[0,n].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level 1 to level #{n}:*  <:FGO_rarity_off:544583775208603688>  #{longFormattedNumber(m)} EXP",event)
      if n<10
        m=dxp[n-1,10-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 10:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_1:544583775330369566>D" if safe_to_spam?(event)}",event)
      end
      if n<15
        m=dxp[n-1,15-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 15:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>D" if safe_to_spam?(event)}",event)
      end
      if n<20
        m=dxp[n-1,20-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 20:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_3:544583774944624670>D, <:FGO_rarity_4:544583774923653140>D, <:FGO_rarity_5:544583774965596171>D, <:FGO_rarity_1:544583775330369566>LB1" if safe_to_spam?(event)}",event)
      end
      if n<25
        m=dxp[n-1,25-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 25:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>LB1" if safe_to_spam?(event)}",event)
      end
      if n<30
        m=dxp[n-1,30-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 30:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_3:544583774944624670>LB1, <:FGO_rarity_1:544583775330369566>LB2" if safe_to_spam?(event)}",event)
      end
      if n<35
        m=dxp[n-1,35-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 35:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB1, <:FGO_rarity_2:544583776148258827>LB2" if safe_to_spam?(event)}",event)
      end
      if n<40
        m=dxp[n-1,40-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 40:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB1, <:FGO_rarity_3:544583774944624670>LB2, <:FGO_rarity_1:544583775330369566>LB3" if safe_to_spam?(event)}",event)
      end
      if n<45
        m=dxp[n-1,45-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 45:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>LB3" if safe_to_spam?(event)}",event)
      end
      if n<50
        m=dxp[n-1,50-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 50:*  <:FGO_rarity_1:544583775330369566>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB2, <:FGO_rarity_3:544583774944624670>LB3, <:FGO_rarity_1:544583775330369566>max" if safe_to_spam?(event)}",event)
      end
      if n<55
        m=dxp[n-1,55-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 55:*  <:FGO_rarity_2:544583776148258827>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_2:544583776148258827>MLB" if safe_to_spam?(event)}",event)
      end
      if n<60
        m=dxp[n-1,60-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 60:*  <:FGO_rarity_3:544583774944624670>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB2, <:FGO_rarity_3:544583774944624670>MLB" if safe_to_spam?(event)}",event)
      end
      if n<65
        m=dxp[n-1,65-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 65:*  \u200B  \u200B  \u200B  \u200B  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_4:544583774923653140>LB3" if safe_to_spam?(event)}",event)
      end
      if n<80
        m=dxp[n-1,80-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 80:*  <:FGO_rarity_4:544583774923653140>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>LB3, <:FGO_rarity_4:544583774923653140>MLB" if safe_to_spam?(event)}",event)
      end
      if n<100
        m=dxp[n-1,100-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"*To get from level #{n} to level 100:*  <:FGO_rarity_5:544583774965596171>  #{longFormattedNumber(m)} EXP#{"  \u200B  \u200B  <:FGO_rarity_5:544583774965596171>MLB" if safe_to_spam?(event)}",event)
      end
    else
      n=[nums[0,2].min,1].max
      n2=[nums[0,2].max,dxp.length].min
      m=dxp[n-1,n2-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP",event)
    end
  end
  event.respond str
end

bot.command([:xp,:exp,:level]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args)
end

bot.command([:plxp,:plexp,:pllevel,:plevel,:pxp,:pexp]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,1)
end

bot.command([:sxp,:sexp,:slevel]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,2)
end

bot.command([:cxp,:cexp,:ceexp,:clevel,:celevel]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,3)
end

bot.command([:skill,:skil]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  end
  disp_skill_data(bot,event,args)
end

bot.command([:sort,:list]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['aliases','alias'].include?(args[0].downcase) && event.user.id==167657750971547648
    data_load()
    nicknames_load()
    @aliases.uniq!
    @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
    open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
      for i in 0...@aliases.length
        f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
      end
    }
    event.respond 'The alias list has been sorted alphabetically'
    return nil
  end
  sort_servants(bot,event,args)
end

bot.command([:find,:search,:lookup]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['skill','skills','skil','skils'].include?(args[0].downcase)
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

bot.command([:tools,:links,:tool,:link,:resources,:resources]) do |event|
  return nil if overlap_prevent(event)
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || event.message.text.downcase.include?('mobile') || event.message.text.downcase.include?('phone')
    event << '**Useful tools for players of** ***Fate/Grand Order***'
    event << '__Download the game__'
    event << 'Google Play (NA): <https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US>'
    event << 'Google Play (JP): <https://play.google.com/store/apps/details?id=com.xiaomeng.fategrandorder&hl=en_US>'
    event << 'Apple App Store (NA): <https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8>'
    event << 'Apple App Store (JP): <https://itunes.apple.com/jp/app/fate-grand-order/id1015521325?l=en&mt=8>'
    event << ''
    event << '__Wikis and databases__'
    event << 'Cirnopedia: <https://fate-go.cirnopedia.org>'
    event << 'Wikia: <https://fategrandorder.fandom.com/wiki/Fate/Grand_Order_Wikia>'
    event << ''
    event << '__Important lists and spreadsheets__'
    event << 'Interlude info: <https://goo.gl/SCsKJn>'
    event << 'Material location guide: <https://goo.gl/ijqefs>'
    event << 'List of Singularity maps with drops: <https://imgur.com/a/6nXq9#f8dRAp5>'
    event << 'Rate-up History (NA): <http://fate-go.cirnopedia.org/summon_us.php>'
    event << 'Rate-up History (JP): <http://fate-go.cirnopedia.org/summon.php>'
    event << 'Order of Interludes and Strengthening Quests: <https://kazemai.github.io/fgo-vz/relate_quest.html>'
    event << 'Palingenesis data: <https://fategrandorder.fandom.com/wiki/Palingenesis>'
    event << 'Current Master Missions: <http://fate-go.cirnopedia.org/master_mission.php>'
    event << ''
    event << '__Calculators and Planners__'
    event << 'Damage calculator: <https://tinyurl.com/yc2tuzn9>'
    event << 'EXP calculator: <https://grandorder.gamepress.gg/exp-calculator>'
    event << 'Material planner: <http://fgosimulator.webcrow.jp/Material/>'
    event << 'Servant planner: <https://grandorder.gamepress.gg/servant-planner>'
    event << 'Daily mats: <https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Mats.png>'
  else
    xpic='https://lh3.googleusercontent.com/gXUStNHv8sT8NjdXBOJmzqK_JIYlPP_6jKBjEOIyP-28CSsnPempO86swUYhVhVgvH4f=s180-rw'
    t=Time.now
    xpic='https://vignette.wikia.nocookie.net/fategrandorder/images/a/ac/FGO_GO_App_Icon.png' if t.month==4 && t.day==1
    create_embed(event,'**Useful tools for players of** ***Fate/Grand Order***',"__Download the game__\n[Google Play (NA)](https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US)  \u00B7  [Google Play (JP)](https://play.google.com/store/apps/details?id=com.xiaomeng.fategrandorder&hl=en_US)\n[Apple App Store (NA)](https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8)  \u00B7  [Apple App Store (JP)](https://itunes.apple.com/jp/app/fate-grand-order/id1015521325?l=en&mt=8)\n\n__Wikis and databases__\n[Cirnopedia](https://fate-go.cirnopedia.org)\n[Wikia](https://fategrandorder.fandom.com/wiki/Fate/Grand_Order_Wikia)\n\n__Important lists and spreadsheets__\n[Interlude info](https://goo.gl/SCsKJn)\n[Material location guide](https://goo.gl/ijqefs)\n[List of Singularity maps with drops](https://imgur.com/a/6nXq9#f8dRAp5)\n[Rate-up History (NA)](http://fate-go.cirnopedia.org/summon_us.php)  \u00B7  [Rate-up History (JP)](http://fate-go.cirnopedia.org/summon.php)\n[Order of Interludes and Strengthening Quests](https://kazemai.github.io/fgo-vz/relate_quest.html)\n[Palingenesis data](https://fategrandorder.fandom.com/wiki/Palingenesis)\n[Current Master Missions](http://fate-go.cirnopedia.org/master_mission.php)\n\n__Calculators and Planners__\n[Damage Calculator](https://tinyurl.com/yc2tuzn9)\n[EXP calculator](https://grandorder.gamepress.gg/exp-calculator)\n[Material planner](http://fgosimulator.webcrow.jp/Material/)\n[Servant planner](https://grandorder.gamepress.gg/servant-planner)\n[Daily mats](https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Mats.png)",0xED619A,nil,xpic)
    event.respond 'If you are on a mobile device and cannot click the links in the embed above, type `FGO!tools mobile` to receive this message as plaintext.'
  end
  event << ''
end

bot.command(:addalias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  add_new_alias(bot,event,newname,unit,modifier,modifier2)
  return nil
end

bot.command(:alias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  add_new_alias(bot,event,newname,unit,modifier,modifier2,1)
  return nil
end

bot.command([:checkaliases,:aliases,:seealiases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args)
end

bot.command([:serveraliases,:saliases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args,1)
end

bot.command([:deletealias,:removealias]) do |event, name|
  return nil if overlap_prevent(event)
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
  elsif find_servant(name,event).length<=0 && find_skill(name,event).length<=0 && find_ce(name,event).length<=0 && find_mat(name,event).length<=0 && find_clothes(name,event).length<=0 && find_code(name,event).length<=0
    event.respond "#{name} is not an alias!"
    return nil
  end
  if find_servant(name,event,true).length>0
    j=find_servant(name,event,true)
    j=["Servant","#{j[1]} [Srv-##{j[0]}]"]
  elsif find_skill(name,event,true).length>0
    j=find_skill(name,event,true)
    j=j[0] if j[0].is_a?(Array)
    j=["Skill","#{j[0]}"]
  elsif find_ce(name,event,true).length>0
    j=find_ce(name,event,true)
    j=["Craft Essance","#{j[1]} [CE-##{j[0]}]"]
  elsif find_mat(name,event,true).length>0
    j=find_mat(name,event,true)
    j=["Material","#{j}"]
  elsif find_clothes(name,event,true).length>0
    j=find_clothes(name,event,true)
    j=["Clothes","#{j[0]}"]
  elsif find_code(name,event,true).length>0
    j=find_code(name,event,true)
    j=["Command","#{j[1]} [Cmd-#{j[0]}]"]
  elsif find_servant(name,event).length>0
    j=find_servant(name,event)
    j=["Servant","#{j[1]} [Srv-##{j[0]}]"]
  elsif find_skill(name,event).length>0
    j=find_skill(name,event)
    j=j[0] if j[0].is_a?(Array)
    j=["Skill","#{j[0]}"]
  elsif find_ce(name,event).length>0
    j=find_ce(name,event)
    j=["Craft Essance","#{j[1]} [CE-##{j[0]}]"]
  elsif find_mat(name,event).length>0
    j=find_mat(name,event)
    j=["Material","#{j}"]
  elsif find_clothes(name,event).length>0
    j=find_clothes(name,event)
    j=["Clothes","#{j[0]}"]
  elsif find_code(name,event).length>0
    j=find_code(name,event)
    j=["Command","#{j[1]} [Cmd-#{j[0]}]"]
  end
  k=0
  k=event.server.id unless event.server.nil?
  for izzz in 0...@aliases.length
    if @aliases[izzz][1].downcase==name.downcase
      if @aliases[izzz][3].nil? && event.user.id != 167657750971547648
        event.respond 'You cannot remove a global alias'
        return nil
      elsif @aliases[izzz][3].nil? || @aliases[izzz][3].include?(k)
        unless @aliases[izzz][3].nil?
          for izzz2 in 0...@aliases[izzz][3].length
            @aliases[izzz][3][izzz2]=nil if @aliases[izzz][3][izzz2]==k
          end
          @aliases[izzz][3].compact!
        end
        @aliases[izzz]=nil if @aliases[izzz][3].nil? || @aliases[izzz][3].length<=0
      end
    end
  end
  @aliases.uniq!
  @aliases.compact!
  logchn=502288368777035777
  logchn=431862993194582036 if @shardizard==4
  srv=0
  srv=event.server.id unless event.server.nil?
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n~~**#{j[0]} Alias:** #{name} for #{j[1]}~~ **DELETED**.")
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond "#{name} has been removed from #{j[1]}'s aliases."
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>2 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
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
  return nil if overlap_prevent(event)
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
  return nil if overlap_prevent(event)
  disp_servant_stats(bot,event,args)
  return nil
end

bot.command([:traits,:trait]) do |event, *args|
  return nil if overlap_prevent(event)
  name=args.join(' ')
  if find_data_ex(:find_servant,name,event,true).length>0
    disp_servant_traits(bot,event,args)
  elsif find_data_ex(:find_enemy,name,event,true).length>0
    disp_enemy_traits(bot,event,args)
  elsif find_data_ex(:find_servant,name,event).length>0
    disp_servant_traits(bot,event,args)
  elsif find_data_ex(:find_enemy,name,event).length>0
    disp_enemy_traits(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:art,:artist]) do |event, *args|
  return nil if overlap_prevent(event)
  event.channel.send_temporary_message('Calculating data, please wait...',1)
  name=args.join(' ')
  if find_data_ex(:find_servant,name,event,true).length>0
    disp_servant_art(bot,event,args)
  elsif find_data_ex(:find_ce,name,event,true).length>0
    disp_ce_art(bot,event,args)
  elsif find_data_ex(:find_servant,name,event).length>0
    disp_servant_art(bot,event,args)
  elsif find_data_ex(:find_ce,name,event).length>0
    disp_ce_art(bot,event,args)
  else
    event.respond "No matches found."
  end
  return nil
end

bot.command([:riyo,:Riyo]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_art(bot,event,args,true)
  return nil
end

bot.command([:np,:NP,:noble,:phantasm,:noblephantasm]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_np(bot,event,args)
  return nil
end

bot.command([:ce,:CE,:cE,:Ce,:craft,:essance,:craftessance]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args,true)
    return nil
  end
  name=args.join(' ')
  if find_data_ex(:find_ce,name,event,true).length>0
    disp_ce_card(bot,event,args)
  elsif find_data_ex(:find_servant,name,event,true).length>0
    disp_servant_ce(bot,event,args)
  elsif find_data_ex(:find_ce,name,event).length>0
    disp_ce_card(bot,event,args)
  elsif find_data_ex(:find_servant,name,event).length>0
    disp_servant_ce(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:valentines,:valentine,:valentinesce,:cevalentines,:valentinece,:cevalentine,:chocolate]) do |event, *args|
  return nil if overlap_prevent(event)
  name=args.join(' ')
  if find_data_ex(:find_servant,name,event,true).length>0
    disp_servant_ce2(bot,event,args)
  elsif find_data_ex(:find_servant,name,event).length>0
    disp_servant_ce2(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:command,:commandcode]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_code_data(bot,event,args)
end

bot.command([:code]) do |event, *args|
  return nil if overlap_prevent(event)
  name=args.join(' ')
  if find_data_ex(:find_clothes,name,event,true).length>0
    disp_clothing_data(bot,event,args)
  elsif find_data_ex(:find_code,name,event,true).length>0
    disp_code_data(bot,event,args)
  elsif find_data_ex(:find_clothes,name,event).length>0
    disp_clothing_data(bot,event,args)
  elsif find_data_ex(:find_code,name,event).length>0
    disp_code_data(bot,event,args)
  else
    event.respond "No matches found."
  end
end

bot.command([:mysticcode,:mysticode,:mystic,:clothes,:clothing]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_clothing_data(bot,event,args)
end

bot.command([:bond,:bondce,:bondCE]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_ce(bot,event,args,false,true)
  return nil
end

bot.command([:mats,:ascension,:enhancement,:enhance,:materials]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_servant_mats(bot,event,args)
  return nil
end

bot.command([:mat,:material]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_mat_data(bot,event,args)
  return nil
end

bot.command([:skills,:skils]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  end
  disp_servant_skills(bot,event,args)
  return nil
end

bot.command([:tinystats,:smallstats,:smolstats,:microstats,:squashedstats,:sstats,:statstiny,:statssmall,:statssmol,:statsmicro,:statssquashed,:statss,:stattiny,:statsmall,:statsmol,:statmicro,:statsquashed,:sstat,:tinystat,:smallstat,:smolstat,:microstat,:squashedstat,:tiny,:small,:micro,:smol,:squashed,:littlestats,:littlestat,:statslittle,:statlittle,:little]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_tiny_stats(bot,event,args)
  return nil
end

bot.command([:safe,:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f|
  return nil if overlap_prevent(event)
  f='' if f.nil?
  metadata_load()
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id)
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
  elsif @spam_channels[0].include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      @spam_channels[0].delete(event.channel.id)
      @spam_channels[1].delete(event.channel.id)
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
    @spam_channels[0].push(event.channel.id)
    @spam_channels[1].delete(event.channel.id)
    metadata_save()
    event.respond 'This channel is now marked as safe for me to send long replies to.'
  elsif event.channel.name.downcase.include?('fate') && event.channel.name.downcase.include?('grand') && event.channel.name.downcase.include?('order')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes the words "Fate", "Grand", and "Order".'
  elsif event.channel.name.downcase.include?('fate') && event.channel.name.downcase.include?('go')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes the words "Fate", "GO".'
  elsif event.channel.name.downcase.include?('fgo')
    event.respond 'It is safe for me to send __**certain**__ long replies here because the channel name includes "FGO".'
  elsif @spam_channels[1].include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      @spam_channels[0].delete(event.channel.id)
      @spam_channels[1].delete(event.channel.id)
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
    @spam_channels[0].delete(event.channel.id)
    @spam_channels[1].push(event.channel.id)
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

bot.command([:channellist,:chanelist,:spamchannels,:spamlist]) do |event|
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

bot.command([:bugreport, :suggestion, :feedback]) do |event, *args|
  return nil if overlap_prevent(event)
  bug_report(bot,event,args,4,['Man','Sky','Earth','Star','Beast'],'Attribute',@prefix,502288368777035777)
end

bot.command([:donation, :donate]) do |event, uid|
  return nil if overlap_prevent(event)
  donor_embed(bot,event,"I also do not currently play FGO myself, but would consider it if I had an account with ~~Alice~~ Nursery Rhyme.  She is adorable and I love her.")
end

bot.command(:invite) do |event, user|
  return nil if overlap_prevent(event)
  usr=event.user
  txt="**You can invite me to your server with this link: <https://goo.gl/ox9CxB>**\nTo look at my source code: <https://github.com/Rot8erConeX/LizBot/blob/master/LizBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/MarketingLiz.png"
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
  return nil if overlap_prevent(event)
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
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command(:status, from: 167657750971547648) do |event, *args|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  bot.game=args.join(' ')
  event.respond 'Status set.'
end

bot.command(:backupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  if @aliases[@aliases.length-1].length<=2 || @aliases[@aliases.length-1][2]<nzz[nzz.length-1][2]
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
  return nil if overlap_prevent(event)
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
  return nil if overlap_prevent(event)
  dev_message(bot,event,channel_id)
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user
  return nil if overlap_prevent(event)
  dev_pm(bot,event,user_id)
end

bot.command(:ignoreuser, from: 167657750971547648) do |event, user_id| # causes Liz to ignore the specified user
  return nil if overlap_prevent(event)
  bliss_mode(bot,event,user_id)
end

bot.command(:leaveserver, from: 167657750971547648) do |event, server_id| # forces Liz to leave a server
  return nil if overlap_prevent(event)
  walk_away(bot,event,server_id)
end

bot.command(:cleanupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  event.channel.send_temporary_message('Please wait...',10)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  nicknames_load()
  nmz=@aliases.map{|q| q}
  k=0
  k2=0
  for i in 0...nmz.length
    if nmz[i][3].nil?
      if nmz[i][1]==@servants[@servants.find_index{|q| q[0]==nmz[i][1]}][1].gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','')
        k2+=1
        nmz[i]=nil
      end
    else
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
  open('C:/Users/Mini-Matt/Desktop/devkit/FGONames.txt', 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:snagstats) do |event, f, f2|
  return nil if overlap_prevent(event)
  nicknames_load()
  data_load()
  metadata_load()
  f='' if f.nil?
  f2='' if f2.nil?
  bot.servers.values(&:members)
  k=bot.servers.values.length
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
  elsif ['servant','servants','unit','units','character','characters','chara','charas','char','chars'].include?(f.downcase)
    srv=@servants.reject{|q| q[0]!=q[0].to_i}
    str="**There are #{srv.length} servants, including:**"
    str2="<:class_shielder_gold:523838231913955348> #{srv.reject{|q| q[2]!='Shielder'}.length} Shielder#{'s' if srv.reject{|q| q[2]!='Shielder'}.length>1}"
    str2="#{str2}\n<:class_saber_gold:523838273479507989> #{srv.reject{|q| q[2]!='Saber'}.length} Sabers"
    str2="#{str2}\n<:class_archer_gold:523838461195714576> #{srv.reject{|q| q[2]!='Archer'}.length} Archers"
    str2="#{str2}\n<:class_lancer_gold:523838511485419522> #{srv.reject{|q| q[2]!='Lancer'}.length} Lancers"
    str2="#{str2}\n<:class_rider_gold:523838542577664012> #{srv.reject{|q| q[2]!='Rider'}.length} Riders"
    str2="#{str2}\n<:class_caster_gold:523838570893672473> #{srv.reject{|q| q[2]!='Caster'}.length} Casters"
    str2="#{str2}\n<:class_assassin_gold:523838617693716480> #{srv.reject{|q| q[2]!='Assassin'}.length} Assassins"
    str2="#{str2}\n<:class_berserker_gold:523838648370724897> #{srv.reject{|q| q[2]!='Berserker'}.length} Berserkers"
    str2="#{str2}\n<:class_unknown_gold:523838979825467392> #{srv.reject{|q| ['Saber','Shielder','Archer','Lancer','Rider','Caster','Assassin','Berserker'].include?(q[2])}.length} extra class servants"
    str=extend_message(str,str2,event,2)
    str2="<:FGO_rarity_off:544583775208603688> #{srv.reject{|q| q[3]!=0}.length} no-star servant#{'s' if srv.reject{|q| q[3]!=0}.length>1}"
    str2="#{str2}\n<:FGO_rarity_1:544583775330369566> #{srv.reject{|q| q[3]!=1}.length} one-star servant#{'s' if srv.reject{|q| q[3]!=1}.length>1}"
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{srv.reject{|q| q[3]!=2}.length} two-star servant#{'s' if srv.reject{|q| q[3]!=2}.length>1}"
    str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{srv.reject{|q| q[3]!=3}.length-1}.5 three-star servant#{'s' if srv.reject{|q| q[3]!=3}.length>1}"
    str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{srv.reject{|q| q[3]!=4}.length}.5 four-star servant#{'s' if srv.reject{|q| q[3]!=4}.length>1}"
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{srv.reject{|q| q[3]!=5}.length} five-star servant#{'s' if srv.reject{|q| q[3]!=5}.length>1}"
    str=extend_message(str,str2,event,2)
    str2="#{srv.reject{|q| q[12]!='Man'}.length} servants with the Man attribute"
    str2="#{str2}\n#{srv.reject{|q| q[12]!='Sky'}.length} servants with the Sky attribute"
    str2="#{str2}\n#{srv.reject{|q| q[12]!='Earth'}.length} servants with the Earth attribute"
    str2="#{str2}\n#{srv.reject{|q| q[12]!='Star'}.length} servants with the Star attribute"
    str2="#{str2}\n#{srv.reject{|q| q[12]!='Beast'}.length} servants with the Beast attribute"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2="#{srv.reject{|q| q[4]!='Linear'}.length} servants with Linear growth curves"
      str2="#{str2}\n#{srv.reject{|q| q[4]!='S'}.length} servants with S growth curves"
      str2="#{str2}\n#{srv.reject{|q| q[4]!='Reverse S'}.length} servants with Reverse S growth curves"
      str2="#{str2}\n#{srv.reject{|q| q[4]!='Semi S'}.length} servants with Semi S growth curves"
      str2="#{str2}\n#{srv.reject{|q| q[4]!='Semi Reverse S'}.length} servants with Semi Reverse S growth curves"
      m=srv.reject{|q| ['Linear','S','Reverse S','Semi S','Semi Reverse S'].include?(q[4])}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with unknown growth curves" unless m.length<=0
      str=extend_message(str,str2,event,2)
      str2="#{srv.reject{|q| q[17][0,5]!='QQQAB'}.length} servants with triple-Quick decks."
      str2="#{str2}\n#{srv.reject{|q| q[17][0,5]!='QQAAB'}.length} servants with double-Quick/double-Arts decks."
      str2="#{str2}\n#{srv.reject{|q| q[17][0,5]!='QQABB'}.length} servants with double-Quick/double-Buster decks."
      str2="#{str2}\n#{srv.reject{|q| q[17][0,5]!='QAAAB'}.length} servants with triple-Arts decks."
      str2="#{str2}\n#{srv.reject{|q| q[17][0,5]!='QAABB'}.length} servants with double-Arts/double-Buster decks."
      str2="#{str2}\n#{srv.reject{|q| q[17][0,5]!='QABBB'}.length} servants with triple-Buster decks."
      str=extend_message(str,str2,event,2)
      str2="#{srv.reject{|q| q[17][6,1]!='Q'}.length} servants with Quick Noble Phantasms."
      str2="#{str2}\n#{srv.reject{|q| q[17][6,1]!='A'}.length} servants with Arts Noble Phantasms."
      str2="#{str2}\n#{srv.reject{|q| q[17][6,1]!='B'}.length} servants with Buster Noble Phantasms."
      m=srv.reject{|q| ['Q','A','B'].include?(q[17][6,1])}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with no Noble Phantasm." unless m.length<=0
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['ce','craft','essance','craftessance','ces','crafts','essances','craftessances'].include?(f.downcase)
    crf=@crafts.map{|q| q}
    srv=@servants.map{|q| q}
    str="**There are #{crf.length} Craft Essences, including:**"
    str2="<:FGO_rarity_1:544583775330369566> #{crf.reject{|q| q[2]!=1}.length} one-star CE#{'s' if crf.reject{|q| q[2]!=1}.length>1}"
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{crf.reject{|q| q[2]!=2}.length} two-star CE#{'s' if crf.reject{|q| q[2]!=2}.length>1}"
    str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{crf.reject{|q| q[2]!=3}.length} three-star CE#{'s' if crf.reject{|q| q[2]!=3}.length>1}"
    str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{crf.reject{|q| q[2]!=4}.length} four-star CE#{'s' if crf.reject{|q| q[2]!=4}.length>1}"
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{crf.reject{|q| q[2]!=5}.length} five-star CE#{'s' if crf.reject{|q| q[2]!=5}.length>1}"
    str=extend_message(str,str2,event,2)
    c=crf.map{|q| q[0].to_i}
    m=srv.map{|q| q[23]}.join(', ').split(', ').map{|q| q.to_i}.reject{|q| q<c.min || q>c.max}.uniq
    str2="<:Bond:523903660913197056> #{m.length} Bond CE#{'s' if m.length>1}"
    m=srv.map{|q| q[26]}.join(', ').split(', ').map{|q| q.to_i}.reject{|q| q<c.min || q>c.max}.uniq
    str2="#{str2}\n<:Valentines:523903633453219852> #{m.length} Valentine's CE#{'s' if m.length>1}"
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['command','commandcode','commands','commandcodes'].include?(f.downcase)
    crf=@codes.map{|q| q}
    str="**There are #{crf.length} Command Codes, including:**"
    str2="<:FGO_rarity_1:544583775330369566> #{crf.reject{|q| q[2]!=1}.length} one-star Command Code#{'s' if crf.reject{|q| q[2]!=1}.length>1}"
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{crf.reject{|q| q[2]!=2}.length} two-star Command Code#{'s' if crf.reject{|q| q[2]!=2}.length>1}"
    str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{crf.reject{|q| q[2]!=3}.length} three-star Command Code#{'s' if crf.reject{|q| q[2]!=3}.length>1}"
    str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{crf.reject{|q| q[2]!=4}.length} four-star Command Code#{'s' if crf.reject{|q| q[2]!=4}.length>1}"
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{crf.reject{|q| q[2]!=5}.length} five-star Command Code#{'s' if crf.reject{|q| q[2]!=5}.length>1}"
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    b=[[],[],[],[],[]]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb').each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[3].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    File.open('C:/Users/Mini-Matt/Desktop/devkit/rot8er_functs.rb').each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[3].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**I rely on a library that is #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/rot8er_functs.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[2].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, it appears to be #{longFormattedNumber(b[4].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command('}.length)} commands, invoked with #{longFormattedNumber(all_commands().length)} different phrases.**"
    event << 'This includes:'
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
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
    glbl=@aliases.reject{|q| q[0]!='Servant' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Servant' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    all_units=@servants.map{|q| [q[0],q[1],0,0]}
    for j in 0...all_units.length
      all_units[j][2]+=glbl.reject{|q| q[1]!=all_units[j][0]}.length
      all_units[j][3]+=srv_spec.reject{|q| q[1]!=all_units[j][0]}.length
    end
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event)
    str="**There are #{longFormattedNumber(glbl.length)} global servant aliases.**\nThe servant#{"s" unless k.length==1} with the most global aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[2]}.max} global aliases#{" each" unless k.length==1}."
    k=all_units.reject{|q| q[2]>0}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[2]>0}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event) 
    str="#{str}\nThe following servant#{"s" unless k.length==1} have no global aliases: #{list_lift(k,"and")}." if k.length>0
    str2="**There are #{longFormattedNumber(srv_spec.length)} server-specific servant aliases.**"
    if event.server.nil? && @shardizard==4
      str2="#{str2}\nDue to being the debug version, I cannot show more information."
    elsif event.server.nil?
      str2="#{str2}\nServers you and I share account for #{@aliases.reject{|q| q[0]!='Servant' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{@aliases.reject{|q| q[0]!='Servant' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| "*#{q[1]}* [##{q[0]}]"}
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| "##{q[0]}"} if k.length>8 && !safe_to_spam?(event)
    str2="#{str2}\nThe servant#{"s" unless k.length==1} with the most server-specific aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[3]}.max} server-specific aliases#{" each" unless k.length==1}."
    k=srv_spec.map{|q| q[2].length}.inject(0){|sum,x| sum + x }
    str2="#{str2}\nCounting each alias/server combo as a unique alias, there are #{longFormattedNumber(k)} server-specific aliases"
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global skill aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific skill aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Craft' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Craft' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Craft Essance aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Craft Essance aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Craft' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Craft' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Material' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Material' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length+77)} global material aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific material aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Clothes' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Clothes' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Mystic Code (clothing) aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Mystic Code (clothing) aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Clothes' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Clothes' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Command' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Command' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Command Code aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Command Code aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Command' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Command' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
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
  glbl=@aliases.reject{|q| q[0]!='Servant' || !q[3].nil?}
  srv_spec=@aliases.reject{|q| q[0]!='Servant' || q[3].nil?}
  b=[]
  File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb').each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} *servers*, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
  event << "This shard is in #{longFormattedNumber(@server_data[0][@shardizard])} server#{"s" unless @server_data[0][@shardizard]==1}, reaching #{longFormattedNumber(bot.users.size)} unique members."
  event << ''
  event << "**There are #{longFormattedNumber(@servants.length)} *servants*.**"
  event << "There are also #{longFormattedNumber(@enemies.length)} non-servant enemy types."
  event << ''
  event << "**There are #{longFormattedNumber(@skills.length)} skills.**"
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Skill'}.length)} active skills, split into #{longFormattedNumber(@skills.reject{|q| q[2]!='Skill'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Passive'}.length)} passive skills, split into #{longFormattedNumber(@skills.reject{|q| q[2]!='Passive'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Clothes'}.length)} clothing skills."
  event << "There are #{longFormattedNumber(@skills.reject{|q| q[2]!='Noble'}.length)} Noble Phantasms."
  event << ''
  event << "**There are #{longFormattedNumber(@crafts.length)} *Craft Essences*.**"
  event << ''
  event << "There are #{longFormattedNumber(@clothes.length)} Mystic Codes."
  event << "There are #{longFormattedNumber(@codes.length)} *Command Codes*."
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end

def disp_date(t,mode=0)
  return "#{t.day}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][t.month]}#{t.year}" if mode==2
  return "#{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year}" if mode==1
  return "#{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
end

bot.command([:today,:now,:todayinfgo,:todayinFGO,:todayInFGO,:today_in_fgo,:today_in_FGO]) do |event, *args|
  return nil if overlap_prevent(event)
  show_next(bot,event,args,true)
end

bot.command([:tomorrow,:tommorrow,:tomorow,:tommorrow]) do |event, *args|
  return nil if overlap_prevent(event)
  show_next(bot,event,args,-1)
end

bot.command([:dailies,:daily]) do |event, *args|
  return nil if overlap_prevent(event)
  show_next(bot,event,args)
end

bot.command([:next,:schedule]) do |event|
  return nil if overlap_prevent(event)
  show_next_2(bot,event)
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
  if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) && @shardizard==4
    (chn.send_message(get_debug_leave_message()) rescue nil)
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
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    if ['skill','skills','skil','skils'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args)
    else
      find_servants(bot,event,args)
    end
    m=false
  elsif ['sort','list'].include?(args[0].downcase)
    args.shift
    sort_servants(bot,event,args)
    m=false
  elsif ['xp','exp','level'].include?(args[0].downcase)
    args.shift
    level(event,bot,args)
    m=false
  elsif ['pxp','pexp','plxp','plexp','plevel','pllevel','sxp','sexp','slevel','cxp','cexp','ceexp','clevel','celevel'].include?(args[0].downcase)
    level(event,bot,args)
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
    if ['find','search'].include?(args[0].downcase)
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
    else
      disp_skill_sata(bot,event,args)
    end
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
  elsif ['mat','material'].include?(args[0])
    args.shift
    disp_mat_data(bot,event,args)
    m=false
  elsif ['command','commandcode'].include?(args[0])
    args.shift
    disp_code_data(bot,event,args)
    m=false
  elsif ['mysticcode','mysticode','mystic','clothing','clothes'].include?(args[0])
    args.shift
    disp_clothing_data(bot,event,args)
    m=false
  elsif ['art','artist'].include?(args[0])
    event.channel.send_temporary_message('Calculating data, please wait...',1)
    if find_data_ex(:find_servant,args.join(' '),event,true).length>0
      disp_servant_art(bot,event,args)
    elsif find_data_ex(:find_ce,args.join(' '),event,true).length>0
      disp_ce_art(bot,event,args)
    elsif find_data_ex(:find_servant,args.join(' '),event).length>0
      disp_servant_art(bot,event,args)
    elsif find_data_ex(:find_ce,args.join(' '),event).length>0
      disp_ce_art(bot,event,args)
    else
      event.respond "No matches found."
    end
    m=false
  elsif ['code'].include?(args[0])
    args.shift
    if find_data_ex(:find_clothes,args.join(' '),event,true).length>0
      disp_clothing_data(bot,event,args)
    elsif find_data_ex(:find_code,args.join(' '),event,true).length>0
      disp_code_data(bot,event,args)
    elsif find_data_ex(:find_clothes,args.join(' '),event).length>0
      disp_clothing_data(bot,event,args)
    elsif find_data_ex(:find_code,args.join(' '),event).length>0
      disp_code_data(bot,event,args)
    else
      event.respond "No matches found."
    end
    m=false
  elsif ['tinystats','smallstats','smolstats','microstats','squashedstats','sstats','statstiny','statssmall','statssmol','statsmicro','statssquashed','statss','stattiny','statsmall','statsmol','statmicro','statsquashed','sstat','tinystat','smallstat','smolstat','microstat','squashedstat','tiny','small','micro','smol','squashed','littlestats','littlestat','statslittle','statlittle','little'].include?(args[0])
    args.shift
    disp_tiny_stats(bot,event,args)
    m=false
  elsif ['valentines','valentine','chocolate',"valentine's"].include?(args[0])
    args.shift
    disp_servant_ce2(bot,event,args)
    m=false
  elsif ['ce','craft','essance','craftessance'].include?(args[0])
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args,true)
    elsif ['valentines','valentine','chocolate',"valentine's"].include?(args[0])
      args.shift
      disp_servant_ce2(bot,event,args)
    elsif find_data_ex(:find_ce,args.join(' '),event,true).length>0
      disp_ce_card(bot,event,args)
    elsif find_data_ex(:find_servant,args.join(' '),event,true).length>0
      disp_servant_ce(bot,event,args)
    elsif find_data_ex(:find_ce,args.join(' '),event).length>0
      disp_ce_card(bot,event,args)
    elsif find_data_ex(:find_servant,args.join(' '),event).length>0
      disp_servant_ce(bot,event,args)
    else
      event.respond "No matches found."
    end
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
  end
  if m
    if find_data_ex(:find_ce,name,event,true).length>0
      disp_ce_card(bot,event,args)
    elsif find_data_ex(:find_servant,name,event,true).length>0
      disp_servant_stats(bot,event,args)
      disp_servant_skills(bot,event,args,true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,args,true)
        disp_servant_np(bot,event,args,true)
        disp_servant_ce(bot,event,args,true,true)
        disp_servant_mats(bot,event,args,true)
      end
    elsif find_data_ex(:find_skill,name,event,true).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_clothes,name,event,true).length>0
      disp_clothing_data(bot,event,args)
    elsif find_data_ex(:find_code,name,event,true).length>0
      disp_code_data(bot,event,args)
    elsif find_data_ex(:find_enemy,name,event,true).length>0
      disp_enemy_traits(bot,event,args)
    elsif find_data_ex(:find_mat,name,event,true).length>0
      disp_mat_data(bot,event,args)
    elsif find_data_ex(:find_ce,name,event).length>0
      disp_ce_card(bot,event,args)
    elsif find_data_ex(:find_servant,name,event).length>0
      disp_servant_stats(bot,event,args)
      disp_servant_skills(bot,event,args,true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,args,true)
        disp_servant_np(bot,event,args,true)
        disp_servant_ce(bot,event,args,true,true)
        disp_servant_mats(bot,event,args,true)
      end
    elsif find_data_ex(:find_skill,name,event).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_clothes,name,event).length>0
      disp_clothing_data(bot,event,args)
    elsif find_data_ex(:find_code,name,event).length>0
      disp_code_data(bot,event,args)
    elsif find_data_ex(:find_mat,name,event).length>0
      disp_mat_data(bot,event,args)
    elsif find_data_ex(:find_enemy,name,event).length>0
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
  str="#{s}"
  if @shardizard==4 && (['fea!','fef!'].include?(str[0,4]) || ['fe13!','fe14!'].include?(str[0,5]) || ['fe!'].include?(str[0,3]))
    str=str[4,str.length-4] if ['fea!','fef!'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!'].include?(str[0,3])
    a=str.split(' ')
    if a[0].downcase=='reboot'
      event.respond 'Becoming Robin.  Please wait approximately ten seconds...'
      exec 'cd C:/Users/Mini-Matt/Desktop/devkit && feindex.rb 4'
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond 'I am not Robin right now.  Please use `FE!reboot` to turn me into Robin.'
    end
  elsif (['feh!','feh?'].include?(str[0,4]) || ['f?','e?','h?'].include?(str[0,2])) && @shardizard==4
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['f?','e?','h?'].include?(event.message.text.downcase[0,2])
    s=s[4,s.length-4] if ['feh!','feh?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Elise.  Please wait approximately ten seconds..."
      exec "cd C:/Users/Mini-Matt/Desktop/devkit && PriscillaBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Elise right now.  Please use `FEH!reboot` to turn me into Elise."
    end
  elsif ['dl!','dl?'].include?(str[0,3]) && @shardizard==4
    s=event.message.text.downcase
    s=s[3,s.length-3]
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Botan.  Please wait approximately ten seconds..."
      exec "cd C:/Users/Mini-Matt/Desktop/devkit && BotanBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Botan right now.  Please use `DL!reboot` to turn me into Botan."
    end
  elsif (['!weak '].include?(str[0,6]) || ['!weakness '].include?(str[0,10]))
    if event.server.nil? || event.server.id==264445053596991498
    elsif !bot.user(304652483299377182).on(event.server.id).nil? # Robin
    elsif !bot.user(543373018303299585).on(event.server.id).nil? # Botan
    elsif !bot.user(206147275775279104).on(event.server.id).nil? || @shardizard==4 || event.server.id==330850148261298176 # Pokedex
      triple_weakness(bot,event)
    end
  elsif overlap_prevent(event)
  elsif m && !all_commands().include?(s.split(' ')[0])
    if find_data_ex(:find_ce,s,event,true).length>0
      disp_ce_card(bot,event,s.split(' '))
    elsif find_data_ex(:find_servant,s,event,true).length>0
      disp_servant_stats(bot,event,s.split(' '))
      disp_servant_skills(bot,event,s.split(' '),true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,s.split(' '),true)
        disp_servant_np(bot,event,s.split(' '),true)
        disp_servant_ce(bot,event,s.split(' '),true,true)
        disp_servant_mats(bot,event,s.split(' '),true)
      end
    elsif find_data_ex(:find_skill,s,event,true).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_clothes,s,event,true).length>0
      disp_clothing_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_code,s,event,true).length>0
      disp_code_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_mat,s,event,true).length>0
      disp_mat_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_enemy,s,event,true).length>0
      disp_enemy_traits(bot,event,s.split(' '))
    elsif find_data_ex(:find_ce,s,event).length>0
      disp_ce_card(bot,event,s.split(' '))
    elsif find_data_ex(:find_servant,s,event).length>0
      disp_servant_stats(bot,event,s.split(' '))
      disp_servant_skills(bot,event,s.split(' '),true)
      if safe_to_spam?(event)
        disp_servant_traits(bot,event,s.split(' '),true)
        disp_servant_np(bot,event,s.split(' '),true)
        disp_servant_ce(bot,event,s.split(' '),true,true)
        disp_servant_mats(bot,event,s.split(' '),true)
      end
    elsif find_data_ex(:find_skill,s,event).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_clothes,s,event).length>0
      disp_clothing_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_code,s,event).length>0
      disp_code_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_mat,s,event).length>0
      disp_mat_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_enemy,s,event).length>0
      disp_enemy_traits(bot,event,s.split(' '))
    end
  elsif event.message.text.include?('0x4') && !event.user.bot_account? && @shardizard==4
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
  holidays=[]
  d=get_donor_list()
  d=d.reject{|q| q[2]<2}
  for i in 0...d.length
    if d[i][4][1]!='-'
      holidays.push([0,d[i][3][0],d[i][3][1],d[i][4][1],"in recognition of #{bot.user(d[i][0]).distinct}","Donator's birthday"])
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
  if k.length<=0
    t=Time.now
    t-=60*60*6
    bot.game='Fate/Grand Order'
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.png','r')) rescue nil if @shardizard.zero?
    @avvie_info=['Liz','*Fate/Grand Order*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  elsif t.year==k[0][0] && t.month==k[0][1] && t.day==k[0][2]
    if k.length==1
      # Only one holiday is today.  Display new avatar, and set another check for midnight
      bot.game=k[0][4]
      if @shardizard.zero?
        bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/EliseImages/#{k[0][3]}.png",'r')) rescue nil
      end
      @avvie_info=[k[0][3],k[0][4],k[0][5]]
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
        if @shardizard.zero?
          bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/LizImages/#{k[k.length-1][3]}.png",'r')) rescue nil
        end
        @avvie_info=[k[k.length-1][3],k[k.length-1][4],k[k.length-1][5]]
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
        if @shardizard.zero?
          bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/LizImages/#{k[j][3]}.png",'r')) rescue nil
        end
        @avvie_info=[k[j][3],k[j][4],k[j][5]]
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
    bot.game='Fate/Grand Order'
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/LizBot.png','r')) rescue nil if @shardizard.zero?
    @avvie_info=['Liz','*Fate/Grand Order*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  end
end

bot.ready do |event|
  if @shardizard==4
    for i in 0...bot.servers.values.length
      if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(bot.servers.values[i].id)
        bot.servers.values[i].general_channel.send_message(get_debug_leave_message()) rescue nil
        bot.servers.values[i].leave
      end
    end
  end
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
  if @shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='LizBot (Debug)'
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/DebugLiz.png','r'))
  else
    next_holiday(bot)
  end
end

bot.run
