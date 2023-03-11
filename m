Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E8C61DA4
	for <webhook@archiver.kernel.org>; Sat, 11 Mar 2023 23:20:49 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.56600.1678576843372814538
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Mar 2023 15:20:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IZ4GlUuD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 852E540003;
	Sat, 11 Mar 2023 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1678576841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qepSr7BvEj/ooaYzG6d39fyTj5lHewvkN3mAWpzMhvA=;
	b=IZ4GlUuDGz0tCmx9Yp09FqX4Cl19z3l/0qt7PzELRqb4+HPc29WFIMV75kDUKrCWVKEhrj
	1GGBkBkNLCa5WzgVQjp5fcNJbA0jk4C7fDgSSCjrCCEHANQ1ME48H4RjQ0obth7i9HW63k
	r/C/j+10GS+kUjRA9Bx+qFAFQKzWJ2gAub4tnYqzPKdFfSUmPwQpqVNWj+HtncuPDuEiMM
	kUe/Km5L2ldvMW9t8bmMZCnTPACXFBff6S4KPW+qjSyLayHoplAEdK+grmT0QWoZVNCNS7
	yKOiKfbwfjE40a4+5b1yReSrsG+Upz48NRBL2lUs4jbhkTiRJPahmiIkrzKYXQ==
Date: Sun, 12 Mar 2023 00:20:39 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Asselstine <mark.asselstine@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2] build: Make python output print to
 stdout when running with -v (verbose)
Message-ID: <202303112320399533191a@mail.local>
References: <20230310145842.5412-1-mark.asselstine@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310145842.5412-1-mark.asselstine@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Mar 2023 23:20:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14549

Hello,

This seems to break bitbake selftests:

https://autobuilder.yoctoproject.org/typhoon/#builders/127/builds/1082/steps/15/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/80/builds/4859/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/87/builds/4938/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/79/builds/4912/steps/15/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/86/builds/4903/steps/14/logs/stdio



On 10/03/2023 09:58:42-0500, Mark Asselstine wrote:
> When tasks are run with -v (verbose) on the bitbake commandline, shell
> tasks print their stdout, python tasks do not.
> 
> This change redirects the python task's print output to an in memory
> buffer. After the task is executed the output is printed to stdout via
> the logger. This makes the python task behavior match the shell task
> behavior when running with -v. The contents of the task's log files
> remain unchanged after this change.
> 
> This approach should keep the correct order in most cases, however, if
> the python task accesses the logger directly, that content will appear
> before other output. On the other hand, this change should negate the
> need for python tasks to access the logger directly.
> 
> The following example will produce out-of-order output
> 
> --
> python do_build() {
>    import sys
>    print("Start")
>    print("Oops!", file=sys.stderr)
>    bb.plain("********************");
>    bb.plain("*                  *");
>    bb.plain("*  Hello, World!   *");
>    bb.plain("*                  *");
>    bb.plain("********************");
>    print("Finish")
> }
> --
> will output
> --
> ********************
> *                  *
> *  Hello, World!   *
> *                  *
> ********************
> Start
> Oops!
> Finish
> --
> 
> The logging-test.bb in meta-selftest or the above 'hello world!' can
> be used to review this change.
> 
> [Yocto #14544]
> 
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> ---
> 
> v2: Richard, per your suggestions, I have added capturing stderr and
> also storing and restoring the previous stdout and stderr. Since we
> are already flushing stdout and stderr when verboseStdoutLogging I
> have skipped the second flushes.
> 
>  lib/bb/build.py | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 5a172711..786c215c 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -25,6 +25,7 @@ import bb
>  import bb.msg
>  import bb.process
>  import bb.progress
> +from io import StringIO
>  from bb import data, event, utils
>  
>  bblogger = logging.getLogger('BitBake')
> @@ -296,13 +297,27 @@ def exec_func_python(func, d, runfile, cwd=None):
>          lineno = int(d.getVarFlag(func, "lineno", False))
>          bb.methodpool.insert_method(func, text, fn, lineno - 1)
>  
> +        if verboseStdoutLogging:
> +            sys.stdout.flush()
> +            sys.stderr.flush()
> +            currout = sys.stdout
> +            currerr = sys.stderr
> +            sys.stderr = sys.stdout = execio = StringIO()
>          comp = utils.better_compile(code, func, "exec_func_python() autogenerated")
>          utils.better_exec(comp, {"d": d}, code, "exec_func_python() autogenerated")
>      finally:
> -        # We want any stdout/stderr to be printed before any other log messages to make debugging
> -        # more accurate. In some cases we seem to lose stdout/stderr entirely in logging tests without this.
> -        sys.stdout.flush()
> -        sys.stderr.flush()
> +        if verboseStdoutLogging:
> +            execio.flush()
> +            logger.plain("%s" % execio.getvalue())
> +            sys.stdout = currout
> +            sys.stderr = currerr
> +            execio.close()
> +        else:
> +            # We want any stdout/stderr to be printed before any other log
> +            # messages to make debugging more accurate. In some cases we seem
> +            # to lose stdout/stderr entirely in logging tests without this.
> +            sys.stdout.flush()
> +            sys.stderr.flush()
>          bb.debug(2, "Python function %s finished" % func)
>  
>          if cwd and olddir:
> -- 
> 2.30.2
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14538): https://lists.openembedded.org/g/bitbake-devel/message/14538
> Mute This Topic: https://lists.openembedded.org/mt/97520900/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

