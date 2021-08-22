def help_text(event,bot,command=nil,subcommand=nil,args=[])
  command='' if command.nil?
  subcommand='' if subcommand.nil?
  k=0
  k=event.server.id unless event.server.nil?
  if ['help','command_list','commandlist'].include?(command.downcase)
    event.respond "The `#{command.downcase}` command displays this message:"
    command=''
  end
  if command.downcase=='reboot'
    create_embed(event,'**reboot**',"Reboots this shard of the bot, installing any updates.\n\n**This command is only able to be used by Rot8er_ConeX**",0x008b8b)
  elsif ['support','supports','profile','friend','friends'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __user__","Shows `user`'s stored Support lineup.\n\nAccepts either a user mention or user ID as input.\nIf no valid user is provided, uses the user who invoked the command as input.",0xED619A)
  elsif ['reload'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Reloads specified data.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['update'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Shows my data input person how to remotely update for during the period where my developer is gone.',0xED619A)
  elsif ['devedit','dev_edit'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    subcommand2=args[0]
    subcommand2='' if subcommand2.nil?
    if has_any?([subcommand.downcase,subcommand2.downcase],['ce','craft','craftessence']) && has_any?([subcommand.downcase,subcommand2.downcase],['support','supports','friends','friend'])
      create_embed(event,"**#{command.downcase} #{subcommand.downcase} #{subcommand2.downcase}** __slot__ __craft__","Causes me to equip the Craft Essence with the name `craft` to the support slot `slot`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['create'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Allows me to create a new devservant with the character `servant`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['fou','fous'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __stat__ __value__","Causes me to apply Fous to the devservant with the name `servant`.\n`stat` can be either HP/Health or Attack/Atk.\n`value` will be added to the pre-existing stats for the devservant, for a maximum of 2000 total per stat.\n\nIf no stat is defined, this command will fail.\nIf no value is defined, the stat will default to applying 10, the minimum amount applicable at once in-game.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the skill level of one of the skills belonging to the devservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the skill instead.\nYou can also include the word \"reset\" to reset the skill level to 0 (or 1 if S1).\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the skill level of one of the Append skills belonging to the devservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the skill instead.\nYou can also include the word \"reset\" to reset the skill level to 0.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['np','merge','merges'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the Noble Phantasm level of one of the skills belonging to the devservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the NP instead.\nYou can also include the word \"reset\" to reset the NP level to NP1.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['ce','craft','craftessence'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __craft__","Causes me to equip the Craft Essence with the name `craft` to the devservant with the name `servant`.\nYou can include the word \"bond\" to automatically equip the servant's Bond CE, but only if their bond level is high enough.\nYou can also include the word \"none\" to de-equip their CE.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['bond'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the bond level of one of the skills belonging to the devservant with the name `servant`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['ascension','ascend'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the ascension level of one of the skills belonging to the devservant with the name `servant`.\nIf the devservant's art is the default art for their ascension, I will change it to the new ascension's default as well.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['art'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to art used for the devservant with the name `servant`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['upgrade','interlude','rankup','rank','up'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __upgrade target__","Causes me to upgrade either one of the skills, or the NP, of the devservant with the name `servant`.\nWhat is upgraded must be defined.\n\nIf nothing is defined, and the devservant is Mash Kyrielight, this subcommand can be used to transition between her three forms (Upgrading to Camelot, and then toggling between that and Orthenaus).\nOther devservants will fail if nothing to be upgraded is defined.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['grail','gold','silver'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to grailshift the devservant with the name `servant`.\n\nThis can only be used on devservants who have reached their Final Ascension.\nIt can also only be used on devservants who are not yet already gold.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['burn','delete'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to delete the devservant with the name `servant`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['command','code','deck'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __slot__ __code__","Causes me to equip the Command Code with the name `code` to the deck slot `slot` of the devservant with the name `servant`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    elsif ['support','supports','friend','friends'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to edit your support lineup to add the devservant with the name `servant` in the appropriate slot based on their class.\nIf you include the word \"all\", the devservant will be placed in your All slot instead.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    else
      create_embed(event,"**#{command.downcase}** __subcommand__ __servant__ __\*effects__","Allows me to create and edit the devservants.\n\nAvailable subcommands include:\n`FGO!#{command.downcase} create` - creates a new devservant\n`FGO!#{command.downcase} fou` - applies fous to an existing devservant's HP or Atk\n`FGO!#{command.downcase} skill` - increases a devservant's skill\n`FGO!#{command.downcase} np` - increases a devservant's NP *(also `merge`)*\n`FGO!#{command.downcase} ce` - equips a CE to a devservant\n`FGO!#{command.downcase} bond` - increases a devservant's bond level\n`FGO!#{command.downcase} ascension` - ascends a devservant\n`FGO!#{command.downcase} art` - changes which art gets displayed for a devservant\n`FGO!#{command.downcase} upgrade` - upgrades a devservant's skill or NP\n`FGO!#{command.downcase} code` - gives a devservant a Command Code\n`FGO!#{command.downcase} support` - edits the dev's support lineup\n`FGO!#{command.downcase} grail` - grailshifts a devservant\n`FGO!#{command.downcase} burn` - burns a devservant *(also `delete`)*\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
    end
  elsif ['edit'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    subcommand2=args[0]
    subcommand2='' if subcommand2.nil?
    if has_any?([subcommand.downcase,subcommand2.downcase],['ce','craft','craftessence']) && has_any?([subcommand.downcase,subcommand2.downcase],['support','supports','friends','friend'])
      create_embed(event,"**#{command.downcase} #{subcommand.downcase} #{subcommand2.downcase}** __slot__ __craft__","Causes me to equip the Craft Essence with the name `craft` to the support slot `slot`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['create'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Allows me to create a new donorservant with the character `servant`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['fou','fous'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __stat__ __value__","Causes me to apply Fous to the donorservant with the name `servant`.\n`stat` can be either HP/Health or Attack/Atk.\n`value` will be added to the pre-existing stats for the donorservant, for a maximum of 2000 total per stat.\n\nIf no stat is defined, this command will fail.\nIf no value is defined, the stat will default to applying 10, the minimum amount applicable at once in-game.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the skill level of one of the skills belonging to the donorservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the skill instead.\nYou can also include the word \"reset\" to reset the skill level to 0 (or 1 if S1).\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the skill level of one of the Append skills belonging to the donorservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the skill instead.\nYou can also include the word \"reset\" to reset the skill level to 0.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['np','merge','merges'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the Noble Phantasm level of one of the skills belonging to the donorservant with the name `servant`.\nYou can include the word \"upgrade\" to upgrade the NP instead.\nYou can also include the word \"reset\" to reset the NP level to NP1.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['ce','craft','craftessence'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to equip a Craft Essence to the donorservant with the name `servant`.\nYou can include the word \"bond\" to automatically equip the servant's Bond CE, but only if their bond level is high enough.\nYou can also include the word \"none\" to de-equip their CE.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['bond'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the bond level of one of the skills belonging to the donorservant with the name `servant`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['ascension','ascend'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to increase the ascension level of one of the skills belonging to the donorservant with the name `servant`.\nIf the donorservant's art is the default art for their ascension, I will change it to the new ascension's default as well.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['art'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to art used for the donorservant with the name `servant`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['upgrade','interlude','rankup','rank','up'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __upgrade target__","Causes me to upgrade either one of the skills, or the NP, of the donorservant with the name `servant`.\nWhat is upgraded must be defined.\n\nIf nothing is defined, and the donorservant is Mash Kyrielight, this subcommand can be used to transition between her three forms (Upgrading to Camelot, and then toggling between that and Orthenaus).\nOther donorservants will fail if nothing to be upgraded is defined.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['grail','gold','silver'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to grailshift the donorservant with the name `servant`.\n\nThis can only be used on donorservants who have reached their Final Ascension.\nIt can also only be used on donorservants who are not yet already gold.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['burn','delete'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to delete the donorservant with the name `servant`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['command','code','deck'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__ __slot__ __code__","Causes me to equip the Command Code with the name `code` to the deck slot `slot` of the devservant with the name `servant`.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    elsif ['support','supports','friend','friends'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __servant__","Causes me to edit your support lineup to add the donorservant with the name `servant` in the appropriate slot based on their class.\nIf you include the word \"all\", the donorservant will be placed in your All slot instead.\n\n**This command is only able to be used by certain people**.",0x9E682C)
    else
      create_embed(event,"**#{command.downcase}** __subcommand__ __servant__ __\*effects__","Allows me to create and edit the donorservants.\n\nAvailable subcommands include:\n`FGO!#{command.downcase} create` - creates a new donorservant\n`FGO!#{command.downcase} fou` - applies fous to an existing donorservant's HP or Atk\n`FGO!#{command.downcase} skill` - increases a donorservant's skill\n`FGO!#{command.downcase} np` - increases a donorservant's NP *(also `merge`)*\n`FGO!#{command.downcase} ce` - equips a CE to a donorservant\n`FGO!#{command.downcase} bond` - increases a donorservant's bond level\n`FGO!#{command.downcase} ascension` - ascends a donorservant\n`FGO!#{command.downcase} art` - changes which art gets displayed for a donorservant\n`FGO!#{command.downcase} upgrade` - upgrades a donorservant's skill or NP\n`FGO!#{command.downcase} code` - gives a donorservant a Command Code\n`FGO!#{command.downcase} grail` - grailshifts a donorservant\n`FGO!#{command.downcase} support` - edits the donor's support lineup\n`FGO!#{command.downcase} burn` - burns a donorservant *(also `delete`)*\n\n**This command is only able to be used by certain people**.",0x9E682C)
    end
  elsif command.downcase=='prefix'
    create_embed(event,'**prefix** __new prefix__',"Sets the server's custom prefix to `prefix`.\n\n**This command can only be used by server mods.**",0xC31C19)
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
  elsif ['status','avatar','avvie'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows my current avatar, status, and reason for such.\n\nWhen used by my developer with a message following it, sets my status to that message.",0xED619A)
  elsif ['alts','alt'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__",'Responds with a list of alts that the character has in *Fate/Grand Order*.',0xED619A)
  elsif ['rand','random'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Generates a random servant with random, but still valid, class, deck, and subdata.',0xED619A)
  elsif ['today','todayinfgo','today_in_fgo','now'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the day's in-game daily events.\nIf in PM, will also show tomorrow's.",0xED619A)
  elsif ['tomorrow','tommorrow','tommorow','tomorow'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the next day's in-game daily events.",0xED619A)
  elsif ['daily','dailies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the day's in-game daily events.\nIf in PM, will also show tomorrow's.\n\nYou can also show include the word \"tomorrow\" to force the next day's data.\nYou can also include a day of the week and force that to show instead.",0xED619A)
  elsif ['next','schedule'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __type__","Shows the next time in-game daily events of the type `type` will happen.\nIf in PM and `type` is unspecified, shows the entire schedule.\n\n__*Accepted Inputs*__\nTraining / Ground(s)\nEmber(s) / Gather(ing)\nMat(s) / Material(s) ~~this one only works fully in PM.~~",0xED619A)
  elsif ['affinity','affinities','affinitys','effective','eff','resist','resistance','resistances','res'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __class__","Shows the given class's affinities with other classes.\nIf no class is given, tries to find a servant name instead and uses their class as input.\nIf neither a class nor a servant is given, shows default affinities.",0xED619A)
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
  elsif ['np','np1','np2','np3','np4','np5','noble','phantasm','noblephantasm'].include?(command.downcase)
    command='np' if ['np1','np2','np3','np4','np5'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Noble Phantasm.\n\nIf it is not safe to spam, I will show the effects for only the default NP level, and it can be adjusted to show other NP levels based on included arguments in the format \"NP#{rand(5)+1}\"\nIf it is safe to spam, I will show all the effects naturally.",0xED619A)
  elsif ['bond','bondce'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Bond CE.",0xED619A)
  elsif ['art','artist'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s art.\n\nDefaults to their normal art, but can be modified to other arts based on the following words:\nFirst/1st/FirstAscension/1stAscension\nSecond/2nd/SecondAscension/2ndAscension\nThird/3rd/ThirdAscension/3rdAscension\nFinal/Fourth/4th/FinalAscension/FourthAscension/4thAscension\nCostume/FirstCostume/1stCostume/Costume1\nSecondCostume/2ndCostume/Costume2\nRiyo/AprilFool's\n\nIf the requested art doesn't exist, reverts back to default art.",0xED619A)
  elsif ['riyo'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s Riyo art, which is shown on April Fool's.",0xED619A)
  elsif ['ce','craft','essence','essance','craftessance','craftessence'].include?(command.downcase)
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
    unless $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
      event << ''
      event << 'This help window is not in an embed so that people who need this command can see it.'
    end
    return nil
  elsif ['find','search','lookup'].include?(command.downcase)
    lookout=[]
    if File.exist?("#{$location}devkit/FGOSkillSubsets.txt")
      lookout=[]
      File.open("#{$location}devkit/FGOSkillSubsets.txt").each_line do |line|
        lookout.push(eval line)
      end
    end
    str='Skill tags'
    if ['skill','skills','skil','skils'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all skills and CE effects that fit `filters`.\n\nYou can search by:\n- Skill type (Active, Passive, CE, Clothing, NP)\n- Effect tag#{' (seen below)' if safe_to_spam?(event)}\n\nIf too many skills and/or CEs are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
      lookout=lookout.reject{|q| q[2]!='Skill'}.map{|q| q[0]}
    elsif ['ce','ces','craft','crafts','essence','essences'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays CEs effects that fit `filters`.\n\nYour search options can be #{'seen below' if safe_to_spam?(event)}#{'shown if you repeat this command in PM' unless safe_to_spam?(event)}\n\nIf too many CEs are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
      lookout=lookout.reject{|q| q[2]!='Skill'}.map{|q| q[0]}
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all servants that fit `filters`.\n\nYou can search by:\n- Class\n- Growth Curve\n- Rarity\n- Attribute\n- Traits\n- Command Deck\n- Noble Phantasm card type\n- Noble Phantasm target(s)\n- Availability\n- Alignment\n\nIf too many servants are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xED619A)
      lookout=lookout.reject{|q| q[2]!='Servant'}.map{|q| q[0]}
      str='Servant traits'
    end
    if safe_to_spam?(event)
      if lookout.join("\n").length>=1900
        str=lookout[0]
        for i in 1...lookout.length
          str=extend_message(str,lookout[i],event,1,',  ')
        end
        event.respond str
      else
        create_embed(event,str,'',0x40C0F0,nil,nil,triple_finish(lookout)) if safe_to_spam?(event)
      end
    end
  elsif ['sort','list'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*filters__","Sorts all servants that fit `filters`.\n\nYou can search by:\n- Class\n- Growth Curve\n- Rarity\n- Attribute\n- Traits\n- Command Deck\n- Noble Phantasm card type\n- Noble Phantasm target(s)\n- Availability\n- Alignment\n\nYou can sort by:\n- HP\n- Atk\n\nYou can adjust the level sorted by using the following words:\n- Base\n- Max\n- Grail\n\nIf too many servants are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xED619A)
  elsif ['deck'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*list of servants__","Shows all listed servants' decks, and then calculates how likely it is for the combined deck to generate a hand with each type of chain.",0xED619A)
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
    elsif ['ce','craft','essance','essence','craftessance','craftessence','ces','crafts','essances','essences','craftessances','craftessences'].include?(subcommand.downcase)
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
    str="#{str}\n\n`alts` __name__ - displays a character's alts"
    str="#{str}\n\n__**Other data**__"
    str="#{str}\n`ce` __name__ - displays data for a Craft Essence"
    str="#{str}\n`commandcode` __name__ - displays data for a Command Code"
    str="#{str}\n`mysticcode` __name__ - displays data for a Mystic Code (*also `clothing` or `clothes`*)"
    str="#{str}\n`skill` __name__ - displays a skill's effects"
    str="#{str}\n`mat` __name__ - displays a material (*also `material`*)"
    str="#{str}\n`affinity` __name__ - displays class affinities (*also `effective`*)"
    str="#{str}\n`find` __\*filters__ - search for servants (*also `search`*)"
    str="#{str}\n`sort` __\*filters__ - sort servants by HP or Atk (*also `list`*)"
    str="#{str}\n`deck` __\*servant list__ - to calculate deck probabilities"
    str="#{str}\n`today` - to see today's events (*also `daily` or `todayInFGO`*)"
    str="#{str}\n`next` - to see when cyclical events happen next"
    create_embed([event,x],"Global Command Prefixes: `FGO!` `FGO?` `Liz!` `Liz?` `Fate!` `Fate?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n__**Liz Bot help**__",str,0xED619A)
    str="__**Meta Data**__"
    str="#{str}\n`invite` - for a link to invite me to your server"
    str="#{str}\n`tools` - for a list of tools aside from me that may aid you"
    str="#{str}\n`snagstats` __type__ - to receive relevant bot stats"
    str="#{str}\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n`shard` (*also `attribute`*)"
    str="#{str}\n\n`random` - generates a random servant (*also `rand`*)"
    str="#{str}\n\n__**Developer Information**__"
    str="#{str}\n`bugreport` __\\*message__ - to send my developer a bug report"
    str="#{str}\n`suggestion` __\\*message__ - to send my developer a feature suggestion"
    str="#{str}\n`feedback` __\\*message__ - to send my developer other kinds of feedback"
    str="#{str}\n~~the above three commands are actually identical, merely given unique entries to help people find them~~"
    create_embed([event,x],"",str,0xED619A)
    str="__**Aliases**__"
    str="#{str}\n`addalias` __new alias__ __target__ - Adds a new server-specific alias"
    str="#{str}\n~~`aliases` __target__ (*also `checkaliases` or `seealiases`*)~~"
    str="#{str}\n~~`serveraliases` __target__ (*also `saliases`*)~~"
    str="#{str}\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias"
    str="#{str}\n\n__**Channels**__"
    str="#{str}\n`spam` __toggle__ - to allow the current channel to be safe to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n\n__**Customization**__"
    str="#{str}\n`prefix` __chars__ - to create or edit the server's custom command prefix"
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
    create_embed([event,x],"__**Bot Developer Commands**__",str,0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || Shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `FGO!` `FGO?` `Liz!` `Liz?` `Fate!` `Fate?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `FGO!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `FGO!` `FGO?` `Liz!` `Liz?` `Fate!` `Fate?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `FGO!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `FGO!help here`." if x==1
  end
end

class FGOServant
  def pronoun(possessive=nil)
    return 'he' if @gender=='Male' && possessive==false
    return 'she' if @gender=='Female' && possessive==false
    return 'his' if @gender=='Male' && possessive==true
    return 'him' if @gender=='Male'
    return 'her' if @gender=='Female'
    return 'their' if possessive==true
    return 'they' if possessive==false
    return 'them'
  end
  
  def generic_footer
    return 'For info on the rarity-buffed version of this character, try "Mash Kyrielight Camelot"' if @id==1.0
    return "This servant can switch to servant #1.2 at her Master's wish, after Lostbelt 1." if @id==1.1
    return "This servant can switch to servant #1.1 at her Master's wish." if @id==1.2
    return "This servant becomes servant #81.1 when he uses his Noble Phantasm." if @id==81.0 
    return "This servant comes from servant #81.0 when he uses his Noble Phantasm." if @id==81.1
    return "For the other servant named Solomon, try servant ##{235-@id}." if [83,152].include?(@id)
    return nil
  end
  
  def portrait(bot,event,forceriyo=false,forceasc=-1)
    dispnum="#{'0' if @id<100}#{'0' if @id<10}#{@id.to_s.gsub('.','p')}"
    dispnum=dispnum.split('p')[0] if @id>2
    disptext=event.message.text.downcase
    t=Time.now
    t-=6*60*60
    forceriyo= !forceriyo if t.month==4 && t.day==1 # on April Fool's, show Riyo art UNLESS users ask for it
    asc=1
    asc=2 if has_any?(disptext.split(' '),['first','firstascension','first_ascension','1st','1stascension','1st_ascension','second','secondascension','2nd','second_ascension','2ndascension','2nd_ascension']) || " #{disptext} ".include?(" first ascension ") || " #{disptext} ".include?(" 1st ascension ") || " #{disptext} ".include?(" second ascension ") || " #{disptext} ".include?(" 2nd ascension ")
    asc=3 if has_any?(disptext.split(' '),['third','thirdascension','third_ascension','3rd','3rdascension','3rd_ascension']) || " #{disptext} ".include?(" third ascension ") || " #{disptext} ".include?(" 3rd ascension ")
    asc=4 if has_any?(disptext.split(' '),['fourth','fourthascension','fourth_ascension','4th','4thascension','4th_ascension','final','finalascension','final_ascension']) || " #{disptext} ".include?(" fourth ascension ") || " #{disptext} ".include?(" 4th ascension ") || " #{disptext} ".include?(" final ascension ")
    asc=5 if (has_any?(disptext.split(' '),['costume','firstcostume','first_costume','1stcostume','1st_costume','costume1']) || " #{disptext} ".include?(" first costume ") || " #{disptext} ".include?(" 1st costume ") || " #{disptext} ".include?(" costume 1 ")) && @ascension_mats.length>4
    asc=6 if (has_any?(disptext.split(' '),['secondcostume','second_costume','2ndcostume','2nd_costume','costume2']) || " #{disptext} ".include?(" second costume ") || " #{disptext} ".include?(" 2nd costume ") || " #{disptext} ".include?(" costume 2 ")) && @ascension_mats.length>5
    asc=7 if (has_any?(disptext.split(' '),['thirdcostume','third_costume','3rdcostume','3rd_costume','costume3']) || " #{disptext} ".include?(" third costume ") || " #{disptext} ".include?(" 3rd costume ") || " #{disptext} ".include?(" costume 3 ")) && @ascension_mats.length>6
    asc=8 if (has_any?(disptext.split(' '),['fourthcostume','fourth_costume','4thcostume','4th_costume','costume4']) || " #{disptext} ".include?(" fourth costume ") || " #{disptext} ".include?(" 4th costume ") || " #{disptext} ".include?(" costume 4 ")) && @ascension_mats.length>7
    asc=9 if (has_any?(disptext.split(' '),['fifthcostume','fifth_costume','5thcostume','5th_costume','costume5']) || " #{disptext} ".include?(" fifth costume ") || " #{disptext} ".include?(" 5th costume ") || " #{disptext} ".include?(" costume 5 ")) && @ascension_mats.length>8
    asc=10 if (has_any?(disptext.split(' '),['sixthcostume','sixth_costume','6thcostume','6th_costume','costume6']) || " #{disptext} ".include?(" sixth costume ") || " #{disptext} ".include?(" 6th costume ") || " #{disptext} ".include?(" costume 6 ")) && @ascension_mats.length>9
    asc=11 if (has_any?(disptext.split(' '),['seventhcostume','seventh_costume','7thcostume','7th_costume','costume7']) || " #{disptext} ".include?(" seventh costume ") || " #{disptext} ".include?(" 7th costume ") || " #{disptext} ".include?(" costume 7 ")) && @ascension_mats.length>10
    asc=12 if (has_any?(disptext.split(' '),['eighthcostume','eighth_costume','8thcostume','8th_costume','costume8']) || " #{disptext} ".include?(" eighth costume ") || " #{disptext} ".include?(" 8th costume ") || " #{disptext} ".include?(" costume 8 ")) && @ascension_mats.length>11
    asc=13 if (has_any?(disptext.split(' '),['ninthcostume','ninth_costume','9thcostume','9th_costume','costume9']) || " #{disptext} ".include?(" ninth costume ") || " #{disptext} ".include?(" 9th costume ") || " #{disptext} ".include?(" costume 9 ")) && @ascension_mats.length>12
    asc=14 if (has_any?(disptext.split(' '),['tenthcostume','tenth_costume','10thcostume','10th_costume','costume10']) || " #{disptext} ".include?(" tenth costume ") || " #{disptext} ".include?(" 10th costume ") || " #{disptext} ".include?(" costume 10 ")) && @ascension_mats.length>12
    k2=$aliases.reject{|q| q[0]!='Servant' || q[2]!=@id || q[5].nil?}
    ftr=self.generic_footer
    if k2.length>0
      asc2=0
      for i in 0...k2.length
        asc2=k2[i][5] if disptext.gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').include?(k2[i][1].downcase)
      end
      if asc2>0
        asc=asc2
       ftr="The ascension art is being forced by the alias you are using.  If you wish to see other arts, try using the servant ID (Srv-##{@id}) instead."
      end
    end
    asc=forceasc*1 if forceasc>=0
    xpic="#{dispnum}#{'a' if asc>9}#{asc}"
    xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/#{xpic}.png"
    if forceriyo || has_any?(disptext.split(' '),['riyo','aprilfools']) || disptext.split(' ').include?("aprilfool's") || disptext.split(' ').include?("april_fool's") || disptext.split(' ').include?("april_fools") || " #{disptext} ".include?(" april fool's ") || " #{disptext} ".include?(" april fools ") || asc==0
      asc=0
      xpic="https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/servant_#{dispnum}.png"
      forceriyo=true
    end
    censor=true
    censor=false if disptext.split(' ').include?('jp') || disptext.split(' ').include?('nsfw')
    if censor
      m=false
      IO.copy_stream(open(xpic.gsub('.png','c.png')), "#{$location}devkit/FGOTemp#{Shardizard}.png") rescue m=true
      if File.size("#{$location}devkit/FGOTemp#{Shardizard}.png")<=100 || m
        censor=false
      else
        censor='Censored NA version'
        xpic=xpic.gsub('.png','c.png')
      end
    else
      m=false
      IO.copy_stream(open(xpic.gsub('.png','c.png')), "#{$location}devkit/FGOTemp#{Shardizard}.png") rescue m=true
      unless File.size("#{$location}devkit/FGOTemp#{Shardizard}.png")<=100 || m
        censor='Default JP version'
      end
    end
    if event.message.text.split(' ').include?(@id.to_s) && @id>=2 && 81!=@id.to_i
      cex=$crafts[@id-$crafts[0].id]
      ftr="This is the art for servant ##{@id}.  For the CE numbered #{@id}, it is named \"#{cex.name}\"."
    elsif event.message.text.split(' ').include?(@id.to_i.to_s) && (@id<2 || @id.to_i==81)
      cex=$crafts[0]
      ftr="This is the art for servant ##{@id}.  For the CE numbered #{@id.to_i}, it is named \"#{cex.name}\"."
    end
    disp=["April Fool's Art",'Default (Zeroth Ascension)','First/Second Ascension','Third Ascension','Final Ascension','First Costume','Second Costume','Third Costume','Fourth Costume','Fifth Costume','Sixth Costume','Seventh Costume','Eighth Costume','Ninth Costume','Tenth Costume'][asc]
    disp="#{disp} [#{@costumes[asc-5]}]" if asc>4 && !@costumes.nil? && !@costumes[asc-5].nil?
    k=self.clone
    if @id<1.2 && [6,7].include?(asc)
      k=$servants.find_index{|q| q.id==1.2}
      k=$servants[k]
      disp="~~#{disp}~~\n\n#{k.dispName('**','__')} #{k.emoji(bot,event)}\n#{['','','','','','',k.stat_emotes[5]*4,'First Costume [Repaired]','','','','','','',''][asc]}"
      ftr=nil
    elsif asc==1
      disp="#{self.stat_emotes[5]*(asc-1)}#{self.stat_emotes[4]*(5-asc)}"
    elsif asc==2 && !has_any?(@traits,['FEH Servant','DL Servant'])
      disp="#{self.stat_emotes[5]*(asc-1)}<:half_asc:581250636612632597>#{self.stat_emotes[4]*(4-asc)}"
    elsif asc>0 && asc<5
      disp="#{self.stat_emotes[5]*(asc)}#{self.stat_emotes[4]*(4-asc)}"
    end
    r=nil; r='Riyo' if forceriyo
    return [xpic,disp,ftr,r,k]
  end
end

class SuperServant
  def fav?; return false; end
  
  def portrait(bot,event,forceriyo=false,forceasc=-1)
    return super(bot,event,forceriyo,@ascend[1])
  end
end

class DevServant
  def fav?
    return true if [74,234,315].include?(@id) # Rhyme, Beni, Habetrot
    return false
  end
  
  def portrait(bot,event,forceriyo=false,forceasc=-1)
    return ["https://pbs.twimg.com/media/D9Lcdt2UcAEDM3G?format=jpg&name=small",'Neko Nero',nil,'@yayoimaka03',self,"[Direct Link](https://twitter.com/yayoimaka03/status/1140216715147538432)"] if [5,90].include?(@id)
    return ["https://media.discordapp.net/attachments/331275258327728130/634032815737929738/67d141d.png",'Palm-Sized Okita-San',nil,'@vxgpxv (translated by u/alloftheabove343)',self,"[Direct Link (original in Japanese)](https://mobile.twitter.com/vxqpxv/status/1056521703642193920?s=21)"] if @id==68
    return ["https://media.discordapp.net/attachments/285663217261477889/681617061289525256/image0.jpg",'Cursed and Cute',nil,'*Fate/Grand Order Absolute Demonic Front: Babylonia* animation team',self] if @id==142
    return ["https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOArt/MiniMelt.png",'Smol and Cute',nil,'Tanaka Gorbachev',self] if @id==163
    return ["https://media.discordapp.net/attachments/400114626433515530/681610528703119470/unknown.png",'IshDoll',nil,'u/AmimBlue',self,"[Direct Link](https://www.reddit.com/r/grandorder/comments/conp9p/unlocking_ishtar_rider)"] if @id==182
    return ["https://media.discordapp.net/attachments/397786370367553538/656077171630014474/image0.jpg",'Smol Eresh Big Cute',nil,'Kurenai shake',self,"[Direct Link (original in Japanese)](https://www.pixiv.net/en/artworks/77513651)"] if @id==196
    return super(bot,event,forceriyo,forceasc)
  end
  
  def rarity_colors
    return ['black','bronze','silver','gold','pink'] if self.fav?
    return ['black','bronze','silver','gold']
  end
  
  def rarity_row
    str="<:FGO_Rarity_M:577777835041751040>"*@rarity
    str="<:FGO_Rarity_S:577774548280147969>"*@rarity if self.fav?
    if @traits.include?('FEH Servant')
      str='<:FEH_rarity_M:577779126891577355>'*@rarity
      color=3
      color=2 if @rarity<4
      color=1 if @rarity<3
      color=0 if @rarity<1
      str='<:FEH_rarity_Mp10:577779126853959681>'*@rarity if @ascend[2]+color>2
      str='<:Icon_Rarity_S:448266418035621888>'*@rarity if self.fav?
      str='<:Icon_Rarity_Sp10:448272715653054485>'*@rarity if @ascend[2]+color>2 && self.fav?
    elsif @traits.include?('DL Servant')
      str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][@rarity]*@rarity
    end
    str="\u200B#{str}\u200B"
    str="**0-star**" if @rarity==0
    return str
  end
end

class DonorServant
  def rarity_colors
    return ['black','bronze','silver','gold','red'] if self.fav?
    return ['black','bronze','silver','gold']
  end
  
  def fav?
    return true if [127,253].include?(@id) && @owner=='Ace'
    return false
  end
end

class FGO_CE
  def portrait(bot,event,forceriyo=false,forceasc=-1)
    num="#{'0' if @id<100}#{'0' if @id<10}#{@id}"
    return ["https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Crafts/craft_essence_#{num}.png"]
  end
end

class FGOCommandCode
  def portrait(bot,event,forceriyo=false,forceasc=-1)
    num="#{'0' if @id<100}#{'0' if @id<10}#{@id}"
    return ["http://fate-go.cirnopedia.org/icons/ccode/ccode_#{num}.png"]
  end
end

def find_in_servants(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_servants(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  xclzz=[]; xrarity=[]; curves=[]; attributes=[]; xtraits=[]; nps=[]; decks=[]; targets=[]; avail=[]; align1=[]; align2=[]; align=[]
  lookout=[]; skilltags=[]
  if File.exist?("#{$location}devkit/FGOSkillSubsets.txt")
    lookout=[]
    File.open("#{$location}devkit/FGOSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  dmg=false
  lookout2=lookout.reject{|q| q[2]!='Class'}
  lookout3=lookout.reject{|q| q[2]!='Skill'}
  for i in 0...lookout2.length
    if lookout2[i][3].nil?
      lookout2[i][1].push('extra')
      lookout2[i][1].push('extras')
    end
  end
  lookout=lookout.reject{|q| q[2]!='Servant'}
  for i in 0...args.length
    dmg=true if ['dmg','damage','damaging'].include?(args[i])
    xclzz.push('Saber') if ['saber','sabers','seiba','seibas'].include?(args[i])
    xclzz.push('Archer') if ['archer','bow','sniper','archa','archers','bows','snipers','archas'].include?(args[i])
    xclzz.push('Lancer') if ['lancer','lancers','lance','lances'].include?(args[i])
    xclzz.push('Rider') if ['rider','riders','raida','raidas'].include?(args[i])
    xclzz.push('Caster') if ['caster','casters','castor','castors','mage','mages','magic'].include?(args[i])
    xclzz.push('Assassin') if ['assassin','assasshin','assassins','assasshins'].include?(args[i])
    xclzz.push('Berserker') if ['berserker','berserkers','berserk','berserks','zerker','zerkers'].include?(args[i])
    xclzz.push('Shielder') if ['shielder','shielders','shield','shields','sheilder','sheilders','sheild','sheilds','extra','extras'].include?(args[i])
    xclzz.push('Ruler') if ['ruler','rulers','leader','leaders','extra','extras'].include?(args[i])
    for i2 in 0...lookout2.length
      xclzz.push(lookout2[i2][0]) if lookout2[i2][1].include?(args[i])
    end
    for i2 in 0...lookout3.length
      skilltags.push(lookout3[i2][0]) if lookout3[i2][1].include?(args[i])
    end
    xrarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>=0 && args[i].to_i<6
    xrarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>=0 && args[i][0,1].to_i<6
    xrarity.push(5) if ['ssr','supersuperrare','supersuperare','super-super-rare','super-super_rare','super_super-rare','super_super_rare','super-superare','super_superare'].include?(args[i])
    xrarity.push(4) if ['sr','superrare','super-rare','super_rare','superare'].include?(args[i])
    xrarity.push(3) if ['r','rare'].include?(args[i])
    xrarity.push(2) if ['uc','uncommon','uncomon','un-common','un-comon','un_common','un_comon'].include?(args[i])
    xrarity.push(1) if ['c','common','comon'].include?(args[i])
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
    xtraits.push('Female') if ['female','woman','girl','f','females','women','girls'].include?(args[i])
    xtraits.push('Male') if ['male','boy','m','males','boys'].include?(args[i])
    for i2 in 0...lookout.length
      xtraits.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
    nps.push('Quick') if ['quick','q'].include?(args[i])
    nps.push('Arts') if ['arts','art','a'].include?(args[i])
    nps.push('Buster') if ['buster','bust','b'].include?(args[i])
    decks.push('QQQAB') if ['quickbrave','qbrave','bravequick','braveq','quickquick','qq'].include?(args[i])
    decks.push('QQAAB') if ['quickarts','quickart','qa'].include?(args[i])
    decks.push('QQABB') if ['quickbuster','quickbust','qb','lancerdeck','deckoflancer','lancedeck','deckoflance'].include?(args[i])
    decks.push('QAAAB') if ['artsbrave','artbrave','abrave','bravearts','braveart','bravea','artsarts','artsart','artarts','artart','aa','casterdeck','castordeck','deckofcaster','deckofcastor','magedeck','magicdeck'].include?(args[i])
    decks.push('QAABB') if ['artsbuster','artbuster','artsbust','artbust','ab','saberdeck','seibadeck','deckofsaber','deckofseiba'].include?(args[i])
    decks.push('QABBB') if ['busterbrave','bbrave','bravebuster','braveb','bustbrave','bravebust','busterbuster','busterbust','bustbuster','bustbust','bb','berserkerdeck','berserkdeck','zerkerdeck','deckofberserker','deckofberserk','deckofzerker'].include?(args[i])
    if args[i].include?('q') && args[i].include?('a') && args[i].include?('b') && args[i].length>=5 && args[i].gsub('q','').gsub('a','').gsub('b','').gsub('(','').gsub(')','').gsub('-','').gsub('_','').length<=0
      args[i]=args[i].gsub('(','').gsub(')','').gsub('-','').gsub('_','')
      m=args[i][0,5].upcase.scan(/\w/).sort{|a,b| dsort(a)<=>dsort(b)}.join('')
      n=''
      n="(#{args[i][5,1].upcase})" if args[i].length>5
      decks.push("#{m}#{n}")
    end
    targets.push('Self') if ['self'].include?(args[i])
    targets.push('All Enemies') if ['enemies','allenemies','all_enemies','all-enemies','aoe','areaofeffect','area_of_effect','area_of-effect','area-of_effect','area-of-effect'].include?(args[i])
    targets.push('Enemy') if ['enemy','singleenemy','single_enemy','single-enemy','singlenemy','oneenemy','one_enemy','one-enemy','onenemy','st','singletarget','single-target','single_target','single'].include?(args[i])
    targets.push('All Allies') if ['allies','allallies','all_allies','all-allies'].include?(args[i])
    targets.push('Ally') if ['ally','singleally','single_ally','single-ally','oneally','one_ally','one-ally'].include?(args[i])
    avail.push('Event') if ['event','event','welfare','welfares'].include?(args[i])
    avail.push('Limited') if ['limited','limit','limits','seasonal','seasonals'].include?(args[i])
    avail.push('NonLimited') if ['nonlimited','nonlimit','notlimits','notlimited','notlimit','notlimits','nolimits','limitless','non'].include?(args[i])
    avail.push('FPSummon') if ['fp','friendpoint','fpsummon','friendpointsummon','friend'].include?(args[i])
    avail.push('Starter') if ['starter','starters','start','starting'].include?(args[i])
    avail.push('StoryLocked') if ['story','stories','storylocked','storylock','storylocks','locked','lock','locks'].include?(args[i])
    avail.push('StoryPromo') if ['storypromo','storypromos','storypromotion','promotion','promotions','storypromotions'].include?(args[i])
    avail.push('Unavailable') if ['unavailable','enemy-only','enemyonly','unplayable'].include?(args[i])
    avail.push('Playable') if ['playable','player','available'].include?(args[i])
    align1.push('Lawful') if ['lawful','law','lawfuls','laws'].include?(args[i])
    align1.push('Neutral') if ['neutral','neutral1'].include?(args[i])
    align1.push('Chaotic') if ['chaotic','chaos','chaotics','chaoses'].include?(args[i])
    align2.push('Good') if ['good','light'].include?(args[i])
    align2.push('Balanced') if ['balanced','balance','neutral2'].include?(args[i])
    align2.push('Evil') if ['evil','dark','bad'].include?(args[i])
    align2.push('Bride') if ['bride','bridals','bridal','brides','wedding','weddings','waifu','waifus'].include?(args[i])
    align2.push('Summer') if ['summer','summers','swimsuit','swimsuits','beach','beaches','beachs'].include?(args[i])
    align2.push('Mad') if ['mad','angry','angery','insane','insanity','insanitys','insanities','insanes'].include?(args[i])
    align.push('Lawful Good') if ['lawfulgood','lawgood','lawfullight','lawlight','lawfulight','goodlawful','goodlaw','lightlawful','lightlaw','lawfulgoods','lawgoods','lawfullights','lawlights','lawfulights','goodlawfuls','goodlaws','lightlawfuls','lightlaws'].include?(args[i])
    align.push('Lawful Balanced') if ['lawfulneutral','lawneutral','neutrallawful','neutrallaw','neutralawful','neutralaw','lawfulneutrals','lawneutrals','neutrallawfuls','neutrallaws','neutralawfuls','neutralaws','lawfulbalanced','lawfulbalance','lawbalanced','lawbalance','balancedlawful','balancelawful','balancedlaw','balancelaw'].include?(args[i])
    align.push('Lawful Evil') if ['lawfulevil','lawfuldark','lawfulbad','lawevil','lawdark','lawbad','evillawful','evilawful','evillaw','evilaw','darklawful','darklaw','badlawful','badlaw','lawfulevils','lawfuldarks','lawfulbads','lawevils','lawdarks','lawbads','evillawfuls','evilawfuls','evillaws','evilaws','darklawfuls','darklaws','badlawfuls','badlaws'].include?(args[i])
    align.push('Lawful Bride') if ['lawfulbride','lawfulbridal','lawfulwedding','lawbride','lawbridal','lawwedding','lawedding','bridelawful','bridallawful','bridalawful','weddinglawful','bridelaw','bridallaw','bridalaw','weddinglaw','lawfulbrides','lawfulbridals','lawfulweddings','lawbrides','lawbridals','lawweddings','laweddings','bridelawfuls','bridallawfuls','bridalawfuls','weddinglawfuls','bridelaws','bridallaws','bridalaws','weddinglaws','lawfulwaifu','lawwaifu','lawaifu','waifulawful','waifulaw','lawfulwaifus','lawwaifus','lawaifus','waifulawfuls','waifulaws'].include?(args[i])
    align.push('Lawful Summer') if ['lawfulsummer','lawfulswimsuit','lawfulbeach','lawsummer','lawswimsuit','lawbeach','summerlawful','swimsuitlawful','beachlawful','summerlaw','swimsuitlaw','beachlaw','lawfulsummers','lawfulswimsuits','lawfulbeachs','lawfulbeaches','lawsummers','lawswimsuits','lawbeaches','lawbeachs','summerlawfuls','swimsuitlawfuls','beachlawfuls','summerlaws','swimsuitlaws','beachlaws'].include?(args[i])
    align.push('Lawful Mad') if ['lawfulmad','lawfulangry','lawfulangery','lawmad','lawangry','lawangery','madlawful','angrylawful','angerylawful','madlaw','angrylaw','angerylaw','lawfulmads','lawfulangrys','lawfulangries','lawfulangerys','lawfulangeries','lawmads','lawangrys','lawangries','lawangerys','lawangeries','madlawfuls','angrylawfuls','angerylawfuls','madlaws','angrylaws','angerylaws','lawfulinsane','lawfulinsanity','lawinsane','lawinsanity','lawfulinsanes','lawfulinsanitys','lawfulinsanities','lawinsanes','lawinsanitys','lawinsanities','insanelawful','insanitylawful','insanelaw','insanitylaw','insanelawfuls','insanitylawfuls','insanelaws','insanitylaws'].include?(args[i])
    align.push('Neutral Good') if ['neutralgood','neutrallight','neutralight','goodneutral','lightneutral','neutralgoods','neutrallights','neutralights','goodneutrals','lightneutrals'].include?(args[i])
    align.push('Neutral Balanced') if ['neutralneutral','neutralsquared','trueneutral','neutraltrue','neutraltruth','neutralneutrals','neutralsquareds','trueneutrals','neutraltrues','neutraltruths','neutralbalanced','neutralbalance','balancedneutral','balanceneutral'].include?(args[i])
    align.push('Neutral Evil') if ['nautralevil','neutraldark','neutralbad','evilneutral','darkneutral','badneutral','nautralevils','neutraldarks','neutralbads','evilneutrals','darkneutrals','badneutrals'].include?(args[i])
    align.push('Neutral Bride') if ['neutralbride','neutralbridal','neutralwedding','brideneutral','bridalneutral','weddingneutral','neutralbrides','neutralbridals','neutralweddings','brideneutrals','bridalneutrals','weddingneutrals','neutralwaifu','waifuneutral','neutralwaifus','waifuneutrals'].include?(args[i])
    align.push('Neutral Summer') if ['neutralsummer','neutralswimsuit','neutralbeach','summerneutral','swimsuitneutral','beachneutral','neutralsummers','neutralswimsuits','neutralbeachs','neutralbeaches','summerneutrals','swimsuitneutrals','beachneutrals'].include?(args[i])
    align.push('Neutral Mad') if ['neutralmad','neutralangry','neutralangery','madneutral','angryneutral','angerynautral','neutralmads','neutralangrys','neutralangries','neutralangerys','neutralangeries','madneutrals','angryneutrals','angerynautrals','neutralinsane','neutralinsanity','insaneneutral','insanityneutral','insaneutral','neutralinsanes','neutralinsanitys','neutralinsanities','insaneneutrals','insanityneutrals','insaneutrals'].include?(args[i])
    align.push('Chaotic Good') if ['chaoticgood','chaosgood','chaoticlight','chaoslight','goodchaotic','goodchaos','lightchaotic','lightchaos','chaoticgoods','chaosgoods','chaoticlights','chaoslights','goodchaotics','goodchaoses','lightchaotics','lightchaoses'].include?(args[i])
    align.push('Chaotic Balanced') if ['chaoticneutral','chaosneutral','neutralchaotic','neutralchaos','chaoticneutrals','chaosneutrals','neutralchaotices','neutralchaoses','chaoticbalanced','chaosbalanced','chaoticbalance','chaosbalance','balancedchaotic','balancedchaos','balancechaotic','balancechaos'].include?(args[i])
    align.push('Chaotic Evil') if ['chaoticevil','chaoticdark','chaoticbad','chaosevil','chaosdark','chaosbad','evilchaotic','darkchaotic','badchaotic','evilchaos','darkchaos','badchaos','chaoticevils','chaoticdarks','chaoticbads','chaosevils','chaosdarks','chaosbads','evilchaotics','darkchaotics','badchaotics','evilchaoses','darkchaoses','badchaoses'].include?(args[i])
    align.push('Chaotic Bride') if ['chaoticbride','chaoticbridal','chaoticwedding','chaoticwaifu','chaosbride','chaosbridal','chaoswedding','chaoswaifu','bridechaotic','bridalchaotic','weddingchaotic','waifuchaotic','bridechaos','bridalchaos','weddingchaos','waifuchaos','chaoticbrides','chaoticbridals','chaoticweddings','chaoticwaifus','chaosbrides','chaosbridals','chaosweddings','chaoswaifus','bridechaotics','bridalchaotics','weddingchaotics','waifuchaotics','bridechaoses','bridalchaoses','weddingchaoses','waifuchaoses'].include?(args[i])
    align.push('Chaotic Summer') if ['chaoticsummer','chaoticswimsuit','chaoticbeach','chaossummer','chaosummer','chaosbeach','summerchaotic','swimsuitchaotic','beachchaotic','beachaotic','summerchaos','swimsuitchaos','beachchaos','beachaos','chaoticsummers','chaoticswimsuits','chaoticbeachs','chaoticbeaches','chaossummers','chaosummers','chaosbeachs','chaosbeaches','summerchaotics','swimsuitchaotics','beachchaotics','beachaotics','summerchaoses','swimsuitchaoses','beachchaoses','beachaoses'].include?(args[i])
    align.push('Chaotic Mad') if ['chaoticmad','chaoticangry','chaoticangery','chaosmad','chaosangry','chaosangery','madchaotic','angrychaotic','angerychaotic','madchaos','angrychaos','angerychaos','chaoticmads','chaoticangrys','chaoticangries','chaoticangerys','chaoticangeries','chaosmads','chaosangrys','chaosangries','chaosangerys','chaosangeries','madchaotics','angrychaotics','angerychaotics','madchaoses','angrychaoses','angerychaoses','chaoticinsane','chaoticinsanity','chaosinsane','chaosinsanity','insanechaotic','insanitychaotic','insanechaos','insanitychaos','chaoticinsanes','chaoticinsanitys','chaoticinsanities','chaosinsanes','chaosinsanitys','chaosinsanities','insanechaotics','insanitychaotics','insanechaoses','insanitychaoses'].include?(args[i])
    align.push('None') if ['noalignment','nonealignment','none'].include?(args[i])
  end
  textra=''
  if nps.length>=5 && nps.include?('Quick') && nps.include?('Arts') && nps.include?('Buster')
    m=true
    while nps.length>=5 && m
      mx=nps[0,5]
      if mx.include?('Quick') && mx.include?('Arts') && mx.include?('Buster')
        mx=mx.map{|q| q[0]}.sort{|a,b| dsort(a)<=>dsort(b)}.join('')
        decks.push(mx)
        nps.shift; nps.shift; nps.shift; nps.shift; nps.shift
      else
        m=false
      end
    end
  end
  decks.push('QQQAB') if nps.reject{|q| q !='Quick'}.length>1
  decks.push('QAAAB') if nps.reject{|q| q !='Arts'}.length>1
  decks.push('QABBB') if nps.reject{|q| q !='Buster'}.length>1
  if align1.include?('Neutral') && !align2.include?('Balanced')
    textra="#{textra}\n\nThe search for \"Neutral\" is being applied to the Horizontal spectrum (Lawful-Chaotic).\nIf you would like the vertical alignment called \"Neutral\" in JP, please use the search term \"Balanced\" instead."
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
  xclzz.uniq!; xrarity.uniq!; curves.uniq!; attributes.uniq!; xtraits.uniq!; nps.uniq!; decks.uniq!; targets.uniq!; avail.uniq!; align1.uniq!; align2.uniq!; align.uniq!; skilltags.uniq!
  char=$servants.map{|q| q.clone}.uniq
  search=[]
  if xclzz.length>0
    char=char.reject{|q| !xclzz.include?(q.clzz)}.uniq
    for i in 0...xclzz.length
      moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{xclzz[i].downcase.gsub(' ','')}_gold"}
      xclzz[i]="#{moji[0].mention}#{xclzz[i]}" if moji.length>0
    end
    search.push("*Classes*: #{xclzz.join(', ')}")
  end
  if xrarity.length>0
    char=char.reject{|q| !xrarity.include?(q.rarity)}.uniq
    search.push("*Rarities*: #{xrarity.map{|q| "#{q}<:fgo_icon_rarity:523858991571533825>"}.join(', ')}")
  end
  if curves.length>0
    char=char.reject{|q| !curves.include?(q.grow_curve)}.uniq
    search.push("*Growth curves*: #{curves.join(', ')}")
  end
  if attributes.length>0
    char=char.reject{|q| !attributes.include?(q.attribute)}.uniq
    search.push("*Attributes*: #{attributes.join(', ')}")
    textra="#{textra}\n\nThe search term \"Beast\" is being interpreted as a search for the Beast attribute.\nIf you meant the Beast class, please include the word \"BeastClass\" in your message instead.\nIf you meant the trait *Wild Beast*, please include the word \"Wild\" in your message instead." if attributes.include?('Beast') && !(clzz.include?('Beast') || traits.include?('Wild Beast'))
    textra="#{textra}\n\nThe search term \"Man\" is being interpreted as a search for the Man attribute.\nIf you meant the trait *Male*, please include the word \"Male\" in your message instead." if attributes.include?('Man') && !traits.include?('Male')
  end
  if xtraits.length>0
    search.push("*Traits*: #{xtraits.join(', ')}")
    if has_any?(args,['any','anytrait','anytraits'])
      search[-1]="#{search[-1]}\n(searching for servants with any listed trait)" if xtraits.length>1
      char=char.reject{|q| !has_any?(xtraits,q.traits)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for servants with all listed traits)" if xtraits.length>1
      textra="#{textra}\n\nTraits searching defaults to searching for servants with all listed traits.\nTo search for servants with any of the listed traits, perform the search again with the word \"any\" in your message." if xtraits.length>1
      for i in 0...xtraits.length
        char=char.reject{|q| !q.traits.include?(xtraits[i])}.uniq
      end
    end
  end
  if decks.length>0
    search.push("*Command Decks*: #{decks.join(', ')}")
    nps=['Q','A','B'] if nps.length<=0
    total_decks=[]
    for i in 0...decks.length
      if decks[i].length>5
        total_decks.push(decks[i])
      else
        for i2 in 0...nps.length
          total_decks.push("#{decks[i]}(#{nps[i2][0,1]})")
        end
      end
    end
    nps=[] if nps.reject{|q| q.length<2}.length<=0
    char2=char.reject{|q| !total_decks.include?(q.deck)}.uniq
    char=char.reject{|q| char2.map{|q2| q2.id}.include?(q.id) || !q.deck.include?('[')}
    for i in 0...char.length
      if has_any?(totaldecks,char[i].deck.split('[')[-1].gsub(']','').scan(/\w/).map{|q| "#{char[i].deck[0,5]}(#{q})"})
        char[i].name="#{char[i].name} *[NP type changes with skill]*"
        char2.push(char[i])
      end
    end
    char=char2.map{|q| q}
  elsif nps.length>0
    char2=char.reject{|q| !nps.map{|q2| q2[0]}.include?(q.deck[6,1])}.uniq
    char=char.reject{|q| char2.map{|q2| q2.id}.include?(q.id) || !q.deck.include?('[')}
    for i in 0...char.length
      if has_any?(nps.map{|q2| q2[0]},char[i].deck.split('[')[-1].gsub(']','').scan(/\w/))
        char[i].name="#{char[i].name} *[NP type changes with skill]*"
        char2.push(char[i])
      end
    end
    char=char2.map{|q| q}
  end
  if nps.length>0
    for i in 0...nps.length
      nps[i]='<:Quick_y:526556106986618880>Quick' if nps[i]=='Quick'
      nps[i]='<:Arts_y:526556105489252352>Arts' if nps[i]=='Arts'
      nps[i]='<:Buster_y:526556105422274580>Buster' if nps[i]=='Buster'
    end
    search.push("*Noble Phantasm card types*: #{nps.join(', ')}")
  end
  if dmg
    char2=[]
    for i in 0...char.length
      nophan=$nobles.reject{|q| q.id.split('u')[0].to_f !=char[i].id}
      if nophan.length<=0
      elsif nophan[0].tags.include?('Dmg') && nophan[-1].tags.include?('Dmg')
        char2.push(char[i])
      elsif nophan[0].tags.include?('Dmg')
        char[i].name="#{char[i].name} *[Base]*"
        char2.push(char[i])
      elsif nophan[-1].tags.include?('Dmg')
        char[i].name="#{char[i].name} *[Upgrade]*"
        char2.push(char[i])
      elsif nophan.length>nophan.reject{|q| q.tags.include?('Dmg')}.length
        char[i].name="#{char[i].name} *[Semi-upgrade]*"
        char2.push(char[i])
      end
    end
    char=char2.map{|q| q}
    search.push("*Damaging Noble Phantasms only*")
  end
  skz=$skills.map{|q| q.clone}
  if targets.length>0
    char2=[]
    for i in 0...char.length
      nophan=$nobles.reject{|q| q.id.split('u')[0].to_f !=char[i].id}
      if nophan.length<=0
      elsif has_any?(nophan[0].target,targets) && has_any?(nophan[-1].target,targets)
        char2.push(char[i])
      elsif has_any?(nophan[0].target,targets)
        char[i].name="#{char[i].name} *[Base]*"
        char2.push(char[i])
      elsif has_any?(nophan[-1].target,targets)
        char[i].name="#{char[i].name} *[Upgrade]*"
        char2.push(char[i])
      elsif nophan.length>nophan.reject{|q| has_any?(q.target,targets)}.length
        char[i].name="#{char[i].name} *[Semi-upgrade]*"
        char2.push(char[i])
      end
    end
    textra="#{textra}\n\nThe word \"Enemy\" is being interpreted as a search for NPs that target a single enemy.\nIf you would like to find a list of enemy-exclusive servants, use the search term \"Unavailable\" instead." if targets.include?('Enemy') && !avail.include?('Unavailable') && event.message.text.downcase.split(' ').include?('enemy')
    textra="#{textra}\n\nThe word \"Enemies\" is being interpreted as a search for NPs that target all enemies.\nIf you would like to find a list of enemy-exclusive servants, use the search term \"Unavailable\" instead." if targets.include?('All Enemies') && !avail.include?('Unavailable') && event.message.text.downcase.split(' ').include?('enemies')
    char=char2.map{|q| q}
    search.push("*Noble Phantasm target(s)*: #{targets.join(', ')}")
  end
  avail=[] if avail.include?('Playable') && avail.include?('Unavailable')
  if avail.length>0
    search.push("*Availability*: #{avail.join(', ')}")
    spro=true if avail.include?('StoryPromo')
    avail=['Event','Limited','NonLimited','Starter','StoryLocked'] if avail.include?('Playable')
    avail.push('StoryPromo') if spro && !avail.include?('StoryPromo')
    char2=[]
    for i in 0...char.length
      if has_any?(char[i].availability,avail)
        char2.push(char[i])
      elsif char[i].id==4 && avail.include?('FPSummon')
        char[i].name="#{char[i].name} *[in JP only]*"
        char2.push(char[i])
      end
    end
    char=char2.map{|q| q}
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
  char=char.reject{|q| !has_any?(q.alignment.split(' / '),align)}.uniq if align.length>0
  passiveremark=false
  if skilltags.length>0
    passiveinclude=has_any?(args,['passive','psv'])
    passiveremark=false
    passiveremark=true if !passiveinclude
    passiveremark=false if char.reject{|q| !has_any?(skilltags,q.skill_tags(true)) || has_any?(skilltags,q.skill_tags)}.length<=0
    search.push("*Skill Tags*: #{skilltags.join(', ')}")
    if has_any?(args,['anyskill','anyskills']) || (args.include?('any') && traits.length<=0)
      search[-1]="#{search[-1]}\n(searching for servants with any listed skill tags)" if skilltags.length>1
      char=char.reject{|q| !has_any?(skilltags,q.skill_tags(passiveinclude))}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for servants with all listed skill tags)" if skilltags.length>1
      textra="#{textra}\n\nSkill tag searching defaults to searching for servants with all listed skill tags.\nTo search for servants with any of the listed skill tags, perform the search again with the word \"anyskill\" in your message." if skilltags.length>1
      for i in 0...skilltags.length
        char=char.reject{|q| !q.skill_tags(passiveinclude).include?(skilltags[i])}.uniq
      end
    end
    textra="#{textra}\n\nSkill tag searching defaults to not including passive skills.\nTo include passive skills in your search, perform the search again with the word \"psv\" in your message." if passiveremark
    for i in 0...char.length
      char[i].name="#{char[i].name} #{char[i].skill_tags(passiveinclude,skilltags)}"
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[2].map{|q| q.id}.include?(q.id)}
  end
  if safe_to_spam?(event)
  elsif (char.length>50 || char.map{|q| "#{q.id}#{'.' if q.id>=2 && q.id.to_i != 81}) #{q.name}"}.join("\n").length+search.join("\n").length+textra.length>=1900) && mode==0
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM."
    return nil
  end
  return [search,textra,char]
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
  char=char.sort{|a,b| a.id<=>b.id}.map{|q| "#{q.id}#{'.' if q.id>=2 && q.id.to_i !=81}) #{q.name}"}.uniq
  if char.length>=$servants.length
    k="No filters defined.  I'm not showing everyone."
    k="EVERYONE IS HERE!" if rand(100)==0
    event.respond "__**Search**__\n#{search.join("\n")}#{"\n\n#{textra}" if textra.length>0}#{"\n" if search.length>0 || textra.length>0}\n__**Results**__\n#{k}\n\n#{char.length} total"
  elsif $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length+textra.length>=1900
    str="__**Search**__\n#{search.join("\n")}#{"\n\n#{textra}" if textra.length>0}#{"\n" if search.length>0 || textra.length>0}\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char,true) unless char.length<=0
    if textra.length<=0 && char.length<10
      textra=char.join("\n")
      flds=nil
    end
    textra="#{textra}\n\n**No servants match your search**" if char.length<=0
    create_embed(event,"__**Search**__\n#{search.join("\n")}#{"\n" if search.length>0}\n__**Results**__",textra,0xED619A,"#{char.length} total",nil,flds)
  end
end

def sort_servants(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_servants(bot,event,args,1)
  return nil if k.nil?
  search=k[0]; textra=k[1]; char=k[2]
  srt=[4,4,4]
  srtt=0
  lvl=-1
  for i in 0...args.length
    lvl=0 if ['lvl1','level1','base','1level','1lvl'].include?(args[i].downcase)
    lvl=1 if ['max','default'].include?(args[i].downcase)
    lvl=2 if ['lvl100','level100','grail','100level','100lvl'].include?(args[i].downcase)
    lvl=3 if ['lvl120','level120','grailplus','grail+','120level','120lvl'].include?(args[i].downcase)
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(6)
      srt[srtt]=6
      srtt+=1
    elsif ['atk','att','attack'].include?(args[i].downcase) && !srt.include?(7)
      srt[srtt]=7
      srtt+=1
    end
  end
  unless search.join("\n").include?('Unavailable') || event.message.text.downcase.split(' ').include?('all')
    char2=char.reject{|q| q.availability.include?('Unavailable')}.uniq
    textra="#{textra}\n\nFor usefulness, I have removed servants that are unavailable to Masters.\nIf you would like to include those servants, include the word \"all\" in your message." unless char2.length==char.length
    char=char2.map{|q| q}
  end
  if lvl<0 && srt.reject{|q| q==2}.length>0
    textra="#{textra}\n\nNo level was included, so I am sorting by default maximum level.\nIf you wish to change that, include the word \"Base\" (for level 1), \"Grail\" (for level 100), or \"Grail+\" (for level 120)." if srt.reject{|q| q==4}.length>0
    lvl=1
  elsif lvl>1 && srt.reject{|q| q==2}.length>0
    lvl-=4
  end
  for i in 0...char.length
    char[i].sort_data=[]
    char[i].sort_data[4]=$servants.length+100-char[i].id
    char[i].sort_data[6]=char[i].hp[lvl]
    char[i].sort_data[7]=char[i].atk[lvl]
    char[i].sort_data[0]="Srv-#{char[i].id}#{'.' unless char[i].id<2 || char[i].id.to_i==81}) #{char[i].name}#{char[i].emoji(bot,event,1)}"
    char[i].sort_data[1]=" [Lv. #{char[i].max_level}]"
  end
  char=char.map{|q| q.sort_data}.uniq
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? supersort(a,b,srt[2]) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  d=['ID','Name','Servant ID','Rarity','ID','Level','HP','Atk']
  disp=[]
  for i in 0...char.length
    m=[]
    for i2 in 0...srt.length
      m.push("#{longFormattedNumber(char[i][srt[i2]])} #{d[srt[i2]]}") if srt[i2]>4
    end
    disp.push("#{char[i][0]}#{char[i][1] if m.length>0 && lvl==1}#{"  -  #{m.join('  -  ')}" if m.length>0}")
  end
  d=['ID','Name','Servant ID','Rarity','ID','Level','<:FGO_HP:653485372168470528>HP','<:FGO_Atk:653485372231122944>Atk']
  str="__**Search**__#{"\n#{search.join("\n")}" if search.length>0}#{"\n" if search.join("\n").include?('Excludes')}#{"\n*Sorted by:* #{srt.reject{|q| q==4}.uniq.map{|q| d[q]}.join(', ')}\n*Sorted at:* #{['Base','Default Max','Grailed Max (NA)','Grailed Max (JP)'][lvl]} Level" if srt.reject{|q| q==2}.length>0}#{"\n\n__**Additional notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
  str="__**Results**__" if str=="__**Search**__\n\n__**Results**__"
  tx=0
  bx=0
  for i in 0...args.length
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,disp.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,disp.length].min
    end
  end
  if tx>0
    disp=disp[0,tx]
  elsif bx>0
    disp=disp[disp.length-bx,bx]
  end
  if str.length+disp.join("\n").length>1900 && !safe_to_spam?(event)
    textra="#{textra}\n\nToo much data is trying to be displayed.\nShowing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    disp=disp[0,[10,disp.length].min]
  end
  t=textra.split("\n")
  for i in 0...5
    t.shift if t.length>0 && t[0].length<=0
  end
  textra=t.join("\n")
  str="__**Search**__#{"\n#{search.join("\n")}" if search.length>0}#{"\n" if search.join("\n").include?('Excludes')}#{"\n*Sorted by:* #{srt.uniq.map{|q| d[q]}.join(', ')}\n*Sorted at:* #{['Base','Default Max','Grailed Max'][lvl]} Level" if srt.reject{|q| q==2}.length>0}#{"\n\n__**Additional notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
  str="__**Results**__" if str=="__**Search**__\n\n__**Results**__"
  for i in 0...disp.length
    str=extend_message(str,disp[i],event)
  end
  event.respond str
end

def find_skills(bot,event,args=nil,ces_only=false,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase).gsub('-','').gsub('_','')}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_skills(bot,event,sn.split(' '),ces_only,13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  types=[]; xtags=[]
  lookout=[]
  if File.exist?("#{$location}devkit/FGOSkillSubsets.txt")
    lookout=[]
    File.open("#{$location}devkit/FGOSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Skill'}
  for i in 0...args.length
    types.push('Skill') if ['active','activeskill','activeskil'].include?(args[i])
    types.push('Passive') if ['passive','passiveskill','passiveskil'].include?(args[i])
    types.push('Noble') if ['np','noble','phantasm','noblephantasm'].include?(args[i])
    types.push('Clothes') if ['clothes','clothing','clothingskill','clothesskill','clothingskil','clothesskil','clotheskil','clotheskill','mystic','mysticcode'].include?(args[i])
    types.push('CEs') if ['ce','ces','craft','crafts','essence','essences'].include?(args[i])
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  types=['CEs'] if ces_only
  types.uniq!
  xtags.uniq!
  str="__**Search**__"
  skz=[$skills,$nobles].flatten.map{|q| q.clone}
  skz2=[$skills,$nobles].flatten.map{|q| q.clone}
  if types.length>0
    skz=skz.reject{|q| !types.include?(q.type)}
    for i in 0...types.length
      types[i]='Active' if types[i]=='Skill'
      types[i]='Noble Phantasm' if types[i]=='Noble'
      types[i]='Craft Essence' if types[i]=='CEs'
    end
    str="#{str}\n*Skill types:* #{types.join(', ')}"
  end
  for i in 0...skz.length
    if skz[i].type=='Noble'
      skz[i].id="#{skz[i].id}b" if i<skz.length-1 && skz[i+1].type=='Noble' && skz[i+1].id=="#{skz[i].id}u"
      skz[i]=[skz[i].name,skz[i].id,skz[i].objt,skz[i].tags]
    else
      skz[i]=[skz[i].name,skz[i].rank,skz[i].objt,skz[i].tags]
    end
  end
  ces=$crafts.map{|q| [q.name,q.id,'CE',q.tags]}
  ces2=$crafts.map{|q| q.clone}
  if types.length<=0 || types.include?('CEs') || types.include?('Craft Essence')
    for i in 0...ces.length
      skz.push(ces[i])
      skz2.push(ces2[i])
    end
  end
  textra=''
  if xtags.length>0
    str="#{str}\n*Tags:* #{xtags.join(', ')}"
    if args.include?('any')
      str="#{str}\n(searching for items with any listed skill tag)" if xtags.length>1
      skz=skz.reject{|q| !has_any?(xtags,q[3])}
    else
      str="#{str}\n(searching for items with all listed skill tags)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for items with all listed tags.\nTo search for items with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        skz=skz.reject{|q| !q[3].include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    skz=skz.reject{|q| crsoff[1].include?(q)}
  end
  return [search,skz] if mode==13
  textra='~~none~~' if textra.length<=0
  str="#{str}\n\n__**Results**__"
  m=[['Active Skills',[]],['Passive Skills',[]],['Append Skills',[]],['Noble Phantasms',[]],['Craft Essances',[]],['Clothing Skills',[]],['Other',[]]]
  for i in 0...skz.length
    if ['Active','Passive','Append'].include?(skz[i][2])
      m2=skz.reject{|q| q[2]!=skz[i][2] || q[0]!=skz[i][0]}
      if i>0 && skz[i-1][2]==skz[i][2] && skz[i-1][0]==skz[i][0]
      elsif skz[i][1]=='-'
        m[0][1].push(skz[i][0])
      elsif m2.length>5
        m[0][1].push("#{skz[i][0]} #{m2[0][1]} thru #{m2[0][-1]}")
      else
        m[0][1].push("#{skz[i][0]} #{m2.map{|q| q[1]}.join('/')}")
      end
    elsif skz[i][2]=='Noble'
      if i>0 && skz[i-1][2]=='Noble' && skz[i-1][1]==skz[i][1].gsub('u','b')
      elsif i<skz.length-1 && skz[i+1][2]=='Noble' && skz[i+1][1]==skz[i][1].gsub('b','u')
        m[3][1].push("NP-#{skz[i][1].split('u')[0].gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]}")
      elsif skz[i][1].include?('b')
        m[3][1].push("NP-#{skz[i][1].split('u')[0].gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]} *[Before Upgrading]*")
      elsif skz[i][1].include?('u2')
        m[3][1].push("NP-#{skz[i][1].split('u')[0].gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]} *[After Upgrading Twice]*")
      elsif skz[i][1].include?('u')
        m[3][1].push("NP-#{skz[i][1].split('u')[0].gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]} *[After Upgrading]*")
      else
        m[3][1].push("NP-#{skz[i][1].split('u')[0].gsub('b','')}#{'.' unless skz[i][1].gsub('u','').gsub('b','').to_i<2}) #{skz[i][0]}")
      end
    elsif skz[i][2]=='CE'
      m[4][1].push("CE-#{skz[i][1]}.) #{skz[i][0]}")
    elsif skz[i][2]=='ClothingSkill'
      m[5][1].push(skz[i][0])
    end
  end
  ftr="#{m.map{|q| q[1]}.join("\n").split("\n").reject{|q| q.nil? || q.length<=0}.length} Total (#{m[0][1].length} Active, #{m[1][1].length} Passive, #{m[2][1].length} Append, #{m[3][1].length} Noble, #{m[4][1].length} CE, #{m[5][1].length} Clothing)"
  mmmx=m.map{|q| q[1]}.join("\n").split("\n").reject{|q| q.nil? || q.length<=0}.length
  m[0][1]=[] if m[0][1].length>=skz2.reject{|q| q.objt !='Active'}.map{|q| q.name}.uniq.length
  m[1][1]=[] if m[1][1].length>=skz2.reject{|q| q.objt !='Passive'}.map{|q| q.name}.uniq.length
  m[2][1]=[] if m[2][1].length>=skz2.reject{|q| q.objt !='Append'}.map{|q| q.name}.uniq.length
  m[3][1]=[] if m[3][1].length>=skz2.reject{|q| q.objt !='Noble'}.map{|q| q.name}.uniq.length
  m[4][1]=[] if m[4][1].length>=skz2.reject{|q| q.objt !='Craft'}.uniq.length
  m[5][1]=[] if m[5][1].length>=skz2.reject{|q| q.objt !='ClothingSkill'}.uniq.length
  unless m.map{|q| q.join("\n")}.join("\n\n").length+str.length+ftr.length>1900 || was_embedless_mentioned?(event)
    f=m.map{|q| q[1].length}
    for i in 0...5
      if f[i]<=f.max/3 && f[i]>0
        m[5][1].push("__**#{m[i][0]}**__\n#{m[i][1].join("\n")}\n")
        m[i][1]=[]
      end
    end
  end
  m=m.reject{|q| q[1].length<=0}
  textra="No filters defined.  I'm not showing everything." if m.length<=0 && mmmx>0
  if m.length<=0
    event.respond "#{str}\n#{textra}#{"\n\n#{ftr}" unless ftr.nil?}"
    return nil
  elsif m.length==1 && m[0][1].length<=10 && textra.length<=0
    textra="__**#{m[0][0]}**__\n#{m[0][1].join("\n")}"
    textra="#{m[0][1].join("\n")}" if types.length==1
    m=[]
  elsif m.length==1
    textra="#{textra}\n\n**#{m[0][0]}**" unless types.length==1
    m=triple_finish(m[0][1])
  else
    m=m.map{|q| [q[0],q[1].join("\n")]}
  end
  if m.map{|q| q.join("\n")}.join("\n\n").length+str.length+ftr.length>1900
    if !safe_to_spam?(event,nil,1)
      str="#{str.split("\n\n")[0]}\n\n__**Note**__\nThere are too many skills trying to be displayed.  Please retry this command in PM."
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
    str=extend_message(str,ftr,event,2) unless ftr.nil?
    event.respond str
    return nil
  end
  textra='' if textra=='~~none~~'
  create_embed(event,str,textra,0xED619A,ftr,nil,m)
end

def list_aliases(bot,event,args=nil,saliases=false,dispdata=false)
  if args.nil? || args.length.zero?
    args=event.message.text.downcase.split(' ')
    args.shift
  end
  data_load()
  nicknames_load()
  easylist=['clothingskills','passiveskills','craftessences','craftessances','clothesskills','clothingskils','clothingskill','passiveskils','passiveskill','pasiveskills','craftessence','pasiveskl','acts',
            'craftessance','commandcodes','clothingskls','clothingskil','clothesskils','clothesskill','clotheskills','appendskills','activeskills','passiveskls','passiveskil','pasiveskils','pasive','srv',
            'pasiveskill','mysticcodes','commandcode','clothingskl','clotheskils','clotheskill','clothesskls','clothesskil','appendskils','appendskill','apendskills','activeskils','activeskill','actives',
            'passiveskl','pasiveskls','pasiveskil','mysticcode','mysticodes','clotheskil','clotheskls','clothesskl','appendskls','appendskil','apendskils','apendskill','activeskls','activeskil','appends',
            'mysticode','materials','clotheskl','appendskl','apendskls','apendskil','activeskl','servants','passives','material','essences','essances','commands','clothing','apendskl','servant','clothes',
            'passive','pasives','mystics','essence','essance','enemies','command','skills','mystic','enemys','enemie','crafts','append','apends','active','units','skils','skill','items','unit','skl','ce',
            'enemy','craft','codes','apend','actvs','srvs','skls','skil','mats','item','code','actv','mat','ces','act']
  len=3
  len=5 if (args.length<=0 || easylist.include?(args[0].downcase)) && safe_to_spam?(event) && !dispdata
  (event.channel.send_temporary_message('Calculating data, please wait...',len) rescue nil) unless dispdata
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=nil
  k=find_best_match(args.join(' '),bot,event,false,false,0) unless (args.length<=0 || easylist.include?(args[0].downcase))
  k=k[0] if !k.nil? && k.is_a?(Array)
  args=[''] if args.nil? || args.length<=0
  if k.nil? && (!safe_to_spam?(event) || event.server.id==350067448583553024) && !(saliases && !event.server.nil? && $aliases.reject{|q| q[3].nil? || !q[3].include?(event.server.id)}.length<=20)
    alz=args.join(' ')
    alz='>censored mention<' if alz.include?('@')
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, Append, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes"
    str="#{str}\n\n*#{alz}* does not fall into any of these categories." if alz.length>0
    str="#{str}\n\nPlease include what you wish to look up the aliases for, or use this command in PM.\nBut if you do that, prepare to be getting messages for a long time.  There's #{longFormattedNumber($aliases.length)} of them." if alz.length<=0
    event.respond str
    return nil
  elsif ['code','codes'].include?(args[0].downcase)
    nicknames_load()
    f.push(list_aliases(bot,event,['commands'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['clothes'],saliases,true))
    f.flatten!
  elsif ['skill','skills','skls','skl','skil','skils'].include?(args[0].downcase)
    nicknames_load()
    f.push(list_aliases(bot,event,['active'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['passive'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['append'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['clothngskill'],saliases,true))
    f.flatten!
  elsif easylist.include?(args[0].downcase)
    alztyp=''
    alztyp='Servant' if ['servant','servants','srv','srvs','unit','units'].include?(args[0].downcase)
    alztyp='Craft' if ['ce','craft','essance','craftessance','essence','craftessence','ces','crafts','essances','craftessances','essences','craftessences'].include?(args[0].downcase)
    alztyp='Command' if ['command','commandcode','commands','commandcodes'].include?(args[0].downcase)
    alztyp='Clothes' if ['mysticcode','mysticode','mystic','mysticcodes','mysticodes','mystics','clothing','clothes'].include?(args[0].downcase)
    alztyp='Active' if ['active','act','actv','activeskill','activeskl','activeskil','actives','acts','actvs','activeskills','activeskls','activeskils'].include?(args[0].downcase)
    alztyp='Passive' if ['passive','passiveskill','passiveskl','passiveskil','passives','passiveskills','passiveskls','passiveskils','pasive','pasiveskill','pasiveskl','pasiveskil','pasives','pasiveskills','pasiveskls','pasiveskils'].include?(args[0].downcase)
    alztyp='Append' if ['append','appendskill','appendskl','appendskil','apend','apendskill','apendskl','apendskil','appends','appendskills','appendskls','appendskils','apends','apendskills','apendskls','apendskils'].include?(args[0].downcase)
    alztyp='ClothingSkill' if ['clothingskill','clothesskill','clotheskill','clothingskil','clothesskil','clotheskil','clothingskl','clothesskl','clotheskl','clothingskills','clothesskills','clotheskills','clothingskils','clothesskils','clotheskils','clothingskls','clothesskls','clotheskls'].include?(args[0].downcase)
    alztyp='Material' if ['mat','mats','materials','material','item','items'].include?(args[0].downcase)
    alztyp='Enemy' if ['enemy','enemies','enemie','enemys'].include?(args[0].downcase)
    x=$aliases.reject{|q| q[0]!=alztyp}
    x=x.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    x=x.reject{|q| q[3].nil?} if saliases
    f=["__**#{'Server-specific ' if saliases}#{alztyp} Aliases**__"]
    if event.server.nil?
      for i in 0...x.length
        str="#{x[i][1].gsub('`',"\`").gsub('*',"\*")} = #{x[i][2]}"
        if q[3].nil?
          f.push(str)
        else
          f2=[]
          for j in 0...x[i][3].length
            srv=(bot.server(x[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f2.push("*#{bot.server(x[i][3][j]).name}*") unless event.user.on(x[i][3][j]).nil?
            end
          end
          f.push("#{str} (in the following servers: #{list_lift(f2,'and')})") unless f2.length<=0
        end
      end
    else
      f=x.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")} = #{q[2]}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
      f.unshift("__**#{'Server-specific ' if saliases}#{alztyp} Aliases**__")
    end
  elsif args.length>0 && args[0].length>0 && k.nil?
    alz=args.join(' ')
    alz='>censored mention<' if alz.include?('@')
    str="The alias system can cover:\n- Servants\n- Skills (Active, Passive, Append, and Clothing skills)\n- Craft Essances\n- Materials\n- Mystic Codes (clothing)\n- Command Codes"
    str="#{str}\n\n*#{alz}* does not fall into any of these categories."
    event.respond str
    return nil
  elsif k.nil?
    nicknames_load()
    f=list_aliases(bot,event,['servants'],saliases,true)
    f.push(' ')
    f.push(list_aliases(bot,event,['crafts'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['commands'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['clothes'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['active'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['passive'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['append'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['clothngskill'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['mat'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['enemies'],saliases,true))
    f.flatten!
  else
    f=k.alias_list(bot,event,saliases)
  end
  return f if dispdata
  if (f.join("\n").length>1900 || f.length>50) && !safe_to_spam?(event)
    event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
    return nil
  end
  str=f[0]
  for i in 1...f.length
    str=extend_message(str,f[i],event)
  end
  event.respond str
end

def show_next(bot,event,args=nil,ignoreinputs=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  msg=event.message.text.downcase.split(' ')
  jp=(msg.include?('jp') || msg.include?('japan') || msg.include?('japanese'))
  jp=false if event.channel.id==682110127251390484
  jp=true if event.channel.id==657288969687531534
  mat_block=''
  mat_block=', ' if msg.include?('colorblind') || msg.include?('textmats')
  t=Time.now
  timeshift=1
  timeshift-=1 unless t.dst?
  t_na=t-60*60*timeshift
  timeshift=-8
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
      str5="~~This is displaying North America's *tomorrow*.  To show Japan's, include the word \"JP\" alongside the word \"tomorrow\".~~" unless jp || disp_date(t_na)==disp_date(t_jp) || event.channel.id==682110127251390484
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
  jp=false if event.channel.id==682110127251390484
  jp=true if event.channel.id==657288969687531534
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
  timeshift=1
  timeshift-=1 unless t.dst?
  t_na=t-60*60*timeshift
  timeshift=-8
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
    str3="~~You can include the word \"JP\" in your message to show JP data.~~" unless event.channel.id==682110127251390484
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
    mode=3 if mode==0 && ['craft','crafts','essence','essences','essance','essances','ceexp','cexp','cxp','celevel','clevel','craftexp','craftxp','craftlevel','essenceexp','essencexp','essencelevel','essanceexp','essancexp','essancelevel','craftessence','craftessences','craft-essence','craft-essences','craft_essences','craft_essence','craftessance','craftessances','craft-essance','craft-essances','craft_essances','craft_essance'].include?(args[i])
    g=1 if ['ssr','gold','hellfire'].include?(args[i])
  end
  if mode==0 && !safe_to_spam?(event)
    event.respond "Please either specify an EXP type or use this command in PM.\n\nAvailable EXP types include:\n- Player\n- Servant\n- Craft Essence"
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
    axp=[1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136,153,171,190,210,231,253,276,300,325,351,378,406,435,465,496,528,561,595,630,666,703,741,780,820,861,903,946,990,1035,1081,1128,1176,1225,1275,
         1326,1378,1431,1485,1540,1596,1653,1711,1770,1830,1891,1953,2016,2080,2145,2211,2278,2346,2415,2485,2556,2628,2701,2775,2850,2926,3300,3081,3160,3240,3321,3403,3486,3570,3655,3741,3828,3916,
         4005,4185,4549,5101,5845,6785,7925,9269,10821,12585,14565,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,203115,0]
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
      m=axp[0,120].map{|q| q*100}.inject(0){|sum,x| sum + x }
      str=extend_message(str,"<:holy_grail:523842742992764940>+ *To get from level 1 to level 120:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
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
      if n<120
        m=axp[n-1,120-n].map{|q| q*100}.inject(0){|sum,x| sum + x }
        str=extend_message(str,"<:holy_grail:523842742992764940>+ *To get from level #{n} to level 120:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,g)}",event)
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
         2628,2701,2775,2850,2926,3003,3081,3160,3240,3321,3403,3486,3570,3655,3741,3828,3916,4005,4095,4186,4278,4371,4465,4560,4656,4753,4851,4950,5050]
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

def disp_art(bot,event,args=nil,forceriyo=false,k=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if !k.nil?
  elsif ['servant','srv'].include?(args[0].downcase) || forceriyo
    args.shift unless forceriyo
    k=find_data_ex(:find_servant,args.join(' '),event)
  elsif ['ce','craft','essance','craftessance','essence','craftessence'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_ce,args.join(' '),event,false,true)
  elsif ['command','commandcode','cmd'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_code,args.join(' '),event)
  else
    k=find_best_match(args.join(' '),bot,event,false,true,2)
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  if !k.is_a?(FGOServant)
  elsif has_any?(args,["mathoo's"]) || (has_any?(args,['my']) && event.user.id==167657750971547648)
    u=$dev_units.find_index{|q| q.id==k.id}
    k=$dev_units[u].clone unless u.nil?
  elsif donate_trigger_word(event)>0
    mu=donate_trigger_word(event)
    u=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu}
    u2=$donor_units.find_index{|q| q.id==k.id && q.owner_id==mu && q.nationality=='JP'}
    u=u2*1 if !u2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
    k=$donor_units[u].clone unless u.nil?
  elsif has_any?(args,['bondce','bond','bond_ce','bonds','bond-ce'])
    c=$crafts.find_index{|q| q.id==k.bond_ce}
    k=$crafts[c].clone unless k.nil?
  elsif has_any?(args,["valentine's",'valentines','valentine','chocolate',"valentine'sce",'valentinesce','valentinece',"valentine's-ce",'valentines-ce','valentine-ce']) && !k.valentines_ce.nil? && k.valentines_ce.length>0
    for i in 0...k.valentines_ce.length
      c=$crafts.find_index{|q| q.id==k.valentines_ce[i]}
      disp_art(bot,event,args,false,$crafts[c].clone)
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  hdr="#{k.dispName('**','__')} #{k.emoji(bot,event)}"
  mx=k.portrait(bot,event,forceriyo)
  hdr="#{hdr}\n#{mx[1]}"
  xpic=[nil,mx[0]]
  ftr=mx[2]
  title=k.rarity_row
  if mx.length>4 && mx[4].id != k.id
    title=mx[4].rarity_row
    hdr="~~#{k.dispName('**','__')}~~\n#{mx[1]}"
  end
  str=''
  flds=[]
  xartist=''; vajp=[]; m=[]
  xartist=k.artist.split(' & ').map{|q| q.split(' as ')[0]}.join(' & ') unless k.artist.nil?
  if mx.length<=3 || mx[3].nil?
    m.push("**Artist:** #{k.artist.split(' & ').map{|q| q.split(' as ')[-1]}.join(' & ')}") unless k.artist.nil?
  else
    xartist=mx[3]
    m.push("**Artist:** #{xartist}")
  end
  m.push("**VA (Japanese):** #{k.voice_jp.split(' & ').map{|q| q.split(' as ')[-1]}.join(' & ')}") unless k.voice_jp.nil?
  vajp=k.voice_jp.split(' & ').map{|q| q.split(' as ')[0]} unless k.voice_jp.nil? || k.voice_jp.length<=0
  str="#{str}#{"\n\n" if str.length>0}#{m.join("\n")}"
  str="#{mx[5]}\n\n#{str}" if mx.length>5 && !mx[5].nil?
  toload=['feh']
  toload.push('dl') if event.server.nil? || !bot.user(543373018303299585).on(event.server.id).nil? || !bot.user(759369481305718806).on(event.server.id).nil? || Shardizard==4
  data_load(toload)
  fehunits=[]
  fehunits=$feh_units.map{|q| q.clone}
  dladv=[]; dldrg=[]; dlprint=[]; dlnpc=[]
  if toload.include?('dl')
    dladv=$dl_adventurers.map{|q| q.clone}
    dldrg=$dl_dragons.map{|q| q.clone}
    dlprint=$dl_wyrmprints.map{|q| q.clone}
    dlnpc=$dl_npcs.map{|q| q.clone}
  end
  adv=[$servants,$crafts,fehunits,dladv,dldrg,dlnpc].flatten.map{|q| q.clone}.uniq
  voices=[]
  for i in 0...adv.length
    a=adv[i].clone
    a.name="*Srv-#{a.id.to_i}.)* #{a.name}" if a.is_a?(FGOServant)
    a.name="*CE-#{a.id}.)* #{a.name}" if a.is_a?(FGO_CE)
    a.name="*[FEH#{"-Unit #{a.id}" if Shardizard==4 && event.user.id==167657750971547648}]* #{a.name}" if a.is_a?(FEHUnit)
    a.name="*[DL-Adv]* #{a.name}" if a.is_a?(DLAdventurer)
    a.name="*[DL-Drg]* #{a.name}" if a.is_a?(DLDragon)
    a.name="*[DL-NPC]* #{a.name}" if a.is_a?(DL_NPC)
    vajp2=[]
    vajp2=a.voice_jp.split(' & ') unless a.voice_jp.nil?
    if a.tid==k.tid && k.objt==a.objt
    elsif vajp.length<2
      voices.push(a) if !k.voice_jp.nil? && k.voice_jp==a.voice_jp
    elsif vajp2.length<2
      vajp2=vajp2[0]
      j=[]
      for i2 in 0...vajp.length
        j.push("#{i2+1}") if vajp[i2]==vajp2
      end
      a.name="#{a.name} *[Voice #{j.join('+')}]*"
      voices.push(a) if j.length>0
    end
  end
  adv=[$servants,$crafts,fehunits,dlprint].flatten.map{|q| q.clone}.uniq
  artists=[]
  for i in 0...adv.length
    a=adv[i].clone
    a.name="*Srv-#{a.id.to_i}.)* #{a.name}" if a.is_a?(FGOServant)
    a.name="*CE-#{a.id}.)* #{a.name}" if a.is_a?(FGO_CE)
    a.name="*[DL-Print]* #{a.name}" if a.is_a?(DLPrint)
    if a.artist.nil? || a.artist.length<=0 || (a.tid==k.tid && a.objt==k.objt)
    elsif a.is_a?(FEHUnit)
      if a.artist[0].split(' as ')[0]==xartist
        a.name="*[FEH#{"-Unit #{a.id}" if Shardizard==4 && event.user.id==167657750971547648}]* #{a.name}"
        artists.push(a)
      elsif a.artist.length>1 && a.artist[1].split(' as ')[0]==xartist
        a.name="*[FEH-Resplendent#{" #{a.id}" if Shardizard==4 && event.user.id==167657750971547648}]* #{a.name}"
        artists.push(a)
      end
    else
      artists.push(a) if a.artist.split(' as ')[0]==xartist
    end
  end
  unless artists.length<=0
    artists=artists.sort{|a,b| (a.objt2<=>b.objt2)==0 ? ((a.tid<=>b.tid)==0 ? (a.name<=>b.name) : (a.tid<=>b.tid)) : (a.objt2<=>b.objt2)}.map{|q| q.name}.uniq
    flds.push(['Same artist',artists.uniq.join("\n")])
  end
  unless voices.length<=0
    voices=voices.sort{|a,b| (a.objt2<=>b.objt2)==0 ? ((a.tid<=>b.tid)==0 ? (a.name<=>b.name) : (a.tid<=>b.tid)) : (a.objt2<=>b.objt2)}; voices.uniq!
    voices=voices.map{|q| q.name}; voices.uniq!
    flds.push(['Same VA',voices.uniq.join("\n")])
  end
  if k.is_a?(FGOServant) && !k.is_a?(SuperServant)
    adv=$crafts.map{|q| q.clone}
    appearances=[]
    for i in 0...adv.length
      a=adv[i].clone
      appearances.push("CE-#{a.id}.) #{a.name}") if !a.servants.nil? && a.servants.include?(k.id.to_i)
    end
    flds.push(['Appears in these CEs',appearances.uniq.join("\n")]) if appearances.length>0
  elsif k.is_a?(FGO_CE) && !k.servants.nil?
    adv=k.servants.map{|q| q}
    srv=[]
    for i in 0...adv.length
      a=$servants.find_index{|q| q.id.to_i==adv[i]}
      unless a.nil?
        a=$servants[a].clone
        srv.push("Srv-#{a.id}.) #{a.name}") if k.servants.include?(a.id.to_i)
      end
    end
    flds.push(['Contains these servants',srv.uniq.join("\n")]) if srv.length>0
  end
  m=flds.map{|q| q[1].split("\n").length}
  flds=flds.map{|q| q[0,2]} if flds.length<3
  titlength=0
  titlength=title.length unless title.nil?
  if m.inject(0){|sum,x2| sum + x2 }>25 && !safe_to_spam?(event)
    str="#{str}\n\nThere were too many datapoints to display them all.  Please use this command in PM."
    flds=[]
  elsif flds.length<=0
  elsif flds.length<=1 && !($embedless.include?(event.user.id) || was_embedless_mentioned?(event)) && flds[0][1].split("\n").length<=5
    str="#{str}\n\n__*#{flds[0][0]}*__\n#{flds[0][1]}"
    flds=[]
  elsif flds.length<=1 && !($embedless.include?(event.user.id) || was_embedless_mentioned?(event))
    str="#{str}\n\n#{flds[0][0]}"
    flds=triple_finish(flds[0][1].split("\n"),true)
  elsif $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || hdr.length+titlength+str.length+flds.map{|q| "__*#{q[0]}*__\n#{q[1]}"}.join("\n\n").length>1900 || m.max>25
    str2=''
    for i in 0...flds.length
      if "**#{flds[i][0]}:** #{flds[i][1].gsub("\n",' - ')}".length>1500
        flds[i][1]=flds[i][1].split("\n")
        str2=extend_message(str2,"**#{flds[i][0]}:** #{flds[i][1][0]}",event)
        for i2 in 1...flds[i][1].length
          str2=extend_message(str2,flds[i][1][i2],event,1,' - ')
        end
      else
        str2=extend_message(str2,"**#{flds[i][0]}:** #{flds[i][1].gsub("\n",' - ')}",event)
      end
    end
    event.respond str2
    flds=[]
  end
  flds=flds.reject{|q| q[1].length<=0}
  flds=nil if flds.length<=0
  create_embed(event,[hdr,title],str,k.disp_color,ftr,xpic,flds)
  event.respond xpic[1] if $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
end

def affinity_data(event,bot,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.reject{ |a| a.downcase=='smol' } if Shardizard==4
  args=args.map{|q| q.downcase}
  clzz=''
  lookout=[]
  if File.exist?("#{$location}devkit/FGOSkillSubsets.txt")
    lookout=[]
    File.open("#{$location}devkit/FGOSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  dmg=false
  lookout2=lookout.reject{|q| q[2]!='Class'}
  for i in 0...args.length
    clzz='Saber' if ['saber','sabers','seiba','seibas'].include?(args[i]) && clzz.length<=0
    clzz='Archer' if ['archer','bow','sniper','archa','archers','bows','snipers','archas'].include?(args[i]) && clzz.length<=0
    clzz='Lancer' if ['lancer','lancers','lance','lances'].include?(args[i]) && clzz.length<=0
    clzz='Rider' if ['rider','riders','raida','raidas'].include?(args[i]) && clzz.length<=0
    clzz='Caster' if ['caster','casters','castor','castors','mage','mages','magic'].include?(args[i]) && clzz.length<=0
    clzz='Assassin' if ['assassin','assasshin','assassins','assasshins'].include?(args[i]) && clzz.length<=0
    clzz='Berserker' if ['berserker','berserkers','berserk','berserks','zerker','zerkers'].include?(args[i]) && clzz.length<=0
    clzz='Shielder' if ['shielder','shielders','shield','shields','sheilder','sheilders','sheild','sheilds','extra','extras'].include?(args[i]) && clzz.length<=0
    clzz='Ruler' if ['ruler','rulers','king','kings','queen','queens','leader','leaders'].include?(args[i]) && clzz.length<=0
    for i2 in 0...lookout2.length
      clzz=lookout2[i2][0] if lookout2[i2][1].include?(args[i]) && clzz.length<=0
    end
  end
  str=''
  xcolor=0xED619A
  xpic=nil
  if clzz.length<=0
    k=find_data_ex(:find_servant,args.join(' '),event)
    if k.nil?
      clzz='Default Affinity'
      xpic='https://cdn.discordapp.com/emojis/523838967058006027.png?v=1'
    else
      str="*Servant:* #{k.dispName('','')} #{k.emoji(bot,event)}\n*Class:* "
      clzz=k.clzz
      xpic=k.thumbnail(event)
      xcolor=k.disp_color
    end
  else
    moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{clzz.downcase.gsub(' ','')}_silver"}
    xpic=moji[0].icon_url if moji.length>0
  end
  str="#{str}**#{clzz}**"
  str=str.split("\n"); str[-1]="__#{str[-1]}__"; str=str.join("\n")
  title=''
  data=[100,10,100]
  data=[95,8,150] if clzz=='Archer'
  data=[105,12,90] if clzz=='Lancer'
  data=[100,9,200] if clzz=='Rider'
  data=[90,25,100] if clzz=='Assassin'
  data=[90,11,50] if clzz=='Caster'
  data=[110,5,10] if clzz=='Berserker'
  data=[110,10,100] if clzz=='Ruler'
  data=[100,15,50] if clzz=='Moon Cancer'
  data=[110,6,30] if clzz=='Avenger'
  data=[110,15,150] if clzz=='Foreigner'
  data=[100,20,100] if clzz=='Pretender'
  unless k.nil?
    data[2]=k.crit_star[0]
    data[1]=k.crit_star[1]
  end
  title="*Base Damage modifier:* #{data[0]}%"
  title="#{title}\n*Crit Star Drop Rate:* #{data[1]}%"
  title="#{title}\n*Crit Star Absorb Weight:* #{data[2]}%"
  atk=[0,0,0,0,0,0,2,-1,0,0,0,0,0]
  defn=[0,0,0,0,0,0,1,0,0,0,0,0,0]
  if clzz=='Shielder'
    for i in 0...atk.length
      atk[i]=0; defn[i]=0
    end
  elsif clzz=='Saber'
    atk[1]=-1; defn[1]=2
    atk[2]=2; defn[2]=-1
  elsif clzz=='Archer'
    atk[2]=-1; defn[2]=2
    atk[0]=2; defn[0]=-1
  elsif clzz=='Lancer'
    atk[0]=-1; defn[0]=2
    atk[1]=2; defn[1]=-1
  elsif clzz=='Rider'
    atk[4]=-1; defn[4]=2
    atk[5]=2; defn[5]=-1
  elsif clzz=='Assassin'
    atk[5]=-1; defn[5]=2
    atk[3]=2; defn[3]=-1
  elsif clzz=='Caster'
    atk[3]=-1; defn[3]=2
    atk[4]=2; defn[4]=-1
  elsif clzz=='Berserker'
    for i in 0...atk.length
      atk[i]=1; defn[i]=2
    end
    atk[11]=-1; defn[6]=1
  elsif clzz=='Ruler'
    for i in 0...6
      defn[i]=-1
    end
    atk[7]=0; atk[8]=-1; atk[9]=2
    defn[8]=2; defn[9]=-1
  elsif clzz=='Avenger'
    atk[9]=-1; defn[9]=2
    atk[7]=2; defn[7]=-1
  elsif clzz=='Moon Cancer'
    atk[7]=-1; defn[7]=2
    atk[8]=2; defn[8]=-1
  elsif clzz=='Alter Ego'
    for i in 0...3
      atk[i]=-1; atk[i+3]=1
    end
    atk[7]=0
    atk[11]=1; defn[11]=-1
    atk[12]=-1; defn[12]=2
  elsif clzz=='Foreigner'
    atk[7]=0; defn[6]=-1
    atk[10]=-1; defn[10]=1
    atk[11]=2; defn[11]=2
    atk[12]=2; defn[12]=-1
  elsif clzz=='Pretender'
    atk[10]=2; defn[10]=-1
    atk[11]=-1; defn[11]=2
    atk[0]=1; atk[1]=1; atk[2]=1
    atk[3]=-1; atk[4]=-1; atk[5]=-1
    atk[7]=0
  end
  atk[7]=1 if !k.nil? && k.id==167
  defn[10]=-1 if ['Saber','Archer','Lancer'].include?(clzz)
  defn[10]=1 if ['Rider','Assassin','Caster'].include?(clzz)
  defn[12]=1 if ['Saber','Archer','Lancer'].include?(clzz)
  defn[12]=-1 if ['Rider','Assassin','Caster'].include?(clzz)
  atk.unshift(0); defn.unshift(0)
  classes=['Shielder','Saber','Archer','Lancer','Rider','Assassin','Caster','Berserker','Ruler','Avenger','Moon Cancer','Alter Ego','Foreigner','Pretender']
  for i in 0...atk.length
    m=['silver',100+50*atk[i]]
    m[0]='bronze' if atk[i]<0
    m[0]='gold' if atk[i]>0
    m2=['silver',100+50*defn[i]]
    m2[0]='bronze' if defn[i]>0
    m2[0]='gold' if defn[i]<0
    moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{classes[i].downcase.gsub(' ','')}_#{m[0]}"}
    moji2=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{classes[i].downcase.gsub(' ','')}_#{m2[0]}"}
    atk[i]="#{moji[0].mention unless moji.length<=0}#{classes[i]}: #{m[1]}%"
    defn[i]="#{moji2[0].mention unless moji.length<=0}#{classes[i]}: #{m2[1]}%"
    if k.nil?
    elsif k.id==175 && defn[i]>0
      defn[i]="#{defn[i]} (100% after S2)"
    elsif k.id==199 && classes[i]=='Caster'
      atk[i]="#{atk[i]} (100% after S2)"; defn[i]="#{defn[i]} (100% after S2)"
    elsif k.id==239 && classes[i]=='Alter Ego'
      atk[i]="#{atk[i]} (200% after S3)"; defn[i]="#{defn[i]} (50% after S3)"
    end
  end
  if safe_to_spam?(event,nil,1)
    atk[0]="__#{atk[0]}__"; defn[0]="__#{defn[0]}__"
    atk[7]="__#{atk[7]}__"; defn[7]="__#{defn[7]}__"
  else
    atk=atk.reject{|q| q.include?(' 100%') && !q.include?(' after ')}
    defn=defn.reject{|q| q.include?(' 100%') && !q.include?(' after ')}
  end
  flds=[['Offense',atk.join("\n")],['Defense',defn.join("\n")]]
  flds=flds.reject{|q| q[1].nil? || q[1].length<=0}
  text="Bronze icons mark unfavorable matchups."
  text="#{text}\nSilver icons mark neutral matchups." if safe_to_spam?(event,nil,1)
  text="#{text}\nGold icons mark favorable matchups."
  text="#{text}\nFor brevity, neutral matchups are not shown." unless safe_to_spam?(event,nil,1)
  ftr='Affinities can be adjusted by certain skills and NPs, which usually remove defense disadvantages.'
  ftr="This servant becomes servant #81.1 when he uses his Noble Phantasm." if !k.nil? && k.id==81.0 
  ftr="This servant comes from servant #81.0 when he uses his Noble Phantasm." if !k.nil? && k.id==81.1
  if flds.length<=0
    flds=nil; ftr=nil
    text="All affinities are neutral."
  elsif clzz=='Beast'
    flds=nil; ftr=nil
    text="Special affinities have been granted by story, are not formulaic."
    xcolor=0x800000
  end
  create_embed(event,[str,title],text,xcolor,ftr,xpic,flds)
end

def show_tools(bot,event)
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || event.message.text.downcase.include?('mobile') || event.message.text.downcase.include?('phone')
    event << '**Useful tools for players of** ***Fate/Grand Order***'
    event << '__Download the game__'
    event << 'Google Play (NA): <https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US>'
    event << 'Google Play (JP): <https://play.google.com/store/apps/details?id=com.xiaomeng.fategrandorder&hl=en_US>'
    event << 'Apple App Store (NA): <https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8>'
    event << 'Apple App Store (JP): <https://itunes.apple.com/jp/app/fate-grand-order/id1015521325?l=en&mt=8>'
    event << ''
    event << '__Current Master Missions__'
    event << 'North America: <http://fate-go.cirnopedia.org/master_mission_us.php>'
    event << 'Japan: <http://fate-go.cirnopedia.org/master_mission.php>'
    event << ''
    event << '*Learning With Manga*: <https://fate-go.us/manga_fgo2/>'
    event << ''
    event << '__Wikis and databases__'
    event << 'Cirnopedia: <https://fate-go.cirnopedia.org>'
    event << ''
    event << '__Important lists and spreadsheets__'
    event << 'Interlude info: <https://goo.gl/SCsKJn>' if safe_to_spam?(event)
    event << 'Material location guide: <https://goo.gl/ijqefs>'
    event << 'List of Singularity maps with drops: <https://imgur.com/a/6nXq9#f8dRAp5>'
    event << 'Rate-up History (NA): <http://fate-go.cirnopedia.org/summon_us.php>'
    event << 'Rate-up History (JP): <http://fate-go.cirnopedia.org/summon.php>'
    event << 'Order of Interludes and Strengthening Quests: <https://kazemai.github.io/fgo-vz/relate_quest.html>' if safe_to_spam?(event)
    event << 'Palingenesis data: <https://fate-go.cirnopedia.org/servant_palingenesis.php>' if safe_to_spam?(event)
    event << ''
    event << '__Calculators and Planners__'
    event << 'Damage calculator: <https://tinyurl.com/yc2tuzn9>'
    event << 'EXP calculator: <https://grandorder.gamepress.gg/exp-calculator>'
    event << 'Material planner: <http://fgosimulator.webcrow.jp/Material/>'
    event << 'Servant planner: <https://grandorder.gamepress.gg/servant-planner>'
    event << 'Daily mats: <https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Mats.png>' if safe_to_spam?(event)
    if safe_to_spam?(event)
      event << ''
      event << '__Cirno direct links__'
      event << 'Servants: <https://fate-go.cirnopedia.org/servant_all.php>'
      event << 'Craft Essences: <https://fate-go.cirnopedia.org/craft_essence.php>'
      event << 'Command Codes: <https://fate-go.cirnopedia.org/command_code.php>'
    end
  else
    xpic='https://lh3.googleusercontent.com/gXUStNHv8sT8NjdXBOJmzqK_JIYlPP_6jKBjEOIyP-28CSsnPempO86swUYhVhVgvH4f=s180-rw'
    t=Time.now
    xpic='https://vignette.wikia.nocookie.net/fategrandorder/images/a/ac/FGO_GO_App_Icon.png' if t.month==4 && t.day==1
    str="__Download the game__"
    str="#{str}\n[Google Play (NA)](https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US)"
    str="#{str}  \u00B7  [Google Play (JP)](https://play.google.com/store/apps/details?id=com.xiaomeng.fategrandorder&hl=en_US)"
    str="#{str}\n[Apple App Store (NA)](https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8)"
    str="#{str}  \u00B7  [Apple App Store (JP)](https://itunes.apple.com/jp/app/fate-grand-order/id1015521325?l=en&mt=8)"
    str="#{str}\n\n__Current Master Missions__"
    str="#{str}\n[North America](http://fate-go.cirnopedia.org/master_mission_us.php)"
    str="#{str}\n[Japan](http://fate-go.cirnopedia.org/master_mission.php)"
    str="#{str}\n\n[*Learning With Manga*](https://fate-go.us/manga_fgo2/)"
    str="#{str}\n\n__Wikis and databases__"
    str="#{str}\n[Cirnopedia](https://fate-go.cirnopedia.org)"
    str="#{str}\n\n__Important lists and spreadsheets__"
    str="#{str}\n[Interlude info](https://goo.gl/SCsKJn)" if safe_to_spam?(event)
    str="#{str}\n[Material location guide](https://goo.gl/ijqefs)"
    str="#{str}\n[List of Singularity maps with drops](https://imgur.com/a/6nXq9#f8dRAp5)"
    str="#{str}\n[Rate-up History (NA)](http://fate-go.cirnopedia.org/summon_us.php)"
    str="#{str}  \u00B7  [Rate-up History (JP)](http://fate-go.cirnopedia.org/summon.php)"
    str="#{str}\n[Order of Interludes and Strengthening Quests](https://kazemai.github.io/fgo-vz/relate_quest.html)" if safe_to_spam?(event)
    str="#{str}\n[Palingenesis data](https://fate-go.cirnopedia.org/servant_palingenesis.php)" if safe_to_spam?(event)
    str="#{str}\n\n__Calculators and Planners__"
    str="#{str}\n[Damage Calculator](https://tinyurl.com/yc2tuzn9)"
    str="#{str}\n[EXP calculator](https://grandorder.gamepress.gg/exp-calculator)"
    str="#{str}\n[Material planner](http://fgosimulator.webcrow.jp/Material/)"
    str="#{str}\n[Servant planner](https://grandorder.gamepress.gg/servant-planner)"
    str="#{str}\n[Daily mats](https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/Mats.png)" if safe_to_spam?(event)
    if safe_to_spam?(event)
      str="#{str}\n\n__Cirno direct links__"
      str="#{str}\n[Servants](https://fate-go.cirnopedia.org/servant_all.php)"
      str="#{str}\n[Craft Essences](https://fate-go.cirnopedia.org/craft_essence.php)"
      str="#{str}\n[Command Codes](https://fate-go.cirnopedia.org/command_code.php)"
    end
    create_embed(event,'**Useful tools for players of** ***Fate/Grand Order***',str,0xED619A,nil,xpic)
    event.respond 'If you are on a mobile device and cannot click the links in the embed above, type `FGO!tools mobile` to receive this message as plaintext.'
  end
  event << ''
end

def show_servant_alts(event,bot,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.reject{ |a| a.downcase=='smol' } if @shardizard==4
  args=args.map{|q| q.downcase}
  k=find_data_ex(:find_servant,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  xcolor=k.disp_color
  data_load()
  srvs=$servants.reject{|q| q.alts[0]!=k.alts[0]}
  universes=srvs.map{|q| q.alts[1]}.sort.uniq
  flds=[]
  flds2=[]
  flds3=[]
  dispstr=''
  dispstr2=''
  if universes.length>1
    for i in 0...universes.length
      str=''
      str2=''
      unisrvs=srvs.reject{|q| q.alts[1]!=universes[i]}
      facets=unisrvs.map{|q| q.alts[2]}.sort.uniq
      flds2.push(["__Universe #{i+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}**__",avg_color(unisrvs.map{|q| q.disp_color(0,1)}),"#{unisrvs.length} alt#{'s' unless unisrvs.length==1} from this universe",[],''])
      if facets.length>1
        for i2 in 0...facets.length
          facsrvs=unisrvs.reject{|q| q.alts[2]!=facets[i2]}
          str="#{str}\n\n__Facet #{i2+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}#{" (#{facets[i2]})" unless facets[i2]=='-'}**__"
          str="#{str}\n#{facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}"
          str2="#{str2}\n\n__Facet #{i2+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}#{" (#{facets[i2]})" unless facets[i2]=='-'}**__"
          str2="#{str2}\n#{facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event,1)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}"
          flds2[-1][3].push(["Facet #{i2+1}: #{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}#{" (#{facets[i2]})" unless facets[i2]=='-'}",facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n"),true])
        end
        flds.push(["Universe #{i+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}**",str,true])
        flds3.push(["Universe #{i+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}**",str2,true])
      else
        flds2[-1][4]="#{unisrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}"
        flds.push(["Universe #{i+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}**",flds2[-1][4],true])
        flds3.push(["Universe #{i+1}: **#{k.alts[0]}#{" (#{universes[i]})" unless universes[i]=='-'}**","#{unisrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event,1)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}",true])
        flds2[-1][3]=nil
      end
    end
  else
    facets=srvs.map{|q| q.alts[2]}.sort.uniq
    if facets.length>1
      for i in 0...facets.length
        facsrvs=srvs.reject{|q| q.alts[2]!=facets[i]}
        str="#{facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}"
        str2="#{facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event,1)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")}"
        flds.push(["Facet #{i+1}: **#{k.alts[0]}#{" (#{facets[i]})" unless facets[i]=='-'}**",str,true])
        flds3.push(["Facet #{i+1}: **#{k.alts[0]}#{" (#{facets[i]})" unless facets[i]=='-'}**",str2,true])
        flds2.push(["__Facet #{i+1}: **#{k.alts[0]}#{" (#{facets[i]})" unless facets[i]=='-'}**__",avg_color(facsrvs.map{|q| q.disp_color(0,1)}),"this facet has #{facsrvs.length} alt#{'s' unless facsrvs.length==1}",nil,facsrvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n"),true])
      end
    else
      flds=nil
      flds3=nil
      dispstr=srvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")
      dispstr2=srvs.map{|q| "#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name}#{q.emoji(bot,event,1)}#{" - #{q.alts[3]}" unless q.alts[3]=='-'}"}.join("\n")
    end
  end
  if !flds.nil? && dispstr.length+flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n").length>1500
    if !safe_to_spam?(event)
      if !flds3.nil? && dispstr2.length+flds3.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n").length>1500
        event.respond "Too many alts are being displayed.  Please use this command in PM."
      else
        create_embed(event,"__**#{k.alts[0]}**__",dispstr2,avg_color(srvs.map{|q| q.disp_color(0,1)}),"#{srvs.length} total",nil,flds3)
      end
      return nil
    end
    for i in 0...flds2.length
      create_embed(event,"#{flds2[i][0]}",flds2[i][4],flds2[i][1],flds2[i][2],nil,flds2[i][3])
    end
    event.respond "#{srvs.length} total alts"
  else
    create_embed(event,"__**#{k.alts[0]}**__",dispstr,avg_color(srvs.map{|q| q.disp_color(0,1)}),"#{srvs.length} total",nil,flds)
  end
end

def generate_random_servant(event,bot)
  d1=['Q','A','B'].sample; d2=['Q','A','B'].sample; np=['Q','A','B'].sample
  deck="Q#{d1 if d1=='Q'}#{d2 if d2=='Q'}A#{d1 if d1=='A'}#{d2 if d2=='A'}B#{d1 if d1=='B'}#{d2 if d2=='B'}"
  xrarity=rand(5)+1
  xrarity-=1 if rand(1000)<=0
  x=['Alter Ego','Avenger','Foreigner','Moon Cancer','Ruler','Shielder']
  x.push('Beast') if rand(1000)<=0
  xclzz=['Saber','Lancer','Archer','Assassin','Caster','Rider','Berserker'].sample
  xclzz=x.sample if rand(1000)<=0
  alter=''
  alter=' (Alter)' if rand(5)<=0
  alter=" (#{['Maid','Santa'].sample} Alter)" if rand(50)<=0
  imgx=event.user
  imgx=event.message.mentions.sample if event.message.mentions.length>0
  img=imgx.avatar_url
  title="**Class:** #{xclzz}"
  att=['Man','Earth','Sky','Star'].sample
  att='Beast' if rand(1000)<=0
  title="#{title}\n**Attribute:** #{att}"
  halg=['Chaotic','Neutral','Lawful'].sample
  valg=['Good','Balanced','Evil'].sample
  valg=['Summer','Bride','Maid'].sample if rand(100)<=0
  title="#{title}\n**Alignment:** #{halg} #{valg}"
  text="<:fgo_icon_rarity:523858991571533825>"*xrarity
  text="**0-star**" if xrarity==0
  rarstats=[[65,4],[60,3],[65,4],[70,7],[80,12],[90,16]]
  text="#{text}\n**Max. default level:** *#{rarstats[xrarity][0]}*"
  text="#{text} (#{['Linear','S','Reverse S','Semi S','Semi Reverse S'].sample} growth curve)"
  t=rarstats[xrarity][1]
  t=0 if xclzz=='Shielder' && rand(2)==0
  text="#{text}\n**Team cost:** *#{t}*"
  cemoji=['<:quick:523854796692783105>','<:arts:523854803013730316>','<:buster:523854810286391296>']
  text="#{text}\n\n**Command Deck:** #{deck.gsub('Q',cemoji[0]).gsub('A',cemoji[1]).gsub('B',cemoji[2])} (#{deck})"
  text="#{text}\n**Noble Phantasm:** #{np.gsub('Q',cemoji[0]).gsub('A',cemoji[1]).gsub('B',cemoji[2])} (#{np.gsub('Q','Quick').gsub('A','Arts').gsub('B','Buster')})"
  typs=['Personnel','Fortress','Army']
  typs.push('Evil') unless valg=='Evil'
  typs=['Encampment','World','Magecraft','Barrier','Divine','Demon','Populace','Wave','Dragon','Mountain','Purge','King','Beast','Boundary'] if rand(10)<=0
  type=typs.sample
  type="Anti-#{type}"
  type=['Magic','Spirit','War Outbreak','Poetry'].sample if rand(10)<=0
  type="#{type}#{[' Hidden Technique',' Mystic Technique','(Self)',' (Encampment)'].sample}" if rand(100)<=0
  type='???' if rand(1000)<=0
  target=['All Allies','All Enemies','Enemy','Self'].sample
  target=['All Enemies','Enemy'].sample if np=='B'
  text="#{text}\n*Type:* #{type}  -  *Target:* #{target}"
  data_load()
  f=$servants.reject{|q| q.rarity !=xrarity && q.clzz !=xclzz}
  f=$servants.reject{|q| q.clzz !=xclzz} if xclzz=='Beast'
  f=(f.map{|q| q.death_rate}.max*10).to_i
  death=rand(f)+1
  death=rand(f)+1 if death>f/6
  death=rand(f)+1 if death>f/5
  death=rand(f)+1 if death>f/4
  death=rand(f)+1 if death>f/3
  death=rand(f)+1 if death>f/2
  f=$servants.reject{|q| q.rarity !=xrarity || q.clzz !=xclzz}
  f=$servants.reject{|q| q.clzz !=xclzz} if f.length<=1
  text="#{text}\n\n**Death Rate:** #{death/10}.#{death%10}%"
  f2=f.map{|q| q.hit_count}
  f2.push([3,3,3,3,3])
  text="#{text}\n\n**Hit Counts:**"
  text="#{text} <:Quick_y:526556106986618880>#{rand(f2.map{|q| q[0]}.max)+1}"
  text="#{text} <:Arts_y:526556105489252352>#{rand(f2.map{|q| q[1]}.max)+1}"
  text="#{text} <:Buster_y:526556105422274580>#{rand(f2.map{|q| q[2]}.max)+1}"
  text="#{text} <:Extra_y:526556105388720130>#{rand(f2.map{|q| q[3]}.max)+1}"
  text="#{text}  \u00B7  <:NP:523858635843960833>#{rand(f2.map{|q| q[4]}.max)+1}"
  f2=f.map{|q| [q.np_gain[0]*100-3,0].max}
  text="#{text}\n**NP Gain:**"
  text="#{text}  *Attack:* #{(rand(f2.max)+3)/100.0}%"
  f2=f.map{|q| q.np_gain[1]}; f2.push(3)
  text="#{text}  \u00B7  *Defense:* #{rand(f2.max)+1}%"
  f2=f.map{|q| q.crit_star[0]}
  text="#{text}\n**Crit Stars:**"
  text="#{text}  *Weight:* #{(rand(f2.max-f2.min)+f2.min).to_i}"
  f2=f.map{|q| (q.crit_star[1]*10).to_i}
  f2=rand(f2.max-f2.min)+f2.min
  text="#{text}  \u00B7  *Drop Rate:* #{(f2/10).to_i}.#{(f2%10).to_i}%"
  color='gold'
  color='silver' if xrarity<4
  color='bronze' if xrarity<3
  color='black' if xrarity<1
  moji=bot.server(523821178670940170).emoji.values.reject{|q| q.name.downcase != "class_#{xclzz.downcase.gsub(' ','')}_#{color}"}
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
  clsmoji='<:class_beast_gold:562413138356731905>' if xclzz=='Beast'
  name="__**#{imgx.name.gsub('(','').gsub(')','')}#{" (#{xclzz})" unless alter.include?(' Alter')}#{alter}**__ [Srv-*i*]#{clsmoji}"
  xcolor=[237,97,154]
  xcolor=[33,188,44] if np=='Q'
  xcolor=[11,77,223] if np=='A'
  xcolor=[254,33,22] if np=='B'
  m=[]
  m.push(xcolor)
  m.push(xcolor)
  m.push([33,188,44]) if deck[1,1]=='Q'
  m.push([33,188,44]) if deck[1,2]=='QQ'
  m.push([254,33,22]) if deck[3,1]=='B'
  m.push([254,33,22]) if deck[2,2]=='BB'
  m.push([11,77,223]) if deck.include?('AA')
  m.push([11,77,223]) if deck.include?('AAA')
  xcolor=avg_color(m)
  create_embed(event,[name,title],text,xcolor,nil,img)
end

def dsort(s)
  return 1 if s=='Q' || s=='Quick'
  return 2 if s=='A' || s=='Arts'
  return 3 if s=='B' || s=='Buster'
  return 4 if s=='E' || s=='Extra'
  return 5
end

def get_multiple_servants(bot,event,args=[],maxthings=0,includeunaffected=false)
  args=event.message.text.downcase.split(' ') if args.nil? || args.length<=0
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  data_load()
  event.channel.send_temporary_message('Calculating data, please wait...',5) rescue nil
  a=true
  s=args.join(' ')
  s2="#{s}"
  k=[]
  u=0
  while a && s.length>0
    args=s.split(' ')
    x=find_data_ex(:find_servant,args.join(' '),event,false,nil,nil,true)
    if x.nil?
      a=false
    else
      k.push(x[0])
      s=first_sub(s,x[1],'')
      u+=1
      s2=first_sub(s2,x[1],x[0].name.gsub(' ','_'))
    end
    a=false if maxthings>0 && u>=maxthings
  end
  return [k.flatten,s2] if includeunaffected
  return k.flatten
end

def generate_deck(event,bot,args=nil)
  event.channel.send_temporary_message('Calculating data, please wait...',event.message.text.length/30+1) rescue nil
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.reject{ |a| a.downcase=='smol' } if @shardizard==4
  args=args.map{|q| q.downcase}
  args2=args.map{|q| q}
  srv=get_multiple_servants(bot,event,args,0)
  srv2=[]
  srv3=0
  for i in 0...srv.length
    unless srv2.map{|q| q.id.to_i}.reject{|q| srv[i].id.to_i != q}.length+srv3>=2
      srv2.push(srv[i].clone)
      if srv2.map{|q| q.id.to_i}.reject{|q| srv[i].id.to_i != q}.length>=2
        srv3=1
        srv2[-1].name="#{srv2[-1].name} (SUPPORT)"
      end
    end
  end
  srv=srv2.map{|q| q}
  x=false
  if srv.length>3
    srv=srv[0,3]
    x=true
  end
  deck=[0,0,0]
  deck2=[]
  np=[0,0,0]
  for i in 0...srv.length
    k=srv[i].deck[0,5]
    if k=='QQQAB'
      deck[0]+=3
      deck2.push('Q')
      deck2.push('Q')
      deck2.push('Q')
    elsif k[0,2]=='QQ'
      deck[0]+=2
      deck2.push('Q')
      deck2.push('Q')
    else
      deck[0]+=1
      deck2.push('Q')
    end
    if k=='QAAAB'
      deck[1]+=3
      deck2.push('A')
      deck2.push('A')
      deck2.push('A')
    elsif k.include?('AA')
      deck[1]+=2
      deck2.push('A')
      deck2.push('A')
    else
      deck[1]+=1
      deck2.push('A')
    end
    if k=='QABBB'
      deck[2]+=3
      deck2.push('B')
      deck2.push('B')
      deck2.push('B')
    elsif k[3,2]=='BB'
      deck[2]+=2
      deck2.push('B')
      deck2.push('B')
    else
      deck[2]+=1
      deck2.push('B')
    end
    np[0]+=1 if srv[i].deck[6,1]=='Q'
    np[1]+=1 if srv[i].deck[6,1]=='A'
    np[2]+=1 if srv[i].deck[6,1]=='B'
    if srv[i].deck.include?('[')
      k=srv[i].deck.split('[')[1].gsub(srv[i].deck[6,1],'')
      np[0]+=1 if k.include?('Q')
      np[1]+=1 if k.include?('A')
      np[2]+=1 if k.include?('B')
    end
  end
  len='%.2f'
  len='%.4f' if @shardizard==4 && safe_to_spam?(event)
  deck2=deck2.combination(5).to_a.map{|q| q.sort{|a,b| dsort(a) <=> dsort(b)}.join('')}
  str="__**Included servants**__\n#{srv.map{|q| "Srv-#{q.id}#{'.' unless q.id<2 || q.id.to_i==81}) #{q.name} - #{q.deck[0,5].gsub('Q','<:Quick_x:523975575329701902>').gsub('A','<:Arts_x:523975575552000000>').gsub('B','<:Buster_x:523975575359193089>')} - #{q.deck[6,1].gsub('Q','<:Quick_xNP:523979766731243527>').gsub('A','<:Arts_xNP:523979767016325121>').gsub('B','<:Buster_xNP:523979766911598632>')}#{" [#{q.deck.split('[')[1].gsub(']','').gsub('Q','<:Quick_xNP:523979766731243527>').gsub('A','<:Arts_xNP:523979767016325121>').gsub('B','<:Buster_xNP:523979766911598632>')}]" if q.deck.include?('[')}"}.join("\n")}#{"\n~~Only the first three names were included~~" if x}"
  str2="__**Chain Probabilities**__"
  x=deck2.reject{|q| !q.include?('QQQ')}.length*100.0/deck2.length
  str2="#{str2}#{"\n" if safe_to_spam?(event,nil,1)}\n<:Quick_y:526556106986618880> *Quick chain:* #{(len % x)}%"
  if safe_to_spam?(event,nil,1)
    x=deck2.reject{|q| !q.include?('QQ')}.length*100.0/deck2.length
    str2="#{str2}\n<:Quick_xNP:523979766731243527> #{(len % x)}% with a Quick NP up" if np[0]>0
    x=deck2.reject{|q| !q.include?('Q')}.length*100.0/deck2.length
    str2="#{str2}\n<:Quick_xNP:523979766731243527> #{(len % x)}% with two Quick NPs up" if np[0]>1
    str2="#{str2}\n<:Quick_xNP:523979766731243527> 100.00#{'00' if @shardizard==4}% with three Quick NPs up" if np[0]>2
  else
    x=deck2.reject{|q| !q.include?('QQ')}.length*100.0/deck2.length
    str2="#{str2} - #{('%.0f' % x)}% <:Quick_xNP:523979766731243527>#{micronumber(1)}" if np[0]>0
    x=deck2.reject{|q| !q.include?('Q')}.length*100.0/deck2.length
    str2="#{str2}, #{('%.0f' % x)}% <:Quick_xNP:523979766731243527>#{micronumber(2)}" if np[0]>1
    str2="#{str2}, 100% <:Quick_xNP:523979766731243527>#{micronumber(3)}" if np[0]>2
  end
  x=deck2.reject{|q| !q.include?('AAA')}.length*100.0/deck2.length
  str2="#{str2}#{"\n" if safe_to_spam?(event,nil,1)}\n<:Arts_y:526556105489252352> *Arts chain:* #{(len % x)}%"
  if safe_to_spam?(event,nil,1)
    x=deck2.reject{|q| !q.include?('AA')}.length*100.0/deck2.length
    str2="#{str2}\n<:Arts_xNP:523979767016325121> #{(len % x)}% with an Arts NP up" if np[1]>0
    x=deck2.reject{|q| !q.include?('A')}.length*100.0/deck2.length
    str2="#{str2}\n<:Arts_xNP:523979767016325121> #{(len % x)}% with two Arts NPs up" if np[1]>1
    str2="#{str2}\n<:Arts_xNP:523979767016325121> 100.00#{'00' if @shardizard==4}% with three Arts NPs up" if np[1]>2
  else
    x=deck2.reject{|q| !q.include?('AA')}.length*100.0/deck2.length
    str2="#{str2} - #{('%.0f' % x)}% <:Arts_xNP:523979767016325121>#{micronumber(1)}" if np[1]>0
    x=deck2.reject{|q| !q.include?('A')}.length*100.0/deck2.length
    str2="#{str2}, #{('%.0f' % x)}% <:Arts_xNP:523979767016325121>#{micronumber(2)}" if np[1]>1
    str2="#{str2}, 100% <:Arts_xNP:523979767016325121>#{micronumber(3)}" if np[1]>2
  end
  x=deck2.reject{|q| !q.include?('BBB')}.length*100.0/deck2.length
  str2="#{str2}#{"\n" if safe_to_spam?(event,nil,1)}\n<:Buster_y:526556105422274580> *Buster chain:* #{(len % x)}%"
  if safe_to_spam?(event,nil,1)
    x=deck2.reject{|q| !q.include?('BB')}.length*100.0/deck2.length
    str2="#{str2}\n<:Buster_xNP:523979766911598632> #{(len % x)}% with a Buster NP up" if np[2]>0
    x=deck2.reject{|q| !q.include?('B')}.length*100.0/deck2.length
    str2="#{str2}\n<:Buster_xNP:523979766911598632> #{(len % x)}% with two Buster NPs up" if np[2]>1
    str2="#{str2}\n<:Buster_xNP:523979766911598632> 100.00#{'00' if @shardizard==4}% with three Buster NPs up" if np[2]>2
  else
    x=deck2.reject{|q| !q.include?('BB')}.length*100.0/deck2.length
    str2="#{str2} - #{('%.0f' % x)}% <:Buster_xNP:523979766911598632>#{micronumber(1)}" if np[2]>0
    x=deck2.reject{|q| !q.include?('B')}.length*100.0/deck2.length
    str2="#{str2}, #{('%.0f' % x)}% <:Buster_xNP:523979766911598632>#{micronumber(2)}" if np[2]>1
    str2="#{str2}, 100% <:Buster_xNP:523979766911598632>#{micronumber(3)}" if np[2]>2
  end
  str=extend_message(str,str2,event,2)
  event.respond str
end

def support_lineup(event,bot,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.reject{ |a| a.downcase=='smol' } if Shardizard==4
  args=args.map{|q| q.downcase}
  ids=$support_lineups.map{|q| [q.owner,q.owner_id]}.uniq
  m=event.message.mentions.reject{|q| !ids.map{|q| q[1]}.include?(q.id)}
  uid=-1
  if m.length>0
    uid=m[0].id
  else
    for i in 0...args.length
      uid=args[i].to_i if uid<0 && args[i].to_i.to_s==args[i] && !bot.user(args[i].to_i).nil? && ids.map{|q| q[1]}.include?(args[i].to_i)
    end
    if uid<0
      for i in 0...args.length
        for i2 in 0...ids.length
          uid=ids[i2][1] if uid<0 && args[i].downcase==ids[i2][0].downcase
          uid=ids[i2][1] if uid<0 && args[i].downcase=="#{ids[i2][0].downcase}'s"
        end
      end
    end
  end
  uid=event.user.id if uid<0
  k=$support_lineups.find_index{|q| q.owner_id==uid}
  k2=$support_lineups.find_index{|q| q.owner_id==uid && q.nationality=='JP'}
  k=k2*1 if !k2.nil? && has_any?(args.map{|q| q.downcase},['japan','jp'])
  if k.nil?
    f="#{bot.user(uid).name} does"
    f='You do' if uid==event.user.id
    event.respond "#{f}n't have a support lineup listed."
    return nil
  end
  k=$support_lineups[k]
  create_embed(event,[k.title(bot),k.header],k.disp_str(bot,event),k.color,nil,k.thumbnail(bot))
end

def update_howto(event,bot)
  if ![78649866577780736,167657750971547648].include?(event.user.id)
    t=Time.now
    if t.month==10 && t.year==2019 && t.day>23 && t.day<30
      event.respond "Please note that my developer is away for the weekend, and cannot do updates.  I have code that allows my data collector to update me remotely, but that may take longer than usual."
    else
      event.respond "This command is unavailable to you."
    end
    return nil
  end
  str="1.) Edit [the sheet](https://docs.google.com/spreadsheets/d/1Xl7lrTPb_00EvBzCJgWDbIWeCCoPfzS48nhyHf28utI/edit#gid=0) as usual."
  str="#{str}\n\n2.) If the edits made were to the \"Active Skills\", \"Passive Skills\", \"Noble Phantasms\", or \"MC Skills\" sheets, switch to the \"allskills\" sheet."
  str="#{str}\n\n3.) Wait for the formulae to finish loading, then grab the LizBot data column of the sheet you edited.  I generally highlight the lowest entry and CTRL+SHIFT+(up)."
  str="#{str}\n\n4.) Copy the selection from step 3 to a text file, with the following names based on sheet:"
  str="#{str}\n- *Servants* should be copied to **FGOServants.txt**"
  str="#{str}\n- *allskills* should be copied to **FGOSkills.txt**"
  str="#{str}\n- *CEs* should be copied to **FGOCraftEssances.txt**"
  str="#{str}\n- *MC Clothes* should be copied to **FGOClothes.txt**"
  str="#{str}\n- *Command Codes* should be copied to **FGOCommandCodes.txt**"
  str="#{str}\n- *Enemies* should be copied to **FGOEnemies.txt**"
  str="#{str}\n\n5.) Upload the text file to [the GitHub page here](https://github.com/Rot8erConeX/LizBot).  You might need to make a GitHub account to do so."
  str="#{str}\n\n6.) Wait probably five minutes for the file to settle on GitHub's servers, then use the command `FGO!reload` in either my debug server, or NEH's LizBotDev channel."
  str="#{str}\n\n7.) Type the number 3 to select reloading data based on GitHub files."
  str="#{str}\n\n8.) Double-check that the edited data works.  It is important to remember that I will not be there to guide you to wherever any problems might be based on error codes."
  str="#{str}\n\n9.) Add any relevant aliases to the new data."
  create_embed(event,"**How to update Liz's data while Mathoo is unavailable.**",str,0xED619A,nil)
end

def devservants_save(table=[]) # used by the edit command to save the devunits
  return nil unless File.exist?("#{$location}devkit/FGODevServants.txt")
  # sort the unit list alphabetically
  k=$dev_units.map{|q| q}
  k.compact!
  k=k.sort{|a,b| a.id<=>b.id}
  k2=k.reject{|q| !q.fav?}
  k=k.reject{|q| q.fav?}
  untz=[k2,k].flatten
  f=$support_lineups[$support_lineups.find_index{|q| q.owner=='Mathoo'}]
  f2=f.clone
  f2.lineup=table.map{|q| q} unless table.nil? || table.length<=0
  s="#{f.friend_code}\n\n#{f2.storage_string}\n\n#{untz.map{|q| q.storage_string}.join("\n\n")}"
  open("#{$location}devkit/FGODevServants.txt", 'w') { |f|
    f.puts s
    f.puts "\n"
  }
  return nil
end

def new_devunit(bot,event,xid)
  x=$dev_units.find_index{|q| q.id.to_i==xid.to_i}
  x=$dev_units.find_index{|q| q.id<2} if xid<2
  unless x.nil?
    barracks='spirit origin list'
    barracks='pocket' if ['Nursery Rhyme','Beni Enma','Habetrot'].include?($dev_units[x].alts[0])
    event.respond "You already have a #{$dev_units[x].creation_string(bot,event)} in your #{barracks}."
    return nil
  end
  bob4=DevServant.new(xid)
  bob4.fous='0\\0'; bob4.codes='0\\0\\0\\0\\0'; bob4.skill_levels='0\\0\\0\\0\\0\\0'; bob4.np_level='0'; bob4.ce_equip='0'; bob4.bond_level='0'; bob4.ascend='0\\0\\0'
  $dev_units.push(bob4.clone)
  str="You have added a **#{bob4.creation_string(bot,event)}** to your collection."
  devservants_save()
  event.respond str
  return nil
end

def dev_edit(bot,event,args=[],cmd='')
  if cmd.downcase=='help' || ((cmd.nil? || cmd.length.zero?) && (args.nil? || args.length.zero?))
    subcommand=nil
    subcommand=args[0] unless args.nil? || args.length.zero?
    subcommand='' if subcommand.nil?
    args=[] if args.nil?
    args=args[1,args.length-1]
    help_text(event,bot,'devedit',subcommand,args)
    return nil
  end
  data_load(['servants','skills','devunits','support'])
  j3=find_data_ex(:find_servant,args.join(' '),event,false,true)
  j3=find_data_ex(:find_servant,event.message.text,event,false,true) if j3.nil?
  unless has_any?([cmd,args[0].downcase],['ce','craft','craftessence']) && has_any?([cmd,args[0].downcase],['support','supports','friends','friend'])
    j=j3.id
    if j.nil? || j<=0
      event.respond "There is no servant by that name.\nPlease know that servant IDs do not work for this command because numbers have to be used for other things."
      return nil
    end
    j2=$dev_units.find_index{|q| q.id==j3.id}
    if j3.id<2
      j2=$dev_units.find_index{|q| q.id<2}
      j3=$servants[$servants.find_index{|q| q.id==$dev_units[j2].id}]
      j=j3.id
    end
  end
  if ['upgrade','interlude','rankup','rank','up'].include?(cmd.downcase) && ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3','append','append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3','np','merge','merges'].include?(args[0].downcase)
    f="#{cmd}"; cmd="#{args[0]}"; args[0]="#{f}"
  end
  if has_any?([cmd,args[0].downcase],['ce','craft','craftessence']) && has_any?([cmd,args[0].downcase],['support','supports','friends','friend'])
    args.shift
    if args.length<=0
      event.respond "No slot given."
      return nil
    end
    args=args.map{|q| q.downcase}
    support=$support_lineups[$support_lineups.find_index{|q| q.owner=='Mathoo'}].clone
    pos=-1
    pos=0 if args[0]=='all'
    pos=1 if ['saber','sabers','seiba','seibas'].include?(args[0])
    pos=2 if ['archer','bow','sniper','archa','archers','bows','snipers','archas'].include?(args[0])
    pos=3 if ['lancer','lancers','lance','lances'].include?(args[0])
    pos=4 if ['rider','riders','raida','raidas'].include?(args[0])
    pos=5 if ['caster','casters','castor','castors','mage','mages','magic'].include?(args[0])
    pos=6 if ['assassin','assasshin','assassins','assasshins'].include?(args[0])
    pos=7 if ['berserker','berserkers','berserk','berserks','zerker','zerkers'].include?(args[0])
    pos=8 if ['extra','extras'].include?(args[0])
    if pos<0
      j3=find_servant(args[0],event)
      unless j3.nil?
        pos=8
        pos=1 if j3.clzz=='Saber'
        pos=2 if j3.clzz=='Archer'
        pos=3 if j3.clzz=='Lancer'
        pos=4 if j3.clzz=='Rider'
        pos=5 if j3.clzz=='Caster'
        pos=6 if j3.clzz=='Assassin'
        pos=7 if j3.clzz=='Berserker'
      end
    end
    if pos<0
      event.respond "Invalid slot given."
      return nil
    end
    args.shift
    if args.length<=0
      event.respond "No CE was included."
      return nil
    end
    j4=find_data_ex(:find_ce,args.join(' '),event)
    if j4.nil?
      if has_any?(args.map{|q| q.downcase},['nothing','none','dequip','deequip','de-equip','unequip','un-equip'])
        support.lineup[pos].ce_id=0
        devservants_save(support)
        event.respond "Your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot is no longer equipping a CE."
      else
        event.respond "No CE was included."
      end
      return nil
    end
    support.lineup[pos].ce_id=j4.id
    devservants_save(support)
    event.respond "Your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot has equipped #{j4.name} [CE-##{j4.id}]."
    return nil
  elsif j2.nil? || j2<0
    if cmd.downcase=='create'
      new_devunit(bot,event,j3)
    else
      @stored_event=[event,j3]
      event.respond 'You do not have this servant.  Do you wish to add them to your collection?'
      event.channel.await(:bob, contains: /(yes)|(no)/i, from: 167657750971547648) do |e|
        if e.message.text.downcase.include?('no')
          e.respond 'Okay.'
        else
          j3=@stored_event[1]
          new_devunit(bot,event,j3)
        end
      end
    end
  elsif cmd.downcase=='create'
    barracks='spirit origin list'
    barracks='pocket' if ['Nursery Rhyme','Beni Enma','Habetrot'].include?($dev_units[j2].alts[0])
    event.respond "You already have a #{$dev_units[j2].creation_string(bot,event)} in your #{barracks}."
    return nil
  elsif ['fou','fous'].include?(cmd.downcase)
    m=-1
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>9 && args[i].to_i<1001 && typ<10 && typ>-1
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>9 && args[i][1,args[i].length-1].to_i<1001 && typ<10 && typ>-1
        typ=args[i][1,args[i].length-1].to_i
      elsif ['hp','health','star'].include?(args[i].downcase) && m<0
        m=0
      elsif ['atk','att','attack','sun'].include?(args[i].downcase) && m<0
        m=1
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      end
    end
    typ=10 if typ.zero?
    if m==-1
      event.respond "No fous were added because no stat was defined."
      return nil
    elsif typ<0
      $dev_units[j2].fous[m]=0
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{['HP','Attack'][m]} Fous have been reset to 0."
    else
      f=$dev_units[j2].fous[m]*1
      $dev_units[j2].fous[m]+=typ
      $dev_units[j2].fous[m]=[$dev_units[j2].fous[m],2000].min
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{['HP','Attack'][m]} Fous have been increased by #{longFormattedNumber(typ)} ~~(from #{longFormattedNumber(f)} to #{longFormattedNumber($dev_units[j2].fous[m])})~~"
    end
  elsif ['ce','craft','craftessence'].include?(cmd.downcase)
    j4=find_data_ex(:find_ce,event.message.text,event)
    if j4.nil? || j4.length<=0
      if has_any?(args.map{|q| q.downcase},['nothing','none','dequip','deequip','de-equip','unequip','un-equip'])
        $dev_units[j2][5]=0
        devservants_save()
        event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s CE has been removed."
      elsif has_any?(args.map{|q| q.downcase},['bond']) && !$crafts.find_index{|q| q.id==j3.bond_ce}.nil? && $dev_units[j2].bond_level>9
        $dev_units[j2].ce_equip=j3.bond_ce
        ce=$crafts[$crafts.find_index{|q| q.id==j3.bond_ce}]
        devservants_save()
        event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has equipped their bond CE, #{ce.name} [CE-##{ce.id}]."
      else
        event.respond "No CE was included."
      end
      return nil
    end
    $dev_units[j2].ce_equip=j4.id
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has equipped #{j4.name} [CE-##{j4.id}]."
  elsif ['bond'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      elsif ['ce','craft','craftessence'].include?(args[i].downcase)
        typ=-2
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      $dev_units[j2].bond_level=0
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s bond level has been reset."
      return nil
    elsif typ==-2 && !$crafts.find_index{|q| q.id==j3.bond_ce}.nil?
      $dev_units[j2].ce_equip=j3.bond_ce
      ce=$crafts[$crafts.find_index{|q| q.id==j3.bond_ce}]
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has equipped their bond CE, #{ce.name} [CE-##{ce.id}]."
      return nil
    end
    typ=1 if typ<=0
    f=$dev_units[j2].bond_level*1
    $dev_units[j2].bond_level=[$dev_units[j2].bond_level+typ,15].min
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s bond level has increased by #{$dev_units[j2].bond_level-f} ~~(from #{f} to #{$dev_units[j2].bond_level})~~."
  elsif ['ascension','ascend'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      $dev_units[j2].ascend='0\\1\\0'
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s ascension has been reset."
      return nil
    end
    mx=[1,2,2,3,4]
    m=mx[$dev_units[j2].ascend[0]]
    $dev_units[j2].ascend[0]=[$dev_units[j2].ascend[0]+typ,4].min
    str=''
    if $dev_units[j2].ascend[1]==m
      $dev_units[j2].ascend[1]=mx[$dev_units[j2].ascend[0]]
      str='The art has also been adjusted to fit the new ascension.'
    else
      str="#{['','Default','First Ascension','Third Ascension','Final Ascension','First Costume','Second Costume'][$dev_units[j2].ascend[1]]} art is still being used.  If you wish to change that, use the `FGO!devedit art` command"
    end
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has reached their #{['Zeroth','First','Second','Third','Final'][$dev_units[j2].ascend[0]]} Ascension.\n#{str}"
  elsif ['art'].include?(cmd.downcase)
    args=args.map{|q| q.downcase}
    disptext=" #{args.join(' ')} "
    asc=0
    asc=1 if has_any?(args,['default','zerothascension','zeroth_ascension','0th','0thascension','0th_ascension','0'])
    asc=2 if has_any?(disptext.split(' '),['first','firstascension','first_ascension','1st','1stascension','1st_ascension','second','secondascension','2nd','second_ascension','2ndascension','2nd_ascension']) || " #{disptext} ".include?(" first ascension ") || " #{disptext} ".include?(" 1st ascension ") || " #{disptext} ".include?(" second ascension ") || " #{disptext} ".include?(" 2nd ascension ")
    asc=3 if has_any?(disptext.split(' '),['third','thirdascension','third_ascension','3rd','3rdascension','3rd_ascension']) || " #{disptext} ".include?(" third ascension ") || " #{disptext} ".include?(" 3rd ascension ")
    asc=4 if has_any?(disptext.split(' '),['fourth','fourthascension','fourth_ascension','4th','4thascension','4th_ascension','final','finalascension','final_ascension']) || " #{disptext} ".include?(" fourth ascension ") || " #{disptext} ".include?(" 4th ascension ") || " #{disptext} ".include?(" final ascension ")
    asc=5 if (has_any?(disptext.split(' '),['costume','firstcostume','first_costume','1stcostume','1st_costume','costume1']) || " #{disptext} ".include?(" first costume ") || " #{disptext} ".include?(" 1st costume ") || " #{disptext} ".include?(" costume 1 ")) && j3[18].length>4
    asc=6 if (has_any?(disptext.split(' '),['secondcostume','second_costume','2ndcostume','2nd_costume','costume2']) || " #{disptext} ".include?(" second costume ") || " #{disptext} ".include?(" 2nd costume ") || " #{disptext} ".include?(" costume 2 ")) && j3[18].length>5
    asc=7 if (has_any?(disptext.split(' '),['thirdcostume','third_costume','3rdcostume','3rd_costume','costume3']) || " #{disptext} ".include?(" third costume ") || " #{disptext} ".include?(" 3rd costume ") || " #{disptext} ".include?(" costume 3 ")) && j3[18].length>6
    asc=8 if (has_any?(disptext.split(' '),['fourthcostume','fourth_costume','4thcostume','4th_costume','costume4']) || " #{disptext} ".include?(" fourth costume ") || " #{disptext} ".include?(" 4th costume ") || " #{disptext} ".include?(" costume 4 ")) && j3[18].length>7
    asc=9 if (has_any?(disptext.split(' '),['fifthcostume','fifth_costume','5thcostume','5th_costume','costume5']) || " #{disptext} ".include?(" fifth costume ") || " #{disptext} ".include?(" 5th costume ") || " #{disptext} ".include?(" costume 5 ")) && j3[18].length>8
    asc=10 if (has_any?(disptext.split(' '),['sixthcostume','sixth_costume','6thcostume','6th_costume','costume6']) || " #{disptext} ".include?(" sixth costume ") || " #{disptext} ".include?(" 6th costume ") || " #{disptext} ".include?(" costume 6 ")) && j3[18].length>9
    asc=11 if (has_any?(disptext.split(' '),['seventhcostume','seventh_costume','7thcostume','7th_costume','costume7']) || " #{disptext} ".include?(" seventh costume ") || " #{disptext} ".include?(" 7th costume ") || " #{disptext} ".include?(" costume 7 ")) && j3[18].length>10
    asc=12 if (has_any?(disptext.split(' '),['eighthcostume','eighth_costume','8thcostume','8th_costume','costume8']) || " #{disptext} ".include?(" eighth costume ") || " #{disptext} ".include?(" 8th costume ") || " #{disptext} ".include?(" costume 8 ")) && j3[18].length>11
    asc=13 if (has_any?(disptext.split(' '),['ninthcostume','ninth_costume','9thcostume','9th_costume','costume9']) || " #{disptext} ".include?(" ninth costume ") || " #{disptext} ".include?(" 9th costume ") || " #{disptext} ".include?(" costume 9 ")) && j3[18].length>12
    asc=14 if (has_any?(disptext.split(' '),['tenthcostume','tenth_costume','10thcostume','10th_costume','costume10']) || " #{disptext} ".include?(" tenth costume ") || " #{disptext} ".include?(" 10th costume ") || " #{disptext} ".include?(" costume 10 ")) && j3[18].length>12
    mx=[1,2,2,3,4]
    m=mx[$dev_units[j2].ascend[0]]
    if asc<5 && asc>m
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has too low of an ascension to display that art."
      return nil
    elsif asc.zero?
      $dev_units[j2].ascend[1]=m
    else
      $dev_units[j2].ascend[1]=asc
    end
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} is now using their #{['','Default','First Ascension','Third Ascension','Final Ascension','First Costume','Second Costume','Third Costume','Fourth Costume','Fifth Costume','Sixth Costume','Seventh Costume','Eighth Costume','Ninth Costume','Tenth Costume'][$dev_units[j2].ascend[1]]} art."
  elsif ['grail','silver','gold'].include?(cmd.downcase)
    if $dev_units[j2].ascend[0]<4
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)} needs to have reached their Fianl Ascension before you can use this command."
      return nil
    elsif j3.rarity<=0
      event.respond "#{$dev_units[j2].creation_string(bot,event)} has their own color gimmicks, and never attains grailshift colors."
      return nil
    elsif j3.rarity>3 && $dev_units[j2].ascend[2]>=0
      event.respond "#{$dev_units[j2].creation_string(bot,event)} is already gold naturally."
      return nil
    elsif j3.rarity>2 && $dev_units[j2].ascend[2]>=1
      event.respond "#{$dev_units[j2].creation_string(bot,event)} is already grailshifted once, to gold."
      return nil
    elsif j3.rarity>0 && $dev_units[j2].ascend[2]>=2
      event.respond "#{$dev_units[j2].creation_string(bot,event)} is already grailshifted twice, to gold."
      return nil
    end
    $dev_units[j2].ascend[2]+=1
    devservants_save()
    clrz=['black','bronze','silver','gold']
    color=3
    color=2 if j3.rarity<4
    color=1 if j3.rarity<3
    color=0 if j3.rarity<1
    color+=$dev_units[j2].ascend[2]
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has been grailshifted to #{clrz[color]}"
  elsif ['code','command','commandcode','deck','c1','c2','c3','c4','c5','code1','code2','code3','code4','code5','card1','card2','card3','card4','card5','q1','q2','q3','quick1','quick2','quick3','a1','a2','a3','arts1','arts2','arts3','art1','art2','art3','b1','b2','b3','buster1','buster2','buster3','bust1','bust2','bust3'].include?(cmd.downcase)
    args=args.map{|q| q.downcase}
    m=-1
    m=0 if ['code1','card1','c1','quick1','q1'].include?(cmd.downcase)
    m=1 if ['code2','card2','c2'].include?(cmd.downcase)
    m=2 if ['code3','card3','c3'].include?(cmd.downcase)
    m=3 if ['code4','card4','c4'].include?(cmd.downcase)
    m=4 if ['code5','card5','c5'].include?(cmd.downcase)
    m=12 if ['quick2','q2'].include?(cmd.downcase)
    m=13 if ['quick2','q3'].include?(cmd.downcase)
    m=21 if ['arts1','art1','a1'].include?(cmd.downcase)
    m=22 if ['arts2','art2','a2'].include?(cmd.downcase)
    m=23 if ['arts3','art3','a3'].include?(cmd.downcase)
    m=31 if ['buster1','bust1','b1'].include?(cmd.downcase)
    m=32 if ['buster2','bust2','b2'].include?(cmd.downcase)
    m=33 if ['buster3','bust3','b3'].include?(cmd.downcase)
    nums=[]
    for i in 0...args.length
      nums.push(0) if has_any?(['code1','card1','c1','quick1','q1'],args)
      nums.push(1) if has_any?(['code2','card2','c2'],args)
      nums.push(2) if has_any?(['code3','card3','c3'],args)
      nums.push(3) if has_any?(['code4','card4','c4'],args)
      nums.push(4) if has_any?(['code5','card5','c5'],args)
      nums.push(12) if has_any?(['quick2','q2'],args)
      nums.push(13) if has_any?(['quick2','q3'],args)
      nums.push(21) if has_any?(['arts1','art1','a1'],args)
      nums.push(22) if has_any?(['arts2','art2','a2'],args)
      nums.push(23) if has_any?(['arts3','art3','a3'],args)
      nums.push(31) if has_any?(['buster1','bust1','b1'],args)
      nums.push(32) if has_any?(['buster2','bust2','b2'],args)
      nums.push(33) if has_any?(['buster3','bust3','b3'],args)
    end
    m=nums[0] if nums.length>0 && m<0
    crds=[1,1,1]
    crds[0]+=1 if j3.deck.include?('QQ')
    crds[0]+=1 if j3.deck.include?('QQQ')
    crds[1]+=1 if j3.deck.include?('AA')
    crds[1]+=1 if j3.deck.include?('AAA')
    crds[2]+=1 if j3.deck.include?('BB')
    crds[2]+=1 if j3.deck.include?('BBB')
    jx=find_data_ex(:find_code,args.join(' '),event)
    m2=[]
    for i in 0...crds[0]
      m2.push("#{['1st','2nd','3rd'][i]} Quick")
    end
    for i in 0...crds[1]
      m2.push("#{['1st','2nd','3rd'][i]} Arts")
    end
    for i in 0...crds[2]
      m2.push("#{['1st','2nd','3rd'][i]} Buster")
    end
    if m<0
      event.respond "No Command Card was specified."
      return nil
    elsif m>10 && m%10>crds[m/10-1]
      event.respond "#{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)} only has #{crds[m/10-1]} #{['Quick','Arts','Buster'][m/10-1]} card#{'s' unless crds[m/10-1]==1}."
      return nil
    elsif has_any?(['reset','revert'],args)
      if m>10
        m-=11 if m<20
        m-=21-crds[0] if m>20 && m<30
        m-=31-crds[0]-crds[1] if m>30
      end
      $dev_units[j2].codes[m]=0
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has removed the Command Card attached to their #{m2[m]} card."
      return nil
    elsif jx.nil? || jx.length<=0
      event.respond "No Command Code was specified."
      return nil
    elsif j3[0]==127 && jx[0]==39 && !has_any?(['cmd39','cmd-39','cmd_39','cmddavinci','davincicmd','commanddavinci','davincicommand'],args)
      event.respond "I am detecting\n- the servant #{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)}\n- the Command Code #{jx.name} [Cmd-#{jx.id}]\n\nPlease try this command again but include an alias for the Command Code that doesn't conflict with the servant."
      return nil
    elsif m>10
      m-=11 if m<20
      m-=21-crds[0] if m>20 && m<30
      m-=31-crds[0]-crds[1] if m>30
    end
    $dev_units[j2].codes[m]=jx.id
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has equipped #{jx.name} [Cmd-#{jx.id}] to their #{m2[m]} card."
  elsif ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3','append','append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3'].include?(cmd.downcase)
    m=-1
    m=0 if ['skill1','skill-1','skill_1','s1'].include?(cmd.downcase)
    m=1 if ['skill2','skill-2','skill_2','s2'].include?(cmd.downcase)
    m=2 if ['skill3','skill-3','skill_3','s3'].include?(cmd.downcase)
    m=3 if ['append1','append-1','append_1','a1'].include?(cmd.downcase)
    m=4 if ['append2','append-2','append_2','a2'].include?(cmd.downcase)
    m=5 if ['append3','append-3','append_3','a3'].include?(cmd.downcase)
    nums=[]
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>-1
        nums.push(args[i].to_i)
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0
        nums.push(0-args[i][1,args[i].length-1].to_i)
      elsif ['upgrade','interlude','rankup','rank','up'].include?(args[i].downcase)
        nums.push(-100)
      elsif ['reset','revert'].include?(args[i].downcase)
        nums.push(-200)
      elsif m==-1
        m=0 if ['skill1','skill-1','skill_1','s1'].include?(args[i].downcase)
        m=1 if ['skill2','skill-2','skill_2','s2'].include?(args[i].downcase)
        m=2 if ['skill3','skill-3','skill_3','s3'].include?(args[i].downcase)
        m=3 if ['append1','append-1','append_1','a1'].include?(args[i].downcase)
        m=4 if ['append2','append-2','append_2','a2'].include?(args[i].downcase)
        m=5 if ['append3','append-3','append_3','a3'].include?(args[i].downcase)
      end
    end
    typ=0
    for i in 0...nums.length
      if m<0 && nums[i]<4 && nums[i]>0
        m=nums[i]-1
      elsif typ==0 && nums[i]<0 && nums[i]>-11
        typ=0-nums[i]
      elsif typ==0 && nums[i]>0 && nums[i]<11
        typ=nums[i]*1
      elsif typ==0 && [-100,100].include?(nums[i])
        typ=-1
      elsif typ==0 && [-200,200].include?(nums[i])
        typ=-2
      end
    end
    typ=1 if typ.zero?
    sklstr="S#{m+1}"
    sklstr="A#{m-2}" if m>2
    if m<0
      event.respond "No skills were upgraded because no skill slot was defined."
      return nil
    elsif typ==-1
      if $dev_units[j2].skill_levels[m].include?('u')
        f=$dev_units[j2].skill_levels[m].split('u')[1].to_i
        f=1 if $dev_units[j2].skill_levels[m][-1]=='u'
        f2=[j3.actives[0],j3.actives[1],j3.actives[2],j3.appends[0],j3.appends[1],j3.appends[2]][m].length
        if f>=f2-1
          event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} is already upgraded to the maximum level."
        else
          $dev_units[j2].skill_levels[m]="#{$dev_units[j2].skill_levels[m].split('u')[0].to_i}u#{f+1}"
          devservants_save()
          event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} has been upgraded again due to an Interlude or Rank-Up Quest."
        end
      elsif m<3 && (j3.actives[m][1].nil? || j3.actives[m][1].length<=0)
        event.respond "#{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} cannot be upgraded yet."
      elsif m>2 && (j3.appends[m-3][1].nil? || j3.appends[m-3][1].length<=0)
        event.respond "#{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} cannot be upgraded yet."
      else
        $dev_units[j2].skill_levels[m]="#{$dev_units[j2].skill_levels[m]}u"
        devservants_save()
        event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} has been upgraded due to an Interlude or Rank-Up Quest."
      end
      return nil
    elsif typ==-2
      $dev_units[j2].skill_levels[m]="0"
      $dev_units[j2].skill_levels[m]="1" if m==0
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} has been reset to an unupgraded level #{$dev_units[j2].skill_levels[m]}."
      return nil
    end
    n=''
    n='u' if $dev_units[j2].skill_levels[m].include?('u')
    n="u#{$dev_units[j2].skill_levels[m].split('u')[1]}" if $dev_units[j2].skill_levels[m].split('u').length>1
    f=$dev_units[j2].skill_levels[m].split('u')[0].to_i
    $dev_units[j2].skill_levels[m]="#{[$dev_units[j2].skill_levels[m].split('u')[0].to_i+typ,10].min}#{n}"
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s #{sklstr} has been leveled by #{$dev_units[j2].skill_levels[m].split('u')[0].to_i-f} ~~(from #{f} to #{$dev_units[j2].skill_levels[m].split('u')[0]})~~."
  elsif ['np','merge','merges'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && args[i][1,args[i].length-1].to_i<6 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['upgrade','interlude','rankup','rank','up'].include?(args[i].downcase)
        typ=-1
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-2
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      if $dev_units[j2].np_level.include?('u')
        f=$dev_units[j2].np_level.split('u')[1].to_i
        f=1 if $dev_units[j2].np_level[-1]=='u'
        f2=$nobles.reject{|q| q.id.split('u')[0].to_i==$dev_units[j2].id.to_i}.length
        if f>=f2
          event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s Noble Phantasm is already to the maximum level."
        else
          $dev_units[j2].np_level="#{$dev_units[j2].np_level.to_i}u#{f+1}"
          devservants_save()
          event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s Noble Phantasm has been upgraded again due to an Interlude or Rank-Up Quest."
        end
      elsif $nobles.find_index{|q| q.id=="#{j3.id}u"}.nil?
        event.respond "#{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)}'s Noble Phantasm cannot be upgraded yet."
      else
        $dev_units[j2].np_level="#{$dev_units[j2].np_level}u"
        devservants_save()
        event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s Noble Phantasm has been upgraded due to an Interlude or Rank-Up Quest."
      end
      return nil
    elsif typ==-1
      $dev_units[j2].np_level="1"
      devservants_save()
      event.respond "Your #{$dev_units[j2].creation_string(bot,event)}'s Noble Phantasm has reset to an unupgraded NP1."
      return nil
    end
    n=''
    n='u' if $dev_units[j2][4].include?('u')
    n="u#{$dev_units[j2].np_level.split('u')[1]}" if $dev_units[j2].np_level.split('u').length>1
    $dev_units[j2].np_level="#{[$dev_units[j2].np_level.split('u')[0].to_i+typ,5].min}#{n}"
    devservants_save()
    event.respond "Your #{$dev_units[j2].creation_string(bot,event)} has been merged to NP#{$dev_units[j2].np_level.split('u')[0]}."
  elsif ['upgrade','interlude','rankup','rank','up'].include?(cmd.downcase) && j3.id<2
    j4=$dev_units[j2].clone
    if $dev_units[j2].id==1.1
      $dev_units[j2].id=1.2
    else
      $dev_units[j2].id=1.1
    end
    devservants_save()
    event.respond "Your #{j4.creation_string(bot,event)} has entered her #{['Default','Camelot','Orthenaus'][($dev_units[j2].id*10-10).to_i]} form [Srv-##{$dev_units[j2].id}]."
  elsif ['burn','delete'].include?(cmd.downcase)
    if $dev_units[j2].fav?
      event.respond "Who are you and what have you done with Mathoo?  He will never burn an adorable smol."
      return nil
    end
    for i in 0...$dev_units.length
      $dev_units[i]=nil if $dev_units[i].id==j3.id
    end
    $dev_units.compact!
    devservants_save()
    event.respond "Your #{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)} has been burned."
  elsif ['support','supports','friends','friend'].include?(cmd.downcase)
    support=$support_lineups[$support_lineups.find_index{|q| q.owner=='Mathoo'}].clone
    pos=8
    pos=1 if j3.clzz=='Saber'
    pos=2 if j3.clzz=='Archer'
    pos=3 if j3.clzz=='Lancer'
    pos=4 if j3.clzz=='Rider'
    pos=5 if j3.clzz=='Caster'
    pos=6 if j3.clzz=='Assassin'
    pos=7 if j3.clzz=='Berserker'
    pos=0 if event.message.text.downcase.split(' ').include?('all')
    support.lineup[pos].servant_id=j3.id
    devservants_save(support)
    str="Your #{$dev_units[j2].creation_string(bot,event)} is now in your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot."
    if $dev_units[j2].ce_equip>0
      cfts=$crafts.map{|q| q}
      ce=cfts.find_index{|q| q.id==$dev_units[j2].ce_equip}
      if ce.nil?
        event.respond str
      else
        ce=cfts[ce]
        event.respond "#{str}\nThey have #{ce.name} [CE-##{ce.id}] as their local CE.  Would you like to copy this to your Support lineup?"
        @stored_event=[event,support,pos,ce]
        event.channel.await(:bob, contains: /(yes)|(no)/i, from: 167657750971547648) do |e|
          if e.message.text.downcase.include?('no')
            e.respond 'Okay.'
          else
            support=@stored_event[1]
            pos=@stored_event[2]
            ce=@stored_event[3]
            support.lineup[pos].ce_id=ce.id
            devservants_save(support)
            e.respond "You have equipped a #{ce.name} [CE-##{ce.id}] to your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot."
          end
        end
      end
    else
      event.respond str
    end
  else
    event.respond 'Edit mode was not specified.'
  end
  return nil
end

def donorservants_save(xid) # used by the edit command to save the devunits
  if File.exist?("#{$location}devkit/LizUserSaves/#{xid}.txt")
    b=[]
    File.open("#{$location}devkit/LizUserSaves/#{xid}.txt").each_line do |line|
      b.push(line.gsub("\n",''))
    end
  else
    b=[]
  end
  k=$donor_units.reject{|q| q.owner_id != xid}
  # sort the unit list alphabetically
  k=k.sort{|b,a| (a.bond_level<=>b.bond_level)==0 ? (b.name<=>a.name) : (a.bond_level<=>b.bond_level)}
  k2=k.reject{|q| !q.fav?}
  k=k.reject{|q| q.fav?}
  untz=[k2,k].flatten
  f=$support_lineups.reject{|q| q.owner_id != xid}
  s="#{untz[0].owner}\\0x#{untz[0].color_tag.to_s(16)}"
  f2=f.find_index{|q| q.nationality=='NA'}
  if f2.nil?
    s="#{s}\\0"
    s2="0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0"
  else
    s="#{s}\\#{f[f2].friend_code}"
    s2=f[f2].storage_string
  end
  f2=f.find_index{|q| q.nationality=='JP'}
  if f2.nil?
    s="#{s}\\0"
    s2="#{s2}\n\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0\n0\\0"
  else
    s="#{s}\\#{f[f2].friend_code}"
    s2="#{s2}\n\n#{f[f2].storage_string}"
  end
  s="#{s}\n\n#{s2}\n\n#{untz.map{|q| q.storage_string}.join("\n\n")}"
  open("#{$location}devkit/LizUserSaves/#{xid}.txt", 'w') { |f|
    f.puts s
    f.puts "\n"
  }
  return nil
end

def new_donorunit(bot,event,xid,sid)
  n='NA'; n='JP' if sid.include?('j')
  x=$donor_units.find_index{|q| q.owner_id==xid && q.nationality==n && q.id.to_i==sid.gsub('j','').to_i}
  x=$donor_units.find_index{|q| q.owner_id==xid && q.nationality==n && q.id<2} if sid.gsub('j','').to_f<2
  unless x.nil?
    event.respond "You already have a #{$dev_units[x].creation_string(bot,event)} in your spirit origin list in #{n}."
    return nil
  end
  bob4=DonorServant.new(sid,'',xid) # saving their donor trigger isn't needed here, as soon as the list is reloaded that is fixeed
  bob4.fous='0\\0'; bob4.codes='0\\0\\0\\0\\0'; bob4.skill_levels='0\\0\\0\\0\\0\\0'; bob4.np_level='0'; bob4.ce_equip='0'; bob4.bond_level='0'; bob4.ascend='0\\0\\0'
  $donor_units.push(bob4.clone)
  str="You have added a **#{bob4.creation_string(bot,event)}** to your #{n} collection."
  donorservants_save(xid)
  event.respond str
  return nil
end

def donor_edit(bot,event,args=[],cmd='')
  uid=event.user.id
  if uid==167657750971547648
    event.respond "This command is for the donors.  Your version of the command is `FGO!devedit`."
    return nil
  elsif !get_donor_list().reject{|q| q[2][1]<4}.map{|q| q[0]}.include?(uid)
    event.respond "You do not have permission to use this command."
    return nil
  elsif !File.exist?("#{$location}devkit/LizUserSaves/#{uid}.txt")
    event.respond "Please wait until my developer makes your storage file."
    return nil
  elsif cmd.downcase=='help' || ((cmd.nil? || cmd.length.zero?) && (args.nil? || args.length.zero?))
    subcommand=nil
    subcommand=args[0] unless args.nil? || args.length.zero?
    subcommand='' if subcommand.nil?
    args=[] if args.nil?
    args=args[1,args.length-1]
    help_text(event,bot,'edit',subcommand,args)
    return nil
  end
  data_load(['servants','skills','donorunits','support'])
  jp=false
  jp=true if has_any?(args.map{|q| q.downcase},['japan','jp'])
  nat='NA'; nat='JP' if jp
  j3=find_data_ex(:find_servant,args.join(' '),event,false,true)
  j3=find_data_ex(:find_servant,event.message.text,event,false,true) if j3.nil?
  unless has_any?([cmd,args[0].downcase],['ce','craft','craftessence']) && has_any?([cmd,args[0].downcase],['support','supports','friends','friend'])
    j=j3.id
    if j.nil? || j<=0
      event.respond "There is no servant by that name.\nPlease know that servant IDs do not work for this command because numbers have to be used for other things."
      return nil
    end
    j2=$donor_units.find_index{|q| q.owner_id==uid && q.nationality==nat && q.id==j3.id}
    if j3.id<2
      j2=$donor_units.find_index{|q| q.owner_id==uid && q.nationality==nat && q.id<2}
      j3=$servants[$servants.find_index{|q| q.id==$donor_units[j2].id}]
      j=j3.id
    end
  end
  if ['upgrade','interlude','rankup','rank','up'].include?(cmd.downcase) && ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3','append','append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3','np','merge','merges'].include?(args[0].downcase)
    f="#{cmd}"; cmd="#{args[0]}"; args[0]="#{f}"
  end
  if has_any?([cmd,args[0].downcase],['ce','craft','craftessence']) && has_any?([cmd,args[0].downcase],['support','supports','friends','friend'])
    args.shift
    if args.length<=0
      event.respond "No slot given."
      return nil
    end
    args=args.map{|q| q.downcase}
    support=$support_lineups.find_index{|q| q.owner_id==uid && q.nationality==nat}
    support=$support_lineups.find_index{|q| q.owner_id==uid} if support.nil?
    support=$support_lineups[support]
    pos=-1
    pos=0 if args[0]=='all'
    pos=1 if ['saber','sabers','seiba','seibas'].include?(args[0])
    pos=2 if ['archer','bow','sniper','archa','archers','bows','snipers','archas'].include?(args[0])
    pos=3 if ['lancer','lancers','lance','lances'].include?(args[0])
    pos=4 if ['rider','riders','raida','raidas'].include?(args[0])
    pos=5 if ['caster','casters','castor','castors','mage','mages','magic'].include?(args[0])
    pos=6 if ['assassin','assasshin','assassins','assasshins'].include?(args[0])
    pos=7 if ['berserker','berserkers','berserk','berserks','zerker','zerkers'].include?(args[0])
    pos=8 if ['extra','extras'].include?(args[0])
    if pos<0
      j3=find_servant(args[0],event)
      unless j3.nil?
        pos=8
        pos=1 if j3.clzz=='Saber'
        pos=2 if j3.clzz=='Archer'
        pos=3 if j3.clzz=='Lancer'
        pos=4 if j3.clzz=='Rider'
        pos=5 if j3.clzz=='Caster'
        pos=6 if j3.clzz=='Assassin'
        pos=7 if j3.clzz=='Berserker'
      end
    end
    if pos<0
      event.respond "Invalid slot given."
      return nil
    end
    args.shift
    if args.length<=0
      event.respond "No CE was included."
      return nil
    end
    j4=find_data_ex(:find_ce,args.join(' '),event)
    if j4.nil? || j4.length<=0
      if has_any?(args.map{|q| q.downcase},['nothing','none','dequip','deequip','de-equip','unequip','un-equip'])
        support[pos].ce_id=0
        devservants_save(support)
        event.respond "Your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot is no longer equipping a CE."
      else
        event.respond "No CE was included."
      end
      return nil
    end
    support.lineup[pos].ce_id=j4.id
    s=$support_lineups.reject{|q| q.owner_id !=uid}.map{|q| q.clone}
    $support_lineups=$support_lineups.reject{|q| q.owner_id==uid}.map{|q| q.clone}
    s=s.reject{|q| q.nationality==support.nationality}
    $support_lineups.push(support.clone)
    for i in 0...s.length
      $support_lineups.push(s[i].clone)
    end
    devservants_save(uid)
    event.respond "Your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot has equipped #{j4.name} [CE-##{j4.id}]."
    return nil
  elsif j2.nil? || j2<0
    if cmd.downcase=='create'
      new_devunit(bot,event,uid,j3)
    else
      @stored_event=[event,j3]
      event.respond 'You do not have this servant.  Do you wish to add them to your collection?'
      event.channel.await(:bob, contains: /(yes)|(no)/i, from: 167657750971547648) do |e|
        if e.message.text.downcase.include?('no')
          e.respond 'Okay.'
        else
          j3=@stored_event[1]
          new_donorunit(bot,event,uid,j3)
        end
      end
    end
  elsif cmd.downcase=='create'
    event.respond "You already have a #{$donor_units[j2].creation_string(bot,event)} in your spirit origin list."
    return nil
  elsif ['fou','fous'].include?(cmd.downcase)
    m=-1
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>9 && args[i].to_i<1001 && typ<10 && typ>-1
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>9 && args[i][1,args[i].length-1].to_i<1001 && typ<10 && typ>-1
        typ=args[i][1,args[i].length-1].to_i
      elsif ['hp','health','star'].include?(args[i].downcase) && m<0
        m=0
      elsif ['atk','att','attack','sun'].include?(args[i].downcase) && m<0
        m=1
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      end
    end
    typ=10 if typ.zero?
    if m==-1
      event.respond "No fous were added because no stat was defined."
      return nil
    elsif typ<0
      $donor_units[j2].fous[m]=0
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{['HP','Attack'][m]} Fous have been reset to 0."
    else
      f=$donor_units[j2].fous[m]*1
      $donor_units[j2].fous[m]+=typ
      $donor_units[j2].fous[m]=[$donor_units[j2].fous[m],2000].min
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{['HP','Attack'][m]} Fous have been increased by #{longFormattedNumber(typ)} ~~(from #{longFormattedNumber(f)} to #{longFormattedNumber($donor_units[j2].fous[m])})~~"
    end
  elsif ['ce','craft','craftessence'].include?(cmd.downcase)
    j4=find_data_ex(:find_ce,event.message.text,event)
    if j4.nil? || j4.length<=0
      if has_any?(args.map{|q| q.downcase},['nothing','none','dequip','deequip','de-equip','unequip','un-equip'])
        $donor_units[j2][5]=0
        donorservants_save(uid)
        event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s CE has been removed."
      elsif has_any?(args.map{|q| q.downcase},['bond']) && !$crafts.find_index{|q| q.id==j3.bond_ce}.nil? && $donor_units[j2].bond_level>9
        $donor_units[j2].ce_equip=j3.bond_ce
        ce=$crafts[$crafts.find_index{|q| q.id==j3.bond_ce}]
        donorservants_save(uid)
        event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has equipped their bond CE, #{ce.name} [CE-##{ce.id}]."
      else
        event.respond "No CE was included."
      end
      return nil
    end
    $donor_units[j2].ce_equip=j4.id
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has equipped #{j4.name} [CE-##{j4.id}]."
  elsif ['bond'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      elsif ['ce','craft','craftessence'].include?(args[i].downcase)
        typ=-2
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      $donor_units[j2].bond_level=0
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s bond level has been reset."
      return nil
    elsif typ==-2 && !$crafts.find_index{|q| q.id==j3.bond_ce}.nil?
      $donor_units[j2].ce_equip=j3.bond_ce
      ce=$crafts[$crafts.find_index{|q| q.id==j3.bond_ce}]
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has equipped their bond CE, #{ce.name} [CE-##{ce.id}]."
      return nil
    end
    typ=1 if typ<=0
    f=$donor_units[j2].bond_level*1
    $donor_units[j2].bond_level=[$donor_units[j2].bond_level+typ,15].min
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s bond level has increased by #{$donor_units[j2].bond_level-f} ~~(from #{f} to #{$donor_units[j2].bond_level})~~."
  elsif ['ascension','ascend'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-1
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      $donor_units[j2].ascend='0\\1\\0'
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s ascension has been reset."
      return nil
    end
    mx=[1,2,2,3,4]
    m=mx[$donor_units[j2].ascend[0]]
    $donor_units[j2].ascend[0]=[$donor_units[j2].ascend[0]+typ,4].min
    str=''
    if $donor_units[j2].ascend[1]==m
      $donor_units[j2].ascend[1]=mx[$donor_units[j2].ascend[0]]
      str='The art has also been adjusted to fit the new ascension.'
    else
      str="#{['','Default','First Ascension','Third Ascension','Final Ascension','First Costume','Second Costume'][$donor_units[j2].ascend[1]]} art is still being used.  If you wish to change that, use the `FGO!devedit art` command"
    end
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has reached their #{['Zeroth','First','Second','Third','Final'][$donor_units[j2].ascend[0]]} Ascension.\n#{str}"
  elsif ['art'].include?(cmd.downcase)
    args=args.map{|q| q.downcase}
    disptext=" #{args.join(' ')} "
    asc=0
    asc=1 if has_any?(args,['default','zerothascension','zeroth_ascension','0th','0thascension','0th_ascension','0'])
    asc=2 if has_any?(disptext.split(' '),['first','firstascension','first_ascension','1st','1stascension','1st_ascension','second','secondascension','2nd','second_ascension','2ndascension','2nd_ascension']) || " #{disptext} ".include?(" first ascension ") || " #{disptext} ".include?(" 1st ascension ") || " #{disptext} ".include?(" second ascension ") || " #{disptext} ".include?(" 2nd ascension ")
    asc=3 if has_any?(disptext.split(' '),['third','thirdascension','third_ascension','3rd','3rdascension','3rd_ascension']) || " #{disptext} ".include?(" third ascension ") || " #{disptext} ".include?(" 3rd ascension ")
    asc=4 if has_any?(disptext.split(' '),['fourth','fourthascension','fourth_ascension','4th','4thascension','4th_ascension','final','finalascension','final_ascension']) || " #{disptext} ".include?(" fourth ascension ") || " #{disptext} ".include?(" 4th ascension ") || " #{disptext} ".include?(" final ascension ")
    asc=5 if (has_any?(disptext.split(' '),['costume','firstcostume','first_costume','1stcostume','1st_costume','costume1']) || " #{disptext} ".include?(" first costume ") || " #{disptext} ".include?(" 1st costume ") || " #{disptext} ".include?(" costume 1 ")) && j3[18].length>4
    asc=6 if (has_any?(disptext.split(' '),['secondcostume','second_costume','2ndcostume','2nd_costume','costume2']) || " #{disptext} ".include?(" second costume ") || " #{disptext} ".include?(" 2nd costume ") || " #{disptext} ".include?(" costume 2 ")) && j3[18].length>5
    asc=7 if (has_any?(disptext.split(' '),['thirdcostume','third_costume','3rdcostume','3rd_costume','costume3']) || " #{disptext} ".include?(" third costume ") || " #{disptext} ".include?(" 3rd costume ") || " #{disptext} ".include?(" costume 3 ")) && j3[18].length>6
    asc=8 if (has_any?(disptext.split(' '),['fourthcostume','fourth_costume','4thcostume','4th_costume','costume4']) || " #{disptext} ".include?(" fourth costume ") || " #{disptext} ".include?(" 4th costume ") || " #{disptext} ".include?(" costume 4 ")) && j3[18].length>7
    asc=9 if (has_any?(disptext.split(' '),['fifthcostume','fifth_costume','5thcostume','5th_costume','costume5']) || " #{disptext} ".include?(" fifth costume ") || " #{disptext} ".include?(" 5th costume ") || " #{disptext} ".include?(" costume 5 ")) && j3[18].length>8
    asc=10 if (has_any?(disptext.split(' '),['sixthcostume','sixth_costume','6thcostume','6th_costume','costume6']) || " #{disptext} ".include?(" sixth costume ") || " #{disptext} ".include?(" 6th costume ") || " #{disptext} ".include?(" costume 6 ")) && j3[18].length>9
    asc=11 if (has_any?(disptext.split(' '),['seventhcostume','seventh_costume','7thcostume','7th_costume','costume7']) || " #{disptext} ".include?(" seventh costume ") || " #{disptext} ".include?(" 7th costume ") || " #{disptext} ".include?(" costume 7 ")) && j3[18].length>10
    asc=12 if (has_any?(disptext.split(' '),['eighthcostume','eighth_costume','8thcostume','8th_costume','costume8']) || " #{disptext} ".include?(" eighth costume ") || " #{disptext} ".include?(" 8th costume ") || " #{disptext} ".include?(" costume 8 ")) && j3[18].length>11
    asc=13 if (has_any?(disptext.split(' '),['ninthcostume','ninth_costume','9thcostume','9th_costume','costume9']) || " #{disptext} ".include?(" ninth costume ") || " #{disptext} ".include?(" 9th costume ") || " #{disptext} ".include?(" costume 9 ")) && j3[18].length>12
    asc=14 if (has_any?(disptext.split(' '),['tenthcostume','tenth_costume','10thcostume','10th_costume','costume10']) || " #{disptext} ".include?(" tenth costume ") || " #{disptext} ".include?(" 10th costume ") || " #{disptext} ".include?(" costume 10 ")) && j3[18].length>12
    mx=[1,2,2,3,4]
    m=mx[$donor_units[j2].ascend[0]]
    if asc<5 && asc>m
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has too low of an ascension to display that art."
      return nil
    elsif asc.zero?
      $donor_units[j2].ascend[1]=m
    else
      $donor_units[j2].ascend[1]=asc
    end
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} is now using their #{['','Default','First Ascension','Third Ascension','Final Ascension','First Costume','Second Costume','Third Costume','Fourth Costume','Fifth Costume','Sixth Costume','Seventh Costume','Eighth Costume','Ninth Costume','Tenth Costume'][$donor_units[j2].ascend[1]]} art."
  elsif ['grail','silver','gold'].include?(cmd.downcase)
    if $donor_units[j2].ascend[0]<4
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)} needs to have reached their Fianl Ascension before you can use this command."
      return nil
    elsif j3.rarity<=0
      event.respond "#{$donor_units[j2].creation_string(bot,event)} has their own color gimmicks, and never attains grailshift colors."
      return nil
    elsif j3.rarity>3 && $donor_units[j2].ascend[2]>=0
      event.respond "#{$donor_units[j2].creation_string(bot,event)} is already gold naturally."
      return nil
    elsif j3.rarity>2 && $donor_units[j2].ascend[2]>=1
      event.respond "#{$donor_units[j2].creation_string(bot,event)} is already grailshifted once, to gold."
      return nil
    elsif j3.rarity>0 && $donor_units[j2].ascend[2]>=2
      event.respond "#{$donor_units[j2].creation_string(bot,event)} is already grailshifted twice, to gold."
      return nil
    end
    $donor_units[j2].ascend[2]+=1
    donorservants_save(uid)
    clrz=['black','bronze','silver','gold']
    color=3
    color=2 if j3.rarity<4
    color=1 if j3.rarity<3
    color=0 if j3.rarity<1
    color+=$donor_units[j2].ascend[2]
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has been grailshifted to #{clrz[color]}"
  elsif ['code','command','commandcode','deck','c1','c2','c3','c4','c5','code1','code2','code3','code4','code5','card1','card2','card3','card4','card5','q1','q2','q3','quick1','quick2','quick3','a1','a2','a3','arts1','arts2','arts3','art1','art2','art3','b1','b2','b3','buster1','buster2','buster3','bust1','bust2','bust3'].include?(cmd.downcase)
    args=args.map{|q| q.downcase}
    m=-1
    m=0 if ['code1','card1','c1','quick1','q1'].include?(cmd.downcase)
    m=1 if ['code2','card2','c2'].include?(cmd.downcase)
    m=2 if ['code3','card3','c3'].include?(cmd.downcase)
    m=3 if ['code4','card4','c4'].include?(cmd.downcase)
    m=4 if ['code5','card5','c5'].include?(cmd.downcase)
    m=12 if ['quick2','q2'].include?(cmd.downcase)
    m=13 if ['quick2','q3'].include?(cmd.downcase)
    m=21 if ['arts1','art1','a1'].include?(cmd.downcase)
    m=22 if ['arts2','art2','a2'].include?(cmd.downcase)
    m=23 if ['arts3','art3','a3'].include?(cmd.downcase)
    m=31 if ['buster1','bust1','b1'].include?(cmd.downcase)
    m=32 if ['buster2','bust2','b2'].include?(cmd.downcase)
    m=33 if ['buster3','bust3','b3'].include?(cmd.downcase)
    nums=[]
    for i in 0...args.length
      nums.push(0) if has_any?(['code1','card1','c1','quick1','q1'],args)
      nums.push(1) if has_any?(['code2','card2','c2'],args)
      nums.push(2) if has_any?(['code3','card3','c3'],args)
      nums.push(3) if has_any?(['code4','card4','c4'],args)
      nums.push(4) if has_any?(['code5','card5','c5'],args)
      nums.push(12) if has_any?(['quick2','q2'],args)
      nums.push(13) if has_any?(['quick2','q3'],args)
      nums.push(21) if has_any?(['arts1','art1','a1'],args)
      nums.push(22) if has_any?(['arts2','art2','a2'],args)
      nums.push(23) if has_any?(['arts3','art3','a3'],args)
      nums.push(31) if has_any?(['buster1','bust1','b1'],args)
      nums.push(32) if has_any?(['buster2','bust2','b2'],args)
      nums.push(33) if has_any?(['buster3','bust3','b3'],args)
    end
    m=nums[0] if nums.length>0 && m<0
    crds=[1,1,1]
    crds[0]+=1 if j3.deck.include?('QQ')
    crds[0]+=1 if j3.deck.include?('QQQ')
    crds[1]+=1 if j3.deck.include?('AA')
    crds[1]+=1 if j3.deck.include?('AAA')
    crds[2]+=1 if j3.deck.include?('BB')
    crds[2]+=1 if j3.deck.include?('BBB')
    jx=find_data_ex(:find_code,args.join(' '),event)
    m2=[]
    for i in 0...crds[0]
      m2.push("#{['1st','2nd','3rd'][i]} Quick")
    end
    for i in 0...crds[1]
      m2.push("#{['1st','2nd','3rd'][i]} Arts")
    end
    for i in 0...crds[2]
      m2.push("#{['1st','2nd','3rd'][i]} Buster")
    end
    if m<0
      event.respond "No Command Card was specified."
      return nil
    elsif m>10 && m%10>crds[m/10-1]
      event.respond "#{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)} only has #{crds[m/10-1]} #{['Quick','Arts','Buster'][m/10-1]} card#{'s' unless crds[m/10-1]==1}."
      return nil
    elsif has_any?(['reset','revert'],args)
      if m>10
        m-=11 if m<20
        m-=21-crds[0] if m>20 && m<30
        m-=31-crds[0]-crds[1] if m>30
      end
      $donor_units[j2].codes[m]=0
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has removed the Command Card attached to their #{m2[m]} card."
      return nil
    elsif jx.nil? || jx.length<=0
      event.respond "No Command Code was specified."
      return nil
    elsif j3[0]==127 && jx[0]==39 && !has_any?(['cmd39','cmd-39','cmd_39','cmddavinci','davincicmd','commanddavinci','davincicommand'],args)
      event.respond "I am detecting\n- the servant #{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)}\n- the Command Code #{jx.name} [Cmd-#{jx.id}]\n\nPlease try this command again but include an alias for the Command Code that doesn't conflict with the servant."
      return nil
    elsif m>10
      m-=11 if m<20
      m-=21-crds[0] if m>20 && m<30
      m-=31-crds[0]-crds[1] if m>30
    end
    $donor_units[j2].codes[m]=jx.id
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has equipped #{jx.name} [Cmd-#{jx.id}] to their #{m2[m]} card."
  elsif ['skill','skill1','skill2','skill3','skill-1','skill-2','skill-3','skill_1','skill_2','skill_3','s1','s2','s3','append','append1','append2','append3','append-1','append-2','append-3','append_1','append_2','append_3','a1','a2','a3'].include?(cmd.downcase)
    m=-1
    m=0 if ['skill1','skill-1','skill_1','s1'].include?(cmd.downcase)
    m=1 if ['skill2','skill-2','skill_2','s2'].include?(cmd.downcase)
    m=2 if ['skill3','skill-3','skill_3','s3'].include?(cmd.downcase)
    m=3 if ['append1','append-1','append_1','a1'].include?(cmd.downcase)
    m=4 if ['append2','append-2','append_2','a2'].include?(cmd.downcase)
    m=5 if ['append3','append-3','append_3','a3'].include?(cmd.downcase)
    nums=[]
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>-1
        nums.push(args[i].to_i)
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0
        nums.push(0-args[i][1,args[i].length-1].to_i)
      elsif ['upgrade','interlude','rankup','rank','up'].include?(args[i].downcase)
        nums.push(-100)
      elsif ['reset','revert'].include?(args[i].downcase)
        nums.push(-200)
      elsif m==-1
        m=0 if ['skill1','skill-1','skill_1','s1'].include?(args[i].downcase)
        m=1 if ['skill2','skill-2','skill_2','s2'].include?(args[i].downcase)
        m=2 if ['skill3','skill-3','skill_3','s3'].include?(args[i].downcase)
        m=3 if ['append1','append-1','append_1','a1'].include?(args[i].downcase)
        m=4 if ['append2','append-2','append_2','a2'].include?(args[i].downcase)
        m=5 if ['append3','append-3','append_3','a3'].include?(args[i].downcase)
      end
    end
    typ=0
    for i in 0...nums.length
      if m<0 && nums[i]<4 && nums[i]>0
        m=nums[i]-1
      elsif typ==0 && nums[i]<0 && nums[i]>-11
        typ=0-nums[i]
      elsif typ==0 && nums[i]>0 && nums[i]<11
        typ=nums[i]*1
      elsif typ==0 && [-100,100].include?(nums[i])
        typ=-1
      elsif typ==0 && [-200,200].include?(nums[i])
        typ=-2
      end
    end
    typ=1 if typ.zero?
    sklstr="S#{m+1}"
    sklstr="A#{m-2}" if m>2
    if m<0
      event.respond "No skills were upgraded because no skill slot was defined."
      return nil
    elsif typ==-1
      if $donor_units[j2].skill_levels[m].include?('u')
        f=$donor_units[j2].skill_levels[m].split('u')[1].to_i
        f=1 if $donor_units[j2].skill_levels[m][-1]=='u'
        f2=[j3.actives[0],j3.actives[1],j3.actives[2],j3.appends[0],j3.appends[1],j3.appends[2]][m].length
        if f>=f2-1
          event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} is already upgraded to the maximum level."
        else
          $donor_units[j2].skill_levels[m]="#{$donor_units[j2].skill_levels[m].split('u')[0].to_i}u#{f+1}"
          donorservants_save(uid)
          event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} has been upgraded again due to an Interlude or Rank-Up Quest."
        end
      elsif m<3 && (j3.actives[m][1].nil? || j3.actives[m][1].length<=0)
        event.respond "#{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} cannot be upgraded yet."
      elsif m>2 && (j3.appends[m-3][1].nil? || j3.appends[m-3][1].length<=0)
        event.respond "#{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} cannot be upgraded yet."
      else
        $donor_units[j2].skill_levels[m]="#{$donor_units[j2].skill_levels[m]}u"
        donorservants_save(uid)
        event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} has been upgraded due to an Interlude or Rank-Up Quest."
      end
      return nil
    elsif typ==-2
      $donor_units[j2].skill_levels[m]="0"
      $donor_units[j2].skill_levels[m]="1" if m==0
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} has been reset to an unupgraded level #{$donor_units[j2].skill_levels[m]}."
      return nil
    end
    n=''
    n='u' if $donor_units[j2].skill_levels[m].include?('u')
    n="u#{$donor_units[j2].skill_levels[m].split('u')[1]}" if $donor_units[j2].skill_levels[m].split('u').length>1
    f=$donor_units[j2].skill_levels[m].split('u')[0].to_i
    $donor_units[j2].skill_levels[m]="#{[$donor_units[j2].skill_levels[m].split('u')[0].to_i+typ,10].min}#{n}"
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s #{sklstr} has been leveled by #{$donor_units[j2].skill_levels[m].split('u')[0].to_i-f} ~~(from #{f} to #{$donor_units[j2].skill_levels[m].split('u')[0]})~~."
  elsif ['np','merge','merges'].include?(cmd.downcase)
    typ=0
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6 && typ.zero?
        typ=args[i].to_i
      elsif args[i][0,1]=='+' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && args[i][1,args[i].length-1].to_i<6 && typ.zero?
        typ=args[i][1,args[i].length-1].to_i
      elsif ['upgrade','interlude','rankup','rank','up'].include?(args[i].downcase)
        typ=-1
      elsif ['reset','revert'].include?(args[i].downcase)
        typ=-2
      end
    end
    typ=1 if typ.zero?
    if typ==-1
      if $donor_units[j2].np_level.include?('u')
        f=$donor_units[j2].np_level.split('u')[1].to_i
        f=1 if $donor_units[j2].np_level[-1]=='u'
        f2=$nobles.reject{|q| q.id.split('u')[0].to_i==$donor_units[j2].id.to_i}.length
        if f>=f2
          event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s Noble Phantasm is already to the maximum level."
        else
          $donor_units[j2].np_level="#{$donor_units[j2].np_level.to_i}u#{f+1}"
          donorservants_save(uid)
          event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s Noble Phantasm has been upgraded again due to an Interlude or Rank-Up Quest."
        end
      elsif $nobles.find_index{|q| q.id=="#{j3.id}u"}.nil?
        event.respond "#{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)}'s Noble Phantasm cannot be upgraded yet."
      else
        $donor_units[j2].np_level="#{$donor_units[j2].np_level}u"
        donorservants_save(uid)
        event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s Noble Phantasm has been upgraded due to an Interlude or Rank-Up Quest."
      end
      return nil
    elsif typ==-1
      $donor_units[j2].np_level="1"
      donorservants_save(uid)
      event.respond "Your #{$donor_units[j2].creation_string(bot,event)}'s Noble Phantasm has reset to an unupgraded NP1."
      return nil
    end
    n=''
    n='u' if $donor_units[j2][4].include?('u')
    n="u#{$donor_units[j2].np_level.split('u')[1]}" if $donor_units[j2].np_level.split('u').length>1
    $donor_units[j2].np_level="#{[$donor_units[j2].np_level.split('u')[0].to_i+typ,5].min}#{n}"
    donorservants_save(uid)
    event.respond "Your #{$donor_units[j2].creation_string(bot,event)} has been merged to NP#{$donor_units[j2].np_level.split('u')[0]}."
  elsif ['upgrade','interlude','rankup','rank','up'].include?(cmd.downcase) && j3.id<2
    j4=$donor_units[j2].clone
    if $donor_units[j2].id==1.1
      $donor_units[j2].id=1.2
    else
      $donor_units[j2].id=1.1
    end
    donorservants_save(uid)
    event.respond "Your #{j4.creation_string(bot,event)} has entered her #{['Default','Camelot','Orthenaus'][($donor_units[j2].id*10-10).to_i]} form [Srv-##{$donor_units[j2].id}]."
  elsif ['burn','delete'].include?(cmd.downcase)
    if $donor_units[j2].fav?
      event.respond "Who are you and what have you done with Mathoo?  He will never burn an adorable smol."
      return nil
    end
    for i in 0...$donor_units.length
      $donor_units[i]=nil if $donor_units[i].id==j3.id
    end
    $donor_units.compact!
    donorservants_save(uid)
    event.respond "Your #{j3.name} [Srv-##{j3.id}] #{j3.emoji(bot,event)} has been burned."
  elsif ['support','supports','friends','friend'].include?(cmd.downcase)
    support=$support_lineups[$support_lineups.find_index{|q| q.owner=='Mathoo'}].clone
    pos=8
    pos=1 if j3.clzz=='Saber'
    pos=2 if j3.clzz=='Archer'
    pos=3 if j3.clzz=='Lancer'
    pos=4 if j3.clzz=='Rider'
    pos=5 if j3.clzz=='Caster'
    pos=6 if j3.clzz=='Assassin'
    pos=7 if j3.clzz=='Berserker'
    pos=0 if event.message.text.downcase.split(' ').include?('all')
    support.lineup[pos].servant_id=j3.id
    s=$support_lineups.reject{|q| q.owner_id !=uid}.map{|q| q.clone}
    $support_lineups=$support_lineups.reject{|q| q.owner_id==uid}.map{|q| q.clone}
    s=s.reject{|q| q.nationality==support.nationality}
    $support_lineups.push(support.clone)
    for i in 0...s.length
      $support_lineups.push(s[i].clone)
    end
    devservants_save(uid)
    str="Your #{$donor_units[j2].creation_string(bot,event)} is now in your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot."
    if $donor_units[j2].ce_equip>0
      cfts=$crafts.map{|q| q}
      ce=cfts.find_index{|q| q.id==$donor_units[j2].ce_equip}
      if ce.nil?
        event.respond str
      else
        ce=cfts[ce]
        event.respond "#{str}\nThey have #{ce.name} [CE-##{ce.id}] as their local CE.  Would you like to copy this to your Support lineup?"
        @stored_event=[event,support,pos,ce]
        event.channel.await(:bob, contains: /(yes)|(no)/i, from: uid) do |e|
          if e.message.text.downcase.include?('no')
            e.respond 'Okay.'
          else
            support=@stored_event[1]
            pos=@stored_event[2]
            ce=@stored_event[3]
            support.lineup[pos].ce_id=ce.id
            s=$support_lineups.reject{|q| q.owner_id !=uid}.map{|q| q.clone}
            $support_lineups=$support_lineups.reject{|q| q.owner_id==uid}.map{|q| q.clone}
            s=s.reject{|q| q.nationality==support.nationality}
            $support_lineups.push(support.clone)
            for i in 0...s.length
              $support_lineups.push(s[i].clone)
            end
            devservants_save(uid)
            e.respond "You have equipped a #{ce.name} [CE-##{ce.id}] to your Support #{['All','Saber','Archer','Lancer','Rider','Caster','Assassin','Berserker','Extra'][pos]} Slot."
          end
        end
      end
    else
      event.respond str
    end
  else
    event.respond 'Edit mode was not specified.'
  end
  return nil
end

def snagstats(event,bot,f=nil,f2=nil)
  nicknames_load()
  data_load()
  metadata_load()
  f='' if f.nil?
  f2='' if f2.nil?
  bot.servers.values(&:members)
  k=bot.servers.values.length
  k=1 if Shardizard==4 # Debug shard shares the five emote servers with the main account
  $server_data[0][Shardizard]=k
  $server_data[1][Shardizard]=bot.users.size
  metadata_save()
  if ['servers','server','members','member','shard','shards','user','users'].include?(f.downcase)
    str="**I am in #{longFormattedNumber($server_data[0].inject(0){|sum,x| sum + x })} servers, reaching approximately #{longFormattedNumber($server_data[1].inject(0){|sum,x| sum + x })} users.**"
    for i in 0...Shards
      m=i
      m=i+1 if i>3
      str=extend_message(str,"The #{shard_data(0,true)[i]} Shard is in #{longFormattedNumber($server_data[0][m])} server#{"s" if $server_data[0][0]!=1}, reaching #{longFormattedNumber($server_data[1][m])} users.",event)
    end
    str=extend_message(str,"The #{shard_data(0)[4]} Shard is in #{longFormattedNumber($server_data[0][4])} server#{"s" if $server_data[0][4]!=1}, reaching #{longFormattedNumber($server_data[1][0])} unique members.",event,2) if event.user.id==167657750971547648
    event.respond str
    return nil
  elsif ['alts','alt','alternate','alternates','alternative','alternatives'].include?(f.downcase)
    srv=$servants.reject{|q| q.id !=q.id.to_i}
    m=srv.reject{|q| !q.alts.include?('Alter') || q.alts.include?('no-alter')}
    str="**There are #{m.length} Alter servants**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origins"
    f=(m.map{|q| q.alts[0]}.uniq.length==m.map{|q| q.alts[0,2].join(' ')}.uniq.length)
    str="#{str} across #{m.map{|q| q.alts[0,2].join(' ')}.uniq.length} SO-universes" unless f
    m=srv.reject{|q| !has_any?(q.alts,['Lily','Young']) || has_any?(q.alts,['no-lily','no-young'])}
    str="#{str}\n**There are #{m.length} Lily/Young servants**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origins"
    f=(m.map{|q| q.alts[0]}.uniq.length==m.map{|q| q.alts[0,2]}.uniq.length)
    str="#{str} across #{m.map{|q| q.alts[0,2]}.uniq.length} SO-universes" unless f
    m=srv.reject{|q| !q.alts.include?('Summer') || q.alts.include?('no-summer')}
    str="#{str}\n**There are #{m.length} Summer servants**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origins"
    m=srv.reject{|q| !q.alts.include?('Bride') || q.alts.include?('no-bride')}
    str="#{str}\n**There are #{m.length} Bride servant#{'s' unless m.length==1}**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origin#{'s' unless m.map{|q| q.alts[0]}.uniq.length==1}"
    m=srv.reject{|q| !q.alts.include?('Maid') || q.alts.include?('no-maid')}
    str="#{str}\n**There are #{m.length} Maid servant#{'s' unless m.length==1}**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origin#{'s' unless m.map{|q| q.alts[0]}.uniq.length==1}"
    m=srv.reject{|q| !q.alts.include?('Santa') || q.alts.include?('no-santa')}
    str="#{str}\n**There are #{m.length} Santa servant#{'s' unless m.length==1}**, covering #{m.map{|q| q.alts[0]}.uniq.length} Spirit Origin#{'s' unless m.map{|q| q.alts[0]}.uniq.length==1}"
    m=srv.map{|q| [q.alts[0],0]}.uniq
    for i in 0...m.length
      m[i][1]=srv.reject{|q| q.alts[0]!=m[i][0]}.length
    end
    m=m.sort{|a,b| a[1]<=>b[1]}
    k=m.reject{|q| q[1]!=m[0][1]}
    if k.length>=10
      str2="There are #{k.length} Spirit Origin#{'s' unless k.length==1} that have no alts"
    else
      str2="#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{'is' if k.length==1}#{'are' unless k.length==1} the Spirit Origin#{'s' unless k.length==1} that have no alts."
    end
    str=extend_message(str,str2,event,2)
    m=m.reverse
    k=m.reject{|q| q[1]!=m[0][1]}
    str2="#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{'is' if k.length==1}#{'are' unless k.length==1} the Spirit Origin#{'s' unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{' each' unless k.length==1}."
    str=extend_message(str,str2,event,2)
    m=srv.map{|q| ["#{q.alts[0]}#{" (#{q.alts[1]})" unless q.alts[1]=='-'}",0]}.uniq
    for i in 0...m.length
      m[i][1]=srv.reject{|q| "#{q.alts[0]}#{" (#{q.alts[1]})" unless q.alts[1]=='-'}"!=m[i][0]}.length
    end
    m=m.sort{|b,a| a[1]<=>b[1]}
    k=m.reject{|q| q[1]!=m[0][1]}
    str2="#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{'is' if k.length==1}#{'are' unless k.length==1} the SO-universe#{'s' unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{' each' unless k.length==1}."
    str=extend_message(str,str2,event,1)
    m=srv.map{|q| ["#{q.alts[0]}#{" (#{q.alts[1]})" unless q.alts[1]=='-'}#{" (#{q.alts[2]})" unless q.alts[2]=='-'}",0]}.uniq
    for i in 0...m.length
      m[i][1]=srv.reject{|q| "#{q.alts[0]}#{" (#{q.alts[1]})" unless q.alts[1]=='-'}#{" (#{q.alts[2]})" unless q.alts[2]=='-'}"!=m[i][0]}.length
    end
    m=m.sort{|b,a| a[1]<=>b[1]}
    k=m.reject{|q| q[1]!=m[0][1]}
    str2="#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{'is' if k.length==1}#{'are' unless k.length==1} the SO-facet#{'s' unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{' each' unless k.length==1}."
    str=extend_message(str,str2,event,1)
    event.respond str
    return nil
  elsif ['servant','servants','unit','units','character','characters','chara','charas','char','chars'].include?(f.downcase)
    lookout=[]
    if File.exist?("#{$location}devkit/FGOSkillSubsets.txt")
      lookout=[]
      File.open("#{$location}devkit/FGOSkillSubsets.txt").each_line do |line|
        lookout.push(eval line)
      end
    end
    lookout=lookout.reject{|q| q[2]!='Class' || !q[3].nil?}.map{|q| q[0]}
    srv=$servants.reject{|q| q.id !=q.id.to_i}
    point_five=true
    x=nil
    unless f2.nil? || f2.length<=0
      x=find_in_servants(bot,event,[f2],1)
      srv=x[2].map{|q| q.clone}
      if !srv.find_index{|q| q.id==1.0}.nil? && !srv.find_index{|q| q.id !=q.id.to_i}.nil?
        srv=srv.reject{|q| q.id !=q.id.to_i}
      elsif !srv.find_index{|q| q.id==1.2}.nil? && !srv.find_index{|q| q.id==1.1}.nil?
        srv=srv.reject{|q| q.id==1.2}
        point_five=false
      else
        point_five=false
      end
    end
    str="**There are #{srv.length} servants, including:**"
    str="#{x[0].join("\n")}\n**With these filters, there are #{srv.length} servants, including:**" unless x.nil?
    str2=''
    m=srv.reject{|q| q.clzz !='Shielder'}
    str2="<:class_shielder_gold:523838231913955348> #{m.length} Shielder#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Saber'}
    str2="#{str2}\n<:class_saber_gold:523838273479507989> #{m.length} Saber#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Archer'}
    str2="#{str2}\n<:class_archer_gold:523838461195714576> #{m.length} Archer#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Lancer'}
    str2="#{str2}\n<:class_lancer_gold:523838511485419522> #{m.length} Lancer#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Rider'}
    str2="#{str2}\n<:class_rider_gold:523838542577664012> #{m.length} Rider#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Caster'}
    str2="#{str2}\n<:class_caster_gold:523838570893672473> #{m.length} Caster#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Assassin'}
    str2="#{str2}\n<:class_assassin_gold:523838617693716480> #{m.length} Assassin#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.clzz !='Berserker'}
    str2="#{str2}\n<:class_berserker_gold:523838648370724897> #{m.length} Berserker#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| !lookout.include?(q.clzz) && q.clzz !='Ruler' && q.clzz !='Shielder'}
    str2="#{str2}\n<:class_extra_gold:523838907591294977> #{m.length} extra class servant#{'s' unless m.length==1} (including Shielders)" if m.length>0
    m=srv.reject{|q| lookout.include?(q.clzz) || ['Saber','Shielder','Archer','Lancer','Rider','Caster','Assassin','Berserker','Ruler'].include?(q.clzz)}
    str2="#{str2}\n<:class_unknown_gold:523838979825467392> #{m.length} servant#{'s' unless m.length==1} with enemy-exclusive classes" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=srv.reject{|q| q.rarity !=0}
    str2="<:FGO_rarity_off:544583775208603688> #{m.length} no-star servant#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.rarity !=1}
    str2="#{str2}\n<:FGO_rarity_1:544583775330369566> #{m.length} one-star servant#{'s' unless m.length==1}" if m.length>0
    m=srv.reject{|q| q.rarity !=2}
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{m.length} two-star servant#{'s' unless m.length==1}" if m.length>0
    if point_five
      str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{srv.reject{|q| q.rarity !=3}.length-1}.5 three-star servants"
      str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{srv.reject{|q| q.rarity !=4}.length}.5 four-star servants"
    else
      m=srv.reject{|q| q.rarity !=3}
      str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{m.length} three-star servant#{'s' unless m.length==1}" if m.length>0
      m=srv.reject{|q| q.rarity !=4}
      str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{m.length} four-star servant#{'s' unless m.length==1}" if m.length>0
    end
    m=srv.reject{|q| q.rarity !=5}
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{m.length} five-star servant#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=srv.reject{|q| q.attribute !='Man'}
    str2="#{m.length} servant#{'s' unless m.length==1} with the Man attribute" if m.length>0
    m=srv.reject{|q| q.attribute !='Sky'}
    str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with the Sky attribute" if m.length>0
    m=srv.reject{|q| q.attribute !='Earth'}
    str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with the Earth attribute" if m.length>0
    m=srv.reject{|q| q.attribute !='Star'}
    str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with the Star attribute" if m.length>0
    m=srv.reject{|q| q.attribute !='Beast'}
    str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with the Beast attribute" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=srv.reject{|q| q.grow_curve !='Linear'}
      str2="#{m.length} servant#{'s' unless m.length==1} with Linear growth curves" if m.length>0
      m=srv.reject{|q| q.grow_curve !='S'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with S growth curves" if m.length>0
      m=srv.reject{|q| q.grow_curve !='Reverse S'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with Reverse S growth curves" if m.length>0
      m=srv.reject{|q| q.grow_curve !='Semi S'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with Semi S growth curves" if m.length>0
      m=srv.reject{|q| q.grow_curve !='Semi Reverse S'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with Semi Reverse S growth curves" if m.length>0
      m=srv.reject{|q| ['Linear','S','Reverse S','Semi S','Semi Reverse S'].include?(q.grow_curve)}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with unknown growth curves" unless m.length<=0
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
      str2=''
      m=srv.reject{|q| q.deck[0,5]!='QQQAB'}
      str2="#{m.length} servant#{'s' unless m.length==1} with triple-Quick (Quick Brave) decks." if m.length>0
      m=srv.reject{|q| q.deck[0,5]!='QQAAB'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with double-Quick/double-Arts decks." if m.length>0
      m=srv.reject{|q| q.deck[0,5]!='QQABB'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with double-Quick/double-Buster decks." if m.length>0
      m=srv.reject{|q| q.deck[0,5]!='QAAAB'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with triple-Arts (Arts Brave) decks." if m.length>0
      m=srv.reject{|q| q.deck[0,5]!='QAABB'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with double-Arts/double-Buster decks." if m.length>0
      m=srv.reject{|q| q.deck[0,5]!='QABBB'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with triple-Buster (Buster Brave) decks." if m.length>0
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
      str2=''
      m=srv.reject{|q| q.deck[6,1]!='Q'}
      str2="#{m.length} servant#{'s' unless m.length==1} with Quick Noble Phantasms." if m.length>0
      m=srv.reject{|q| q.deck[6,1]!='A'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with Arts Noble Phantasms." if m.length>0
      m=srv.reject{|q| q.deck[6,1]!='B'}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with Buster Noble Phantasms." if m.length>0
      m=srv.reject{|q| ['Q','A','B'].include?(q.deck[6,1])}
      str2="#{str2}\n#{m.length} servant#{'s' unless m.length==1} with no Noble Phantasm." unless m.length<=0
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['ce','craft','essance','craftessance','essence','craftessence','ces','crafts','essances','craftessances','essences','craftessences'].include?(f.downcase)
    crf=$crafts.map{|q| q.clone}
    srv=$servants.map{|q| q.clone}
    str="**There are #{crf.length} Craft Essences, including:**"
    str2=''
    str2="<:FGO_rarity_1:544583775330369566> #{crf.reject{|q| q.rarity !=1}.length} one-star CE#{'s' if crf.reject{|q| q.rarity !=1}.length>1}"
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{crf.reject{|q| q.rarity !=2}.length} two-star CE#{'s' if crf.reject{|q| q.rarity !=2}.length>1}"
    str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{crf.reject{|q| q.rarity !=3}.length} three-star CE#{'s' if crf.reject{|q| q.rarity !=3}.length>1}"
    str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{crf.reject{|q| q.rarity !=4}.length} four-star CE#{'s' if crf.reject{|q| q.rarity !=4}.length>1}"
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{crf.reject{|q| q.rarity !=5}.length} five-star CE#{'s' if crf.reject{|q| q.rarity !=5}.length>1}"
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    c=crf.map{|q| q.id.to_i}
    m=srv.map{|q| q.bond_ce}.join(', ').split(', ').map{|q| q.to_i}.reject{|q| q<c.min || q>c.max}.uniq
    str2="<:Bond:613804021119189012> #{m.length} Bond CE#{'s' if m.length>1}"
    m=srv.map{|q| q.valentines_ce}.join(', ').split(', ').map{|q| q.to_i}.reject{|q| q<c.min || q>c.max}.uniq
    str2="#{str2}\n<:Valentines:676941992768569374> #{m.length} Valentine's CE#{'s' if m.length>1}"
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['command','commandcode','commands','commandcodes'].include?(f.downcase)
    crf=$codes.map{|q| q.clone}
    str="**There are #{crf.length} Command Codes, including:**"
    str2=''
    str2="<:FGO_rarity_1:544583775330369566> #{crf.reject{|q| q.rarity !=1}.length} one-star Command Code#{'s' if crf.reject{|q| q.rarity !=1}.length>1}"
    str2="#{str2}\n<:FGO_rarity_2:544583776148258827> #{crf.reject{|q| q.rarity !=2}.length} two-star Command Code#{'s' if crf.reject{|q| q.rarity !=2}.length>1}"
    str2="#{str2}\n<:FGO_rarity_3:544583774944624670> #{crf.reject{|q| q.rarity !=3}.length} three-star Command Code#{'s' if crf.reject{|q| q.rarity !=3}.length>1}"
    str2="#{str2}\n<:FGO_rarity_4:544583774923653140> #{crf.reject{|q| q.rarity !=4}.length} four-star Command Code#{'s' if crf.reject{|q| q.rarity !=4}.length>1}"
    str2="#{str2}\n<:FGO_rarity_5:544583774965596171> #{crf.reject{|q| q.rarity !=5}.length} five-star Command Code#{'s' if crf.reject{|q| q.rarity !=5}.length>1}"
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['alias','aliases','name','names','nickname','nicknames'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',1) rescue nil
    glbl=$aliases.reject{|q| q[0]!='Servant' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Servant' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    all_units=$servants.map{|q| [q[0],q[1],0,0]}
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
    if event.server.nil? && Shardizard==4
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
    glbl=$aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global skill aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific skill aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| !['Active','Passive','ClothingSkill'].include?(q[0]) || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Craft' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Craft' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Craft Essence aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Craft Essence aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Craft' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Craft' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Material' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Material' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length+77)} global material aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific material aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Clothes' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Clothes' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Mystic Code (clothing) aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Mystic Code (clothing) aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Clothes' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Clothes' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Command' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Command' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Command Code aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Command Code aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Command' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Command' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3) rescue nil
    b=[[],[],[],[],[]]
    File.open("#{$location}devkit/LizBot.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[3].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    File.open("#{$location}devkit/rot8er_functs.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    File.open("#{$location}devkit/LizClassFunctions.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("#{$location}devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[3].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**I rely on a library that is #{longFormattedNumber(File.foreach("#{$location}devkit/rot8er_functs.rb").inject(0) {|c, line| c+1}+File.foreach("#{$location}devkit/LizClassFunctions.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[2].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, it appears to be #{longFormattedNumber(b[4].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command('}.length)} commands, invoked with #{longFormattedNumber(all_commands().length)} different phrases.**"
    event << 'This includes:'
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || !q.include?('from: 167657750971547648')}.length)} dev-only commands, invoked with #{longFormattedNumber(all_commands(false,2).length)} different phrases."
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
  elsif event.user.id==167657750971547648 && !f.nil? && f.to_i.to_s==f
    srv=(bot.server(f.to_i) rescue nil)
    if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      s2="I am not in that server, but it would be assigned to the #{shard_data(0,true)[(f.to_i >> 22) % Shards]} Shard."
    else
      s2="__**#{srv.name}** (#{srv.id})__\n*Owner:* #{srv.owner.distinct} (#{srv.owner.id})\n*Shard:* #{shard_data(0,true)[(f.to_i >> 22) % Shards]}\n*My nickname:* #{bot.user(502288364838322176).on(srv.id).display_name}"
    end
    event.respond s2
    return nil
  end
  glbl=$aliases.reject{|q| q[0]!='Servant' || !q[3].nil?}
  srv_spec=$aliases.reject{|q| q[0]!='Servant' || q[3].nil?}
  b=[]
  File.open("#{$location}devkit/LizBot.rb").each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  event << "**I am in #{longFormattedNumber($server_data[0].inject(0){|sum,x| sum + x })} *servers*.**"
  event << "This shard is in #{longFormattedNumber($server_data[0][Shardizard])} server#{"s" unless $server_data[0][Shardizard]==1}."
  event << ''
  event << "**There are #{longFormattedNumber($servants.length)} *servants*.**"
  event << ''
  event << "**There are #{longFormattedNumber($skills.length)} skills.**"
  event << "There are #{longFormattedNumber($skills.reject{|q| q.type !='Active'}.length)} active skills, split into #{longFormattedNumber($skills.reject{|q| q.type !='Active'}.map{|q| q.name}.uniq.length)} families."
  event << "There are #{longFormattedNumber($skills.reject{|q| q.type !='Append'}.length)} append skills, split into #{longFormattedNumber($skills.reject{|q| q.type !='Append'}.map{|q| q.name}.uniq.length)} families."
  event << "There are #{longFormattedNumber($skills.reject{|q| q.type !='Passive'}.length)} passive skills, split into #{longFormattedNumber($skills.reject{|q| q.type !='Passive'}.map{|q| q.name}.uniq.length)} families."
  event << "There are #{longFormattedNumber($skills.reject{|q| q.type !='ClothingSkill'}.length)} clothing skills."
  event << "There are #{longFormattedNumber($nobles.length)} Noble Phantasms."
  event << ''
  event << "**There are #{longFormattedNumber($crafts.length)} *Craft Essences*.**"
  event << ''
  event << "There are #{longFormattedNumber($clothes.length)} Mystic Codes."
  event << "There are #{longFormattedNumber($codes.length)} *Command Codes*."
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("#{$location}devkit/LizBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end
