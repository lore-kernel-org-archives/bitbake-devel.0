Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R5YVi-0006sx-P2
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 09:43:26 +0200
Received: by bke11 with SMTP id 11so23404808bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2011 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=RIWaMfkvuyFGDKd8VPwaaB4AlZakkpc6mBQelYqs2RI=;
	b=e0D3eELH8Jmp3ZOj+BcZxaI7+zzXyU542yBG6LiL3WZAZRiwkUnhItkkrXXEGtyc/O
	ALfBR0+f2dG17dJpgfOAV6W7B4c0DQTX5uL5wEmnVlEXURtb+aFHhtcUqTmDPuuUKYJ7
	/4a8vnj0XFSIMj19K049zQJSnwrgoqZiBMk1c=
Received: by 10.204.138.131 with SMTP id a3mr1409774bku.179.1316417890947;
	Mon, 19 Sep 2011 00:38:10 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id y8sm13084155bkb.4.2011.09.19.00.38.08
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 19 Sep 2011 00:38:09 -0700 (PDT)
Date: Mon, 19 Sep 2011 09:38:02 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20110919073802.GA19168@jama.jama.net>
References: <cover.1316158579.git.Martin.Jansa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <cover.1316158579.git.Martin.Jansa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH 0/3] Small fixes for fetch2
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
X-List-Received-Date: Mon, 19 Sep 2011 07:43:26 -0000
X-Groupsio-MsgNum: 497
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2011 at 09:37:24AM +0200, Martin Jansa wrote:
> The following changes since commit 2d5c71ae78b13e935548fe6ff5174b1c09b307=
7d:
>=20
>   fetch2: export LD_LIBRARY_PATH (2011-09-16 09:27:12 +0200)
>=20
> are available in the git repository at:
>   git://gitorious.org/shr/bitbake jansa/pull
>=20
> Martin Jansa (3):
>   fetch2/git: fix typo logggin/logger
>   fetch2/git: be more carefull in _contains_ref when checking git log
>     output
>   fetch2: export LD_LIBRARY_PATH
>=20
>  lib/bb/fetch2/__init__.py |    2 +-
>  lib/bb/fetch2/git.py      |    7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Hi,

Is there any reason why this wasn't merged and this=20
http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=3D38a598731b49c8a0b=
a0ede570adc33eb1e848235
was merged instead?

Notice missing debug level as first param..

Regards,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk528VoACgkQN1Ujt2V2gBwgHACfYGYpyFA4/lfVIFJdC8QEyech
BQsAoIDIW9lt3WAwVG5SzvbYmV377PUY
=t3+J
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
