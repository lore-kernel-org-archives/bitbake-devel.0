Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Sbxh4-0000hO-7Z
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 19:37:22 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Jun 2012 10:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="108148174"
Received: from unknown (HELO envy.home) ([10.255.12.60])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Jun 2012 10:25:50 -0700
Message-ID: <4FCE40D9.8070107@linux.intel.com>
Date: Tue, 05 Jun 2012 10:24:41 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Kang Kai <Kai.Kang@windriver.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
	<4FCDAF89.8000803@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA684@SHSMSX102.ccr.corp.intel.com>
	<4FCDC027.5030304@windriver.com>
In-Reply-To: <4FCDC027.5030304@windriver.com>
X-Enigmail-Version: 1.4.1
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"zhenfeng.zhao@windriver.com" <zhenfeng.zhao@windriver.com>
Subject: Re: [PATCH 2/2] hob2: create a standalone deploy image tool
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
X-List-Received-Date: Tue, 05 Jun 2012 17:37:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/05/2012 01:15 AM, Kang Kai wrote:
> On 2012年06月05日 15:40, Wang, Shane wrote:
>> Kang Kai wrote on 2012-06-05:
>>
>>> On 2012年06月05日 14:42, Wang, Shane wrote:
>>>>> -----Original Message-----
>>>>> From: Kang Kai [mailto:kai.kang@windriver.com]
>>>>> Sent: Tuesday, June 05, 2012 11:37 AM
>>>>> To: dvhart@linux.intel.com
>>>>> Cc: Wang, Shane; zhenfeng.zhao@windriver.com;
>>>>> bitbake-devel@lists.openembedded.org
>>>>> Subject: [PATCH 2/2] hob2: create a standalone deploy image tool
>>>>>
>>>>> diff --git a/bitbake/lib/bb/ui/crumbs/utils.py
>>>>> b/bitbake/lib/bb/ui/crumbs/utils.py
>>>>> index cd01a04..939864f 100644
>>>>> --- a/bitbake/lib/bb/ui/crumbs/utils.py
>>>>> +++ b/bitbake/lib/bb/ui/crumbs/utils.py
>>>>> @@ -22,6 +22,7 @@
>>>>>    # bitbake which will allow more flexibility.
>>>>>
>>>>>    import os
>>>>> +import bb
>>>> Why is this needed? I don't see any change you made in utils.py.
>>>> Is that to say without this line, the functions in utils.py don't work?
>>> Without the import, it just complains that
>>>
>>> NameError: global name 'bb' is not defined
>>>
>>> Regards,
>>> Kai
>> OK, It seems Saul didn't test it when he created utils.py;-)
> 
> I am not quit sure because it is fine when call the deploy image in the 
> hob. little weird.
> 

Probably because another file in the import list includes bb.

However, this change is not specific to the image tool and should be
broken out as a separate patch. utils.py makes calls to bb.utils.which()
on the third source line, so bb should certainly be imported in utils.py.

--
Darren


> Regards,
> Kai
> 
>>
>> --
>> Shane
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


