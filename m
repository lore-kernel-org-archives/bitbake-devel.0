Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UXC6N-0002bt-Ng
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 17:04:24 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz10so393528pad.16
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Apr 2013 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=z7znqxvowCSvW1fVN4vruqCTVqK0uAa8jGSzcOo3f38=;
	b=P6pZRPsSsz9wjC4La5OpZQCPwO28POo5JI36bLjnTE69lBe6WS0idXdMnh5yTTsuRt
	yZAyJeYRq4PwK1JmOAVKvLmaytOmRb23UHEYYWDhZwdPKtx8ZqGyZx7I9MaIdnZD10Dd
	Fj0sbD7sPyCza3TDoORtRptA09AKDvoS1uv65HTKJS5aKWghSOL6EQI0/luB9mbe0kJZ
	NIJGITpzzAn+HlRP2AXCT2lG26JO1GEGWP1NYDB0tLBYgx7ashal0b9PwUq4FDcu9LkO
	RIcJ226gHplR6Ze9C5RK12gsJEtpISs27/gfhUymax6I1iqiohap4i5nVCFv5O23KOEu
	sj0g==
X-Received: by 10.66.157.106 with SMTP id wl10mr10699091pab.163.1367333188353; 
	Tue, 30 Apr 2013 07:46:28 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	ak1sm28794677pbc.10.2013.04.30.07.46.25 for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 30 Apr 2013 07:46:27 -0700 (PDT)
Date: Tue, 30 Apr 2013 16:46:42 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20130430144642.GD3184@jama>
References: <1367319160-19785-1-git-send-email-Martin.Jansa@gmail.com>
	<20732985.qIsTObyanK@helios>
MIME-Version: 1.0
In-Reply-To: <20732985.qIsTObyanK@helios>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC] git: add BB_FETCH_PREMIRROR_READONLY option
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
X-List-Received-Date: Tue, 30 Apr 2013 15:04:35 -0000
X-List-Received-Date: Tue, 30 Apr 2013 15:04:35 -0000
X-Groupsio-MsgNum: 3421
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline

--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2013 at 01:57:42PM +0100, Paul Eggleton wrote:
> On Tuesday 30 April 2013 12:52:40 Martin Jansa wrote:
> > * just RFC, because I haven't even tested this change,
> >   use it only to describe the issue and discuss it
> >=20
> > * remove symlink to ud.fullmirror when BB_FETCH_PREMIRROR_READONLY is s=
et
> >=20
> > * with read-only PREMIRROR (e.g. mounted over NFS or CIFS
> >   and referenced as file:///mnt/premirror) we cannot use
> >   BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
> >   files later became just symlinks to read-only location in PREMIRROR
> >   (it works fine on first build and for new components, because
> >   at that time there isn't tarball on PREMIRROR yet).
> >=20
> >   ERROR: Fetcher failure: Fetch command failed with exit code 141, outp=
ut:
> >   tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-=
only
> > file system tar (child): Error is not recoverable: exiting now
> >=20
> > * maybe we can change the default behavior and always remove symlink
> >   without introducing new option
>=20
> Personally I think it would be better to do the latter.

Only case when keeping old behavior is IMHO desirable is when someone
is using file:// and wants tar.gz updated in original location (e.g. to
rsync less from downloads directory after build).

But it won't update all (e.g. new components which don't have symlinks
yet) so rsync is still needed and usefulness of such requirement is quite l=
ow.

Cheers,

>=20
> Cheers,
> Paul
>=20
> --=20
>=20
> Paul Eggleton
> Intel Open Source Technology Centre

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlF/2VIACgkQN1Ujt2V2gBwqMQCeOtCwgZc6Nxfr0SvbUyZe7pKY
S+4AnjJXEcCnAyCwUkycm7YjMsggmYMu
=rriv
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
