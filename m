Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web12.1685.1595577503458857535
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2020 00:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@bmw.de header.s=mailing1 header.b=Ugn/pYI3;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=4673b3482=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1595577503; x=1627113503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M1RUqqB4gFEZkzrVq5KsJshn2R/zzTo27fh/vAn/fvA=;
  b=Ugn/pYI3L72rpAh/PQiJqy78iR1OIa13iezn9fwVGu54kFySuFSvBfjz
   vsIydjqBmg2GsSh/HUZF6AaiheV9pbg59AZvRofCHhvNYbJtHoM+K/YiT
   a1uo8Uw+5bl/4i6Tgd8L4YwRC4gYHSbLYVVJA5Xv72dzdoCLx5mviqm2y
   Y=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 24 Jul 2020 09:58:20 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw1.muc with ESMTP/TLS;
 24 Jul 2020 09:58:20 +0200
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp) ([160.48.96.48])
 by esabb4.muc with ESMTP/TLS; 24 Jul 2020 09:58:20 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by smucm10l.europe.bmw.corp
 (160.48.96.48) with Microsoft SMTP Server (TLS;
 Fri, 24 Jul 2020 09:58:20 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
 smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1497.006; Fri,
 24 Jul 2020 09:58:20 +0200
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH][master|dunfell|zeus] knotty: ignore pipe errors
Thread-Topic: [bitbake-devel] [PATCH][master|dunfell|zeus] knotty: ignore pipe
 errors
Thread-Index: AQHWYQMJ2SeFxI4d+EW/DXcCGxKyxakWHEUAgAAgkYA=
Date: Fri, 24 Jul 2020 07:58:20 +0000
Message-ID: <20200724075819.GE108868@korppu>
References: <20200723145812.14029-1-mikko.rapeli@bmw.de>
 <48c641c1f8be55e4e6bb862f543df9178b8ff69f.camel@linuxfoundation.org>
In-Reply-To: <48c641c1f8be55e4e6bb862f543df9178b8ff69f.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF338F60C14CE94EA178D9F7EF9533B9@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 07:01:46AM +0100, Richard Purdie wrote:
> On Thu, 2020-07-23 at 17:58 +0300, Mikko Rapeli wrote:
> > Piping bitbake output to another process like less currently
> > results in an ugly error if the other end of pipe exits
> > before bitbake has written all output to it.
> >=20
> > For example with "bitbake -e linux-yocto | less" and
> > pressing q to quit less results in:
> >=20
> > Error in atexit._run_exitfuncs:
> > Traceback (most recent call last):
> >   File "/home/mcfrisk/src/yocto/poky/bitbake/lib/bb/event.py", line
> > 133, in print_ui_queue
> >     sys.stdout.flush()
> > BrokenPipeError: [Errno 32] Broken pipe
> > Exception ignored in: <_io.TextIOWrapper name=3D'<stdout>' mode=3D'w'
> > encoding=3D'UTF-8'>
> > BrokenPipeError: [Errno 32] Broken pipe
> >=20
> > Fix is to use default signal handler for pipe signal. It's
> > perfectly normal that on Unix systems the other end of pipe
> > gets killed before all data is written.
> >=20
> > In some cases there seems to also be a loop which results in
> > a large number of "[Errno 32] Broken pipe" messages printed to
> > console until knotty process is killed. I think this also
> > fixes those cases.
> >=20
> > This patch applies to master, dunfell and zeus branches.
> >=20
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
> > ---
> >  bitbake/lib/bb/ui/knotty.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/bitbake/lib/bb/ui/knotty.py
> > b/bitbake/lib/bb/ui/knotty.py
> > index 87e873d644..56ac41d0f9 100644
> > --- a/bitbake/lib/bb/ui/knotty.py
> > +++ b/bitbake/lib/bb/ui/knotty.py
> > @@ -29,6 +29,9 @@ featureSet =3D
> > [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
> >  logger =3D logging.getLogger("BitBake")
> >  interactive =3D sys.stdout.isatty()
> > =20
> > +# ignore pipe errors since they are normal
> > +signal.signal(signal.SIGPIPE, signal.SIG_DFL)
> > +
> >  class BBProgress(progressbar.ProgressBar):
> >      def __init__(self, msg, maxval, widgets=3DNone, extrapos=3D-1,
> > resize_handler=3DNone):
> >          self.msg =3D msg
>=20
> I think but have not 100% confirmed this caused the failures in:
>=20
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1200

Hmm, I can't see the connection based on logs though I don't know the test
setups at all.

> (new build running to check)

Looking forward to these results...

-Mikko

> Cheers,
>=20
> Richard=
