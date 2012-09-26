Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TGoXb-00026Z-La
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 12:08:27 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2012 02:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="213465170"
Received: from unknown (HELO helios.localnet) ([10.252.122.36])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2012 02:55:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 26 Sep 2012 10:55:34 +0100
Message-ID: <9368245.KRBzAsCsF9@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.1 (Linux/3.2.0-31-generic-pae; KDE/4.9.1; i686; ; )
In-Reply-To: <1348569020-1266-1-git-send-email-cristiana.voicu@intel.com>
References: <1348569020-1266-1-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/settings: implement a new tab in settings dialog to show SSTATE_MIRRORS
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
X-List-Received-Date: Wed, 26 Sep 2012 10:08:27 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Tuesday 25 September 2012 13:30:20 Cristiana Voicu wrote:
> Add a new tab to show correctly SSTATE_MIRRORS variable. Now you can add new
> mirrors or delete mirror. "info" image was also changed( it is smaller, so
> it can be next to labels).
> From "Build environment" tab, SSTATE_DIR and SSTATE_MIRRORS vars were
> removed.
> 
> [YOCTO #2893]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>

I just tested this; it works for the basic case, however there are a couple of 
issues with "Custom":

 1) If I select "Custom", set both "Match" and "Replace with", save and then 
re-open the dialog, I see that the mirror entry shows as "Standard" again. I 
think the code should be checking to see if the entry fits into "Standard" form 
and if not then showing it as "Custom".

 2) If I select "Custom" with a path already set, I feel it should adjust the 
path to be the appropriate full version that will still work (i.e. with \1 or 
PATH on the end). That does mean it needs to be able to go back the other way 
and probably show a warning dialog if it can't reverse it cleanly. However 
this fix can wait until 1.4 if there isn't enough time IMO.

There are a couple of other minor visual issues but at this late stage I think 
we can address those in 1.4.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


