Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A91FC43458
	for <webhook@archiver.kernel.org>; Sun, 28 Jun 2026 07:29:52 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68766.1782631788019169775
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Jun 2026 00:29:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GclqKGst;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a623d3e7so1426025e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2026 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782631786; x=1783236586; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqBI8IxLOeP8ww1OP5C0AJMDiYu9OCs2/eKaB1ype+Y=;
        b=GclqKGstQDf9rpRap91FMtWnHxh67gx4KfgUZYzQC6WyVQCFNJZi3RNoQ6Fu2kMB9G
         j4aCPe/t3tE7cNjCy2sq9z9hIpo8I9uaJg8p4+hpSr6cE/7dG5Za7fNkzJbC4FBjErLv
         +qMSJSJK1sxWRHxpPPkce7W+qjq/gH1QKf/9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782631786; x=1783236586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqBI8IxLOeP8ww1OP5C0AJMDiYu9OCs2/eKaB1ype+Y=;
        b=GDgmLm/YDWSzn1v7Dz4iPcO4j8Ke4XseHZLN8/YR3Wg27ON4eaMFY1NnqjyA/86n+j
         W5p/nFbBCi7kUYg5kxjwIBl9p/O7YH3U3/jS6akFzQdrZrjK/VUJXsUN7cjWIJX7/2ak
         MGC2gGXRnADXDN56HLhyblkSSpk49mD4do6IX/19BZ0yPBtuwfEkzApHBoQoiEN+hJTl
         qbGvxf1vmJiqu5RF88yLa5o/G6UH4j/Hg0sT+bmL6fQZsyG0B/k1tlzTlXqa1Ip8/f0k
         x7aUUGFgIerjZFbhsPUaZnmqaYkhpZr1OI055y8NRkf5LE5lnvAomRYwwJpK7sSEirVk
         NiEA==
X-Forwarded-Encrypted: i=1; AHgh+RrAkQuidYVjYsfLKSdXuOTQNJVzXdXtYtWM/le1GgIOoD5BQEHygncDrar1yIacIVOlQfyK7jvspFhkFEFp@lists.openembedded.org
X-Gm-Message-State: AOJu0YyiH6ywOoNiO5DadSyP/jYWXdrZYpYK0OinC/rPha2m6fyZKbWP
	YVOgyRJ963cHYbCbLVzBaZZLMqX0YfnnLeMv1zC9bZBOXZpgF6V39QZeYbuMGA4nElM=
X-Gm-Gg: AfdE7cl2nhrlwd2E1aTv3jajnQoz7XASmHtbQbW1DqulvT01Mo18gxkOYVCKRzOQv/8
	8oZq01skfw+6kO7YmcmUtjdq7CI0sCzf4nyCzcvfWSb3fShxjoMFINT03auDRhjk1fOiwCjQm0+
	vCeypA3A//7PgJBq/GhXkozBJld0hGNbNbUTTGQf3jw6Uv7VvPnrstjJo/m7SW7Zblr3HNtoFQE
	v9JO4NKrFmTbvPkAbMFBNr7uYoRXbo0RrBEU5CwyAnTJM3wqnEvS5Sd0rsWYPvnpaZJox573xGt
	oMKjDu8k6IpPgePqId4x7a7Rg1o8kJMuMo/RTGPsrj5UAyZNQDj4eEwkeSKmZ7vtPpGKZ6hRO46
	Rxgo214cXrDYhgDdUS7OkFlBHn6RSvT7/JTLvMaF+bpU+/m+RpJnrER+bo7xIFH2KEa9dhspgE4
	AyoY3FXe/WQevhoxPvfW7hFDyJiTJx6u0LKdo/U4auS5lo8vZNTgdwitK739jEAp3HefWXGIhl1
	OkYdw==
X-Received: by 2002:a05:6000:220c:b0:473:41c6:f1b9 with SMTP id ffacd0b85a97d-47341c6f3ccmr567565f8f.11.1782631786146;
        Sun, 28 Jun 2026 00:29:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff? ([2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472bca3caccsm4220704f8f.33.2026.06.28.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 00:29:45 -0700 (PDT)
Message-ID: <982a310197bcfc6725c8a5d6d8fdf41217cf239b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bb: Add prefuncs and postfuncs ordering
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jun 2026 08:29:43 +0100
In-Reply-To: <20260626170044.3829734-1-JPEWhacker@gmail.com>
References: <20260626170044.3829734-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2026 07:29:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19799

On Fri, 2026-06-26 at 11:00 -0600, Joshua Watt via lists.openembedded.org w=
rote:
> Adds the ability for functions specified in prefuncs and postfuncs to
> specify the order in which they must execute. This allows specific
> functions to indicate that they must run first or last (or second,
> second to last, etc.) without needing all places in the code that
> manipulate the function list to have to agree on how to order them
> (a good example of this is sstate.bbclass and buildhistory.bbclass).
>=20
> Ordering is done similar to how python list indices work; 0 is always
> sorted first, 1 is second, -2 is second to last, -1 is last, etc. In the
> event of functions having duplicate values, they are grouped together,
> but keep their same relative ordering. If one or more functions do not
> have an order assigned, they executed between the positive order
> functions and the negative order functions, and keep their same relative
> order (this means that existing behavior is preserved in the absence of
> any ordering information).
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

I've wondered about something like this for a long time, the trouble is
it does not scale well and I've always concluded it wouldn't really
help overall and solve the real problem.

It solves an immediate issue of making one thing run first, or last. If
a second comes along, it can just about handle that. The trouble is
when you have three or more and they all want to be "last", or "first",
you can't define that in the metadata. This just gets worse when you
think of independent layers trying to pick numeric values. This is
already a pain with layer priorities and I wish we'd never used
numbers.

You can already get some idea of ordering just by the +=3D and =3D+
operations ordering the data, or reordering the variable contents using
anon python.

You could even define a filter function for the variable which could
reorder things with a custom order function.

So I'm probably against adding this level of complexity when we already
have enough of it and it doesn't fully solve the issue anyway.

If we did something, I'd probably look in the direction of "after" and
"before" operations like tasks, trying to avoid some of the issues we
have there.

Cheers,

Richard


