Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dbaryshkov@gmail.com>)
	id 1R8zP6-00041H-Lo; Wed, 28 Sep 2011 21:02:48 +0200
Received: by wwf27 with SMTP id 27so7564326wwf.24
	for <multiple recipients>; Wed, 28 Sep 2011 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=aN9mWWln0YxRyRATYrfgYbkHYzBmm06gwUq+G9vnZvQ=;
	b=aUHDJpk+l36W8yWjz5XrFKX4D2xHW2YqV1cHs6juYANwPM99rq0vaT34ouD7iBbmXi
	hRAlOufzXF0ETviVgsv6v0OB7kP/cyaH7Tn7awFRgE/LmpkBlDKD+bpBjjiSim94zmgT
	pIQbdcYoQhtxXSUHD/XtJIVfUJaxjTsFtgRro=
Received: by 10.227.61.142 with SMTP id t14mr6163870wbh.68.1317236238213;
	Wed, 28 Sep 2011 11:57:18 -0700 (PDT)
Received: from [137.202.140.192] (nat-rup.mentorg.com. [139.181.168.34])
	by mx.google.com with ESMTPS id l40sm27210899wbm.10.2011.09.28.11.57.16
	(version=SSLv3 cipher=OTHER); Wed, 28 Sep 2011 11:57:17 -0700 (PDT)
Message-ID: <4E836DD1.5010600@gmail.com>
Date: Wed, 28 Sep 2011 22:56:17 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
	<201109281116.00890.paul.eggleton@linux.intel.com>
	<4E831868.4090603@gmail.com>
	<201109281432.57331.paul.eggleton@linux.intel.com>
In-Reply-To: <201109281432.57331.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] meta-micro problems
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
X-List-Received-Date: Wed, 28 Sep 2011 19:02:48 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/28/2011 05:32 PM, Paul Eggleton wrote:
> On Wednesday 28 September 2011 13:51:52 Dmitry Eremin-Solenikov wrote:
>> If you wish, I can retry this with smaller layer set. But if the bug
>> will still arise, I simply have no knowledge/time to look deeper into bb
>> without additional input/pointers from bb gurus.
>
> That's OK, I can spend time looking into it. It sounds like a bug in bitbake
> if metadata can influence it to behave this way. If we can produce a simplified
> test case I think it will be easier to fix.

I was too early to say that it works. Got the same issues again on my 
main builder. I'll run some more tests. E.g. main builder has my 
meta-micro FEED_ARCH patch commited. That might be one of the problems.

>
> Cheers,
> Paul
>



