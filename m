Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB14C27C65
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 11:22:41 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.16997.1718018552246806048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Jun 2024 04:22:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e+aWvQje;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so1174741f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718018550; x=1718623350; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kYC5F2Lfk2kUzPNJtBgBco8lnamjzIj2p41YHgklygo=;
        b=e+aWvQjeupDEY78URypOk9Aoq+HVYYfAeRAUHzDmo20+NJqR4sBR7yiKAbyQ4F39U3
         LUf8xozCcqhCLRlQnMyT2T2Q47MhSsCo0b+6NF65PleQ9ByzAtxEN0sEYaGouvE+6buW
         MQIRtLdQoUPDKFHGgxUo41inQDbycYtnTB7Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718018550; x=1718623350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYC5F2Lfk2kUzPNJtBgBco8lnamjzIj2p41YHgklygo=;
        b=WnroMdpJxYEgS9WP7+jNEN2iS/me6ViDgIkKD8krLp/T3Ij2nxqlPx51sTHt2J+Tp6
         xDpyzr1LM8IqhDcTu1R9hTSrEaYE2s+6TBNhDkCcdQ1YD/5nKHNKa2LORDd0FBBgRzBN
         eS4IsGG6UiXdrh4st1YzGLUlKza+yWpdt9Xz/I8PbJXzpYjSGR/sNB7DD2ffCCCJriuK
         lG+HOADDMTy86ONwXvgvXSBgPohOxado9bMSQJD/BE/8Q25y9ghpHoEbD2wICmtBUxVh
         1pxPN4kl66t8HGnMU8BI020b0JMCNeB54GdXM7DK9r5INBgb0jG1YqL3Ph0619m6OnzB
         Nk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvrMT00bFjSN+rp6voc7nfipHLKeaF6NHl7OFeU8I1NVcJsVc0iw7ig0lEgvHCEkXHOLuWJ6Mf9D0RLc8/g4fzIqLjDNpxW4mWi9+G8McKk3n0sKo=
X-Gm-Message-State: AOJu0YxwNIt4v/2CVRtHKJNT21rifYf+2zdtz2XxX/oCGp1DgqSUEGBQ
	mNf59pnp6a/1ACen+L5TkyICcCqrkNFaY6sEy790iV5rfvByqV8jEb+Vm7/yAlE=
X-Google-Smtp-Source: AGHT+IFLHWGE54jNM0I3k4wFJkjhswmKldUpslyPk+OEuNXucZSaRNw6PKV50I0DnsS1M7PKQE2mwA==
X-Received: by 2002:a5d:42c8:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-35f1f1959aamr2563210f8f.33.1718018550314;
        Mon, 10 Jun 2024 04:22:30 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fc3b:77d4:176b:a54? ([2001:8b0:aba:5f3c:fc3b:77d4:176b:a54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f11cc5061sm6377363f8f.5.2024.06.10.04.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:22:29 -0700 (PDT)
Message-ID: <17fdbe98636e4e93ba2f7dfd52e294d2fb479ff3.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [RFC PATCH] bitbake-setup: add the
 proof of concept implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org, 
 yocto@lists.yoctoproject.org,
 openembedded-architecture@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Mon, 10 Jun 2024 12:22:29 +0100
In-Reply-To: <20240502105745.3073153-1-alex.kanavin@gmail.com>
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 11:22:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16343

On Thu, 2024-05-02 at 12:57 +0200, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> For the rationale and design guidelines please see this message:
> https://lists.openembedded.org/g/openembedded-architecture/message/1913
>=20
> Left out for now but will be done later:
> - config fragment support
> - tests
> - documentation
> - official configuration repository

I finally got around to looking at bitbake-setup, sorry about the
delay. For some reason I've been struggling to want to start thinking
about this!

My initial impressions are really good, I think it is a start down the
right path for what we need. I've noted down my thoughts as they came
to me:

From the init command, it isn't clear what build.sh is for. I think it
should also mention the traditional build env file too, make it clear
where that is.

I struggled to find the --build-dir option to init, I tried to specify
a direction as the next parameter but that has to be named.

For the cloning of repos, I wondered if we should have some config file
in HOME with a pointer to a central downloads/clone cache? The
autobuilder will certainly need something like that. Whether we could
use a common cache with DL_DIR remains to be seen too.

I'm not sure I like the build config being moved out the way when
updating. The tmpdir "ABI" and conf file versioning should protect us
from the worst problems?

Also, once you're "in" a build environment, can we can bitbake-setup
without parameters, i.e "bitbake-setup status" and "bitbake-setup
update"? Effectively that means teaching init-build-env about the
environment it is in so that bitbake-setup can then read the right
config from the env.

For demo purposes it might help if we could add a "poky-ng" config,
which would be poky, but built using the config from the individual
bitbake/core/meta-yocto/docs components. That shouldn't be too hard to
add?

I'll be experimenting a bit more but I wanted to give some feedback now
I've taken a look.

Cheers,

Richard


