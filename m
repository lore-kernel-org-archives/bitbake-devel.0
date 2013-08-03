Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0D9756A59D
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Aug 2013 08:13:29 +0000 (UTC)
Received: by mail-ee0-f41.google.com with SMTP id d17so700000eek.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 03 Aug 2013 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=mTsz7yOcKKinQIXHMSoQdvUe6J2kdCw4G4KwB250dcM=;
	b=DA8FeMp67l9FxKiDYZpRJJKbRlzhlTyaaCQdboJJ7XOCIKikhwnt/ekLHYFyszRMuB
	Pbi8VtlnOC5dM0GUI6LxYGSr2n35mv9y+SJ3lnzYPezSoyvqbnY4Hp01y1udPdgdSKx1
	B1j1y70XFaZ+9l2MP/oGIjSOmputDlaeXWe+cH81xTNCYWdWMvKQn3RkpbZh/evR+iw6
	tn3rAZgBt+fGdlUyhX/bBYcyLOeyZEohgtcaexkpvSwTX/HhKYhknyYpg9jFqMFPt2QR
	Ped+zDepsipCnA7QaKStDaNT6k/zfXba/oAYwE+IADPG7S1RrJ2ijRfOORUYb+J8AV7E
	DU/g==
X-Received: by 10.15.54.198 with SMTP id t46mr8768110eew.74.1375517609882;
	Sat, 03 Aug 2013 01:13:29 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id e1sm5976826eev.8.2013.08.03.01.13.28
	for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Sat, 03 Aug 2013 01:13:29 -0700 (PDT)
Date: Sat, 3 Aug 2013 10:14:08 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Joe MacDonald <joe@deserted.net>
Message-ID: <20130803081408.GV3280@jama>
References: <1375366786-16892-1-git-send-email-joe@deserted.net>
	<CABcZANmaaKPj5Fno3aBiA0_DZyg6sEH4+QP8J_g=GODfAgwFag@mail.gmail.com>
	<CANBf+V2Qx4rxbQ2KYL+-t+jA4ds9gMFeKPD1rQBQrqFsfYpj3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANBf+V2Qx4rxbQ2KYL+-t+jA4ds9gMFeKPD1rQBQrqFsfYpj3A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Chris Larson <clarson@kergoth.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: enable pdb tracing
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
X-List-Received-Date: Sat, 03 Aug 2013 08:13:30 -0000
X-Groupsio-MsgNum: 3705
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YHHegWJYV76VGRm9"
Content-Disposition: inline

--YHHegWJYV76VGRm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2013 at 09:07:15PM -0400, Joe MacDonald wrote:
> On Fri, Aug 2, 2013 at 5:05 PM, Chris Larson <clarson@kergoth.com> wrote:
>=20
> > On Thu, Aug 1, 2013 at 7:19 AM, <joe@deserted.net> wrote:
> >
> >> From: Joe MacDonald <joe@deserted.net>
> >>
> >> Based on:
> >>
> >>    http://blog.devork.be/2009/07/how-to-bring-running-python-program.h=
tml
> >>
> >> register a signal handler to dynamically start pdb tracing on receiving
> >> SIGUSR1.
> >>
> >> Signed-off-by: Joe MacDonald <joe@deserted.net>
> >>
> >
> > As long as you keep in mind this will only affect the UI, not the forked
> > off server, this could be useful. I'd suggest adding something for the
> > server as well, but it'd need to listen to a socket for the input, lack=
ing
> > access to the user's tty, or would need to interface with the UI to do =
it :)
> >
>=20
> That's a really good idea.  It seemed like anything was better than what I
> had at the time, but now that you mention it being able to use pdb (or
> something like it) to talk to one of the forked processes would be a real=
ly
> helpful with the current problem I'm looking at.  I'll see what I can do
> about extending this (since it doesn't sound like it's a fundamentally bad
> idea, just of limited applicability here) to more than just the UI.

Hi,

one type of hangs is described here
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D4338
I have no experience with pdb, but if it will help debuging this king of
issues I'll happily try it next time I get it hanging.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--YHHegWJYV76VGRm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEARECAAYFAlH8u9AACgkQN1Ujt2V2gBxPkACeOyiHKJuJ++hxFGtMWqBsMTiA
ZsoAoLTBWcNcXHlFWxGnRKZ42jEDIFCG
=GTm+
-----END PGP SIGNATURE-----

--YHHegWJYV76VGRm9--
