Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2A04973179
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jun 2016 10:33:34 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 28 Jun 2016 03:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,541,1459839600"; d="scan'208";a="1006591668"
Received: from rvardha1-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.169.76])
	by orsmga002.jf.intel.com with ESMTP; 28 Jun 2016 03:33:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 28 Jun 2016 22:33:29 +1200
Message-ID: <9718339.9HqyM6s4Q7@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-200.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <CAJTo0Lbfx7mDE1f0Oa3EtAp+-HdYGXJ8AY0T4adDiMKi=fLzzw@mail.gmail.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
	<5e1ed9818cf97c1de778cc25a640d8bc589f4d55.1465786269.git.paul.eggleton@linux.intel.com>
	<CAJTo0Lbfx7mDE1f0Oa3EtAp+-HdYGXJ8AY0T4adDiMKi=fLzzw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 05/10] fetch2: implement progress support
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
X-List-Received-Date: Tue, 28 Jun 2016 10:33:36 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 28 Jun 2016 11:23:32 Burton, Ross wrote:
> On 13 June 2016 at 03:52, Paul Eggleton <paul.eggleton@linux.intel.com>
> 
> wrote:
> > +        runfetchcmd(command + ' --progress=dot --show-progress', d,
> > quiet, log=progresshandler)
> 
> wget: unrecognized option '--show-progress'
> 
> Turns out wget on Ubuntu 14.04 (wget 1.15) doesn't support this option.

Turns out it was introduced in 1.16. Sigh...

I will try to figure out what we can do with this. Worst case I suppose we 
could run wget once to determine the version and just disable progress 
reporting if it's too old.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

