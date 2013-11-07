Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 36DD86D2FB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 16:25:17 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 07 Nov 2013 08:25:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="318310518"
Received: from unknown (HELO helios.localnet) ([10.252.121.102])
	by AZSMGA002.ch.intel.com with ESMTP; 07 Nov 2013 08:25:11 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Gary Thomas <gary@mlbassoc.com>
Date: Thu, 07 Nov 2013 16:25:10 +0000
Message-ID: <7286154.LbYKCCWHqH@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-31-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <527BAC0F.3090901@mlbassoc.com>
References: <527BAC0F.3090901@mlbassoc.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Ross Burton <ross.burton@intel.com>
Subject: Re: Some 'depexp' nits
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
X-List-Received-Date: Thu, 07 Nov 2013 16:25:17 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Gary,

On Thursday 07 November 2013 08:04:47 Gary Thomas wrote:
> I hope this is the correct list.
> 
> I was just using '-u depexp' and noticed a few small things.
>    $ bitbake my-qt5-image -u depexp
>    This UI is only compatible with the -g option
> 
> Perhaps this should be worded more strongly, like this?
>    This UI requires the -g option

Sounds like a good idea yes.

> Also, after running successfully, I closed the window (using
> the close WM button) and got this:
>    $ bitbake my-qt5-image -u depexp -g
>    Unable to cleanly stop: No such command
> 
> There didn't seem to be any other way to exit the program, so
> at least this should be clean.

There is now a bug open for the latter issue:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=5445

> Are these valid concerns/observations?  Would you entertain patches
> for these items?

Yes, that would be great.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

