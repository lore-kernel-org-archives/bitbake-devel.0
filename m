Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCBCCD18C
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 07:54:36 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.10127.1726646062052290363
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 00:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=O4joE09d;
 spf=pass (domain: baylibre.com, ip: 209.85.218.47, mailfrom: jstephan@baylibre.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d43657255so762575166b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726646060; x=1727250860; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtAlMiO1oCVWbbWR1qJ8jfylGANYu30aWP6Vfcf9HGg=;
        b=O4joE09dudRBwB7qJN3ZW3m02hibhudClLgii4+DtILhwL2a0EylnD8a5vnUj+dCOY
         +CHGaPaUSHAVLfgZ6eWns1HFPy+98U++1fC910G6in6otMhYP4iV1nGj6smi3olI31dD
         cYBkHw4KiUEMJZomFxCdpecv6eeE1Z58szW/BVSABKzdFniDT5NAEsFMAXdaRmzXtNKC
         baHppREHfG/laRcABQ5/d+/d1ZuKBbfq9wmz8CD+0zcrKmfFJyYZs8XlPDn702CibEhN
         DruSxrnANZWl4zPWq+js7H7IOHqFOJL45xUIiSoXqWgqvIgM1QOGbhwc5WE2Dy30eNMf
         m0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726646060; x=1727250860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtAlMiO1oCVWbbWR1qJ8jfylGANYu30aWP6Vfcf9HGg=;
        b=TNYW5vpmy9GJzM/4Fs+454QS7CU0K72qTCPp2JZB5BSv+9CeVF7YvsvKeNfoLjtIvQ
         HpjAykca06juSP25HX9idkFmY+unGkKi2moKKUsbDAnuB6VzrF7TrH+slJ7OJRsI46y2
         vrFH4W+pittmD0CoN4w+6pr1PJ3EhWreMIJtKmAWRAJRDJBdLcNx7600/YNOGGUN2Co7
         vBjzf5DgoALb2mp/sSubu2FtQu3+gRcIJjUIb2RrCi4y+NMdm1Vkeo0zP7oRS+m4m4XA
         bTi5VATOKTHG7mazqmRV3MBvxS5JtQ+XX1mqZYTPGkc0ujm9Eb3SklUX59UexxG7K5kF
         CKPQ==
X-Gm-Message-State: AOJu0YzVUPFK7ihUBkxap6FGEVtmQpXSS4dUNY+xn8g5DqMI2/JWNrqs
	CmfMBpUt5jwIVnbYAOhrYpjIoZK2kb9WSErSFwu4SD/KNK1SgqzkcnWu9xtrcU5Y/SMIq97hhTf
	bqTlG5Hk6g8+9lmxtakITey7ZBt7fPdUYUFPrng==
X-Google-Smtp-Source: AGHT+IGUVMXf6ZGI9T1Q0J4qIBtW4KOA3VJXOXfLNcyN8kUPJqOpOPLCodZGibuVY9BuYxsqkqEb/EOMjUPk+4jaAo4=
X-Received: by 2002:a17:907:f763:b0:a86:81b8:543f with SMTP id
 a640c23a62f3a-a90480cef74mr1613446666b.64.1726646060124; Wed, 18 Sep 2024
 00:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240917151157.780068-1-jstephan@baylibre.com> <17F610BFBC886D2E.8168@lists.openembedded.org>
In-Reply-To: <17F610BFBC886D2E.8168@lists.openembedded.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Sep 2024 09:54:09 +0200
Message-ID: <CAEHHSvYBQQEdTCMdqTNUnswV+vbcb-i5gNwq_6y7Nufqx2hE4g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: main: add choices to
 restrict -S parameter
To: jstephan@baylibre.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 07:54:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16572

Le mar. 17 sept. 2024 =C3=A0 17:12, Julien Stephan via
lists.openembedded.org <jstephan=3Dbaylibre.com@lists.openembedded.org>
a =C3=A9crit :
>
> Currently, available -S parameters are "none", "printdiff" and "lockedsig=
s",
> but there is no check on parameter, so user can literally give anything
> to -S and it will act as if "none" was specified.
>
> Fix this by adding the allowed values in choices for -S parameter
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  bitbake/lib/bb/main.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> index 1f4313fa0dd..24758646eaa 100755
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -213,6 +213,7 @@ def create_bitbake_parser():
>
>      exec_group.add_argument("-S", "--dump-signatures", action=3D"append"=
,
>                          default=3D[], metavar=3D"SIGNATURE_HANDLER",
> +                        choices=3D["none", "printdiff", "lockedsigs"],

Richard,

Should I send a v2, dropping lockedsigs? Or should this patch be dropped al=
so?

Cheers
Julien

>                          help=3D"Dump out the signature construction info=
rmation, with no task "
>                               "execution. The SIGNATURE_HANDLER parameter=
 is passed to the "
>                               "handler. Allowed values are none, printdif=
f and lockedsigs. "
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16566): https://lists.openembedded.org/g/bitbake-deve=
l/message/16566
> Mute This Topic: https://lists.openembedded.org/mt/108502729/4356723
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [jsteph=
an@baylibre.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

