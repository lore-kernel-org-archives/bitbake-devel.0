Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3BA447D45D
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  5 May 2019 05:55:51 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x455tn1B023200
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 4 May 2019 22:55:49 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Sat, 4 May 2019 22:55:48 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Nicolas Dechesne
	<nicolas.dechesne@linaro.org>, "Burton, Ross" <ross.burton@intel.com>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
	<CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
	<CAJTo0LapxS3a00e31b9ur32x4XtNPTWUSmw4i=_x9AjbLuECjQ@mail.gmail.com>
	<CAP71WjxDASA04Fz6Fd6ew2FQPZFbtU9gMFJKoUiYVmKUNkbyag@mail.gmail.com>
	<4659e72f46cee86b62be445fc267bf2fae4f78b4.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <0c43bc44-1cf4-af21-e4e4-ed7ef2cf0365@windriver.com>
Date: Sun, 5 May 2019 13:56:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4659e72f46cee86b62be445fc267bf2fae4f78b4.camel@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Sun, 05 May 2019 05:55:52 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/2/19 3:42 AM, Richard Purdie wrote:
> On Wed, 2019-05-01 at 18:48 +0200, Nicolas Dechesne wrote:
>> On Wed, May 1, 2019 at 5:30 PM Burton, Ross <ross.burton@intel.com>
>> wrote:
>>> On Wed, 1 May 2019 at 11:51, Jacob Kroon <jacob.kroon@gmail.com>
>>> wrote:
>>>> I'm getting a lot of these warnings after removing tmp/ and
>>>> rebuilding
>>>> my image from sstate cache.
>>>> FWIW I use rm_work.bbclass, and regularly use the
>>>> sstate-cache-management,sh script to prune old cache.
>>>
>>> There's a patch I hacked up in master-next that shows where these
>>> warnings are coming from.  Yes, this patch produces two warnings
>>> per
>>> recipe with rm_work enabled.
>>
>> argh... i hit the same issue and came up with the exact same
>> conclusion.. i should have checked the mailing list earlier today ;)
>>
>> I am getting thousands of warnings like that with rm_work. I had
>> modified bitbake so that it shows the 'task' name like Ross, in ().
> 
> I suspect we're going to need to rethink that patch, and/or perhaps
> rm_work...


Sorry for the warnings, I just came back from the International Labour Day
Holiday. Something is wrong with rm_work, I will send a patch to fix it.

> 
> I did have concerns about it but was assured it was widely tested. We
> also probably need an rm_work test case on the autobuilder (need a bug
> for that so we don't forget?).

Rather than add a testcae on autobuilder, how about add a testcase to
oe-selftest, please ?

// Robert

> 
> Cheers,
> 
> Richard
> 
> 
> 

