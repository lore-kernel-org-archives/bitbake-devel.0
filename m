Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.851.1622735748123707240
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 08:55:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=sGka3UPI;
 spf=softfail (domain: sakoman.com, ip: 209.85.221.51, mailfrom: steve@sakoman.com)
Received: by mail-wr1-f51.google.com with SMTP id n4so6386427wrw.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkSyPKI5C47pVOvVadQEhRRFIJbmEYZsrq89k4KjoEs=;
        b=sGka3UPIF8fsvxPdnK76UrEA7GVPhAQndWirujXOj1hY8i+U8TmA3R3FV/0hYyR+tB
         31NKBiYrwE6fEOqnEIpIGJilnY+25U0UYSK72WHnpu1PD5D1bj9l6NQ6/dSMTS92oTu6
         MBY8h5yj7Sh3snpHNPqxoXwSgp3bYOap9zs8CPWppFwTIH7Dgoi7Q+dgNWSpFjVG9Z5b
         FES/qLkbEzOJy97c5dKQfzpuATgnN7HAUCENKO6AMzBnY/kSZeA80d84wM0vzpIitj8H
         FR5aGsOL3OVZHLbTq8DFRmywdMky0XxdCZcxMJcaEeix8CbiD4AhSfwqxw2LZWvk11NS
         OAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkSyPKI5C47pVOvVadQEhRRFIJbmEYZsrq89k4KjoEs=;
        b=AmZA+25ot8+GcUChjh6ZOj+/occWWIcijihRHpbNHkY6iTRN8Mwngagqj47NY6dyXw
         0IBBzf93NNny0mtoKSUZl25qw6fuJMjYy016rFbiIRQlDMl/s9gItTTd8QljOwm5AiX8
         un5vEIbTk9O6Tx12gbUvftx5PYghjN+meuQQ9IqVgH0nuIF5WTfA1bN8ntlkucQBlHBq
         5nZh9J6AJqUhGw8R4FEbg67iot0i8fk7enrB5zhgWA5xqbGdNZMvL300rbQ1G+6S0nr2
         Cw1W0+5i7QEy7uDKBgG+ZDd9W9jsMd9CmB4MH10nsjzEM5reGBEhZWP3B94goDSjNKju
         rZKg==
X-Gm-Message-State: AOAM533YxDsbELLmhwuewrCu9GVehBiQpjr52WJP95tNz9Fb3lunt+ih
	j+kf9CLgFi6vJPdQY47PbSlHL/8ARHfh+6ayb2WX4Q==
X-Google-Smtp-Source: ABdhPJwWImnqTJOYx4xjvSvuJj7eh++/iMF4Lex8rFyACEEnL0ie3eWrIacweBBFXPGybUGlX/0QbEOe/weYwqEPLWM=
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr634101wrz.350.1622735746380;
 Thu, 03 Jun 2021 08:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210603114543.98044-1-Martin.Jansa@gmail.com>
In-Reply-To: <20210603114543.98044-1-Martin.Jansa@gmail.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Thu, 3 Jun 2021 05:55:35 -1000
Message-ID: <CAOSpxdaLzBr-cO2KhD5-JETRxDYnV=-Ykg12YWZa1AH1bzAGmQ@mail.gmail.com>
Subject: Re: [1.46][PATCH 1/4] cooker: Ensure parse_quit thread is closed down
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

Are you seeing a particular issue that these patches resolve?

I seem to recall considering these patches last summer and
encountering issues on the autobuilder.  Sadly it has been long enough
that I don't recall the details.

I spoke briefly with Richard this morning, and he also has some
concerns about taking these.  Any details you can provide on why you
find these necessary would be appreciated.

Steve

On Thu, Jun 3, 2021 at 1:45 AM Martin Jansa <martin.jansa@gmail.com> wrote:
>
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> Each run through the parser would leak a thread from the queue created to
> shut the parser down. Close this down correctly and clean up the code flow
> slightly whilst in the area, making sure this thread does shut down correctly
> (we don't care if it loses data).
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 11cc2b95..4820d268 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2056,12 +2056,11 @@ class CookerParser(object):
>                                              self.total)
>
>              bb.event.fire(event, self.cfgdata)
> -            for process in self.processes:
> -                self.parser_quit.put(None)
> -        else:
> -            self.parser_quit.cancel_join_thread()
> -            for process in self.processes:
> -                self.parser_quit.put(None)
> +
> +        # Allow data left in the cancel queue to be discarded
> +        self.parser_quit.cancel_join_thread()
> +        for process in self.processes:
> +            self.parser_quit.put(None)
>
>          # Cleanup the queue before call process.join(), otherwise there might be
>          # deadlocks.
> @@ -2078,6 +2077,9 @@ class CookerParser(object):
>              else:
>                  process.join()
>
> +        self.parser_quit.close()
> +        self.parser_quit.join_thread()
> +
>          sync = threading.Thread(target=self.bb_cache.sync)
>          sync.start()
>          multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
> --
> 2.30.2
>
