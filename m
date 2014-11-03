Return-Path: <ben.shelton@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id F29266E63E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:47:32 +0000 (UTC)
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id
	sA3FlV7l025728; Mon, 3 Nov 2014 09:47:32 -0600
Received: from localhost ([130.164.14.198])
	by us-aus-mgwout2.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014110309473138-591806 ;
	Mon, 3 Nov 2014 09:47:31 -0600 
Date: Mon, 3 Nov 2014 09:47:26 -0600
From: Ben Shelton <ben.shelton@ni.com>
To: "Burton, Ross" <ross.burton@intel.com>
Message-ID: <20141103154726.GA9716@bshelton-desktop>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 11/03/2014 09:47:31 AM,
	Serialize by Router on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 11/03/2014 09:47:32 AM,
	Serialize complete at 11/03/2014 09:47:32 AM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52, 1.0.28,
	0.0.0000
	definitions=2014-11-03_02:2014-11-03, 2014-11-03,
	1970-01-01 signatures=0
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
X-List-Received-Date: Mon, 03 Nov 2014 15:47:42 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/02, Burton, Ross wrote:
> On 27 October 2014 17:27, Ben Shelton <ben.shelton@ni.com> wrote:
> 
> > In the commit 'prserv: Ensure data is committed', the PR server moved to
> > only committing transactions to the database when the PR server is
> > stopped.  This improves performance, but it means that if the machine
> > running the PR server loses power unexpectedly or if the PR server
> > process gets SIGKILL, the uncommitted package revision data is lost.
> >
> > To fix this issue, sync the database periodically, once per 30 seconds
> > by default, if it has been marked as dirty.  To be safe, continue to
> > sync the database at exit regardless of its status.
> >
> 
> This appears to be causing random problems for me where bitbake will
> timeout attempting to access the PR database, my hunch is that it's
> blocking on disk I/O.  Are there any tricks we can do with sqlite to reduce
> the overhead of committing? (assuming that sqlite isn't causing a full
> filesystem sync).
> 
> Ross

After running a few large nightly builds, we've seen some issues with
this as well.  It looks like the issue is in the PR server itself, which
logs this error:

"OperationalError: cannot start a transaction within a transaction"

However, I'm confused as to why this is happening, since the only place
new transactions are being created is in the sync() function ("BEGIN
EXCLUSIVE TRANSACTION"), and AFAIK that's only called by a single
thread.  Any ideas?

Would it make sense to revert the patch until we identify/fix the issue?

Ben

