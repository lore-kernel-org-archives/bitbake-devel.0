Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mb3-0007oc-UU
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:06:42 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Mar 2012 16:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119308862"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by orsmga001.jf.intel.com with ESMTP; 19 Mar 2012 16:57:49 -0700
Message-ID: <4F67C7FC.7070806@linux.intel.com>
Date: Mon, 19 Mar 2012 16:57:48 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<c8c378f53c7322440b3fb96c5c676bf66b668193.1331910234.git.shane.wang@intel.com>
In-Reply-To: <c8c378f53c7322440b3fb96c5c676bf66b668193.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 08/12] Hob: change the range dance in hobwidget make it like a pythonista
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
X-List-Received-Date: Tue, 20 Mar 2012 00:06:42 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To fix the for..in.. range dance code, and make it like pythonista, as the required.

This commit message doesn't match the patch contents.

>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |   67 +++++++++++++++++---------------
>   1 files changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 71f0629..2afa975 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -309,7 +309,7 @@ class HobTabBar(gtk.DrawingArea):
>           self.tab_h_ratio = 52 * 1.0/53
>           self.set_size_request(self.width, self.height)
>
> -        self.current_child = 0
> +        self.current_child = None
>           self.font = self.get_style().font_desc
>           self.font.set_size(pango.SCALE * 13)
>           self.update_children_text_layout_and_bg_color()
> @@ -339,10 +339,10 @@ class HobTabBar(gtk.DrawingArea):
>           if self.is_focus() or event.type == gtk.gdk.BUTTON_PRESS:
>               x, y = event.get_coords()
>               # check which tab be clicked
> -            for i, child in enumerate(self.children):
> +            for child in self.children:
>                  if      (child["x"]<  x) and (x<  child["x"] + self.tab_width) \
>                      and (child["y"]<  y) and (y<  child["y"] + self.tab_height):
> -                   self.current_child = i
> +                   self.current_child = child
>                      result = True
>                      break
>
> @@ -353,7 +353,7 @@ class HobTabBar(gtk.DrawingArea):
>                      self.grab_focus()
>
>           if result == True:
> -            page = self.children[self.current_child]["toggled_page"]
> +            page = self.current_child["toggled_page"]
>               self.emit("tab-switched", page)
>               self.tab_pressed = True
>               self.queue_draw()
> @@ -366,7 +366,7 @@ class HobTabBar(gtk.DrawingArea):
>               child["x"] = self.tab_x + i * self.tab_width
>               child["y"] = self.tab_y
>
> -        if self.blank_rectangle:
> +        if self.blank_rectangle != None:

This seems redundant?

