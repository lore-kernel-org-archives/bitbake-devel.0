Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9704660589
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 04:09:37 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Feb 2017 20:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,349,1484035200"; d="scan'208";a="1124074397"
Received: from ystew-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.191.171])
	by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2017 20:09:27 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 09 Feb 2017 17:09:20 +1300
Message-ID: <2583370.YQW5y1mmkv@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/5.3.3 (Linux/4.9.7-201.fc25.x86_64; KDE/5.29.0; x86_64; ; )
In-Reply-To: <20170209011411.GA26866@linux-uys3>
References: <578DC9D2.1060607@mlbassoc.com>
	<2475257.7Bltr6I3so@peggleto-mobl.ger.corp.intel.com>
	<20170209011411.GA26866@linux-uys3>
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: New progress meters
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
X-List-Received-Date: Thu, 09 Feb 2017 04:09:38 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 8 February 2017 8:14:11 PM NZDT Trevor Woerner wrote:
> On Wed 2016-07-20 @ 08:29:52 AM, Paul Eggleton wrote:
>        ^^^^^^^^^^
> ... talk about showing up late to the party! ;-)

It's never too late :)

> > We can certainly do something like that - the progress handler sees all
> > output even if it doesn't contain anything interesting to it (e.g. %
> > complete). The trouble comes when the process prints out nothing - such
> > as when linking a very large binary. I'm not sure how you would
> > introspect into that part of the process.
> 
> Would it be possible to show progress such that once a recipe started to be
> processed, it would remain in view until it was done (preferably in the same
> relative location)?
> 
> Let's say you have a recipe abc.bb whose tasks are: fetch, unpack, patch,
> configure, compile, deploy, package. I think it might be nice if, once
> bitbake started processing abc, we saw something like:
> 
> 
> 	before-4.5.6 ...
> 	abc-1.2.3 do_fetch ===>
> 	after-0.9.8 ...
> 
> Then when the fetch was done we'd see
> 
> 	before-4.5.6 ...
> 	abc-1.2.3 do_unpack ===|==>
> 	after-0.9.8 ...
> 
> then
> 
> 	before-4.5.6 ...
> 	abc-1.2.3 do_patch ===|===|=>
> 	after-0.9.8 ...
> 
> 
> Or, maybe:
> 
> 	before-4.5.6 ...
> 	abc-1.2.3  =fetch=
> 	after-0.9.8 ...
> 
> 	before-4.5.6 ...
> 	abc-1.2.3  =fetch=|=unpack=
> 	after-0.9.8 ...
> 
> 	before-4.5.6 ...
> 	abc-1.2.3  =fetch=|=unpack=|=patch=
> 	after-0.9.8 ...
> 
> Maybe the different tasks could have their own colours? Perhaps the equals
> signs could be used to show progress: as a task progresses more equals signs
> would be printed, then the pipe drawn and the new task drawing started when
> the next task begins? At the end of processing abc we might see something
> like:
> 
> 	abc-1.2.3
> =fetch===========|=unpack=|=patch=|=configure====|=compile=================
> ==========================|=deploy===|=package==
> 
> which tells us that fetching and compiling were this recipe's largest jobs.
> 
> I guess the largest problem would be handling the vertical real-estate. With
> hundreds of packages, the output would scroll off rather quickly. Maybe
> once a recipe was complete it could drop off?

So this is an interesting idea. The challenge though as I mentioned in my 
previous email is about knowing how long the task is going to take - right now 
we only have this for a few tasks. In this case you would use that to scale 
the bar for each task with respect to the screen width - if you don't have 
this scaling then either horizontal real-estate is going to be an additional 
problem, or there won't be any ability to compare the task times (at least 
within the same recipe - this would prevent comparing between recipes).

Whilst we could get an approximation of total task time if we know how long 
the log file is expected to be, I still haven't figured out a good way of 
having even that information available before the build, though I have to 
admit I haven't spent much time thinking about it since the changes went in.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

