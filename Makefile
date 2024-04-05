all:
	cp ./init.lua ~/.config/nvim/
	cp -r lua ~/.config/nvim/
	cp -r after ~/.config/nvim/

clean:
	rm -rf ~/.config/nvim/
	mkdir ~/.config/nvim
	make all
