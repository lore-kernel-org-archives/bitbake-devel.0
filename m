Received: from hermes.mlbassoc.com ([64.234.241.98] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1SA1p7-00076u-A8
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 17:22:13 +0100
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id AC1EEF811F1; Tue, 20 Mar 2012 10:13:21 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from hermes.chez-thomas.org (localhost.localdomain [127.0.0.1])
	by mail.chez-thomas.org (Postfix) with ESMTP id 53194F811E4;
	Tue, 20 Mar 2012 10:13:20 -0600 (MDT)
Message-ID: <4F68ACA0.8040409@mlbassoc.com>
Date: Tue, 20 Mar 2012 10:13:20 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <4F6882EE.5080704@mlbassoc.com>
	<CABcZANmcjghvLZy+gu6i5iqBfLg13CJg8+FyOABFq633q_Mi4Q@mail.gmail.com>
In-Reply-To: <CABcZANmcjghvLZy+gu6i5iqBfLg13CJg8+FyOABFq633q_Mi4Q@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: BBMASK doesn't work on .bbappend?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Mar 2012 16:22:13 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2012-03-20 08:26, Chris Larson wrote:
> On Tue, Mar 20, 2012 at 6:15 AM, Gary Thomas<gary@mlbassoc.com>  wrote:
>> I'm trying to include only part of the meta-ti layer into my mix,
>> so I have this in local.conf:
>>   BBMASK = ".*/meta-ti/recipes-misc/:.*/meta-ti/recipes-bsp/"
>>
>> Both my layer and meta-ti layer have a file formfactor_0.0.bbappend,
>> but it seems that the meta-ti/recipes-bsp/formfactor/formfactor_0.0.bbappend
>> is being processed as well as my own (and breaks my .bbappend file).
>>
>> How can I keep this file from being used?  I need other things in the
>> meta-ti layer so I'd like to come up with a "soft" solution, e.g. using
>> BBMASK (which works great for the .bb files)
>
> I'm using BBMASK to mask out a few bbappends from meta-oe -- we can't
> use it otherwise at this point. Also, BBMASK is a single regex. that :
> you have in yours looks questionable, unless you actually have a colon
> in your path. More likely you wanted | there.

I changed the BBMASK to be ".*/meta-ti/recipes-misc/|.*/meta-ti/recipes-bsp/"
and it's still processing the .bbappend file :-(  I also tried
   BBMASK = ".*/meta-ti/recipes-(misc|bsp)/"
Do either of these look correct to ignore everything below meta-ti/recipes-misc
and meta-ti/recipes-bsp ?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


