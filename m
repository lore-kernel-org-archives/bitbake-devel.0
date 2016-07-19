Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id D3C42606D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 09:53:52 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 0342968A01C; Tue, 19 Jul 2016 10:53:52 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=ALL_TRUSTED,BAYES_50,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 81C2A68A019;
	Tue, 19 Jul 2016 10:53:50 +0100 (BST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id ED80367403D0;
	Tue, 19 Jul 2016 11:53:49 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <578DC9D2.1060607@mlbassoc.com>
	<9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
	<D3B3B3B3.81640%belen.barros.pena@intel.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <578DF8AD.1090003@mlbassoc.com>
Date: Tue, 19 Jul 2016 11:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <D3B3B3B3.81640%belen.barros.pena@intel.com>
Subject: Re: New progress meters
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
X-List-Received-Date: Tue, 19 Jul 2016 09:53:53 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 2016-07-19 11:43, Barros Pena, Belen wrote:
>
>
> On 19/07/2016 10:16, "bitbake-devel-bounces@lists.openembedded.org on
> behalf of Paul Eggleton" <bitbake-devel-bounces@lists.openembedded.org on
> behalf of paul.eggleton@linux.intel.com> wrote:
>
>> Hi Gary,
>>
>> On Tue, 19 Jul 2016 08:33:54 Gary Thomas wrote:
>>> I quite like the new progress meters, but they seem to not be very
>>> accurate.  I was just rebuilding webkitgtk and got this:
>>>
>>> 0: webkitgtk-2.12.3-r0 do_compile (pid 30494)  96%
>>> |#######################################  | ETA:  0:02:58
>>>
>>> Sadly, it sat there, waffling between 02:58 and 03:44 for about
>>> 10 minutes...
>>>
>>> * How is this [estimate] calculated?
>>> * Should I be concerned when it's not accurate (or even moving)?
>>
>> There are a few different types of progress handling for different types
>> of
>> tasks. To be specific in this example, for recipes that inherit cmake
>> during
>> do_compile we report the progress that the cmake-produced makefile prints
>> out.
>> The ETA, which is implemented in the python-progressbar code we are using
>> is
>> kind of a rolling average calculated based on recent progress, so it's
>> possible it's inaccurate in this instance if there are places where it
>> stalls.
>> Python-progressbar has an alternative ETA mode which we could try, but to
>> be
>> honest when the progress value sent to it isn't evenly apportioned with
>> respect to time and we don't have any weighting information, there's not
>> a lot
>> anyone can do to estimate time remaining accurately. If it's truly
>> bothersome
>> we could just turn off the ETA display I suppose.
>
> Big caveat: this is just my opinion. Displaying information we are not
> sure is accurate is probably not a good idea: it disconcerts people,
> creates false expectations and ultimately undermines trust on the system.
>
> If you are not sure the ETA is reliable, I would remove it.

ETA is always that - ESTIMATED.  That said, I'd agree that it should be "close"
or not used at all. Who amongst us has waited for that last 2 minutes downloading
some update...?

>
> Just my 2c.
>
> Cheers
>
> Belén
>
>>
>>> n.b. I wasn't sure the best place for this question, the bitbake
>>> list, generic Yocto or OE-core.  Feel free to redirect as needed.
>>
>> Technically this is an OE question although I know that isn't obvious -
>> there
>> are parts of this that are implemented in BitBake and parts in OE, so
>> asking
>> here is fine.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

