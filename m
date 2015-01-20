Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5B1D0729FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jan 2015 02:25:10 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0K2P9t0020474
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Mon, 19 Jan 2015 18:25:09 -0800 (PST)
Received: from [128.224.162.174] (128.224.162.174) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 19 Jan 2015 18:25:08 -0800
Message-ID: <54BDBC83.9030007@windriver.com>
Date: Tue, 20 Jan 2015 10:25:07 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1421158296.31262.17.camel@linuxfoundation.org>	
	<54BCBBF6.4020904@windriver.com>
	<1421663325.1798.31.camel@linuxfoundation.org>
In-Reply-To: <1421663325.1798.31.camel@linuxfoundation.org>
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
X-List-Received-Date: Tue, 20 Jan 2015 02:25:12 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


Hello RP,

I've got several errors like the following when the system's load is high,
not sure whether related to pyinotify.

for example, when do_configure:
sh: 0: Cannot fork

when do_package or others:
Exception: OSError: [Errno 11] Resource temporarily unavailable

// Robert

On 01/19/2015 06:28 PM, Richard Purdie wrote:
> On Mon, 2015-01-19 at 16:10 +0800, Robert Yang wrote:
>> The inotify watcher numbers need less than "sysctl -n fs.inotify.max_user_watches",
>> otherwise we may get the errors like:
>> WatchManagerError: add_watch: cannot watch /path/to/build/conf/bblayers.conf
>> WD=-1, Errno=No space left on device (ENOSPC),
>>
>> It's easy to meet this error if we run many builds at the same time,
>> On Ubuntu Ubuntu 12.04.3 x86_64, the default value is "8192".
>>
>> Can we add some counters in cooker.py (or other files) to check the
>> value and print ERRORS/WARNINGS, please ? Ther current "ENOSPC" errors
>> is not easy to debug.
>>
>> I'd like to work on it if that make sense.
>
> Surely we should just trap the ENOSPC error and translate it into a
> human readable error message? I don't like the idea of adding counters
> into the system.
>
> To improve the situation from a variety of perspectives, I'm thinking we
> should perhaps just place watches on the directories containing the
> files rather than the files themselves since this would drastically
> reduce the number of watches we need. The downside is we may have to be
> more careful about how we invalidate the caches.
>
> Cheers,
>
> Richard
>
>
>

