Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Sd0xK-0004qs-A7
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 17:18:30 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Jun 2012 08:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="154902076"
Received: from unknown (HELO envy.home) ([10.255.12.197])
	by orsmga002.jf.intel.com with ESMTP; 08 Jun 2012 08:06:54 -0700
Message-ID: <4FD214C8.8050705@linux.intel.com>
Date: Fri, 08 Jun 2012 08:05:44 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1338976258.git.kai.kang@windriver.com>
	<1339154065.30460.6.camel@ted>
In-Reply-To: <1339154065.30460.6.camel@ted>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 0/6] V2 hob2: some tweak and add a standalone deploy image tool
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
X-List-Received-Date: Fri, 08 Jun 2012 15:18:30 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/08/2012 04:14 AM, Richard Purdie wrote:
> On Wed, 2012-06-06 at 17:52 +0800, Kang Kai wrote:
>> Hi Darren,
>>
>> Thanks for your detailed reivew.
>>
>> V2 update:
>> 1. break up the commit about hig.py 
>> 2. some text tweak 
>> 3. remove the gtk version check
>> 4. rename the standalone tool
>>
>> V1:
>> These 2 patches try to add a standalone deploy image tool using current codes. 
>> It should be launched by run the absolute path to bitbake/bin/bitbake-deployimage,
>> I'll add a shell script to wrap it under script directory.
>>
>> Regards,
>> Kai
>> The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:
>>
>>   documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)
>>
>> are available in the git repository at:
>>   git://git.pokylinux.org/poky-contrib kangkai/distro
>>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro
>>
>> Kang Kai (6):
>>   ui/crumbs/utils.py: import module bb
>>   ui/crumbs/hig.py: fix run time error
>>   ui/crumbs/hig.py: remove extra spaces
>>   ui/crumbs/hig.py: check deploy process return value
>>   hob2: update DeployImageDialog for seperated tool
>>   hob2: create a standalone deploy image tool
> 
> Merged to master, thanks.

This happened a bit more quickly than I could get to reviewing V2 for
the inclusion of my feedback.

I've gone ahead and reviewed the patchset again. The breakout looks spot
on, thanks Kang. There are various other minor issues, mostly with the
strings. Please have a look and consider submitting a follow-on patch
series.

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


