Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 77E9E65D4F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 08:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA48fZ9E031811; Tue, 4 Nov 2014 08:41:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ufIbMjzHreXA; Tue,  4 Nov 2014 08:41:35 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA48fXMh031808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 4 Nov 2014 08:41:35 GMT
Message-ID: <1415090528.23396.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Gary Thomas <gary@mlbassoc.com>
Date: Tue, 04 Nov 2014 08:42:08 +0000
In-Reply-To: <5457C903.2030703@mlbassoc.com>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
	<20141103154726.GA9716@bshelton-desktop> <1415035858.5111.45.camel@ted>
	<5457C903.2030703@mlbassoc.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Tue, 04 Nov 2014 08:42:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-11-03 at 11:27 -0700, Gary Thomas wrote:
> On 2014-11-03 10:30, Richard Purdie wrote:
> > On Mon, 2014-11-03 at 09:47 -0600, Ben Shelton wrote:
> >> On 11/02, Burton, Ross wrote:
> >>> On 27 October 2014 17:27, Ben Shelton <ben.shelton@ni.com> wrote:
> >>>
> >>>> In the commit 'prserv: Ensure data is committed', the PR server moved to
> >>>> only committing transactions to the database when the PR server is
> >>>> stopped.  This improves performance, but it means that if the machine
> >>>> running the PR server loses power unexpectedly or if the PR server
> >>>> process gets SIGKILL, the uncommitted package revision data is lost.
> >>>>
> >>>> To fix this issue, sync the database periodically, once per 30 seconds
> >>>> by default, if it has been marked as dirty.  To be safe, continue to
> >>>> sync the database at exit regardless of its status.
> >>>>
> >>>
> >>> This appears to be causing random problems for me where bitbake will
> >>> timeout attempting to access the PR database, my hunch is that it's
> >>> blocking on disk I/O.  Are there any tricks we can do with sqlite to reduce
> >>> the overhead of committing? (assuming that sqlite isn't causing a full
> >>> filesystem sync).
> >>>
> >>> Ross
> >>
> >> After running a few large nightly builds, we've seen some issues with
> >> this as well.  It looks like the issue is in the PR server itself, which
> >> logs this error:
> >>
> >> "OperationalError: cannot start a transaction within a transaction"
> >>
> >> However, I'm confused as to why this is happening, since the only place
> >> new transactions are being created is in the sync() function ("BEGIN
> >> EXCLUSIVE TRANSACTION"), and AFAIK that's only called by a single
> >> thread.  Any ideas?
> >
> > Did the commit() fail and therefore there was already an transaction
> > open? It leads to another quesiton of why the commit would fail (timeout
> > maybe?).
> >
> >> Would it make sense to revert the patch until we identify/fix the issue?
> >
> > You have flagged a valid issue that I would like to get to the bottom of
> > so perhaps not quite yet.
> >
> > I'm wondering if we can have some in memory copy of the table which we
> > flush to disk in a separate thread which wouldn't influence the PR
> > service request responses but its a horrible idea to workaround what
> > seems like a fundamental problem in sqlite :/.
> 
> I just got this error:
> ERROR: Can NOT get PRAUTO from remote PR service
> ERROR: Function failed: package_get_auto_pr
> ERROR: Logfile of failure stored in: /home/local/rpi-latest_2014-10-30/tmp/work/armv6-vfp-amltd-linux-gnueabi/usbutils/007-r0/temp/log.do_package.13260
> ERROR: Task 3204 (/home/local/poky-latest/meta/recipes-bsp/usbutils/usbutils_007.bb, do_package) failed with exit code '1'
> 
> Is it the same as what's being discussed above?

Yes.

>   Where can I
> look for more info on what happened?

We're still figuring out what is going on but it is roughly that:

a) The build generates a ton of IO
b) That IO builds up into a queue
c) The PR service decides it needs to sync to disk
d) The PR service hits an fsync() of some kind in sqlite whilst writing 
e) The PR service is blocked for its clients until the sync() finishes
f) Connections to the PR service timeout.

It would be nice if we could write the sqlite data in a separate thread
whilst the readers continue. There is an asynchronous module but its
deprecated:

http://www.sqlite.org/asyncvfs.html

WAL is recommended instead:

http://www.sqlite.org/wal.html

so we probably need to look at that.

> n.b. I just restarted my build and it seems happy to carry on
> where it left off.

No data is lost and this is a transient issue.

Why not revert the patch? The issue is that the data in the PR service
whilst in memory, *never* makes it to disk until process exit time. This
is bad if your build server loses power for example. I would therefore
like to try and fix this rather then revert.

Cheers,

Richard


