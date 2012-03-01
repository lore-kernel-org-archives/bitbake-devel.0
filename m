Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3BiF-0002js-I4
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 20:30:51 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 01 Mar 2012 11:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113570082"
Received: from unknown (HELO [10.7.198.68]) ([10.7.198.68])
	by orsmga001.jf.intel.com with ESMTP; 01 Mar 2012 11:22:19 -0800
Message-ID: <4F4FCC6B.60006@linux.intel.com>
Date: Thu, 01 Mar 2012 11:22:19 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<706daef003dc2293e05fd03402ff74473a862fec.1330523904.git.shane.wang@intel.com>
	<4F4E98D6.5030608@linux.intel.com>
	<1330575571.1785.57.camel@dongxiao-osel>
In-Reply-To: <1330575571.1785.57.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 25/32] Hob: Add an extra 50M space if zypper is selected
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
X-List-Received-Date: Thu, 01 Mar 2012 19:30:51 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 20:19, Xu, Dongxiao wrote:
> On Wed, 2012-02-29 at 13:29 -0800, Joshua Lock wrote:
>> On 29/02/12 06:15, Shane Wang wrote:
>>> From: Dongxiao Xu<dongxiao.xu@intel.com>
>>>
>>> An workaround to judge if zypper is selected, we will add an extra
>>> 51200 KB to image size.
>>
>> This sort of change sets alarms off, especially as we already have
>> variables in the core metadata to affect image size (one of which is
>> employed for this very reason) - are we not honouring those variables in
>> hob?
>
> Thanks Josh for the suggestion.
>
> The situation we are facing is that, Hob could only query the variable
> values from bb.configuration.data, which doesn't include the
> image_types.bbclass and rootfs_rpm.bbclass. Therefore it is not able to
> get those variable's updated value in these classes.

I understand the problem, that's why the old hob forced a pre-conf which 
included INHERIT += "image_types" - not the cleanest solution but 
arguably better than hard coding values as at least this way we respect 
user settings.

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


