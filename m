Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id DA2F7607F8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Mar 2016 05:10:14 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 2B36668A01B; Tue, 22 Mar 2016 05:10:13 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=ALL_TRUSTED,BAYES_50,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 2290468A019;
	Tue, 22 Mar 2016 05:10:13 +0000 (GMT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id C924167400A8;
	Tue, 22 Mar 2016 06:10:12 +0100 (CET)
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <56EA7B5F.9030700@mlbassoc.com>
	<5861476.KL7KapCN76@peggleto-mobl.ger.corp.intel.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <56F0D3B4.6030802@mlbassoc.com>
Date: Tue, 22 Mar 2016 06:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5861476.KL7KapCN76@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake hang
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
X-List-Received-Date: Tue, 22 Mar 2016 05:10:16 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2016-03-21 23:08, Paul Eggleton wrote:
> On Thu, 17 Mar 2016 10:39:43 Gary Thomas wrote:
>> Typing ^C very early on causes a complete hang:
>>
>> $ bitbake some-image
>> NOTE: Started PRServer with DBfile:
>> /local/p7619_2016-02-23/cache/prserv.sqlite3, IP: 127.0.0.1, PORT: 43616,
>> PID: 14386 Parsing recipes:  11% |###########
>>
>>           | ETA:  00:00:21
>>
>> Keyboard Interrupt, closing down...
>>
>> WARNING: Timeout while attempting to communicate with bitbake server
>> WARNING: Timeout while attempting to communicate with bitbake server
>> WARNING: Timeout while attempting to communicate with bitbake server
>> WARNING: Timeout while attempting to communicate with bitbake server
>> ERROR: Gave up; Too many tries: timeout while attempting to communicate with
>> bitbake server
>>
>> Tested using poky:8debfea81e69d038bd2d56314b272cb74f5582ed
>>
>> Should I file a bug?
>
> Yes please.
>
> Cheers,
> Paul
>

Done: https://bugzilla.yoctoproject.org/show_bug.cgi?id=9319

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

