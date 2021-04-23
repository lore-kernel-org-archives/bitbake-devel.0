Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.2069.1619195683542617321
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:34:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=cq9+arly;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id r7so36977914wrm.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Apr 2021 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9tYBwWhpB8xAlgjQ3uSAuxBbJiqFkiBekAjzTdZPoEg=;
        b=cq9+arlyHoxLZNWemecUq2YOhJDp3m7iZ7mGfGLAFSZzrXfns950Bk7qxNIh6dRES1
         Rwfp2Qb9IBDXWzKQWkEJiL8fv9VBKAC2C6mG1oOEpMYN5p///F5tC4TVSqDXPrP7Qj2m
         ASY/hhE02WB2JWtud6vYyb7JBxlkKcIMokLwFJpqqC1RIWryRXyeAoMhwTxtSB4cgkzq
         ZoJEIODymrv9Fq7f2WQvvYPRyfWJnxx7GHftWVNyPeFAdqp7BgGP2+r6B6/9WP3FYS8x
         6APUyP2BTesv8K+zs3FjRu7C8ImIBtH6V8eqSNFmjrrTwU0YPLUdIZU30b0DhiFbrSqf
         NxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9tYBwWhpB8xAlgjQ3uSAuxBbJiqFkiBekAjzTdZPoEg=;
        b=EKtCpGwOWbtUBs8PN10cqL2eBW9qH9EGlzWMhG3+JUF5tqVPwhcSSbBDiKet+B6skg
         o/um9RvI8rp3OA8NGe81WqGFdA36DhkHJI4ZQfSGp53OMT0Xt1xbEY+eQuDNd4U6YL5i
         FxdCXPx7zC20FmL2z3azk+fj02cFUr8inLVxq+jBAKcaM2taGwWyAFpfaVS4TcYSBxpc
         97A8O76M5aByuTsNdQb+i2nZsuawddhke3QzloxKNWcC9/y8NddF3uD1xHHcJnYge5fs
         r3Iot8Hx0zQlr5x2YUFRmNkAjfEmOURimlhcUZgJJsd16H1x4H7aW6lYdnA4sKcu94hZ
         WnUw==
X-Gm-Message-State: AOAM530nbkKWN3uHKG77Mu2ZINCx/CjcpdYeR5QFKyjtFK1vM3/0oBZn
	SPKb3j5WnLCLV+CLi757JOo=
X-Google-Smtp-Source: ABdhPJxIE2HGk0A3i119VphK6cW41PDuNe8ogoO1sKqb0PJZqBnxG8SaBKhAbZjOsZsGSxmKYmcZGQ==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr5638649wrw.426.1619195682086;
        Fri, 23 Apr 2021 09:34:42 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id i4sm10161969wrx.56.2021.04.23.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:34:41 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 23 Apr 2021 18:34:41 +0200
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] README: update/fix contribution guidelines
Message-ID: <20210423163441.zyojiy5w3b2kp3ao@jama>
References: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
X-Groupsio-MsgNum: 12241
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7xsuvdrxyqaexbq"
Content-Disposition: inline

--n7xsuvdrxyqaexbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrote:
> - Ask to CC the docs@lists.yoctoproject.org mailing list

it adds 2nd --to

which is probably fine, just doesn't match with commit message

> - doc/README: fix the command to generate the manual
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  README     | 5 +++++
>  doc/README | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/README b/README
> index 96e6007e..5034a9bf 100644
> --- a/README
> +++ b/README
> @@ -26,6 +26,11 @@ branch, type:
>  
>      git send-email -M -1 --to bitbake-devel@lists.openembedded.org
>  
> +If you're sending a patch related to the BitBake manual, make sure you =
copy
> +the Yocto Project documentation mailing list:
> +
> +    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --to=
 docs@lists.yoctoproject.org
> +
>  Mailing list:
>  
>      http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> diff --git a/doc/README b/doc/README
> index cbb5215d..1f8e0f6e 100644
> --- a/doc/README
> +++ b/doc/README
> @@ -47,7 +47,7 @@ To install all required packages run:
>  
>  To build the documentation locally, run:
>  
> - $ cd documentation
> + $ cd doc
>   $ make html
>  
>  The resulting HTML index page will be _build/html/index.html, and you
> --=20
> 2.25.1
>=20

>=20
>=20
>=20


--n7xsuvdrxyqaexbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCYIL3HwAKCRA3VSO3ZXaA
HLwJAJ4ll0JVEdOW4cRTH5Wvjjf6pV+AVACeO579qeVexCqRMdsgeedC/yF6Pb8=
=aJQP
-----END PGP SIGNATURE-----

--n7xsuvdrxyqaexbq--
