Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA12C5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 21:27:37 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.865.1787347654348129208
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 14:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EFIYfMW+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so6725425e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787347652; x=1787952452; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sRwQ8ZdRguaIvMKDqGYv265AmZAnT7uiFGRLZa/uO6Q=;
        b=EFIYfMW+1ecp5k+EPm5YMk4E+u0IEmgyamHS985FNh9Zzsrf+2Xa+urNwkiz3tsCnF
         mY4Cu3/1y5ZFp7sp8fkJy0XHHnXbEBh9WXoRcN8GswXw8ZFN5jpDcmPCzq65PEXI8edS
         UfmbgWPW5Ro99qryr53eLb6MEIGDEp4zJOZ00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787347652; x=1787952452;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRwQ8ZdRguaIvMKDqGYv265AmZAnT7uiFGRLZa/uO6Q=;
        b=HAOl3vqe8ImCKlANLTybG6+bhcwFUCK8xRGgP76kK5xnAQbG9a4W7vm+i6HSn/m+F4
         SweZO0E+uBxiknoM4Of2ebZ3j4e1N/XcbHFLr3QG8kM8+jZZ4pWBTGLoo5eCq5K3fcim
         WQfvpICUDRV34fBi+szCIJN46WpAo80M2MLSFL6A+EulepUtHZdC1TvPm5M4pFZzi8Jf
         gI0CI/7wgOOre/P3YVNaU38J6GCrwKa0YaqH28LfoMa77ST+9KHCOgYylFp6/UsFRh2V
         iEDXROSR0uLm+jv6IcxhNw79SqYRoZSHFV3qITpsdJGmzFNdSeaHa1xwMGDrLFjnlnhB
         FL6w==
X-Gm-Message-State: AFuF++lsW+A/zMqDwJ9z8ttjNSp78MHTQyuKnnqTnILUeISq9fRV3pDr
	RvPyW80/buBOLeieB+dZmiziv/z4ICaIJgWMl/mX3ylxNidjpDqxMT8DUpLoFj0J57IPi1v9r2z
	SLc1+/Yk=
X-Gm-Gg: AR+sD123DPs7m98msgFN7Pxxz2sBlZSgJFF05XN/x+L85DqBUTgEk2TcQZcBAB3Gt9x
	nTF6kjZPAYqXbkqFCyJQ7CYG/wI8yPzXWgotsJJBTDAHkCxMRfb2a842K3L10rJzD/p5PWafWg9
	gyKRApaY7s2jAbVMBD5uehclX+CjLb5jEqwFVc4CR4vHBIhvdM4klQXR18l2Prq7MaaSrvQ2S/u
	wRQqpjz/S/8+0pcrz6mQOZyvPgM4ILVGD8DMup/2DDGGOG9M4dkdVwI0GPK9JQIKOOYVIMhWI6r
	6P6f22Bgf8HpbN8ishwMPtIKQX8vO3rI+HBAsjddKSN7Bvi4VaLCJtzD9NPB3h6i97UZmLwQNuQ
	/U89HL7DeFotD5uhSDjeFjpFvo4lf3gH+ee5WCO4zXlJaSVuA5TISetZwHxoZCedl8OO+xxOcw7
	xIOMakWpZzaEj6jbCFYIpA3aJWXi4I3ZazNuIPMPhfUSZ78u18AlE3xGnKXT/iZIFEOG/X5aPGD
	jcNLo16ZtD1GW0MX/9REOvrMdbiNa2PSU6nl2mNzc0gOsLuRR1E1g==
X-Received: by 2002:a05:600c:a313:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-499bf8cd003mr43296385e9.2.1787347652491;
        Fri, 21 Aug 2026 14:27:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e5fd:eed9:eff8:d030? ([2001:8b0:aba:5f3c:e5fd:eed9:eff8:d030])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c01b90casm7680345e9.2.2026.08.21.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:27:30 -0700 (PDT)
Message-ID: <e9b1c5a8825756040472ac48bfbb61db4009ac31.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/3] Remove bb.fetch compatibility shim
 module
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "alex.kanavin@gmail.com"
	 <alex.kanavin@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 21 Aug 2026 22:27:28 +0100
In-Reply-To: <DM8PR12MB54303D8EC454EA621D9171028BA32@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
	 <CANNYZj9wrRh4JR3cuwKchRFXEKEKa+oyCSh1XMN=tWJihY-8Ug@mail.gmail.com>
	 <DM8PR12MB54303D8EC454EA621D9171028BA32@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 21:27:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20015

On Fri, 2026-08-21 at 17:26 +0000, Chris Laplante via lists.openembedded.or=
g wrote:
> Hi Alex,
>=20
> > On Fri, 21 Aug 2026 at 19:06, Chris Laplante via lists.openembedded.org
> > <chris.laplante=3Dagilent.com@lists.openembedded.org> wrote:
> > > fetch2 replaced fetch a long time ago (2012) so I argue it is time to
> > > say goodbye the bb.fetch shim.
> >=20
> > Why not instead rename fetch2 to fetch and drop the unneeded '2'? Is th=
ere a
> > reason to keep the number?
>=20
> I thought about it, but I'd bet 'fetch2' is more prevalent than
> 'fetch' in third-party layers. We also document the naming choice:
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-ma=
nual-fetching.html#file-download-support
> . So I think it would result in breaking a bunch of layers. Whereas
> if people are still using bb.fetch, we can point to the manual if
> they complain.=20
>=20
> That being said, I'm not opposed to going the 'fetch' route if people
> prefer it.=C2=A0=20

I'd probably lean towards moving to "bb.fetch" but leaving fetch2
working for a short while as things get updated. The "2" is fairly
meaningless.

The key question is whether we'd ever have a fetch3 but I suspect we'd
handle things differently with fetcher changes than that...

Cheers,

Richard

