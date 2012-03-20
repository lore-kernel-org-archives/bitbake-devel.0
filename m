Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S9sQ8-0000hh-OC
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 07:19:49 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 23:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141682797"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 23:10:54 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "Barros Pena, Belen"
	<belen.barros.pena@intel.com>, Giulia Piu <giulia@closertag.com>
In-Reply-To: <c9435773fd1a5d0cb612522ce4984052b36901d6.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
	<c9435773fd1a5d0cb612522ce4984052b36901d6.1332202341.git.josh@linux.intel.com>
Date: Tue, 20 Mar 2012 14:08:51 +0800
Message-ID: <1332223731.1848.22.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/6] ui/crumbs/hig: make the layer selection dialogue more closely match design
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
X-List-Received-Date: Tue, 20 Mar 2012 06:19:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
> The layer dialogue design includes in-line remove/delete widgets next to
> the layer path in the tree view for all layers other than the meta layer as
> well as an in-line notice that the meta layer cannot be removed.
> 
> This is achieved  in this patch through the use of custom cell_data_func's
> for the treeview to render the meta layer differently and a custom
> CellRenderer implementation, CellRendererPixbufActivatable, which renders a
> pixbuf and emits a clicked signal when the user clicks on it.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/hig.py |   96 ++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 74 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 849d7c9..5b0cfc9 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -789,6 +789,26 @@ class DeployImageDialog (CrumbsDialog):
>          os.close(f_from)
>          os.close(f_to)
>          self.progress_bar.hide()
> +
> +class CellRendererPixbufActivatable(gtk.CellRendererPixbuf):
> +    """
> +    A custom CellRenderer implementation which is activatable
> +    so that we can handle user clicks
> +    """
> +    __gsignals__    = { 'clicked' : (gobject.SIGNAL_RUN_LAST,
> +                                     gobject.TYPE_NONE,
> +                                     (gobject.TYPE_STRING,)), }
> +
> +    def __init__(self):
> +        gtk.CellRendererPixbuf.__init__(self)
> +        self.set_property('mode', gtk.CELL_RENDERER_MODE_ACTIVATABLE)
> +
> +    """
> +    Respond to a user click on a cell
> +    """
> +    def do_activate(self, even, widget, path, background_area, cell_area, flags):
> +        self.emit('clicked', path)
> +
>  #
>  # LayerSelectionDialog
>  #
> @@ -855,13 +875,13 @@ class LayerSelectionDialog (CrumbsDialog):
>          layer_tv.set_rules_hint(True)
>          layer_tv.set_headers_visible(False)
>          tree_selection = layer_tv.get_selection()
> -        tree_selection.set_mode(gtk.SELECTION_SINGLE)
> +        tree_selection.set_mode(gtk.SELECTION_NONE)
>  
>          col0= gtk.TreeViewColumn('Path')
>          cell0 = gtk.CellRendererText()
>          cell0.set_padding(5,2)
>          col0.pack_start(cell0, True)
> -        col0.set_attributes(cell0, text=0)
> +        col0.set_cell_data_func(cell0, self.draw_layer_path_cb)
>          layer_tv.append_column(col0)
>  
>          scroll = gtk.ScrolledWindow()
> @@ -897,18 +917,19 @@ class LayerSelectionDialog (CrumbsDialog):
>              for layer in layers:
>                  layer_store.set(layer_store.append(), 0, layer)
>  
> -            image = gtk.Image()
> -            image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
> +            col1 = gtk.TreeViewColumn('Enabled')
> +            layer_tv.append_column(col1)
> +
> +            cell1 = CellRendererPixbufActivatable()
> +            cell1.connect("clicked", self.del_cell_clicked_cb, layer_store)
> +            col1.pack_start(cell1, True)
> +            col1.set_cell_data_func(cell1, self.draw_delete_button_cb, layer_tv)
> +
>              add_button = gtk.Button()
> -            add_button.set_image(image)
> +            add_button.set_label("_Add layer")
> +            add_button.set_use_underline(True)
>              add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
> -            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
> -            image = gtk.Image()
> -            image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
> -            del_button = gtk.Button()
> -            del_button.set_image(image)
> -            del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
> -            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
> +            table_layer.attach(add_button, 0, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
>          layer_tv.set_model(layer_store)
>  
>          hbox.show_all()
> @@ -936,24 +957,16 @@ class LayerSelectionDialog (CrumbsDialog):
>          hbox_top = gtk.HBox()
>          self.vbox.pack_start(hbox_top, expand=False, fill=False)
>  
> -        if self.split_model:
> -            label = self.gen_label_widget("<b>Select Layers:</b>\n(Available layers under '${COREBASE}/layers/' directory)")
> -        else:
> -            label = self.gen_label_widget("<b>Select Layers:</b>")
> +        label = self.gen_label_widget("<b>Select Layers:</b>")
>          hbox_top.pack_start(label, expand=False, fill=False)
> -
>          tooltip = "Layer is a collection of bb files and conf files"
>          info = HobInfoButton(tooltip, self)
>          hbox_top.pack_end(info, expand=False, fill=False)
>  
>          layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
> -        layer_widget.set_size_request(-1, 180)
> +        layer_widget.set_size_request(450, 250)
>          self.vbox.pack_start(layer_widget, expand=True, fill=True)
>  
> -        label = self.gen_label_widget("<b>Note:</b> '<i>meta</i>' is the Core layer for Yocto images please do not remove it.")
> -        label.show()
> -        self.vbox.pack_end(label, expand=False, fill=False)
> -
>          self.show_all()
>  
>      def response_cb(self, dialog, response_id):
> @@ -972,6 +985,45 @@ class LayerSelectionDialog (CrumbsDialog):
>          self.layers_changed = (self.layers != layers)
>          self.layers = layers
>  
> +    """
> +    A custom cell_data_func to draw a delete 'button' in the TreeView for layers
> +    other than the meta layer. The deletion of which is prevented so that the
> +    user can't shoot themselves in the foot too badly.
> +    """
> +    def draw_delete_button_cb(self, col, cell, model, it, tv):
> +        path =  model.get_value(it, 0)
> +        # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
> +        path.rstrip('/')
> +        name = os.path.basename(path)
> +        if name == "meta":
> +            cell.set_sensitive(False)
> +            cell.set_property('pixbuf', None)
> +            cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
> +        else:
> +            pix = tv.render_icon(gtk.STOCK_DELETE, gtk.ICON_SIZE_DND, None)

Could Belen and Giulia provide an designed icon for this delete button?
Since the default gtk.STOCK_DELETE may appear different from OS
distributions.

Besides, I think it is better if this button can have the effect of
hover/un-hover, because from first eye on the button, users may not know
it is click-able.

Thanks,
Dongxiao

> +            cell.set_property('pixbuf', pix)
> +            cell.set_sensitive(True)
> +            cell.set_property('mode', gtk.CELL_RENDERER_MODE_ACTIVATABLE)
> +
> +        return True
> +
> +    """
> +    A custom cell_data_func to write an extra message into the layer path cell
> +    for the meta layer. We should inform the user that they can't remove it for
> +    their own safety.
> +    """
> +    def draw_layer_path_cb(self, col, cell, model, it):
> +        path = model.get_value(it, 0)
> +        name = os.path.basename(path)
> +        if name == "meta":
> +            cell.set_property('markup', "<b>Core layer, it cannot be removed</b>\n%s" % path)
> +        else:
> +            cell.set_property('text', path)
> +
> +    def del_cell_clicked_cb(self, cell, path, model):
> +        it = model.get_iter_from_string(path)
> +        model.remove(it)
> +
>  class ImageSelectionDialog (CrumbsDialog):
>  
>      __columns__ = [{




