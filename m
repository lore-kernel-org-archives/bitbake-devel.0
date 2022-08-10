Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DDC00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 14:48:25 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.6548.1660142897403408289
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LNENi6wO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id z17so18009412wrq.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=e5wnWHIPP1IDhJw3Cgue+sTIFO+II8qnwsJL+2aBjQw=;
        b=LNENi6wOxB83d+QHcgr5kYRAWMSO1cWEM0PvyzzXLToVRNPKWmoYBLq9o1tkt8rjBS
         HGRwxkkhQD9rHcsp0VZVCwC5GuTCyHJXdrehgMrqnPKTcbE0airCWtcwAz74o35mrqTo
         l2O9gQrvDocrQDsAtVOncFlP6BLMWvM47FCPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=e5wnWHIPP1IDhJw3Cgue+sTIFO+II8qnwsJL+2aBjQw=;
        b=Kb/uUZTCmAjQZiVr9UQ9wpbXMaIyHiO7kuYSkHpdm91qlQa8bbunXy9GZW6a+eAoQS
         c6CTpqiSbk+b2wbuJqNWlla6GgjyCHyaTbR7F9KoZ8VeqikovEEsA0d9AKH9Pbr5tpju
         k3+VGgtynJ58Y9mHyQ1GO3K0qb52LlAf/RFWrpDXAz7dCJI7ggoJ1XI//o8d0qvpubZq
         R6W8IZlxXVtThOyyx2agpbsMTqMq1+tUAHyGWolxnoohSxRIQK1vdUMzRa4lnhSkTr6Y
         g0useKB538cjyGrtEDsJbyaGe5IDEb0mTwja+DAnFddCbiHwI1PAoKihuTb/lpsjdLFj
         6ydA==
X-Gm-Message-State: ACgBeo24QetM2okvk8hP0vcnTkinBt9v0WYaUk65rcjG6bme7JBd1CSb
	lOyfX02EC4tZbb3WVq1RPPZUdQ==
X-Google-Smtp-Source: 
 AA6agR5/VRU3cclxYIbMfP/WlSFTIu7TdwniwqywO/GIHNwipEVIsI33i9KIJQ2KOdhAep5JZbuk8g==
X-Received: by 2002:a5d:6190:0:b0:21f:cf9:68ec with SMTP id
 j16-20020a5d6190000000b0021f0cf968ecmr18069558wru.696.1660142895740;
        Wed, 10 Aug 2022 07:48:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b?
 ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 e20-20020a05600c4b9400b003a2cf1ba9e2sm2518639wmp.6.2022.08.10.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:48:15 -0700 (PDT)
Message-ID: 
 <3fdfc0580eacf23711052b4fb7b6be7d95509ab0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Switch branch to correct
 hash in case of two premirrors
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Mateusz Marciniec
	 <mateuszmar2@gmail.com>, Jan Brzezanski <jan.brzezanski@gmail.com>
Date: Wed, 10 Aug 2022 15:48:14 +0100
In-Reply-To: 
 <CAJkqNs2oOCm7h0otnQEmc3brr1Y5RdjkMkGWfSW0tc+yhWCKVg@mail.gmail.com>
References: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
	 <f853e0fb1daec7c32a1fb1d0ac523cc4b8c2031f.camel@linuxfoundation.org>
	 <CAJkqNs2oOCm7h0otnQEmc3brr1Y5RdjkMkGWfSW0tc+yhWCKVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 14:48:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13886

On Wed, 2022-08-10 at 16:33 +0200, Tomasz Dziendzielski wrote:
> > If I understand what that code is doing, even if the upstream
> > branch
> > didn't have (and never had) the revision in question, it would
> > force
> > that revision onto the branch?
> >=20
> > I don't think we want to do that.
> Actually yes, since I couldn't find a way to determine the specific
> branch for specific git:// entry at this point. It's still better
> than not being able to checkout the hash on a branch even though=C2=A0it'=
s
> there. Maybe the better solution would be to get rid of 'tmpdir' and
> just clean the clonedir=C2=A0and unpack the tarball to clonedir? I wasn't
> sure if there was some reason for using tmpdir, so I didn't want to
> change that.

Looking at the git history for the file:

https://git.yoctoproject.org/poky/log/bitbake/lib/bb/fetch2/git.py

you'll see it was added recently:

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/fetch2/git.py?id=3D=
53ed421226228f60a89a1868819b6c3ed6d45026

and addressed a number of long standing bugs. In particular the fetcher
was wiping out data and causing long refetches when it was
misconfigured. We did add test cases for those issues.
>=20

> > Some basic test would be useful here.=C2=A0
> I will try to work on some test once we find some solution.

Test cases can also be useful to clarify exactly what the problem being
solved is too. We'll need a test case regardless of how we solve it.

Cheers,

Richard

