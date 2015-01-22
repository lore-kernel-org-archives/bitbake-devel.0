Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E3E3972BCE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 09:10:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0M9AGxt023903
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Thu, 22 Jan 2015 01:10:16 -0800 (PST)
Received: from [128.224.162.174] (128.224.162.174) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.174.1;
	Thu, 22 Jan 2015 01:10:15 -0800
Message-ID: <54C0BE76.7030601@windriver.com>
Date: Thu, 22 Jan 2015 17:10:14 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1421158296.31262.17.camel@linuxfoundation.org>		<54BCBBF6.4020904@windriver.com>	<1421663325.1798.31.camel@linuxfoundation.org>
	<54BDBC83.9030007@windriver.com>
In-Reply-To: <54BDBC83.9030007@windriver.com>
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
X-List-Received-Date: Thu, 22 Jan 2015 09:10:17 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi RP,

I think that I can confirm it is caused by exceeded the max user processes,
the default value on my host is:

$ ulimit -u
5000

When the "cannot fork" error happens, the top shows that there are more than
4000 processes, here is the data from "top -d 2 -b":

Tasks: 4547 total, 1070 running, 3443 sleeping,   6 stopped,  28 zombie
Tasks: 4654 total, 1109 running, 3499 sleeping,   6 stopped,  40 zombie
Tasks: 4682 total, 1114 running, 3531 sleeping,   6 stopped,  31 zombie
Tasks: 4753 total, 1110 running, 3597 sleeping,   6 stopped,  40 zombie
Tasks: 4519 total, 1056 running, 3417 sleeping,   6 stopped,  40 zombie
Tasks: 4547 total, 1096 running, 3424 sleeping,   6 stopped,  21 zombie
Tasks: 4632 total, 1140 running, 3453 sleeping,   6 stopped,  33 zombie
Tasks: 4633 total, 1039 running, 3563 sleeping,   6 stopped,  25 zombie
Tasks: 4737 total, 1089 running, 3611 sleeping,   6 stopped,  31 zombie
Tasks: 4670 total, 1121 running, 3512 sleeping,   6 stopped,  31 zombie
Tasks: 4506 total, 1045 running, 3433 sleeping,   6 stopped,  22 zombie
Tasks: 4522 total, 1056 running, 3427 sleeping,   6 stopped,  33 zombie
Tasks: 4491 total, 1098 running, 3363 sleeping,   6 stopped,  24 zombie
Tasks: 4565 total, 1101 running, 3432 sleeping,   6 stopped,  26 zombie
Tasks: 4559 total, 1112 running, 3406 sleeping,   6 stopped,  35 zombie
Tasks: 4775 total, 1119 running, 3620 sleeping,   6 stopped,  30 zombie
Tasks: 4677 total, 1109 running, 3545 sleeping,   6 stopped,  17 zombie
Tasks: 4618 total, 1093 running, 3486 sleeping,   6 stopped,  33 zombie
Tasks: 4518 total, 1100 running, 3385 sleeping,   6 stopped,  26 zombie

I run 5 builds on the same host, each of them is BB_NUMBER_THREADS=32 and
PARALLEL_MAKE="-j32", I can get the error every time when "bitbake image".
Then I use "ulimit -u 10000", the "bitbake image" works well, and the
world is in building.

I've never seen this problem before 2015/01/02 (on the same host), did we
improve bitbake's parallel recently, please ?

I have two rough ideas to fix the problem:
1) Let bitbake check the remaining processes account before start new
processes.
2) Try to reduce forking process in meta/classes, for example:
    <foo> | grep | sed
    We can get rid of "grep" to reduce forking.

What's your opinion, please ?

// Robert

On 01/20/2015 10:25 AM, Robert Yang wrote:
>
> Hello RP,
>
> I've got several errors like the following when the system's load is high,
> not sure whether related to pyinotify.
>
> for example, when do_configure:
> sh: 0: Cannot fork
>
> when do_package or others:
> Exception: OSError: [Errno 11] Resource temporarily unavailable
>
> // Robert
>
> On 01/19/2015 06:28 PM, Richard Purdie wrote:
>> On Mon, 2015-01-19 at 16:10 +0800, Robert Yang wrote:
>>> The inotify watcher numbers need less than "sysctl -n
>>> fs.inotify.max_user_watches",
>>> otherwise we may get the errors like:
>>> WatchManagerError: add_watch: cannot watch /path/to/build/conf/bblayers.conf
>>> WD=-1, Errno=No space left on device (ENOSPC),
>>>
>>> It's easy to meet this error if we run many builds at the same time,
>>> On Ubuntu Ubuntu 12.04.3 x86_64, the default value is "8192".
>>>
>>> Can we add some counters in cooker.py (or other files) to check the
>>> value and print ERRORS/WARNINGS, please ? Ther current "ENOSPC" errors
>>> is not easy to debug.
>>>
>>> I'd like to work on it if that make sense.
>>
>> Surely we should just trap the ENOSPC error and translate it into a
>> human readable error message? I don't like the idea of adding counters
>> into the system.
>>
>> To improve the situation from a variety of perspectives, I'm thinking we
>> should perhaps just place watches on the directories containing the
>> files rather than the files themselves since this would drastically
>> reduce the number of watches we need. The downside is we may have to be
>> more careful about how we invalidate the caches.
>>
>> Cheers,
>>
>> Richard
>>
>>
>>

