Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 4E6107E668
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 22:39:40 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id v15so10211872wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=g+7vSUdxKzrm5T9v4KVl3zCFqvL2wgBjV1o/kcy8h/4=;
	b=RNqNYLlJAu1J1YARTEy0QF4uiEbt20+9WedIzh2Ju3Z5pBJloKTRa0KxG0+wg0j0mo
	fLgHgU4sFkReWFjU9OiGSTVCTmc3006ID+Iqkd7cosezkMx4MBTYIYVeQMSttOcTieY/
	Rl6gjy1rTmk+JdwkkBQ87jas3pflcag7PAZq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=g+7vSUdxKzrm5T9v4KVl3zCFqvL2wgBjV1o/kcy8h/4=;
	b=Lbu/7m1pEMh07ryJt5eMNp6QnxElclFZ63EMkGfLebeClTt3yaT13TymQL+xG4LEBh
	uOp/fXiIabvTTcK1em9j5vELwUhZfUPJznrrVTzpl+ZAJiKvHGXsuQWExBc4IOhqVPQv
	+2QjQ1GM26bggBuzwyCoIIwWsKGEsWl4oyyo5xfAj3KgzuGtoYaBmPanOXGm8U+Bbff0
	oK+VW0Mlhp8qfigsGvCtC7XeEfhFOdluqVs6FhlTTbGiswo2Der1P/njjozpGn7DT7CI
	/opZXKglPZf4yQi96xhJj+rf0iax/Rf26aCa+LLsCmilwwiQaxDMo6jQLfZM28Rdht04
	w/eQ==
X-Gm-Message-State: APjAAAWDwr001eIGxKuuDjW8JS0UsSeiL1Ixgm7+uQKpNwon2NLWi4Gf
	jIEGW28OR2OFPKYp5BAijqH3P/jp7ds=
X-Google-Smtp-Source: APXvYqy46Fmk8sJJ+aDlU+mI5wsZFtkz7g3ZbjPcWhwDO20M9UD7zuHEzv3sNz7ee6tbosGAuQPBqw==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr11312163wmd.73.1562971180658;
	Fri, 12 Jul 2019 15:39:40 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id z7sm8441348wrh.67.2019.07.12.15.39.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 15:39:39 -0700 (PDT)
Message-ID: <67745c66fe9252c8e5acaa42c5f34110f6c17848.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 23:39:38 +0100
In-Reply-To: <20190712131349.29918-2-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
	<20190712131349.29918-2-richard.purdie@linuxfoundation.org>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] runqueue: Streamline outright setscene failure handling
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
X-List-Received-Date: Fri, 12 Jul 2019 22:39:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-07-12 at 14:13 +0100, Richard Purdie wrote:
> With the recent codebase changes we can just call the outrightfail
> function immediately, removing some intermediate data structures.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 48b668abc1..2d52ef3190 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1913,9 +1913,6 @@ class RunQueueExecute:
>                              self.sq_task_skip(nexttask)
>                              self.scenequeue_notneeded.add(nexttask)
>                              return True
> -                    if nexttask in self.sqdata.outrightfail:
> -                        self.sq_task_failoutright(nexttask)
> -                        return True
>                      task = nexttask
>                      break
>          if task is not None:
> @@ -2330,8 +2327,6 @@ class SQData(object):
>          self.stamps = {}
>          # Setscene tasks directly depended upon by the build
>          self.unskippable = set()
> -        # List of setscene tasks which aren't present
> -        self.outrightfail = []
>          # A list of normal tasks a setscene task covers
>          self.sq_covered_tasks = {}
>  
> @@ -2553,7 +2548,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
>          for tid in sqdata.sq_revdeps:
>              if tid not in valid_new and tid not in noexec:
>                  logger.debug(2, 'No package found, so skipping setscene task %s', tid)
> -                sqdata.outrightfail.append(tid)
> +                sqrq.sq_task_failoutright(tid)
>  
>  class TaskFailure(Exception):
>      """

I'm going to NAK my own patch. There is logic inbetween these two
points which may end up covering the task without it needing to run. In
particular do_shared_workdir in the kernel never has a valid sstate
artefact and this change causes eSDK to break *if and only if* that
task hasn't already been run in a given build directory.

This did result in a single failure on the autobuilder but shows how
much fun this code is.

I'll ponder this further, its likely going to be better to pass around
the "valid" list and totally streamline and rewrite some horrible code
here.

Cheers,

Richard




