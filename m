Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDr3x-0004Nx-Cx
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Mar 2012 07:41:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Mar 2012 22:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127213230"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 30 Mar 2012 22:32:14 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
In-Reply-To: <1333153931.27459.5.camel@dongxiao-osel>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<9135f6b93e4fe1665f3bdc56eba150d67582d8e1.1333108781.git.dongxiao.xu@intel.com>
	<4F75DADC.7070909@linux.intel.com>
	<1333153931.27459.5.camel@dongxiao-osel>
Date: Sat, 31 Mar 2012 13:29:50 +0800
Message-ID: <1333171790.4073.9.camel@dongxiao-osel>
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
X-List-Received-Date: Sat, 31 Mar 2012 05:41:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-31 at 08:32 +0800, Xu, Dongxiao wrote:
> On Fri, 2012-03-30 at 09:10 -0700, Joshua Lock wrote:
> > 
> > On 30/03/12 05:01, Dongxiao Xu wrote:
> > > For layers defined in bblayers.conf, we treat them as default layers
> > > and users are not allowed to remove them.
> > 
> > Can you explain the rationale behind this change? I see what you're 
> > doing but it's not entirely clear why.
> > 
> > I think this is a bad idea. Early on in the design of Hob we decided we 
> > didn't want configuration made for non-Hob builds to affect builds made 
> > with Hob, and vice versa.
> 
> The issue I am going to solve is that, with current local.conf
> (DISTRO="poky") and bblayers.conf (bblayers="meta meta-yocto"), we are
> not able to delete the meta-yocto layer in Hob since it will meet
> local.conf parsing error since it could not find where "poky" is
> defined.
> 
> This patch is to set those layers define in bblayers.conf as default
> layers and they could not be removed. For example, in Yocto Project,
> "meta", "meta-yocto", and "meta-hob" are not removable. For pure OE-Core
> environment, "meta" and "meta-hob" are not removable.
> 

Just discussed with Josh on this problem.

He suggested that meta-yocto should be still removable. If user met the
error after deleting the meta-yocto layer, he/she should change the
DISTRO setting in "Setting" dialog to "defaultsetup".

Current code to handle the distro setting is:

    def set_distro(self, distro):  
        if distro != "defaultsetup":   
            self.server.runCommand(["setVariable", "DISTRO", distro])

Therefore even if user has selected defaultsetup, it will not set any
value to bitbake server, and then DISTRO ?= "poky" will take effect
while parsing local.conf.

To make DISTRO ?= "poky" doesn't take effect, we need to change the code
to be:

    def set_distro(self, distro):  
        if distro == "defaultsetup":   
            distro = ""
        self.server.runCommand(["setVariable", "DISTRO", distro])

However Richard ever worried about this approach.
See:
http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002438.html

In summary, there are two solutions now:

1) Set those layers defined in bblayers.conf as default, and don't allow
users to delete them, like this [PATCH 3/7] does.
2) Use the empty string "" as the value of DISTRO variable for
"defaultsetup", and set this value before parsing configuration files,
making the DISTRO ?= "poky" in local.conf doesn't take effect.

Welcome for comments on this issue.

Thanks,
Dongxiao

