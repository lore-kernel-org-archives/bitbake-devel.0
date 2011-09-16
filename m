Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4T24-0002H5-U3
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:40:21 +0200
Received: by bke11 with SMTP id 11so4579945bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=TC+eUnCpJpo4cAr7hBMfZaYiaaQaWe6EDT0BERm8haw=;
	b=WQ8w/3v+NgwVJBBEbVL8/uXXWqOmftJZ3ioXQq/jAXW7Zb1JC1ce2xzDClhda4pDum
	xirAKPIDK0miMTG6T5PTbYiyJ52Uw80UxAOdWri1Sqvq+ie2xg1HtMucozs3Y8VMebgk
	VUTsTO1KNSFuUMQTIaGmSjopTI1gMGwqJyAHs=
Received: by 10.204.3.207 with SMTP id 15mr586548bko.82.1316158508667;
	Fri, 16 Sep 2011 00:35:08 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id f15sm5497420bke.2.2011.09.16.00.35.05
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:35:07 -0700 (PDT)
Date: Fri, 16 Sep 2011 09:34:56 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20110916073456.GE7445@jama.jama.net>
References: <1316157115-13998-1-git-send-email-Martin.Jansa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1316157115-13998-1-git-send-email-Martin.Jansa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH] fetch2/git: fix typo logggin/logger
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
X-List-Received-Date: Fri, 16 Sep 2011 07:40:21 -0000
X-Groupsio-MsgNum: 487
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline

--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2011 at 09:11:55AM +0200, Martin Jansa wrote:
> ---

Ignore this one, will send it in pull-request with other 2 patches and
SOB line..


>  lib/bb/fetch2/git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 9a578ae..26236b8 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -280,7 +280,7 @@ class Git(FetchMethod):
>          # Check if we have the rev already
> =20
>          if not os.path.exists(ud.clonedir):
> -            logging.debug("GIT repository for %s does not exist in %s.  \
> +            logger.debug(1, "GIT repository for %s does not exist in %s.=
  \
>                            Downloading.", url, ud.clonedir)
>              self.download(None, ud, d)
>              if not os.path.exists(ud.clonedir):
> --=20
> 1.7.6.1
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk5y/B8ACgkQN1Ujt2V2gBxrNACgoyAhErskgIMhooM2IFiCeZff
GA0AoJfVg0ITH6MKcQodjCrPq6Uu5D/M
=ZTU0
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
