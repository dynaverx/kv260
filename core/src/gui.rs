use gtk::Label;
use glib::clone;
use gtk::prelude::*;
use gtk::Entry;
use chrono::Local;
use gtk::Image;
use gtk::gdk_pixbuf::{Pixbuf};




pub fn build_ui(application: &gtk::Application) {
    let window = gtk::ApplicationWindow::new(application);
    window.set_title("ICP");
    window.set_default_size(200, 120);

    let margin = 6;
    let grid = gtk::Grid::builder()
        .margin_start(margin)
        .margin_end(margin)
        .margin_top(margin)
        .margin_bottom(margin)
        .halign(gtk::Align::Center)
        .valign(gtk::Align::Center)
        .row_spacing(margin)
        .column_spacing(margin)
        .build();

    window.set_child(Some(&grid));

    let entry = Entry::builder()
        .margin_start(margin)
        .margin_top(margin)
        .margin_end(margin)
        .margin_bottom(margin)
        .build();
    grid.attach(&entry, 0, 0, 4 ,1);

// --> KEYBOARD STARTS HERE <--

    let button_1 = gtk::Button::with_label("");
    let pixbuf1 = Pixbuf::from_file("img/1.png").unwrap();
    let image1 = Image::from_pixbuf(Some(&pixbuf1));
    button_1.set_image(Some(&image1));

    let button_2 = gtk::Button::with_label("");
    let pixbuf2 = Pixbuf::from_file("img/2.png").unwrap();
    let image2 = Image::from_pixbuf(Some(&pixbuf2));
    button_2.set_image(Some(&image2));


    let button_3 = gtk::Button::with_label("");
    let pixbuf3 = Pixbuf::from_file("img/3.png").unwrap();
    let image3 = Image::from_pixbuf(Some(&pixbuf3));
    button_3.set_image(Some(&image3));


    button_1.connect_clicked(move |_| println!("Button 1"));
    button_2.connect_clicked(move |_| println!("Button 2"));
    button_3.connect_clicked(move |_| println!("Button 3"));

    grid.attach(&button_1, 0, 1, 1, 1);
    grid.attach(&button_2, 1, 1, 1, 1);
    grid.attach(&button_3, 2, 1, 1, 1);

    // --> ROW 2
    let button_4 = gtk::Button::with_label("");
    let pixbuf4 = Pixbuf::from_file("img/4.png").unwrap();
    let image4 = Image::from_pixbuf(Some(&pixbuf4));
    button_4.set_image(Some(&image4));


    let button_5 = gtk::Button::with_label("");
    let pixbuf5 = Pixbuf::from_file("img/5.png").unwrap();
    let image5 = Image::from_pixbuf(Some(&pixbuf5));
    button_5.set_image(Some(&image5));

    let button_6 = gtk::Button::with_label("");
    let pixbuf6 = Pixbuf::from_file("img/6.png").unwrap();
    let image6 = Image::from_pixbuf(Some(&pixbuf6));
    button_6.set_image(Some(&image6));

    button_4.connect_clicked(move |_| println!("Button 4"));
    button_5.connect_clicked(move |_| println!("Button 5"));
    button_6.connect_clicked(move |_| println!("Button 6"));
    grid.attach(&button_4, 0, 2, 1, 1);
    grid.attach(&button_5, 1, 2, 1, 1);
    grid.attach(&button_6, 2, 2, 1, 1);

    // --> ROW 3
    let button_7 = gtk::Button::with_label("");
    let pixbuf7 = Pixbuf::from_file("img/7.png").unwrap();
    let image7 = Image::from_pixbuf(Some(&pixbuf7));
    button_7.set_image(Some(&image7));


    let button_8 = gtk::Button::with_label("");
    let pixbuf8 = Pixbuf::from_file("img/8.png").unwrap();
    let image8 = Image::from_pixbuf(Some(&pixbuf8));
    button_8.set_image(Some(&image8));

    let button_9 = gtk::Button::with_label("");
    let pixbuf9 = Pixbuf::from_file("img/9.png").unwrap();
    let image9 = Image::from_pixbuf(Some(&pixbuf9));
    button_9.set_image(Some(&image9));

    button_7.connect_clicked(move |_| println!("Button 7"));
    button_8.connect_clicked(move |_| println!("Button 8"));
    button_9.connect_clicked(move |_| println!("Button 9"));
    grid.attach(&button_7, 0, 3, 1, 1);
    grid.attach(&button_8, 1, 3, 1, 1);
    grid.attach(&button_9, 2, 3, 1, 1);

// --> ROW 5 - LABEL
let counter_label = Label::new(Some("0.0"));
grid.attach(&counter_label, 0, 5, 4, 1);

    // --> ROW 4
    let plus_button = gtk::Button::with_label("+");
    let button_0 = gtk::Button::with_label("");
    let pixbuf0 = Pixbuf::from_file("img/0.png").unwrap();
    let image0 = Image::from_pixbuf(Some(&pixbuf0));
    button_0.set_image(Some(&image0));

    let minus_button = gtk::Button::with_label("-");
    plus_button.connect_clicked(glib::clone!(@weak counter_label => move |_| {
        let nb = counter_label.text()
            .parse()
            .unwrap_or(0.0);
        counter_label.set_text(&format!("{}", nb + 1.1));
    }));
    button_0.connect_clicked(move |_| println!("Button 0"));
    minus_button.connect_clicked(glib::clone!(@weak counter_label => move |_| {
        let nb = counter_label.text()
            .parse()
            .unwrap_or(0.0);
        counter_label.set_text(&format!("{}", nb - 1.2));
    }));
    grid.attach(&plus_button, 0, 4, 1, 1);
    grid.attach(&button_0, 1, 4, 1, 1);
    grid.attach(&minus_button, 2, 4, 1, 1);




    // --> ROW 2 COLUMN 4 Quit button
    let quit_button = gtk::Button::with_label("Quit");
    quit_button.connect_clicked(clone!(@weak window => move |_|
        unsafe {
            window.destroy()
        }
    ));
    grid.attach(&quit_button, 3, 1, 1, 4);

    let time = format!("{}", Local::now().format("%Y-%m-%d %H:%M:%S"));
    let label_time = gtk::Label::new(None);
    label_time.set_text(&time);
     grid.attach(&label_time, 0, 6, 4, 1);

    let tick = move || {
        let time = format!("{}", Local::now().format("%Y-%m-%d %H:%M:%S"));
        label_time.set_text(&time);
        glib::Continue(true)
    };
    glib::timeout_add_seconds_local(1, tick);


    // --> KEYBOARD ENDS HERE <--

    window.show_all();
}


