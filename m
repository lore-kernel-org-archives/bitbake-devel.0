Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1TisbI-0007kf-NR
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 21:08:16 +0100
Received: by mail-ee0-f47.google.com with SMTP id e51so736895eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 11:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent
	:x-gm-message-state;
	bh=+WjbiddW6+ppkCLHCdL1j0m38Fx89gSsYl5dAJN4ydQ=;
	b=MDDroVwjLRkrzRx6nL+ld21qm7FQS/qMRS0OCglGB0/s/jSH6FQhtuP2p2bTFnhBWz
	T4YTqnR9bKrSOHfoKSP9udTkWJfbg1/Qh7KYRIUv1EEjIbkyazOhEKdUmsDMLgBdqc0z
	y1KOQ2obnU8ejtZWuRZ5ASEvQIDiFQz0LmmKAVrUU7VhmfIlV20j3HozMSMWJ+p/qNXs
	fAVbtS4ZR4bs5IEZZc0ylxzInvEqWYkzqYQWUKUQmHceYJ7UO2gCanKJyLBJomCspQPz
	32iAx0z6k7B+4+wtm1UzxaVcwFFuZwbT0CCbp/Qw7eVmmuayBPeHfEGghDSoXX/a/oaE
	0lBA==
Received: by 10.14.176.66 with SMTP id a42mr5529035eem.34.1355342022769;
	Wed, 12 Dec 2012 11:53:42 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id 6sm45884338eea.3.2012.12.12.11.53.40
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 12 Dec 2012 11:53:41 -0800 (PST)
Date: Wed, 12 Dec 2012 21:53:35 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <20121212195335.GB743@gmail.com>
References: <20121212184156.GA743@gmail.com>
	<alpine.DEB.2.02.1212121356150.13192@oneiric>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1212121356150.13192@oneiric>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnUyJ1mlTPNKMSdCxyHJMMX62ILxWqTu3RIl8ccAeXugXUI8S49mfALeqgIYo5pmV5OA1un
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 20:08:16 -0000
X-Groupsio-MsgNum: 3032
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline

--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 01:57:53PM -0500, Robert P. J. Day wrote:
>   gack.  there's no compelling reason to be that, um, pedantic with
> the wildcard pattern.  just use
>=20
>   *.{bb,bbappend,bbclass}
>=20
> trying to save a couple characters while introducing that kind of
> visual ugliness just isn't worth it.

It can be used but I was not the one who introduced "that kind of visual
ugliness" :) I just sticked with the old one, adding bbappend.

Visual ugliness/goodness depends on person to person. To me, it doesn't
look ugly at all. I've seen things uglier than just an innocent
wildcard pattern.

Regards,
Eren

--=20
    . 73! DE TA1AET
      http://linkedin.com/in/erenturkay

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyOC/AAoJEOM7bMm6HhcTytsQAJ3+jsrtpj2XKPiKrhZ57oTm
wdqz7r3gBnWAoETDv1mi3BQaTqdd2TuMqD75Y5PUGqvjXHP031YHsi8QJPU6+3os
fpxHGNcWAmg3XnrQ5L+BUfsICfSWW1KVoLBQ+OIwZmd/x6hB48ERaXS4C9xNIQhw
XFH/VvkIQqctWmEp3xwyJEVRz7emVZFEFw3fCCJSHXGEXUfy0VSgWDMDLS7d3Q7q
aaLjPztBopdeRrtNbmM4lFESTFb5Z0l3sFoulBHF4rSnYPVddGmQAekm2H4C3a1Y
c9ETI8RThCabBZGl2M3iQqF4u+3i7yNS/MXy5L+3b+SLzjD/xwZ4/XFvsh+dlAvk
nrzAcRK02ZHMKIazi/fJaMPXb3HaZqZMXGwJ0Lsgn1UAT8hHCmqCg11F8iajzBoV
aiCEhfMbEYDM9DEkZs850IlfGKgIUgB30XgxSzGzdOLBqbuCV8oG6je2WxxtUygE
I68H2Ctpc/9hZOuCCq9RRfiVDpJMsMkDgjg+EP2Osefznt5KwcFw87vaV/v2iqzx
IGuUJCCo5JpHX/YIMsbRHLf0KlPXqycaaMO2qzinzmsXm7vZnlXu+oDGXFmNSZAt
dw62DSnYoHsOO5paMHfCqFODDiDQheek3bTAY9BmTOMq+Ab/fkKVz9CpQR2jOnMl
vdNmK3In2q/1q6mNazcl
=J+jN
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
