function onUpdate(elapsed)

	if getProperty('health') < 0.001 then

		setProperty('health', 0.001);

	end
end

function onGameOver() -- failsafe

	return Function_Stop;

end