Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f172.google.com (mail-ea0-f172.google.com
	[209.85.215.172])
	by mail.openembedded.org (Postfix) with ESMTP id 1C9E360FA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 14:23:35 +0000 (UTC)
Received: by mail-ea0-f172.google.com with SMTP id r16so1857726ead.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Oct 2013 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=27WW8xfATvq5k7qhSuHtzPYfQeIM1I9W/KJ8FVLtVHI=;
	b=rpGREK6m1yx9ezSXuERHDI1Q/W1kRRhRgmwj0A/AVEj+gnjfpjQvcBRD1rae5IkeXm
	yoWVveEiFOdVaLdQsn/Pb+xXgtH+htX0GV4gSdCRh/OmsRHRVd5nNYE1/FY37kNxKHrf
	VF8/ZIcPF4T9rmxRs61fS1CbCshK8D42Ph+FGb8AJZdlOmATZYBJEYc7ctwZLm1Xa6O6
	vSBjrhRfsHoy3kzmsBy8u4ufX9DyCzzDkz9k4ueJ8Wca6oDkuYDRqCRelIoD7IaZLAf7
	GLb+gJXHXEQBz+iAKFN/xa9sApMtHSn+xWCp2w/tNFYfn3f6uNrcyvTs26HREhvMTuHX
	MH4g==
X-Received: by 10.14.2.2 with SMTP id 2mr937575eee.92.1380896617506;
	Fri, 04 Oct 2013 07:23:37 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	d8sm28593787eeh.8.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 04 Oct 2013 07:23:36 -0700 (PDT)
Date: Fri, 4 Oct 2013 16:23:43 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131004142343.GK6240@jama>
References: <1380892492.18603.601.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1380892492.18603.601.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bin/bitbake: Catch establish connection log messages
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 04 Oct 2013 14:23:36 -0000
X-Groupsio-MsgNum: 4012
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline

--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2013 at 02:14:52PM +0100, Richard Purdie wrote:
> If for example you try "bitbake -m" with an invalid BBSERVER, error
> messages are not dsplayed. This change ensures logging is in place

small typo         ^
                   displayed

> to catch and display such errors.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
> index 222dabd..21a6c81 100755
> --- a/bitbake/bin/bitbake
> +++ b/bitbake/bin/bitbake
> @@ -297,8 +297,6 @@ def main():
>          server =3D servermodule.BitBakeXMLRPCClient(configParams.observe=
_only)
>          server.saveConnectionDetails(configParams.remote_server)
> =20
> -    logger.removeHandler(handler)
> -
>      if not configParams.server_only:
>          # Collect the feature set for the UI
>          featureset =3D getattr(ui_module, "featureSet", [])
> @@ -310,6 +308,8 @@ def main():
>          for k in cleanedvars:
>              os.environ[k] =3D cleanedvars[k]
> =20
> +        logger.removeHandler(handler)
> +
>          try:
>              return ui_module.main(server_connection.connection, server_c=
onnection.events, configParams)
>          finally:
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iEYEARECAAYFAlJOz28ACgkQN1Ujt2V2gBw8kACdHBhmXSMKRHTZyKU8jgjwLvHf
wnoAn2lsXWdDiFr/nrad1XGtNc+BPy8j
=JE2n
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
