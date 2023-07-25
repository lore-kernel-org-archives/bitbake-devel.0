Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A512C001DE
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 16:39:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.25156.1690303157232473908
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jul 2023 09:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=hFdkBGMN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84E601C0004;
	Tue, 25 Jul 2023 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690303154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TAYH/LuEYTY5IIlxrJ943Ylnrlh3kl/Iy7RXe1gaanU=;
	b=hFdkBGMNVk0i2zB1iPs+Mg/mS1t8EW3XwIHmzLAnvYp6JqUmi85RDFmvwWCNrXUtXEGM0W
	INPYiqMqi3RpCY6zovfdIMPxP5+aZQMqcXdjPICb1a14/4l9OQOMAW2+gQd7GmzClh+nrT
	YyU5tAlTf0ptj04lNSWJbssO6m3E6T2vYsRT2er7dbLiYKLKse2E7+OuVbrNIU9Zm2Iedw
	oQqBIHTl0Vww5OJ3Bi52k3V9ol2AJAZIrkiA+lLvQBSgIa5smPJHmdSIirya6MB2qsz3g5
	kV27ZMxgS8ChWGMxWh/5twt8xQSUcARy0iLudm3GbhhBkk+QfCMOy9xJFP2hkA==
Date: Tue, 25 Jul 2023 18:39:14 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dit Kozmaj <dit.kozmaj@kynetics.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2: Set maxsplit to match expected
 variables
Message-ID: <202307251639147fff30ad@mail.local>
References: <20230725134710.85784-1-dit.kozmaj@kynetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725134710.85784-1-dit.kozmaj@kynetics.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jul 2023 16:39:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14889

Hello,

On 25/07/2023 13:47:10+0000, Dit Kozmaj wrote:
> From: Dit Kozmaj <dit.kozmaj@kynetics.com>
> 
> Set the maxsplit value to match the expected number of variables.
> This also avoids an unnecessary split as the parameters are in the form 'key=value'
> and the 'value' could contain the '=' character.
> 
> Signed-off-by: Dit Kozmaj <dit.kozmaj@kynetics.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 2 +-
>  bitbake/lib/bb/tests/fetch.py     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

This doesn't apply one master, which branch did you use? Can you rebase?

> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 3e6555bd67..79b289eaec 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -388,7 +388,7 @@ def decodeurl(url):
>              if s:
>                  if not '=' in s:
>                      raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
> -                s1, s2 = s.split('=')
> +                s1, s2 = s.split('=', 1)
>                  p[s1] = s2
>  
>      return type, host, urllib.parse.unquote(path), user, pswd, p
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
> index 61dd5cccaf..a261ad69d8 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):
>         "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
>         "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
>         "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
> +       "https://somesite.com/somerepo.git;user=anyUser:idtoken=1234" : ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtoken=1234'}),
>      }
>      # we require a pathname to encodeurl but users can still pass such urls to 
>      # decodeurl and we need to handle them
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14887): https://lists.openembedded.org/g/bitbake-devel/message/14887
> Mute This Topic: https://lists.openembedded.org/mt/100350479/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

