Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B35C43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 20:50:38 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.2926.1657227034446531261
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 13:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fne91Lxg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id z12so18329566wrq.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=XaTUyJ5LGtHE4hEPBsNPq69VxCErm4qn8rsPKT7NLxE=;
        b=Fne91LxgDof+NB04Zzfc9fIre7kUqn7mpqLglz/XFZPWmxqmxSemJYTYLo95TpbDvo
         Il0UxXxvQo/NnmJWgsVF87OfSGXp+5cgYWqrz0/KLPN3U2LhEkQB1/eqoAKHI4WoIGgE
         F8EFcqvQ21pYDuSEoC8VuNo2Ocq2P2Iz1k8sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=XaTUyJ5LGtHE4hEPBsNPq69VxCErm4qn8rsPKT7NLxE=;
        b=XN7rmvwf51+gcPPjFvW0uUmlqrlbsMQQwF8KiRjJjQiY2KIyLTOLwAajI6zrC2hkNQ
         3m0c7+42raDxugnGEchAYqKvJ+XIsuXCiRnR1vPWkrpXwqwV5InqQ8l37KctdWIpoUbB
         kxw4FeVGmACB7X72Gsoy9+3hhSnWUt8OhPZCU+0iR2A6K1y3sYHCfz8KUKeyWzXOiFwp
         SeNdrGFOd1OSZTnvTpSiERUX35kIzqiZQKqIynA8SzBic80FYOoOoJt2PLfcs3jqf12D
         BOf6yPYBl8ffJZfCPmhuzFy89h1yzjtdYq6J10rNQiKwcwbnTjMaq3ssysJC9hZVudat
         XpXQ==
X-Gm-Message-State: AJIora+dh5e0ga9TLfz94zqncLo5EOceuPnUtuCt3yFCbv+Vbtdzz1Oq
	DMtre1zHKmCdk1XK0o1GABNMHA==
X-Google-Smtp-Source: 
 AGRyM1udd1WorYNsj05y3uIf8m2ZMyHLKWG+CdVQRTxbdyoPXDwgUuvXtmo/cBhxGijPIZ8Dzw0VBg==
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id
 b14-20020a5d4d8e000000b0021d68d456ebmr24032013wru.40.1657227032803;
        Thu, 07 Jul 2022 13:50:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d855:200b:b1b2:5d8c?
 ([2001:8b0:aba:5f3c:d855:200b:b1b2:5d8c])
        by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b003a17ab4e7c8sm31054613wmq.39.2022.07.07.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:50:32 -0700 (PDT)
Message-ID: 
 <d3875ec790ad9afad85296c9e844d610ecc649e6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bruce Ashfield <bruce.ashfield@gmail.com>, Maia Xiao
	 <t-maiaxiao@linux.microsoft.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Jul 2022 21:50:31 +0100
In-Reply-To: 
 <CADkTA4NaD1SKgOpMdM4ap=Gv7g7KXc_MjUt1eLe-J2=i9_KEUQ@mail.gmail.com>
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
	 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
	 <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
	 <970e2ed4c836e291aa9845849c0d3d86b57f849c.camel@linuxfoundation.org>
	 <d6f373c-eb88-e765-7973-9d4af6de40ee@linux.microsoft.com>
	 <CADkTA4NaD1SKgOpMdM4ap=Gv7g7KXc_MjUt1eLe-J2=i9_KEUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Jul 2022 20:50:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13809

On Thu, 2022-07-07 at 12:55 -0400, Bruce Ashfield wrote:
> On Wed, Jul 6, 2022 at 4:14 PM Maia Xiao <t-maiaxiao@linux.microsoft.com>=
 wrote:
> >=20
> > > > Actually never mind on this first point, assuming that this isn't r=
un on
> > > > all fetch paths (I didn't check that).
> > > >=20
> > > > But my second comment about the depth is something to consider.
> > >=20
> > > Yes, I'm also remembering comments someone made to me recently that
> > > many git servers don't support limited depth clones because of the lo=
ad
> > > they put on the server.
> > >=20
> > > I appreciate this was moved to a newcomer bug as I think we assumed
> > > there was a straightforward way to remotely ask "is revision X in the
> > > repo" but it is looking like that might not be that easy :(
> >=20
> > Going off what Bruce said, a potentially "softer" way to do this is to
> > keep self._lsremote(..) as the True condition, but we additionally try
> > to fetch the specified srcrev and just log a warning if that didn't
> > work.
> >=20
> > If we feel reluctant about the additional fetch, another thing that we
> > could still do is to log a warning if the srcrev isn't a tag / at the
> > top of some branch (i.e., not in the ls-remote). I'm not sure if it is
> > (un)common enough for that check to make sense, though.
>=20
> Either of those options makes sense to me. As I mentioned in my
> follow up, I wasn't sure if the revision checking was in the hot path
> (i.e. run on every git fetcher opportunity) .. if it is in that path, the=
n
> we have to be more careful.
>=20
> I thought the 2nd option you mentioned sounded interesting, but
> it is quite common for branches to move on quickly, while we build
> an older tag that is a release point. So it could potentially generate
> a lot of warnings.

This shouldn't be in the hotpath for most code. The wget checkstatus()
*is* as it is used heavily by the sstate code but people don't put
sstate into git (I hope!).

I think keeping the lsremote and then warning if the revision check
fails might be a good compromise. I'd be interested to know how a world
build running checkstatus for each recipe looks for something like oe-
core or poky.

Cheers,

Richard

