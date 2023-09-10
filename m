Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24984C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 20:18:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.43950.1694377082409168450
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 13:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ndxc4vmI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-401da71b83cso42858895e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694377080; x=1694981880; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cd2N50qR+0Sn3Aw/cpQdyohXG+wD7d9swHPsvqOBADw=;
        b=Ndxc4vmICv9TYrrETMztGhNYPdB8eDxmVKnCYe5RJZBaALJe0aSIcQpzUzzbLRVktp
         lXW5w0BpQaf7JsTkSVSYbmnF5izAzPlA+XftjJhKbU7Pw/zDaqqmdaQzTAB0MCF4j9YC
         sp6aIHB6A7lanwRKev3MPKAnAfkmveO/X5L14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694377080; x=1694981880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2N50qR+0Sn3Aw/cpQdyohXG+wD7d9swHPsvqOBADw=;
        b=kcmiz7wunc2ggjUHBG4AlP9fqAf+eT+58RSt/muXzYQmDGID4xjkIG3BVmwhNxfNnQ
         QC9ILq2NWLMFB00XjI/S4Tacnv82N9baOWzxVQK4C0NHcw5ZDAPdUYvzS0XwbOFrCzht
         0edcxU6RrtSytdW+XSeuyv7qJpXpuAIjCKQmqQebfUSavGCyn9+Q0sW4K1hsYbBRb3Z0
         mbGSe0OlkQGuGwMZC88w7bNDOIsNMeJf/AHuWVk3Lh30ZYigZNi0jKdgUo7UES7E92vh
         aO7GPMj5JHz77DK7GYrxowznIS4UQWjLd+FnRoyK/hJcHOAlB49/CMAuPFrntjWHAlQa
         YXVA==
X-Gm-Message-State: AOJu0YwHJ91jjzywbU7chUUZZzgRhXlWn+YysJCuj0qEFAE3VWEco3Y/
	NtFN5LvWvuHJw9o+UPZ2Vv1doQ==
X-Google-Smtp-Source: AGHT+IFW1hAOFiMkinMDa7RdUH5u0GZRjYGPgw3+ebgci1ZrB1IiHjRRf4Wjh0pwfFSvn+kqYio8Qw==
X-Received: by 2002:a1c:7716:0:b0:3fb:b248:67c with SMTP id t22-20020a1c7716000000b003fbb248067cmr6892578wmi.22.1694377080056;
        Sun, 10 Sep 2023 13:18:00 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5580:ed73:9c6:f365? ([2001:8b0:aba:5f3c:5580:ed73:9c6:f365])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b00402ff8d6086sm5806416wms.18.2023.09.10.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 13:17:59 -0700 (PDT)
Message-ID: <72eaf44b3c86582c73a9cf76ccba2378a0e83c6c.camel@linuxfoundation.org>
Subject: Re: [PATCH v2] bitbake-worker: remove the network flag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rs@ti.com, alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, denis@denix.org, reatmon@ti.com
Date: Sun, 10 Sep 2023 21:17:57 +0100
In-Reply-To: <20230910194648.942409-2-rs@ti.com>
References: <20230910194648.942409-2-rs@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 20:18:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15028

On Sun, 2023-09-10 at 14:46 -0500, rs@ti.com wrote:
> What I feel would be the proper solution to the aforementioned issues.
>=20
> Examples of layers that currently use the network flag outside of the do_=
fetch
> stage:
>=20
> 	oe-core (icecc.bbclass)
> 	meta-openembedded (go recipes)
> 	meta-flutter (all flutter recipes and classes)
>=20
> This is not an attempt to shame maintainers. I'm just curious why the net=
work
> task expects every maintainer to handle proxy variables (something pretty=
 much
> required if you are actually using the network in that task) independentl=
y. It
> just results in needless debugging and a bunch of patches attempting to e=
xport
> variables in their own way. Sorry if this comes off as antagonistic in an=
y way.

You are doing yourself no favours at all by posting this patch again.
My instinctive reaction would be to filter all your mails to /dev/null
from now on.

You have to keep in mind that bitbake/OE allow you to do pretty much
anything from metadata so it is hard to put boundaries and any that we
do put in place can and will get bypassed. We've gone backwards and
forwards on these issues for a long time.

The "Yocto Project Compatible" status was born out of a desire to at
least make it possible to highlight layers doing things which could be
considered anti-social. We haven't quite caught up with network
enable/disable there yet but we should and likely will (please file a
bug for that). Sadly the work in maintaining that standard is more
complex than people realise, e.g. a new revision of the criteria has
been held up by a YP website refresh for over a year <snip long painful
story> :(.

We added the network flag since before that, code was doing pretty much
what it wanted anywhere. We now at least can tell exactly where the
accesses are being enabled, which is a start to fixing some of these
issues.

icecc in OE-Core enables it since by its very nature, distributed
compiling needs the network. It is unlikely to need/want proxy info
though as it will likely be local network only.

go needs someone to work on the fetcher side of things for it. We've
solutions with rust/crates which might help provide a model for how
that could work in the future. For better or worse, someone does need
to spend time on it.

I've no experience with flutter to comment there. I will note that most
of these "new" things start with basics and things like proxy support
have to follow later as they're not top of people's minds when they're
trying to get anything working.

I am frustrated in general about a great many areas of the project
where things don't get "completed" to the level everyone would like.
Over time we do have a good track record of sorting them out though, I
just wish people could work on them proactively rather than reactively.
We do have some proactive work happening at least for the first time in
a while with the RFQs.

I do understand your frustration but I think you need to work out a
more productive way to move forward. The network flag did at least let
us mark up and know where the issues are so in that sense we did
improve on what went before.

Cheers,

Richard

