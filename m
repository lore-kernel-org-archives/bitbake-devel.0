Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 612DF60589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 20:29:56 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jul 2016 13:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,390,1464678000"; d="scan'208";a="142102786"
Received: from steng1-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.150.251])
	by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2016 13:29:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 20 Jul 2016 08:29:52 +1200
Message-ID: <2475257.7Bltr6I3so@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <f4f9f0d1-9827-b239-5458-328a947af066@windriver.com>
References: <578DC9D2.1060607@mlbassoc.com>
	<CAJTo0LaXhGF3eFt=tfRBHfU56kf_nheBrV8Sshsxrpq+fGn7cA@mail.gmail.com>
	<f4f9f0d1-9827-b239-5458-328a947af066@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Gary Thomas <gary@mlbassoc.com>
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
X-List-Received-Date: Tue, 19 Jul 2016 20:30:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 19 Jul 2016 12:06:46 Mark Hatle wrote:
> On 7/19/16 11:45 AM, Burton, Ross wrote:
> > On 19 July 2016 at 10:21, Gary Thomas <gary@mlbassoc.com
> > 
> > <mailto:gary@mlbassoc.com>> wrote:
> >     Thanks.  I was mostly asking to see what the expected "user
> >     experience"
> >     should be since the webkitgtk (which takes FOREVER to build) seemed a
> >     bit misleading/optimistic.  For the most part, I do like the
> >     additional
> >     information.
> > 
> > The situation here is that cmake counts the steps and announces its
> > progress through them as the progress.  Of course the last step is to
> > link about 8GB of binaries...
> > 
> > A progress bar is better than no progress bar, so I still call this an
> > improvement :)
> 
> We have (had, python 3 broke it) a patch to knotty that permits the logs to
> be presented on the screen during a build so for places where you think it
> might have hung you can at least get some status.
> 
> I like the idea of a progress bar.. but we need to weigh the 'it looks like
> it froze' vs 'make sure people know things are still moving'.
> 
> in the GUI world this is the old hour glass/spinning cursor/rotating
> progress bar -- vs a progress meter behavior..

We can certainly do something like that - the progress handler sees all output 
even if it doesn't contain anything interesting to it (e.g. % complete). The 
trouble comes when the process prints out nothing - such as when linking a 
very large binary. I'm not sure how you would introspect into that part of the 
process.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

