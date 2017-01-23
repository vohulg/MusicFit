

function renderVexpaString(noteString) {
    
    //alert("renderVexpaString run !");
    //return;
   
    /*
    noteString = "options space=20 tab-stems=true stave-distance=0 tab-stem-direction=down \n \
    tabstave notation=true key=Am time=4/4 \n\
    notes :8 0/1 0/1 0/1 0/1 | :q 3/2 :8 1/2 1/2 |  0/2 2/3 | :8 0/1 0/1 3/1 0/1 \n \
    \n\
    options space=20 \n\
    tabstave notation=true \n\
    notes :8 3/2 3/2 1/2 1/2 | :q 0/1 2/3 | :qd 0/2 :8 1/2 | :q 3/1 :8 1/2 1/2 \n\
    \
    options space=20 \n\
    tabstave notation=true \n\
    notes :q 0/2 2/3 | :qd 0/2 :8 1/2 | :8 3/2 3/2 1/2 1/2 | :q 0/2 2/3 ";
     */
    
    
    console.log(noteString);
    
    vextab = VexTabDiv;
    VexTab = vextab.VexTab;
    Artist = vextab.Artist;
    Renderer = Vex.Flow.Renderer;
    
    Artist.DEBUG = true;
    VexTab.DEBUG = false;
    
    // Create VexFlow Renderer from canvas element with id #boo
    renderer = new Renderer($('#note')[0], Renderer.Backends.CANVAS);
    
    // Initialize VexTab artist and parser.
    artist = new Artist(10, 10, 600, {scale: 0.8});
    vextab = new VexTab(artist);
    
    try {
        vextab.reset();
        artist.reset();
        vextab.parse(noteString);
        artist.render(renderer);
        $("#error").text("");
        return "success";
    } catch (e) {
        console.log(e);
        $("#error").html(e.message.replace(/[\n]/g, '<br/>'));
        return "faild";
    }
}





