Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C1D6B75886
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 01:28:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t5C1SUho022872
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 11 Jun 2015 18:28:30 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 11 Jun 2015 18:28:30 -0700
Message-ID: <557A35BC.9010801@windriver.com>
Date: Fri, 12 Jun 2015 09:28:28 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Dan McGregor
	<danismostlikely@gmail.com>
References: <1433260860-4674-1-git-send-email-danismostlikely@gmail.com>	
	<1433260860-4674-2-git-send-email-danismostlikely@gmail.com>	
	<556E4C1B.6080109@windriver.com>	
	<CACS+7ZScXmkPeDJnsNfnkHFQfJc6XSYUbaHYVHe6wQuKs8XouQ@mail.gmail.com>
	<1434063642.28975.248.camel@linuxfoundation.org>
In-Reply-To: <1434063642.28975.248.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/hg.py: Several fixes
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
X-List-Received-Date: Fri, 12 Jun 2015 01:28:39 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 06/12/2015 07:00 AM, Richard Purdie wrote:
> On Wed, 2015-06-10 at 08:42 -0600, Dan McGregor wrote:
>> Excellent question; I'll try that soon.
>
> Can you both agree on which patch(es) should merge please as I'm a
> little confused with what is currently on the list for this?

Yes, part of our code are similar.

Hi Dan,

How about RP merge my patch firstly, it fixes two things:
1) Fix the broken hg:// protocol, it doesn't work atm.
2) Fix hg's MIRROR TARBALL.

And then you can rebase your code, I'd like to help testing
when you send the formal patch.

// Robert

>
> Cheers,
>
> Richard
>
>
>

