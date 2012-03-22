Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAWWN-0007Zh-BS
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 02:08:55 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 18:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="142880475"
Received: from unknown (HELO [10.255.15.222]) ([10.255.15.222])
	by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2012 18:00:00 -0700
Message-ID: <4F6A7990.6060902@linux.intel.com>
Date: Wed, 21 Mar 2012 18:00:00 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
	<76678d0e7b33939ea902c26dd68a1279e293d3d7.1332288516.git.josh@linux.intel.com>
	<1332375865.1849.1.camel@dongxiao-osel>
In-Reply-To: <1332375865.1849.1.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/5] ui/crumbs/hig: make the layer selection dialogue more closely match design
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
X-List-Received-Date: Thu, 22 Mar 2012 01:08:55 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/03/12 17:24, Xu, Dongxiao wrote:
> On Tue, 2012-03-20 at 17:15 -0700, Joshua Lock wrote:
>> The layer dialogue design includes in-line remove/delete widgets next to
>> the layer path in the tree view for all layers other than the meta layer as
>> well as an in-line notice that the meta layer cannot be removed.
>
> Hi Josh,
>
> One thing just came to my mind is that, the meta-hob layer also could
> not be removed since Hob GUI will use that.

Will Hob not work without the Hob layer? If that's the case I guess we 
should disable removal of that also.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


