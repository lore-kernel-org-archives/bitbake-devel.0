Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77ACCD18F
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 08:27:36 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.10600.1726648052866497827
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 01:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=TTdYokCs;
 spf=pass (domain: baylibre.com, ip: 209.85.218.41, mailfrom: jstephan@baylibre.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso103447866b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726648051; x=1727252851; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEpiT5ZpDbQh3/3RTDDumCKI0vIY2yvEAv3gSpg93G4=;
        b=TTdYokCsKirQw41CC97GkHKcIEQLEYqqMMxinm+flNU6OJBKNLWuwoHdSYi3iuEExl
         P5a2K7qmARkn8PPESTtZoFJr1JwGYYufoUrxP+sWqf6z2+W4CjksKyAqKM5733V3R+tG
         LbDbBrx7+KTxDPa+HlvTL9gxh6PbAxzNzSf0H7eG3NEzfzfN5UBnf1jYkqd0Ir1ARME2
         MKKdvKdMv6C+yiq6dR1zbua7rPZpCDNjpZkbFvPKSi/DlizhdPIs33p/Se8UyaJqmYFI
         6ef1W7FscC9/D5qRrLm808IWJv7QN+UKZdxtSPFaSpg79I7GFmD3g69s9zpDgSDs/Y/0
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726648051; x=1727252851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEpiT5ZpDbQh3/3RTDDumCKI0vIY2yvEAv3gSpg93G4=;
        b=hBOOks6xIW3lrEnbqU7ZNWpC+QdU2LWGSKnKi2UufqFhB1PR7F8y+gN2x5RX/hGPZL
         auGCYn6t0VbGTpt4uRKJaRxgYKpstTjtgiVaccUEFJCV4DOpuwFETDFjuTMTf1SqDD+a
         nF5AdEbSQf4orXJ71niQmRLQSdgNDYSbvugQRf4/8OrpEw/5PY53g/hhcF82iRxt4qAr
         +ds3lAFYQdTXKDKIVVTtD8oK5B1VhKjDv38sSIbsYgNSVR9EQCMOAgJTpQlL1nPppMKw
         +ME3VIdf2tINoWeH+hCQcFcspXQ1TBR5LeRXttX+wsAKh9L83xCGpzPpHlzytd9rinco
         E1IA==
X-Gm-Message-State: AOJu0Yzm2xcw9z90y+rac5PGDZ+M9vH+gphUnC9qobg/OC8+qFyIW7Fc
	kzU7lPnXtD81uUTJFDDtweQWP15AaJg5a3iQGJTRGUab/a0vMgDar8BbrIzA87+eJ9JlqJ+Pdjt
	7nL/ZphW8GS8OI9NGFRjs//OOgwl4LKNEYYiekw==
X-Google-Smtp-Source: AGHT+IEWvnMXrZsL/mLrRT02bWTWZH4HtbbE04Qz30BC9WQJJIDsErjFNUF8h/i44mXcB4tsoUm0C90m3y0bcPYeRDY=
X-Received: by 2002:a17:907:7421:b0:a90:9fb5:2c43 with SMTP id
 a640c23a62f3a-a909fb52dbemr336223066b.34.1726648050842; Wed, 18 Sep 2024
 01:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240917151157.780068-1-jstephan@baylibre.com>
 <17F610BFBC886D2E.8168@lists.openembedded.org> <CAEHHSvYBQQEdTCMdqTNUnswV+vbcb-i5gNwq_6y7Nufqx2hE4g@mail.gmail.com>
 <2a431a522b46432ac01a45dec140dd96815497d7.camel@linuxfoundation.org>
In-Reply-To: <2a431a522b46432ac01a45dec140dd96815497d7.camel@linuxfoundation.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Sep 2024 10:27:19 +0200
Message-ID: <CAEHHSvb06ou87GYjZk-ygmjs8xpj-1Lm7VPSe-FcYjGdGgheAg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: main: add choices to
 restrict -S parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 08:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16574

Le mer. 18 sept. 2024 =C3=A0 10:08, Richard Purdie
<richard.purdie@linuxfoundation.org> a =C3=A9crit :
>
> On Wed, 2024-09-18 at 09:54 +0200, Julien Stephan via lists.openembedded.=
org wrote:
> > Le mar. 17 sept. 2024 =C3=A0 17:12, Julien Stephan via
> > lists.openembedded.org <jstephan=3Dbaylibre.com@lists.openembedded.org>
> > a =C3=A9crit :
> > >
> > > Currently, available -S parameters are "none", "printdiff" and "locke=
dsigs",
> > > but there is no check on parameter, so user can literally give anythi=
ng
> > > to -S and it will act as if "none" was specified.
> > >
> > > Fix this by adding the allowed values in choices for -S parameter
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  bitbake/lib/bb/main.py | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> > > index 1f4313fa0dd..24758646eaa 100755
> > > --- a/bitbake/lib/bb/main.py
> > > +++ b/bitbake/lib/bb/main.py
> > > @@ -213,6 +213,7 @@ def create_bitbake_parser():
> > >
> > >      exec_group.add_argument("-S", "--dump-signatures", action=3D"app=
end",
> > >                          default=3D[], metavar=3D"SIGNATURE_HANDLER",
> > > +                        choices=3D["none", "printdiff", "lockedsigs"=
],
> >
> > Richard,
> >
> > Should I send a v2, dropping lockedsigs? Or should this patch be droppe=
d also?
>
> The comment applied to the series, I can't merge it as the handlers are
> metadata specific. I think we might need to ultimately move this
> functionality elsewhere and drop -S entirely.
>

Noted!
Thank you

> Cheers,
>
> Richard

