using Gtk;

namespace Clipper {
  class ClipperApp : Gtk.Window {

    private Gtk.TextView text_view;

    public ClipperApp() {
      set_default_size(400, 260);
      var scrolled   = new Gtk.ScrolledWindow(null, null);
      var mono_font = Pango.FontDescription.from_string("monospace");
      this.text_view = new TextView();

      this.text_view.set_wrap_mode(Gtk.WrapMode.WORD);
      this.text_view.override_font(mono_font);
      set_text_from_clipboard();

      scrolled.add(text_view);
      add(scrolled);
    }

    public void set_text_from_clipboard() {
      Gdk.Display display = get_display();
      Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display(display, Gdk.SELECTION_PRIMARY);
      string text = clipboard.wait_for_text();
      this.text_view.buffer.text = text ?? "";
    }

    public static int main (string[] args) {
      Gtk.init(ref args);

      var app = new ClipperApp();
      app.show_all();

      app.destroy.connect(Gtk.main_quit);

      Gtk.main();
      return 0;
    }
  }
}
