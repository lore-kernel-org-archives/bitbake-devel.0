Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B3C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 11:09:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.9192.1742296168491800068
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 04:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fw1vuw0b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0618746bso23811625e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742296166; x=1742900966; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lByDqOid6YgHvH2ty8TjjwdsxO5mmqelHPbymGlxAAA=;
        b=fw1vuw0bkpHhDZYzEfCF7hLo3DPurfFNqzGTx5k5D2oE1vNK5lyQ0xseqWP/jCCQZA
         OXELWJbsDSXJ+QKE8kZJpA77JpkUl5CARMiFsnD/dScf8mdpUpxg1NwtWPybh//m532s
         UymtBxaStw8p/uO8kIjWWjTqDMfaF1H3QZVWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742296166; x=1742900966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lByDqOid6YgHvH2ty8TjjwdsxO5mmqelHPbymGlxAAA=;
        b=qyVgrWVJ9f+NbN96KB6Soxc68IWsYK1YWeaG1Vq2X2edgJ81lIz1lOwyOlmtVFADhe
         D6GpXdZjUQYPL26AGJ1Hv5fuXu/zASnTXEZ64ND6M9AGyktti53/IbAxiAhK508/XOkL
         jnRECrj+qvfgtSEJ6AwWS4SUMH/UmuAMJloJVXfYg1X1RHBQUKPilIcMP05InWV2a3jP
         HNaeF+V77069XPmUQMbU1aTyad+vn3yLrjKeCLh+x/6JxO/b5WjvG/QpKQE/SM2Lke0N
         V/x+x6ax8q3VjSOyk/ybZtCyw3u/DyLCehfguFNvpITuP5P74HfVU2edM2Yvmb3Efzrm
         BGJw==
X-Gm-Message-State: AOJu0Yxjc5zmUdmieiDJrZMRQ1PkujtIT905xzyOnwBFqJaf/JGO7502
	+VVBxYveZKxX6kBBW7zOdA6ihM7eaUiaP3UrlNwjsEWV13kuTDsg5BKvxYufpg9c3GZ/ggW/n6U
	l
X-Gm-Gg: ASbGncvZVmAL7blBqjDhUa2SAVtFr8jSks5ItH/O5imI96FYARJtMG9Fo4Ax+UJiv0S
	DvJNNO4PGHAWDt7YDb7MrvA8nM6K/pcC6dnyLRaNcrF3uA/xkRe3BHhXFGHZq28LmSi6huF4GLO
	iZKLCO5/VQD9ihODR38lC+DH+ZRYXTUr38mVo1eLAKAL52UOG7iJP06FEg2mDPOlef06aWWSzgf
	nNreQTJwWS+UYartFjJ1To3dwhjFSDlbfU2OzfsuLucO8ftmhcfSFfai9qPUBO205Ya23Jcp8ky
	gxKzPJljDqDiGf83KEnwDTSNaveD8o5JVEft/lFL/kW0cDyoDjibDLiJnabUPi40T04576mACNl
	QsdeLKclQWD3iw/ht595uDVKr5lUqn5Q8CQ==
X-Google-Smtp-Source: AGHT+IHhy2RLl5nC3IlDoo1/jnCQ23Jh+eEyA1vo5RH8fiOeHRKR5NsbVHUyzdIwFj5fTmoLkQQzKA==
X-Received: by 2002:a05:600c:3d0d:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43d3b9ce0b5mr16428005e9.19.1742296166140;
        Tue, 18 Mar 2025 04:09:26 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:791f:f4e7:28a8:7096? ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60d37sm131132985e9.27.2025.03.18.04.09.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:09:25 -0700 (PDT)
Message-ID: <e9ba3c48c1362ab5dea20ddbb0bc8591673bde52.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Mar 2025 11:09:24 +0000
In-Reply-To: <182DE10AF4BD4C6D.22901@lists.openembedded.org>
References: <182DE10AF4BD4C6D.22901@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 11:09:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17452

On Tue, 2025-03-18 at 11:07 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> Currently bitbake disallows tag parameters along with revision parameters=
.
> This isn't great since quite often, we'd like to verify that a given revi=
sion
> does match some tag. At the same time we don't want to or need to access
> the network to verify this, which normally a tag would require.
>=20
> Rework the code so that tag and revisions can both be specified together.
> Verify that any tag specified matches the revision in use at unpack time.
>=20
> This means we can start requiring people to put tags in git SRC_URIs
> when revisions are used, making review a little easier that it isn't
> some random revision.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 13 +++++--------
> =C2=A0lib/bb/fetch2/git.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++++=
+
> =C2=A02 files changed, 17 insertions(+), 8 deletions(-)

I fixed the get -> git typo in the subject...

Cheers,

Richard

