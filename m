Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F55CD3430
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 09:41:14 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35071.1777974069586546589
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 02:41:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T4NAZChL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2968530f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777974068; x=1778578868; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmiqzTB7Gl3AjKfSwrDYeTOcrurfEbMe/JWkd9nvk4A=;
        b=T4NAZChLonnTgtSuGrLx22lVwAVW/fPlzBSRcpTkXDX5F5iRWmn4DH0oJm9OwvpRwu
         g4YeyVqpljJ44mZoNx47jstSu6dles61T9oPfzBlA9kysoHzv+zx9iFi4QfvtLpRi4wb
         jbFf0kgkWr1whykFJRUBxFqr4qOm3rJ2Um2Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974068; x=1778578868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmiqzTB7Gl3AjKfSwrDYeTOcrurfEbMe/JWkd9nvk4A=;
        b=X9Kh8CfjhC4O+yUMBY54RVOtDPYehz3WmYrCe/RSeRR3WnfXC3IlQ2ta1mzdOUVRXu
         zg8L9aUKRNyLkkkNxfrZkvPi0BL341uVhX3AOPZ5u9ccwslp69ZaQOcdWDKmrblmZa7O
         GFekb3xZqERd7C4B9UP2cUHCQEA1VqLhDVP8OoJdAxm7iCJoWDfwatO1Ur3n0zxmcUgk
         UOD/hyk3W/IOYKsf5Yk6QuTdB6G463hIeauVEcelhFdXnwykrRF5X6Gj91pCfcGjqL1i
         VMOhfu2ZyT3/pzO3MSzxO8xPHfZ+eOGec5m6Yq7f1URaZU/yGo8JJCsniOJ4G8Wt6lNQ
         gkBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8r8uVvbyg/xRBJdeeIa2jNjgOEzLTFrJgH41gtblXymh1z5FTfl/I+QrcrbUJ9cPX2oMuJ9sXEFCrauDKC@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz7m9W5ht9atw4bQupO9JDD7981HPsCeAOoWX2uPJbdAQRi5LXr
	H4dtseCw6uBbJYOPg8OAwWhpegps6E+yxjyH/A5G6LjtvdDncvEp2GaWizTcIP7eMAs=
X-Gm-Gg: AeBDies3mKesTCuNQAPJaYhMCK+jwAb6CZcIZYE4IqkVsTFFWragTlYNHaP0zGZVf0U
	dobonz4JgIG6GIk4t+tyv/c14XTqMtKCwz4AwIIllS5vig44omBvGYYnZsirEcABlyZxJ77y6WT
	ioSnnLRBXTlPt+q9XxetDxPXqOGhvsJsexLzu/nFppw2u4MTDR3lN6HfhnwZsZidu94KFj+USRk
	5dT3yug45qgLauUz7YPMjO+gH0TKArK7xF6TCkQo8lcdrRainCnALGEGMfe6VGVwO1j4DdDEGlM
	6TEzR7MoIZSOiwCWePDV3jBw3Jt+q0+F98gtJYyXEODYzbAdQs5NYqRVwgukGbUY4uI4q6UbqfB
	pIF4O8/jfUQ55JTBsyajAgHQbxdQDuc6VMV86ZRsQFTwXPM03bxtmdBjiXZ1/Zozzfd7BmNo0Va
	Q46Wgxnr5ZvvZR402kYaTGOGCquZGBwotZPxuqV5uC6xcioLoWviXz1RMs3xzum9lhM9nmRSR3T
	1d//u+7+9iPTRHoHGrZTdTV5EQ=
X-Received: by 2002:a05:6000:3112:b0:44f:da83:2030 with SMTP id ffacd0b85a97d-44fda9262cfmr5356720f8f.41.1777974067663;
        Tue, 05 May 2026 02:41:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8349:ba09:9e5a:e125? ([2001:8b0:aba:5f3c:8349:ba09:9e5a:e125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960aa2sm3134488f8f.29.2026.05.05.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:41:07 -0700 (PDT)
Message-ID: <7ac8312de40809f14006bfff65143f002543c50b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: add
 BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: marciohenriques84@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 05 May 2026 10:41:06 +0100
In-Reply-To: <1413912.1777968532263348828@lists.openembedded.org>
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
	 <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
	 <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org>
	 <1413912.1777968532263348828@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 09:41:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19434

On Tue, 2026-05-05 at 01:08 -0700, Marcio Henriques via lists.openembedded.=
org wrote:
> We want to create a download mirror to store all sources needed to build =
a =C2=A0
> specific project.
> =C2=A0
> The idea is to use Git shallow tarballs because each tarball has a unique=
 name. =C2=A0
> This prevents files from being overwritten in the mirror. With full Git =
=C2=A0
> tarballs, the name is always the same, so the mirror file gets replaced e=
ach =C2=A0
> time. If something is removed from the upstream repository, we might uplo=
ad a =C2=A0
> new tarball that no longer contains a reference used by a recipe that was=
 =C2=A0
> already integrated.

FWIW the git fetcher is specifically coded to avoid removing
references. It shouldn't remove old revisions or obsolete heads (e.g.
for repos that changed master -> main). If it is doing that, that is
something we should fix.

> With shallow tarballs, we can safely clean DL_DIR since it's not the sour=
ce of =C2=A0
> truth. If something is removed from upstream, we fall back to the mirror =
and =C2=A0
> use the shallow tarball.
> =C2=A0
> For most of the builds, we want to use the bare clone in DL_DIR/git2 and =
just =C2=A0
> update the repo when bumping a SRCREV. The DL_DIR/git2 repositories are =
=C2=A0
> available on the machine that triggers the build.
> =C2=A0
> The shallow tarball is a fallback for cases where something was removed f=
rom =C2=A0
> the repository (for example, after a force push) and is not present in =
=C2=A0
> DL_DIR/git2 or upstream, but was merged at some point. This is why we use=
 Git =C2=A0
> shallow and set shallow_skip_fast to True.

I can see why you might decide to do that but it will be a pretty
inefficient use of space with an archive for every revision and means
turning everything into shallow clones, which has its own challenges.

Cheers,

Richard

