Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SZZUL-00082D-5q
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 05:22:21 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 May 2012 20:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="149275168"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 29 May 2012 20:12:01 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 29 May 2012 20:12:00 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.90]) with mapi id
	14.01.0355.002; Wed, 30 May 2012 11:11:58 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] Hob: Fixed a compatible issue for
	indicator icon view
Thread-Index: AQHNOmI38kHAtbqNyUOZoOvFti66uZbhrcmw
Date: Wed, 30 May 2012 03:11:58 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BB42A3@SHSMSX102.ccr.corp.intel.com>
References: <cover.1337942129.git.limingx.l.an@intel.com>
	<8fc876ef63562b89f1af1de59252188951238519.1337942129.git.limingx.l.an@intel.com>
In-Reply-To: <8fc876ef63562b89f1af1de59252188951238519.1337942129.git.limingx.l.an@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Hob: Fixed a compatible issue for	indicator icon view
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
X-List-Received-Date: Wed, 30 May 2012 03:22:21 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK, I am OK with that and have tested on Ubuntu 10.04. CC Josh.

But one more thing, can you test set_action_widget() mentioned by Josh to s=
ee how we can replace it with something else, Liming?
It seems that doesn't work on Ubuntu 10.04.

--
Shane

Liming An wrote on=A02012-05-25:

> Because some screen not support the alpha visual channel, so the function
> 'screen.get_rgba_colormap()' will return None, it's a compatible issue, s=
o
> change it by another way.
>=20
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobwidget.py |   51 +++++----------------------=
-----
>  1 files changed, 8 insertions(+), 43 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> b/bitbake/lib/bb/ui/crumbs/hobwidget.py index f8e97ad..bd9e2e2 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py +++
> b/bitbake/lib/bb/ui/crumbs/hobwidget.py @@ -400,50 +400,33 @@ class
> HobInfoButton(gtk.EventBox):
>  class HobIndicator(gtk.DrawingArea):
>      def __init__(self, count):
>          gtk.DrawingArea.__init__(self)
> -
> -        # We want to composite the transparent indicator onto the parent
> -        # HBox
> -        screen =3D self.get_screen()
> -        rgba =3D screen.get_rgba_colormap()
> -        self.set_colormap(rgba)
> -        self.set_app_paintable(True)
> +        # Set no window for transparent background
> +        self.set_has_window(False)
>          self.set_size_request(38,38)
>          # We need to pass through button clicks
>          self.add_events(gtk.gdk.BUTTON_PRESS_MASK |
> gtk.gdk.BUTTON_RELEASE_MASK)
>=20
>          self.connect('expose-event', self.expose)
> -        self.connect_after('realize', self.composite)
>=20
>          self.count =3D count
>          self.color =3D HobColors.GRAY
> -    def composite(self, widget):
> -        # This property must be set after the widget has been realised
> -        self.window.set_composited(True)
> -
>      def expose(self, widget, event):
> -        # Transparent background
> -        ctx =3D widget.window.cairo_create()
> -        ctx.set_operator(cairo.OPERATOR_CLEAR)
> -        region =3D gtk.gdk.region_rectangle(event.area)
> -
> -        ctx.region(region)
> -        ctx.fill()
> -
>          if self.count and self.count > 0:
> -            w =3D self.allocation.width
> -            h =3D self.allocation.height
> +            ctx =3D widget.window.cairo_create()
> +
> +            x, y, w, h =3D self.allocation
>=20
>              ctx.set_operator(cairo.OPERATOR_OVER)
>              ctx.set_source_color(gtk.gdk.color_parse(self.color))
>              ctx.translate(w/2, h/2)
> -            ctx.arc(1, 1, min(w,h)/2 - 2, 0, 2*math.pi)
> +            ctx.arc(x, y, min(w,h)/2 - 2, 0, 2*math.pi)
>              ctx.fill_preserve()
>             =20
>              layout =3D self.create_pango_layout(str(self.count))
>              textw, texth =3D layout.get_pixel_size()
> -            x =3D (w/2)-(textw/2) + 1
> -            y =3D (h/2) - (texth/2) + 1
> +            x =3D (w/2)-(textw/2) + x
> +            y =3D (h/2) - (texth/2) + y
>              ctx.move_to(x, y)
> self.window.draw_layout(self.style.light_gc[gtk.STATE_NORMAL], int(x),
> int(y), layout)
>=20
> @@ -466,24 +449,6 @@ class HobTabLabel(gtk.HBox):
>          self.lbl.set_alignment(0.0, 0.5)
>          self.lbl.show()
>          self.pack_end(self.lbl, True, True, 6)
> -        self.connect_after('expose-event', self.expose_event) - -  =20
> def expose_event(self, widget, event): -        # Composite the child
> indicator onto the Box -        child =3D self.indicator -        ctx =3D
> widget.window.cairo_create() - -      =20
> ctx.set_source_pixmap(child.window, child.allocation.x,
> child.allocation.y) - -        region =3D
> gtk.gdk.region_rectangle(child.allocation) -        r =3D
> gtk.gdk.region_rectangle(event.area) -        region.intersect(r) -    =20
>   ctx.region(region) -        ctx.clip() - -        ctx.paint() - -    =20
>   return False
>=20
>      def set_count(self, count):
>          self.indicator.set_count(count)



