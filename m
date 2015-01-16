Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 6E67F722C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 11:52:59 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 07742F811E5; Fri, 16 Jan 2015 04:52:59 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=4.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 649C2F811E4;
	Fri, 16 Jan 2015 04:52:59 -0700 (MST)
Message-ID: <54B8FBA2.1060904@mlbassoc.com>
Date: Fri, 16 Jan 2015 04:53:06 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <54B80569.5030507@mlbassoc.com>
	<1421396904.1798.5.camel@linuxfoundation.org>
In-Reply-To: <1421396904.1798.5.camel@linuxfoundation.org>
Subject: Re: Parsing recipes progress bar doesn't show incremental progress
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
X-List-Received-Date: Fri, 16 Jan 2015 11:53:05 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2015-01-16 01:28, Richard Purdie wrote:
> On Thu, 2015-01-15 at 11:22 -0700, Gary Thomas wrote:
>> I think there has been a recent change in behaviour.  When
>> you start up bitbake there is a progress bar during the recipe
>> parsing:
>>     Parsing recipes: 100% |##########################################| Time: 00:00:05
>>
>> I used to see this bar fill as it went, but now it sits there
>> at 0% until it is completely done and then BAM goes to 100%
>>
>> Has anyone else seen this?  I'm running Poky/Yocto updated
>> to 2b925045877aeb44d9823a8c9515e8ab8fca1e52 as of 2015-01-15
>
> My guess is that the delay introduced after parsing from pyinotify is
> causing the bar to be visible at 100% for a while. I've just merged the
> performance fix for pyinotify, can you see if its still doing what you
> describe after that?

It may be better, certainly less of the "pregnant pause" now.

The progress bar for 'parsing recipes' seems to work fine when it's
actually parsing a lot of recipes.  The behaviour I was seeing happens
when bitbake is able to use cached data, e.g.
   Loading cache: 100% |####################################################################################| ETA:  00:00:00
   Loaded 1587 entries from dependency cache.
   Parsing recipes: 100% |##################################################################################| Time: 00:00:01
   Parsing of 1165 .bb files complete (1164 cached, 1 parsed). 1586 targets, 115 skipped, 0 masked, 0 errors.

In this case, the second progress bar was empty for the one second that
phase took and there were no intermediate changes to it.

Maybe it's just an impression I got yesterday when that second
progress bar sat empty for 5 seconds.  Today it took only one
(for the same build tree), so perhaps you did improve it.

Thanks for looking at this.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

