Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id ECE716B3CB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2013 09:15:06 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2013 02:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,800,1367996400"; d="scan'208";a="380574861"
Received: from unknown (HELO helios.localnet) ([10.252.122.201])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2013 02:15:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Benix Vincent <benixvincent@yahoo.com>
Date: Fri, 02 Aug 2013 10:15:06 +0100
Message-ID: <1435362.7ku5pyYbEP@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-27-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1375433362.36500.YahooMailNeo@web162601.mail.bf1.yahoo.com>
References: <1375433362.36500.YahooMailNeo@web162601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Any resource to start learning bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Aug 2013 09:15:07 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 02 August 2013 01:49:22 Benix Vincent wrote:
> I am a newbie to OE bitbake, any good reference to start with?

Probably your best reference for using BitBake within the OE context (at 
least, modern OE-Core as opposed to OE-Classic) is the Yocto Project 
documentation:

https://www.yoctoproject.org/documentation/current

There is also a bitbake manual that covers pure BitBake usage, which is in the 
process of being updated. You can build the current version within the bitbake 
source tree by running "make html" under doc/manual/.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

