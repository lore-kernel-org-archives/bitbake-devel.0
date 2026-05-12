Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E78CD4855
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:15:43 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70512.1778573736088226530
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 01:15:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E1+zf6Xh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3261194f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778573734; x=1779178534; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMc6H+1VZvKB1hv8z+/NbivBMocnLPfqCCSwYCvYIYU=;
        b=E1+zf6XhtY3eNgp/EIixwLzJk8UupkH78mRqtGoLh3F/jOIui8sUlLSLrntI43NfVH
         lkFmAAoFrHKv7j49SWQMfgRaUf+aFW7LjfSCgxvVgUB3U2v18jj7C6RaamKUa4/LjmKi
         /pHqCv7x3NbmrUhAfYM9OnAI55L/a/06z5qio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573734; x=1779178534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMc6H+1VZvKB1hv8z+/NbivBMocnLPfqCCSwYCvYIYU=;
        b=mTb5j1E7pnWaSkem5lTCQSuHUN8rCimg1oWijdNcbgAuMISlW2aSzxdNqdOkQdWX99
         UI6snxuXKbqMfMeAoUBTOWAasCgsQZez5yscqS+eDysR0L5V3ybUNAj/4R1XOimwlcAv
         BqjZL3XI7mENKswcD8OVRRy3fxqC35bjKUXk1hSebgR0MGEsy2hqjTC7gbFTCeyVVVX+
         zzwIgdxEN1GMzu6arsFkiImaKku0YtvcF5JSLasF9yWR4BXuYwlEl7vJVnR8aW7r/Sf0
         a23heGY/aB/+nagK+0iuvgyEkxt9HPN1hrML7Wd6DNvG/SUTcMAed31I/BTw8JkfQCyr
         hegg==
X-Forwarded-Encrypted: i=1; AFNElJ92aRXZo6N92jLzpDXiChFxK5/YpXUFW7E1wAVYjmUUVJ4hwrGR7tb2nSiSBIDqas5w7UtzVk+L2XAf4r3K@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz/jFeVpofVQIWFwMdqfiR7R2EWa3hKuZH+6EYVW01rqdzwZMp0
	+eyG1MRn5ROp1o8ovvoYPkHVfL2Gb/TnVKvo/eY1fRX8ydKwiCNTdLz8gFRGrMjOCMw=
X-Gm-Gg: Acq92OEPP3jQ4buBcXtPkHW5arFtZ3Dd2DYEp5Sa5OraCOULW0kn4OBtiTY2BCWGhCX
	1hTDyDn4ahutLx1Jtgkv56fM6X6I9UzzOoAM1YVtYXWTcIf3i4MT7tjixn2C5x54eGsmi6SelOC
	succeIlQySPvV5YbpENEGx8H8GH8gJOKGU3LsN2Cuko/QRhJNtEslaQiedhER/NCohT6Yvlvfns
	5Z1qrKfAv7STA1cnkl9nVMoxtwLHL/jJOLJWaTJUrs4bkO8+K/M7Dd/ROFh9h8HsGlcQRWEeCY1
	yyiJQg2aWB5BmHHuDtfyG5sim/wPnh2nM4eowSAbKts+EA8c7951ywjga1m3b4aeEglqPv1k2C+
	qIXv6jAGN1wr97zyzjwtG8UdC8W054iGpPl2IqzAyuYH3+0an+OqK6aGn2MRCLyhN9laX1Tuq1g
	HNXYjhi83XQ9Xt+9ChelQ4Usxdc8jDuK3DuQyKQzCovvZldTVoXEMqiAYNrskj4s4tiojclNjg0
	rwCzTuyt9krPRo4SMaPwWycHVE=
X-Received: by 2002:a05:6000:144c:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45460e40ab5mr26446859f8f.4.1778573734296;
        Tue, 12 May 2026 01:15:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:44a5:ca0b:d27c:9664? ([2001:8b0:aba:5f3c:44a5:ca0b:d27c:9664])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm29767322f8f.16.2026.05.12.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:15:33 -0700 (PDT)
Message-ID: <18eeec4ded4bafd81bfcbc884d82d87e076679c5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: add
 BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: marciohenriques84@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 12 May 2026 09:15:31 +0100
In-Reply-To: <1495889.1778516042086994585@lists.openembedded.org>
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
	 <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
	 <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org>
	 <1413912.1777968532263348828@lists.openembedded.org>
	 <7ac8312de40809f14006bfff65143f002543c50b.camel@linuxfoundation.org>
	 <1495889.1778516042086994585@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 08:15:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19496

On Mon, 2026-05-11 at 09:14 -0700, Marcio Henriques via lists.openembedded.=
org wrote:
> On Tue, May 5, 2026 at 10:41 AM, Richard Purdie wrote:
>=20
>=20
> > FWIW the git fetcher is specifically coded to avoid removing
> > references. It shouldn't remove old revisions or obsolete heads (e.g.
> > for repos that changed master -> main). If it is doing that, that is
> > something we should fix.
> This is also about dealing with force pushes that may remove something th=
at
> was previously merged and is no longer available in DL_DIR/git2 or upstre=
am.

The fetcher should not be removing those things. If it is, we should
fix that.

> > I can see why you might decide to do that but it will be a pretty
> > inefficient use of space with an archive for every revision and means
> > turning everything into shallow clones, which has its own challenges.
>=20
> It can actually also be more efficient as the git fetcher fetches all bra=
nches and this may
> require more space than just archiving the source code for the revisions=
=C2=A0used in the build.

Yes and no, in that you have a copy for each revision.

Cheers,

Richard

