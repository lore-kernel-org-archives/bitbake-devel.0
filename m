Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mUj-0007fx-9l
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:00:09 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Mar 2012 16:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120838252"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:51:15 -0700
Message-ID: <4F67C673.7000502@linux.intel.com>
Date: Mon, 19 Mar 2012 16:51:15 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<32ef0101438198032c77c14ed701339417e3749f.1331910234.git.shane.wang@intel.com>
In-Reply-To: <32ef0101438198032c77c14ed701339417e3749f.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 05/12] Hob: fix '!= None' and '== None' in the code
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
X-List-Received-Date: Tue, 20 Mar 2012 00:00:10 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> This patch is to fix the following:
>
> if foo != None ----->  if foo
> if foo == None ----->  if not foo
>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

Thanks!

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    4 ++--
>   bitbake/lib/bb/ui/crumbs/hoblistmodel.py     |    2 +-
>   bitbake/lib/bb/ui/crumbs/hobpages.py         |    4 ++--
>   bitbake/lib/bb/ui/crumbs/hobwidget.py        |    6 +++---
>   bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   12 ++++++------
>   bitbake/lib/bb/ui/crumbs/runningbuild.py     |    4 ++--
>   6 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index 790e2ef..1e1151e 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -119,7 +119,7 @@ class HobHandler(gobject.GObject):
>               self.generating = False
>
>       def run_next_command(self, initcmd=None):
> -        if initcmd != None:
> +        if initcmd:
>               self.initcmd = initcmd
>
>           if self.commands_async:
> @@ -127,7 +127,7 @@ class HobHandler(gobject.GObject):
>               next_command = self.commands_async.pop(0)
>           else:
>               self.clear_busy()
> -            if self.initcmd != None:
> +            if self.initcmd:
>                   self.emit("command-succeeded", self.initcmd)
>               return
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> index caf31bc..69e13cf 100644
> --- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -713,7 +713,7 @@ class RecipeListModel(gtk.ListStore):
>           return None
>
>       def set_selected_image(self, img):
> -        if img == None:
> +        if not img:
>               return
>           path = self.find_path_for_item(img)
>           self.include_item(item_path=path,
> diff --git a/bitbake/lib/bb/ui/crumbs/hobpages.py b/bitbake/lib/bb/ui/crumbs/hobpages.py
> index bd4b292..63ee3dd 100755
> --- a/bitbake/lib/bb/ui/crumbs/hobpages.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobpages.py
> @@ -34,7 +34,7 @@ class HobPage (gtk.VBox):
>           self.builder = builder
>           self.builder_width, self.builder_height = self.builder.size_request()
>
> -        if title == None:
> +        if not title:
>               self.title = "HOB -- Image Creator"
>           else:
>               self.title = title
> @@ -62,7 +62,7 @@ class HobPage (gtk.VBox):
>           label.set_markup("<span font_desc=\'14\'>%s</span>" % self.title)
>           hbox.pack_start(label, expand=False, fill=False, padding=20)
>
> -        if widget != None:
> +        if widget:
>               # add the widget in the event box
>               hbox.pack_end(widget, expand=False, fill=False, padding=padding)
>           eventbox.add(hbox)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 247bbd1..f0d9cbc 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -366,7 +366,7 @@ class HobTabBar(gtk.DrawingArea):
>               child["x"] = self.tab_x + i * self.tab_width
>               child["y"] = self.tab_y
>
> -        if self.blank_rectangle != None:
> +        if self.blank_rectangle:
>               self.resize_blank_rectangle()
>
>       def resize_blank_rectangle(self):
> @@ -553,7 +553,7 @@ class HobTabBar(gtk.DrawingArea):
>           self.queue_draw()
>
>       def set_blank_size(self, x, y, w, h):
> -        if self.blank_rectangle == None or self.blank_rectangle.x != x or self.blank_rectangle.width != w:
> +        if not self.blank_rectangle or self.blank_rectangle.x != x or self.blank_rectangle.width != w:
>               self.emit("blank-area-changed", x, y, w, h)
>
>           return gtk.gdk.Rectangle(x, y, w, h)
> @@ -640,7 +640,7 @@ class HobNotebook(gtk.VBox):
>           if not notebook:
>               return
>           title = notebook.get_tab_label_text(notebook_child)
> -        if title == None:
> +        if not title:
>               return
>           for child in self.tabbar.children:
>               if child["title"] == title:
> diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> index c063d74..30c25aa 100755
> --- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> @@ -64,9 +64,9 @@ class ImageDetailsPage (HobPage):
>               self.hbox.set_border_width(15)
>               self.add(self.hbox)
>
> -            if widget != None:
> +            if widget:
>                   row = 1
> -            elif varlist != None and vallist != None:
> +            elif varlist and vallist:
>                   # pack the icon and the text on the left
>                   row = len(varlist)
>               self.table = gtk.Table(row, 20, True)
> @@ -75,18 +75,18 @@ class ImageDetailsPage (HobPage):
>
>               colid = 0
>               self.line_widgets = {}
> -            if icon != None:
> +            if icon:
>                   self.table.attach(icon, colid, colid + 2, 0, 1)
>                   colid = colid + 2
> -            if widget != None:
> +            if widget:
>                   self.table.attach(widget, colid, 20, 0, 1)
> -            elif varlist != None and vallist != None:
> +            elif varlist and vallist:
>                   for line in range(0, row):
>                       self.line_widgets[varlist[line]] = self.text2label(varlist[line], vallist[line])
>                       self.table.attach(self.line_widgets[varlist[line]], colid, 20, line, line + 1)
>
>               # pack the button on the right
> -            if button != None:
> +            if button:
>                   self.hbox.pack_end(button, expand=False, fill=False)
>
>           def update_line_widgets(self, variable, value):
> diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> index ddac232..d8af55c 100644
> --- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
> +++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
> @@ -43,7 +43,7 @@ class RunningBuildModel (gtk.TreeStore):
>
>       def config_model_filter(self, model, it):
>           msg = model.get(it, self.COL_MESSAGE)[0]
> -        if msg == None or type(msg) != str:
> +        if not msg or type(msg) != str:
>               return False
>           if msg.startswith("\nOE Build Configuration:\n"):
>               return True
> @@ -51,7 +51,7 @@ class RunningBuildModel (gtk.TreeStore):
>
>       def failure_model_filter(self, model, it):
>           color = model.get(it, self.COL_COLOR)[0]
> -        if color == None:
> +        if not color:
>               return False
>           if color == HobColors.ERROR:
>               return True

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


