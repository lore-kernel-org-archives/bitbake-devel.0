Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7584CD4F54
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 16:40:20 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14841.1780072817284547289
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 09:40:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bT7V8eYr;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8acb856a674so167820936d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 09:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780072816; cv=none;
        d=google.com; s=arc-20240605;
        b=R5jBLhOXnCPI4MomZ4HHgMG3mPixAfyI9WawzeihYK4+LhmwDKjkh//32wE7RjxVMn
         4IRB25J2TF0ABCGXbGdPdmWrzp3YazznWf8Wj0+ojtYnE8h/YgZXIjnXCsJrGO5j9MMH
         OFpQCMjy5SVxsT4LGWxK8zP2zQn323mTtIEBuWbyn4lXf/6CYnLj30sjW5Flz5fzS0K/
         7MKYD+9oGY1QgimgM2hLJjzkH3uDJ0Sm4LtGgJy6JadkuUgiuBYa3pUFZIAqSNqRcPKU
         hi2132N7uX9OR3IcF9a6f28ZCZ/w6IGSffbvkXxi9q/dODNtUhG5/ATO+CGHLWBNb/ZA
         xndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wR0SB/hEiSSnfKIZxAChsqad+NE59saPy9BVW12re/o=;
        fh=84xj9XDuYLF0wLQ0yAEsw/oXHkMBlnfXtSMQO8blqMw=;
        b=UuvKMbNqN15U1BS827xEsAeDvmqbkAoZB6fJQl0+79xKPgg0FMeImjNKFW2WoJm4rb
         0Q5RpTkIycuFsVRcCOfam2tP27bhOmXb1hbIrHp25XUNCQ9St40+QfQDpdlx9T2NGfep
         jgqkc+DZkNr5h+JsWLCGlGR4b9x7xVIGTuwT4m3dLHg4AzmOvFWolYy8oc/VUOL2XDZC
         nH1x3j1rQmSIcdOBp/hxc0evvxumUK5fNaH//PbvU3+c1GXG8yUmVYxycsM5vWXmK42b
         HKA6C90PmiKTpxFl4WbtfSwGD/FJwOKqc1ngo+Y6Z0GqBCRffo9oU3rrMkxaQUeJi1+1
         JVwQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780072816; x=1780677616; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wR0SB/hEiSSnfKIZxAChsqad+NE59saPy9BVW12re/o=;
        b=bT7V8eYrzYa/s07c3zPcKuILlIRkXxzbt2qaUoVro27+F7cZt9igYG3axYkLiMpoop
         b1MgglXwwSuQcjRAq2/+eX3cJfDH9gMQonyioeYqHJ7mhpda7CisChQAKt/RyNf79NxE
         RU8mG6tFbY8zvlVFQayw6vE2Y3oGX7wk7DTomCdi065ovVwXM979VnRq1vV/BBpBecmU
         h6Yw+wUTRU+Gl0SIVZQZNTZ6W23hiw8Ixz+BFRsx/k4vqrXFEkq+YoiCbMOTvHrQClpc
         /JAZnx/lgiObL0vd7m9rTA3y/2UwxHHR0xdBsIKmzzQ8S5q8D7/X5si5ccRqAJkgeUYj
         7PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780072816; x=1780677616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR0SB/hEiSSnfKIZxAChsqad+NE59saPy9BVW12re/o=;
        b=h3DM1HKnV22RWaJpVF+tJzFLc80Vjd0TkmThG+Qy0EJm8H0CkMJBY8Gj5XvsVdHGrt
         S+TqCNkNgM9YszZ/2L4Rrtqrjnl2zCxh5HKZCnvSo+3m/KIVjIbbRzgp4DhQJkcFehl/
         HNzjTqGWKVcjifT+UMpgwSLp/3P79OwzMpotmmEY2QitCbdFXL4xBVen5EIYl5yhUkwl
         vMiHs9sL4jd93Abow/GxNhMS/wOdvH7zWdlBTm3F4ye/bZED+hkyMw25Ruwb2EPgBU1R
         ZTlQQcm3GSPmqiK6FWLbiOoLFXa1L2+x+oKL3kdgETlAi5+MlUafnVvE3EBpsKf1kTc8
         Czqg==
