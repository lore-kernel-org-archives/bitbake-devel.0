Return-Path: <zzs213@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by mail.openembedded.org (Postfix) with ESMTP id 0C2BF731C2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Aug 2016 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=p/hal
	mqRNjB2k7LSIQBU0nNGaXfLpyRcqA5jwYlGz+E=; b=AF9bWkUkEGbKfDRmEPCH9
	bd9sghbaDalDnXwy6TCaZhb3WsVu+2NTr59BaW1wxEZLsef3DTwwUvdyRJITWVw7
	CiSYtMTc7+mwKE7lwbEsbQYBrzQZH9C3Eevn0INAtdSj3OxZxaMQCtN+ZTIfdANv
	T8n4XWx+mlQ6iWrX2tjwYI=
Received: from [192.168.0.12] (unknown [171.212.170.252])
	by smtp1 (Coremail) with SMTP id C8mowACHrSrC475X18e6Dw--.501S2;
	Thu, 25 Aug 2016 20:25:39 +0800 (CST)
To: bitbake-devel@lists.openembedded.org
References: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
	<754ba7e8-128f-cd67-7f1c-d3e2a57b006c@126.com>
	<d14aa6a9-7e47-55ff-aa24-d9e3892fa677@126.com>
	<1472125831.16712.144.camel@linuxfoundation.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <2fafcaaf-a59e-bc2f-f427-1d126fc834ed@126.com>
Date: Thu, 25 Aug 2016 20:25:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472125831.16712.144.camel@linuxfoundation.org>
X-CM-TRANSID: C8mowACHrSrC475X18e6Dw--.501S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWrZryDJr13Kr15uw48Zwb_yoWfZFXE9F
	9a9FW8G3srW3Wjqw13Zr1kArnrKasxWF1UXrZ5Xa1Sg348Xay3WayUtr97Kwn5CFW0yrnI
	gF12vr17J3yv9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeag4DUUUUU==
X-Originating-IP: [171.212.170.252]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiqAPQGVc1pcm-ggAAsR
Subject: Re: question about BBVERSIONS OVERRIDES and PREFERRED_VERSION
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
X-List-Received-Date: Thu, 25 Aug 2016 12:25:46 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>> But, I'm not sure this work for other env.
>>
>> I don't know why just lower case override permited in  this function.
>>
>> Version string just include digit and point is very common, but
>> islower() return False for these strings.
>>
>> This behavior is intended or a bug?
>> Or has another way to solve my problem?
>
> There was a discussion a while ago and we decided to only have bitbake
> accept lower case overrides. I believe that the numeric piece isn't an
> issue but the decimal point character probably is.
>
> The reason for this was to try and avoid some of the performance costs
> where any variable with a "_" in the name was potentially an override
> character and this was costly for variable processing.
>

So, that's said I can't use override based upon version string just like 
'1.1.7'

If it is true, Does it means  'BBVERSIONS' has no sense?

I can't believe that  widly used version string format  can't be used as 
override!



