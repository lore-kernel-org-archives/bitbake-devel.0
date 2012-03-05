Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S4gY7-0007vY-7U
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Mar 2012 23:38:35 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2012 14:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="117952185"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
	by orsmga002.jf.intel.com with ESMTP; 05 Mar 2012 14:29:58 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Tue, 6 Mar 2012 06:29:57 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Tue, 6 Mar 2012 06:29:57 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/6] crumbs/persistenttooltip: a new
	Gtk+	widget for use in Hob
Thread-Index: AQHM+NYi1+37UK4GaEapOEeM6mbsiZZcS6EA
Date: Mon, 5 Mar 2012 22:29:56 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE1B57@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
	<8bd3c205e17913dd3fe85e95d9ef2f28a01f123e.1330734444.git.josh@linux.intel.com>
In-Reply-To: <8bd3c205e17913dd3fe85e95d9ef2f28a01f123e.1330734444.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] crumbs/persistenttooltip: a new Gtk+	widget for use in Hob
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
X-List-Received-Date: Mon, 05 Mar 2012 22:38:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ACK the rest except one comment below.

--
Shane

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
> Joshua Lock
> Sent: Friday, March 02, 2012 4:39 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/6] crumbs/persistenttooltip: a new Gtk+
> widget for use in Hob
>=20
> The Hob interaction design calls for a top level widget which shows a
> persistent tooltip. This tooltip will not disappear until the user
> explicitly closes it.
>=20
> This allows us to provide clickable hyperlinks, longer instructions and
> deeper information in the tooltips.
>=20
> Note: by design the tooltip should dismiss when the user clicks off it,
> this implementation does include that functionality. It's a to do item.
>=20
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/persistenttooltip.py |  127
> +++++++++++++++++++++++++++++++++
>  1 files changed, 127 insertions(+), 0 deletions(-)
>  create mode 100644 lib/bb/ui/crumbs/persistenttooltip.py
>=20
> diff --git a/lib/bb/ui/crumbs/persistenttooltip.py
> b/lib/bb/ui/crumbs/persistenttooltip.py
> new file mode 100644
> index 0000000..f3f55b1
> --- /dev/null
> +++ b/lib/bb/ui/crumbs/persistenttooltip.py
> @@ -0,0 +1,127 @@
> +#
> +# BitBake Graphical GTK User Interface
> +#
> +# Copyright (C) 2012   Intel Corporation
> +#
> +# Authored by Joshua Lock <josh@linux.intel.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License alon=
g
> +# with this program; if not, write to the Free Software Foundation, Inc.=
,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import gobject
> +import gtk
> +
> +class PersistentTooltip(gtk.Window):
> +	"""
> +	A tooltip which persists once shown until the user dismisses it with th=
e
> Esc
> +	key or by clicking the close button.
> +
> +	# FIXME: the PersistentTooltip should be disabled when the user clicks
> anywhere off
> +	# it. We can't do this with focus-out-event becuase modal ensures we
> have focus?
> +
> +	markup: some Pango text markup to display in the tooltip
> +	"""
> +	def __init__(self, markup):
> +		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
> +
> +		# We need to ensure we're only shown once
> +		self.shown =3D False
> +
> +		# We don't want any WM decorations
> +		self.set_decorated(False)
> +		# We don't want to show in the taskbar or window switcher
> +		self.set_skip_pager_hint(True)
> +		self.set_skip_taskbar_hint(True)
> +		# We must be modal to ensure we grab focus when presented from
> a gtk.Dialog
> +		self.set_modal(True)
> +
> +		self.set_border_width(6)
> +		self.set_position(gtk.WIN_POS_MOUSE)
> +		self.set_opacity(0.95)
> +
> +		# Draw our label and close buttons
> +		hbox =3D gtk.HBox(False, 0)
> +		hbox.show()
> +		vbox =3D gtk.VBox(False, 0)
> +		vbox.show()
> +		vbox.pack_start(hbox, True, True, 0)
> +
> +		img =3D gtk.Image()
> +		img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
> +
> +		self.button =3D gtk.Button()
> +		self.button.set_image(img)
> +		self.button.connect("clicked", self._dismiss_cb)
> +		self.button.set_can_default(True)
> +		self.button.grab_focus()
> +		self.button.show()
> +		hbox.pack_end(self.button, False, False, 0)
> +
> +		self.set_default(self.button)
> +
> +		self.label =3D gtk.Label()
> +		self.label.set_markup(markup)
> +		self.label.show()
> +		vbox.pack_end(self.label, True, True, 6)
> +
> +		self.connect("key-press-event", self._catch_esc_cb)
> +
> +		# Inherit the system theme for a tooltip
> +		style =3D gtk.rc_get_style_by_paths(gtk.settings_get_default(),
> +			'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
> +		self.set_style(style)
> +
> +		self.add(vbox)
> +
> +	"""
> +	Modify the displayed message once the PersistentTooltip has been
> created.
> +
> +	markup: the Pango Markup of the new message
> +	"""
> +	def set_tooltip(self, markup):
> +		self.label.set_markup(markup)
I haven't seen this is used. Can we remove it?


> +
> +
> +	"""
> +	Callback when the PersistentTooltip's close button is clicked.
> +	Hides the PersistentTooltip.
> +	"""
> +	def _dismiss_cb(self, button):
> +		self.hide()
> +		return True
> +
> +	"""
> +	Callback when the Esc key is detected. Hides the PersistentTooltip.
> +	"""
> +	def _catch_esc_cb(self, widget, event):
> +		keyname =3D gtk.gdk.keyval_name(event.keyval)
> +		if keyname =3D=3D "Escape":
> +			self.hide()
> +		return True
> +
> +	"""
> +	Called to present the PersistentTooltip.
> +	Overrides the superclasses show() method to include state tracking.
> +	"""
> +	def show(self):
> +		if not self.shown:
> +			self.shown =3D True
> +			gtk.Window.show(self)
> +
> +	"""
> +	Called to hide the PersistentTooltip.
> +	Overrides the superclasses hide() method to include state tracking.
> +	"""
> +	def hide(self):
> +		self.shown =3D False
> +		gtk.Window.hide(self)
> --
> 1.7.7.6
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


