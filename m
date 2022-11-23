Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE4C433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 12:24:44 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.18749.1669206279621714758
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Nov 2022 04:24:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JYoWKUtL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id g12so29105468wrs.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYFPm91w6QoJLNrexeyfrW9hK8e5vPfgOY5tJu01YEM=;
        b=JYoWKUtLwjW+QlTKOHF8mqblp95aHl+vHERlJHx19oy74RM4B3E52NhKCOxkBaPPNn
         nEof9djPdlLs0AtcufzGRhMnBLHLsvAvWJZKT/QFhShBGNnHF/b5z71zAZ5v//zA7U72
         ji6EFu1WIOSqA+rxyG6/vd9xgGtZCPODf3q3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYFPm91w6QoJLNrexeyfrW9hK8e5vPfgOY5tJu01YEM=;
        b=sO/LZmznSamc8mLaD75rUzsVA+fYQm1Am5uoye3Uawq7dedIebfoxk6+o3J0qReBoL
         DPtabBVZtxeNLDwZNyMCyS0WV22vKLZ/XAiqKi1gWRJoX3eShL6mYPln/UzCfyyNOcM8
         YFAKulSt7DO5Nj/MPEV5S1rS3RoVucxmYiy2OuUm358lQJtQqetWRyrPnOoFCZJvmJHs
         ugdtxgPK4WpR5TzKGo1hsTaGNYCAVkqYvFlXaKpyV/ZaPscwImJKPRuwYhFjYeAVwzul
         UgxhjEJmpV0+Dvjnk6Jy7DxANclC9LYdKYaj155fkl5fyqiDuUmVoCrJBW4VYFipIaA+
         erbQ==
X-Gm-Message-State: ANoB5plBF/yHsDvRtGcdPDeO102vwT7guF1+qpwNm6nR6IgH4LUU/Wak
	wHllPUtIS4def2sf4Ap51Cuxqw==
X-Google-Smtp-Source: AA0mqf6uXAbzOL+9bXGDVOAVMRedjvXdjlFF0A1CB5WVm0EN316+HA/iAP74Df+UeXcfbzy/lfRtMA==
X-Received: by 2002:adf:f612:0:b0:22e:5d66:dc5d with SMTP id t18-20020adff612000000b0022e5d66dc5dmr11303822wrp.175.1669206277593;
        Wed, 23 Nov 2022 04:24:37 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:978b:ac21:2786:e95b? ([2001:8b0:aba:5f3c:978b:ac21:2786:e95b])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003b4fe03c881sm2000151wmq.48.2022.11.23.04.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:24:36 -0800 (PST)
Message-ID: <7dd30ab32b66b66429457bceb9400e77edea2a32.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Cache timings with various changes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 23 Nov 2022 12:24:34 +0000
In-Reply-To: <87f9939926fd4a488abb8e6442c6100a@axis.com>
References: 
	<f963c6619df931162db7de468699d2aad0c1b76a.camel@linuxfoundation.org>
	 <87f9939926fd4a488abb8e6442c6100a@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 12:24:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14102

On Wed, 2022-11-23 at 04:33 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openemb=
edded.org> On Behalf Of Richard Purdie
> > Sent: den 23 november 2022 01:07
> > To: bitbake-devel <bitbake-devel@lists.openembedded.org>
> > Cc: Joshua Watt <JPEWhacker@gmail.com>
> > Subject: [bitbake-devel] Cache timings with various changes
> >=20
> > I've talked about changing the data we cache in various forums. These
> > are some actual numbers from a local system (88 core):
> >=20
> > Patch                   Full reparse time    Cache load time    Cache s=
ize (compressed)     Cache size (uncompressed)
> > -----                   -----------------    ---------------    -------=
----------------     -------------------------
> > master baseline         5.732s               2.261s             N/A    =
                     24M
> > frozenset changes       4.326s               2.289s             N/A    =
                     24M
> > pickle in one           4.509s               2.177s             N/A    =
                     24M
> > compress with zstd      6.040s               2.204s             3.4M   =
                     24M
> > add hash data to cache  9.693s               4.327s             17M    =
                     83M
> >=20
> > It seems the frozenset improvements I have speed things up nicely and
> > look like a good change. The compression does slow things down, as does
> > pickling the cache in one go.
> >=20
> > The patches are in poky-contrib rpurdie/t222. I'll post the frozenset
> > one, the others look like they need more thought.
> >=20
> > Cheers,
> >=20
> > Richard
>=20
> Not sure how you measured the times, so I just looked at the progress bar=
s=20
> for "Loading cache" and "Parsing recipes".=C2=A0

The numbers are from:

https://git.yoctoproject.org/poky-contrib/commit/?h=3Drpurdie/t222&id=3D3f3=
c3f5df43097ee4539308e6f06d838bbd69f40

i.e. "time bitbake -p" with a hot/cold cache. In that sense they're the
real world numbers a user sees.

> With our layers (4717 recipes)=20
> and my computer with 8 cores (16 threads), this is what I got:
>=20
> * Without rpurdie/t222 applied, it takes 0-2 s to load the cache, it take=
s=20
> =C2=A0=C2=A043-46 s to parse the recipes and the cache is 185 MB.
> * After applying up to "cache: Switch to compressing the cache file with=
=20
> =C2=A0=C2=A0zstd", the cache load and recipe parse times remains the same=
, but the=20
> =C2=A0=C2=A0size of the cache decreases to 17 MB
> * With all of rpurdie/t222 applied it takes 2-3 to load the cache, 51-53 =
s=20
> =C2=A0=C2=A0to parse the recipes and the cache is 55 MB.

That is useful data, thanks! It seems to agree with my estimate that
the patch slows down main parsing by a few seconds (probably something
we could live with) and doubles the hot cache load time (not so good).

Cheers,

Richard




