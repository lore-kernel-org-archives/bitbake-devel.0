Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1UQl0B-0007KX-5J; Fri, 12 Apr 2013 22:55:20 +0200
Received: by mail-pb0-f49.google.com with SMTP id um15so1585155pbc.22
	for <multiple recipients>; Fri, 12 Apr 2013 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=U3W5E+43JRmvnNmNoHhWxGlF2xiOMBWTU7WZBPUmi6o=;
	b=gGcMGr5JEnrk+NpWalJ0fEu3xu8ddRm3mNpHCb2sLx+IPBAIKBTZ4Pq0RXEV1mW09F
	Otm9R0y6Uz0iRXW5b+B9kRRj4/Jh2PUBkyu+f4JTzz1uBGZms6wcfJEkTg1eDzrbbD/g
	eVcWsj+/q58fzsBv/TboD/1kicMhpLkWH0VnTp08rsAERF8oQRyOlnmQ0j+cqdwx1cUE
	fPk02ldtLoYEfNeITrwPNy5D6Lq99tzyni+1+pxcMlGpy7jAY11bdwdUF7NWQSSbW7/D
	l5iy/h/ulWayqCq5hq4HNe/GdIh7PvM1bjLyxeytGTGbHG9xMSweozRZSD8MxvfVne1L
	/y/w==
X-Received: by 10.68.198.69 with SMTP id ja5mr16939852pbc.183.1365799073398;
	Fri, 12 Apr 2013 13:37:53 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id gi10sm9780004pbc.40.2013.04.12.13.37.50
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Fri, 12 Apr 2013 13:37:52 -0700 (PDT)
Date: Fri, 12 Apr 2013 22:37:46 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
Message-ID: <20130412203746.GW2477@jama>
References: <20130411133031.GF2477@jama>
	<CAHUNapRzKJrofFbKX2=5rJZJxSdo+S+5c38GHkp0J8Mhz=C+sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHUNapRzKJrofFbKX2=5rJZJxSdo+S+5c38GHkp0J8Mhz=C+sw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: Checksum failure encountered with download
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
X-List-Received-Date: Fri, 12 Apr 2013 20:55:35 -0000
X-Groupsio-MsgNum: 3378
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kLdbqvpuLRxNeSq5"
Content-Disposition: inline

--kLdbqvpuLRxNeSq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 03:44:41PM -0400, Trevor Woerner wrote:
> Sorry for not noticing this sooner.
>=20
> On Thu, Apr 11, 2013 at 9:30 AM, Martin Jansa <martin.jansa@gmail.com> wr=
ote:
> > My proposal is to add md5sum of downloaded file to ChecksumError and
> > rename it to <file>.<md5sum> in "if isinstance(e, ChecksumError):"
>=20
> Would it be possible to make this behaviour configurable for those who
> might be concerned about disk space? Or perhaps while renaming and
> saving it, also move it into the $TMPDIR directory and/or tie this
> feature in with rm_work?
>=20
> I'm just thinking that over time one's DL_DIR could potentially become
> rather cluttered with lots of failed downloads. Only some people would
> be interested in seeing the failures and the rest would have to remove
> them manually. I'm also thinking of the scenario where the DL_DIR is
> shared/sync'ed among a group of people/computers; that could add up to
> quite a bit of data to share.

I can make it configurable, but I think that bad-checksums should be
only in few exceptional cases, while package upgrades are common.

That said 90% of my downloads directory are old versions I keep just to
be able to recreate old builds with upstream sources already gone and
now I've one renamed bad-checksum tarball from evas-1.7.6.1...

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--kLdbqvpuLRxNeSq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFocJoACgkQN1Ujt2V2gBxOaQCgjc+8L4XjvzdMWErow93o/TJL
RksAn2qWj6BAAjCmr2mz0ZrFKpjRCjGh
=6n6R
-----END PGP SIGNATURE-----

--kLdbqvpuLRxNeSq5--
