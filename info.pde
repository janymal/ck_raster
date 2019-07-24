void info() {
  /*
	menu info opisy
   	*/

  fill(255);
  strokeWeight(1);
  stroke(0);

  // tło menu info
  rect(0, 50, 950, 430);

  // --------------------------------------------- [ opis do menu ]
  noStroke();
  fill(0);

  pushMatrix();
  translate(415, 51);


  textFont(font);
  text(" – obszaru roboczego i obszaru eksportu ", 54, 80);
  text(" – obszaru roboczego i obszaru eksportu ", 54, 100);

  text(" – pojedyńczej linii ", 54, 150);
  text(" – pomiędzy liniami ", 54, 170);
  text(" – pomiędzy wierszami ", 54, 190);
  text(" – co drugiej linii ", 54, 210);
  text(" – linii ", 54, 230);

  text(" – sinusa ", 54, 280);
  text(" – powtórzeń sinusa ", 54, 300);
  text(" – wygięcia ", 54, 320);

  popMatrix();

  // --------------------------------------------- [ opis do skrótów klawiaturowych ]
  pushMatrix();
  translate(680, 50);

  text(" SKRÓTY ", 20, 60);

  text(" przesuwanie", 20, 80);
  text(" [ RMB ] *", 20, 100);

  text(" powiększanie", 20, 140);
  text(" [ + ]  lub  [ scroll ]", 20, 160);

  text(" pomniejszanie", 20, 200);
  text(" [ - ]  lub  [ scroll ]", 20, 220);

  text(" formaty drukarskie ", 20, 260);
  text(" [ A ] + [ 0 – 6 ]  i  [ B ] + [ 0 – 6 ]", 20, 280);

  text(" reset obszaru roboczego", 20, 320);
  text(" [ R ] ", 20, 340);

  text(" * prawy przycisk myszy ", 20, 380);

  popMatrix();
}


void ws_info() {
  /*
	boczne menu z informacja
   	o szerokości i wysokości
   	z przeliczeniem na 'mm'
   	*/
  textFont(font);
  textAlign(LEFT);

  fill(0);
  pushMatrix();
  translate(ws_width, -10);
  text(" szerokość ", 10, 20);
  text(ws_width, 10, 40);
  text(" px ", 70, 40);
  text(ws_width * cal, 10, 60);
  text(" mm ", 70, 60);

  text(" wysokość ", 10, 100);
  text(ws_height, 10, 120);
  text(" px ", 70, 120);
  text(ws_height * cal, 10, 140);
  text(" mm ", 70, 140);

  popMatrix();
  noFill();
}

void info_b() {
  /*
	boczne menu z informacja
   	o klatkarzu i o zoomie w procentach
   	*/

  fill(0);
  textFont(font);
  textAlign(RIGHT);
  text(" fps : " + int(frameRate) + " | " + " zoom : " + int(zoom * 100) + " %", width-10, 20);
}

void preset_info(String str, float _con) {
  /*
	popup info o wybranym formacie drukarski
   	*/

  textFont(font2);
  textAlign(CENTER);
  noStroke();

  fill(255, map(_con, 1, 50, 255, 10));
  pushMatrix();
  translate((width-350)/2, 50);
  rect(0, 0, 350, 60);
  popMatrix();

  fill(0, map(_con, 1, 50, 255, 10));
  text("FORMAT " + str, width/2, 100);
}
