Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 140CC60761
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Mar 2016 22:08:04 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 21 Mar 2016 15:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,374,1455004800"; d="scan'208";a="768578614"
Received: from ngocthuy-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.169.222])
	by orsmga003.jf.intel.com with ESMTP; 21 Mar 2016 15:08:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Gary Thomas <gary@mlbassoc.com>
Date: Tue, 22 Mar 2016 11:08:01 +1300
Message-ID: <5861476.KL7KapCN76@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.4.5-300.fc23.x86_64; KDE/4.14.18; x86_64; ;
	)
In-Reply-To: <56EA7B5F.9030700@mlbassoc.com>
References: <56EA7B5F.9030700@mlbassoc.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake hang
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
X-List-Received-Date: Mon, 21 Mar 2016 22:08:07 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thu, 17 Mar 2016 10:39:43 Gary Thomas wrote:
> Typing ^C very early on causes a complete hang:
> 
> $ bitbake some-image
> NOTE: Started PRServer with DBfile:
> /local/p7619_2016-02-23/cache/prserv.sqlite3, IP: 127.0.0.1, PORT: 43616,
> PID: 14386 Parsing recipes:  11% |###########
> 
>          | ETA:  00:00:21
> 
> Keyboard Interrupt, closing down...
> 
> WARNING: Timeout while attempting to communicate with bitbake server
> WARNING: Timeout while attempting to communicate with bitbake server
> WARNING: Timeout while attempting to communicate with bitbake server
> WARNING: Timeout while attempting to communicate with bitbake server
> ERROR: Gave up; Too many tries: timeout while attempting to communicate with
> bitbake server
> 
> Tested using poky:8debfea81e69d038bd2d56314b272cb74f5582ed
> 
> Should I file a bug?

Yes please.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

