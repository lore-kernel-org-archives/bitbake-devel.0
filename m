Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB613C54EE9
	for <webhook@archiver.kernel.org>; Wed, 21 Sep 2022 00:32:08 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.932.1663720318802294269
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:31:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=l8zCeCZn;
 spf=pass (domain: gmail.com, ip: 209.85.208.41,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id q21so6276108edc.9
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=owMLn+gBc9M4aSYMWUADI1rndp2JGWQhqGyXOibWtNw=;
        b=l8zCeCZn+rVcmVpjdPbFP+MPTEmjUL3DDkFcxrwZyiZ4pRLeQob4wdio/NfOD3zvk3
         Q/5ij4ZHc+JrRIT5sQVvS8y8UF8B+G8k1lFIjBgR2JoT+EYdcJsqAqjL6MBeVDX2V79R
         vcJo7RK9VzUHM3G+NQq/3mjY+6UrOe+IuVtoe0QHmn5Cq3O5Iq7RxItdg3+z2/Fg29vl
         b14/OY+sQ2Stj0/eIEVXudXz9tAPKbymluvnL6XUiDj1hUpB6ZJyu11PAEBxJzSH2gVu
         jnY5Zbgxs0DWG+0MGVM3qWchI9SmaQy7mDRdnW5P2i9XsdvQUFz4f5pWl2EZuX9g0tAS
         vxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=owMLn+gBc9M4aSYMWUADI1rndp2JGWQhqGyXOibWtNw=;
        b=q29ZaiiYJ/O2rMFMM30IuMINP8oRhflCP/d80AaKdtKsoSXw4WyC+hxII3fxVb7dzk
         6L0CykaGuY+GbEwAi5y8jBErSC12Pt4Zjmhr0zQ+cW2jfvWTOV6k21pMKiJNgYrMarTY
         6jJbxAGYdYk1GwNp3u7XGrqZrQX/1QfdjwqoaZVXUbdhaoIRiBhCgZbvL+cI5wlijD7b
         3IKCnSnMs9rTLTZp1tyBUhjt7nELt7HIMOpFy3AND3CjylMjXONipuol9R3jutvDbuLr
         2F0GQGK7b7b3ElI0Y7HvVZAQQKQcfRyU8SJZmDmQkxRjhvimcA0Qg+HZBVpOhvHDq91L
         tysA==
X-Gm-Message-State: ACrzQf0oaUzEMZBIBw3dsNiD6mvSjtwAik4VneOHqUdSZqRQIm6+skyr
	+gDMjHlEFR7wQs6lzMfL9D2RS5kuifokkExB0PM=
X-Google-Smtp-Source: 
 AMsMyM4aiirSnossKquhtLh0JRO2K4I2LK46HYm/DkogjD4NjLp/AR0ivXz/KvHSb44eZz+uvXgKpklYBJ++51xSn40=
X-Received: by 2002:a05:6402:5188:b0:452:5395:a271 with SMTP id
 q8-20020a056402518800b004525395a271mr22628968edd.383.1663720317125; Tue, 20
 Sep 2022 17:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220919091312.894690-1-jose.quaresma@foundries.io>
 <20220919091312.894690-2-jose.quaresma@foundries.io>
In-Reply-To: <20220919091312.894690-2-jose.quaresma@foundries.io>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 20 Sep 2022 19:31:48 -0500
Message-ID: 
 <CAJdd5GbyD0=f=wSM+ESCiBGhr-Njwg_OAMFDRGA70gqWQHd40w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] lib/bb: fix bitbake debug logger with
 invalid args
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Sep 2022 00:32:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13984

On Mon, Sep 19, 2022 at 4:14 AM Jose Quaresma <quaresma.jose@gmail.com> wrote:
>
> f68682a7 logging: Make bitbake logger compatible with python logger
> introduces the "_debug_helper" that change the api of the debug logger as
> they call now bbdebug always with level 1. Any old code that uses the old
> syntax "debug(lvl, msg)" is broken if they don't call the main debug log.
>
> This issue can be replicated running "bitbake -D" with:
>
> from bb.fetch2 import logger
> logger.debug(2, "I am alive")

It was actually intentional to make it so that logger.debug() would
match the standard Python logging API, because otherwise 3rd party
code using the logger doesn't work, see f68682a7 ("logging: Make
bitbake logger compatible with python logger") in bitbake.

The correct code would be `logger.debug2("I am alive")` although I see
we missed converting some of places that do that when we converted,
which I think is my fault. Sorry.

>
> That one side effect is crashing the knotty:
>
> | Traceback (most recent call last):
> | File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 685, in main
> | event.msg = taskinfo['title'] + ': ' + event.msg
> | TypeError: can only concatenate str (not "int") to str
>
> Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> ---
>  lib/bb/__init__.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 81b5a628..6378bce3 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -45,7 +45,11 @@ class BBLoggerMixin(object):
>              self.debug = self._debug_helper
>
>      def _debug_helper(self, *args, **kwargs):
> -        return self.bbdebug(1, *args, **kwargs)
> +        lvl = 1
> +        if isinstance(args[0], int):
> +            lvl = args[0]
> +            args = args[1:]
> +        return self.bbdebug(lvl, *args, **kwargs)
>
>      def debug2(self, *args, **kwargs):
>          return self.bbdebug(2, *args, **kwargs)
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13979): https://lists.openembedded.org/g/bitbake-devel/message/13979
> Mute This Topic: https://lists.openembedded.org/mt/93777549/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