X-Gm-Message-State: AOJu0YyjAxNF9bYXENR5Q2xiCeHYyZ00U125YAkyNeqmlskRYf3Qu5Kc
	GobxCZtqsch56pC8E4qBAad7S3io1v/QocTzNqEArQKY1HyaIcTlUnTYG6/Oi48jOp6x+y3TPwd
	tPocYkouEuXBREnAEc4osmcallBME4Aw=
X-Gm-Gg: Acq92OF8b0CK5towoALnja3cRChuoSyFsqlUOfdAN81Qq3CLTEP5FUM5Y35D+4cjAkf
	Pdup4uCQew25cSs0E6hmOANiUYAPMsC3vsAMBiwBzeY5DC0r5PXGsY6bWHoUPt+LLAyo+gDgi/v
	9WEx1O7QBTVN4W3AOA9NIlHkc30oao8l/A69qy0+t6EB6CfqRiW57VhOP9uMWk9tGk71gS+Agmt
	gCJdoyxI3qto4YlOrWBqnmBzWfor71XhXEvJv4g+jT/oxuoIFePsk1EufHg84+ZLP6cptrTv7pq
	OOXgJHtri9kLBeRBgdij93FXz3zhc4c9cypoLHiB3h2GNnXn0Ing
X-Received: by 2002:a05:6214:e42:b0:8cb:e814:67d3 with SMTP id
 6a1803df08f44-8cce4eefe3dmr44897446d6.24.1780072816187; Fri, 29 May 2026
 09:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
 <CANNYZj9FxhgKEfBu0M=1o7pc3RYZ67XdcpOyr5dEKTpmTAWYYg@mail.gmail.com> <tgfbutopbavkq6ehs2g62lkfpw7guzyfpucg46lj2p2j534f2b@aaiam4e7b4xf>
In-Reply-To: <tgfbutopbavkq6ehs2g62lkfpw7guzyfpucg46lj2p2j534f2b@aaiam4e7b4xf>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 May 2026 18:40:04 +0200
X-Gm-Features: AVHnY4IQKugjhMbaKSYPD3a8RdJcwZZVIEf_g5qP09877WhcAqzUMrVu-XtDanM
Message-ID: <CANNYZj-i+koZijvYCjCq74P+ArUW7Aq9kcpJ5j_afCyXKJyDow@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: support default source overrides
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 16:40:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19568

On Fri, 29 May 2026 at 18:06, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:

> Thanks for your feedback, I understand your concern and was not sure how
> to go about it for that reason.
>
> Yes, that's exactly the issue I'm facing. We would like to have a "dev"
> and "release" setup. My current idea was to have the "dev" setup be the
> default, with all revisions pointing to master/tip of the branch and use
> source-overrides to create a "release" without relying on users to pass
> it correctly.
>
> If users have to pass it on the CLI, it also creates an awkward
> bootstrapping where they first have to check out our registry locally
> before setting up the release build.
>
> And if revisions are tightly specified in the main conf.json, it's also
> less straight forward to update it with the current fixed-revisions
> system.

The overrides system was added for a different use case. We wanted to
support CI systems which need to set up a build from something like a
pull request, where one of the layers needs to come from a developer's
branch, but everything else should remain standard. Another use case,
added a bit later, was to write out fixed revisions override, so that
a build that was set up from a floating revision config, could be
reproduced exactly with specific revisions that were resolved at that
point.

I agree that supporting multiple sets of sources would be useful,
perhaps you could look into adding a "sources-overrides" section into
the json, which would contain multiple sets of overrides (e.g. 'dev',
'release', 'oldrelease'), and then the UI would allow selecting one
interactively or through command line? Unfortunately 'sources' itself
can't be extended like that.

Alex

