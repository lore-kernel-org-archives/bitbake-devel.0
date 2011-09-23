Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R789Z-0001MK-2v
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 17:59:05 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Sep 2011 08:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="55152635"
Received: from unknown (HELO helios.localnet) ([10.252.120.136])
	by orsmga001.jf.intel.com with ESMTP; 23 Sep 2011 08:53:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 16:53:41 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1316781566.git.paul.eggleton@linux.intel.com>
	<e93b8449659b02b0abbf5f39b40488e9ba05c142.1316781566.git.paul.eggleton@linux.intel.com>
In-Reply-To: <e93b8449659b02b0abbf5f39b40488e9ba05c142.1316781566.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Message-Id: <201109231653.41279.paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] bitbake/lib/bb/msg.py: fix setting debug and verbosity levels
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
X-List-Received-Date: Fri, 23 Sep 2011 15:59:05 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 23 September 2011 13:43:02 Paul Eggleton wrote:
> The debug and verbosity levels (as set by the -D and -v command line
> options respectively)  were not being passed through within msg.py since
> bitbake revision 45aad2f9647df14bcfa5e755b57e1ddab377939a due to setting
> incorrect variable names.

Seems there are a couple of references to loggerVerbose, so ignore this; I 
will send a v2 shortly.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


