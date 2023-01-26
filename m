Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869E7C54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 12:41:43 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.72627.1674736897620028744
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 04:41:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T9K9gkIW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1025084wms.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5sKa91EpWjbIB52JO+bJ2IYDZyXCt/RUQXMhmTxBs2Y=;
        b=T9K9gkIWo368g9X3k+6IZ2ARm44J1Rz6X0vwhNw7qvgK9NHeDvkJQFhQvJTtgs+U2m
         meHj31pJmE1TC5OwqxQF3mFLRmmoyfGDa9eKWkufiA/1VSMNFHEp731X7hiznPtW0XbE
         o9zlz0gmno5HjgQB8L8WuTsvOfOb9d6ytLxKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sKa91EpWjbIB52JO+bJ2IYDZyXCt/RUQXMhmTxBs2Y=;
        b=qnNfMQu6XDYS7JKUOUyZ0epheGhyTeKBL7k+RqEHCi0FulWkLmi7U9U7katwd0l+fs
         ssQs6PDuHlIUBVLuYTvcjzKIwiI+CH3rXEAOrDXOWrbNX9vfadnVbNEpxSIDJUr1elYQ
         ifg0hvNy5Z779sTvskJzzmsx/JZS9SlfrOSz3MGtn7Hh6VkZu/6T4LbOu/n1B8KRR9Z1
         LcS8TCJ847XGLF68WGOhKWXSBDxyw4lJdHFmD+Y63yCM9+gRPW9i1w3z2WmhksWWEDhS
         n3/n+VAUDFSfuvSjINSUO8mvmsSK59Wl2r+StLWj0a1w9D0BBzzSg7DSXMuuM2NtuOfx
         Nq1A==
X-Gm-Message-State: AFqh2kqIOOLeZbZDbn9/FO5m5fBfC+960qG45f2k7EkHjNS6UnfMbhvK
	A+xSmtMl0v9nSTgmgZEllMi1BA==
X-Google-Smtp-Source: AMrXdXt8MTlOPp0tEdV1E/iu7zZ3RYUTcpbyb4uDdvfRYXbTNaxjAooCQuHAYAzlNQFJ6JoxLYqP5A==
X-Received: by 2002:a05:600c:35d4:b0:3db:3694:b93c with SMTP id r20-20020a05600c35d400b003db3694b93cmr22794834wmq.15.1674736895751;
        Thu, 26 Jan 2023 04:41:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f2d7:e330:f537:35d8? ([2001:8b0:aba:5f3c:f2d7:e330:f537:35d8])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c13d300b003daf98d7e35sm4403641wmg.14.2023.01.26.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:41:35 -0800 (PST)
Message-ID: <55d8dad421c8281356ff4510dcef0e016bf67dfb.camel@linuxfoundation.org>
Subject: Re: [PATCH 5/6] data: Add sup0port for new BB_HASH_CODEPARSER_VALS
 for cache optimisation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Jan 2023 12:41:34 +0000
In-Reply-To: <b3c51ad7-da76-db80-d2ed-a2fa2df60518@myneves.com>
References: <b3c51ad7-da76-db80-d2ed-a2fa2df60518@myneves.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 12:41:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14346

On Wed, 2023-01-25 at 15:52 +0000, Paulo Neves wrote:
> Perhaps BB_HASH_CODEPARSER_VALS could contain a list of flag names that
> could then be iterated and the values retrieved safely.

That is definitely worth thinking about. The challenge is the added
complexity and the extra variable lookups, particularly if people start
to make the expressions more complex. I was trying to keep things
simple!

> The current implementation will break if any forced value has a white
> space or a '=3D' sign. If this variable is to appear in the manual at
> least these constraints should documented.

Right, I'm assuming that since we're controlling the substitutions, we
can avoid issues like that relatively easily. Martin has run into some
recipes which are doing .split("-") on PN though.

I'll give this a bit more thought but I am leaning towards keeping
things simple if we can.

Cheers,

Richard


