Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3301C982D6
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 14:27:43 +0000 (UTC)
Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41083.1789655259595957108
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 07:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cdvYRcyU;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.230.99, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso7205501fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789655257; x=1790260057; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9i5wCEzOEsO4OGa3pzeAwdndOsjBJB3aZu/eS8laJHg=;
        b=cdvYRcyUo/ypcLcGY6HZLTOWXWtgEhKPnZ5aQ+arNiDW1gEmoZ+OM+UOOndPkNMvYH
         knGklOkEa+DvRTSMwibUR1uVIIcQIt1E33ugkBPaU8QbORAkJKEpG6X4HlT69m7cHMTT
         KUNEI2R9eHwwXrZkgDYBQamAgOXd5yoP78LJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655257; x=1790260057;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9i5wCEzOEsO4OGa3pzeAwdndOsjBJB3aZu/eS8laJHg=;
        b=O4AwNRJJNJs7cLybgfuHWKYTtWgBkn2eC1OQl9VSlJA/3z8LFu7Dp7XhQy1GfT4KBN
         Bd6r/yKrMQg395niKKC5hNWkAiROJ8FsJd4h4Woh573FGIlnM05tqo9ITYN/mWvLS0wm
         dKEDWqirKa6IdMLxFV9g1DvC8PWkrqT7EyB7P63QONk+7YnyJSHZ7vQsvA850KWvIfjS
         hHfVa7duTUbB8K33GfcAwYmwvHhkqSZfZreHtZ4RNFVEfe3MEw4AqnkVcLNYEZ43N4dU
         G/FImTT0JvDnXXNuR7IqDzjcVTUNzj4DUHpmY9kxuqDH9rjRuMXrhty3upSDPF4es8p5
         JvbQ==
X-Forwarded-Encrypted: i=1; AKwUvByUMLmIclcuebiC5JEkSebB+w7xicXrNhckiJtIfrAXOF5jifeayGjHw0RlXUNgwcv3wrbLyY2jzarVB1Ew@lists.openembedded.org
X-Gm-Message-State: AFuF++mKC73Zm4CGhbcpOY02qoxS9TAun91+kbfCPEXNgEYQQ0Ula/US
	7UWIiVk1TDECOXfpsL7buemdEZKo7ydVTupstqb3wEI0J3D+lPDMNTqEFrky202rkGc=
X-Gm-Gg: AYBFou0SxiPj9NFm4CGDEZnkNjTgLoneAPPitZBqjrmkJGo+P+Y4rvgE2PRC24jR6/Z
	BUNAmcHCCCwfgRnkP+VaazQoVESDl5cFl+iG2r7/ZJCQ5Lj2U5xZgMaECqePi0oTgSn7ozvcrHw
	FvSCjKaR1w3aNiprC8+pTw+QSWU3AbKtp9UcNAnC6QWBRELeEQNM6qfUsGhYt8gQUJxnSmg6Uh0
	WA6q9eqpk7phLl8OHh2dPR+PzWXKQnXKh8CP6tow++UaTfXy/Qc1YeQ9kpKcx3/TitR0xW+aq35
	B1dxctvnzMDO2aoQdDmzeOS38Xm5iDg8wKKbHmXxsvL4upPcDfhLC2GYTSC9+t0b9eC1anlGB+t
	mHI297CZ9Z+tFsKvQn3zU+dvVE+h9Fs0m6pV8OPUsvSjqDR6Z24HODSs9xcjiCUVbiUxEYJiZpx
	8iR4l17c1Nos9V/Z41ie+YL09CxwKU7NZRYY8zo/GsjykPtwkPqltV4HUOm7g8qn3DDlAgSgkD+
	3q/yISfSR8jcQ5K1eg3p/8kUm4pZWJvNDFF5418RAt1qcv8lR9InInHmYt7rWwo06Hv1uYys8E=
X-Received: by 2002:a05:651c:150a:b0:3a5:d070:a002 with SMTP id 38308e7fff4ca-3a5dc9b6248mr14595541fa.4.1789655257371;
        Thu, 17 Sep 2026 07:27:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4507:59aa:c79a:ecab? ([2001:8b0:aba:5f3c:4507:59aa:c79a:ecab])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5daf95edfsm14640351fa.11.2026.09.17.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:27:36 -0700 (PDT)
Message-ID: <8e2acf45a1bc8fa401e5fe94a1f307fad6f60d8a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch/git: unpack from premirror
 when cached clone is stale
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Sep 2026 15:27:34 +0100
In-Reply-To: <18D621254B11266D.1924412@lists.openembedded.org>
References: 
	<DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
		 <83ebfdbf46526c150dcda4d027a5217800113c36.camel@linuxfoundation.org>
		 <DM6PR11MB3962C3B7731F3653247433CFCBB82@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <18D621254B11266D.1924412@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 14:27:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20222

On Thu, 2026-09-17 at 15:12 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> On Thu, 2026-09-17 at 14:05 +0000, Fredrik Svensson (svsvenss) wrote:
> > Thanks for reviewing Richard,
> > I agree that reporting an error would be safe, but it would still leave
> > the build broken until someone manually cleans the worker's download ca=
che.
> > This is not great for automated CI builds.
> >=20
> > I would like to investigate the other option you mentioned: after a pre=
mirror
> > fetch succeeds, update the existing clone by fetching from the premirro=
r clone
> > while the existing download lock is held. That would preserve localpath=
,
> > without deleting or renaming either clone, and normal unpacking could t=
hen
> > continue.
> >=20
> > I would add a test which verifies that the existing clone gains the req=
uested
> > commit, unpack succeeds, and the premirror clone remains unchanged.
> >=20
> > Does that sound like the right direction before I submit a new patch?
>=20
> See the patch I followed up with...

Just to be clear, that patch is a proof of concept in that it fixes the
test case submitted. It does cause other bitbake-selftest failures and
those need looking into and resolving. The patch itself might also not
be quite right as I used origud instead of ud in one location (at
least).

It does however shown signs of being a fix in the right direction.

Cheers,

Richard

