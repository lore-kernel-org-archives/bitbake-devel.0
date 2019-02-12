Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8DDFC7C3DD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Feb 2019 09:59:56 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x1C9xuMB008303
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 12 Feb 2019 01:59:56 -0800 (PST)
Received: from localhost.corp.ad.wrs.com (128.224.163.177) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.435.0; Tue, 12 Feb 2019 01:59:56 -0800
To: Mark Hatle <mark.hatle@windriver.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1548400142.git.liezhi.yang@windriver.com>
	<070002fb5989fd3c629d06ce77d9b33d11982a18.1548400142.git.liezhi.yang@windriver.com>
	<fe63e0bb8c0a5b572dcb038f5af51bbd29fadc72.camel@linuxfoundation.org>
	<d6feea78-123c-ba23-1fab-d664f0873a74@windriver.com>
	<5508a496-24af-f341-6455-35952d8ae6dd@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <fff17600-0407-a690-dc4a-c3861e1e42e7@windriver.com>
Date: Tue, 12 Feb 2019 18:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5508a496-24af-f341-6455-35952d8ae6dd@windriver.com>
Subject: Re: [PATCH 1/1] bitbake: cookerdata: Check duplicated BBFILE_COLLECTIONS
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
X-List-Received-Date: Tue, 12 Feb 2019 09:59:56 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2/12/19 10:02 AM, Robert Yang wrote:
> 
> 
> On 2/6/19 12:43 AM, Mark Hatle wrote:
>> On 2/5/19 9:14 AM, Richard Purdie wrote:
>>> On Fri, 2019-01-25 at 15:09 +0800, Robert Yang wrote:
>>>> It shouldn't work when there are duplicated BBFILE_COLLECTIONS.
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>   bitbake/lib/bb/cookerdata.py | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>
>>> This caused a load of failures on yocto-check-layer:
>>>
>>> https://autobuilder.yoctoproject.org/typhoon/#/builders/39/builds/259
>>>
>>> We may need to fix that behaviour of that script?
>>>
>>> Not sure if this is highlighting a bug or not...
>>
>> I think it is highlighting a bug in the yocto-check-layer.
>>
>> I've seen instances in the past where something has failed (or been aborted),
>> and the yocto-check-layer didn't cleanup after itself.
>>
>> Due to this, we had various configuration files load multiple times (since the
>> layer was loaded multiple times) which caused problems throughout the system.
>>
>> The yocto-check-layer needs to somehow verify that it's not added the same layer
>> multiple times.
> 
> Sorry, I just came back from holiday, I will work on it if it has not been fixed.

I've sent 2 patches in oe-core to fix yocto-check-layer:

http://lists.openembedded.org/pipermail/openembedded-core/2019-February/278919.html

// Robert

> 
> // Robert
> 
>>
>> --Mark
>>
>>> Cheers,
>>>
>>> Richard
>>>
>>
>>

