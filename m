Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB851C6FA82
	for <webhook@archiver.kernel.org>; Wed, 21 Sep 2022 00:40:38 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.1018.1663720834460578936
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ZFAVp8nQ;
 spf=pass (domain: gmail.com, ip: 209.85.218.46,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id sd10so1736503ejc.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MIhGSwDSQEEsGWzT28e1CQJ95xQA1yazsIAkHyCnG9o=;
        b=ZFAVp8nQICtl/nH8PnU+HNUXHWZmSLS6zEzd5WYs6Hz1zwY3jwOxflj7CLag3xPU3n
         7hxhiRAx+8C7O1yMJ3EiFjhnPwzmBPdEVFp8UtfELE5FHi2ovNk6Y97vuRzWvyby7L7y
         6adQVeNYeAWWyiA4CMJP3/YZo10Uo4BkFIBrTSKcn7f8lflQXFDrcFnGFqvLfstZnZnD
         q2qO0Rk6LG0AtGL/MFfwWkRBFcZwnxU0SYbm+lvJEw5NV4AM+j68qyPIM99A8LeXnuoB
         FDGSuxqkKxwCiap/KWCHKIXYTH/9YjiT2tR1IgzuP67vO376O853hpIa+FFUge0AiqAj
         P0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MIhGSwDSQEEsGWzT28e1CQJ95xQA1yazsIAkHyCnG9o=;
        b=lBhatlXvzHdv0f4ZxI6aVigss++4lVGHeE3WBBA/7jAZx8oCj2HMt+kt0ytnaugOzj
         ryy2fymHqUxAfh++ZOvTi5lCMRLBoYaAiWgxT+zv5KxRr2y54trrLSvv1rlQIL1l1351
         RyaSEDGdezNpJkY9CdHBqGfCLYp0GF24G9XCtLw8uDf2eH/AN7YJgaml2p/KdNTU7op4
         hHb+DkC1d7Fc7rXg8j73Ll4Wg7AQlVNb810jOel8Ytu0hCgm+GHhMb9n4r+EqMlV5/pa
         Sib10eucddDUNHuZpQCrNQOsBbEbABN9SI3bsTQbrjWBk8etmYuiKwHhn0m9L4tRuJbR
         jNkw==
X-Gm-Message-State: ACrzQf05USfkt4IZ92tSChqbQ4gnq1oS9YLmXo/U4nVtn1TDEiEHnrM6
	KpY7Tr+HhRWIQQz9pwINlVZZiJqms+5N+jWjQfg=
X-Google-Smtp-Source: 
 AMsMyM6uWmJyJWSX5kVscGVGT2c3bOhKO6OWCW27veI/qfp9drBD09vcC1KUXPwB+MdjgSkziT+D8nWpuWKqq07uOfY=
X-Received: by 2002:a17:907:1623:b0:77e:9455:b4d9 with SMTP id
 hb35-20020a170907162300b0077e9455b4d9mr17932690ejc.491.1663720832863; Tue, 20
 Sep 2022 17:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220919091312.894690-1-jose.quaresma@foundries.io>
In-Reply-To: <20220919091312.894690-1-jose.quaresma@foundries.io>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 20 Sep 2022 19:40:24 -0500
Message-ID: 
 <CAJdd5GaiiFEdCP=tKjrEFY5OyK5aUYjpSnBmiqvW8KGUGAnrRQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] lib/bb: warning when the debug
 message is invalid
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Sep 2022 00:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13985

LGTM

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>

On Mon, Sep 19, 2022 at 4:14 AM Jose Quaresma <quaresma.jose@gmail.com> wrote:
>
> There are many messed up calls for the debug log,
> so is better to warm about this as they will not work
> as expected.
>
> The level need to be an integer and the msg a string.
>
> Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> ---
>  lib/bb/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index b8333bdb..81b5a628 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -60,6 +60,10 @@ class BBLoggerMixin(object):
>                  return
>              if loglevel < bb.msg.loggerDefaultLogLevel:
>                  return
> +
> +        if not isinstance(level, int) or not isinstance(msg, str):
> +            mainlogger.warning("Invalid arguments in bbdebug: %s" % repr((level, msg,) + args))
> +
>          return self.log(loglevel, msg, *args, **kwargs)
>
>      def plain(self, msg, *args, **kwargs):
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13978): https://lists.openembedded.org/g/bitbake-devel/message/13978
> Mute This Topic: https://lists.openembedded.org/mt/93777548/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

