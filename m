Return-Path: <daniel@qtec.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F4C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 12:50:35 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web12.33526.1644843033371221009
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:50:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qtec.com header.s=google header.b=JR/aZrbL;
 spf=pass (domain: qtec.com, ip: 209.85.208.181, mailfrom: daniel@qtec.com)
Received: by mail-lj1-f181.google.com with SMTP id o9so17221559ljq.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Feb 2022 04:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNiQm7Y5nXXXOk8BBIUvw2GtLrtd0CSIOFGqZnatgSU=;
        b=JR/aZrbLXegcr/tS9PiksvK5F+2HgKDsY1bsPbAwtzdim+q1DTsXplhdx07YJM+UAv
         KTwpLtVIoPj73JQOFQFoKS9MenGa57M6CpTtQoFqfbUKL5cke9ljirvSVDTFYciZy2f1
         YSLL+FtTNJDpodmItzRa6/1gwtgK4V3l+eBZn/bOEj3AADh9cks4FHlCNgFBW2RSExwD
         +sqoUgx369cEGFMev4YhTd4QZRa1lM4bAmYSKaRLa+mZ3+kYYwni5PT5/qnh+dEPib4x
         C/n4kevBYp0gHlZZgtKUwkzTFh4nmzZ+Rf5Szad2Pfea6in+xMwt6JyI/RC73UUgQe1B
         A4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNiQm7Y5nXXXOk8BBIUvw2GtLrtd0CSIOFGqZnatgSU=;
        b=fS8loeDYGh1L8ZuN8CeKWJZ9YXKf8rUtPv7q/E7Hm8weZhgtfplsHg3CfXsQiKrytj
         xTYr00fBnNIt9QV3b1xkY6To3c1G+KOY2S9uR2iPo6AiN6yeiQFIjMB+vsOV2pIuzIO+
         SuCs+YPF7hmzSMpDcMR9952Ur44WT5SBB+K2gyGDLqKSfa9bNjqGMrEo+edlnwAoRuww
         6/RoufRAzN69IT6Ee75Mj69UAi5Yfwsf5k9OozSyzGXQsKs7ygr7CoaTQPeUz4uu0J8x
         SDEqvbqv7wptSFAtWcqStPb6CEzPB75pwMpdDa78G+kySnJG4iD3ox2xV9u7nimZFHhE
         uenA==
X-Gm-Message-State: AOAM5317OGKmQ+Fsw2fGL8/6dgk9yMyEkkaunLGWo27X1ywozCSzGqQt
	wCeDjuJFzY3gIJvkMd+KRWbBzmKROnGBPePyOlclaQ==
X-Google-Smtp-Source: 
 ABdhPJx5EaFHZQ8F/+/3i2vnA+cSl89j1pppGvdQsJwSXCDWQkzbUPT3aos+b+D6S03yZLLS7uhIG7NFPrlsQw7wzFc=
X-Received: by 2002:a2e:890a:: with SMTP id d10mr4410927lji.409.1644843031165;
 Mon, 14 Feb 2022 04:50:31 -0800 (PST)
MIME-Version: 1.0
References: <16D3A703B0414493.26336@lists.openembedded.org>
In-Reply-To: <16D3A703B0414493.26336@lists.openembedded.org>
From: Daniel Gomez <daniel@qtec.com>
Date: Mon, 14 Feb 2022 13:50:19 +0100
Message-ID: 
 <CAH1Ww+QEMyqkPFgwgE3Q2dO9BZxa9D_EyxNrX6-9qE-S-NiLBw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] contrib: Fix hash server Dockerfile
 dependencies
To: Daniel Gomez <daniel@qtec.com>
Cc: bitbake-devel@lists.openembedded.org, Daniel Gomez <dagmcr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Feb 2022 12:50:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13346

On Mon, 14 Feb 2022 at 13:32, Daniel Gomez via lists.openembedded.org
<daniel=qtec.com@lists.openembedded.org> wrote:
>
> When building the Hash Equivalence server Dockerfile, some
> dependencies are missing in order to run the hash server properly:
>
> Traceback errors:
>
> Traceback (most recent call last):
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
>     ret = main()
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
>     server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
>   File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
>     from . import server
>   File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
>     import bb.asyncrpc
> ModuleNotFoundError: No module named 'bb'
>
> Traceback (most recent call last):
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
>     ret = main()
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
>     server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
>   File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
>     from . import server
>   File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
>     import bb.asyncrpc
>   File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
>     from bb import fetch2 as fetch
>   File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
>     from . import git
>   File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
>     import bb.progress
>   File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
>     import bb.build
>   File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
>     from bb import data, event, utils
>   File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
>     from bb import data_smart
>   File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
>     import bb, bb.codeparser
>   File "/opt/bbhashserv/lib/bb/codeparser.py", line 26, in <module>
>     import codegen
> ModuleNotFoundError: No module named 'codegen'
>
> Traceback (most recent call last):
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
>     ret = main()
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
>     server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
>   File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
>     from . import server
>   File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
>     import bb.asyncrpc
>   File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
>     from bb import fetch2 as fetch
>   File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
>     from . import git
>   File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
>     import bb.progress
>   File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
>     import bb.build
>   File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
>     from bb import data, event, utils
>   File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
>     from bb import data_smart
>   File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
>     import bb, bb.codeparser
>   File "/opt/bbhashserv/lib/bb/codeparser.py", line 32, in <module>
>     from bb.pysh import pyshyacc, pyshlex
>   File "/opt/bbhashserv/lib/bb/pysh/pyshyacc.py", line 13, in <module>
>     import bb.pysh.pyshlex as pyshlex
>   File "/opt/bbhashserv/lib/bb/pysh/pyshlex.py", line 17, in <module>
>     from ply import lex
> ModuleNotFoundError: No module named 'ply'
>
> Traceback (most recent call last):
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
>     ret = main()
>   File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
>     server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
>   File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
>     from . import server
>   File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
>     import bb.asyncrpc
>   File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
>     from bb import fetch2 as fetch
>   File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1935, in <module>
>     from . import wget
>   File "/opt/bbhashserv/lib/bb/fetch2/wget.py", line 30, in <module>
>     from   bs4 import BeautifulSoup
> ModuleNotFoundError: No module named 'bs4'

Signed-off-by: Daniel Gomez <daniel@qtec.com>
> ---
>  contrib/hashserv/Dockerfile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
> index d6fc728f..74b4a3be 100644
> --- a/contrib/hashserv/Dockerfile
> +++ b/contrib/hashserv/Dockerfile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  # Copyright (c) 2021 Joshua Watt <JPEWhacker@gmail.com>
> -#
> +#
>  # Dockerfile to build a bitbake hash equivalence server container
>  #
>  # From the root of the bitbake repository, run:
> @@ -15,5 +15,9 @@ RUN apk add --no-cache python3
>
>  COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
>  COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
> +COPY lib/bb /opt/bbhashserv/lib/bb/
> +COPY lib/codegen.py /opt/bbhashserv/lib/codegen.py
> +COPY lib/ply /opt/bbhashserv/lib/ply/
> +COPY lib/bs4 /opt/bbhashserv/lib/bs4/
>
>  ENTRYPOINT ["/opt/bbhashserv/bin/bitbake-hashserv"]
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13345): https://lists.openembedded.org/g/bitbake-devel/message/13345
> Mute This Topic: https://lists.openembedded.org/mt/89134937/1985121
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [daniel@qtec.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

