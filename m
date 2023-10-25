Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C6C0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 09:27:47 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.169488.1698226066157147923
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Oct 2023 02:27:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fky3UCMA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-507f1c29f25so5195185e87.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698226064; x=1698830864; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7h+Ssso4gdMcoOEAMv/0g0yBJMGDIIao6bdfKEIjCZ4=;
        b=Fky3UCMA8mjfx3Q8YwU3Mp4w8dxdH9aupud6dsZ9UEWCBOTm9OB4O7HF8/tX8IxUwm
         Ralv+oEyIo/fkfdZhnxHpjZChexF9JGNM1QOBnXOmaMHlsHu44YaVIX2ikCHFhJMDjqR
         w0WI1XlUoMJd04rHnn/3/HJ9z7+Y3ykOeMs00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226064; x=1698830864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7h+Ssso4gdMcoOEAMv/0g0yBJMGDIIao6bdfKEIjCZ4=;
        b=uFBbdhyCgrU6J3GZmBPKngCX6dXXrBKnTuI9DFpPsmHnVxeHebQmblDNo2fbV3pNRp
         U5mhr8QCv5k/PF1gKw3kQHg2bR5oJmVbTyRKCSyNtTeJwvL61ZWehOl2nYOrhecj9c9f
         5xkTsSzmp748lRMQCoAeJM6vj4Mt0hXseawTNAyr6jkaL2BGE+AuhkoBdj14wPSCOZFM
         X2eKx4FBs845GUcYJHm6cnwokSwBXtuVnw0U4lTVbg5/q6w2E8o768zfBriKjLejtzwm
         +FIdKQ/0qhiv9Pqd8mynKLUk0w1z2TgcU9ORlJzuPQE2mBB8VHna+HL3stL1u3gDySMS
         fSNg==
X-Gm-Message-State: AOJu0Yy+vUJGzA25sy1ApL0RCzGhw1dw1Dc32GKCKeShPnnPK9Pvdk4u
	6FZgwLRJvZdfBuGLGm7Bp9wmDg==
X-Google-Smtp-Source: AGHT+IE5AoeznQDn+MVVk3HIfVdfNBxz0qmiNPC1Fz0sSU1ZlyTvhCeeg5lgk50VlQAOvRYxxFjtYw==
X-Received: by 2002:a05:6512:2ef:b0:505:79f2:5c6c with SMTP id m15-20020a05651202ef00b0050579f25c6cmr10483725lfq.6.1698226064239;
        Wed, 25 Oct 2023 02:27:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:63b1:c4c7:ff33:3a6c? ([2001:8b0:aba:5f3c:63b1:c4c7:ff33:3a6c])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c220600b0040684abb623sm18619443wml.24.2023.10.25.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:27:43 -0700 (PDT)
Message-ID: <b8e4f99865416ec0f1a08e2dbade7a57863af4dd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: Add git-lfs
 install step
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Desone Burns <dburns@seegrid.com>, bitbake-devel@lists.openembedded.org
Cc: Joseph Chafin <jchafin@seegrid.com>
Date: Wed, 25 Oct 2023 10:27:43 +0100
In-Reply-To: <CAJZje+tdOZPp73THMk6pZNLyzncLQcqTRcdyN=v99dJL_=430g@mail.gmail.com>
References: 
	<CAJZje+vcoFiS5rHFn1rvUzmSo-++8VchDzTktSgxKLwD7F0Acg@mail.gmail.com>
	 <CAJZje+tdOZPp73THMk6pZNLyzncLQcqTRcdyN=v99dJL_=430g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 09:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15284

On Tue, 2023-10-24 at 16:27 -0400, Desone Burns wrote:
> When pulling a Git repo that included LFS, it was possible that
> the LFS download would fail with a message regarding the LFS being
> installed in the repo. This change runs the LFS install step prior
> to checkout, to ensure the download step is included in the Git
> hooks.
>=20
> Signed-off-by: Desone Burns II <dburnsii@live.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---
> =C2=A01 file changed, 12 insertions(+), 3 deletions(-)

Firstly, the patch didn't come through correctly and has line wrapping
and whitespace issues which would prevent it being applied.

I'm also very unclear which lfs issues this patch fixes. There have
been a few changes around lfs recently and I can't tell if this is a
new issue, a regression with one of the recent changes or something
else. Which branch/revision was the original issue seen against?

In general we'd expect a user to have git-lfs available in advance of
the builds and not to download and create a local install in the repo
during the fetch. I'm unclear what an "lfs install" does though so
perhaps I don't understand that.

The patch also doesn't change any of our tests which ideally need
updating to include whatever issue this patch is fixing.

Cheers,

Richard


