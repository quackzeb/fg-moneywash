# fg-moneywash
I'm new to coding, made an advnaced moneywash script for qbcore. here it is - hopefully it helps someone.

# Dependencies
- [ox_target](https://github.com/overextended/ox_target/releases/tag/v1.16.0)
- [ox_inventory](https://github.com/overextended/ox_inventory/releases/tag/v2.40.2)
- [ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.23.1)

I highly recommend installing the latest releases.

# Images
ox_inventory > web > images
![image](https://cdn.discordapp.com/attachments/1261505938477678634/1262394914726215760/securityblack.png?ex=66967061&is=66951ee1&hm=d5cf25fec30bb25ed731963ad4ed4999b74ee4fd62ce100ca3352c0f26bd5d49&)

# Item 
ox_inventory > data > items.lua
```lua
	["laundrymat_keycard"] = {
		label = "Laundrymat Keycard",
		weight = 1,
		stack = false,
		description = "This can be used to access a laundrymat",
		client = {
			image = "securityblack.png",
		}
	}
```
You should have that already in since you are using ox_inventory, but there it is if you dont.

# Config
Quick explanation of each config

```lua
Config.moneywash = {
    tax = 0.10, -- 10% default, 0.005 = 5%, 0.5 = 50% etc etc
    cooldown = 120, -- Seconds
    washtime = 25, -- Seconds
    maxwash = 10000 -- Max washing at a time, put to like a billion for unlimited
}
```
- Tax = The amount lost after money wash, if you don't want any loss put it to 1.
- Cooldown = The amount of time the player has to wait until doing the next wash.
- Washtime = The amount of time the player has to wait during wash.
- Maxwash = The max amount of dirty money that can be washed at a time, put to billion if unlimited.

# Support
If you need any support or have any suggestions for the script, please dm froggy_.s on discord.