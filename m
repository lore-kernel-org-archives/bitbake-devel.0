Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 89BBE65D59
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 08:10:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0J8AW8s003374
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Mon, 19 Jan 2015 00:10:33 -0800 (PST)
Received: from [128.224.162.174] (128.224.162.174) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 19 Jan 2015 00:10:31 -0800
Message-ID: <54BCBBF6.4020904@windriver.com>
Date: Mon, 19 Jan 2015 16:10:30 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <1421158296.31262.17.camel@linuxfoundation.org>
In-Reply-To: <1421158296.31262.17.camel@linuxfoundation.org>
Subject: Re: [PATCH] bitbake: Add pyinotify to lib/
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
X-List-Received-Date: Mon, 19 Jan 2015 08:10:38 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Resend since the previous message body is too big.

Hi RP,

The inotify watcher numbers need less than "sysctl -n fs.inotify.max_user_watches",
otherwise we may get the errors like:
WatchManagerError: add_watch: cannot watch /path/to/build/conf/bblayers.conf 
WD=-1, Errno=No space left on device (ENOSPC),

It's easy to meet this error if we run many builds at the same time,
On Ubuntu Ubuntu 12.04.3 x86_64, the default value is "8192".

Can we add some counters in cooker.py (or other files) to check the
value and print ERRORS/WARNINGS, please ? Ther current "ENOSPC" errors
is not easy to debug.

I'd like to work on it if that make sense.

// Robert

On 01/13/2015 10:11 PM, Richard Purdie wrote:
> We need inotify support within bitbake and pyinotify provides the best
> mechanism to add this. We have a few options:
>
> a) Depend on pyinotify from the system
> b) Add in our own copy
> c) Only use pyinotify in cases like the memory resident server
>
> For a), it would mean adding in dependencies, updating documentation and
> generally creating churn for users as well as having implications for things
> like the build-appliance recipe.
>
> It turns out that glibc has the C functionality we need from version 2.4
> onwards (2006) and that we just need a single python file for b), there
> is no binary module needed. We therefore add in a copy of pyinotify 0.9.5
> into the tree meaning we can depend on it simply and unconditionally.
>
> c) is unattractive as we need fewer possible code paths, not more.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/pyinotify.py b/bitbake/lib/pyinotify.py
> new file mode 100644
> index 0000000..2dae002
> --- /dev/null
> +++ b/bitbake/lib/pyinotify.py
> @@ -0,0 +1,2416 @@
> +#!/usr/bin/env python

