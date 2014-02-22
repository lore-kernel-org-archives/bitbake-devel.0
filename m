Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 37EA76E890
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 11:23:12 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1MBN0VE024860; Sat, 22 Feb 2014 11:23:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bxpYy1_OWMTM; Sat, 22 Feb 2014 11:23:00 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1MBMutQ024856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 22 Feb 2014 11:22:59 GMT
Message-ID: <1393068170.5181.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Sat, 22 Feb 2014 11:22:50 +0000
In-Reply-To: <CAJ2CSBs-RL_8V_nGYhY21k0J2E_ME3xwC3kgKLqt1PCEYwxLNQ@mail.gmail.com>
References: <CAJ2CSBs-RL_8V_nGYhY21k0J2E_ME3xwC3kgKLqt1PCEYwxLNQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: request for comments - dynamic task selection
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
X-List-Received-Date: Sat, 22 Feb 2014 11:23:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-02-20 at 19:17 +0000, Damian, Alexandru wrote:
> I have a RFC patch that attempts to improve build performance by
> dynamically selecting the next-to-run task based on  currently running
> tasks. The general idea is if we overload the network with too many
> fetch tasks, it's better to start doing unpack tasks while the disks
> idle instead of starting new fetch tasks. The concept can be generally
> applied, e.g. it's better to schedule package tasks in parallel with
> compile tasks instead of running all the compile tasks first and then
> all package tasks.
>
> This patch just looks at currently running tasks and selects the next
> available task that hasn't a similar-type task already running.
>
> I'm seeing a roughly 2% build time reduction when building the
> virtual:native components, with just 26 tasks reordered out of 244
> tasks executed. I am attaching a toaster.sqlite file that captures the
> test - build no.1 is done with the origin/master source, and build no.
> 2 is done with this patch applied.

The trouble with scheduler changes is that they're hard to evaluate as
the benefits may appear on one machine but cause issues on another.

Firstly, I'd like to see this as a new scheduler, not changing the
existing one. I'd then like Stefan to try this against our standard
performance tests, see what it does to our various benchmarks there.

I'd also note that do_fetch is not the best task for optimisation since
most people have relatively up to date source directories locally at any
point after their first build.

Cheers,

Richard



