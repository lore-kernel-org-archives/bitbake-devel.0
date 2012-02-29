Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rCy-0003FB-Rz
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:13 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Feb 2012 13:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979410"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:28:42 -0800
Message-ID: <4F4E9885.6090705@linux.intel.com>
Date: Wed, 29 Feb 2012 13:28:37 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<660576fe6e84608bbf4d7237f5804cfd244029cd.1330523904.git.shane.wang@intel.com>
In-Reply-To: <660576fe6e84608bbf4d7237f5804cfd244029cd.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 04/32] Hob: fixed the issue in the brought-in-by dialog.
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:13 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> When typing any thing in the search entry, the brough-in-by dialog will be shown. That is because we call back "selection-changed" signal to pop up the dialog, which is not correct.
> This patch is to fix the problem by using "row-activated" signal.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

I point out some incorrect padding below but other than that:
Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hig.py                  |    5 +---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py            |   30 ++++++++++++---------
>   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   12 ++------
>   bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   13 ++-------
>   4 files changed, 24 insertions(+), 36 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> index 2de7b2a..74f4f7b 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -89,15 +89,12 @@ class BinbDialog(gtk.Dialog):
>           self.set_resizable(False)
>           self.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.DARK))
>
> -        hbox = gtk.HBox(False, 0)
> -        self.vbox.pack_start(hbox, expand=False, fill=False, padding=10)
> -
>           label = gtk.Label(content)
>           label.set_alignment(0, 0)
>           label.set_line_wrap(True)
>           label.modify_fg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.WHITE))
>
> -        hbox.pack_start(label, expand=False, fill=False, padding=10)
> +        self.vbox.pack_start(label, expand=True, fill=True, padding=10)

Padding needs fixing at some point. Perhaps one series can focus on that?

