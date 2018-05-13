SRC=upgrade.php
DOC=jdcloud-upgrade.html

all: $(DOC)

clean:
	-rm -rf $(DOC)

$(DOC): $(SRC)
	jdcloud-gendoc $^ > $@

%.html: %.md
	pandoc $< > $@
