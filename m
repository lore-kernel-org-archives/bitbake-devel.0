Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4FA717570D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 08:43:41 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 27 Oct 2015 01:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,204,1444719600"; d="scan'208";a="836380844"
Received: from fcheverx-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.10.27])
	by fmsmga002.fm.intel.com with ESMTP; 27 Oct 2015 01:43:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org, Brian Avery <avery.brian@gmail.com>
Date: Tue, 27 Oct 2015 08:43:39 +0000
Message-ID: <32134538.nEPZhokZdl@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.8-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <40CEB3B1-8820-4D38-91B6-5A41DACC4AED@gmail.com>
References: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
	<CAKV_0egMyNQ2bzbO+gydU+vDsc_xwGgKgwmh9YW8vynVhShQ8Q@mail.gmail.com>
	<40CEB3B1-8820-4D38-91B6-5A41DACC4AED@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] toaster: Point to meta/conf for default toasterconf.json
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
X-List-Received-Date: Tue, 27 Oct 2015 08:43:42 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday 26 October 2015 09:19:02 Khem Raj wrote:
> > On Oct 26, 2015, at 9:05 AM, Brian Avery <avery.brian@gmail.com> wr=
ote:
> >=20
> > True,
> >=20
> > but then builds for poky would fail :(
> >=20
> > How about something like (posted from gmail so just for discussion =
not
> > to be used!!):
> >=20
> > if [ "$TOASTER_CONF" =3D "" ]; then
> >=20
> > -    TOASTER_CONF=3D"$(dirname
> > $TOASTER)/../../meta-yocto/conf/toasterconf.json"
> >=20
> > +    if [ -e "$(dirname
> > $TOASTER)/../../meta-yocto/conf/toasterconf.json" ] ; then
> >=20
> > +       TOASTER_CONF=3D"$(dirname
> > $TOASTER)/../../meta-yocto/conf/toasterconf.json"
> >=20
> > +    elif [ -e "$(dirname $TOASTER)/../../meta/conf/toasterconf.jso=
n" ] ;
> > then
> >=20
> > +       TOASTER_CONF=3D"$(dirname
> > $TOASTER)/../../meta/conf/toasterconf.json"
> >=20
> > +    fi
> >=20
> >     export TOASTER_CONF=3D$(python -c "import os; print
> >=20
> > os.path.realpath('$TOASTER_CONF')=E2=80=9D)
>=20
> I think checking meta-yocto and meta is just doing it for two distro=E2=
=80=99s
> IMO OE-Core should just default to meta/ and meta-yocto/poky should t=
hen
> set TOASTER_CONF in its distro.conf

The original design that I specified was to check every layer in the=20=

configuration. Somehow what got implemented was to hardcode the path in=
 bitbake=20
which is pretty much exactly the wrong thing to have done :/

If we're able to rely on DISTRO being set to the right thing then I'd g=
o with=20
Khem's approach, but the important thing to note is that this json file=
 is=20
simply initialising the database; changing that path afterwards is goin=
g to do=20
absolutely nothing. It's more akin to TEMPLATECONF (and possibly even h=
igher=20
level than that, since you're likely to create new build directories mo=
re=20
often than you'll create a new toaster database). Maybe we could use=20=

TEMPLATECONF?

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

