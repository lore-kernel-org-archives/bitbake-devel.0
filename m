Return-Path: <andy@warmcat.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9CCCA47B
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 11:05:10 +0000 (UTC)
Received: from warmcat.com (warmcat.com [46.105.127.147])
 by mx.groups.io with SMTP id smtpd.web09.27048.1657537498867671588
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Jul 2022 04:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@warmcat.com header.s=default header.b=FlYJJjCB;
 spf=pass (domain: warmcat.com, ip: 46.105.127.147,
 mailfrom: andy@warmcat.com)
Message-ID: <13490b23-28c1-1c15-8ee0-e2009451ccb3@warmcat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 warmcat.com 27C6860BA2D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
	s=default; t=1657537497;
	bh=ds3zGjlZlZ5edTHjW6kBH5iORWKmH33xXYwrfCAsJpQ=;
	h=Date:To:From:Subject:From;
	b=FlYJJjCBv6aIhicXfEUqSzXxuHI3znsKjYnuZRspWyWzFhflfvC+SQkIjoa2jQ/vD
	 E7xHLD71mTqcNcNFb8UdwpwgCIL3nu8F3C6L6fVzetoWwgEjRXD2pDC5PqJLWt5OI5
	 RV/ieLjcf1y0gsrKcfc74mpsNjp8ghwgzV9B7lE4=
Date: Mon, 11 Jul 2022 12:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Andy Green <andy@warmcat.com>
Subject: gitsm: problem with large submodule-structured repo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Jul 2022 11:05:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13819

Hi -

I am trying to build a large proprietary project from its repo with 
bitbake and gitsm://

This project can be cloned and its submodules initialized well (and 
built in fact) using:

$ git submodule update --init --recursive

... so I don't think there's any basic sanity problems with it.

If I look in the toplevel .git/modules after that, I see this structure 
reflecting a total of 57 submodules underneath

../.git/modules/a/b/i/config
../.git/modules/a/b/c/j/config
../.git/modules/a/b/c/k/config
../.git/modules/a/b/c/l/config
../.git/modules/a/b/c/m/modules/c/G/config
../.git/modules/a/b/c/o/config
../.git/modules/a/b/c/p/config
../.git/modules/a/b/c/q/config
../.git/modules/a/b/c/q/modules/H/config
../.git/modules/a/b/c/q/modules/I/config
../.git/modules/a/b/c/q/modules/J/config
../.git/modules/a/b/c/q/modules/K/config
../.git/modules/a/b/c/q/modules/L/config
../.git/modules/a/b/c/q/modules/M/config
../.git/modules/a/b/c/r/config
../.git/modules/a/b/c/r/modules/N/O/config
../.git/modules/a/b/c/r/modules/P/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/modules/a1/b1/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/modules/a1/c1/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/modules/a1/d1/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/modules/a1/e1/config
../.git/modules/a/b/c/r/modules/P/modules/lib/Y/modules/a1/f1/config
../.git/modules/a/b/c/r/modules/Q/g1/config
../.git/modules/a/b/c/r/modules/c/R/config
../.git/modules/a/b/c/s/config
../.git/modules/a/b/c/t/config
../.git/modules/a/b/c/u/config
../.git/modules/a/b/c/v/config
../.git/modules/a/b/c/v/modules/S/config
../.git/modules/a/b/c/w/config
../.git/modules/a/b/c/x/config
../.git/modules/a/b/c/x/modules/modules/T/config
../.git/modules/a/b/c/y/config
../.git/modules/a/b/c/z/config
../.git/modules/a/b/c/z/modules/U/Z/config
../.git/modules/a/b/c/z/modules/U/Z/modules/h1/i1/config
../.git/modules/a/b/c/z/modules/U/Z/modules/j1/config
../.git/modules/a/b/c/z/modules/U/Z/modules/j1/modules/lib/k1/l1/config
../.git/modules/a/b/c/A/config
../.git/modules/a/b/c/A/modules/V/W/config
../.git/modules/a/b/c/B/config
../.git/modules/a/b/c/B/modules/U/Y/config
../.git/modules/a/b/c/B/modules/U/Y/modules/a1/m1/config
../.git/modules/a/b/c/B/modules/U/Y/modules/a1/n1/config
../.git/modules/a/b/c/B/modules/U/Y/modules/a1/o1/config
../.git/modules/a/b/c/B/modules/U/Y/modules/a1/p1/config
../.git/modules/a/b/c/B/modules/U/Y/modules/a1/q1/config
../.git/modules/a/b/c/C/config
../.git/modules/a/b/c/C/modules/X/config
../.git/modules/a/b/d/config
../.git/modules/a/b/e/config
../.git/modules/a/b/f/config
../.git/modules/a/b/g/config
../.git/modules/a/b/h/D/config
../.git/modules/a/b/h/E/config
../.git/modules/a/b/h/F/config

Note that there are some reused strings at different depth levels in that.

During the bitbake gitsm:// attempt it can check out a couple of dozen 
subrepos OK (with what I think are harmless warnings about non-absolute 
repo urls).

...
WARNING: XXX-1.0-r0 do_fetch: Submodule included by 
gitsm://git@xxx.com/r/P.git;protocol=ssh;name=I;subpath=I;bareclone=1;nobranch=1 
refers to relative ssh reference git@xxx.com:r/Y.git.  References may 
fail if not absolute.
WARNING: XXX-1.0-r0 do_fetch: Failed to fetch URL 
gitsm://git@xxx.com/c/s.git;protocol=ssh;name=X/Y;subpath=X/Y;Y=1;nobranch=1, 
attempting MIRRORS if available
ERROR: XXX-1.0-r0 do_fetch: Fetcher failure: Unable to find revision 
12345f9dfb053a87d4a3aa83a59400f2e181c8d7 in branch  even from upstream
ERROR: XXX-1.0-r0 do_fetch: gitsm: submodule download failed: FetchError 
Fetcher failure for URL: 
'gitsm://git@xxx.com/r/s.git;protocol=ssh;name=X/Y;subpath=X/Y;bareclone=1;nobranch=1'. 
Unable to fetch URL from any source.
WARNING: XXX-1.0-r0 do_fetch: Failed to fetch URL 
gitsm://git@xxx.com/r/P.git;protocol=ssh;name=Installer;subpath=Installer;bareclone=1;nobranch=1, 
attempting MIRRORS if available

If I subvert the generation of the exception in python, and let it 
continue past this error (which is interesting because otherwise it must 
fetch 6.5GB from the remote each time I try it since it feels the clone 
as a whole failed), then while trying to bring files over using git lfs 
it dies with (this is unlikely to be literally true)

batch request: Bad owner or permissions on 
/etc/ssh/ssh_config.d/50-redhat.conf: exit status 255

Any suggestions for how to proceed?

Thanks,

-Andy

