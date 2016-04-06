Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id E434D7716D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 01:33:28 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u361XRtL018115
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 5 Apr 2016 18:33:27 -0700 (PDT)
Received: from [128.224.162.236] (128.224.162.236) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 5 Apr 2016 18:33:26 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1459852436.git.liezhi.yang@windriver.com>
	<422c156e028c615327a780b83db657ba68259549.1459852436.git.liezhi.yang@windriver.com>
	<1459863381.7348.163.camel@linuxfoundation.org>
	<1459867622.7348.168.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <57046764.2010800@windriver.com>
Date: Wed, 6 Apr 2016 09:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459867622.7348.168.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2/git.py: remove .indirectiondir workaround
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
X-List-Received-Date: Wed, 06 Apr 2016 01:33:29 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 04/05/2016 10:47 PM, Richard Purdie wrote:
> On Tue, 2016-04-05 at 14:36 +0100, Richard Purdie wrote:
>> On Tue, 2016-04-05 at 03:35 -0700, Robert Yang wrote:
>>> It was used for workaround git 1.7.9.2 which was released in 2012
>>> which
>>> should not be existed on nowadays host, so remove it to avoid
>>> confusions.
>>
>> I like the idea of this however:
>>
>> $ cat classes/sanity.bbclass | grep 7.8
>> # We use git parameters and functionality only found in 1.7.8 or
>> later
>>      if LooseVersion(version) < LooseVersion("1.7.8"):
>>          return "Your version of git is older than 1.7.8 and has bugs
>> which will break builds. Please install a newer version of git.\n"
>>
>> so we have a minimum version of 1.7.8 defined right now...
>>
>> I'd be ok merging this if we increase the minimum version
>> requirement.
>
> There is also another issue pending on increased git version so I've
> just sent a patch for this, which would then unblock this one.

Thank you very much.

// Robert

>
> Cheers,
>
> Richard
>

