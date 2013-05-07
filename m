Received: from mail-pb0-f51.google.com ([209.85.160.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UZqNY-0000Sl-S2
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 May 2013 00:29:04 +0200
Received: by mail-pb0-f51.google.com with SMTP id wy7so724447pbc.38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 May 2013 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=J2Az9RMdn8PXVqNLAdtP1VawX5UaiLR8gDHksg9q6jE=;
	b=WnNLqaJy0Ad8s9oOCahqtqCmUla9cH0dTKZ7eiqTU8lkxWPjoFagdcWnxCV4KEOdCf
	sRwxmO9Y8FtTvxDjW63NhBOZ7OAokg5cvfwNrsgOC4hbaubzQB8c3GZXpBYP+GyXiZKY
	bmMp5Rfo0colAFCkq8qHHCDwbwPjtdT+ZH8vcUPT5dofEqBTzfztjew/qTfPpbfmLRZo
	UakmTTR+aGlo3ARSL+OnHAe8TVlD20cFmxxkSlBgr6IXk+mGoy4YnaVNVTc0c2ksrWxu
	jrKSrHe+o4vRoY7WfuhJyQ9IiqttCZygjH+ruuN0pAiNsCFDD+npwgprPsjm/drDK/15
	Tx+w==
X-Received: by 10.68.170.66 with SMTP id ak2mr4388007pbc.123.1367964658707;
	Tue, 07 May 2013 15:10:58 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id 10sm865745pbm.0.2013.05.07.15.10.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 07 May 2013 15:10:57 -0700 (PDT)
Date: Wed, 8 May 2013 00:10:48 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20130507221048.GB3188@jama>
References: <20732985.qIsTObyanK@helios>
	<1367944760-16756-1-git-send-email-Martin.Jansa@gmail.com>
	<20130507215108.GA3188@jama>
MIME-Version: 1.0
In-Reply-To: <20130507215108.GA3188@jama>
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
X-List-Received-Date: Tue, 07 May 2013 22:29:08 -0000
X-Groupsio-MsgNum: 3437
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 11:51:08PM +0200, Martin Jansa wrote:
> On Tue, May 07, 2013 at 06:39:20PM +0200, Martin Jansa wrote:
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
only file system
> >   tar (child): Error is not recoverable: exiting now
>=20
> This one is tested and I would like to get it also in 1.16 and 1.18
>=20
> Steps to reproduce the issue (without redownloading anything big)
>=20
> # mv downloads downloads-ro
> # mkdir downloads
> # mkdir tmp-eglibc/downloads
> # sudo mount -o ro,bind downloads-ro tmp-eglibc/downloads
> # sudo mount -o remount,ro tmp-eglibc/downloads
>=20
> conf/local.conf:
> SOURCE_MIRROR_URL =3D "file:///OE/oe-core/tmp-eglibc/downloads"
> INHERIT +=3D "own-mirrors"
>=20
> # bitbake -c fetch qtbase
> # ls -lah downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.gz=20
>   should be a symlink
>=20
> bump SRCREV in qtbase_git.bb to some revision not included in
> git2_qt.gitorious.org.qt.qtbase.git.tar.gz
>=20
> # bitbake -c fetch qtbase
> WARNING: Failed to fetch URL git://qt.gitorious.org/qt/qtbase.git;branch=
=3Dstable, attempting MIRRORS if available
> DEBUG: Fetcher failure: Fetch command failed with exit code 141, output:
> tar (child): /OE/oe-core/downloads/git2_qt.gitorious.org.qt.qtbase.git.ta=
r.gz: Cannot open: Read-only file system
> tar (child): Error is not recoverable: exiting now
>=20
> apply this patch
> # bitbake -c fetch qtbase
> works fine
> # ls -lah downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.gz
> -rw-r--r-- 1 bitbake bitbake 176M May  7 23:41 downloads/git2_qt.gitoriou=
s.org.qt.qtbase.git.tar.gz
> is now proper file instead of symlink

There is one more interesting behavior with such setup where file://
fetcher is used in PREMIRROR

AFAIK it's completely harmless and also not influenced by this change,
but .done stamps for files downloaded from premirror are stored in
${DL_DIR}<path-to-local-premirror>/file.done, e.g.
downloads/OE/oe-core/tmp-eglibc/downloads/git2_qt.gitorious.org.qt.qtbase.g=
it.tar.gz.done

qtbase was recreated locally thanks to this patch, that's why it has 2 .don=
e stamps, one in
downloads, 2nd in downloads/OE/oe-core/tmp-eglibc/downloads/

qtdeclarative has only symlink and .done stamp in downloads/OE/oe-core/tmp-=
eglibc/downloads/

OE @ ~/oe-core $ ll downloads/*qt{base,declarative}.git*
-rw-r--r-- 1 bitbake bitbake 184015350 May  7 23:41 downloads/git2_qt.gitor=
ious.org.qt.qtbase.git.tar.gz
-rw-r--r-- 1 bitbake bitbake         0 May  7 23:41 downloads/git2_qt.gitor=
ious.org.qt.qtbase.git.tar.gz.done
lrwxrwxrwx 1 bitbake bitbake        82 May  8 00:00 downloads/git2_qt.gitor=
ious.org.qt.qtdeclarative.git.tar.gz -> /OE/oe-core/tmp-eglibc/downloads/gi=
t2_qt.gitorious.org.qt.qtdeclarative.git.tar.gz

OE @ ~/oe-core $ ll downloads/OE/oe-core/tmp-eglibc/downloads/*qt{base,decl=
arative}.git*
-rw-r--r-- 1 bitbake bitbake 0 May  7 23:41 downloads/OE/oe-core/tmp-eglibc=
/downloads/git2_qt.gitorious.org.qt.qtbase.git.tar.gz.done
-rw-r--r-- 1 bitbake bitbake 0 May  8 00:00 downloads/OE/oe-core/tmp-eglibc=
/downloads/git2_qt.gitorious.org.qt.qtdeclarative.git.tar.gz.done

> > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > ---
> >  lib/bb/fetch2/git.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 052802e..6175e4c 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -217,6 +217,10 @@ class Git(FetchMethod):
> >      def build_mirror_data(self, url, ud, d):
> >          # Generate a mirror tarball if needed
> >          if ud.write_tarballs and (ud.repochanged or not os.path.exists=
(ud.fullmirror)):
> > +            # it's possible that this symlink points to read-only file=
system with PREMIRROR
> > +            if os.path.islink(ud.fullmirror):
> > +                os.unlink(ud.fullmirror)
> > +
> >              os.chdir(ud.clonedir)
> >              logger.info("Creating tarball of git repository")
> >              runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.joi=
n(".") ), d)
> > --=20
> > 1.8.2.1
> >=20
>=20
> --=20
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com



--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGJe+gACgkQN1Ujt2V2gBw0/wCdEdyP+AiC5iHVzocCjPwASGQK
n08AoI4ozMpaJsrm9chthg+QR1O8XZKM
=uAs1
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
