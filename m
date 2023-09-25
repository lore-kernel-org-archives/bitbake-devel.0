Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A65CE7A94
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 14:07:12 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.61683.1695650822303134614
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 07:07:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wk6x54pk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3200bc30666so5461390f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695650820; x=1696255620; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5PHnmN86pcNG0e4y/VvFlMFcCssFiXnmr8yqCdFmLs=;
        b=Wk6x54pk+PSpDJ0Mk1hhGaFX4MFqtNcOTOTmNWrtVO3ViwuEJ/IhmJSbiL/qq/jtGz
         o/XyFvcFlTJShP25ld7Rj+Db5UGpk8rX2B4o5I2VpP+1r8sPK+17Sa2kDPowU+6L7kn6
         jdW+XMrcUWZdB5Oc67BZwm2+INiUAOEmmUIyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650820; x=1696255620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5PHnmN86pcNG0e4y/VvFlMFcCssFiXnmr8yqCdFmLs=;
        b=PCnW6/fMt79mUHd6ieLfY1Rn3FjdVM2+2VhdvMSkL7Jsd2oxTQ0X9cfkADUrtqm1yz
         9+BaDplHJbWHo3kzT05+kbZha1ntwebMx+XZcMvlsIW/MumgadS9yR3f499LgxFbxgu7
         6nfB3WjaEvrrjpFPDaFoRHzPXqT7aG0kXPz21bKBlsEGvpTM36j0W3L/Uidqy+I808Uv
         y35DytLR1wTlFt1N53J02Z0UpHoC5wxeKE3iEGPXknrC+YSa0XmR+jkmFK33mqDaalNU
         SIiT96EkkBEoFS2vEGY3vzgfRZnwEMelUNC5G+tP79WgQAFeJ1mPXNC8b4kkg/NOIOYT
         1sfQ==
X-Gm-Message-State: AOJu0YyF5vSRkkGK92zD/iAvXM2MXiIMuosnGz8aYuukGHFd/FkHcr+R
	dBp1roGRmG/znVKzEUvA6uRBmA==
X-Google-Smtp-Source: AGHT+IFDadU64mIwNiLANnPMikBBEQzd15zFQCMY4qgSU0NxtduaUdUPGtMjHCD1zR7G2WFIRwrtfw==
X-Received: by 2002:a5d:4fc9:0:b0:31f:f99c:6009 with SMTP id h9-20020a5d4fc9000000b0031ff99c6009mr6917138wrw.22.1695650820501;
        Mon, 25 Sep 2023 07:07:00 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dc0c:9197:530a:4339? ([2001:8b0:aba:5f3c:dc0c:9197:530a:4339])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b0031416362e23sm12003241wrx.3.2023.09.25.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:07:00 -0700 (PDT)
Message-ID: <659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Sep 2023 15:06:59 +0100
In-Reply-To: <DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925032246.1316597-1-pkj@axis.com>
	 <2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	 <DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
	 <DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 14:07:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15119

On Mon, 2023-09-25 at 13:55 +0000, Peter Kjellerstedt wrote:
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > On Mon, 2023-09-25 at 10:16 +0000, Peter Kjellerstedt wrote:
> > > > -----Original Message-----
> > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > Sent: den 25 september 2023 11:22
> > > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>;
> > > > bitbake-devel@lists.openembedded.org
> > > > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not
> > > > output anything with --value and undefined variable
> > > >=20
> > > >=20
> > >=20
> > > My goal here was not really to be able to determine if the
> > > variable is
> > > defined or not
> >=20
> > I know, but that is an important detail and whilst it may not
> > matter to
> > you, it does matter a lot.
>=20
> Well, as I see it, with my change it _is_ now possible to make the=20
> distinction if you really care, where before you could only assume
> that a returned value of "None" actually meant that the variable is
> not defined.

As things currently stand it is clear something went wrong through the
process you yourself mentioned as how noticed. Once your proposed
change merges, it becomes very unclear what is happening.

I'm not disagreeing that it needs to be fixed somehow we agree on that
and I've already said as much. What we disagree on is how to fix it. I
disagree on this way of addressing it.

I'm not taking this patch as it stands.

Cheers,

Richard

