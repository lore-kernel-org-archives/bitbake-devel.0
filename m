Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 74D586AC95
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 01:11:59 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0N1Bx4L014638
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Thu, 22 Jan 2015 17:11:59 -0800 (PST)
Received: from [128.224.162.174] (128.224.162.174) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.174.1;
	Thu, 22 Jan 2015 17:11:58 -0800
Message-ID: <54C19FDD.5050209@windriver.com>
Date: Fri, 23 Jan 2015 09:11:57 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: "Burton, Ross" <ross.burton@intel.com>
References: <1421158296.31262.17.camel@linuxfoundation.org>	<54BCBBF6.4020904@windriver.com>	<1421663325.1798.31.camel@linuxfoundation.org>	<54BDBC83.9030007@windriver.com>
	<54C0BE76.7030601@windriver.com>	<CAJTo0LboyFeOwwSJANbXjwfQ88C_SeaFq1EMUn2xRwu6Byi+ug@mail.gmail.com>
	<54C19BCC.7080102@windriver.com>
In-Reply-To: <54C19BCC.7080102@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Add pyinotify to lib/
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
X-List-Received-Date: Fri, 23 Jan 2015 01:12:04 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 01/23/2015 08:54 AM, Robert Yang wrote:
>
>
> On 01/22/2015 08:50 PM, Burton, Ross wrote:
>>
>> On 22 January 2015 at 09:10, Robert Yang <liezhi.yang@windriver.com
>> <mailto:liezhi.yang@windriver.com>> wrote:
>>
>>     I run 5 builds on the same host, each of them is BB_NUMBER_THREADS=32 and
>>     PARALLEL_MAKE="-j32", I can get the error every time when "bitbake image".
>>     Then I use "ulimit -u 10000", the "bitbake image" works well, and the
>>     world is in building.
>>
>>
>> I'd suggest option (3), reducing the amount of parallelism. If you're expecting
>> five builds on the machine, then reducing those values would reduce wasted
>> parallelism - after all you've got over 3000 tasks sleeping.
>
> But I've never seen this error before 2015/01/02, do you know anything about
> what changes cause this issue recently, please ?

I also got errors like when "ulimit -u is 5000":

http://errors.yoctoproject.org/Errors/Search/Details/7896/1/10/a6ea28e3460217496856d2d79667c4bfbd867df9

I think that they are the similar issues.

When I used "ulimit -u 10000", everything is fine, the world builds are OK, too.

BTW., you can use "top -d 2 -b > top.out" to monitor the resources.

// Robert

>
> // Robert
>
>>
>> Ross

