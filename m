Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF3C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 15:56:05 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web12.28.1660146963634781565
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 08:56:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=h0xGzVey;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: raj.khem@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id z25so21870639lfr.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5oa9Hu1pHWSQYLhTYoCzRbJzWkxl7c5xkxqt98uMo8U=;
        b=h0xGzVeyuBLzG3xSgDp1a9RSE9h8c5mx2gmhnhymotXFWdWGLKFfYfM0KhsyxqzISS
         NvgtwP/aCLcJ3DqGxu902qPC/FAk0iRVqo0SkyNQZUQDw/cWikPl9Zv/AEHChf5Ba9vY
         Qn0YN9ABUf49Quz+6k8ZXijQtDVWpck7OmYF0E2jMy5pX/+cZ9B/AZP/2WI08hKt93ny
         +mlgJ8J6UQSrE+NPsy1sPkfD1Y5fmcOxUXO2HEW++1jT0u9gCsnfA6tp4FyBAAPJt1FU
         f40OjMn89pNrMv8YRk7rsP9UT0n+DtEUn6R5+J82+DO3qsFjfPpJDt/GxSKF+K//2QWI
         AzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5oa9Hu1pHWSQYLhTYoCzRbJzWkxl7c5xkxqt98uMo8U=;
        b=MyPVhWXoWVAwIDspoFcWKTJlDCV6FS3ZDA0IRXtpHmng+bfFD24c0vcEx3jBZCCAkB
         LhdPDi0fPTh98bWLwu5pVedCvqD4n4oEffVhDS6hujWINCyTqbNLh79uzV0cPhG9sYhq
         XgjvB+Ob+SnOUa3JA4rzaGbPryJI4HgHaH3h6/bLW6rrI8/d9VFCEslzt2DsbCaNFvlL
         fZqHcMlWh6IRHuxSkEH1TFDI45zGHT/12RQCl6zy6liqD9VKF3cNd/PeA5kDNHBb0i03
         zCxX31xMTIP/vdbHiQwu2vFjNV1VP7PnLMO45CkwVIfhuL4t+TOaypsL1zoJxVbnwRug
         i0pA==
X-Gm-Message-State: ACgBeo2K1CQjla9JjV2nyF+uYeG64TdvNPAVhqvjTQp0jFCWRpUmRLIK
	SXGAssGc6qXG80wJK6Ird1DdXxIzilHtz0VVBlM=
X-Google-Smtp-Source: 
 AA6agR4RL+gb57sHbSoeaz6UbU9mGoxjdbpk5z79HHq442rOR01XDG3VdFDs9j0/wwSoTe5Xxyg0ZoUGheuY4T5npMA=
X-Received: by 2002:a05:6512:1154:b0:48b:3020:b29 with SMTP id
 m20-20020a056512115400b0048b30200b29mr9427643lfg.338.1660146961590; Wed, 10
 Aug 2022 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 10 Aug 2022 08:55:33 -0700
Message-ID: 
 <CAMKF1sq8xAqD-yzEkV67yDPs3yoeQ86ygHKXoLHbp0Go2n=kWQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] BBHandler: Allow earlier exit for
 classes not found
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 15:56:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13887

I seeing

% bitbake binutils
WARNING: ['base', 'sanity-meta-odroid-extras', 'clang',
'report-error', 'image-buildinfo', 'package_ipk', 'buildhistory',
'buildstats', 'buildstats-summary', 'debian', 'devshell', 'sstate',
'license', 'remove-libtool', 'sanity']
ERROR: ParseError at
/mnt/b/yoe/master/sources/openembedded-core/meta/classes/buildhistory.bbclass:10:
Could not inherit file classes/image-artifact-names.bbclass

On Wed, Aug 10, 2022 at 6:43 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> Rather than relying on later code to error if the class isn't found,
> exit earlier and more clearly from a code perspective.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/parse/parse_py/BBHandler.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
> index 68415735fd..532a4e08f1 100644
> --- a/lib/bb/parse/parse_py/BBHandler.py
> +++ b/lib/bb/parse/parse_py/BBHandler.py
> @@ -56,6 +56,9 @@ def inherit(files, fn, lineno, d):
>              if abs_fn:
>                  file = abs_fn
>
> +        if not os.path.exists(file):
> +            raise ParseError("Could not inherit file %s" % (file), fn, lineno)
> +
>          if not file in __inherit_cache:
>              logger.debug("Inheriting %s (from %s:%d)" % (file, fn, lineno))
>              __inherit_cache.append( file )
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13880): https://lists.openembedded.org/g/bitbake-devel/message/13880
> Mute This Topic: https://lists.openembedded.org/mt/92936457/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.khem@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

