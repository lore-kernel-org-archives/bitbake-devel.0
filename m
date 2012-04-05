Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SFpka-00075F-1X
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 18:41:32 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 05 Apr 2012 09:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127525751"
Received: from unknown (HELO helios.localnet) ([10.252.120.33])
	by azsmga001.ch.intel.com with ESMTP; 05 Apr 2012 09:32:18 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 05 Apr 2012 17:32:17 +0100
Message-ID: <21867085.kuhcoOKVOX@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-17-generic-pae; KDE/4.8.1; i686; ; )
In-Reply-To: <72c1e44f0bc8b40583d16ff8b396faf8cf62fed9.1333155656.git.josh@linux.intel.com>
References: <cover.1333155656.git.josh@linux.intel.com>
	<72c1e44f0bc8b40583d16ff8b396faf8cf62fed9.1333155656.git.josh@linux.intel.com>
MIME-Version: 1.0
Cc: Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 1/1] lib/bb/ui/hob: exit cleanly if the required pygtk version isn't available
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
X-List-Received-Date: Thu, 05 Apr 2012 16:41:32 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 30 March 2012 18:05:29 Joshua Lock wrote:
> Hob uses API from pygtk 2.22, therefore check to see whether this
> version is available and exit cleanly if not.

Apparently Belen and Giulia have been doing their hob testing on an F15 
machine (fully up-to-date) and it was working OK, now it is blocked by this 
check - the version of PyGTK+ on there is 2.17.

Is that intended/desirable?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


