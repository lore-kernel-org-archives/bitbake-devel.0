Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E44C4332F
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 16:01:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.53894.1671552082950586127
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 08:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S8WK8Y7S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso9176065wmp.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEkIYpQt4PFHSIyVcgNZgdZhD9HuOLPl7a0eXfRyZD0=;
        b=S8WK8Y7Sy/Svv/CoIL2Xj3tN1+aIm8JF1V/Ez22UPv2N5rtSj3MpYk0jM1WHyTsQ/p
         XikNacUG1Zfw4kIn7I6Ad0skkXZXhVvVlwpProzyZhp9v5ZuccS2jILuivP5C8D5TtT8
         uVAFTh9IDlas99j4dPNH6qhN5sMpk3tMjIaa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEkIYpQt4PFHSIyVcgNZgdZhD9HuOLPl7a0eXfRyZD0=;
        b=q/JWns4Hq6Ib/L8UEVbdCR9hbW5rOu4le4Eh93Lx3h3f2Oo4xfZDnYtlmpMOz/gQYV
         qKYTKvBnILRMtd1vz/1rQFyClTOK6EwPQsHOMEPtYSMFRia17qJCrXDS/H6jxXjbU6DM
         PLak5YE/R+L9c78ezjyABpujK53J3avjZyaw1QO09lpAjtRIegOzwoZBq6mDysk45mA8
         tYDKgGHgfR6lWk2GW56mGJ1GqiosbES04p2wg+O8pTsqQ0rroC4PmvbWSs7nvKbE+sHI
         9SbNNYb4aUCRPS33+egWcek95yOqmrjegS6rokt0BUTZwNxjdTHv+iLX3QddTCUWDPeV
         Hp/Q==
X-Gm-Message-State: ANoB5pkFrKSlmqYNkR/r8iB/ggD5WOD1lpjhrzaTbTghzUSTtebTwp5v
	kh2vjTSWEcCkzfeBsUwNiNRmeg==
X-Google-Smtp-Source: AA0mqf6EYu8EEyur4LsULz0hteX4nd3SW1ixfSTIV3rhVkn4CrUHZ3y9Wk8p6t0Mrz4WaI+eX7bz4Q==
X-Received: by 2002:a05:600c:4f14:b0:3cf:e91d:f263 with SMTP id l20-20020a05600c4f1400b003cfe91df263mr35693499wmq.4.1671552081213;
        Tue, 20 Dec 2022 08:01:21 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1273:dbb7:632c:a9de? ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b003c6b70a4d69sm15976719wmj.42.2022.12.20.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:01:20 -0800 (PST)
Message-ID: <63cc3aef01919483dcbe92f0520cd5b06bbd3298.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Enable to use some bitbake server
 commands
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yosuke.nky@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 20 Dec 2022 16:01:20 +0000
In-Reply-To: <27383.1671457713988336797@lists.openembedded.org>
References: 
	<64b26408f1b87a4b8e58268cb9529e0952c30582.camel@linuxfoundation.org>
	 <27383.1671457713988336797@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 16:01:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14215

On Mon, 2022-12-19 at 05:48 -0800, yosuke.nky@gmail.com wrote:
> > It looks like we may just be able to add a dict() wrapper around
> > the return values if these are all defaultdict objects?
> Sorry, I forgot that some commands return "collections.abc.KeysView".
> Therefore,=C2=A0enable_marshel function in my patch is trying to cast lis=
t
> and dict.=C2=A0 =C2=A0
> For instance,=C2=A0dataStoreConnectorCmd returns
> "collections.abc.KeysView" when subcommand is "keys".=C2=A0 =C2=A0
> However, dataStoreConnectorCmd has so many subcommands that we have
> not been able to verify the return types of all of them.
> Perhaps we should consider removing dataStoreConnectorCmd from the
> scope of this patch, as we will look into how to fix it properly
> later.

I think that would make sense. We may end up having to document that
the datastore connector can only be used on local connections as that
functionality is much more complex that the others.

> To make matters easier to understand, I created gits file for
> reproducing the error with tinfoil, not with my private work.
> https://gist.github.com/AngryMane/9e0f57dac862b209ae406a729c4fa4e5
> You can reproduce the error by following below steps.
> 1.=C2=A0bitbake-error in my gist and copy it to bitbake/bin
> 1. source oe-init-build env
> 1.=C2=A0bitbake --server-only --bind localhost:8081
> 1.bitbake-error
>=20
> Please note that this error occurs with only XMLRPCserver and
> ProcessServer doen't occur this error.
> In other words, the problem does not occur except in use cases where
> the bitbake --server-only option is used.

Sounds good, thanks for putting that together, I'll have to take a
look!

Cheers,

Richard


