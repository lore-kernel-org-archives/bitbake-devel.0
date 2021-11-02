Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A31C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 23:07:06 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.238.1635894425740803948
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 16:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=m+QRwyJ1;
 spf=pass (domain: gmail.com, ip: 209.85.214.175,
 mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id v20so1211821plo.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=X4SJbt76ZvMZQHZbs2NbD59SM/atIj4y3dCMIT5q8G4=;
        b=m+QRwyJ1Jm34kPNt5qCpY7zZhR7dy2YTeY6tPPWt62GCqnlbYjh/xzVZX/N8qyj7bH
         nOI1GHpx5Mp4i6kwDiYuG7miZBhf9VtZXoO1fjkx+xFuJVfySJKQpWggGFZJNVso2dgC
         GFBVyQdmZMB+B5U/EK+tilndEBxFhdFEuoGiAItywG2hbRpo3ZUsRzVr0TZORA0hIkHe
         CtslGnyeabWj9qONmbOjhn+EEhEgnFCSbWV6IEeIfKfn1UqJpvwchYk0v3uAAzzsOGFS
         GdmIMKlPem63j9tTFt23/QsYOeSq8/84lltykSq5ZHopoaLATcrcekxAjRxkRpIN9iFu
         Ma+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X4SJbt76ZvMZQHZbs2NbD59SM/atIj4y3dCMIT5q8G4=;
        b=caI55NfuI6G0LdE97v0JofBTjJSsXgVqXgQJGfg4DAokG+GAH1HTl9Ww3CZErXGmK7
         hjFXsXGIsPiMcCde0DpNuJtFOr8XEW1qXpv/av/jJQtMfSO7iA51/Impe7TCfRhSZQXt
         Lwhk3q+qFn7oSsFcXRykdbERgLbW4fGQxkkONllMul+Fw1udRxJgER6KxhFZfoNGpYn0
         4LJZYErb4wla6hykZq4GKO5FwxNiVz3dg5jQwayxPOyPeW/rxt8z9HYEEv8aNwUVo+EO
         3RFd46pkeay4Awg5upnpR5KFIxv21ExnJ4KOFLIVj/eDO93DCzoRRi44NK2fkbkVDnpg
         /Uvg==
X-Gm-Message-State: AOAM530eISzWpbGxY1NDI1/zv19J7P6d0qdNBp/MAW0l0KZ0B/XP6pd1
	nkJpn0vq1/8nzbFL5zdoy2+u7GukiAo=
X-Google-Smtp-Source: 
 ABdhPJzbvvGKkhW+RPyGdoIHWpoI00l3KN0CGXsOkdjfm80R5uq9ml3jWEi/0MYfXk1t/8e7tlYvtA==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id
 v10mr10270738pjj.130.1635894424984;
        Tue, 02 Nov 2021 16:07:04 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:a5c0:e13:25b1:763b:6129?
 ([2601:202:4180:a5c0:e13:25b1:763b:6129])
        by smtp.gmail.com with ESMTPSA id
 n20sm137479pgc.10.2021.11.02.16.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 16:07:03 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH v2] fetch/git: Show warning for invalid
 github urls
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20211102170559.3553007-1-richard.purdie@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
Message-ID: <b43ae3ea-2d22-b53a-efcf-fa83f7e6e9be@gmail.com>
Date: Tue, 2 Nov 2021 16:07:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102170559.3553007-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 23:07:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12870

I feel like this may need to become an FAQ as it will affect older
releases no longer supported.

did I just volunteer?

-armin


On 11/2/21 10:05 AM, Richard Purdie wrote:
> On master, tell the users they need to update their urls for github.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 1 +
>  1 file changed, 1 insertion(+)
>
> [v2 - add missing ud.url)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index f5be24d6ab..6546aef6a2 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -146,6 +146,7 @@ class Git(FetchMethod):
>              # github stopped supporting git protocol
>              # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
>              ud.proto = "https"
> +            bb.warn("URL: %s uses git protocol which is no longer supported by github. Please change to ;protocol=https in the url." % ud.url)
>  
>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12868): https://lists.openembedded.org/g/bitbake-devel/message/12868
> Mute This Topic: https://lists.openembedded.org/mt/86771319/3616698
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [akuster808@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


