Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 593237CB94
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 21:13:06 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id o17so59388wrw.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=k5HKpCrUzh3o5PnGaoUqO5+ClGbXrBuyu8HFL4KgzkM=;
	b=Vwtv8DCIZkG2deQJUswwui4E+d1nQcovGNPSlYAlGrUFCyPBoGBFNIh4byKThmAHVy
	8vVclpLb000O0YzpntAYyusK7Tuao4Hq+q8moHHNFHeE9HQXOTnW1q9rYXJfcBgdSIl0
	zIn3b/tDq0oAyRs5B+qfXE2PnQ9LxrLJFXkZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=k5HKpCrUzh3o5PnGaoUqO5+ClGbXrBuyu8HFL4KgzkM=;
	b=miQNM4LHeYhJWXpOfwglsjJDrcWkGSDxH6Am9AmdjHmKddS0XdFRDyGlGEUXakB/mm
	UoPfmXJjqMzd8stSnRp/BX9onKvV46TWJSOfJEJ60LrJ30E+2X5qTHKJABrIjZCwSRcp
	IDgmUM1kasyk40qPVMDXy4TwsrKPSfMK8rZkLY2sGlsRzSMhqhS3djUgWRggD6qGy9S9
	3le6khmT0X6CviPrktV3lAv66PqW40rX+Zot1UeUvCaxoTTRKaRCqbZOXKyErMVANEcD
	P9CpsFnxHEVCBoqUkObqAQTJvdSlcio/krUr0KSaueCEsQlhSVzdg/aRDNZmTkUiCsxz
	a3Uw==
X-Gm-Message-State: AHQUAubpMmb3gB1BUHzxPLAmUq0ur7tCn+AtCrNK7FDWImUqfoJdaKXo
	S9STDOHgIjyuVMBLQL2Jj3lsUuIsZNU=
X-Google-Smtp-Source: AHgI3IYLnvrpMqDkexm9caqw+io8EPoU/z6+/LQ4RAx0WKaagpeHnQFE1jUgTZYk6w9jKBdrod5+IQ==
X-Received: by 2002:adf:ffcf:: with SMTP id x15mr313106wrs.277.1550783587017; 
	Thu, 21 Feb 2019 13:13:07 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	132sm25891379wmd.27.2019.02.21.13.13.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Feb 2019 13:13:06 -0800 (PST)
Message-ID: <429831d9241a7ec21e84523a354c89f9a97263ad.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Laplante <chris.laplante@agilent.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 21 Feb 2019 21:13:05 +0000
In-Reply-To: <1538621300-112900-1-git-send-email-chris.laplante@agilent.com>
References: <1538621300-112900-1-git-send-email-chris.laplante@agilent.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [PATCH] build.py: support custom task [progress] handlers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Feb 2019 21:13:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-10-03 at 22:48 -0400, Chris Laplante via bitbake-devel
wrote:
> To use this mechanism, you need to inject your progress handler (i.e.
> something derived from bb.progress.ProgressHandler) into
> __builtins__.
> Here's one way to do it (from recipe-space):
> 
>     def install_my_progress_handler():
>         from bb.progress import ProgressHandler
> 
>         class MyProgressHandler(ProgressHandler):
>             pass
> 
>         if "MyProgressHandler" not in __builtins__:
>             __builtins__["MyProgressHandler"] = MyProgressHandler
> 
>         return "OK"
> 
>     _INSTALL_MY_PROGRESS_HANDLERS := "${@install_my_progress_handler(
> )}"

Sorry about the lack of review.

My concern on this is the fact we have to poke around __builtins__. I
understand why, I just can't help wonder if there is a better way
somehow.

I'm not sure I have a better one, not sure if Chris or others might?

Cheers,

Richard


> To install on a task:
>     do_task[progress] = "custom:MyProgressHandler"
> 
> To install on a task and pass extra arguments:
>     do_task[progress] = "custom:MyProgressHandler:my-arg"
> 
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/build.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 3e2a94e..2e14572 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -387,6 +387,14 @@ exit $ret
>          elif progress.startswith('outof:'):
>              # Use specified regex
>              logfile = bb.progress.OutOfProgressHandler(d,
> regex=progress.split(':', 1)[1], outfile=logfile)
> +        elif progress.startswith("custom:"):
> +            # Use a custom progress handler
> +            parts = progress.split(":", 2)
> +            _, cls, otherargs = parts[0], parts[1], (parts[2] or
> None) if parts[2:] else None
> +            if cls and cls in __builtins__:
> +                logfile = __builtins__[cls](d, outfile=logfile,
> otherargs=otherargs)
> +            else:
> +                bb.warn('%s: unknown custom progress handler in task
> progress varflag value "%s", ignoring' % (func, cls))
>          else:
>              bb.warn('%s: invalid task progress varflag value "%s",
> ignoring' % (func, progress))
>  
> -- 
> 2.7.4
> 


