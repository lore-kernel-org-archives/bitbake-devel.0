Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rBd-00039A-T4
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:35:50 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112978754"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:27:19 -0800
Message-ID: <4F4E9837.7080602@linux.intel.com>
Date: Wed, 29 Feb 2012 13:27:19 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: Shane Wang <shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
Cc: Liming An <limingx.l.an@intel.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Wed, 29 Feb 2012 21:35:50 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/02/12 06:11, Shane Wang wrote:
> The following patches are going to fix the following problems:
>
> * Enable HobNotebook to make notebook more like the design video;
> * Improve and enhance the GUI;
> * Rebase the patches Josh has sent out before with the title "Hob tweaks";
> * Address some tricky issues we found in the bitbake;
> * Revise Hob according to the comments on the previous patch set;
> * Fix some bugs we found when testing Hob;
> * and some temporary walkarounds we have to find a way to solve in Hob or in the bitbake later.
>
> The following changes since commit 927bec5f72230be4f2452d9ef5a747b2c00cb781:
>
>    bitbake.conf: Create a new filter variable BB_HASHCONFIG_WHITELIST (2012-02-27 20:10:41 +0000)

This is a pretty decent series. I'd appreciate smaller ones in future as 
they're easier to review.

I've tried to comment on each patch with SOB's for the ones that I'm OK 
with and comments for the rest.

One thing I did notice whilst reviewing this series is that there's a 
lot of this anti-pattern in the hob 2 code:
	for i in range(len(mylist)):
rather than:
	for item in list:

Can we make an effort to tidy those up?

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


