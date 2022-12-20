Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46771C4332F
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 16:41:54 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.54865.1671554508838373803
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 08:41:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BpB1WfGk;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id r26so18263047edc.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vwpVZ63IXAVFAiTRQm2B6TKaTw5wBogNPEi63RtbusU=;
        b=BpB1WfGkpBU0Xo9xDb5QqRe+7ttd7lv1lim5FgX2++OioNXe1FnLRo+/0iqFxYSa+X
         Ma5iJpSccWZsd0hPVO+DumS3L2Gqsx2atFMLONEmgx2xgkRtmybc7KXEbiuWhiR+K/ux
         sKAGurDUF6aTCSbAz/wDiVkn0zdd0+qe6ld+nLelyjobMUZxZTsFEKotAgH0GHAl1KX5
         a0VYCt/QAlnCuc6TRW7tco0a1GHuxM3FOfBr7QhZWhZiPRMsO7J3bISMxdWTTqUKNhVv
         JLbQvCR/xzG9HLPoq2CthUhCTmUVPC5g+HHPA8IPcw55b9yLpkJncnRmQbwnP3llKVuw
         dhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwpVZ63IXAVFAiTRQm2B6TKaTw5wBogNPEi63RtbusU=;
        b=qvxBQqIJTuPwQvG3xat9AB40zuK/Q0vTABQyUXxH9mbd2PTsr/Sfya8igrdf998PYq
         dYQtmDizcq4Yf4PVpowSul3l0LSj+6i1hM3gUAM/lFdkXc9KEu3XKWCpwkBH1VJc6CYJ
         QyrSeYq3dGXY4mJNjUpEMHkGswGIKaOJ0UMnewDhszoDmM2yWxqUZfa1OrKZ0UaxusUy
         CI0JFO+Tyc5lFMuaYiiUZZP8nKjaRn8Nuxv14m+ieSEWzJ6U3s2f0/piqgUwYqJAuhT/
         tKhCAT198MRuRdYFX6x/+RnYg+dV63r4OIj1rjuhaw/jbgM2K1kGCG4ni5/CJkWRkjRS
         VVVg==
X-Gm-Message-State: ANoB5plW3IQJg4ZCJqS38hDeJ22oyX3ATtWs7OjXEJVwQ0isUQNjQXnY
	pCGG4OQ/UGXsPzoTuYLPsxH47E6NG4m/i1z6bxw=
X-Google-Smtp-Source: AA0mqf7K3Pu4Ipu2QCe1JY9IDMWylUX052b1suD6mYxMbUl4/MwIIUV0JMiD/j2Cz3hoqKXcoSKgKRcK3KwMxl7G4s0=
X-Received: by 2002:a05:6402:ea2:b0:46f:fe46:df81 with SMTP id
 h34-20020a0564020ea200b0046ffe46df81mr4304083eda.56.1671554507253; Tue, 20
 Dec 2022 08:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org> <20221220151604.415637-4-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221220151604.415637-4-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 20 Dec 2022 10:41:35 -0600
Message-ID: <CAJdd5GbfF8ppFL7QZZ3F-XQconAtx0=uDhHd6MbqncbRo_yFeA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/6] event: builtins fix for 'd' deletion
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 16:41:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14216

On Tue, Dec 20, 2022 at 9:16 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> I've been seeing event handlers where 'd' seems to disappear half way through
> event handler execution. This is problematic when multiple threads are active
> since this code assumes single threading. Add in a recursive lock to avoid
> d being deleted from a context it shouldn't be.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/event.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 21e9a1b025..5df5b3a3ee 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -68,6 +68,7 @@ _catchall_handlers = {}
>  _eventfilter = None
>  _uiready = False
>  _thread_lock = threading.Lock()
> +_builtins_lock = threading.RLock()

Does this need to be a recursive lock?

>  _thread_lock_enabled = False
>  _heartbeat_enabled = False
>
> @@ -93,6 +94,9 @@ def disable_heartbeat():
>      _heartbeat_enabled = False
>
>  def execute_handler(name, handler, event, d):
> +    if _thread_lock_enabled:
> +        _builtins_lock.acquire()
> +
>      event.data = d
>      addedd = False
>      if 'd' not in builtins:
> @@ -115,6 +119,9 @@ def execute_handler(name, handler, event, d):
>          del event.data
>          if addedd:
>              del builtins['d']
> +        if _thread_lock_enabled:
> +            _builtins_lock.release()
> +
>
>  def fire_class_handlers(event, d):
>      if isinstance(event, logging.LogRecord):
> --
> 2.37.2
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14212): https://lists.openembedded.org/g/bitbake-devel/message/14212
> Mute This Topic: https://lists.openembedded.org/mt/95787500/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

