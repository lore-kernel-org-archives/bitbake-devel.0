Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SzqOE-0007Om-SZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 16:40:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 10 Aug 2012 07:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,745,1336374000"; d="scan'208";a="184318254"
Received: from unknown (HELO helios.localnet) ([10.252.121.78])
	by orsmga002.jf.intel.com with ESMTP; 10 Aug 2012 07:28:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 10 Aug 2012 15:28:45 +0100
Message-ID: <9608773.T2XBm9ArBe@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-27-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <cover.1344569166.git.liezhi.yang@windriver.com>
References: <cover.1344569166.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1 V2] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 10 Aug 2012 14:40:39 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 10 August 2012 11:47:38 Robert Yang wrote:
> Changes of V2:
> 
> * Fix a typo fn -> 'fn'
> 
> * Use "bitbake -e" rather than "bitbake -e recipe" to get the BB_STAMPS_DIR
> 
> * Use "BB_STAMPS_DIR=<path> bitbake -S recipe" to regenerate the stamps
> 
> * Change the summary format a little, now it looks like:
>   - (without -v):
>     === Summary: (3653 changed, 1927 unchanged)
>     Newly added: 807
>     PV changed: 48
>     PR changed: 276
>     Depends changed: 2522
> 
>   - (with -v):
>     === Summary: (3653 changed, 1927 unchanged)
>     Newly added: 807
>     Depends changed: 2846
> 
> // Robert
> 
> The following changes since commit 2dec760b79bb7e2e79c33c5127fa64685bd86a18:
> 
>   foomatic: fix perl path for target (2012-08-08 10:06:00 +0100)

So leaving Chris's objections aside for a moment, I applied this and the 
BB_STAMPS_DIR change, and ran the script on my build directory which is out of 
date with respect to the metadata (i.e. metadata has been updated since the 
last build). The output seems to suggest that no changes have been made, which 
is not the case:

----------- snip -----------
$ bitbake-whatchanged core-image-minimal
Figuring out the BB_STAMPS_DIR ...
Generating the new stamps ... (need several minutes)

=== Summary: (0 changed, 0 unchanged)
Newly added: 0
PV changed: 0
PR changed: 0
Depends changed: 0
----------- snip -----------

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


