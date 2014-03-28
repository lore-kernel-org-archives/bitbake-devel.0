Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 19CCB6B5DD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 14:22:12 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2014 07:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,751,1389772800"; d="scan'208";a="509691592"
Received: from cpcarrag-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.121.42])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2014 07:22:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Fri, 28 Mar 2014 14:22:03 +0000
Message-ID: <2703747.EGqZ9dGWcs@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.3 (Linux/3.13.6-200.fc20.x86_64; KDE/4.12.3; x86_64; ; )
In-Reply-To: <5335718B.3070709@windriver.com>
References: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
	<CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com>
	<5335718B.3070709@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: bitbake memres server should not always reload the cache
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
X-List-Received-Date: Fri, 28 Mar 2014 14:22:13 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 28 March 2014 07:56:43 Jason Wessel wrote:
> On 03/28/2014 06:43 AM, Alex Damian wrote:
> > Please hold merging this change.
> > 
> > I think we need to discuss a bit on this. My expectation is that the
> > Bitbake server will reinit its state between builds, re-parsing the
> > configuration files and reload the cache. I am not sure why we would
> > consider maintaining the hot cache copy in memory between builds.
>
> It is about increasing the interactivity of the system.  There are certainly
> times you need to soft reset, but perhaps that is what we need to expose. 
> If I want to run a dev shell and have done a build, this is something I'd
> like to be instantaneous, or if I am working on the package and want to
> re-run the compile and package steps, there really is no need to parse.
> 
> There is a trade off for the individual package work vs the work of
> rebuilding the entire image.  In the case of the entire image you most
> certainly want the soft reset behavior.

To my mind it depends on the likelihood of something having changed and 
whether that change might affect what you would be doing with the action that 
follows. For example. if you're trying to fix the execution of a particular 
task, you would expect to see any change in the recipe / configuration to take 
effect when re-running the task.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

