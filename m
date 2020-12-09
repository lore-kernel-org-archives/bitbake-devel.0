Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
 by mx.groups.io with SMTP id smtpd.web09.2889.1607547854873386586
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 13:04:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eNZ1wYIj;
 spf=pass (domain: linaro.org, ip: 209.85.219.194, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-yb1-f194.google.com with SMTP id w127so2631754ybw.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJ/TO5OO+QTqf2gDVgXS4+vwLXNJ9yOGfSaQWrdOdGE=;
        b=eNZ1wYIj77Aqt98scD/gZKJGm6eLHKvLE1/BgaEFZzsoggZjq+Gudg7Diw/Ydc2uO8
         eJLtyrWdj8LAa5D7vt+nJb2Y//mXzIvnChZlER3DjEozQmf/6p2txD3GezGgHHAXauEX
         wig0g/r0BuHkYqozRVJTBLj8DNs76Cazucm3DGuFTwET6ayOoGW67TM/Bnt5EEJWQtJo
         s83l/12qBEo29vz+Gw1XYdUSywCugKE4+B6+E1DERff3s+qmJvoL62ryn+vgl/Y1/wZo
         qspFkdyxVzwUvzcamOpN7n1qJp75nP9Bl+/sb7NdWmsSNq+TSRM5zY+jJYEOmQPoeHp5
         7NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJ/TO5OO+QTqf2gDVgXS4+vwLXNJ9yOGfSaQWrdOdGE=;
        b=LH+DV61jVcEfp+zuM05vzJHoqs3hf13ET5+Lqp4uDgziuUSQnspln4aq5fTdPww91r
         iqZki5Z3l6/sZd27p6Rkh3wKDAPNJslCKI/agczMR91wYxiItKAUUaWT4ZXmLlN043rv
         ixqvknPoU70xYe0qUQEydKFfkYC6dRa2MINoOZKKijS9CC4U9Jsth5hQl6/nk64mOckw
         SM1eYURnxCSzrZBOv6iHt8lOpOb5ANyXbuqfsMkummL5s1lALVVfDKE/D7WNz0p0mCa2
         QnrjvWJ5h0aepBBdze1X0oTfhwaTuRKg2DMk9J6HJv04jQK4cb9Dd3pkHLNYdYyGQ2LE
         Z13g==
X-Gm-Message-State: AOAM5334wQtE2OOj9/qJi7GEY/aFvlK5czay4lolGiF4Sapw1MUwcxZM
	h5oFP3RIgXKmkZUXEgmOlFaPmlvv3NCq1jlX4v4seg==
X-Google-Smtp-Source: ABdhPJwoHS3Q9f2+buO6xZoUP30JE9iUzmgsYdkE7n1z+M5M8ANtpM6MAwlHFSmpIYvcs49/++2Q/SFB2u3VFuBJxh0=
X-Received: by 2002:a25:b19d:: with SMTP id h29mr6258176ybj.133.1607547853941;
 Wed, 09 Dec 2020 13:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20201202195810.20800-1-JPEWhacker@gmail.com>
In-Reply-To: <20201202195810.20800-1-JPEWhacker@gmail.com>
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
Date: Wed, 9 Dec 2020 22:04:03 +0100
Message-ID: <CAP71Wjx9bCo++6ppp925_vd9fDZZ+N9DgJKuMcE_oK9Oi6LLmQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] hashserv: client: Fix AF_UNIX path length limits
To: Joshua Watt <JPEWhacker@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Anuj Mittal <anuj.mittal@intel.com>
Content-Type: text/plain; charset="UTF-8"

hi Joshua,


On Wed, Dec 2, 2020 at 8:58 PM Joshua Watt <JPEWhacker@gmail.com> wrote:
>
> Restores a fix for unix domain socket path length limits when using the
> synchronous hash equivalence client that was accidentally removed when
> the async client was added.
>
> Unfortunately, it's much more difficult to fix the same problem when
> using the async client directly due to the interaction of chdir() and
> async code, but this will at least restore the old behavior in the
> synchronous case.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

the meta-qcom CI started failing.. and I have the feeling this is
because of this change. I am now seeing many errors, and this:
00:02:31.320 OSError: AF_UNIX path too long

Here is the link to the full Jenkins log:
https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/136/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/console

This is a test build we do for each Github PR. This build is using
this commit from Poky/master:
982688103619 (build-appliance-image: Update to master head revision)

We tested another PR 2 days ago, and it went fine:
https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/134/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/consoleFull
This build was based on this commit:
982688103619 (build-appliance-image: Update to master head revision)

Looking at the error log, and this commit, it looks related to me..
though I am not sure I understand the details ;)

> ---
>  bitbake/lib/hashserv/client.py | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
> index ae5875d1b3..7bbf0865d5 100644
> --- a/bitbake/lib/hashserv/client.py
> +++ b/bitbake/lib/hashserv/client.py
> @@ -40,7 +40,7 @@ class AsyncClient(object):
>
>          self._connect_sock = connect_sock
>
> -    async def _connect(self):
> +    async def connect(self):
>          if self.reader is None or self.writer is None:
>              (self.reader, self.writer) = await self._connect_sock()
>
> @@ -62,7 +62,7 @@ class AsyncClient(object):
>          count = 0
>          while True:
>              try:
> -                await self._connect()
> +                await self.connect()
>                  return await proc()
>              except (
>                  OSError,
> @@ -190,7 +190,6 @@ class Client(object):
>
>          for call in (
>              "connect_tcp",
> -            "connect_unix",
>              "close",
>              "get_unihash",
>              "report_unihash",
> @@ -209,6 +208,16 @@ class Client(object):
>
>          return wrapper
>
> +    def connect_unix(self, path):
> +        # AF_UNIX has path length issues so chdir here to workaround
> +        cwd = os.getcwd()
> +        try:
> +            os.chdir(os.path.dirname(path))
> +            self.loop.run_until_complete(self.client.connect_unix(path))
> +            self.loop.run_until_complete(self.client.connect())
> +        finally:
> +            os.chdir(cwd)
> +
>      @property
>      def max_chunk(self):
>          return self.client.max_chunk
> --
> 2.29.2
>
>
> 
>
