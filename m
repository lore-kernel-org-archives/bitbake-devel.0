Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A3C4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 13:33:16 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.21785.1671456793746769319
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Dec 2022 05:33:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=GovaclXK;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1671456794;
  x=1702992794;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=/EOCTr9vLq3Re92D6OG9baocgo7ADKU2LLn8Y0/+Qxw=;
  b=GovaclXKM8Zege77AFwSCrvqtOv8dPoPyzm5lRiT6qCWJaTLoBKk4iG8
   YgpyA5gdxAZunEFiQBBrN52ue2YZe5awVj7j+CBgnNfuOP5LDOsucsGdm
   2L04XxYvetUd9orvCl5muqFeQ2wmoOo9DYzncNgvHdFyUuc3LdJ+S9k9X
   ZN+yqvx7KYpQBpNl9pQ5BZJik/2xkbuPg5bbP8CuoQDwz+RjgcUPP3g5j
   ci7fshBRnN2efLMgUnPzVbcoKTvlJ0SiS2MwaRl4ok2xPqTstgTQ85dlU
   OpP9LR8LYXL7Ki9JXkdDL+VSIcMElsMv+VCA7m6+66NbPYuo2bNn9VNpS
   A==;
References: <jwq5yegq5h5.fsf@axis.com>
 <49ffc1db-9b43-e570-d726-dba12d560a30@windriver.com>
User-agent: mu4e 1.8.9; emacs 29.0.60
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: Randy MacLeod <randy.macleod@windriver.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"Zheng.qiu@uwaterloo.ca" <Zheng.qiu@uwaterloo.ca>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Bitbake PSI checker
Date: Mon, 19 Dec 2022 13:50:47 +0100
Organization: Axis Communications AB
In-Reply-To: <49ffc1db-9b43-e570-d726-dba12d560a30@windriver.com>
Message-ID: <jwqfsdbo6w9.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 13:33:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14199


On Mon, Dec 12 2022, Randy MacLeod wrote:

> CCing Richard
>
> On 2022-12-12 05:07, Ola x Nilsson via lists.openembedded.org wrote:
>> Hi,
>>
>> I've been looking into using the pressure stall information awareness of
>> bitbake
> That's good to hear Ola.
>>   but I have some problems getting it to work.  Actually I think
>> it just doesn't work at all.
>
> Doesn't work at all?
>
> Well that would be surprising. See below.

OK, it will occasionally block a task. But since the next attempt will
always be a very short time interval it will almost always start a new
task even if the pressure is high.
At least this is what I observe on my system.

<snip>

> 1. Rather than just keep track of the previous pressure values
> seen more than 1 second ago as done currently:
>
>  =C2=A0 =C2=A0 =C2=A0 if now - self.prev_pressure_time > 1.0:
>
> and always using that as a reference, we can
> store say 10 values per second and use that as a reference.
>
> There are some challenges in that approach in that we don't control
> how often the function is called. Averaging over the last 10 calls
> is tempting but likely has some edge cases such as when there are
> lots of tasks starting/ending.
>
>
> 2. If there has been a long delay since the function was last called,
> we could check the pressure, sleep for a short period of time and check it
> again. Some people would not like this since it will needlessly delay=20
> the build
> so we'd have to keep the delay to < 1 second. Too short a delay will redu=
ce
> the accuracy of the result but I suspect that 0.1 seconds is sufficient=20
> for most
> users. We could also look at the avg10 value in this case or even some=20
> combination of
> both the current contention and avg10.
>
>
> 3. Just calculate the pressure per second by:
>
>  =C2=A0=C2=A0 ( current pressure - last pressure ) / (now - last_time)
>
> This could handle=C2=A0 short time differences such os milliseconds
> as would be a 'cheap' way to deal with long delays. In your case,
> the pressure would be:
>
>  =C2=A0 978077.0 io_pressure 1353882.0 mem_pressure 20922.0
>
> divided by ~19 since the initial values were close to zero.
>
> Then for the next time, just 0.1 seconds later:
>
> 1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_pressu=
re 20922.0
> 1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
> 1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.0
>
> Multiplying by 10 or easy calculation, the would be a pressure:
>
> cpu: 4660, io: 307920, mem: 0.
>
>
> Do you have another idea or a preference as to which approach we take?

I think 3 is a good first step.  Using multiple samples could improve
our calculated "avg1", but lets do that later if needed.

/Ola

>
> ../Randy
>
>
>>
>> /Ola Nilsson
>>
>>=20
>>


