Return-Path: <Rob.Woolley@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A96626013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2015 19:41:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t2DJfcuC029043
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 13 Mar 2015 12:41:38 -0700 (PDT)
Received: from [128.224.146.229] (128.224.146.229) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server (TLS) id 14.3.224.2;
	Fri, 13 Mar 2015 12:41:38 -0700
Message-ID: <55033D71.5070200@windriver.com>
Date: Fri, 13 Mar 2015 15:41:37 -0400
From: "Woolley, Rob" <rob.woolley@windriver.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>	
	<5501AFD7.40906@windriver.com>
	<1426177814.9114.119.camel@linuxfoundation.org>
In-Reply-To: <1426177814.9114.119.camel@linuxfoundation.org>
X-Originating-IP: [128.224.146.229]
Cc: tom.zanussi@linux.intel.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] knotty: Add automatic pager support
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
X-List-Received-Date: Fri, 13 Mar 2015 19:41:51 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 03/12/2015 12:30 PM, Richard Purdie wrote:
> On Thu, 2015-03-12 at 11:25 -0400, Rob Woolley wrote:
>> Hi,
>>
>> Just wanted to send out a ping to see if this enhancement is desired.
>>
>> It scratches an itch for me, but not sure how others feel about it.
>>
>> If there are any changes I can make or extra tests I can run, please let
>> me know.
> Patches 1/2 look good, I've run into the EPIPE issue myself and I have
> noticed the crazy logfile so those can likely be merged.
>
> I'm less sure about 3, letting the user pipe the output to less when
> needed would seem to be the better way to have this rather than adding
> in specific pagination support?
>
> Cheers,
>
> Richard
Sounds cool.  The exception was bugging me, so I'm glad to hear those 
ones look good.

As far as the 3rd patch is concerned: I remember when I first used 
bitbake, I was surprised by the flood of data coming from those 
options.  I would suggest that doing the automatic paging provides a 
better first impression and saves unnecessary typing.

I noticed that lib/image/help.py and lib/bsp/help.py have auto-paging 
for the help command.  I've CC'd Tom Zanussi for his opinion.

Regards,
Rob


