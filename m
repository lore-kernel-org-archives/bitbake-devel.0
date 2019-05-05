Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0F7246C10F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  5 May 2019 10:31:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x45AUkk4028343
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 5 May 2019 03:30:56 -0700
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Sun, 5 May 2019 03:30:23 -0700
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
	<0c43bc44-1cf4-af21-e4e4-ed7ef2cf0365@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <90381831-a25e-921f-40eb-1fe96c633a78@windriver.com>
Date: Sun, 5 May 2019 18:30:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0c43bc44-1cf4-af21-e4e4-ed7ef2cf0365@windriver.com>
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
X-List-Received-Date: Sun, 05 May 2019 10:31:59 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi RP,

After more investigations, these warnings are caused by recrdeptask,
the rm_work calls:

addtask after 'deps + recrdeptask' before do_build

Then we will get the warnings, and we can divide these warnings into 3 kinds:

1) deltask only removes task from 'deps', but doesn't remove it from
    'recrdeptask', so there are warnings for native recipes like dependent
    task do_package_write_rpm, although native.bbclass has called
    "deltask do_package_write_rpm', such a recrdeptask doesn't make any sense
    for native recipes. But we can't make deltask remove recrdeptask since we may
    need keep recrdeptask sometimes, for example, the image recipes don't need
    do_package_write_rpm, but their do_rootfs tasks require all the dependent
    rpms are done. I think that we need a command such as delrecrdeptask to fix
    it, but I'm not sure whether it is worth or not.

2) base.bbclass has set 'do_build[recrdeptask] += "do_deploy"', but do_deploy
    doesn't exist for most of the recipes, so we get the warnings of not
    do_deploy task, I don't know why do_deploy should be a recrdeptask, and
    maybe we need set it in rootfs_xxx.bbclass or image.bbclass, or set it
    conditionally in a func.

3) gcc-source doesn't have do_populate_sysroot or do_populate_lic, but
    do_build_without_rm_work always depends on them:

    bb.build.addtask('do_build_without_rm_work', '', ' '.join(deps), d)

    so we get warnings that gcc-source has no dependent task do_populate_sysroot
    or do_populate_lic. I think that we can make do_build_without_rm_work
    depend on them conditionally to fix the problem.

Any comments are appreciated.

// Robert


On 5/5/19 1:56 PM, Robert Yang wrote:
> 
> 
> On 5/2/19 3:42 AM, Richard Purdie wrote:
>> On Wed, 2019-05-01 at 18:48 +0200, Nicolas Dechesne wrote:
>>> On Wed, May 1, 2019 at 5:30 PM Burton, Ross <ross.burton@intel.com>
>>> wrote:
>>>> On Wed, 1 May 2019 at 11:51, Jacob Kroon <jacob.kroon@gmail.com>
>>>> wrote:
>>>>> I'm getting a lot of these warnings after removing tmp/ and
>>>>> rebuilding
>>>>> my image from sstate cache.
>>>>> FWIW I use rm_work.bbclass, and regularly use the
>>>>> sstate-cache-management,sh script to prune old cache.
>>>>
>>>> There's a patch I hacked up in master-next that shows where these
>>>> warnings are coming from.  Yes, this patch produces two warnings
>>>> per
>>>> recipe with rm_work enabled.
>>>
>>> argh... i hit the same issue and came up with the exact same
>>> conclusion.. i should have checked the mailing list earlier today ;)
>>>
>>> I am getting thousands of warnings like that with rm_work. I had
>>> modified bitbake so that it shows the 'task' name like Ross, in ().
>>
>> I suspect we're going to need to rethink that patch, and/or perhaps
>> rm_work...
> 
> 
> Sorry for the warnings, I just came back from the International Labour Day
> Holiday. Something is wrong with rm_work, I will send a patch to fix it.
> 
>>
>> I did have concerns about it but was assured it was widely tested. We
>> also probably need an rm_work test case on the autobuilder (need a bug
>> for that so we don't forget?).
> 
> Rather than add a testcae on autobuilder, how about add a testcase to
> oe-selftest, please ?
> 
> // Robert
> 
>>
>> Cheers,
>>
>> Richard
>>
>>
>>

