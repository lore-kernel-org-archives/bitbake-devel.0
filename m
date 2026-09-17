Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248AC982D1
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 12:16:02 +0000 (UTC)
Received: from mail-ed2-f43.google.com (mail-ed2-f43.google.com [74.125.228.107])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38260.1789647358827817740
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 05:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VHjBekMH;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.228.107, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed2-f43.google.com with SMTP id 4fb4d7f45d1cf-6a9ba73bee8so589343a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789647357; x=1790252157; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mlEE/1KZ2H4Fmd/nXCkPGq3LKIDHWvSOIAxnxQg/7bQ=;
        b=VHjBekMHrlPROW96PbHx7ch1jpi2TKR/jeIcv/FM3Ef1sLWB8HcLHwM6UHvijckEvj
         /c0gdDtc2rItxiWtbAdm2pQ7mcKGfDR5T6E+nSiiNuSg5hqfBPe9cHVOD9eiop2rdd6T
         0aIjoiqTPEmv3e3ezIpgPC0z99YreOHGoxGek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647357; x=1790252157;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlEE/1KZ2H4Fmd/nXCkPGq3LKIDHWvSOIAxnxQg/7bQ=;
        b=DYm3GUdAM9aP8d1jAM4Nw2Oaxvgps5+lHbYXFIZ7OQS6YfWST8PLLuYmeFsGY37E2t
         UbiBSBsGu19U4KiR4E8vNRM3YoeFsX3J6BwJx/2naJVr5xqMeDLcpNA21W6Jzd89zffI
         +oYO+R6MrXVxxLkeZtSy+eqNDAeGaSXDn/KxoVnU99ca5r8ASLIafLFEGPrbuxGVyfLT
         bE14HL6vUxO7GKIjrfUApFLaVa/4OyowKXXwTthob80cwa2xDNvR20VMa8gi501eYbT+
         xu7D4ui5MnWl3h5VorLcZRsRHzeH/Jj3xjN8N/ZItzyZ1v2RYsM3BfgfezVVsmh/rviu
         z+1A==
X-Forwarded-Encrypted: i=1; AKwUvBzRBA7VSvo/qJDD09pATQHXwLtavq/8cEnlUf4lh2aIaCwaZnK88bWF4fJP2NVfqF9BERJ9RAcz34nDvcnr@lists.openembedded.org
X-Gm-Message-State: AFuF++km9orz/7xekYhfFqnwgSchUfe77oSvY8Kb6hsLtcyWsGm3L/Nj
	v/zxoFQV5aG94GK065FR3yc9xW5oPNfXhBPsVhE1WuRg0kypM6SYhHsT818GOT6mwcg=
X-Gm-Gg: AYBFou3PVIpTo9ITGWGSiT39wyjSVnJ8CHwAp/c7GYOZ80qj2fqoST6S5nhoFoTfyxa
	zBnVdJvaTwInpcuMTMd6R7NK0dK5/PpBqPo55JA494zyqQDe5tqJIgyS6tbPmOS6XxNHwJ8aN31
	xhRHAu2YtZu3SesDLMuzeA86xYmAIB773xJct8mtT501Zw+HHEso3o2FBuLGYTvYm6Bkkz9auaZ
	2mTI1Kfo0zkBgGAweXJlYNAKhY8YFpuRGUzrHMS8AMnhueE+wSmsWznAxUSlankDEWjwcdfQYwA
	NpEiLGgNTV+hL0soau4pv2Q+Jx+em4fDSnSXYjLcBHo+rLCr73j/zNxzVyChr1pzhG9TFbYm8sm
	tOrd1hVAhp62hp8sb9DK5hgg41UFZy7OP/oQJDav5rz0DvjAkT4mRi4prZuBC5jPKKNAkaHh5eg
	qnhDW/174dlzOwXsPgaa4+q0mhMe/ACLMfPo4vujUiXxfQB7k+/erfCQDjY+WLFxDmmRXS9U/jR
	+tXZFRd0n+sTc9jWvGDMYoS9uiMZpjsQt7RtaZFOXYgBehxzMomRq4k4vlHOkZA
X-Received: by 2002:a17:907:6d22:b0:c25:f7db:4bf0 with SMTP id a640c23a62f3a-c29f54f1522mr262768666b.22.1789647356760;
        Thu, 17 Sep 2026 05:15:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4507:59aa:c79a:ecab? ([2001:8b0:aba:5f3c:4507:59aa:c79a:ecab])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29e801cdfesm231552866b.58.2026.09.17.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:15:56 -0700 (PDT)
Message-ID: <83ebfdbf46526c150dcda4d027a5217800113c36.camel@linuxfoundation.org>
Subject: Re: [PATCH v3] fetch/git: unpack from premirror when cached clone
 is stale
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Sep 2026 13:15:55 +0100
In-Reply-To: <DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 12:16:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20218

On Mon, 2026-09-14 at 11:00 +0000, Fredrik Svensson (svsvenss) wrote:
> The failure happens as follows:
>=20
> 1. BitBake has an old Git clone for the original URL.
> 2. That clone does not contain the commit being built.
> 3. BitBake successfully fetches the commit from a premirror into another =
clone.
> 4. BitBake tries to unpack from the old clone and fails.
>=20
> Remember the clone used by the successful premirror fetch and unpack from=
 it.
> Leave both clones unchanged and preserve the premirror clone during clean=
.
>=20
> Add a test for this case.
>=20
> Signed-off-by: Fredrik Svensson <fredriks@meraki.com>
> ---
> Thanks for the feedback.
>=20
> This version leaves the stale clone untouched. It remembers the clone use=
d by
> the successful premirror fetch and uses that clone for unpacking.
>=20
> It also removes update_mirror_links. A symlink is still created when the
> original clone path is absent, but clean no longer follows that symlink, =
so it
> does not remove the premirror clone.
>=20
> The updated self-test verifies that unpack uses the premirror revision, t=
he old
> clone is unchanged, and clean preserves the premirror clone.
>=20
> Changes in v3:
> - do not delete or replace the stale clone;
> - use origud to remember the successful premirror path;
> - remove update_mirror_links;
> - preserve the premirror clone during clean; and
> - update the self-test for the new behavior.
>=20
> lib/bb/fetch/__init__.py | 48 +++++++++++++-------------------
> =C2=A0lib/bb/fetch/git.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 60 ++++++++++++=
+++++++---------------------
> =C2=A0lib/bb/tests/fetch.py=C2=A0=C2=A0=C2=A0 | 49 ++++++++++++++++++++++=
++++++++++
> =C2=A03 files changed, 97 insertions(+), 60 deletions(-)

Thanks, I spent quite a bit of time looking at this and I'm not
convinced the code will work well. You're adjusting localpath to
mirrorpath deep in try_mirror_url and there is no guarantee that the
codepath will always run and adjust ud.localpath before it gets
referenced. Yes, the test case works but the code is full of
assumptions about what localpath means and we can't just change the
behaviour like this. I therefore cannot merge this.

I did caveat that you were pressuring me for review and I did my best
but didn't dive into details. I'm not entirely convinced I've given you
good advice on the route to take :(.

Perhaps the best approach may be to take the original v2 patch approach
but error if the directory overlap occurs rather than delete anything?
At least that way the user can get a clear error message about the
issue.

The better option would be to update the out of date clone from the
premirror but I'm not quite sure which part of the codepaths would need
tweaking for that or how invasive it would be.

Cheers,

Richard




