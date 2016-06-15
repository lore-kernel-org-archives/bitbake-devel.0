Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B0679601A5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jun 2016 21:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5FLkYXw016421; Wed, 15 Jun 2016 22:46:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EEgMdRLNSg2z; Wed, 15 Jun 2016 22:46:46 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5FLkfu6016439
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Jun 2016 22:46:42 +0100
Message-ID: <1466027201.13979.240.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 15 Jun 2016 22:46:41 +0100
In-Reply-To: <1951483.CXMg640ZQm@peggleto-mobl.ger.corp.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
	<ea0b3c1b34818a2eb5f0beb998a4c4e63f334b19.1465786269.git.paul.eggleton@linux.intel.com>
	<1465816173.13979.204.camel@linuxfoundation.org>
	<1951483.CXMg640ZQm@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
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
X-List-Received-Date: Wed, 15 Jun 2016 21:46:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-06-14 at 00:16 +1200, Paul Eggleton wrote:
> On Mon, 13 Jun 2016 12:09:33 Richard Purdie wrote:
> > On Mon, 2016-06-13 at 14:52 +1200, Paul Eggleton wrote:
> > > @@ -1119,14 +1150,19 @@ class RunQueue:
> > >          if self.state is runQueuePrepare:
> > >              self.rqexe = RunQueueExecuteDummy(self)
> > > 
> > > +            self.rqdata.init_progress_reporter =
> > > bb.progress.MultiStageProcessProgressReporter(self.cooker.data, +
> > >         
> > >                                                    "Initialising
> > > tasks",
> > > +                                                            [27,
> > > 870, 3,
> > > 33, 1, 3, 3, 2, 3, 6, 1, 13, 1, 1, 132, 32, 1, 61, 1, 13, 2, 243,
> > > 151,
> > > 299, 81, 1, 15, 72])> 
> > >              if self.rqdata.prepare() == 0:
> > >                  self.state = runQueueComplete
> > >              
> > >              else:
> > >                  self.state = runQueueSceneInit
> > > 
> > > +                self.rqdata.init_progress_reporter.next_stage()
> > 
> > I appreciate the difficulty in figuring some of this out and the
> > changes look quite neat on the most part. I am however very worried
> > by
> > the above from a code maintenance standpoint.
> > 
> > If for example I add or remove a step in runqueue, how do I know
> > where
> > in this array to make a change? How do I calculate what the new
> > weighting should be?
> 
> Actually with the current patchset it's pretty easy. Just temporarily
> specify 
> debug=True to the reporter when constructing and it will print out
> the list of 
> weightings (based on timing each stage) when finish() is called,
> along with a 
> map of the weightings to the lines where next_stage() was called.
> (Perhaps if 
> we'd want a comment to that effect for anyone editing this code.)

I think a comment in there about this would be helpful as it isn't
clear how to handle this. What does it do in the case you have a next()
call without a weight? Will that give a warning?

Cheers,

Richard

