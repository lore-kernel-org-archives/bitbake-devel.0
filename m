Received: from mail-pa0-f49.google.com ([209.85.220.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UZq4X-00071J-MA
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 May 2013 00:09:24 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so810393pad.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 May 2013 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=qhfME2VfP7rGQ7mXgfC/7end86apcbFxyjxItenRTtU=;
	b=WHanzSuPydeD3ql93K/wKf09Mu6BYfANkcm5L7wM9dBk1SLwNRfxyHKX1j1RaCwr/z
	6nDxYsVkFk/HTFAiJE65LpITIabtP8qoqLEfHI3zL0hpkvffsTqMZJXY0nn7qRKRFejY
	i50RG22BTKxxt0oo1dKQJTcMDQ6VEBVOaksfnwY6cqcUOJvL013HDqN/AFuRNCAJbk4h
	BL4cvNO05Zc6IRKVKS3+G0Ps8RHScUer0WIOgdUM1zsi9ZJ+6lCMib+cZf4RakMRlGG/
	Va8YeIFngsi5uTzVz/6++IdUvZqjll1ntqRKRdBdmlgJ+IMphhy2TJcclDc30Yneho7e
	l+Eg==
X-Received: by 10.66.25.80 with SMTP id a16mr4900686pag.97.1367963479548;
	Tue, 07 May 2013 14:51:19 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	dg5sm29669218pbc.29.2013.05.07.14.51.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 07 May 2013 14:51:18 -0700 (PDT)
Date: Tue, 7 May 2013 23:51:08 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20130507215108.GA3188@jama>
References: <20732985.qIsTObyanK@helios>
	<1367944760-16756-1-git-send-email-Martin.Jansa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1367944760-16756-1-git-send-email-Martin.Jansa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCHv3] git: remove symling before updating mirror tarball
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
X-List-Received-Date: Tue, 07 May 2013 22:09:27 -0000
X-Groupsio-MsgNum: 3435
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 06:39:20PM +0200, Martin Jansa wrote:
> * with read-only PREMIRROR (e.g. mounted over NFS or CIFS
>   and referenced as file:///mnt/premirror) we cannot use
>   BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
>   files later became just symlinks to read-only location in PREMIRROR
>   (it works fine on first build and for new components, because
>   at that time there isn't tarball on PREMIRROR yet).
>=20
>   ERROR: Fetcher failure: Fetch command failed with exit code 141, output:
>   tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-on=
ly file system
>   tar (child): Error is not recoverable: exiting now

This one is tested and I would like to get it also in 1.16 and 1.18

Steps to reproduce the issue (without redownloading anything big)

# mv downloads downloads-ro
# mkdir downloads
# mkdir tmp-eglibc/downloads
# sudo mount -o ro,bind downloads-ro tmp-eglibc/downloads
# sudo mount -o remount,ro tmp-eglibc/downloads

conf/local.conf:
SOURCE_MIRROR_URL =3D "file:///OE/oe-core/tmp-eglibc/downloads"
INHERIT +=3D "own-mirrors"

# bitbake -c fetch qtbase
# ls -lah downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.gz=20
  should be a symlink

bump SRCREV in qtbase_git.bb to some revision not included in
git2_qt.gitorious.org.qt.qtbase.git.tar.gz

# bitbake -c fetch qtbase
WARNING: Failed to fetch URL git://qt.gitorious.org/qt/qtbase.git;branch=3D=
stable, attempting MIRRORS if available
DEBUG: Fetcher failure: Fetch command failed with exit code 141, output:
tar (child): /OE/oe-core/downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.=
gz: Cannot open: Read-only file system
tar (child): Error is not recoverable: exiting now

apply this patch
# bitbake -c fetch qtbase
works fine
# ls -lah downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.gz
-rw-r--r-- 1 bitbake bitbake 176M May  7 23:41 downloads/git2_qt.gitorious.=
org.qt.qtbase.git.tar.gz
is now proper file instead of symlink

> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 052802e..6175e4c 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -217,6 +217,10 @@ class Git(FetchMethod):
>      def build_mirror_data(self, url, ud, d):
>          # Generate a mirror tarball if needed
>          if ud.write_tarballs and (ud.repochanged or not os.path.exists(u=
d.fullmirror)):
> +            # it's possible that this symlink points to read-only filesy=
stem with PREMIRROR
> +            if os.path.islink(ud.fullmirror):
> +                os.unlink(ud.fullmirror)
> +
>              os.chdir(ud.clonedir)
>              logger.info("Creating tarball of git repository")
>              runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(=
".") ), d)
> --=20
> 1.8.2.1
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGJd0wACgkQN1Ujt2V2gBxULwCfRVbIbZblyaENDPaRlJiPtRIF
TUAAnj6eKp3tRYs5H10PyIfQO4NOnjEQ
=oH+a
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
