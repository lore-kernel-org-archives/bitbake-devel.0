Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 97E297074F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 18:10:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6MIAapZ005638; Tue, 22 Jul 2014 19:10:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PyqrOF-_gHAI; Tue, 22 Jul 2014 19:10:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6MIAVlb005379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Jul 2014 19:10:33 +0100
Message-ID: <1406052631.22985.110.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 22 Jul 2014 19:10:31 +0100
In-Reply-To: <20140722144605.GT22875@jama>
References: <1405931753.22985.93.camel@ted> <20140722144605.GT22875@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] command/runqueue: Fix shutdown logic
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
X-List-Received-Date: Tue, 22 Jul 2014 18:10:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-07-22 at 16:46 +0200, Martin Jansa wrote:
> On Mon, Jul 21, 2014 at 09:35:53AM +0100, Richard Purdie wrote:
> > If you hit Ctrl+C at the right point, the system processes the request
> > but merrily continues building. It turns out finish_runqueue() is called
> > but this doesn't stop the later generation and execution of the
> > runqueue.
> > 
> > This patch adjusts some of the conditionals to ensure the build really
> > does stop.
> 
> Great, I've included this change in my world builds to see if it fixes
> bitbake still running after jenkins job is aborted.

I've seen that too and I don't think this fix will address that
unfortunately. Its on my list of things to look into.

> I don't think it's caused by this change and I don't know how much we
> can do about it, but today I was testing snort build (which eats all
> memory in m4 call until OOMK kills it) 

I ended up excluding snort from my builds for that reason. Builds go a
lot faster when its not destroying the machine!

> and when I wanted to interrupt
> the build it failed with 2 tracebacks:
> 
> NOTE: Preparing runqueue
> NOTE: Executing SetScene Tasks
> NOTE: Executing RunQueue Tasks
> NOTE: Running task 569 of 610 (ID: 5, /OE/build/oe-core/meta-openembedded/meta-networking/recipes-connectivity/snort/snort_2.9.6.0.bb, do_configure)
> NOTE: recipe snort-2.9.6.0-r0: task do_configure: Started
> ^C^C^C^C^C^C^C^C^C^C^C^C^C^CTraceback (most recent call last):
>   File "/OE/build/oe-core/bitbake/bin/bitbake", line 382, in <module>
>     ret = main()
>   File "/OE/build/oe-core/bitbake/bin/bitbake", line 372, in main
>     bb.event.ui_queue = []
> KeyboardInterrupt
> ^CException KeyboardInterrupt in <module 'threading' from '/usr/lib64/python2.7/threading.pyc'> ignored
> 
> ^CError in atexit._run_exitfuncs:
> ^CError in sys.exitfunc:
> Traceback (most recent call last):
>   File "/usr/lib64/python2.7/atexit.py", line 30, in _run_exitfuncs
>     traceback.print_exc()
>   File "/usr/lib64/python2.7/traceback.py", line 233, in print_exc
>     print_exception(etype, value, tb, limit, file)
>   File "/usr/lib64/python2.7/traceback.py", line 110, in print_exception
>     def print_exception(etype, value, tb, limit=None, file=None):
> KeyboardInterrupt
> 
> There was also about 5 minute delay between first 2 Ctrl+C and actual
> exit, but that could be caused by huge load caused by that faulty m4.

Thanks, I'll have a look at those and see if they're significant and if
we can do anything about them. It may be they are "one offs" and
unlikely to reproduce but we'll see.

Cheers,

Richard


