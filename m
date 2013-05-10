Received: from mail-ea0-f170.google.com ([209.85.215.170])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Uak1b-0004nV-RS
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 May 2013 11:54:52 +0200
Received: by mail-ea0-f170.google.com with SMTP id f15so603507eak.15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=P4n80aejLe+3cwKuVrCZesk+P4M7czmFt9v+DFzVTwo=;
	b=kC5dgSa0v5+p1X2V57agMKNHlHdSkbOl338KIZPzA6x5red8Pb1QhZ3lsotXg6+TjN
	cUyiySWDr34gG6ZIXvBSivest9fefTbqyKHafw6pxtXLQrlYLQL4263Lii1YmQWuy3RU
	X/4lwtj0fecdO8OCM+UyJBrlSTOb4DsTnO77RdvhKfW4VcoEuG2qsCVU/9GtCu5K4gwj
	L8Mf4immnfmQUMPKgrw7vMA176Umi1ABeDfB/3keRNmj/U9sWMFdzK/j8HNX1Q5YY3Rp
	Eoo1VMAjSSoHRz6YX7s61GroqjrzSQS83+zQ3e5TokXLDQCfp3DCJRoCJko1Yf0XKgo1
	hjhA==
X-Received: by 10.15.21.9 with SMTP id c9mr39824119eeu.7.1368178534446;
	Fri, 10 May 2013 02:35:34 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	bp51sm2424352eeb.5.2013.05.10.02.35.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Fri, 10 May 2013 02:35:33 -0700 (PDT)
Date: Fri, 10 May 2013 11:35:35 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20130510093535.GH3188@jama>
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
X-List-Received-Date: Fri, 10 May 2013 09:55:18 -0000
X-Groupsio-MsgNum: 3441
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline

--TKYYegg/GYAC5JIZ
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

cherry-picking 3627b02f77c78beedadadd77c619b9e5edaae076 works fine for
both, do you prefer to send patches with [1.16]/[1.18] in subject or
should I just wait a bit more with patch in master and then ping you
later?

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGMv2cACgkQN1Ujt2V2gBwG6wCZATKTe2JpBSAPiCRjKbl7am5o
Qd4An1HM0KCyc2OOPdCl3KVSrEqmVegS
=jAJ8
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
