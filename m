Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC0C4706F
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 20:28:16 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.228198.1704054490095193236
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 12:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XolqAUlL;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7E7DC0002;
	Sun, 31 Dec 2023 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704054488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CputC1UvIOD4nLPTOkdul02zL6zrFpX5z6lCoPsZEKQ=;
	b=XolqAUlLpXef/7nUENAsvffVcNKpteIUT/wQ+cl5clNK7Tc9MOfj5RzoagCZdFKN5rSOdM
	gYgWQrsA/Twrlu0xdfpx+zcos/teYcdxNTYTUUjmDZImHbyb4jjCTRC8rR4CBdgEzXqsI8
	dp9CnaU3AwqwJK72qvxCDlUBVbE3KbvJcDSy6UiFp2OdTebDwLntx1ZVmnqRbcrlAYxAJ5
	HDLR2STbGZeWD9+cIQ1VN/xi1se9ypdX0SEIhwsDd+hLnvup4NzJYv4KCeJFDAB/2WsNEm
	P7ZQ1VLMrnOtYuHOo92vwOFehRAh5HDIgkH8cN6VyTp55TAltS2ow+gomL6kqw==
Date: Sun, 31 Dec 2023 21:28:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: liezhi.yang@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 1/1] bitbake: event: Inject empty
 lines to make code match lineno in filename
Message-ID: <202312312028077ba80d35@mail.local>
References: <cover.1703829627.git.liezhi.yang@windriver.com>
 <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 20:28:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15736

This causes bitbake-selftest failures:

======================================================================
ERROR: test_register_from_string (bb.tests.event.EventHandlingTest)
Test register method receiving code in string
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/tests/event.py", line 121, in test_register_from_string
    result = bb.event.register("string_handler", "    return True")
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 261, in register
    tmp = "\n" * (lineno-1) + tmp
TypeError: unsupported operand type(s) for -: 'NoneType' and 'int'

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6202/steps/11/logs/stdio

On 28/12/2023 22:06:42-0800, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> So that we can get the correct error messages.
> 
> * In python 3.10.9, the error message was:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>       # SPDX-License-Identifier: MIT
>              ^^^^^
>   SyntaxError: invalid syntax
> 
>   This is hard to debug since the error line number 4 is incorrect, but nothing
>   is wrong with the code in line 4.
> 
> * Now the error message and lineno is correct:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>       an error line
>          ^^^^^
>   SyntaxError: invalid syntax
> 
> And no impact on parsing time:
> * Before:
> $ rm -fr cache tmp; time bitbake -p
> real    0m27.254s
> 
> * Now:
> $ rm -fr cache tmp; time bitbake -p
> real    0m27.200s
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/event.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index f8acacd80d1..7722258b7e8 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -257,6 +257,8 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
>          # handle string containing python code
>          if isinstance(handler, str):
>              tmp = "def %s(e, d):\n%s" % (name, handler)
> +            # Inject empty lines to make code match lineno in filename
> +            tmp = "\n" * (lineno-1) + tmp
>              try:
>                  code = bb.methodpool.compile_cache(tmp)
>                  if not code:
> -- 
> 2.42.0
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15717): https://lists.openembedded.org/g/bitbake-devel/message/15717
> Mute This Topic: https://lists.openembedded.org/mt/103413642/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

