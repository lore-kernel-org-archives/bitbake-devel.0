Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1UQHr9-00063c-7y; Thu, 11 Apr 2013 15:48:05 +0200
Received: by mail-pd0-f174.google.com with SMTP id p12so854165pdj.5
	for <multiple recipients>; Thu, 11 Apr 2013 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=dBcZAF4fFm1C35f9+6Y9bim+6XwZobel0H0ppYFOGcY=;
	b=wdtuN3/HimWsrBhNOv/IBsRvKDEneIsSAjKvj40CIlddQIfcMZpyt4dMhAOb5QYrXk
	W3QmstNh0KtmYw97132UGg9GjVZe7zenwP2hopiPYbc7e9eIWLIypxTRDoGj070MRkj0
	Aze+Bxz3oTViB2xgzUTeW+IqgM+c1CzdNySsLktSX8hfbPVGta5wFmP+PiP3yOT97NKh
	iEItQ09JvLmS8qTTnTcnQ4yQiD0PVNoqxxM38XHr/WYbDqVi4keBx20zTh+xRh8o/OnD
	ChsIndnlbOVgmakBKn5Jbm4Rd9wE/Lgz5iN5bihmnyHOKQpPLFT85MgfaGbiZ3q7kfm8
	NTJg==
X-Received: by 10.66.72.3 with SMTP id z3mr9539778pau.125.1365687039445;
	Thu, 11 Apr 2013 06:30:39 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id qh4sm5018877pac.8.2013.04.11.06.30.36
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Thu, 11 Apr 2013 06:30:38 -0700 (PDT)
Date: Thu, 11 Apr 2013 15:30:31 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: openembedded-core@lists.openembedded.org
Message-ID: <20130411133031.GF2477@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Checksum failure encountered with download
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
X-List-Received-Date: Thu, 11 Apr 2013 13:48:26 -0000
X-Groupsio-MsgNum: 3373
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline

--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when fetcher fails with ChecksumError it shows error like in subject and
tries another MIRRORs

Would anyone object to keep fetched source with wrong checksum in
downloads directory (renamed so it does not conflict with file with
correct checksum downloaded later)?

Right now it just removes the file:
                        # Remove any incomplete fetch
                        m.clean(ud, self.d)

The problem with this is when upstream repacks some archive I would like
to be able to compare old tarball and new one.

My proposal is to add md5sum of downloaded file to ChecksumError and
rename it to <file>.<md5sum> in "if isinstance(e, ChecksumError):"

Does it make sense (should I send patch for this)?

FWIW: Emerge in gentoo does something similar.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFmuvcACgkQN1Ujt2V2gBxm+gCfURhJs3bOxkZT4MnPkhxzB5cA
1SgAn0OMSw42C27Sv9OoDOiE0obbLe1T
=8VEK
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
