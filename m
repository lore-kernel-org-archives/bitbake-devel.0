Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3E3F07162E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 10:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0JAT0nw006718; Mon, 19 Jan 2015 10:29:00 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id choYWIEe1rYj; Mon, 19 Jan 2015 10:29:00 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0JASjBK006693
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Jan 2015 10:28:57 GMT
Message-ID: <1421663325.1798.31.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 19 Jan 2015 10:28:45 +0000
In-Reply-To: <54BCBBF6.4020904@windriver.com>
References: <1421158296.31262.17.camel@linuxfoundation.org>
	<54BCBBF6.4020904@windriver.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 19 Jan 2015 10:29:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-01-19 at 16:10 +0800, Robert Yang wrote:
> The inotify watcher numbers need less than "sysctl -n fs.inotify.max_user_watches",
> otherwise we may get the errors like:
> WatchManagerError: add_watch: cannot watch /path/to/build/conf/bblayers.conf 
> WD=-1, Errno=No space left on device (ENOSPC),
> 
> It's easy to meet this error if we run many builds at the same time,
> On Ubuntu Ubuntu 12.04.3 x86_64, the default value is "8192".
> 
> Can we add some counters in cooker.py (or other files) to check the
> value and print ERRORS/WARNINGS, please ? Ther current "ENOSPC" errors
> is not easy to debug.
> 
> I'd like to work on it if that make sense.

Surely we should just trap the ENOSPC error and translate it into a
human readable error message? I don't like the idea of adding counters
into the system.

To improve the situation from a variety of perspectives, I'm thinking we
should perhaps just place watches on the directories containing the
files rather than the files themselves since this would drastically
reduce the number of watches we need. The downside is we may have to be
more careful about how we invalidate the caches.

Cheers,

Richard


