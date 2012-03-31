Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDmPt-0004AT-KI
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Mar 2012 02:43:42 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 Mar 2012 17:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83723820"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Mar 2012 17:34:34 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F75DADC.7070909@linux.intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<9135f6b93e4fe1665f3bdc56eba150d67582d8e1.1333108781.git.dongxiao.xu@intel.com>
	<4F75DADC.7070909@linux.intel.com>
Date: Sat, 31 Mar 2012 08:32:11 +0800
Message-ID: <1333153931.27459.5.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/7] Hob: Make layers define in bblayers.conf as default
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
X-List-Received-Date: Sat, 31 Mar 2012 00:43:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-30 at 09:10 -0700, Joshua Lock wrote:
> 
> On 30/03/12 05:01, Dongxiao Xu wrote:
> > For layers defined in bblayers.conf, we treat them as default layers
> > and users are not allowed to remove them.
> 
> Can you explain the rationale behind this change? I see what you're 
> doing but it's not entirely clear why.
> 
> I think this is a bad idea. Early on in the design of Hob we decided we 
> didn't want configuration made for non-Hob builds to affect builds made 
> with Hob, and vice versa.

The issue I am going to solve is that, with current local.conf
(DISTRO="poky") and bblayers.conf (bblayers="meta meta-yocto"), we are
not able to delete the meta-yocto layer in Hob since it will meet
local.conf parsing error since it could not find where "poky" is
defined.

This patch is to set those layers define in bblayers.conf as default
layers and they could not be removed. For example, in Yocto Project,
"meta", "meta-yocto", and "meta-hob" are not removable. For pure OE-Core
environment, "meta" and "meta-hob" are not removable.

Thanks,
Dongxiao

> 
> Thanks,
> Joshua
> 
> >
> > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> > ---
> >   lib/bb/ui/crumbs/builder.py |    4 ++--
> >   lib/bb/ui/crumbs/hig.py     |   23 +++++++++--------------
> >   2 files changed, 11 insertions(+), 16 deletions(-)
> >
> > diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> > index 44b208a..3be799c 100755
> > --- a/lib/bb/ui/crumbs/builder.py
> > +++ b/lib/bb/ui/crumbs/builder.py
> > @@ -178,7 +178,7 @@ class Parameters:
> >           self.all_distros = []
> >           self.all_sdk_machines = []
> >           self.max_threads = params["max_threads"]
> > -        self.all_layers = []
> > +        self.layers_default = params["layer"].split()
> >           self.core_base = params["core_base"]
> >           self.image_names = []
> >           self.image_addr = params["image_addr"]
> > @@ -764,7 +764,7 @@ class Builder(gtk.Window):
> >       def show_layer_selection_dialog(self):
> >           dialog = LayerSelectionDialog(title = "Layers",
> >                        layers = copy.deepcopy(self.configuration.layers),
> > -                     all_layers = self.parameters.all_layers,
> > +                     layers_default = self.parameters.layers_default,
> >                        parent = self,
> >                        flags = gtk.DIALOG_MODAL
> >                            | gtk.DIALOG_DESTROY_WITH_PARENT
> > diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> > index 9adb281..9a38bc0 100644
> > --- a/lib/bb/ui/crumbs/hig.py
> > +++ b/lib/bb/ui/crumbs/hig.py
> > @@ -850,7 +850,7 @@ class LayerSelectionDialog (CrumbsDialog):
> >               layer_store.remove(iter)
> >
> >
> > -    def gen_layer_widget(self, layers, layers_avail, window, tooltip=""):
> > +    def gen_layer_widget(self, layers, layers_default, window, tooltip=""):
> >           hbox = gtk.HBox(False, 6)
> >
> >           layer_tv = gtk.TreeView()
> > @@ -881,8 +881,8 @@ class LayerSelectionDialog (CrumbsDialog):
> >           for layer in layers:
> >               if layer.endswith("/meta"):
> >                   core_iter = layer_store.prepend([layer])
> > -            elif layer.endswith("/meta-hob") and core_iter:
> > -                layer_store.insert_after(core_iter, [layer])
> > +            elif layer in layers_default:
> > +                core_iter = layer_store.insert_after(core_iter, [layer])
> >               else:
> >                   layer_store.append([layer])
> >
> > @@ -924,12 +924,12 @@ class LayerSelectionDialog (CrumbsDialog):
> >       def add_leave_cb(self, button, event):
> >           self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
> >
> > -    def __init__(self, title, layers, all_layers, parent, flags, buttons=None):
> > +    def __init__(self, title, layers, layers_default, parent, flags, buttons=None):
> >           super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
> >
> >           # class members from other objects
> >           self.layers = layers
> > -        self.all_layers = all_layers
> > +        self.layers_default = layers_default
> >           self.layers_changed = False
> >
> >           # icon for remove button in TreeView
> > @@ -945,7 +945,7 @@ class LayerSelectionDialog (CrumbsDialog):
> >           self.connect("response", self.response_cb)
> >
> >       def create_visual_elements(self):
> > -        layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.all_layers, self, None)
> > +        layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.layers_default, self, None)
> >           layer_widget.set_size_request(450, 250)
> >           self.vbox.pack_start(layer_widget, expand=True, fill=True)
> >           self.show_all()
> > @@ -972,9 +972,7 @@ class LayerSelectionDialog (CrumbsDialog):
> >       def draw_delete_button_cb(self, col, cell, model, it, tv):
> >           path =  model.get_value(it, 0)
> >           # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
> > -        path.rstrip('/')
> > -        name = os.path.basename(path)
> > -        if name == "meta" or name == "meta-hob":
> > +        if path in self.layers_default:
> >               cell.set_sensitive(False)
> >               cell.set_property('pixbuf', None)
> >               cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
> > @@ -992,11 +990,8 @@ class LayerSelectionDialog (CrumbsDialog):
> >       """
> >       def draw_layer_path_cb(self, col, cell, model, it):
> >           path = model.get_value(it, 0)
> > -        name = os.path.basename(path)
> > -        if name == "meta":
> > -            cell.set_property('markup', "<b>Core layer for images: it cannot be removed</b>\n%s" % path)
> > -        elif name == "meta-hob":
> > -            cell.set_property('markup', "<b>Core layer for Hob: it cannot be removed</b>\n%s" % path)
> > +        if path in self.layers_default:
> > +            cell.set_property('markup', "<b>Core layer: it cannot be removed</b>\n%s" % path)
> >           else:
> >               cell.set_property('text', path)
> >
> 




