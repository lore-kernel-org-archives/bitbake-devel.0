Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BAC63706
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 17:25:22 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.21920.1670433918505081838
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 09:25:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e0HL2Zid;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id co23so1607277wrb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ui6vrBPK3l9wyE0Y4jgaI8qoAQm0NisYsPIDQS5fIk=;
        b=e0HL2Zido767kTRLzyD/P61IDytujpsS8Vvjgw3QNO0aofMpBeLeD6qH864vx9IePg
         mBflrBZma/5COLrBISOScQDfeC1gSWGHqDx2vUWG4vQDZe4SDzOJDmuKO9OIb6xlSgXr
         DYWo8r5rhQbOeT11wkt/Rrg35P3LEkJmGPPQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ui6vrBPK3l9wyE0Y4jgaI8qoAQm0NisYsPIDQS5fIk=;
        b=eRAQakTCqKq7eCbSLiFvHjTwMGJ4fzOh+8aRibqqt7Tj5XFqhX3Zg8bfEm9PKNEv1x
         gm8gfNCR4mHrnCIDwwr1sb9f41lO9DKOJJBsLHUuUV4eKm9umk+ymVJxfRpZVS3MGBGx
         /s7J6sKIVcLST6R/QK4VyRy7O/yMktBnJnZruQXMjqoT/HjRbzuQWmUZ8AeEBh0vuRkZ
         Ad53aL2GWd2HNvHdH2ozf5v5yXCLPf1q+FcO1UfBgt6qI559JUI1TUsRA1ihL29UIgi+
         7uCkTjUBskbW07+bdWWmkGtpQelDlrw2KhoQGuaE0hQ38F+/Skr/uZ/WeIW5x5SWdyp+
         7jlg==
X-Gm-Message-State: ANoB5plC+W++j+VJ+rr/2QKr9izSKi+igyDh6JanmrKY5/5ZH1Kh11GS
	nga3h0Zv6MLJcQmCYXLng2LP/Q==
X-Google-Smtp-Source: AA0mqf4Vt7rakxgHZTSz9mTI30WeEAZ6AKfHIy1m69A2z5hFsGERHQnUEVITOdqUj4hCmRRqe3SJ6A==
X-Received: by 2002:a5d:554b:0:b0:242:84c:8d2 with SMTP id g11-20020a5d554b000000b00242084c08d2mr16852088wrw.555.1670433916876;
        Wed, 07 Dec 2022 09:25:16 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8? ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id y2-20020adfdf02000000b0023657e1b980sm19565905wrl.53.2022.12.07.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:25:16 -0800 (PST)
Message-ID: <e1db3a7a221bcdbe3508703c7a8d4ae107a80b70.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: Add support for addpylib conf
 file directive and BB_GLOBAL_PYMODULES
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 07 Dec 2022 17:25:14 +0000
In-Reply-To: <CABcZANkBcRoqU3nk=i+Jv+343UtKeyJuDGCN_jjVjhGBw+UZgA@mail.gmail.com>
References: <20221207141539.2129083-1-richard.purdie@linuxfoundation.org>
	 <CABcZANkBcRoqU3nk=i+Jv+343UtKeyJuDGCN_jjVjhGBw+UZgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 17:25:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14146

On Wed, 2022-12-07 at 08:31 -0700, Christopher Larson wrote:
> This looks great in general, thanks for working on this. Anything is
> better than the current hack, and using a proper directive seems
> clean. It seems like BB_GLOBAL_PYMODULES and BBIMPORT will be checked
> in every addpylib directive, though, which seems to indicate that
> metadata which doesn't have any addpylib directives won't get those
> variables processed, is that correct?

That is correct, yes. We're assuming BB_GLOBAL_PYMODULES is set before
the first addpylib. I was ultimately thinking that BBIMPORT could then
limit scope to just the current module. I should perhaps just make that
explict now?

>  The semantics there don't seem entirely clear. It also seems like
> the import happens right there at the addpylib line, so it's an
> immediate operation, right?

I think so, although the statement cache makes this a little unclear
whether it is immediate or end of file.

>  To be expected, but we might want to mention that specifically in
> the docs and/or commit message.

Agreed, I'll make that clear. Thanks for the feedback.

Cheers,

Richard

