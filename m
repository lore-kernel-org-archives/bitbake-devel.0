Return-Path: <eren@hambedded.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id 58AF1608CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 May 2013 19:08:50 +0000 (UTC)
Received: by mail-ea0-f179.google.com with SMTP id z16so743321ead.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 May 2013 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent
	:x-gm-message-state;
	bh=VBRzDX85fs9coPJeUQ+mJbM3Ewy2YLbY5SfyY6jyfnw=;
	b=EpaaZW3Hf4EUcyXhliCrbtiJ6sW6Am9p32XgQPwHszNIRCwZ7KJXcpdfW6Tf1qpZGN
	CR1oAzvg++X//7xIdFKM+yI8zN0AYH/yeUgFD7AIO/UcaOfi0EgzxnSUije+4/C/D2+5
	5bwozUTXDC3Ezu8TXdLa0v1XC5I6oof8LDSHAiyJx+Al95gEHiZoBTpkJjAm3KdnVPT7
	zvF/jQy1ndta83y+7PoIP3xMyb0eWFHs92R/i4gp9T9nIYp50dQOnyt8WGzKShGRfq50
	wAoGnAOhfA93eJ1XfVip7mOo5fj3grDQ0p0usSjhejnJn128R0QxZNzQldYyeWtJWG5q
	M1Wg==
X-Received: by 10.14.4.3 with SMTP id 3mr10876281eei.59.1369940930196;
	Thu, 30 May 2013 12:08:50 -0700 (PDT)
Received: from gmail.com ([46.197.0.81])
	by mx.google.com with ESMTPSA id e1sm27851476eem.10.2013.05.30.12.08.48
	for <multiple recipients>
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Thu, 30 May 2013 12:08:49 -0700 (PDT)
Date: Thu, 30 May 2013 22:08:40 +0300
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: "William M.A. Traynor" <wmat@alphatroop.com>
Message-ID: <20130530190840.GA13314@gmail.com>
References: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlQTJQ48yseZjG1lH6tjMunrcO7ytO58VnpFPKUeFLV9z1XGKukrC/5HaTrCPgrW9vgQlhC
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Hello World example for BitBake Manual
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 30 May 2013 19:08:51 -0000
X-Groupsio-MsgNum: 3510
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 01:28:11PM -0400, William M.A. Traynor wrote:
> In researching and trying to work through a Hello World example for
> inclusion in the BitBake Manual, I've been able to reproduce the
> examples described in the following thread:
> http://www.mail-archive.com/yocto@yoctoproject.org/msg09347.html
>=20
> and in the following blog post:
> http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/

Hello,

I tried to be comprehensive about how OE works in "From bitbake hello
world to an image" post. As Paul suggested, it would be detailed to
include in bitbake manual. However, I would be happy if it was
referenced in the manual :)

There are still some parts that need to be fixed in the document. They
are not show stopper but I haven't got time to fix them.

If you have any suggestions or questions regarding to the post, please
feel free to send an e-mail to me.

Regards,
Eren

--=20
    . 73! DE TA1AET
      http://linkedin.com/in/erenturkay

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJRp6O4AAoJEOM7bMm6HhcTjXEP/iY4Nif1SbQVERmzo3TGQPly
u6TRocRypW4ax8mm9OM317acpCeOZu7rxPP6RG0GETX8gbAJdXc3dBLFwgxfG3xr
v6ufgCA1ErBMCesGqvMGThNM7DQ/1HmFZMdE3PwU/JNDPp4nRSDASkIJtVxci5ge
PVx+OYiwIfAalbXo/jsc0qYntYf0Rqwr9CHh5+WfE/XutgfrbFYC542DjRC9BLo8
CZHmF3HnroG+AkLCKPl9lvKrEYfhYAd3bamn4crPYcv3xiDzeBjXZL5bzs/l7r+X
h3N25GB9pVewt5RmAm90t75+ZGkUMwMcgKVroybjcrjII4braNe9zpskf3SQlJcu
rSAGicWzd5426yr/VVClpJ/yVFvpLtoi9IYzJu7JaRS51i8NKohEaRhjUiG5Qwle
RXBrmMem/ibzxQj0iUUfsdvnhpv9PhA1MltJu+JibhPgh80ExmPDwbcCWxWnp+6E
+h23pSNmph7UH3k0MASmMmRorZDJgfDEFRCWO4iwhsnFv+9KNhGTpkMsDnX59LTB
LKW/iZyrSGp4Hxlcy09R62e4sILh9KYTqFUeKJRP0DG9ymfidIRV0dwsTlNu3iLD
ANrvTpH7mWTrs1Q1wTcvbfN8veet1zSbKZIa5uNNEyruom5ICJzWjqJAybWhiGqI
KJeoV9G4t9TTEcsw8Efg
=oMq7
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
