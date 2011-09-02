
joCore := $(patsubst %,js/core/%, \
    log.js \
    _jo.js \
    dom.js \
    event.js \
    subject.js \
    time.js \
    yield.js \
    cache.js \
    clipboard.js \
    local.js \
)

joData := $(patsubst %,js/data/%, \
    datasource.js \
    record.js \
    database.js \
    sqldatasource.js \
    filesource.js \
    script.js \
    preference.js \
    yql.js \
    dispatch.js \
)

joUi := $(patsubst %,js/ui/%, \
    interface.js \
    collect.js \
    view.js \
    container.js \
    control.js \
    button.js \
    list.js \
    busy.js \
    caption.js \
    card.js \
    stack.js \
    scroller.js \
    divider.js \
    expando.js \
    expandotitle.js \
    flexrow.js \
    focus.js \
    footer.js \
    gesture.js \
    group.js \
    html.js \
    input.js \
    label.js \
    menu.js \
    option.js \
    passwordinput.js \
    popup.js \
    screen.js \
    shim.js \
    sound.js \
    stackscroller.js \
    tabbar.js \
    table.js \
    textarea.js \
    title.js \
    toolbar.js \
    form.js \
    dialog.js \
    selectlist.js \
    navbar.js \
    select.js \
    toggle.js \
    slider.js \
)

joAllSources := $(joCore) $(joData) $(joUi)

joDocInputs := CONTENTS.mdown ABOUT.mdown README.mdown $(wildcard docs/*.mdown) LICENSE.mdown
joDocStatic := docs/doc.css docs/docbody.css docs/jodog.png
joDocStaticTargets := $(patsubst %,ship/%,$(joDocStatic))

joThemeStatic := $(wildcard css/*.png)
joThemeStaticTargets := $(patsubst css/%,ship/jo/%,$(joThemeStatic))

all: ship/jo/jo.js ship/jo/jo_min.js ship/jo/jo.css ship/docs/index.html
all: $(joDocStaticTargets) $(joThemeStaticTargets)

ship/jo ship/docs: %:
	mkdir -p $@

ship/jo/jo.js: $(joAllSources) | ship/jo
	cat $^ > $@.new
	mv $@.new $@

ship/jo/jo_min.js: ship/jo/jo.js
	jsmin < $< > $@.new
	mv $@.new $@

ship/jo/jo.css: $(wildcard less/*.less)
	lessc less/jo.less > $@.new
	mv $@.new $@

ship/docs/index.html: $(joDocInputs) $(joAllSources) | ship/docs
	../joDoc/jodoc --title "Jo HTML5 Mobile App Framework Documentation" --markdown "../../markdown/gruber/Markdown.pl" $^ > $@.new
	mv $@.new $@

ship/docs/%: docs/% ship/docs
	cp $< $@.new
	mv $@.new $@

ship/jo/%: css/% ship/jo
	cp $< $@.new
	mv $@.new $@


