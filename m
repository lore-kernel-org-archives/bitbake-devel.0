Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 74F5860589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 21:12:05 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 19 Jul 2016 14:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,391,1464678000"; d="scan'208";a="736836633"
Received: from steng1-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.150.251])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2016 14:12:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>
Date: Wed, 20 Jul 2016 09:12:01 +1200
Message-ID: <4536096.E32OAZCnSo@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <D3B3B3B3.81640%belen.barros.pena@intel.com>
References: <578DC9D2.1060607@mlbassoc.com>
	<9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
	<D3B3B3B3.81640%belen.barros.pena@intel.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Gary Thomas <gary@mlbassoc.com>
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
X-List-Received-Date: Tue, 19 Jul 2016 21:12:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 19 Jul 2016 09:43:16 Barros Pena, Belen wrote:
> On 19/07/2016 10:16, "bitbake-devel-bounces@lists.openembedded.org on
> behalf of Paul Eggleton" <bitbake-devel-bounces@lists.openembedded.org on
> 
> behalf of paul.eggleton@linux.intel.com> wrote:
> >Hi Gary,
> >
> >On Tue, 19 Jul 2016 08:33:54 Gary Thomas wrote:
> >> I quite like the new progress meters, but they seem to not be very
> >> accurate.  I was just rebuilding webkitgtk and got this:
> >> 
> >> 0: webkitgtk-2.12.3-r0 do_compile (pid 30494)  96%
> >> 
> >> |#######################################  | ETA:  0:02:58
> >> 
> >> Sadly, it sat there, waffling between 02:58 and 03:44 for about
> >> 10 minutes...
> >> 
> >> * How is this [estimate] calculated?
> >> * Should I be concerned when it's not accurate (or even moving)?
> >
> >There are a few different types of progress handling for different types
> >of tasks. To be specific in this example, for recipes that inherit cmake
> >during do_compile we report the progress that the cmake-produced makefile
> >prints out. The ETA, which is implemented in the python-progressbar code we
> >are using is kind of a rolling average calculated based on recent progress,
> >so it's possible it's inaccurate in this instance if there are places where
> >it stalls. Python-progressbar has an alternative ETA mode which we could
> >try, but to be honest when the progress value sent to it isn't evenly
> >apportioned with respect to time and we don't have any weighting
> >information, there's not a lot anyone can do to estimate time remaining
> >accurately. If it's truly bothersome we could just turn off the ETA display
> >I suppose.
> 
> Big caveat: this is just my opinion. Displaying information we are not
> sure is accurate is probably not a good idea: it disconcerts people,
> creates false expectations and ultimately undermines trust on the system.
> 
> If you are not sure the ETA is reliable, I would remove it.
> 
> Just my 2c.

Right, I see your point - the entire reason I added this was to give the user 
some reassurance about the progress and if it's misleading then it does the 
opposite. I think I will just remove it.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

