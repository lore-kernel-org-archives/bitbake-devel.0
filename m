Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 89B7378558
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Feb 2018 04:17:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w184Hod2022980
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Feb 2018 20:17:50 -0800 (PST)
Received: from localhost.corp.ad.wrs.com (128.224.163.240) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.361.1; Wed, 7 Feb 2018 20:17:43 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
	<48f4881a33e65e2162ca1df077982561058f040c.1517497731.git.liezhi.yang@windriver.com>
	<1517823574.3090.79.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <9da1f8e4-f56b-f88e-00cb-b97327b195c8@windriver.com>
Date: Thu, 8 Feb 2018 12:18:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517823574.3090.79.camel@linuxfoundation.org>
Subject: Re: [PATCH 4/8] bitbake: cooker: don't preserve BB_CONSOLELOG
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 08 Feb 2018 04:17:50 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi RP,

On 02/05/2018 05:39 PM, Richard Purdie wrote:
> On Thu, 2018-02-01 at 23:15 +0800, Robert Yang wrote:
>> Fixed:
>> $ bitbake --server-only -T -1
>> Set MACHINE = "qemux86" in conf/local.conf
>> $ bitbake quilt
>> Set MACHINE = "qemuppc" in conf/local.conf
>> $ bitbake quilt
>>
>> The log still goes into tmp/log/cooker/qemux86 in the second run,
>> this is
>> incorrect (should be tmp/log/cooker/qemuppc). I checked the code, the
>> ui
>> initializes it every time when it starts, so let it use the up-to-
>> date
>> one rather than old one.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/cooker.py | 8 --------
>>   1 file changed, 8 deletions(-)
> 
> This effectively reverts:
> 
> http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/cooker.py?id=3ebf7617d6c869f798807792918e1030b3ab66de
> 
> Sadly I didn't put a bug number in that commit message but I do
> remember there being a good reason to do this.
> 
> I think the problem is a "UI" can run multiple commands with reset
> events within that command stream and it would only have one console
> log. I also believe there may have been issues where toaster would have
> been unable to find the logs if they kept moving around.

I've found the bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=8411

I think that it has been fixed by:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=8373

http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=a0791c19db7d5b33ce7a4e3614a574ad4a319a84

I've tried the following commands with my patch:
$ . /workspace1/lyang1/poky/bitbake/bin/toaster start noweb
$ MACHINE=qemuppc bitbake quilt-native

The log is tmp/log/cooker/qemuppc/build_20180208_120722.942.log

$ MACHINE=qemux86 bitbake quilt-native

The log is tmp/log/cooker/qemux86/build_20180208_121605.382.log

And the log contents are correct.

So I think that we don't need preserve BB_CONSOLELOG anymore.

// Robert

> 
> The console log handling probably needs more thought as there are
> clearly multiple issues here. We may want to move it out of a directory
> which is machine specific?
> 
> Cheers,
> 
> Richard
> 
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index af482f9..3f113ae 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -326,11 +326,6 @@ class BBCooker:
>>           self.state = state.initial
>>           self.caches_array = []
>>   
>> -        # Need to preserve BB_CONSOLELOG over resets
>> -        consolelog = None
>> -        if hasattr(self, "data"):
>> -            consolelog = self.data.getVar("BB_CONSOLELOG")
>> -
>>           if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
>>               self.enableDataTracking()
>>   
>> @@ -358,9 +353,6 @@ class BBCooker:
>>           self.data_hash = self.databuilder.data_hash
>>           self.extraconfigdata = {}
>>   
>> -        if consolelog:
>> -            self.data.setVar("BB_CONSOLELOG", consolelog)
>> -
>>           self.data.setVar('BB_CMDLINE', self.ui_cmdline)
>>   
>>           #
>> -- 
>> 2.7.4
>>
> 

