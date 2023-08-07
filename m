Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E089C001DB
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 13:32:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.34448.1691415156436235995
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Aug 2023 06:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bo2Np+wX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbea147034so38848365e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691415155; x=1692019955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rnS5rNIaDJQtxFWncq+gGblQsXNbr/C2tsqcF1nSrg=;
        b=Bo2Np+wXCq1oCxtpM7j+ooqoL+ZeumZiXN8tF+TM5RzgsfGbetxiqNvGNyEXVcefV1
         Zyx5LXs4oAcefe6JmsEP97D3vkFFuwFp+Uz1BmrS2cQx2t2yF2rlQpVvQA5w0ji6naXR
         5f6EBAhgKg4qtgiYBn0b5PE22zL3CttGrWIBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415155; x=1692019955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rnS5rNIaDJQtxFWncq+gGblQsXNbr/C2tsqcF1nSrg=;
        b=TN2yNbtjO4z5zaNjHaQvgro1zTE+FAHobULJEHuCQZW/YOpkT+PrL0ZXE1JvEkJ+Gf
         cpwbgeR2zacVsIPnkbIH3BPemILPXT90KEJz5NWTDASKFRS853WMnamPLANDqHpcQLy7
         xXchcLLQIIFedVrGgac6UOKvsLSxxdszYB4+dnXBtPoHhZxg6PdoJtCl3rcMmEBOvzDN
         X/+7lLd4mhLbTvNdM4hXo5tULO1vnuRQScpwarP2BU/wem2aCdydHh+yx7BPDgC4kXe6
         Hwr9z96o0nX8NRMFHxJyGIinpE1RwHOZDAUqbdTdsvRQVNHaWaoNpBu5ubAEQWFb3vmz
         Z2PQ==
X-Gm-Message-State: AOJu0YzpP/NqWr00Ym933NImiKo9tO8zdWuW5E2GgPWp2CtTdEmseXE5
	iuOrqsmuXr1V7LUAKBROZi0mww==
X-Google-Smtp-Source: AGHT+IHHrjUNBlieZWbOPZZVubVGLZAPTLl3obLz260g3pFLlLqCTuFLKbbLfcSZsZfmcly0lGwtYg==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:403d:90c0 with SMTP id f26-20020a7bcd1a000000b003fb403d90c0mr5489627wmj.39.1691415154833;
        Mon, 07 Aug 2023 06:32:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ea0f:cf41:6751:30d5? ([2001:8b0:aba:5f3c:ea0f:cf41:6751:30d5])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c220c00b003fe1ca92151sm10756098wml.26.2023.08.07.06.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:32:34 -0700 (PDT)
Message-ID: <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ChenQi <Qi.Chen@windriver.com>, Randy MacLeod
 <randy.macleod@windriver.com>,  bitbake-devel@lists.openembedded.org
Date: Mon, 07 Aug 2023 14:32:33 +0100
In-Reply-To: <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
	 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
	 <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 13:32:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14922

On Mon, 2023-08-07 at 17:06 +0800, ChenQi wrote:
> On 8/6/23 01:29, Randy MacLeod wrote:
> > On 2023-08-03 03:56, Qi.Chen@windriver.com wrote:
> > > From: Chen Qi<Qi.Chen@windriver.com>
> > >=20
> > > The current logic is not correct because if the time interval
> > > between the current check and the last check is very small, the PSI
> > > checker is not likely to block things even if the system is heavy
> > > loaded.
> > Agreed, there is a problem but we do have to be careful to not
> > a make things too slow since the goal is to have maximum throughput
> > without having too much congestion and cpu scheduling and IO latency.
>=20
> Hi Randy & Richard,
>=20
> Is the concern about the 1s blocking window?
>=20
> I'm thinking about making the blocking time calculated from the current=
=20
> pressure data & max setting value.
>=20
> The idea is (cur_pressure - max_value) / (cur_pressure + max_value). In=
=20
> this way, the blocking time is in the range (0, 1.0), the bigger=20
> cur_pressure exceeds the max setting, the longer tasks are blocked.
>=20
> What do you think?

I was thinking of something a bit different.

If cur_pressure is less than say 70% of max, we execute tasks as
normal. When pressure is 70-90% of max, we can implement something like
a 0.5s blocking time and then from 90% to max we can use 1s.

The idea would be to only use the delay if we're close to the maximum
pressure value. We'd need some experiments to determine the right
percentages and blocking times.

How does that idea sound?

Cheers,

Richard


