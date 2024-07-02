

function onCreate()
    addCharacterToList('ruinGameOver', 'boyfriend')
    precacheImage('gameover/ruinGameOver')

    --stage1
    precacheImage('stages/ruinFreddy/bgMain')
    makeLuaSprite('bgMain', 'stages/ruinFreddy/bgMain', -100, 50)
    scaleObject('bgMain', 0.75, 0.75, true)
    screenCenter('bgMain', 'xy')
    setScrollFactor('bgMain', 1, 1)
    addLuaSprite('bgMain', false)
    setProperty('bgMain.visible', true)

    --stage2
    precacheImage('stages/ruinFreddy/bgRun')
    makeAnimatedLuaSprite('bgRun', 'stages/ruinFreddy/bgRun', -200, 0)
    addAnimationByPrefix('bgRun', 'anim', 'BG Running Sequence', 24, true)
    scaleObject('bgRun', 1, 1, true)
    setScrollFactor('bgRun', 1, 1)
    addLuaSprite('bgRun', false)
    playAnim('bgRun', 'anim', true)
    setProperty('bgRun.visible', false)

    
    precacheImage('characters/ruinBoyfriendFeet')
    makeAnimatedLuaSprite('ruinBoyfriendFeet', 'characters/ruinBoyfriendFeet', 0, 0)
    addAnimationByPrefix('ruinBoyfriendFeet', 'anim', 'BF Feet Running Sequence', 24, true)
    scaleObject('ruinBoyfriendFeet', 0.7, 0.7, true)
    screenCenter('ruinBoyfriendFeet', 'xy')
    setScrollFactor('ruinBoyfriendFeet', 1, 1)
    addLuaSprite('ruinBoyfriendFeet', false)

    setProperty('ruinBoyfriendFeet.visible', false)


    --stage3
    precacheImage('stages/ruinFreddy/bgWall')
    makeLuaSprite('bgWall', 'stages/ruinFreddy/bgWall', 0, 200)
    scaleObject('bgWall', 0.33, 0.33, true)

    setScrollFactor('bgWall', 1, 1)
    addLuaSprite('bgWall', false)
    setProperty('bgWall.visible', false)


end

function onStepHit()
    if curStep == 1024 then
        bfTorsoPosX = getProperty('boyfriend.x')
        bfTorsoPosY = getProperty('boyfriend.y')
        setProperty('ruinBoyfriendFeet.x', bfTorsoPosX - 164)
        setProperty('ruinBoyfriendFeet.y', bfTorsoPosY + 230)

        setProperty('bgMain.visible', false)
        setProperty('bgRun.visible', true)
        setProperty('ruinBoyfriendFeet.visible', true)

        playAnim('ruinBoyfriendFeet', 'anim', true)


    elseif curStep == 1152 then
        setProperty('boyfriend.alpha', 0)
        setProperty('bgRun.visible', false)
        setProperty('ruinBoyfriendFeet.visible', false)
        setProperty('bgWall.visible', true)
    end
end