Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A40C433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 13:28:02 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web12.68.1635859681577147724
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 06:28:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DqKolmja;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id t30so8482627wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=IDQ2wSqYXqWv7fRbfDzLZ0dZ7Apu+0tZQ0ADaQznSOI=;
        b=DqKolmja2m0Lm9ChqdAonb4RZdys4g3ou5sRCNRvBUKMT16ztL3DgEhbUjwFYyKGFK
         1MG7edDRJRIcONOwZeJsvLbgQnu3qE9Qw4uu8KdjQ8vCRcEDJNSyPQeKR+Ns0rMM4YRE
         ZC5reZiOUWkL1ltfeLZ86Ujv6hgXUlCWHGK6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IDQ2wSqYXqWv7fRbfDzLZ0dZ7Apu+0tZQ0ADaQznSOI=;
        b=DYN5XmUQHAbju+HBBwhIC4o8QrmLNiFvNxNIimxzDEtzbCgCWTSeZ5HY4m2nXq1yBo
         k1xHvxpfMpDiUBPW/9ZZkMQbSmxbq50gFf2rDycy0euBEt4omwEcF1F1gPCfd/Au3vD5
         f96Wf5hv/i4nkL28/mlNZ2dwGJKuhEwsCtTKfFyyDKKKP92TRnm/8EMOJ+rM3hPspNn5
         b4ATLxmK5+csmIQ2qz6toOGl+4VqbjItGOs7RjHy+3EwJIHGS6F0F/Y71io4GwZOZVEe
         cpP87B4Xf+iJ2aPqiSd9PMxnYu2dls0QgpDhPw4256iqoZ8GRKJKv86N/d/d7EOVT+gv
         uAGg==
X-Gm-Message-State: AOAM533xzKEQO8/jB+QLH4K+qkrmTqrHTlq8K854ubNsJh3rghHGWxx4
	BOp8iMvhjCV67ntAEeDaeF6E7A==
X-Google-Smtp-Source: 
 ABdhPJyRv6LmFFO0E1byEiE8qFXb/Amc5IpTxfejO7rPeMFx7Zf7Hh354bs3GJNI29F+QQzqq4ioxQ==
X-Received: by 2002:adf:da44:: with SMTP id r4mr48057321wrl.180.1635859679998;
        Tue, 02 Nov 2021 06:27:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e05:60cd:475e:19f5?
 ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id 9sm11460324wry.0.2021.11.02.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:27:59 -0700 (PDT)
Message-ID: 
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 02 Nov 2021 13:27:58 +0000
In-Reply-To: 
 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
	 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 13:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12859

On Tue, 2021-11-02 at 14:19 +0100, Konrad Weihmann wrote:
> 
> On 02.11.21 13:44, Richard Purdie wrote:
> > github is dropping support for git procotol iun git urls. Add code to remap
> > this to https in a way that could be used in older bitbake versions.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/fetch2/git.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index e974445fbe..f5be24d6ab 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -142,6 +142,10 @@ class Git(FetchMethod):
> >               ud.proto = 'file'
> >           else:
> >               ud.proto = "git"
> > +        if ud.host == "github.com" and ud.proto == "git":
> > +            # github stopped supporting git protocol
> > +            # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
> 
> While having a warning within the bitbake is something very much 
> appreciated, I don't think it's a good idea to remap to https here, as I 
> think rather the recipes that still use this should be fixed.
> This will just lead to non-core layer (the ones being not so well 
> maintained) just ignoring the warning and leave the original offending 
> recipes as they are.
> 
> I think this solution does scale very well.
> For instance this assumes that github.com is used, but I can also think 
> of DNS aliases, where this rule here simply won't catch up... same for 
> the fact that other hosting platforms will likely go in the same 
> direction and we would end up with an ever growing condition here
> 
> Bottom line: I like the warning, but would rather insist on the recipes 
> that still use git:// + protocol=git to be fixed - at the mentioned 
> 11.1.22 likely fetching them will fail with an explicit error message 
> anyway, so I actually don't see the need to magically fix up things here

With 15 years of legacy branches and recipes out there, this change is intended
to be backported to older bitbakes to at least give some support to people stuck
on older versions. This is why this commit and the warning are separated.

The warning is being added as we're not at 11.1.22 yet and people have
previously said they don't like instant hard breaking error messages. We'll
therefore give people some time to update, then change master to an error.

Cheers,

Richard




