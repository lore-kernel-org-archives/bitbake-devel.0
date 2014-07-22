Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id B91337078B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 18:51:26 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id m15so68718wgh.17
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=izGvsc7A6Mqxne5etQAybC22km1BtH4kk1J8NVeiQCk=;
	b=pKz+P2LkCUc1n/Ep9xhZdRQGqFEeHCoZKLX3D68nMxAcmz6KLqmAGMJMUaN0jZm1cf
	AV2OYJbuneIwGRD+YKixn4kXGjRaNSi7+W07UIPpCsQeiGtI+eQigtRuToFKb6r3pHja
	qgZCvofLdi8ecvfHn3SVue11lPq585ffTowrl7r9Isb9vFBl4/lW4kLYhc44RyMUYHF5
	3+YiLc5Nj+NEpUKwJaDwzjCkl6GDTzXbWkmF+ClsAj1oOjKMFpwA8xS/MHICU+ZtmXCq
	dzZm8ZAJ3yYBYz8APZehu2BI2cYfhToqA4SkXa8KdbkvZaeyimCOy/nY1YuyZKTjfOH+
	fckQ==
X-Received: by 10.180.84.7 with SMTP id u7mr17202919wiy.27.1406055087948;
	Tue, 22 Jul 2014 11:51:27 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id ex4sm10783wic.2.2014.07.22.11.51.26
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 22 Jul 2014 11:51:26 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 22 Jul 2014 20:51:42 +0200
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140722185142.GX22875@jama>
References: <1405931753.22985.93.camel@ted> <20140722144605.GT22875@jama>
	<1406052631.22985.110.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1406052631.22985.110.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] command/runqueue: Fix shutdown logic
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
X-List-Received-Date: Tue, 22 Jul 2014 18:51:31 -0000
X-Groupsio-MsgNum: 4936
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4rQ9lIe3OahbhU4J"
Content-Disposition: inline

--4rQ9lIe3OahbhU4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 07:10:31PM +0100, Richard Purdie wrote:
> On Tue, 2014-07-22 at 16:46 +0200, Martin Jansa wrote:
> > On Mon, Jul 21, 2014 at 09:35:53AM +0100, Richard Purdie wrote:
> > > If you hit Ctrl+C at the right point, the system processes the request
> > > but merrily continues building. It turns out finish_runqueue() is cal=
led
> > > but this doesn't stop the later generation and execution of the
> > > runqueue.
> > >=20
> > > This patch adjusts some of the conditionals to ensure the build really
> > > does stop.
> >=20
> > Great, I've included this change in my world builds to see if it fixes
> > bitbake still running after jenkins job is aborted.
>=20
> I've seen that too and I don't think this fix will address that
> unfortunately. Its on my list of things to look into.
>=20
> > I don't think it's caused by this change and I don't know how much we
> > can do about it, but today I was testing snort build (which eats all
> > memory in m4 call until OOMK kills it)=20
>=20
> I ended up excluding snort from my builds for that reason. Builds go a
> lot faster when its not destroying the machine!

adding pkgconfig inherit fixed that, but indeed strange side effect

and it seems to trigger this memory eating only in combination with more
restrictive m4 dependencies or foreign flag (but I got OOM even after
patching snort's configure.in to pass foreign).

> > and when I wanted to interrupt
> > the build it failed with 2 tracebacks:
> >=20
> > NOTE: Preparing runqueue
> > NOTE: Executing SetScene Tasks
> > NOTE: Executing RunQueue Tasks
> > NOTE: Running task 569 of 610 (ID: 5, /OE/build/oe-core/meta-openembedd=
ed/meta-networking/recipes-connectivity/snort/snort_2.9.6.0.bb, do_configur=
e)
> > NOTE: recipe snort-2.9.6.0-r0: task do_configure: Started
> > ^C^C^C^C^C^C^C^C^C^C^C^C^C^CTraceback (most recent call last):
> >   File "/OE/build/oe-core/bitbake/bin/bitbake", line 382, in <module>
> >     ret =3D main()
> >   File "/OE/build/oe-core/bitbake/bin/bitbake", line 372, in main
> >     bb.event.ui_queue =3D []
> > KeyboardInterrupt
> > ^CException KeyboardInterrupt in <module 'threading' from '/usr/lib64/p=
ython2.7/threading.pyc'> ignored
> >=20
> > ^CError in atexit._run_exitfuncs:
> > ^CError in sys.exitfunc:
> > Traceback (most recent call last):
> >   File "/usr/lib64/python2.7/atexit.py", line 30, in _run_exitfuncs
> >     traceback.print_exc()
> >   File "/usr/lib64/python2.7/traceback.py", line 233, in print_exc
> >     print_exception(etype, value, tb, limit, file)
> >   File "/usr/lib64/python2.7/traceback.py", line 110, in print_exception
> >     def print_exception(etype, value, tb, limit=3DNone, file=3DNone):
> > KeyboardInterrupt
> >=20
> > There was also about 5 minute delay between first 2 Ctrl+C and actual
> > exit, but that could be caused by huge load caused by that faulty m4.
>=20
> Thanks, I'll have a look at those and see if they're significant and if
> we can do anything about them. It may be they are "one offs" and
> unlikely to reproduce but we'll see.
>=20
> Cheers,
>=20
> Richard
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--4rQ9lIe3OahbhU4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlPOsr4ACgkQN1Ujt2V2gBywrACaAwkYpQ3v0INYW9481Xa7le97
lHUAnR3Df7dXB3fbDPdigvB+zhS7s3hk
=H2MM
-----END PGP SIGNATURE-----

--4rQ9lIe3OahbhU4J--
