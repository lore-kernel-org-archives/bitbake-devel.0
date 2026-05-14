Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E3CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 06:55:37 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4926.1778741730827026325
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 23:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GFCH2pid;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-448528f4e69so4399869f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778741729; x=1779346529; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKrfuSkV3AtbrgsFEQsZ7R7NyTmJ6y3tcKcvcPEC21I=;
        b=GFCH2pidCfp5onG9rTWYlF79EqXfvOVzmZp1bORA4gWSVgP11tWgXEaSc/ACfbUaaJ
         tkMK47fFraJwLyNSGl5C0xdB2x5dzTt75Fm7br5aN8bochIzBUz8VUeOUSLzAX6Xcqge
         sOW5FoarLAL/BMRcKW0nOxbN7a6UOdyujwOAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741729; x=1779346529;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKrfuSkV3AtbrgsFEQsZ7R7NyTmJ6y3tcKcvcPEC21I=;
        b=BeeE2esgaJ+Qkh/AlU+DgUTZ+qKt7GVaRMC5/aW1DEzrulZQpUQdS/9d+PTkQxSfz1
         AKPwZtVVBxbAbog4WGkwvQtWLEQPcdZ2RNRm4AGGtmRup6MRDKAPPQKLeRalM4ZW/zvI
         nNfOcXyJz/bMqEPGozLKGGmXSyNFV7BITYcioKzVTasDHoDpS97cOPsjSHJ+YgqR250h
         T0lgXwN17Rdv6jlnpY9Zn+6fD9uq7JXIPwMvIt69OKwAiXAQxfCshFxRHH5CuNHMv0+q
         a2Gu6F0tc7iKGwkSK2KzHetpTqUU+/xN41IKLagbDerAuUtMJSMCmSB6lb5nrkfX1oqd
         weMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TSDdqpKAfwEIrLmH2nyJwYZzCatwl2kvtqkESOcS0Bt1k3rcGusQQGPb4DTwZgpN0AhxnkC29O3T6ISom@lists.openembedded.org
X-Gm-Message-State: AOJu0YzLckw5Lj53/WEjZZrSZb7E4gp7esM202iMsAj7xVtgUtN+OZnR
	gajXSv/K5cSg5n0ZqBZCwPZGxaoEJbLf4iT8F1ZHhQt/XQ03VxHz8xkKaLd2yW/iQuM=
X-Gm-Gg: Acq92OHRpdPx4r7My7iDm44rk8E7cJF9r40K5NRgamqryUgHkopgMkfLpJshbJpem0k
	r4gN3zantdQpx2DVe2eVphIAOFb3OulqoqyJfHpTS+w/iHmZUmmrTnSiWmWzfJgCNq0c8gg8EbF
	sQSpVtzt5msnUdoJfitWswx/vEKhIy7gh1rZSpSNk/Rwu4Kxejsx0QKg8n6q0OnpNJR7RduAOwE
	591PdjAWjaohxy1vjIDW73+7DdpNL5B8NlYGN9YDBeQmA61uXKog0wo+sA2rOPhIuPtWY8SQEDG
	HbXk//2q7JXHLp6v3HQ9NJ6Z5W02VX2d+uXK3W4Xuk2hZBojLNCcsTDoqt2vnaC/IYybRPyfRia
	68WHjrJz8wTasghjvdQ8SNSyDEFL0xX3RfCp3FgxX445Cziy9CW9g8v3Apuvs5VKQ/Ue1HkO5qb
	jRPnA+i6BL5jMBLvxcc6XrfNBhfDVYehv3sUNKTWdEn52k/cu9P09nJRxFc8bOEOybv3sn7N9Y5
	xDRE53GVH4MRA==
X-Received: by 2002:a05:6000:26c2:b0:45a:1b61:9f9a with SMTP id ffacd0b85a97d-45c580cdfccmr9996038f8f.1.1778741729085;
        Wed, 13 May 2026 23:55:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fdc9:4435:e57:8008? ([2001:8b0:aba:5f3c:fdc9:4435:e57:8008])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm4221229f8f.36.2026.05.13.23.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:55:28 -0700 (PDT)
Message-ID: <097843c651961a6f5156b4e6febfd3f9910e7a73.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch: Upgrade shown checksum to SHA-512
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 14 May 2026 07:55:26 +0100
In-Reply-To: <20260513144621.440431-1-JPEWhacker@gmail.com>
References: <20260513144621.440431-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 06:55:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19517

On Wed, 2026-05-13 at 08:46 -0600, Joshua Watt via lists.openembedded.org w=
rote:
> Regulatory standards for Software Bill of Materials like BSI TR-03183
> [1] are requiring SHA 512 as the minimum checksum for validation.
> Upgrade the checksum suggested by the bitbake fetcher to align with this
> requirement.
>=20
> Note that the checker has allowed SHA 512 as the checksum for some time
> now, this only changes the checksum that is suggested by tooling.
>=20
> [1]: https://www.bsi.bund.de/EN/Themen/Unternehmen-und-Organisationen/Sta=
ndards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr0=
3183/TR-03183_node.html
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f7d5dfe9a..1e78c4fda 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -35,7 +35,7 @@ _revisions_cache =3D bb.checksum.RevisionsCache()
> =C2=A0logger =3D logging.getLogger("BitBake.Fetcher")
> =C2=A0
> =C2=A0CHECKSUM_LIST =3D [ "goh1", "md5", "sha256", "sha1", "sha384", "sha=
512" ]
> -SHOWN_CHECKSUM_LIST =3D ["sha256"]
> +SHOWN_CHECKSUM_LIST =3D ["sha256", "sha512"]
> =C2=A0
> =C2=A0class BBFetchException(Exception):
> =C2=A0=C2=A0=C2=A0=C2=A0 """Class all fetch exceptions inherit from"""
>=20

This change will need a tweak to one of the devtool tests:

devtool.DevtoolUpgradeTests.test_devtool_upgrade_drop_md5sum

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3720
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3853

Cheers,

Richard

