Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7178F60886
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 08:15:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 06 Aug 2013 01:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,825,1367996400"; d="scan'208";a="358239252"
Received: from unknown (HELO helios.localnet) ([10.252.122.203])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2013 01:15:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Benix Vincent <benixvincent@yahoo.com>
Date: Tue, 06 Aug 2013 09:15:14 +0100
Message-ID: <7281862.jtv4mAibim@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-27-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1375766435.51103.YahooMailNeo@web162604.mail.bf1.yahoo.com>
References: <1375764715.11349.YahooMailNeo@web162605.mail.bf1.yahoo.com>
	<ADEA8F38-F1BB-427C-8864-440A2B8FA6C7@gmail.com>
	<1375766435.51103.YahooMailNeo@web162604.mail.bf1.yahoo.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Multiple init script in bitbake file
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
X-List-Received-Date: Tue, 06 Aug 2013 08:15:16 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 05 August 2013 22:20:35 Benix Vincent wrote:
> NO diag1 & diag2 aren't part of package variables. Hence it didn't work.
> 
> But this is a single package, and has two init scripts. One option is to
> combine these two init scripts. But I am looking if any posssibility 

Unfortunately OE-Core's update-rc.d.bbclass doesn't support multiple 
initscripts in a single package. Other than combining the two scripts, another 
simple way to fix it would be to split out your separate daemons into different 
packages.

BTW, this kind of question belongs on the OE-Core mailing list:

http://lists.openembedded.org/mailman/listinfo/openembedded-core

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

