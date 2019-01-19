# fivem_hideintrunk
### HOW TO FORCE PEOPLE IN ###

Add this to your server side file of jobs
```lua
RegisterServerEvent('core:hideintrunk')
AddEventHandler('core:hideintrunk', function(target)
    TriggerClientEvent('core:hideintrunk', target)
end)
RegisterServerEvent('core:outoftrunk')
AddEventHandler('core:outoftrunk', function(target)
    TriggerClientEvent('core:outoftrunk', target)
end)
```
and this example for your client side menu
```lua
{label = 'Narvat do kufru', value = 'hideintrunk'},            
{label = 'Vytahnout z kufru', value = 'outoftrunk'}, 

if data.current.value == 'hideintrunk' then
    TriggerServerEvent('core:hideintrunk', GetPlayerServerId(player))
end
if data.current.value == 'outoftrunk' then
    TriggerServerEvent('core:outoftrunk', GetPlayerServerId(player))
end           
```

### REQUIREMENTS ####
- NONE, ITS STANDALONE

### KEYS ####
- **/hideintrunk** for ENTER
- **ALT + Q** for ENTER/LEAVE trunk
- **SPACE** for INVISIBILITY

### BUGS ####
- sometimes not dettaching, you have to press combination few times
- doesnt fit in every trunk, invisibility function is solution.


### TO-DO ###
- ability to adjust offset
- disable invisibility again
- server side for 3D text
- :white_check_mark: loop help notif
- rotate ped 180°
- :white_check_mark: more help texts
- :white_check_mark: force people in
- :white_check_mark: lock people in
- :white_check_mark: mathrandom of getting away?
- create scripted camera
- check how many people in (limit to one or more by vehicle category)
