function onGameOver()
    playSound('ruinGameOver')
    if not lowQuality then
	    startVideo('ruinGameOver')
    else
        startVideo('ruinGameOver-LQ')
    end
end