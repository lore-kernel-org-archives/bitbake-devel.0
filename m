Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40BC52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 13:01:04 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.19066.1724245255771818654
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 06:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LPKC8IyA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428163f7635so58181085e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724245254; x=1724850054; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RbiOWh25qFx4Cb1DcCV0HkBoiPaL+e+YbTTKI3RvMek=;
        b=LPKC8IyAkmtBECyBb4B9ftsvNPKY8ecxwhceTmbohUtvv01aQtqeUaMzrOgtl3gh1c
         /rFgu9HukYyjIhp6AZA2hMpog+5icK/2AnqzdoTgyPk/S7kDZUCPc4UuVoxKasbzVS/6
         SLSADD6FE8Oeiagg6CBNOs1XcviXor5e3L9Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724245254; x=1724850054;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbiOWh25qFx4Cb1DcCV0HkBoiPaL+e+YbTTKI3RvMek=;
        b=JMFQqWWjfvz38eyuOrNFhf95L3g4sTsbHNuBfVsPWog8SN5az41ZSgTNnpEpXMn2UI
         ulaD6gUHXU6FlG1cvYkeSpIpScmUpM35ek7niTIskW3V/GNrUO8bPhT2leo5nBbuY/NA
         hkBQBT9Cq85vJv6XPEBbx+Eu2GPW13VdKpZUI91TGMixyTnbBxczP0KILqWUYYkA2YTy
         uEsKtaZ3EVTC9Ne/BceD4Ana5dU5UGKCGeYjV0UGItw7a06R+JAIXbansKc+XgFQ7sxO
         KmDTJwiy8J7P1FF6DeUWJFGBKnErdhNS77glMk54okUniZrlSEETt5LuYzWa/gpCRNIT
         fKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3wtdk1O3fg02UmgjzK3n6jinXMGocfNx9pS2acFxUqPb4tmo7yC41sTn5vqW/sOvRlmjzRX8vA43BNU+W@lists.openembedded.org
X-Gm-Message-State: AOJu0YwfKtitrNgFAbdvZb5R8c2Hef2yvu384+XJN6rO/TspoYUcsG4M
	14UdR7R/JwdUxAXhDsomFGjox2eNLPpCv+AZvLLdu6ll2AYLe+U6dFIDF84bXh8=
X-Google-Smtp-Source: AGHT+IFskn/1c5G+F/5dUvR78vX6DMFZy4IWGP1Y5KSAl8ss+Gx5RSAnoed9BNdkVs38iQJ2ANN0KQ==
X-Received: by 2002:a05:600c:4f91:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-42abf050848mr15355545e9.10.1724245253800;
        Wed, 21 Aug 2024 06:00:53 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:91ef:3f82:9d0e:a987? ([2001:8b0:aba:5f3c:91ef:3f82:9d0e:a987])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef9763esm25836215e9.20.2024.08.21.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 06:00:53 -0700 (PDT)
Message-ID: <4db1b2f7e7f6af14bb5f3f9a37083d5ac10fb3e4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified
 versions in package.json
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enguerrand de Ribaucourt
 <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com, 
	stefan.herbrechtsmeier@weidmueller.com
Date: Wed, 21 Aug 2024 14:00:52 +0100
In-Reply-To: <a094a466-f8d5-46b0-adfe-e515e927b16a@savoirfairelinux.com>
References: 
	<20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
	 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
	 <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
	 <a094a466-f8d5-46b0-adfe-e515e927b16a@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 13:01:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16510

On Wed, 2024-08-21 at 12:06 +0200, Enguerrand de Ribaucourt wrote:
> This patch doesn't introduce nondeterministic fetching because the=20
> resolved and integrity field contain checksums/srcrev that will be=20
> handled just as before to ensure reproducibility. This is true for https=
=20
> and git dependencies.
>=20
> However from my analysis, it looks like if a npm-shrinkwrap.json is=20
> pointing to a local "file" version as a dependency, there is no checksum=
=20
> mechanism, but it may very well be a limitation of the=20
> npm-shrinkwrap.json format. This will only concern users who rely on=20
> local files which shouldn't be the norm. But this was the pre-existing=
=20
> behavior and is not caused by this patch. Specific npm-shrinkwrap.json=
=20
> pointing to local files without a version field couldn't be built=20
> without this modification. With this patch, they will now be accepted
> but inherit this lack of an existing integrity mechanism for local=20
> tarballs as it would have been even with a version field (which would
> not be used).
>=20
> I haven't played with `file` dependencies but maybe this is something we=
=20
> can improve in a distinct patchset. If the integrity field is always=20
> generated in npm-shrinkwrap.json, then we could add the integrity check=
=20
> for this kind of dependency.
>=20
> TLDR: Even if the version field is not specified, the fallback=20
> resolved/integrity fields contain the git commit SHA, or the HTTP=20
> tarball's checksum. However local file tarballs do not have an integrity=
=20
> mechanism, but it was already the case even if they declared a "version"=
=20
> field.
>=20

I think this all makes sense and I agree, it doesn't sound like there
is an issue here with the use of the resolved field.

What I would like to ask is that the commit message be improved so that
this is better documented and the commit more easily understood from
it. In particular, it should be clear why it doesn't break determinism.

I suspect we also need to find a way to test the npm fetcher on the
autobuilder, maybe in a standalone job that pulls in meta-oe and builds
the tools it needs. We can then start expanding the test cases to cover
these issues as they arise.

For better or worse, the fetcher had a ton of corner cases and we need
to account for them all with test cases so we can make changes to the
code without fear of regressing anything. Outside of npm, I think we do
a reasonable job but right now we don't run the npm cases sadly.

Cheers,

Richard







