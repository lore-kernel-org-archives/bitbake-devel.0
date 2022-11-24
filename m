Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB87C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 22:26:23 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.35262.1669328777705905293
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 14:26:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Sgw+pQmF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id v7so2216324wmn.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VF0V0bc8A30mPyKLyFVeAAIDtkYRjHn+blHVEROY1j4=;
        b=Sgw+pQmFn+hfCbNTLdJf1W8Y7wsMNyDklPy2MVQfZ/Lj3ff8fLzs5QKalxFqAYdBFZ
         hKHv1N/evp60xWdbyrwXVnuLXGqkxAxhGZrgxr1oeayb9wdc6KuHDwBzWDzFcYbthfSL
         n6qLhb6NHb3pyTTAipBHuHQZxJAuUmSefliIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF0V0bc8A30mPyKLyFVeAAIDtkYRjHn+blHVEROY1j4=;
        b=ci7kyKenVUILVsNlfcksZeCkrGFIo1Cie3Wmik59iPcu3K/k/OeuD0+ZDAVo16/2mT
         GFWEZ6G6ue+tyeJFsW9EAta0MaTyaTJH/uZwYFw2YkePFToc7QniB2qCYmkw75623Oq3
         WRjBuqyGb2IidJBjbJfkUbkrP6xds2WsorikprjYP6WTaQ9QdJnJ5pdEzCydjpALWwL9
         Rnbo5KxK48RkRm1SiMd1+nh6vmHDVodbc/NZwb4smQ9Mpebsbt83hc+Rl9L2okEVsyAL
         HUYZDGom/U5MVFZ2pQPFBhFZnpqO2urwqB7NpGpF5FRVfn7gcwa9WR1deDajC6ZbzLgU
         iqyQ==
X-Gm-Message-State: ANoB5pm/TDAYVexXSntF5Be0CvApiSrOb5kmbQgA1nN3zNCV5iaLXbOq
	TbIlqeAs7mew3VIyjwYhJ5Blooo5mS5p2A==
X-Google-Smtp-Source: AA0mqf6ZMDSt/OLUm1XrgI/r/tCclfeqKh8fcLGqhcqyqeyhef3CEzcDkO5OMavpu1565QaSOFPa+g==
X-Received: by 2002:a05:600c:5113:b0:3cf:77c0:48ea with SMTP id o19-20020a05600c511300b003cf77c048eamr28310445wms.130.1669328775530;
        Thu, 24 Nov 2022 14:26:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7c6f:7712:93d3:b3fa? ([2001:8b0:aba:5f3c:7c6f:7712:93d3:b3fa])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b003cfa80443a0sm3172217wmb.35.2022.11.24.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 14:26:12 -0800 (PST)
Message-ID: <4a988050cbe346b434d51d87173c7644838fc94a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Cache timings with various changes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Thu, 24 Nov 2022 22:26:10 +0000
In-Reply-To: <172A0E0769C4899C.9021@lists.openembedded.org>
References: <172A0E0769C4899C.9021@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 22:26:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14112

On Wed, 2022-11-23 at 00:07 +0000, Richard Purdie via
lists.openembedded.org wrote:
> I've talked about changing the data we cache in various forums. These
> are some actual numbers from a local system (88 core):
>=20
> Patch                   Full reparse time    Cache load time    Cache siz=
e (compressed)     Cache size (uncompressed)
> -----                   -----------------    ---------------    ---------=
--------------     -------------------------
> master baseline         5.732s               2.261s             N/A      =
                   24M
> frozenset changes       4.326s               2.289s             N/A      =
                   24M
> pickle in one           4.509s               2.177s             N/A      =
                   24M
> compress with zstd      6.040s               2.204s             3.4M     =
                   24M

This line in the data is flawed as I changed the compression algorithm
for codeparser at the same time and therefore the 6s number includes
rebuilding the codeparser cache which none of the others do.

I'll continue to try and work through some of the pros/cons of the
changes.

Cheers,

Richard

