Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A0B12731A3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jun 2016 21:50:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jun 2016 14:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,477,1459839600"; d="scan'208";a="719704774"
Received: from ctan86-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.217])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2016 14:49:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 16 Jun 2016 09:49:52 +1200
Message-ID: <1816755.NLEoNl8zbq@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.6-200.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <1466027201.13979.240.camel@linuxfoundation.org>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
	<1951483.CXMg640ZQm@peggleto-mobl.ger.corp.intel.com>
	<1466027201.13979.240.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 10/10] runqueue: report progress for "Preparing RunQueue" step
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
X-List-Received-Date: Wed, 15 Jun 2016 21:50:01 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wed, 15 Jun 2016 22:46:41 Richard Purdie wrote:
> On Tue, 2016-06-14 at 00:16 +1200, Paul Eggleton wrote:
> > On Mon, 13 Jun 2016 12:09:33 Richard Purdie wrote:
> > > On Mon, 2016-06-13 at 14:52 +1200, Paul Eggleton wrote:
> > > > @@ -1119,14 +1150,19 @@ class RunQueue:
> > > >          if self.state is runQueuePrepare:
> > > >              self.rqexe = RunQueueExecuteDummy(self)
> > > > 
> > > > +            self.rqdata.init_progress_reporter =
> > > > bb.progress.MultiStageProcessProgressReporter(self.cooker.data, +
> > > > 
> > > >                                                    "Initialising
> > > > 
> > > > tasks",
> > > > +                                                            [27,
> > > > 870, 3,
> > > > 33, 1, 3, 3, 2, 3, 6, 1, 13, 1, 1, 132, 32, 1, 61, 1, 13, 2, 243,
> > > > 151,
> > > > 299, 81, 1, 15, 72])>
> > > > 
> > > >              if self.rqdata.prepare() == 0:
> > > >                  self.state = runQueueComplete
> > > >              
> > > >              else:
> > > >                  self.state = runQueueSceneInit
> > > > 
> > > > +                self.rqdata.init_progress_reporter.next_stage()
> > > 
> > > I appreciate the difficulty in figuring some of this out and the
> > > changes look quite neat on the most part. I am however very worried
> > > by
> > > the above from a code maintenance standpoint.
> > > 
> > > If for example I add or remove a step in runqueue, how do I know
> > > where
> > > in this array to make a change? How do I calculate what the new
> > > weighting should be?
> > 
> > Actually with the current patchset it's pretty easy. Just temporarily
> > specify
> > debug=True to the reporter when constructing and it will print out
> > the list of
> > weightings (based on timing each stage) when finish() is called,
> > along with a
> > map of the weightings to the lines where next_stage() was called.
> > (Perhaps if
> > we'd want a comment to that effect for anyone editing this code.)
> 
> I think a comment in there about this would be helpful as it isn't
> clear how to handle this. 

OK, I'll add one - I need to rebase this patchset anyway.

> What does it do in the case you have a next()
> call without a weight? Will that give a warning?

It will yes.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

