Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CB4CCF9E0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 08:58:23 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.27729.1761555499587024963
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 01:58:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Rypg4vYI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2919819f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761555498; x=1762160298; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBRwahL260MSwEKglssyJT1S4LztjhvnNMMRFRYD16E=;
        b=Rypg4vYICAfpu3UvduIR1ag6OJJ5JEidtQsfnS74sgehtSIPEibRCr0ZcM5eARsOW9
         j0FNdY/cCz4uZFfWAm3QDeZ9lK6jJ/E4l35qFPmxSF6wQqKhOKequ8eXyDHzfCDAAKST
         PTlMI/g5KT0R86I94Pujroc/wH+ek0YwdsK1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555498; x=1762160298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBRwahL260MSwEKglssyJT1S4LztjhvnNMMRFRYD16E=;
        b=EpProQKnmBmLNW07qieSeWHnXeudrmNW7t2KfA2mDr6LZoFPgwKOts1bZJKyedShWn
         PUnXedYULK7YV1+W1KVCc+HPMG+dR6XasQBshSd755IGFizIWL28xmgNQ0tKmNzqrNAP
         0gfvtZKu4nswQEWafG7yXn07qFMWE5vbkhhax8WW8DpzzAImt+8TsU8KEog+prc02lCi
         ZPQW5evDpv3D4QskmAae/RTIY+klvzH1lFlOTT3jIyZrIdxJjQFoS6SjrAMMTpt79a/d
         V15eJOF2IuqGMOwZPjq5m5y43jIf1ywuIIblWUO9HPBvGfZh/xYN1BdDFKGPXDY1iKmO
         MGgw==
X-Forwarded-Encrypted: i=1; AJvYcCWXk6tx+6bPWaegVNd6hRGw0kzOoU8ylnTdzey81llpmu3ObmK6EozmLWPjhKL7BKwnCeQMi7Jn/Qdv9fDU@lists.openembedded.org
X-Gm-Message-State: AOJu0YzDy7yVXPRPqDhKbl3vNxFdAMY/1KpDDmbzElOI+IlqCPQOIUSq
	lB/G8BuOz1PPw5MpAgAIiz3EBt1VlBjSNY0Ral0Uv4LF5MnPAe0bFKZC7l8xZnVqQxM=
X-Gm-Gg: ASbGncvVpOAOcsq5SCUbslDiAj0752+db+n5ST+ZI4mSR828U7Lf+vPENEWYOI7nWGM
	PiJBYSkXWtcsciSp1hVmpZvQa0n7F3cqMPM0CKUclT+qOluSDz4Fj/bq2C1ItyiaECGgCJSUegu
	9n1AgeEHtmaqNv59pOasFEvEt4iY9brKiLgEXpHyEOb/grhYKxMT6/R3WMp3c8jhgzE5sRV9Gdx
	DpxV9sBAzfjh3U/if5HeV+Owtp1RC0zsf6Gy2TOv0HD6ues5qZCvjMePdtJgbsPA2rnXjh9mZZv
	DGpG3S0ETr8oWHZg6jvNLZDI2arskxJBaPFp8xYYRzBPQzxvmr5cpCuE5vGD1ce20xOPjv/X69D
	zo6/EBzkrr+epNY9p7HpFaNoh7cHTARAYTA1r0rK0uT4Sh7KPxALeqxIidqp3VbALGDUkXbShrZ
	4whHzFU89sgLzg3tNmeJArtmzzoPspKSpCqEWzSlo75TzJtJVXATWb64hCmEc3nvwnqMO/dSbsd
	wGAHSC9dtU8tA==
X-Google-Smtp-Source: AGHT+IHSpS1jCMw9fd9A9KMU1EwmWXAO0x9L/VnsJASq6LC7zBZldI9HrPgXM0pJPm8NXzhE4+oqag==
X-Received: by 2002:a05:6000:41f0:b0:427:5eb:d82d with SMTP id ffacd0b85a97d-42705ebd878mr24504433f8f.17.1761555497853;
        Mon, 27 Oct 2025 01:58:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:16c5:d0d6:9af3:2bd2? ([2001:8b0:aba:5f3c:16c5:d0d6:9af3:2bd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm13050652f8f.28.2025.10.27.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:58:16 -0700 (PDT)
Message-ID: <fd1e8c06aa46063af275cebef8aa42eb897c55e0.camel@linuxfoundation.org>
Subject: Re: [PATCH] siggen: Fix dump of non-runtime sigdata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <paul@pbarker.dev>, bitbake-devel@lists.openembedded.org
Date: Mon, 27 Oct 2025 08:58:15 +0000
In-Reply-To: <20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev>
References: <20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 08:58:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18218

On Mon, 2025-10-27 at 08:25 +0000, Paul Barker wrote:
> If the debug code is uncommented in SignatureGeneratorBasic.finalise(),
> sigtask stamp file are created without runtime data such as
> 'runtaskdeps' and 'file_checksum_values'. If we then try to run
> bitbake-dumpsig on one of these files, we will see a traceback as the
> expected keys are not present in the sigdata dictionary:
>=20
> =C2=A0=C2=A0=C2=A0 Traceback (most recent call last):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/bin/bitbake-dumpsig", li=
ne 195, in <module>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output =3D bb.siggen.dump_sigf=
ile(options.sigdatafile1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", line =
1266, in dump_sigfile
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 computed_taskhash =3D calc_tas=
khash(a_data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", line =
1199, in calc_taskhash
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for dep in sigdata['runtaskdep=
s']:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0 KeyError: 'runtaskdeps'
>=20
> To fix this, treat these entries as empty lists if they are not present.
>=20
> Signed-off-by: Paul Barker <paul@pbarker.dev>
> ---
> Richard,
>=20
> This patch attempts to fix an issue reported on IRC last week [1]. It
> prevents the traceback, but I'll have to defer to you on whether the
> taskhash calculated without 'runtimedeps' and 'file_checksum_values' is
> meaningful.
>=20
> I guess an alternative approach would be to call calc_taskhash in a try
> block and not print out a task hash if the call fails.

Rather than compute a hash which will never work, we should just skip
calculating/printing it or print something indicating it can't be
calculated. I've not looked into the details yet but I will at some
point unless someone beats me to it with a different patch.

Cheers,

Richard

>=20
> Thanks!
>=20
> [1]: https://irc.yoctoproject.org/irc/%23yocto.2025-10-24.log.html#yocto.=
2025-10-24.log.html#t2025-10-24T11:09:20
> ---
> =C2=A0lib/bb/siggen.py | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 41eb6430122f..5355f499074f 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -1196,10 +1196,10 @@ def calc_basehash(sigdata):
> =C2=A0def calc_taskhash(sigdata):
> =C2=A0=C2=A0=C2=A0=C2=A0 data =3D sigdata['basehash']
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 for dep in sigdata['runtaskdeps']:
> +=C2=A0=C2=A0=C2=A0 for dep in sigdata.get('runtaskdeps', []):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D data + sigdata[=
'runtaskhashes'][dep]
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 for c in sigdata['file_checksum_values']:
> +=C2=A0=C2=A0=C2=A0 for c in sigdata.get('file_checksum_values', []):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if c[1]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if "./" in c[0]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 data =3D data + c[0]
>=20
> ---
> base-commit: 35a421cdcafb3595b9de5489ffdc567825400d26
> change-id: 20251027-fix-dumpsig-e945637ad89f
>=20
> Best regards,