>               self.resize_blank_rectangle()
>
>       def resize_blank_rectangle(self):
> @@ -383,16 +383,16 @@ class HobTabBar(gtk.DrawingArea):
>               pangolayout = self.create_pango_layout(child["title"])
>               pangolayout.set_font_description(self.font)
>               child["title_layout"] = pangolayout
> -            child[i]["r"] = color.red
> -            child[i]["g"] = color.green
> -            child[i]["b"] = color.blue
> +            child["r"] = color.red
> +            child["g"] = color.green
> +            child["b"] = color.blue
>
>       def append_tab_child(self, title, page):
>           num = len(self.children) + 1
>           self.tab_width = self.tab_width * len(self.children) / num
>
>           i = 0
> -        for child in self.children:
> +        for i, child in enumerate(self.children):
>               child["x"] = self.tab_x + i * self.tab_width
>               i += 1
>
> @@ -414,6 +414,9 @@ class HobTabBar(gtk.DrawingArea):
>               "indicator_number" : 0,
>           }
>           self.children.append(new_one)
> +        # set the default current child
> +        if not self.current_child:
> +            self.current_child = new_one
>
>       def on_draw(self, widget, event):
>           cr = widget.window.cairo_create()
> @@ -425,11 +428,12 @@ class HobTabBar(gtk.DrawingArea):
>
>           self.draw_background(cr)
>           self.draw_toggled_tab(cr)
> -        self.draw_tab_text(cr)
>
> -        for i, child in enumerate(self.children):
> +        for child in self.children:
>               if child["indicator_show"] == True:
> -                self.draw_indicator(cr, i)
> +                self.draw_indicator(cr, child)
> +
> +        self.draw_tab_text(cr)
>
>       def draw_background(self, cr):
>           style = self.get_style()
> @@ -476,14 +480,15 @@ class HobTabBar(gtk.DrawingArea):
>                   # center pos
>                   off_x = (self.tab_width - fontw) / 2
>                   off_y = (self.tab_height - fonth) / 2
> -                x = child[i]["x"] + off_x
> -                y = child[i]["y"] + off_y
> +                x = child["x"] + off_x
> +                y = child["y"] + off_y
>                   self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout)
>
>       def draw_toggled_tab(self, cr):
> -        i = self.current_child
> -        x = self.children[i]["x"]
> -        y = self.children[i]["y"]
> +        if not self.current_child:
> +            return
> +        x = self.current_child["x"]
> +        y = self.current_child["y"]
>           width = self.tab_width
>           height = self.tab_height
>           style = self.get_style()
> @@ -515,10 +520,10 @@ class HobTabBar(gtk.DrawingArea):
>           cr.arc(x + r, y + r, r, math.pi, 1.5*math.pi)
>           cr.fill()
>
> -    def draw_indicator(self, cr, i):
> -        tab_x = self.children[i]["x"]
> -        tab_y = self.children[i]["y"]
> -        number = self.children[i]["indicator_number"]
> +    def draw_indicator(self, cr, child):
> +        tab_x = child["x"]
> +        tab_y = child["y"]
> +        number = child["indicator_number"]
>           dest_w = int(32 * self.tab_w_ratio)
>           dest_h = int(32 * self.tab_h_ratio)
>           if dest_h<  self.tab_height:
> @@ -541,17 +546,17 @@ class HobTabBar(gtk.DrawingArea):
>           cr.move_to(x, y)
>           self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
>
> -    def show_indicator_icon(self, i, number):
> -        self.children[i]["indicator_show"] = True
> -        self.children[i]["indicator_number"] = number
> +    def show_indicator_icon(self, child, number):
> +        child["indicator_show"] = True
> +        child["indicator_number"] = number
>           self.queue_draw()
>
> -    def hide_indicator_icon(self, i):
> -        self.children[i]["indicator_show"] = False
> +    def hide_indicator_icon(self, child):
> +        child["indicator_show"] = False
>           self.queue_draw()
>
>       def set_blank_size(self, x, y, w, h):
> -        if not self.blank_rectangle or self.blank_rectangle.x != x or self.blank_rectangle.width != w:
> +        if self.blank_rectangle == None or self.blank_rectangle.x != x or self.blank_rectangle.width != w:

This change seems redundant.

>               self.emit("blank-area-changed", x, y, w, h)
>
>           return gtk.gdk.Rectangle(x, y, w, h)
> @@ -618,18 +623,18 @@ class HobNotebook(gtk.VBox):
>           self.tb.show()
>
>       def show_indicator_icon(self, title, number):
> -        for i, child in enumerate(self.tabbar.children):
> +        for child in self.tabbar.children:
>               if child["toggled_page"] == -1:
>                   continue
>               if child["title"] == title:
> -                self.tabbar.show_indicator_icon(i, number)
> +                self.tabbar.show_indicator_icon(child, number)
>
>       def hide_indicator_icon(self, title):
> -        for i, child in enumerate(self.tabbar.children):
> +        for child in self.tabbar.children:
>               if child["toggled_page"] == -1:
>                   continue
>               if child["title"] == title:
> -                self.tabbar.hide_indicator_icon(i)
> +                self.tabbar.hide_indicator_icon(child)
>
>       def tab_switched_cb(self, widget, page):
>           self.notebook.set_current_page(page)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


