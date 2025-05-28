ESX = exports["es_extended"]:getSharedObject()

local originalSettingsSaved = false

local function saveOriginalSettings()
    if not originalSettingsSaved then

        originalSettingsSaved = true
    end
end

local elements = {
    {label = 'FPS - Poprawia Optymalizację', value = 'fps'},
    {label = 'GRAFIKA - Poprawia Grafikę', value = 'graphics'},
    {label = 'Domyślne - Przywraca ustawienia domyślne', value = 'default'}
}

RegisterCommand('fps', function()
    saveOriginalSettings()
    
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vs_fps_menu', {
        title = 'Boost FPS',
        align = 'center',  
        elements = elements,
    }, function(data, menu)
        if data.current.value == 'fps' then
            SetTimecycleModifier('yell_tunnel_nodirect')
            ESX.ShowNotification('Ustawienia zoptymalizowane pod FPS')

        elseif data.current.value == 'graphics' then
            SetTimecycleModifier('MP_Powerplay_blend')
            SetExtraTimecycleModifier('reflection_correct_ambient')
            SetVisualSettingFloat('Grass', 0.25)
            SetVisualSettingFloat('VehicleDensity', 0.5)
            ESX.ShowNotification('Zwiększono jakość grafiki')

        elseif data.current.value == 'default' then
            ClearTimecycleModifier()
            ClearExtraTimecycleModifier()
            ResetVisualSetting('Grass')
            ResetVisualSetting('VehicleDensity')
            ESX.ShowNotification('Przywrócono ustawienia domyślne')
        end
    end, function(data, menu)
        menu.close()
    end)
end)
