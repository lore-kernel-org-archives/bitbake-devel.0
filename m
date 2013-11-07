Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 974D76D66B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 16:36:08 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id A8E83F81226; Thu,  7 Nov 2013 09:36:10 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id B3AD1F81225;
	Thu,  7 Nov 2013 09:36:09 -0700 (MST)
Message-ID: <527BC186.5040406@mlbassoc.com>
Date: Thu, 07 Nov 2013 09:36:22 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <527BAC0F.3090901@mlbassoc.com> <7286154.LbYKCCWHqH@helios>
In-Reply-To: <7286154.LbYKCCWHqH@helios>
Cc: bitbake-devel@lists.openembedded.org, Ross Burton <ross.burton@intel.com>
Subject: Re: Some 'depexp' nits
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
X-List-Received-Date: Thu, 07 Nov 2013 16:36:08 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2013-11-07 09:25, Paul Eggleton wrote:
> Hi Gary,
>
> On Thursday 07 November 2013 08:04:47 Gary Thomas wrote:
>> I hope this is the correct list.
>>
>> I was just using '-u depexp' and noticed a few small things.
>>     $ bitbake my-qt5-image -u depexp
>>     This UI is only compatible with the -g option
>>
>> Perhaps this should be worded more strongly, like this?
>>     This UI requires the -g option
>
> Sounds like a good idea yes.
>
>> Also, after running successfully, I closed the window (using
>> the close WM button) and got this:
>>     $ bitbake my-qt5-image -u depexp -g
>>     Unable to cleanly stop: No such command
>>
>> There didn't seem to be any other way to exit the program, so
>> at least this should be clean.
>
> There is now a bug open for the latter issue:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5445
>
>> Are these valid concerns/observations?  Would you entertain patches
>> for these items?
>
> Yes, that would be great.

Can I send them against the Poky/Yocto tree?  Or should it be the
separate bitbake tree (which is where?)?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