> Thanks,
> Dongxiao
> 
> > 
> > Thanks,
> > Joshua
> > 
> > >
> > > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> > > ---
> > >   lib/bb/ui/crumbs/builder.py |    4 ++--
> > >   lib/bb/ui/crumbs/hig.py     |   23 +++++++++--------------
> > >   2 files changed, 11 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> > > index 44b208a..3be799c 100755
> > > --- a/lib/bb/ui/crumbs/builder.py
> > > +++ b/lib/bb/ui/crumbs/builder.py
> > > @@ -178,7 +178,7 @@ class Parameters:
> > >           self.all_distros = []
> > >           self.all_sdk_machines = []
> > >           self.max_threads = params["max_threads"]
> > > -        self.all_layers = []
> > > +        self.layers_default = params["layer"].split()
> > >           self.core_base = params["core_base"]
> > >           self.image_names = []
> > >           self.image_addr = params["image_addr"]
> > > @@ -764,7 +764,7 @@ class Builder(gtk.Window):
> > >       def show_layer_selection_dialog(self):
> > >           dialog = LayerSelectionDialog(title = "Layers",
> > >                        layers = copy.deepcopy(self.configuration.layers),
> > > -                     all_layers = self.parameters.all_layers,
> > > +                     layers_default = self.parameters.layers_default,
> > >                        parent = self,
> > >                        flags = gtk.DIALOG_MODAL
> > >                            | gtk.DIALOG_DESTROY_WITH_PARENT
> > > diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> > > index 9adb281..9a38bc0 100644
> > > --- a/lib/bb/ui/crumbs/hig.py
> > > +++ b/lib/bb/ui/crumbs/hig.py
> > > @@ -850,7 +850,7 @@ class LayerSelectionDialog (CrumbsDialog):
> > >               layer_store.remove(iter)
> > >
> > >
> > > -    def gen_layer_widget(self, layers, layers_avail, window, tooltip=""):
> > > +    def gen_layer_widget(self, layers, layers_default, window, tooltip=""):
> > >           hbox = gtk.HBox(False, 6)
> > >
> > >           layer_tv = gtk.TreeView()
> > > @@ -881,8 +881,8 @@ class LayerSelectionDialog (CrumbsDialog):
> > >           for layer in layers:
> > >               if layer.endswith("/meta"):
> > >                   core_iter = layer_store.prepend([layer])
> > > -            elif layer.endswith("/meta-hob") and core_iter:
> > > -                layer_store.insert_after(core_iter, [layer])
> > > +            elif layer in layers_default:
> > > +                core_iter = layer_store.insert_after(core_iter, [layer])
> > >               else:
> > >                   layer_store.append([layer])
> > >
> > > @@ -924,12 +924,12 @@ class LayerSelectionDialog (CrumbsDialog):
> > >       def add_leave_cb(self, button, event):
> > >           self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
> > >
> > > -    def __init__(self, title, layers, all_layers, parent, flags, buttons=None):
> > > +    def __init__(self, title, layers, layers_default, parent, flags, buttons=None):
> > >           super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
> > >
> > >           # class members from other objects
> > >           self.layers = layers
> > > -        self.all_layers = all_layers
> > > +        self.layers_default = layers_default
> > >           self.layers_changed = False
> > >
> > >           # icon for remove button in TreeView
> > > @@ -945,7 +945,7 @@ class LayerSelectionDialog (CrumbsDialog):
> > >           self.connect("response", self.response_cb)
> > >
> > >       def create_visual_elements(self):
> > > -        layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.all_layers, self, None)
> > > +        layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.layers_default, self, None)
> > >           layer_widget.set_size_request(450, 250)
> > >           self.vbox.pack_start(layer_widget, expand=True, fill=True)
> > >           self.show_all()
> > > @@ -972,9 +972,7 @@ class LayerSelectionDialog (CrumbsDialog):
> > >       def draw_delete_button_cb(self, col, cell, model, it, tv):
> > >           path =  model.get_value(it, 0)
> > >           # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
> > > -        path.rstrip('/')
> > > -        name = os.path.basename(path)
> > > -        if name == "meta" or name == "meta-hob":
> > > +        if path in self.layers_default:
> > >               cell.set_sensitive(False)
> > >               cell.set_property('pixbuf', None)
> > >               cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
> > > @@ -992,11 +990,8 @@ class LayerSelectionDialog (CrumbsDialog):
> > >       """
> > >       def draw_layer_path_cb(self, col, cell, model, it):
> > >           path = model.get_value(it, 0)
> > > -        name = os.path.basename(path)
> > > -        if name == "meta":
> > > -            cell.set_property('markup', "<b>Core layer for images: it cannot be removed</b>\n%s" % path)
> > > -        elif name == "meta-hob":
> > > -            cell.set_property('markup', "<b>Core layer for Hob: it cannot be removed</b>\n%s" % path)
> > > +        if path in self.layers_default:
> > > +            cell.set_property('markup', "<b>Core layer: it cannot be removed</b>\n%s" % path)
> > >           else:
> > >               cell.set_property('text', path)
> > >
> > 
> 
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




