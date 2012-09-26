Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TGmXK-0007Xa-V2
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 10:00:03 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2012 00:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="213352636"
Received: from costin-desktop (HELO [10.237.105.66]) ([10.237.105.66])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2012 00:46:04 -0700
Message-ID: <5062A5F7.7000003@intel.com>
Date: Wed, 26 Sep 2012 09:51:35 +0300
From: Constantin Musca <constantinx.musca@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To: Constantin Musca <constantinx.musca@intel.com>
References: <1348642178-27405-1-git-send-email-constantinx.musca@intel.com>
In-Reply-To: <1348642178-27405-1-git-send-email-constantinx.musca@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] *** bblayers.conf should be updated automatically
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
X-List-Received-Date: Wed, 26 Sep 2012 08:00:03 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/26/2012 09:49 AM, Constantin Musca wrote:
> To keep things simple for this release, Paul proposed to put the bblayers.conf
> merging code in sanity.bbclass. After upgrading bblayers.conf we tell the
> user to re-run. It would be better if we could re-read the configuration but that
> is something we can address in 1.4. Every layer should make its specific bblayers.conf
> updates by appending to the check_bblayers_conf bitbake function. We decided that this
> is the right thing to do because we don't want to be invasive. This represents the meta
> merging functionality and does only the bblayers.conf v4 -> v5 update. The v5 -> v6
> bblayers.conf update is done in another patch sent to poky@yoctoproject.org.
>
> Constantin Musca (1):
>    sanity.bbclass: bblayers.conf should be updated automatically
>
>   meta/classes/sanity.bbclass |   56 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>
Sorry. Wrong mail list.

Constantin


