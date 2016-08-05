Return-Path: <zzs213@126.com>
Received: from m15-112.126.com (m15-112.126.com [220.181.15.112])
	by mail.openembedded.org (Postfix) with ESMTP id 226A66AC00
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Aug 2016 03:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=31u3q
	0P3cppv713Gv64NO+Ll+isU3hYXZfBz25YdOw0=; b=Nqjj/MlnR+83St8ziYdsL
	2cleiwCrOgB4R6PDYvqJu9r67n5ZGgARddrZEA2cS80sPC358mr2SWj48NtE9ri4
	dr9+UuQ8qqfYkDMptrCMWQUxlP3AcT4NPgTxbamdxVL8fu6H7FKlaFR2PGGHVcy4
	lzoPyvqt8aOGCmYwq8vQLw=
Received: from [192.168.0.12] (unknown [171.212.168.97])
	by smtp2 (Coremail) with SMTP id DMmowAAHtWGTBKRXyZOvCg--.22187S2;
	Fri, 05 Aug 2016 11:14:28 +0800 (CST)
To: bitbake-devel@lists.openembedded.org
References: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
	<57A0B48A.6000606@windriver.com>
	<06719fa1-4361-f8d1-c4ef-c10534c3f1f3@126.com>
	<1470237801.9142.134.camel@linuxfoundation.org>
	<093B67FB09E7C1439E8DF68949D5ACF32A619126@IRSMSX109.ger.corp.intel.com>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <c3d77159-3c6c-332f-3364-f04ee43eea63@126.com>
Date: Fri, 5 Aug 2016 11:14:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <093B67FB09E7C1439E8DF68949D5ACF32A619126@IRSMSX109.ger.corp.intel.com>
X-CM-TRANSID: DMmowAAHtWGTBKRXyZOvCg--.22187S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4kur1UAFW8GryfWr1rZwb_yoW5Aw1UpF
	W7Ka4Yk3ykJr1rArnFyr18KFZ5tw4fKwsagrn8Jry8Arn09F4qv3yvgr15uasrArn7tw4j
	93yYqF17Zws8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8zuAUUUUU=
X-Originating-IP: [171.212.168.97]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiTxa8GVYY6W7b6QAAsH
Subject: Re: howto build specific version package
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
X-List-Received-Date: Fri, 05 Aug 2016 03:14:42 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2016年08月04日 19:44, Schroeder, Henning 写道:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
>> Sent: Wednesday, August 3, 2016 17:23
>> To: 张忠山 <zzs213@126.com>; Yang, Liezhi (Wind River)
>> <liezhi.yang@windriver.com>; bitbake-devel@lists.openembedded.org
>> Subject: Re: [bitbake-devel] howto build specific version package
>>
>> On Wed, 2016-08-03 at 14:14 +0800, 张忠山 wrote:
>>> 在 2016年08月02日 22:56, Robert Yang 写道:
>>>> Hi,
>>>>
>>>> On 08/02/2016 10:34 PM, zzs wrote:
>>>>>
>>>>>
>>>>> Hello, everyone
>>>>>
>>>>> I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
>>>>> When build the `test` package  using the flowwing cmd:
>>>>>      bitbake test
>>>>> Always 2.0 was built.
>>>>> My question is: how to let bitbake to build version 1.0 of the
>>>>> test package
>>>>
>>>> You can:
>>>> 1) PREFERRED_VERSION_test = "1.0" in conf file such as local.conf
>>>> Or:
>>>> 2) Set DEFAULT_PREFERENCE = "-1" in test_2.0.bb.
>>>>
>>>> // Robert
>>>>
>>> Thanks for your repley.
>>>
>>> Your suggested method can select any version sure.
>>>
>>> But whenever I finish  my project. some time later I wan't rebuilt
>>> this project.
>>> Then I must edit the source to select specific version. It is not
>>> convenient and buggy.
>>> Is there a way to select version that no need to edit the source, e.g.
>>> select it on command line
>>
>> You can't select everything from the commandline. Its for the reasons of
>> reproducibility that we suggest people set things in configuration files like
>> local.conf. You can then provide the exact configuration to reproduce any
>> given build by saving that configuration file.
>>
>> Cheers,
>>
>> Richard
>
> Hi,
> I do see two options for you.
> 1.) As explained by the folks already you create two build directories which share download and sstate folders. Then you create one local.conf with the "Production Version" and one with the "Development Version". Depending on which build folder you utilize you get the product or development version.
> 2.) If you incline to use the command line to switch, there is the option to specify a config file explicitely read by bitbake. If called with "-R product.conf" you get your product version and otherwise you stick with Yocto choice of taking newest one.
>
> Example:
> bash-4.3$ cat -> product.conf
> PREFERRED_VERSION_test="1.0"
> bash-4.3$ bitbake -R product.conf test
> ...
>
> Option One is the most conflict free variant as your configurations are cleanly separated and your calls to bitbake are identical. At the cost of having the build directory two times and two different environments (Shell instances).
> Option Two is risky if you do not tell bitbake to clean (bitbake -c cleanall test) from the former build as you may end up with a mixed sysroot.
>
> Hope this helps.
>

Thanks very much.
Now I use the second option.



