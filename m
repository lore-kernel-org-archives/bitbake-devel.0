Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAlbB-0004XS-7H
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 18:14:53 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 22 Mar 2012 10:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123943941"
Received: from unknown (HELO [10.7.198.147]) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 10:05:57 -0700
Message-ID: <4F6B5BF4.8040501@linux.intel.com>
Date: Thu, 22 Mar 2012 10:05:56 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AF612C@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AF612C@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/10] Hob GUI tweaks v2
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
X-List-Received-Date: Thu, 22 Mar 2012 17:14:53 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/03/12 01:39, Wang, Shane wrote:
> 05, I think we need more work, the label on the button is blue. I hope we can make the labels colorful to highlight there is a button for click. Again, for "Back to XXX", the design is "<<  Back to XXX". But I can ACK to check in the patch first, and leave the work for future.

Agreed, I mentioned the need to create a follow-on patch for the colour 
in the pull message. I'll work on that today.
I see the design also includes the << on Back buttons, I'll include a 
patch to re-add those in today's series - apologies for missing that.

> 07, the machine combo box vertically is not in the middle of "layers" button, and it removes the hover function, that is when the mouse is over the button, the icon will be changed. Initially we implemented that in this way, however it didn't look good. So, we used our specific solution. What the designer expects is it becomes a button. That could be implemented.

Right you are, I'd missed that on the design also. I'll fix this and 
ensure the use of the hover state in a follow on patch.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


