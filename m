Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F06BCAC5A2
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 20:56:03 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.815.1726606554757073540
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Sep 2024 13:55:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gG/0m0zx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374b9761eecso4864310f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726606553; x=1727211353; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKP3PZV/1GBpNvTqj0xJAOBCEn42eyWvvLlg1m24Odg=;
        b=gG/0m0zx00pLaXDCcs0xhA+NVc608nnB9Q9pA3vZYUjIwjaU2P6HtBBWr3zSAE9I5V
         hMmOk394AldLb3I2Pd/xtfF3bZxnhrrlf+Wehn2YVrhoQdi/D/b+Gg2ubdxY/10vQvVR
         yOsVTQqGk87Ypx2GJ4REe3RH9qFMVNPsCyNWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726606553; x=1727211353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKP3PZV/1GBpNvTqj0xJAOBCEn42eyWvvLlg1m24Odg=;
        b=FTHBe7AxD4sEtoIOpvqnb3oL49o5Bj9Cx5AWIdRtGs/Cr1mpATdloYZE6Eymj/2DJI
         ITI001m1OcJwbufr2MuGdrko5RBurprQlzWTkrMFWTYzlvkNSNv9jKV2o0F/vosWNAeW
         zL622fy7GnLIZzQqDAyMLeJRVg4RkReAVAK5cH8weNe2kyx2VIY5qUOjhcjvz+3jmTpg
         NrDnLaofiS+zyiB4IoPQKT5BKSxnEgxuwX3cVRH/U7CXdMgnNZsKIvSYdacKkoY1vM00
         AVDH2ZqhPwMh7voKsEvXjS+bKAxcZwBr3U28cpNjzXtDIJv0yjBXuWIcqdSG6cW8XFXB
         2AFw==
X-Forwarded-Encrypted: i=1; AJvYcCVVHYrjvA4ci8ZPT0DcApKTu5PGvmVT6mtH8dVO6bFE+JxGG+JFT2IbJSV3FT3IgLhLNbIa38fs6rfidgxW@lists.openembedded.org
X-Gm-Message-State: AOJu0YwObKmDLfQ3/gGzAJotseANk35tnLI8BMrh70stkf1QVlTJv+mV
	H+ag0EO9jjF8IAAac4vLMNjsKJTOJiVJDYm1a5Cmrs4AxYhm/dsgJf/Wf6zAL0w=
X-Google-Smtp-Source: AGHT+IFMQxccMSy98j3xSmKmUcSCZ99xV3iyI6RQSPSLG61IrzqutRcpNIDuv9kMPd7hEDMVLGJoSQ==
X-Received: by 2002:adf:a18a:0:b0:368:48e6:5056 with SMTP id ffacd0b85a97d-378c2cf540dmr12188947f8f.22.1726606552724;
        Tue, 17 Sep 2024 13:55:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:121c:7879:24c3:1e39? ([2001:8b0:aba:5f3c:121c:7879:24c3:1e39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81e2sm10473293f8f.37.2024.09.17.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:55:52 -0700 (PDT)
Message-ID: <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: add documentation for
 "bitbake -S lockedsigs"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jstephan@baylibre.com, bitbake-devel@lists.openembedded.org
Date: Tue, 17 Sep 2024 21:55:50 +0100
In-Reply-To: <20240917151157.780068-1-jstephan@baylibre.com>
References: <20240917151157.780068-1-jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 20:56:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16567

On Tue, 2024-09-17 at 17:11 +0200, Julien Stephan via lists.openembedded.or=
g wrote:
> The following commit added "lockedsigs" as new signature handler for the
> -S option of bitbake:
> =C2=A0=C2=A0=C2=A0 2cf13f25139 - lib/oe/sstatesig.py: dump locked.sigs.in=
c only when explicitly asked via -S lockedsigs
>=20
> But it was not documented anywhere, so add some basic documentation for
> it in both the .rst documentation files and the help message of bitbake
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> =C2=A0.../bitbake-user-manual-execution.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0.../bitbake-user-manual-intro.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 13 +++++++++----
> =C2=A0bitbake/lib/bb/main.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++-----
> =C2=A03 files changed, 22 insertions(+), 9 deletions(-)

Unfortunately I don't think this is quite so simple. The lockedsigs
support is implemented in OE-Core and BitBake doesn't contain that
code. This makes it very hard to accurately document since it is
metadata dependent.

I do agree we need to improve this somehow, I just don't know how.

Cheers,

Richard



