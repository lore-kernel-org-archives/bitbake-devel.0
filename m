Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5B7C96AC00
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Mar 2016 01:47:24 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 20 Mar 2016 18:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,368,1455004800"; d="scan'208";a="938041461"
Received: from edeshpan-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.136.133])
	by orsmga002.jf.intel.com with ESMTP; 20 Mar 2016 18:47:23 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Zhou, Luwei" <luwei.zhou@intel.com>
Date: Mon, 21 Mar 2016 14:47:21 +1300
Message-ID: <2409005.uOzAKMEWXG@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.4.4-301.fc23.x86_64; KDE/4.14.17; x86_64; ;
	)
In-Reply-To: <46BA6A9193234D4CB7051E63F3A63ED52DF9AE@shsmsx102.ccr.corp.intel.com>
References: <46BA6A9193234D4CB7051E63F3A63ED52DF9AE@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake fetching fails on git repo but can manually git clone
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
X-List-Received-Date: Mon, 21 Mar 2016 01:47:25 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Luwei,

On Fri, 18 Mar 2016 08:32:04 Zhou, Luwei wrote:
> I am new to yocto and hope the mail list is the right place to ask.
> 
> I am using jethro 2.0 to build my yocto system. I have met some weird issue
> when bitbake fetching source. When I try bitbake image, there would be
> fetching error caused by some components(mraa etc). I have tried enabling
> -D option when running bitbake -D mraa -c fetch to see the log.  I can see
> bitbake will first trying using git clone to fetch the code and failed(with
> a return of warning) and then trying mirror still failed with error.
> However, When I manually run the command  below:
> 
> git -c core.fsyncobjectfiles=0 clone --bare --mirror
> git://github.com/intel-iot-devkit/mraa.git
> /home/luweizho/build/ambr-yocto-build/build/downloads/git2/github.com.intel
> -iot-devkit.mraa.git
> 
> The git clone can be completed. My current setting is below. It is kind of
> weird.  Why git clone can work manually but bitbake fetching would return
> warning and then fail. I have checked the wiki below and didn't find out
> the reason.
> https://wiki.yoctoproject.org/wiki/Working_Behind_a_Network_Proxy

I've just noticed this page is significantly out-of-date and have updated it.
 
> My ~/.bashrc proxy settingis:
> ...

I suspect the reason this is failing is that SOCKS_SERVER isn't being allowed 
through into the environment where the fetcher is running. However, instead of 
fixing that I would suggest using our git proxy script (scripts/oe-git-proxy) 
and setting ALL_PROXY instead of SOCKS_SERVER (the syntax is slightly different 
though, see the updated wiki page or the script file itself for details).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

