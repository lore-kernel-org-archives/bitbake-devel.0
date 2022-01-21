Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFFCC433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 14:55:20 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.12950.1642776918317036633
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 06:55:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=fIg6+fUM;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.53,
 mailfrom: steve@sakoman.com)
Received: by mail-ed1-f53.google.com with SMTP id l5so26271279edv.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8erO9dK0bvGg7TbeoYMHzbP4wvS5Kpoyw4Yyv5DqHvc=;
        b=fIg6+fUM+SDScDeOUiC+hFPZrwrinJgJlY7BMOKTv2M1MYk9IoONigWRe3DRofWa4n
         EGK0KBofsCcUYpaeiKqK8zIFufqBGjm11/5ofpqZxUHCNAn4IAIrhWfe0qPJymO+5uHV
         VnMyEcyxgq4cfdxSPJ6QLZaRAHdg+jsSCf6sFL4TLTK8aEI9HVFh4MX9a5MPQg2IsNF4
         DwAHglZyaf8LwDbjd1mqA3CJSKyRzvxipnViyD7gqt0bT7KpP5xzJmLdg3Ga3dqdSxVh
         EJqOPHtVx+/ErcHdPQ9WdHZqGoaYeidQPUpVaZZE4KnU8C663hV6bfKFc/ySw/j61x7k
         aLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8erO9dK0bvGg7TbeoYMHzbP4wvS5Kpoyw4Yyv5DqHvc=;
        b=WE4eNjr4LsF4MQsQ1wYAheazKbuj7p9HiLYK6A9JsjWerzi2Lpzx3DGWkPvCdUT5GK
         LP5PfJj0untt7IHirclg3WaJIVXdKvBStoj7iw1dG1RuEmP2P0B5h2Rq3ERnPWQ8y034
         wsS7aiCSTtKzd5ZYY+NIxU6p/Z1LRINgSe8JOlKYAqXDt3xqH6qqfIyXtWWBo9lpuT2h
         zuk/NPe5I+eoN1oHdVXtQ0mBvvpHrQzL++HS6tYQx/lsjESqRbWSby7DaW758+iYf+2J
         qi3qUAdPQVQBN7SGNV1jvwO/gEysh+P4v/dbKu5/EhwKECuXXBVzaZDGEbzldCqQem3d
         m85A==
X-Gm-Message-State: AOAM5320KvxiHUCFUVBV2APEulf9Obj03fnH1EmChQUi2dQgidWBY7L7
	5sL3o55UsSs80FRnHV29hmIni+7lllthB+YNQii3Qg==
X-Google-Smtp-Source: 
 ABdhPJwHc5p5nqJSYhB1+jVjTxvQ5PFcguTUG5lvRdUO8YEnXW9cSmpg8EOOeCrthiPt9qXsRFywQs/2YshYjKIKij8=
X-Received: by 2002:a05:6402:4490:: with SMTP id
 er16mr4452907edb.203.1642776916471;
 Fri, 21 Jan 2022 06:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20220121145142.763-1-jatedev@gmail.com>
In-Reply-To: <20220121145142.763-1-jatedev@gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Fri, 21 Jan 2022 04:55:04 -1000
Message-ID: 
 <CAOSpxdZdS+eRKqQVNSRDWc0pFrFtgA1XG-LX3gbU2=y0qexn9w@mail.gmail.com>
Subject: Re: [bitbake][dunfell][1.46][PATCH v2] hashserv: specify loop for
 asyncio in python < 3.6
To: Jate Sujjavanich <jatedev@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 14:55:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13269

Hi Jate,

Just want to confirm that the only difference between V1 and V2 is the
addition of the reference to the bug number?

Thanks,

Steve

On Fri, Jan 21, 2022 at 4:52 AM Jate Sujjavanich <jatedev@gmail.com> wrote:
>
> [YOCTO #14697]
>
> Detect python version 3.5 restoring loop argument where
> it is still required. In 3.6 auto loop detection is available.
>
> Bitbake 1.46 is used in dunfell which lists a minimum python version
> of 3.5. Omitting this argument leads to a regression and hang during
> "Initialising tasks" at 44%.
>
> Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
> ---
>  lib/hashserv/server.py | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 56f354bd..f38a22ad 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -12,6 +12,7 @@ import math
>  import os
>  import signal
>  import socket
> +import sys
>  import time
>  from . import chunkify, DEFAULT_MAX_CHUNK
>
> @@ -419,9 +420,14 @@ class Server(object):
>          self._cleanup_socket = None
>
>      def start_tcp_server(self, host, port):
> -        self.server = self.loop.run_until_complete(
> -            asyncio.start_server(self.handle_client, host, port)
> -        )
> +        if sys.version_info[0] == 3 and sys.version_info[1] < 6:
> +            self.server = self.loop.run_until_complete(
> +                asyncio.start_server(self.handle_client, host, port, loop=self.loop)
> +            )
> +        else:
> +            self.server = self.loop.run_until_complete(
> +                asyncio.start_server(self.handle_client, host, port)
> +            )
>
>          for s in self.server.sockets:
>              logger.info('Listening on %r' % (s.getsockname(),))
> @@ -444,9 +450,14 @@ class Server(object):
>          try:
>              # Work around path length limits in AF_UNIX
>              os.chdir(os.path.dirname(path))
> -            self.server = self.loop.run_until_complete(
> -                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
> -            )
> +            if sys.version_info[0] == 3 and sys.version_info[1] < 6:
> +                self.server = self.loop.run_until_complete(
> +                    asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
> +                )
> +            else:
> +                self.server = self.loop.run_until_complete(
> +                    asyncio.start_unix_server(self.handle_client, os.path.basename(path))
> +                )
>          finally:
>              os.chdir(cwd)
>
> --
> 2.25.1
>

