Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 57EC265E94
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 14:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4EDMj4021969; Tue, 4 Nov 2014 14:13:22 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oYpzkmkWF-09; Tue,  4 Nov 2014 14:13:22 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4EDJ4V021966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 4 Nov 2014 14:13:20 GMT
Message-ID: <1415110434.23396.29.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ben Shelton <ben.shelton@ni.com>
Date: Tue, 04 Nov 2014 14:13:54 +0000
In-Reply-To: <20141103154726.GA9716@bshelton-desktop>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
	<20141103154726.GA9716@bshelton-desktop>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 04 Nov 2014 14:14:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-11-03 at 09:47 -0600, Ben Shelton wrote:
> On 11/02, Burton, Ross wrote:
> > On 27 October 2014 17:27, Ben Shelton <ben.shelton@ni.com> wrote:
> > 
> > > In the commit 'prserv: Ensure data is committed', the PR server moved to
> > > only committing transactions to the database when the PR server is
> > > stopped.  This improves performance, but it means that if the machine
> > > running the PR server loses power unexpectedly or if the PR server
> > > process gets SIGKILL, the uncommitted package revision data is lost.
> > >
> > > To fix this issue, sync the database periodically, once per 30 seconds
> > > by default, if it has been marked as dirty.  To be safe, continue to
> > > sync the database at exit regardless of its status.
> > >
> > 
> > This appears to be causing random problems for me where bitbake will
> > timeout attempting to access the PR database, my hunch is that it's
> > blocking on disk I/O.  Are there any tricks we can do with sqlite to reduce
> > the overhead of committing? (assuming that sqlite isn't causing a full
> > filesystem sync).
> > 
> > Ross
> 
> After running a few large nightly builds, we've seen some issues with
> this as well.  It looks like the issue is in the PR server itself, which
> logs this error:
> 
> "OperationalError: cannot start a transaction within a transaction"
> 
> However, I'm confused as to why this is happening, since the only place
> new transactions are being created is in the sync() function ("BEGIN
> EXCLUSIVE TRANSACTION"), and AFAIK that's only called by a single
> thread.  Any ideas?

I just posted a patch for this. Any SQL transaction will start a new one
if one wasn't already in progress. This was therefore a race between two
threads. Whether it fixes all the problems remains to be seen, WAL mode
may still be a good idea as it does perform better for our use case.

Cheers,

Richard


