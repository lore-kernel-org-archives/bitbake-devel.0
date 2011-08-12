Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruZD-0008Mr-2k
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:26:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Aug 2011 09:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="37228251"
Received: from unknown (HELO helios.localnet) ([10.255.18.64])
	by orsmga002.jf.intel.com with ESMTP; 12 Aug 2011 09:21:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:20:59 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
	<e59f678e8c65fb21e4b54eb72b0327f448cd789d.1313165343.git.paul.eggleton@linux.intel.com>
In-Reply-To: <e59f678e8c65fb21e4b54eb72b0327f448cd789d.1313165343.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Message-Id: <201108121720.59619.paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 3/4] bitbake-layers: use logger.plain instead of info
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
X-List-Received-Date: Fri, 12 Aug 2011 16:26:39 -0000
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 12 August 2011 17:13:58 Paul Eggleton wrote:
> +    # Set up logging
> +    console = logging.StreamHandler(sys.stdout)
> +    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")

Forgot to mention in the cover: when Richard's logging changes get merged this 
code will need the additional "bb.msg.addDefaultlogFilter(console)" line added 
as well.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


