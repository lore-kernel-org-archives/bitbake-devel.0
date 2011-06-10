Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QV18d-0002NB-LE
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jun 2011 14:48:37 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 10 Jun 2011 05:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,347,1304319600"; d="scan'208";a="11990910"
Received: from unknown (HELO helios.localnet) ([10.255.13.133])
	by orsmga002.jf.intel.com with ESMTP; 10 Jun 2011 05:45:12 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2011 13:45:11 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1307693771.git.dexuan.cui@intel.com>
	<6439f6f95ef1157063276692bcf2adfebb7597eb.1307693771.git.dexuan.cui@intel.com>
	<1307708964.15712.210.camel@rex>
In-Reply-To: <1307708964.15712.210.camel@rex>
MIME-Version: 1.0
Message-Id: <201106101345.11050.paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] bitbake-layers: stop the warning "not been run using the bitbake wrapper..."
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
X-List-Received-Date: Fri, 10 Jun 2011 12:48:37 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 10 June 2011 13:29:24 Richard Purdie wrote:
> We can't add implementation specific information to bitbake I'm afraid
> so we'll need to find a different way to handle this...

Perhaps we could just change sanity.bbclass to check argv[0] somehow (or some 
equivalent way to get the current process name) and skip the check if it isn't 
"bitbake"? This would have the added bonus of solving the problem for future 
tools that use bitbake code in a similar way to bitbake-layers.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


