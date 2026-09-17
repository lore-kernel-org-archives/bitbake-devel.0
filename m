Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782BC88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 14:12:33 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40515.1789654345185221258
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 07:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N5+hOnTB;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so496684f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789654343; x=1790259143; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8uO/WT36bhhRJs7vKQZ6DxInp1YxQFmYgjGsV6B23+s=;
        b=N5+hOnTBqNHw+jlf+hLo2RnsBPE6E14ostKkNTMlar47+jAlNVW2QdWv0HYWdeyL3V
         1Gc/BH2exGU/QYNBe0pocRzH2aCosv3dBPF72RQ1rEbxC0fHn3jeEdVu+zrjCm8+HB/O
         aIBzNcLAWDBGN7fSBLtej0oAuG6bPGpfmqS94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789654343; x=1790259143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8uO/WT36bhhRJs7vKQZ6DxInp1YxQFmYgjGsV6B23+s=;
        b=ckieCRzV6xoJHp8i8QjBklLLSLbihBLKzDxP0hph/SDiRBd96x5kJu8N68yy+Pjk0n
         Rb5Q8An72nU5dC0QiVnLzSIISgSQKfzJ+D+3DADC6jgp5AoIFtfY4YWbt9MefNMakG4Z
         v9Hhx67dRqJ3ki4a4Cydfs7L6aLgRjm2D+LHbJj6BlthEvC9FJWWkvN1bpLbuMUW5Kd5
         4k66DwZGePYWL9UU9ilmpjuwXg0bt9IlY9YVPlHnImiveUXL7dWDEKDaoOI1r256xakP
         HrLcf9UwU4/fD7gmg26+NWOxqfgLMTQnVcY3hLs6WJ4f2W1xXHIxvk9jlbI1ZFLaGvTn
         eT6w==
X-Forwarded-Encrypted: i=1; AKwUvBytIR0Ew2om9nzAj0b8xi2Yude+0aX+KCYcll6M6GM6Jtvfa8d/VJozOIuz7g+OY4Jxq9TJ+gu9hZhLkPnZ@lists.openembedded.org
X-Gm-Message-State: AFuF++lapMG1P/rxXqY8HxLeWv94GaU37mQAQ5sFu3IWrAU20Tn+ziuH
	PIs8LGOa/jhLF4IJ+nXk2JrOHDXb1xYAexRh4jGdhBvEk02Q6kzK/mLdchEpVhghaQs=
X-Gm-Gg: AYBFou1HzSf2CBffkEgxZBvaMrWwxKoUVjE1AhcvjXTA9uRfxROuU/eWK9N+BdqCfh0
	DhsyNRN7sHAtgDQrI9NkYRuCU5LQuZ2QvUTDDk491a7dNyiAhjMp3HUrwP/Bf/gQbtjm41UJtXt
	E1Xc19iyIDaoOsuTvQcqRalj7L+K81Vxc6aoAZrCM8iTMKWmIoR9N4zWSZwY3sBuHXustwlks3Q
	Niu7qeu+XY3/ilSCbktRNd1sWLLE6wcWb0FXDmiwJ/tsTcqGGdGvDcdI+x1FNf+W7INtMZcxHrM
	0hR5L/96mq+6X48Mb5NKEmCjbcfYF9h5ccN2G82G8N7JWSq5HNxVugqTVzzWJeK5WM3JSREC9dB
	99C1DLxmRG/ZpCXS4wI1x3yEZta+dFGZcmTGhzz/McbtnfR1f3UjJi73kAm1QPRibwRmmtBTou5
	hULFHGxeZK3PXU51iHm0m1usksRxNncMmMHThPqwAmq5yNczCotPrHgWnQv6iRSBN48F6igsKUr
	/27zvckh60mHJ56eMev1sWkA6qPeGFmXRmXwK1GsFM5MYwA/bcLy9ne61VFShVX7fIoS+wfaes=
X-Received: by 2002:a05:6000:2401:b0:485:ac3b:4a79 with SMTP id ffacd0b85a97d-4870d03bdb4mr8778120f8f.43.1789654343286;
        Thu, 17 Sep 2026 07:12:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4507:59aa:c79a:ecab? ([2001:8b0:aba:5f3c:4507:59aa:c79a:ecab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf438fbsm16451778f8f.36.2026.09.17.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:12:22 -0700 (PDT)
Message-ID: <281fbd0da4194607650b292a8765da92e67e8d0f.camel@linuxfoundation.org>
Subject: Re: [PATCH v3] fetch/git: unpack from premirror when cached clone
 is stale
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Sep 2026 15:12:21 +0100
In-Reply-To: <DM6PR11MB3962C3B7731F3653247433CFCBB82@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <83ebfdbf46526c150dcda4d027a5217800113c36.camel@linuxfoundation.org>
	 <DM6PR11MB3962C3B7731F3653247433CFCBB82@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 14:12:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20221

On Thu, 2026-09-17 at 14:05 +0000, Fredrik Svensson (svsvenss) wrote:
> Thanks for reviewing Richard,
> I agree that reporting an error would be safe, but it would still leave
> the build broken until someone manually cleans the worker's download cach=
e.
> This is not great for automated CI builds.
>=20
> I would like to investigate the other option you mentioned: after a premi=
rror
> fetch succeeds, update the existing clone by fetching from the premirror =
clone
> while the existing download lock is held. That would preserve localpath,
> without deleting or renaming either clone, and normal unpacking could the=
n
> continue.
>=20
> I would add a test which verifies that the existing clone gains the reque=
sted
> commit, unpack succeeds, and the premirror clone remains unchanged.
>=20
> Does that sound like the right direction before I submit a new patch?

See the patch I followed up with...

Cheers,

Richard

