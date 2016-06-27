Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 810E36E630
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2016 03:31:56 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u5R3Vus7026981
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 26 Jun 2016 20:31:56 -0700 (PDT)
Received: from [128.224.162.240] (128.224.162.240) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.248.2;
	Sun, 26 Jun 2016 20:31:55 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>, "Wessel, Jason"
	<jason.wessel@windriver.com>, Mark Hatle <mark.hatle@windriver.com>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
	<ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
	<1466774122.3319.235.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <57709E29.2000707@windriver.com>
Date: Mon, 27 Jun 2016 11:31:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1466774122.3319.235.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Mon, 27 Jun 2016 03:31:57 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 06/24/2016 09:15 PM, Richard Purdie wrote:
> On Fri, 2016-06-24 at 00:55 -0700, Robert Yang wrote:
>> From: Jason Wessel <jason.wessel@windriver.com>
>>
>> The filename can't be "foo." for MS Windows filesystem, it will
>> renamed
>> to "foo" automatically, so we can't upload sources like "foo." to the
>> Windows server, remove "." in the end will fix the problem.
>
> This patch on its own is probably ok. What I worry about is that if I
> merge this, I'll then get all the follow ups which for example force
> lower or upper case everywhere, remove ":" characters from all
> filenames (including sstate?), remove various other characters and so
> on.
>
> We don't run on windows filesystems and we're not likely ever to be
> able to.
>
> So what are we aiming for here?

We don't run bitbake on windows, either. Our problem is that we put
the downloaded sources on a windows server, and the filename mismatches
when the name is "foo.", so it would fail to download.

// Robert

>
> Cheers,
>
> Richard
>