>           self.vbox.show_all()
>
>   #
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 4bbbed6..664bf25 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -55,16 +55,16 @@ class HobViewTable (gtk.VBox):
>       A VBox to contain the table for different recipe views and package view
>       """
>       __gsignals__ = {
> -         "toggled"      : (gobject.SIGNAL_RUN_LAST,
> -                           gobject.TYPE_NONE,
> -                          (gobject.TYPE_PYOBJECT,
> -                           gobject.TYPE_STRING,
> -                           gobject.TYPE_INT,
> -                           gobject.TYPE_PYOBJECT,)),
> -         "changed"      : (gobject.SIGNAL_RUN_LAST,
> -                           gobject.TYPE_NONE,
> -                          (gobject.TYPE_PYOBJECT,
> -                           gobject.TYPE_PYOBJECT,)),
> +         "toggled"       : (gobject.SIGNAL_RUN_LAST,
> +                            gobject.TYPE_NONE,
> +                           (gobject.TYPE_PYOBJECT,
> +                            gobject.TYPE_STRING,
> +                            gobject.TYPE_INT,
> +                            gobject.TYPE_PYOBJECT,)),
> +         "row-activated" : (gobject.SIGNAL_RUN_LAST,
> +                            gobject.TYPE_NONE,
> +                           (gobject.TYPE_PYOBJECT,
> +                            gobject.TYPE_PYOBJECT,)),
>       }
>
>       def __init__(self, columns):
> @@ -75,7 +75,8 @@ class HobViewTable (gtk.VBox):
>           self.table_tree.set_enable_search(True)
>           self.table_tree.set_rules_hint(True)
>           self.table_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
> -        self.table_tree.get_selection().connect("changed", self.selection_changed_cb, self.table_tree)
> +        self.toggle_columns = []
> +        self.table_tree.connect("row-activated", self.row_activated_cb)
>
>           for i in range(len(columns)):
>               col = gtk.TreeViewColumn(columns[i]['col_name'])
> @@ -99,6 +100,7 @@ class HobViewTable (gtk.VBox):
>                   self.toggle_id = i
>                   col.pack_end(cell, True)
>                   col.set_attributes(cell, active=columns[i]['col_id'])
> +                self.toggle_columns.append(columns[i]['col_name'])
>               elif columns[i]['col_style'] == 'radio toggle':
>                   cell = gtk.CellRendererToggle()
>                   cell.set_property('activatable', True)
> @@ -107,6 +109,7 @@ class HobViewTable (gtk.VBox):
>                   self.toggle_id = i
>                   col.pack_end(cell, True)
>                   col.set_attributes(cell, active=columns[i]['col_id'])
> +                self.toggle_columns.append(columns[i]['col_name'])
>
>           scroll = gtk.ScrolledWindow()
>           scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
> @@ -133,8 +136,9 @@ class HobViewTable (gtk.VBox):
>       def toggled_cb(self, cell, path, columnid, tree):
>           self.emit("toggled", cell, path, columnid, tree)
>
> -    def selection_changed_cb(self, selection, tree):
> -        self.emit("changed", selection, tree)
> +    def row_activated_cb(self, tree, path, view_column):
> +        if not view_column.get_title() in self.toggle_columns:
> +            self.emit("row-activated", tree.get_model(), path)
>
>   class HobViewBar (gtk.EventBox):
>       """
> diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> index 280d480..a3c4acd 100755
> --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -116,7 +116,7 @@ class PackageSelectionPage (HobPage):
>               tab.set_model(self.package_model.tree_model(filter))
>               tab.connect("toggled", self.table_toggled_cb)
>               if self.pages[i]['name'] == "Included":
> -                tab.connect("changed", self.tree_selection_cb)
> +                tab.connect("row-activated", self.tree_row_activated_cb)
>
>               reset_button = gtk.Button("Reset")
>               reset_button.connect("clicked", self.reset_clicked_cb)
> @@ -161,14 +161,8 @@ class PackageSelectionPage (HobPage):
>           self.back_button.connect("clicked", self.back_button_clicked_cb)
>           button_box.pack_start(self.back_button, expand=False, fill=False)
>
> -    def tree_selection_cb(self, table, tree_selection, tree_view):
> -        tree_model = tree_view.get_model()
> -        path, column = tree_view.get_cursor()
> -        if not path or column == tree_view.get_column(2):
> -            return
> -
> -        it = tree_model.get_iter(path)
> -        binb = tree_model.get_value(it, PackageListModel.COL_BINB)
> +    def tree_row_activated_cb(self, table, tree_model, path):
> +        binb = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
>           if binb:
>               self.builder.show_binb_dialog(binb)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> index cf8504a..ee36f8c 100755
> --- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -140,8 +140,7 @@ class RecipeSelectionPage (HobPage):
>               tab.set_model(self.recipe_model.tree_model(filter))
>               tab.connect("toggled", self.table_toggled_cb)
>               if self.pages[i]['name'] == "Included":
> -                tab.connect("changed", self.tree_selection_cb)
> -
> +                tab.connect("row-activated", self.tree_row_activated_cb)
>               reset_button = gtk.Button("Reset")
>               reset_button.connect("clicked", self.reset_clicked_cb)
>               hbox = gtk.HBox(False, 5)
> @@ -185,14 +184,8 @@ class RecipeSelectionPage (HobPage):
>           self.back_button.connect("clicked", self.back_button_clicked_cb)
>           button_box.pack_start(self.back_button, expand=False, fill=False)
>
> -    def tree_selection_cb(self, table, tree_selection, tree_view):
> -        tree_model = tree_view.get_model()
> -        path, column = tree_view.get_cursor()
> -        if not path or column == tree_view.get_column(2):
> -            return
> -
> -        it = tree_model.get_iter(path)
> -        binb = tree_model.get_value(it, RecipeListModel.COL_BINB)
> +    def tree_row_activated_cb(self, table, tree_model, path):
> +        binb = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
>           if binb:
>               self.builder.show_binb_dialog(binb)
>

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


