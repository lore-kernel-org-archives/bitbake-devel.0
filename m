Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D56CA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:19:21 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.18512.1758100755869030850
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 02:19:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NwtObD8S;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7240eb21ccaso6467876d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100755; x=1758705555; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3zVOjbrHnGuHcOtactysngzhhGelECyp0+gfGpvJd4=;
        b=NwtObD8SPIOoDyPbLUGaSO6uyzvtDaZG2nAAz4iiF/p4Bx8qtElr0TzfbFcJxm7PHy
         hky+6Xw0yg357om5ARf81wbf5/yssiNSXsc5b3Pl7V6rglx+apj3HNBZoWS470qz0zPH
         aRsZpGyKR/vKRWcnGLveafi4QgyH1v29OpGYqRbEKvvp5XvQF++wEEWdEXDtHa2/MmlV
         XDVD2SN85T59PO92fZWmAsaaqOqLl5cjJs0/RmNMq1XSAS90LeVvN0InNEIXtgZzJSBl
         VurSzFYy+ppfQMdcMULc0l6kOBiQu6OpvJ5D0RRrSOlEI7fN91a2tXvhWQu7q3j7fW7U
         xrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100755; x=1758705555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3zVOjbrHnGuHcOtactysngzhhGelECyp0+gfGpvJd4=;
        b=JiuxkqgZ2hhJciLbK5vkY6nq2X4YK0Gh5ai5nOWe+iqYuHBEVOTOFZJrR1qnf66bit
         +DOdaGs8QeA/oanhKMH6ps3Xc5PpuZ+n3IH1CzCP1ORAeD3XzRK/yzPHFOGgTJ0REyul
         KNpKTFVMVRe/u4TyDilVYv29/5NEMCI67vbgI6lW3ZQKJKNR0BcfVJTZM3027Ub/G2pi
         n88yfWu4iDwOYd9rVhvNpI1VXH/I/W4m+L9zGNQSfcfrxjfIZYPrQ/CZG2942R9iGrcU
         p9FQGAGWDbTxxkeSEftdXh/pfLIfI1YIQSIy+fCrC6/lexTWNl5jmG6kFnC6meBaaafI
         3sLA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1PNzMr7up2YPVXDc4e2H2SmLAE1ommF/nYTwaxKEC4mEc78drp2fOJqrTfqX081XeVztmXHA7V33If3/@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzx2Sn4vR4gEMFaHIIVAWtZtCqyz1+Mpjp1yl18rj6jUUg0BtFe
	P/FTfDTJSVOWJXF3vnZNDhrBNHuaWB7s5ULPMfFEnaxN86Cm7vMKTrbHSs38iPY4ZebDKX68jKD
	j5LJWNxAgYi/wy+GUXztPa3H/yHD3DXM=
X-Gm-Gg: ASbGncvxi5m/+FoCx2wv+37i8HJsRgf1lht8EQbuzbDGJQvo7/7seqxRdN9yuWKMv9a
	1AiK93/ztk6oBY5ZeTAPf3ZMILKdG2V7HOJU9VEJOttebykpfQUky1jAsIw3APzh40MEVWzCu+i
	KGYFcnYkVp9VhjmHDDu7fAHSvoRZF3QlDcpFFR38DBQFxj5yjEIa08qYfZbEARpcFp0IdlM2del
	QUt78Urwswdw2ETgvbSneWbe54Qbqx3iM3i/xJGc+x3zWFPdoR0pTWhVjxOIP/ibIR8XvJSF4wx
	aRkipLJ69mGBDso=
X-Google-Smtp-Source: AGHT+IHY31oKyenDaLmdqjxkRyzU5wWP+AanC5ulSpG2gBeq6abHRkY2Spigl+4wA//L2mNUzKUtFYOVltw+NI7T7ps=
X-Received: by 2002:a05:6214:29c9:b0:765:5347:57ce with SMTP id
 6a1803df08f44-78ec7125870mr13874826d6.34.1758100754758; Wed, 17 Sep 2025
 02:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <tEoU.1758053094260077183.1RYf@lists.yoctoproject.org> <9EEFEABC-1B2A-4C76-B0CC-0E0CADAEB744@arm.com>
In-Reply-To: <9EEFEABC-1B2A-4C76-B0CC-0E0CADAEB744@arm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 17 Sep 2025 11:19:03 +0200
X-Gm-Features: AS18NWC3Sk-BkhfVNZejhhheIhwyx2CCTepjXx-PL8C7d-HPdOCn5SGsEu5d17U
Message-ID: <CANNYZj-Sk_VEMa8--q-s3G6KP1zih5KqZC4uv5WJzAd7sQrzzQ@mail.gmail.com>
Subject: Re: [yocto] Documentation around adding custom fetchers to layer
To: yocto@lists.yoctoproject.org, ross.burton@arm.com
Cc: "seth.raymond@matrixspace.com" <seth.raymond@matrixspace.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 09:19:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18051

On Wed, 17 Sept 2025 at 11:15, Ross Burton via lists.yoctoproject.org
<ross.burton=3Darm.com@lists.yoctoproject.org> wrote:
> > I'm not seeing any documentation on how to add a custom fetcher to a la=
yer, and the fetchers in poky don't provide enough information on how to re=
gister these fetchers. Is this functionality supported, or will we have to =
fork poky and keep it up-to-date to add a new fetcher?
>
> This is a bitbake issue, so I=E2=80=99ve copied in the bitbake list.
>
> There=E2=80=99s no standard way to add out-of-bitbake fetchers, as you sa=
y you need to add the fetcher instance to bb.fetch2.methods.
>
> I guess you might be able to write a do_fetch prefunc that creates an ins=
tance of your fetcher and adds it to the list, but I would not be surprised=
 if there were more places where that would be needed.
>
> python use_my_fetcher() {
>   bb.fetch2.methods.append(MyFetcher())
> }
> do_fetch[prefuncs] +=3D =E2=80=9Cuse_my_fetcher=E2=80=9D

To be honest, I was going to say that custom fetchers are not
supported. Doing that would fragment the ecosystem and make people
invent all kinds of private magic in their builds, and subvert the
promises that standard fetchers make.

Perhaps it would help to step back and look at what this customer
fecher does. Can we see its source? Or an extended description of how
the password manager is used, what data it takes and produces, and how
that data is used in actual fetching? Then we'd think of how to do
this with regular fetchers.

Alex

