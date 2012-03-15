Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S8JOu-0006of-Tg
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 23:44:05 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 15:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121450137"
Received: from unknown (HELO [10.255.15.198]) ([10.255.15.198])
	by orsmga002.jf.intel.com with ESMTP; 15 Mar 2012 15:35:16 -0700
Message-ID: <4F626EA4.1050200@linux.intel.com>
Date: Thu, 15 Mar 2012 15:35:16 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<42a098d7aa3f119f3f6735be07da727591ef8118.1331716896.git.dongxiao.xu@intel.com>
	<4F60F395.9080502@linux.intel.com>
	<1331800315.1855.25.camel@dongxiao-osel>
In-Reply-To: <1331800315.1855.25.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 02/11] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Thu, 15 Mar 2012 22:44:05 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/03/12 01:31, Xu, Dongxiao wrote:
> On Wed, 2012-03-14 at 12:37 -0700, Joshua Lock wrote:
>>
>> On 14/03/12 02:26, Dongxiao Xu wrote:
>>> Currently for non-x86 architecture, there are un-resolved dependency
>>> issue when generate universe dependency tree. Therefore disable the
>>> handling of "NoProvider" event in Hob to enable the build for non-x86
>>> architectures. After we resolved the dependency for universe, we still
>>> need to handle this event in Hob.
>>
>> I'm not sure we'll ever be able to strongly guarantee that NoProvider
>> issues won't creep in. Would we better off coming up with a more tenable
>> long term solution?
>
> The current code is a strict check for NoProvider issue. Do you have any
> suggestion on this one? What about putting the NoProvider error in
> building time?

The ideal, from a user perspective, would I think be that any NoProvider 
recipes just aren't included in the list of available recipes/packages.

Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


