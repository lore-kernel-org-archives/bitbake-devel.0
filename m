Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 3F7F2618BE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 20:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=4017; q=dns/txt; s=axis-central1;
	t=1582921920; x=1614457920;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=9FWZU+lJ/mLL1+5UWfnPp2I8wZM1+EjM290ufNyMc/8=;
	b=XDUKTCE//hslVAo0XzWI2PuO7vFHbustlxmBppv2lBL7/zyaNo4qoS+/
	1r3IJp2Rtglvn1msp8sTG9kbst2oDsFTribaMzpm22T76rNaO6eYKYDUS
	xSliaVDu0waeXiks20oPd28pYE1D3cxTcRBihVC7OFr8eFvdZzrCeR0Tg
	2AWSFA3Tq654gRTpXnW5hHWxIAs1OBRUSOHxonAIXatemLZcelTA1Rngy
	JJUu60RVaAlnsspWeW9ljUqgME7LIbdmW/kqD8R5TgGTDwR5+gMn91KoH
	FUPgum1iI/2QSV+1mscaDnRdVfW0kttkQJtW1bEhyUXOczo/t9+P0UsXT w==;
IronPort-SDR: DYMFWRdTOLszgQ4y29+BsxX3MN+xsMb0nB/oNNoFOputIR5Vq/noC/dxZKvzEzctZ/BzVBbbE7
	Z4uzebQVwlkIw0E/VbJmabvtg2kMF8KGaVP2C3APeqknmsiiP83VyA+TrJiiy5iBivqkVDoQo7
	q/uzkRtiDD7aTZcn2Yh1x+Fw6aawWiCEbiDze7nbm5XMtOyxdJvycnXs0LBuqArys8LsH/f+WL
	rrK2AXfAPAl4+eglB735MgzZpdqOE1dcpV83x5od8WLCpALW1+fgrSvM2oWJfdpz5MSb0636O/
	WrQ=
X-IronPort-AV: E=Sophos;i="5.70,497,1574118000"; 
   d="scan'208";a="5784373"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, "Mikko.Rapeli@bmw.de"
	<Mikko.Rapeli@bmw.de>
Thread-Topic: [bitbake-devel] can i get a list of only bbappend'ed recipes
	that were *used* in a build?
Thread-Index: AQHV7ju4CHDoMUkrjUSd3SIX30oFYqgwlBqAgABb4ICAABv6EA==
Date: Fri, 28 Feb 2020 20:31:58 +0000
Message-ID: <52d5e8b6d3c64fe0a74d098e79651f2b@XBOX03.axis.com>
References: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
	<20200228140919.GO104502@korppu>
	<alpine.LFD.2.21.2002281435580.6574@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2002281435580.6574@localhost.localdomain>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: can i get a list of only bbappend'ed recipes that were *used* in a build?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 28 Feb 2020 20:31:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> Sent: den 28 februari 2020 20:38
> To: Mikko.Rapeli@bmw.de
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] can i get a list of only bbappend'ed recipes
> that were *used* in a build?
>=20
> On Fri, 28 Feb 2020, Mikko.Rapeli@bmw.de wrote:
>=20
> > Hi,
> >
> > On Fri, Feb 28, 2020 at 08:33:36AM -0500, rpjday@crashcourse.ca wrote:
> > > looked around and i don't see an immediately obvious way to do
> > > this ... is there a way to generate a list of *only* those recipes
> > > that were used in the current build that had associated .bbappend
> > > files?
> > >
> > > "bitbake-layers show-appends" will show all recipes with .bbappend
> > > files, including those that are not included and processed for the
> > > current build/image. here's the rationale, in case i'm missing
> > > something.
> >
> > I'm doing "find meta* -name \*recipe\*bb\*" and reviewing every one
> > of them. More visibility to this including parsing order would be
> > nice to store in e.g. buildhistory.
>=20
>   thanks for clarifying that there wasn't a massively trivial way to
> do this that i just didn't see.

For each image you build, you should find a manifest in=20
"tmp/deploy/image/<machine>/<image>-<machine>.manifest". It contains the=20
names, architectures and versions of all packages that were installed in=20
the image.=20

To convert the package names from the manifest to recipes, you can use=20
oe-pkgdata-util:

  oe-pkgdata-util -p tmp/pkgdata/<machine> package-info -f <path to the man=
ifest file>

(the -p tmp/pkgdata/<machine> option isn't necessary, but you avoid=20
starting tinfoil if you use it). This will give you one line per package=20
that also includes the recipe name. Pass the output to `cut -f3 -d' ' |=20
sort -u' and you should have the list of recipes that were used to build=20
the packages in your image.

Then all you have to do is take the intersection of recipes from that=20
list and from `bitbake-layers show-appends` and you should have the=20
list of recipes that have bbappends applied and are used to build your=20
image.

Not trivial, but it should be possible to write a relatively simple=20
script to do the above.

> > > been handed an existing vendor layer, with *tons* of bbappend'ed
> > > recipes, some basic, some from meta-openembedded and many from the
> > > vendor's proprietary layer. my go-to strategy is to always try to
> > > build a core-image-minimal to establish a working baseline and,
> > > when that works, it would be nice to know which of the recipes
> > > that contributed to that core-image-minimal build were modified in
> > > any way via a .bbappend file, then work my way out.
> > >
> > > does that make sense? is there a way to do this, other than wander
> > > down to tmp/work/... and try to figure out which recipes were
> > > modified from the original? am i overlooking something simple?
> >
> > I start off by reviewing every single file in vendor and BSP SW
> > layers before I add them to builds. Sadly this does not catch bad
> > things which get integrated later in updates.
> >
> > Resulting distro config in my projects is full of BBMASK paths to
> > the various layers which are intrusive with their bbappends.
>=20
> yup, i'd already thought of that ... a methodical way to slowly add
> recipes/layers to the build.
>=20
> > Maybe recording all bbappends and their relative paths in the
> > project and parsing order to buildhistory would help.
> >
> > I would also like to limit layers from adding bbappends to certain
> > recipes but I don't see ways for this currently without external
> > scripts.
>=20
> yeah, there's lots of cool things i can think of that would assist
> in a migration from an older version of OE/YP to a more recent one.
>=20
> rday

//Peter


