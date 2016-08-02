Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2DB21731CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Aug 2016 14:56:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u72EuCGr016967
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 2 Aug 2016 07:56:12 -0700 (PDT)
Received: from [128.224.162.240] (128.224.162.240) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 2 Aug 2016 07:56:11 -0700
To: zzs <zzs213@126.com>, <bitbake-devel@lists.openembedded.org>
References: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <57A0B48A.6000606@windriver.com>
Date: Tue, 2 Aug 2016 22:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
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
X-List-Received-Date: Tue, 02 Aug 2016 14:56:20 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/02/2016 10:34 PM, zzs wrote:
>
>
> Hello, everyone
>
> I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
> When build the `test` package  using the flowwing cmd:
>      bitbake test
> Always 2.0 was built.
> My question is: how to let bitbake to build version 1.0 of the test package

You can:
1) PREFERRED_VERSION_test = "1.0" in conf file such as local.conf
Or:
2) Set DEFAULT_PREFERENCE = "-1" in test_2.0.bb.

// Robert

>
>
>
>
>

