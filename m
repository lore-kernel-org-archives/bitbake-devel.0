Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id 8AE476AC00
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 06:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=lNfV5
	KuYnOPSJItXjPhlh6Hxga1/rda3rTOe1PsNQa0=; b=Cmos8o/41AA4IyBM64ZQ4
	s16+UEgq3WzbgxUYo82j1DbHnpL+W7Kau+8KV8RzVbQn0hwH+6p2OziLfZOGjD8+
	V7KUEbjPUINMstAfmj3/t5sCGKeazjH8nRO3wIw9ClM/99gHfBTPvBMCPS4BBtdI
	jwokIhUqt/MArRYQS23qFM=
Received: from [192.168.0.12] (unknown [171.212.168.97])
	by smtp3 (Coremail) with SMTP id DcmowAD3bLrQi6FXmeQTDQ--.49214S2;
	Wed, 03 Aug 2016 14:14:42 +0800 (CST)
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
	<57A0B48A.6000606@windriver.com>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <06719fa1-4361-f8d1-c4ef-c10534c3f1f3@126.com>
Date: Wed, 3 Aug 2016 14:14:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <57A0B48A.6000606@windriver.com>
X-CM-TRANSID: DcmowAD3bLrQi6FXmeQTDQ--.49214S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1kGw4ruF4xWrW3AFW8JFb_yoW3KFX_uF
	1vvFykXwsrur47t3ZxKrs5CrZ2qF4DKaykXryUJry29a4rCwsaqw4kur9Igw1xGwnrKr9a
	g3y7t3s8K34jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5ynQUUUUUU==
X-Originating-IP: [171.212.168.97]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiYBO6GVbdVz0EngAAsr
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
X-List-Received-Date: Wed, 03 Aug 2016 06:14:50 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2016年08月02日 22:56, Robert Yang 写道:
> Hi,
>
> On 08/02/2016 10:34 PM, zzs wrote:
>>
>>
>> Hello, everyone
>>
>> I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
>> When build the `test` package  using the flowwing cmd:
>>      bitbake test
>> Always 2.0 was built.
>> My question is: how to let bitbake to build version 1.0 of the test
>> package
>
> You can:
> 1) PREFERRED_VERSION_test = "1.0" in conf file such as local.conf
> Or:
> 2) Set DEFAULT_PREFERENCE = "-1" in test_2.0.bb.
>
> // Robert
>
Thanks for your repley.

Your suggested method can select any version sure.

But whenever I finish  my project. some time later I wan't rebuilt this 
project.
Then I must edit the source to select specific version. It is not 
convenient and buggy.
Is there a way to select version that no need to edit the source, e.g. 
select it on command line




