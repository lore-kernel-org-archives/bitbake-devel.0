Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1REKoY-0006Lw-Dl
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Oct 2011 14:55:10 +0200
Received: by bkat8 with SMTP id t8so524678bka.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Oct 2011 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=pwjrhECuLr8118PO43OArGuURbU8Bk5k7G3geRfKjks=;
	b=tvOqlAUr01/IJc0aQ7vuU46bX6XHjQHNbvnxqsNTa3bR/jWSVScGY7giXi0rUiR482
	cIsYBToQ6Rjw/ZI+/eNNF+mgP27S+0IihtDk2H7GyOsIIvdZGig6CQcmRuBgM2gzuIB3
	5O34rs5UrTvW4IqDtYFhbaQJpoa+OxvLYCemI=
Received: by 10.204.8.24 with SMTP id f24mr2652406bkf.64.1318510163250;
	Thu, 13 Oct 2011 05:49:23 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id e14sm3567539bka.0.2011.10.13.05.49.21
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 13 Oct 2011 05:49:21 -0700 (PDT)
Date: Thu, 13 Oct 2011 14:49:13 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Message-ID: <20111013124913.GB28525@jama.jama.net>
References: <cover.1318352470.git.josh@linux.intel.com>
	<63dc9197eb483863e1cec5e58f036b7493850787.1318352470.git.josh@linux.intel.com>
	<CABcZANksOeUAVw0EmcTBVK61NE8GoE8Xq=4yCZdkuihVB7FqUQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANksOeUAVw0EmcTBVK61NE8GoE8Xq=4yCZdkuihVB7FqUQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] fetch2: improve usability of checksums
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
X-List-Received-Date: Thu, 13 Oct 2011 12:55:10 -0000
X-Groupsio-MsgNum: 573
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2011 at 12:21:42PM -0700, Chris Larson wrote:
> On Tue, Oct 11, 2011 at 10:07 AM, Joshua Lock <josh@linux.intel.com> wrot=
e:
> > This patch improves the usability of checksums by only requiring one ch=
ecksum
> > be defined.
> >
> > Further, checksum verification will provide as much information as poss=
ible
> > at, rather than a bit at a time. No longer will you need to run fetch, =
see an
> > md5sum mismatch, fix it, run fetch, seen an sha256sum mismatch, fix it =
and
> > fetch again. If neither checksum is defined we now report both missing =
sums
> > at once - rather than one after the other.
> > Finally, if both sums are incorrect, we'll report both incorrect sums a=
t the
> > same time.
> >
> > Fixes part of [YOCTO #1399]
>=20
> Nicely done, the fetch/mismatch cycle was quite an annoying one :)

yeah, great, thanks!

finally it looks like=20
http://git.openembedded.org/openembedded/commit?id=3D353b4dc7223f8dd50fcf21=
d7c031b9dd91a724a2
again :)

Regards,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6W3kkACgkQN1Ujt2V2gBzEmQCgg3OaGf17jBINQUvsy6YcQ6ix
SAIAoIFyo2KkWoJKhMzYFTADsEmn5W2e
=2CDh
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
