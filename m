Return-Path: <jpuhlman@mvista.com>
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
	[209.85.210.41])
	by mail.openembedded.org (Postfix) with ESMTP id 463C67F276
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 23:19:03 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id y39so668566ota.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:from:to:references:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=3o83WlqVesbBt7e8ekNBS3ejFae5ueiRi/rP44gQ7qk=;
	b=IdYpiuTJ0fB02Fnd6THd7LLBqJ0cbf935yGzuS2xXbf9+acwaPGIDYNpjnZErVWRYn
	Pd881/cyng0XnYYvkinqPbCCOK4nAdXGHuHWLcUyz3BdZ8PXoftWIga2MIJZU4wUjWnK
	AXDeUF7I+30xixsbYCgaeXg+0xJ+prwUQdblKZLUDOYyo+I+2g2v+XYXTTYqsUo3OkD4
	ssdpkDbKGGXBOQfSCcjTsqj3ECpRt2rsPclxE+slB/YL0IgzFrGbU9SPKhL8Bx9NmIis
	fipaPT6vsKMPfu+9ggtBQirbjV2cV/V97sbTEnMg2W+r2LjWs5W6Ngl8w35UBrXlgV+Y
	bdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=3o83WlqVesbBt7e8ekNBS3ejFae5ueiRi/rP44gQ7qk=;
	b=MfRQEYevMhFBy9UOa6+fH2i8RlkdP94w3pMV6iQHNOA/FsS5GK1XoPbn2DVuvgoWM2
	xHUi3mvbaxJ6n15duYPOGgK+OZEwioivnp/AwM98LW5zTD50HIJ/IxZovU0RG/ra4MnZ
	+rZNInUJOwv1bO+SDAv1xry3BavOOU80Iz5VE/MuZxyIJGG2PAizAQW4uGBcCnGUUUVR
	UUqLaNci9HgGhoMriE5qJPsRceQJJxO8wXD0lC1lpAn0HJyLuKGptdUb/ocs+BwUSuNT
	IgjgfajazNvK5pf22oXvGmLzjpXWycND4FzQ6faIkgSdk1T28LV4H4UHlBlwYI6bWdzo
	EbTA==
X-Gm-Message-State: APjAAAU5LJUByBFiI85AkheKcxaujeYr/AqCnaOvb07ELXAREi+QSvUR
	53Zmi1+Wd8jgY8vfAUhA8jwnoQ==
X-Google-Smtp-Source: APXvYqxvi8WVzmp/UQYYyqFHdHNS1K85zDLCoFCDpEV5zAxkKZqCKGS9xugHVDHH5qrI0jgYbNecgQ==
X-Received: by 2002:a9d:2902:: with SMTP id d2mr867140otb.333.1569539944168;
	Thu, 26 Sep 2019 16:19:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:4c90:60a0:8460:5454:270e:1a37?
	([2600:1700:4c90:60a0:8460:5454:270e:1a37])
	by smtp.gmail.com with ESMTPSA id
	w13sm1042453oih.54.2019.09.26.16.19.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 16:19:03 -0700 (PDT)
From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>,
	bitbake-devel@lists.openembedded.org, grzegorz.heldt@gmail.com
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
	<d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
	<9022a7bc-7f91-dddb-5bfc-530b42a2d1bf@kernel.crashing.org>
	<625be95c-9f8f-adcc-2c27-179733423b59@mvista.com>
Message-ID: <d7e77675-23ff-ed76-026a-e7c842a0f8bb@mvista.com>
Date: Thu, 26 Sep 2019 16:18:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <625be95c-9f8f-adcc-2c27-179733423b59@mvista.com>
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Thu, 26 Sep 2019 23:19:03 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US



On 9/26/2019 4:12 PM, Jeremy A. Puhlman wrote:
>
>>> This is what you get on thud.
>>>
>>> [cluge@jptest01 build]$ bitbake-layers add-layer 
>>> ../meta-openembedded/meta-python/
>>> NOTE: Starting bitbake server...
>>> [cluge@jptest01 build]$ bitbake-layers add-layer 
>>> ../meta-openembedded/meta-oe/
>>> NOTE: Starting bitbake server...
>> Ya, the dredded circular dependency.  I thought you could add them 
>> both at the
>> same time to resolve this.  (You can via the layer index mechanism at 
>> least..)
>> I believe the circular dependency has been resolved in master.)
>>
>> --Mark
>
> I haven't looked at warrior, but thud its not circular at least when 
> it comes to layer depends(yeah it think
> there is meta-oe content that can depend on meta-python). If you 
> reverse the two, it works just fine.
>
Yeah the its still the same with warrior. You just need to reorder adds, 
if doing it one at a time. However, you
are correct you can add them at the same time on the same line.

-- 
Jeremy A. Puhlman
jpuhlman@mvista.com


