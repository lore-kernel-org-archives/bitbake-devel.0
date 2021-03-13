Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.3137.1615663114747346311
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Mar 2021 11:18:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZHTUowoB;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so17106816wmi.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Mar 2021 11:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qQLxTzoCcGQzJr2swH4IP9BoKLPvu5vy4Xy/t9Gv9Tc=;
        b=ZHTUowoB5S7mapcFIFAzzqYLWUOkX+7JI5l/+No230hs51EiQbVXI51I0TDkZjaC8c
         Fm5JHH9B96hb8kuYMlNCAIG3NK+/wnaTX70z143bKxm8dyvgeE9Ro7zCCLGUJl5rjhPN
         TCDE9Hi9PO2RN8EPojWpWTP/utqeC+5HEvlAR1uNiMtbOrjoradSsGUNkto2IDfNJmae
         DqcYG+o+LWXMfbd+aP4FipeTng047iTKnVuM2FA9HHbeYnNZ3vw/eik2QKE0pHOVhf8r
         KcG4UYcgJOoPBPDU5048vWpele9suEb4oPYjMBaGHjlxc5S6S+ZcHsTD98ZSBuPCBCxw
         LzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQLxTzoCcGQzJr2swH4IP9BoKLPvu5vy4Xy/t9Gv9Tc=;
        b=VmyXQLgdPIMeC17h2FWkAVHpifJvVY3Nsgk/WudTfoKSGoMTSFvmWBic1gQCWWoYrf
         7f/SXZ6FG1GvuuaoDyyyV7NxkfyUR6LWHujisvuYCZzdpGSKF6MbOsgm5fS/256O3H9l
         NcNSFLIdXbvfy4ho7VOghub66Glo8rj+OlGn/zigETE9mvCBJqkRoeSGcSAgj528YCOJ
         yXbIV4g03L2Snrk5qht9QY5yNey8YIeEHhKYypNAS+Em+mlZOzQWl5KhdXmtBsUxDA5v
         /U66Gc5eD6XkqkZrTFGWg2NJWUDHqRQ+RoS50WiTbswW18TrIFCaCz5laYvoxez2191L
         gQ9Q==
X-Gm-Message-State: AOAM5318AzM24x3gyFyZL84u9duZa+jI9PRkJXA6UFQQMEdZSJ16DOKb
	cpb+dJHpVUYBORBMqp7x4KI=
X-Google-Smtp-Source: ABdhPJyguS7KYCaKj2QIrzR08ekUtT9CzbwFCjTOoRkkvcbo6xXYtuYuEfT97vciHSOG7ZHQHKDaJQ==
X-Received: by 2002:a05:600c:2d42:: with SMTP id a2mr19124066wmg.77.1615663113125;
        Sat, 13 Mar 2021 11:18:33 -0800 (PST)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id f14sm7344991wmf.7.2021.03.13.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 11:18:32 -0800 (PST)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Sat, 13 Mar 2021 20:18:31 +0100
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Message-ID: <20210313191831.zii2a432aws6y6lq@jama>
References: <cover.1615662134.git.steve@sakoman.com>
MIME-Version: 1.0
In-Reply-To: <cover.1615662134.git.steve@sakoman.com>
X-Groupsio-MsgNum: 12105
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjmorhtmqsc5cp2j"
Content-Disposition: inline

--xjmorhtmqsc5cp2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 13, 2021 at 09:04:50AM -1000, Steve Sakoman wrote:
> Please review this next set of patches for dunfell/1.46 and have comments=
 back
> by end of day Tuesday.
>=20
> Passed a-full on autobuilder:
>=20
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1962
>=20
> The following changes since commit e0dd20a006ce6fdc656e6be6ac581e93e2ed4a=
95:
>=20
>   __init__.py: Fix bitbake debug log handling (2021-03-09 00:03:26 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.openembedded.org/bitbake-contrib stable/1.46-nut
>   http://cgit.openembedded.org/bitbake-contrib/log/?h=3Dstable/1.46-nut
>=20
> Richard Purdie (2):
>   runqueue: Fix task execution corruption issue
>   runqueue: Add setscene task overlap sanity check
>=20
>  lib/bb/runqueue.py | 7 +++++++
>  1 file changed, 7 insertions(+)

Following fix from master might be useful for 1.46 and 1.48 as well.

The bebef58b21bdff7a3ee1fa2449b7df19144f26fd mentioned in commit message wa=
s introduced in 1.40 and I've included this
change to all my builds since it was sent to ML and haven't seen any issues=
 caused by that (but cannot confirm that
it _completely_ resolve the hangs I was seeing after parsing issues).

commit 915330e1dbae1ee8fd9a0358decf2c294f771961
Author: Jan Brzezanski <jan.brzezanski@gmail.com>
Date:   Thu Feb 18 17:53:32 2021 +0100

    Force parser shutdown after catching an exception

    Commit bebef58b21bdff7a3ee1fa2449b7df19144f26fd introduced forcing
    parser shutdown as default in case of build abort.

    In this case bitbake sometimes hangs after facing error during parsing,
    waiting for child processes to finish. Killing it then will spawn zombie
    processes.

    Thus we force the shutdown after catching an exception.

    Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
    Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

--xjmorhtmqsc5cp2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCYE0QBQAKCRA3VSO3ZXaA
HLdUAKCTG5O3HVaXuch1GGTK6TdAm8kYvACfZ/+FVybaETRWa+ikEgy4Kf/3rqg=
=bMhj
-----END PGP SIGNATURE-----

--xjmorhtmqsc5cp2j--
