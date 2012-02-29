Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rCD-0003BJ-Uv
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:36:27 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Feb 2012 13:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979046"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:27:55 -0800
Message-ID: <4F4E985B.1070606@linux.intel.com>
Date: Wed, 29 Feb 2012 13:27:55 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<0079cc38920b78e36e2371fb34bcffd12883da5f.1330523904.git.shane.wang@intel.com>
In-Reply-To: <0079cc38920b78e36e2371fb34bcffd12883da5f.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 06/32] Hob: implement a self-defined notebook visual component for Hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 Feb 2012 21:36:27 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> In recipe selection page, package selection page, and build details page, etc, there is a notebook component which is not gtk.Notebook in the design video.
> We implement the visual component with a drawing area, and use it to replace the old notebook in recipe selection page and package selection page.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

Code style comments below.

More importantly, have we made sure we can't use the stock notebook 
before we've implemented our own? The commit log tells me that we aren't 
using gtk.Notebook but doesn't tell me why?

The implemented notebook is a reasonable start but it needs a lot of 
polish before I'd want to see it shipped.
i.e. the green flashed border around the selected tabs is strange, the 
drawing looks a little jaggy, especially the orange circle (not a 
graphics guy so I don't know the right term) and I'm pretty certain the 
number in the circle isn't centred. Finally (for now) once I get to 
three digits the numbers don't fit in the circle.

I think the rationale would be useful as a comment in the class file too.

Cheers,
Joshua

> ---
>   bitbake/lib/bb/ui/crumbs/hobcolor.py             |    1 +
>   bitbake/lib/bb/ui/crumbs/hobwidget.py            |  467 ++++++++++++++++++----
>   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   19 +-
>   bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   19 +-
>   4 files changed, 394 insertions(+), 112 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumbs/hobcolor.py
> index 9d67d5c..402f022 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
> @@ -28,6 +28,7 @@ class HobColors:
>       DARK         = "#3c3b37"
>       BLACK        = "#000000"
>       LIGHT_ORANGE = "#f7a787"
> +    YELLOW       = "#ffff00"
>
>       OK = WHITE
>       RUNNING = PALE_GREEN
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 9afbfdb..a2d99a2 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -17,11 +17,14 @@
>   # You should have received a copy of the GNU General Public License along
>   # with this program; if not, write to the Free Software Foundation, Inc.,
>   # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -
>   import gtk
>   import gobject
>   import os
>   import os.path
> +import sys
> +import pango, pangocairo
> +import math
> +
>   from bb.ui.crumbs.hobcolor import HobColors
>
>   class hwc:
> @@ -167,90 +170,6 @@ class HobViewTable (gtk.VBox):
>           if not view_column.get_title() in self.toggle_columns:
>               self.emit("row-activated", tree.get_model(), path)
>
> -class HobViewBar (gtk.EventBox):
> -    """
> -    A EventBox with the specified gray background color is associated with a notebook.
> -    And the toolbar to simulate the tabs.
> -    """
> -
> -    def __init__(self, notebook):
> -        if not notebook:
> -            return
> -        self.notebook = notebook
> -
> -        # setup an event box
> -        gtk.EventBox.__init__(self)
> -        self.set_border_width(2)
> -        style = self.get_style().copy()
> -        style.bg[gtk.STATE_NORMAL] = self.get_colormap().alloc_color (HobColors.GRAY, False, False)
> -        self.set_style(style)
> -
> -        hbox = gtk.HBox()
> -        self.add(hbox)
> -
> -        # setup a tool bar in the event box
> -        self.toolbar = gtk.Toolbar()
> -        self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
> -        self.toolbar.set_style(gtk.TOOLBAR_TEXT)
> -        self.toolbar.set_border_width(5)
> -
> -        self.toolbuttons = []
> -        for index in range(self.notebook.get_n_pages()):
> -            child = self.notebook.get_nth_page(index)
> -            label = self.notebook.get_tab_label_text(child)
> -            tip_text = 'switch to ' + label + ' page'
> -            toolbutton = self.toolbar.append_element(gtk.TOOLBAR_CHILD_RADIOBUTTON, None,
> -                                label, tip_text, "Private text", None,
> -                                self.toolbutton_cb, index)
> -            toolbutton.set_size_request(200, 100)
> -            self.toolbuttons.append(toolbutton)
> -
> -        # set the default current page
> -        self.modify_toolbuttons_bg(0)
> -        self.notebook.set_current_page(0)
> -
> -        self.toolbar.append_space()
> -
> -        # add the tool bar into the event box
> -        hbox.pack_start(self.toolbar, expand=False, fill=False)
> -
> -        self.search = gtk.Entry()
> -        self.align = gtk.Alignment(xalign=0.5, yalign=0.5)
> -        self.align.add(self.search)
> -        hbox.pack_end(self.align, expand=False, fill=False)
> -
> -        self.label = gtk.Label(" Search: ")
> -        self.label.set_alignment(0.5, 0.5)
> -        hbox.pack_end(self.label, expand=False, fill=False)
> -
> -    def toolbutton_cb(self, widget, index):
> -        if index>= self.notebook.get_n_pages():
> -            return
> -        self.notebook.set_current_page(index)
> -        self.modify_toolbuttons_bg(index)
> -
> -    def modify_toolbuttons_bg(self, index):
> -        if index>= len(self.toolbuttons):
> -            return
> -        for i in range(0, len(self.toolbuttons)):
> -            toolbutton = self.toolbuttons[i]
> -            if i == index:
> -                self.modify_toolbutton_bg(toolbutton, True)
> -            else:
> -                self.modify_toolbutton_bg(toolbutton)
> -
> -    def modify_toolbutton_bg(self, toolbutton, active=False):
> -        if active:
> -            toolbutton.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.WHITE))
> -            toolbutton.modify_bg(gtk.STATE_ACTIVE, gtk.gdk.Color(HobColors.WHITE))
> -            toolbutton.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.WHITE))
> -            toolbutton.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.WHITE))
> -        else:
> -            toolbutton.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.GRAY))
> -            toolbutton.modify_bg(gtk.STATE_ACTIVE, gtk.gdk.Color(HobColors.GRAY))
> -            toolbutton.modify_bg(gtk.STATE_SELECTED, gtk.gdk.Color(HobColors.GRAY))
> -            toolbutton.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(HobColors.GRAY))
> -
>   class HobXpmLabelButtonBox(gtk.EventBox):
>       """ label: name of buttonbox
>           description: the simple  description
> @@ -311,3 +230,381 @@ class HobXpmLabelButtonBox(gtk.EventBox):
>           """ Hide items - first time """
>           pass
>
> +class HobTabBar(gtk.DrawingArea):
> +    __gsignals__ = {
> +        "blank-area-changed" : (gobject.SIGNAL_RUN_LAST,
> +                                gobject.TYPE_NONE,
> +                               (gobject.TYPE_INT,
> +                                gobject.TYPE_INT,
> +                                gobject.TYPE_INT,
> +                                gobject.TYPE_INT,)),
> +
> +        "tab-switched" : (gobject.SIGNAL_RUN_LAST,
> +                          gobject.TYPE_NONE,
> +                         (gobject.TYPE_INT,)),
> +    }
> +
> +    def __init__(self):
> +        gtk.DrawingArea.__init__(self)
> +        self.children = []
> +
> +        self.tab_width = 140
> +        self.tab_height = 52
> +        self.tab_x = 10
> +        self.tab_y = 0
> +
> +        self.width = 500
> +        self.height = 53
> +        self.tab_w_ratio = 140 * 1.0/500
> +        self.tab_h_ratio = 52 * 1.0/53
> +        self.set_size_request(self.width, self.height)
> +
> +        self.current_child = 0
> +        self.font = self.get_style().font_desc
> +        self.font.set_size(pango.SCALE * 13)
> +        self.update_children_text_layout_and_bg_color()
> +
> +        self.blank_rectangle = None
> +        self.tab_pressed = False
> +
> +        self.set_property('can-focus', True)
> +        self.set_events(gtk.gdk.EXPOSURE_MASK | gtk.gdk.POINTER_MOTION_MASK |
> +                        gtk.gdk.BUTTON1_MOTION_MASK | gtk.gdk.BUTTON_PRESS_MASK |
> +                        gtk.gdk.BUTTON_RELEASE_MASK)
> +
> +        self.connect("expose-event", self.on_draw)
> +        self.connect("button-press-event", self.button_pressed_cb)
> +        self.connect("button-release-event", self.button_released_cb)
> +        self.show_all()
> +
> +    def button_released_cb(self, widget, event):
> +        self.tab_pressed = False
> +        self.queue_draw()
> +
> +    def button_pressed_cb(self, widget, event):
> +        if event.type == gtk.gdk._2BUTTON_PRESS:
> +            return
> +
> +        result = False
> +        if self.is_focus() or event.type == gtk.gdk.BUTTON_PRESS:
> +            x, y = event.get_coords()
> +            # check which tab be clicked
Why don't we just iterate the list here?
	for child in self.children:
			if child["x"] < x and etc.
> +            for i in range(len(self.children)):
> +               if      (self.children[i]["x"]<  x) and (x<  self.children[i]["x"] + self.tab_width) \
> +                   and (self.children[i]["y"]<  y) and (y<  self.children[i]["y"] + self.tab_height):
> +                   self.current_child = i
> +                   result = True
> +                   break
> +
> +            # check the blank area is focus in or not
> +            if (self.blank_rectangle) and (self.blank_rectangle.x>  0) and (self.blank_rectangle.y>  0):
> +                if      (self.blank_rectangle.x<  x) and (x<  self.blank_rectangle.x + self.blank_rectangle.width) \
> +                    and (self.blank_rectangle.y<  y) and (y<  self.blank_rectangle.y + self.blank_rectangle.height):
> +                   self.grab_focus()
> +
> +        if result == True:
> +            page = self.children[self.current_child]["toggled_page"]
> +            self.emit("tab-switched", page)
> +            self.tab_pressed = True
> +            self.queue_draw()
> +
> +    def update_children_size(self):
> +        # calculate the size of tabs
> +        self.tab_width = int(self.width * self.tab_w_ratio)
> +        self.tab_height = int(self.height * self.tab_h_ratio)
> +        for i in range(len(self.children)):

Again, can't we just iterate the list here?
	for child in self.children:
> +            self.children[i]["x"] = self.tab_x + i * self.tab_width
> +            self.children[i]["y"] = self.tab_y
> +
> +        if self.blank_rectangle != None:
> +            self.resize_blank_rectangle()
> +
> +    def resize_blank_rectangle(self):
> +        width = self.width - self.tab_width * len(self.children) - self.tab_x
> +        x = self.tab_x + self.tab_width * len(self.children)
> +        hpadding = vpadding = 5
> +        self.blank_rectangle = self.set_blank_size(x + hpadding, self.tab_y + vpadding,
> +            width - 2 * hpadding, self.tab_height - 2 * vpadding)
> +
> +    def update_children_text_layout_and_bg_color(self):
> +        style = self.get_style().copy()
> +        color = style.base[gtk.STATE_NORMAL]
> +        for i in range(len(self.children)):
Again,
	for child in self.children:

> +            pangolayout = self.create_pango_layout(self.children[i]["title"])
> +            pangolayout.set_font_description(self.font)
> +            self.children[i]["title_layout"] = pangolayout
> +            self.children[i]["r"] = color.red
> +            self.children[i]["g"] = color.green
> +            self.children[i]["b"] = color.blue
> +
> +    def append_tab_child(self, title, page):
> +        num = len(self.children) + 1
> +        self.tab_width = self.tab_width * len(self.children) / num
> +
> +        i = 0
> +        for child in self.children:

Just like this!

> +            child["x"] = self.tab_x + i * self.tab_width
> +            i += 1
> +
> +        x = self.tab_x + i * self.tab_width
> +        y = self.tab_y
> +        pangolayout = self.create_pango_layout(title)
> +        pangolayout.set_font_description(self.font)
> +        color = self.style.base[gtk.STATE_NORMAL]
> +        new_one = {
> +            "x" : x,
> +            "y" : y,
> +            "r" : color.red,
> +            "g" : color.green,
> +            "b" : color.blue,
> +            "title_layout" : pangolayout,
> +            "toggled_page" : page,
> +            "title"        : title,
> +            "indicator_show"   : False,
> +            "indicator_number" : 0,
> +        }
> +        self.children.append(new_one)
> +
> +    def on_draw(self, widget, event):
> +        cr = widget.window.cairo_create()
> +
> +        self.width = self.allocation.width
> +        self.height = self.allocation.height
> +
> +        self.update_children_size()
> +
> +        self.draw_background(cr)
> +        self.draw_toggled_tab(cr)
> +        self.draw_tab_text(cr)
> +
> +        for i in range(len(self.children)):

See above:
	for child in self.children:

> +            if self.children[i]["indicator_show"] == True:
> +                self.draw_indicator(cr, i)
> +
> +    def draw_background(self, cr):
> +        style = self.get_style()
> +
> +        if self.is_focus():
> +            cr.set_source_color(style.base[gtk.STATE_SELECTED])
> +        else:
> +            cr.set_source_color(style.base[gtk.STATE_NORMAL])
> +
> +        y = 6
> +        h = self.height - 6 - 1
> +        gap = 1
> +
> +        w = self.children[0]["x"]
> +        cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
> +        cr.rectangle(0, y, w - gap, h) # start rectangle
> +        cr.fill()
> +
> +        cr.set_source_color(style.base[gtk.STATE_NORMAL])
> +        cr.rectangle(w - gap, y, w, h) #first gap
> +        cr.fill()
> +
> +        w = self.tab_width
> +        for i in range(len(self.children)):

	for child in self.children:

> +            x = self.children[i]["x"]
> +            cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
> +            cr.rectangle(x, y, w - gap, h) # tab rectangle
> +            cr.fill()
> +            cr.set_source_color(style.base[gtk.STATE_NORMAL])
> +            cr.rectangle(x + w - gap, y, w, h) # gap
> +            cr.fill()
> +
> +        cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
> +        cr.rectangle(x + w, y, self.width - x - w, h) # last rectangle
> +        cr.fill()
> +
> +    def draw_tab_text(self, cr):
> +        style = self.get_style()
> +
> +        for i in range(len(self.children)):

	for child in self.children:

> +            pangolayout = self.children[i]["title_layout"]
> +            if pangolayout:
> +                fontw, fonth = pangolayout.get_pixel_size()
> +                # center pos
> +                off_x = (self.tab_width - fontw) / 2
> +                off_y = (self.tab_height - fonth) / 2
> +                x = self.children[i]["x"] + off_x
> +                y = self.children[i]["y"] + off_y
> +                self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout)
> +
> +    def draw_toggled_tab(self, cr):
> +        i = self.current_child
> +        x = self.children[i]["x"]
> +        y = self.children[i]["y"]
> +        width = self.tab_width
> +        height = self.tab_height
> +        style = self.get_style()
> +        color = style.base[gtk.STATE_NORMAL]
> +
> +        r = height / 10
> +        if self.tab_pressed == True:
> +            for xoff, yoff in [(1, 0), (2, 0)]:
> +                cr.set_source_color(gtk.gdk.color_parse(HobColors.PALE_GREEN))
> +                cr.move_to(x + r + xoff, y + yoff)
> +                cr.line_to(x + width - r + xoff, y + yoff)
> +                cr.arc(x + width - r+ xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
> +                cr.move_to(x + width + xoff, r + yoff)
> +                cr.line_to(x + width + xoff, y + height + yoff)
> +                cr.line_to(x + xoff, y + height + yoff)
> +                cr.line_to(x + xoff, r + yoff)
> +                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
> +                cr.stroke()
> +            x = x + 2
> +            y = y + 2
> +        cr.set_source_rgba(color.red, color.green, color.blue, 1)
> +        cr.move_to(x + r, y)
> +        cr.line_to(x + width - r , y)
> +        cr.arc(x + width - r, y + r, r, 1.5*math.pi, 2*math.pi)
> +        cr.move_to(x + width, r)
> +        cr.line_to(x + width, y + height)
> +        cr.line_to(x, y + height)
> +        cr.line_to(x, r)
> +        cr.arc(x + r, y + r, r, math.pi, 1.5*math.pi)
> +        cr.fill()
> +
> +    def draw_indicator(self, cr, i):
> +        style = self.get_style()
> +        tab_x = self.children[i]["x"]
> +        tab_y = self.children[i]["y"]
> +        number = self.children[i]["indicator_number"]
> +        dest_w = int(32 * self.tab_w_ratio)
> +        dest_h = int(32 * self.tab_h_ratio)
> +        if dest_h<  self.tab_height:
> +            dest_w = dest_h
> +
> +        # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
> +        x = tab_x + self.tab_width * 3/4 - dest_w/2
> +        y = tab_y + self.tab_height/2 - dest_h/2
> +        cr.move_to(tab_x, tab_y)
> +        r = min(dest_w, dest_h)/2
> +        color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
> +        cr.arc(x + r, y + r, r, 0, 2*math.pi)
> +        cr.fill()
> +
> +        text = ("%d" % number)
> +        layout = self.create_pango_layout(text)
> +        layout.set_font_description(self.font)
> +        textw, texth = layout.get_pixel_size()
> +        x = x + (dest_w/2)-(textw/2)
> +        y = y + (dest_h/2) - (texth/2)
> +        cr.move_to(x, y)
> +        self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
> +
> +    def show_indicator_icon(self, i, number):
> +        self.children[i]["indicator_show"] = True
> +        self.children[i]["indicator_number"] = number
> +        self.queue_draw()
> +
> +    def hide_indicator_icon(self, i):
> +        self.children[i]["indicator_show"] = False
> +        self.queue_draw()
> +
> +    def set_blank_size(self, x, y, w, h):
> +        if self.blank_rectangle == None or self.blank_rectangle.x != x or self.blank_rectangle.width != w:
> +            self.emit("blank-area-changed", x, y, w, h)
> +
> +        return gtk.gdk.Rectangle(x, y, w, h)
> +
> +class HobNotebook(gtk.VBox):
> +
> +    def __init__(self):
> +        gtk.VBox.__init__(self, False, 0)
> +
> +        self.notebook = gtk.Notebook()
> +        self.notebook.set_property('homogeneous', True)
> +        self.notebook.set_property('show-tabs', False)
> +
> +        self.tabbar = HobTabBar()
> +        self.tabbar.connect("tab-switched",   self.tab_switched_cb)
> +        self.notebook.connect("page-added",   self.page_added_cb)
> +        self.notebook.connect("page-removed", self.page_removed_cb)
> +
> +        self.search = None
> +        self.search_name = ""
> +
> +        self.tb = gtk.Table(1, 100, False)
> +        self.hbox= gtk.HBox(False, 0)
> +        self.hbox.pack_start(self.tabbar, True, True)
> +        self.tb.attach(self.hbox, 0, 100, 0, 1)
> +
> +        self.pack_start(self.tb, False, False)
> +        self.pack_start(self.notebook)
> +
> +        self.show_all()
> +
> +    def append_page(self, child, tab_label):
> +        self.notebook.set_current_page(self.notebook.append_page(child, tab_label))
> +
> +    def set_entry(self, name="Search:"):
> +        for child in self.tb.get_children():
> +            if child:
> +                self.tb.remove(child)
> +
> +        hbox_entry = gtk.HBox(False, 0)
> +        hbox_entry.show()
> +
> +        self.search = gtk.Entry()
> +        self.search_name = name
> +        style = self.search.get_style()
> +        style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
> +        self.search.set_style(style)
> +        self.search.set_text(name)
> +        self.search.set_editable(False)
> +        self.search.show()
> +        self.align = gtk.Alignment(xalign=1.0, yalign=0.7)
> +        self.align.add(self.search)
> +        self.align.show()
> +        hbox_entry.pack_end(self.align, False, False)
> +        self.tabbar.resize_blank_rectangle()
> +
> +        self.tb.attach(hbox_entry, 75, 100, 0, 1, xpadding=5)
> +        self.tb.attach(self.hbox, 0, 100, 0, 1)
> +
> +        self.tabbar.connect("blank-area-changed", self.blank_area_resize_cb)
> +        self.search.connect("focus-in-event", self.set_search_entry_editable_cb)
> +        self.search.connect("focus-out-event", self.set_search_entry_reset_cb)
> +
> +        self.tb.show()
> +
> +    def tab_switched_cb(self, widget, page):
> +        self.notebook.set_current_page(page)
> +
> +    def page_added_cb(self, notebook, notebook_child, page):
> +        if not notebook:
> +            return
> +        title = notebook.get_tab_label_text(notebook_child)
> +        if title == None:
> +            return
> +        for i in range(len(self.tabbar.children)):
> +            if self.tabbar.children[i]["title"] == title:
> +                self.tabbar.children[i]["toggled_page"] = page
> +                return
> +        self.tabbar.append_tab_child(title, page)
> +
> +    def page_removed_cb(self, notebook, notebook_child, page, title=""):
> +        for i in range(len(self.tabbar.children)):
> +            if self.tabbar.children[i] == title:
> +                self.tabbar.children[i]["toggled_page"] = -1
> +
> +    def blank_area_resize_cb(self, widget, request_x, request_y, request_width, request_height):
> +        self.search.set_size_request(request_width, request_height)
> +        widget.modify_bg(gtk.STATE_SELECTED, gtk.gdk.color_parse(HobColors.YELLOW))
> +
> +    def set_search_entry_editable_cb(self, widget, event):
> +        if self.search:
> +            self.search.set_editable(True)
> +            self.search.set_text("")
> +            style = self.search.get_style()
> +            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
> +            self.search.set_style(style)
> +
> +    def set_search_entry_reset_cb(self, widget, event):
> +        if self.search:
> +            style = self.search.get_style()
> +            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
> +            self.search.set_style(style)
> +            self.search.set_text(self.search_name)
> +            self.search.set_editable(False)
> diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> index a3c4acd..dab90ec 100755
> --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -23,7 +23,7 @@
>   import gtk
>   import glib
>   from bb.ui.crumbs.hobcolor import HobColors
> -from bb.ui.crumbs.hobwidget import HobViewBar, HobViewTable
> +from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook
>   from bb.ui.crumbs.hoblistmodel import PackageListModel
>   from bb.ui.crumbs.hobpages import HobPage
>
> @@ -102,11 +102,7 @@ class PackageSelectionPage (HobPage):
>           self.pack_start(self.group_align, expand=True, fill=True)
>
>           # set visiable members
> -        self.grid = gtk.Table(10, 1, True)
> -        self.grid.set_col_spacings(3)
> -
> -        self.ins = gtk.Notebook()
> -        self.ins.set_show_tabs(False)
> +        self.ins = HobNotebook()
>           self.tables = [] # we need to modify table when the dialog is shown
>           # append the tab
>           for i in range(len(self.pages)):
> @@ -128,19 +124,16 @@ class PackageSelectionPage (HobPage):
>               self.ins.append_page(tab, label)
>               self.tables.append(tab)
>
> -        self.grid.attach(self.ins, 0, 1, 1, 10, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND, 1, 1)
> -        # a black bar associated with the notebook
> -        self.topbar = HobViewBar(self.ins)
> -        self.grid.attach(self.topbar, 0, 1, 0, 1, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND, 1, 1)
> +        self.ins.set_entry("Search packages:")
>           # set the search entry for each table
>           for tab in self.tables:
> -            tab.set_search_entry(0, self.topbar.search)
> +            tab.set_search_entry(0, self.ins.search)
>
>           # add all into the dialog
> -        self.box_group_area.add(self.grid)
> +        self.box_group_area.pack_start(self.ins, expand=True, fill=True)
>
>           button_box = gtk.HBox(False, 5)
> -        self.box_group_area.pack_start(button_box, expand=False, fill=False)
> +        self.box_group_area.pack_end(button_box, expand=False, fill=False)
>
>           self.build_image_button = gtk.Button()
>           label = gtk.Label()
> diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> index ee36f8c..416c613 100755
> --- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -23,7 +23,7 @@
>   import gtk
>   import glib
>   from bb.ui.crumbs.hobcolor import HobColors
> -from bb.ui.crumbs.hobwidget import HobViewBar, HobViewTable
> +from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook
>   from bb.ui.crumbs.hoblistmodel import RecipeListModel
>   from bb.ui.crumbs.hobpages import HobPage
>
> @@ -124,13 +124,7 @@ class RecipeSelectionPage (HobPage):
>           self.pack_start(self.group_align, expand=True, fill=True)
>
>           # set visiable members
> -        self.grid = gtk.Table(10, 1, True)
> -        self.grid.set_col_spacings(3)
> -
> -        # draw the left part of the window
> -        # a notebook
> -        self.ins = gtk.Notebook()
> -        self.ins.set_show_tabs(False)
> +        self.ins = HobNotebook()
>           self.tables = [] # we need modify table when the dialog is shown
>           # append the tabs in order
>           for i in range(len(self.pages)):
> @@ -151,16 +145,13 @@ class RecipeSelectionPage (HobPage):
>               self.ins.append_page(tab, label)
>               self.tables.append(tab)
>
> -        self.grid.attach(self.ins, 0, 1, 1, 10, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND)
> -        # a black bar associated with the notebook
> -        self.topbar = HobViewBar(self.ins)
> -        self.grid.attach(self.topbar, 0, 1, 0, 1, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND)
> +        self.ins.set_entry("Search recipes:")
>           # set the search entry for each table
>           for tab in self.tables:
> -            tab.set_search_entry(0, self.topbar.search)
> +            tab.set_search_entry(0, self.ins.search)
>
>           # add all into the window
> -        self.box_group_area.add(self.grid)
> +        self.box_group_area.pack_start(self.ins, expand=True, fill=True)
>
>           button_box = gtk.HBox(False, 5)
>           self.box_group_area.pack_end(button_box, expand=False, fill=False)

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


