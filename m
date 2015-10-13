Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2EC1F7701C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Oct 2015 08:33:27 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 13 Oct 2015 01:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,677,1437462000"; d="scan'208";a="663242955"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 13 Oct 2015 01:33:28 -0700
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 9C5F16A4083;
	Tue, 13 Oct 2015 01:32:28 -0700 (PDT)
Date: Tue, 13 Oct 2015 11:33:22 +0300
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20151013083322.GA15680@linux.intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
	<04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
	<1444537330.14364.5.camel@linuxfoundation.org>
	<20151011200231.GA25841@linux.intel.com>
	<1444625699.29375.12.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1444625699.29375.12.camel@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org, "Bartosh,
	Eduard" <eduard.bartosh@intel.com>
Subject: Re: [PATCH 1/6] event: add new property to BuildBase class
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: ed.bartosh@linux.intel.com
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 13 Oct 2015 08:33:28 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 05:54:59AM +0100, Richard Purdie wrote:
> On Sun, 2015-10-11 at 23:02 +0300, Ed Bartosh wrote:
> > On Sun, Oct 11, 2015 at 05:22:10AM +0100, Richard Purdie wrote:
> > > On Mon, 2015-10-05 at 10:43 +0100, Elliot Smith wrote:
> > > > From: Ed Bartosh <ed.bartosh@linux.intel.com>
> > > > 
> > > > Added 'task' property to the base class of BuildStarted and
> > > > BuildCompleted classes to store bitbake task if it's specified.
> > > > 
> > > > This is done as without task Build* events can't fully represent
> > > > bitbake build. Task information is needed by UI classes to properly
> > > > show or process Build* events.
> > > 
> > > This doesn't make sense I'm afraid. There is no one "task" which a build
> > > start/complete event can correspond to. Consider something like:
> > > 
> > > "bitbake A:do_fetch B:do_rootfs"
> > > 
> > > There would be one BuildStarted event but task doesn't have a singular
> > > value. We therefore don't want to add task information to these events
> > > as it will ultimately mislead anything building on top of this
> > > information.
> > > 
> > > I appreciate there is the -c option, but that just means "if there is no
> > > specific task specified, use this", i.e. its a default.
> > >
> > 
> > OK. can we call it 'default_task' then?
> > You spotted it's purpose right - it's done to represent the task
> > specified by -c option.
> 
> That would certainly be better. I am a little worried how this would be
> used in the UI though. Can you explain where and why the UI needs this
> piece of information?

After looking at UI code I think I can implement this functionality
differently. Thank you for pointing out to this.

Please merge patches 5 and 6 from this patchset. They're not directly
related to 'task' property and can be merged independently.

--
Regards,
Ed

