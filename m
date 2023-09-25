Return-Path: <mario@parenteses.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6FCD548D
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 18:39:25 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web10.68867.1695667162238032673
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 11:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@parenteses.org header.s=MBO0001 header.b=kvNRXz9Z;
 spf=softfail (domain: parenteses.org, ip: 80.241.56.172, mailfrom: mario@parenteses.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RvWqn6qyTz9sQm;
	Mon, 25 Sep 2023 20:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parenteses.org;
	s=MBO0001; t=1695667157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHo+OKendmKvIrfvDVPfJyZbsVnwOQqLmMMM/pYwTMA=;
	b=kvNRXz9Z5mhUAktCXnJblPceOHk6N0gG63XRXLZUpreI7wacFZt+AMxqYZHbhlK/atJvfb
	JsBCnPH2A+/LrgGQwm30+erFK9i15fAjyI9Vgt04C/Kh+ULfIjxN3CTlMWLnqbSxVzjFPF
	qrQtEJyhTCNxIy/2IR3wn+BoN26RrO1tdcMrgG0/WUv+8lXoIBNuWXDFGxxwgOyNoLNe6e
	+V0DYaxvmWmM74F5H7Hj2fGAduSizlX5+OeFK1tcqRxctoen+wkltjog/WwhwBdEvnOjxM
	kjGgH9Zqh3nwvY/vstHjl/G5PN6Wgi7IcUi20AeJZ78Jp2FAMs9F264Ajh5KFw==
From: Mario Domenech Goulart <mario@parenteses.org>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
  "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
References: <20230925032246.1316597-1-pkj@axis.com>
	<2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	<DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
	<DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
	<DB5PR02MB1021356A2A4354ED39DB5CD96EFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<4e46959768ee5e6cc6f72a42fa566db267dd5d38.camel@linuxfoundation.org>
Date: Mon, 25 Sep 2023 20:39:16 +0200
In-Reply-To: <4e46959768ee5e6cc6f72a42fa566db267dd5d38.camel@linuxfoundation.org>
	(Richard Purdie's message of "Mon, 25 Sep 2023 17:17:53 +0100")
Message-ID: <87o7hqrtbf.fsf@parenteses.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 18:39:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15123

Hi,

On Mon, 25 Sep 2023 17:17:53 +0100 "Richard Purdie" <richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2023-09-25 at 16:00 +0000, Peter Kjellerstedt wrote:
>> > -----Original Message-----
>> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > Sent: den 25 september 2023 16:07
>> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-
>> > devel@lists.openembedded.org
>> > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output
>> > anything with --value and undefined variable
>> > 
>> > On Mon, 2023-09-25 at 13:55 +0000, Peter Kjellerstedt wrote:
>> > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > > > On Mon, 2023-09-25 at 10:16 +0000, Peter Kjellerstedt wrote:
>> > > > > > -----Original Message-----
>> > > > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > > > > > Sent: den 25 september 2023 11:22
>> > > > > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>;
>> > > > > > bitbake-devel@lists.openembedded.org
>> > > > > > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not
>> > > > > > output anything with --value and undefined variable
>> > > > > > 
>> > > > > > 
>> > > > > 
>> > > > > My goal here was not really to be able to determine if the
>> > > > > variable is
>> > > > > defined or not
>> > > > 
>> > > > I know, but that is an important detail and whilst it may not
>> > > > matter to
>> > > > you, it does matter a lot.
>> > > 
>> > > Well, as I see it, with my change it _is_ now possible to make
>> > > the
>> > > distinction if you really care, where before you could only
>> > > assume
>> > > that a returned value of "None" actually meant that the variable
>> > > is
>> > > not defined.
>> > 
>> > As things currently stand it is clear something went wrong through
>> > the
>> > process you yourself mentioned as how noticed. Once your proposed
>> > change merges, it becomes very unclear what is happening.
>> 
>> The documentation (i.e., `bitbake-getvar -h`) for --value states 
>> "Only report the value, no history and no variable name". When I 
>> read that, I instinctly assume that it will not output anything if 
>> I ask for a variable that does not exist, not that it will output 
>> something that looks like a valid value (i.e., "None"), but isn't. 
>
> Please stop trying to convince me the current behaviour is wrong. I've
> said multiple times, I agree. What I don't agree with is how you're
> fixing it.
>
>> I would be fine with an error message to stderr, but then I would 
>> assume the same result if bitbake-getvar is called without --value 
>> for an undefined variable.
>
> I agree with that.
>
>>  I would also prefer if it is possible to silence the error for the
>> case where you do not care if the variable is undefined.
>
> I only agree with this if the user specifically asks for that behaviour
> as I think it is a perfect way to end up with obscure bugs otherwise.
>
>> Whether bitbake-getvar should actually fail with an error in case 
>> the variable does not exist is more debatable. I can see use cases 
>> both ways.
>
> I can see the use case both ways but I think the user has to
> specifically ask for undefined to result in "".
>
>> > I'm not disagreeing that it needs to be fixed somehow we agree on
>> > that
>> > and I've already said as much. What we disagree on is how to fix
>> > it. I
>> > disagree on this way of addressing it.
>> 
>> Based on my comments above, here is my suggestion: 
>> 
>> When an undefined variable is requested, give an error message, e.g.:
>> 
>> $ bitbake-getvar UNDEFINED_VAR
>> The variable 'UNDEFINED_VAR' is not defined! [on stderr]
>> 
>> and set the exit code to 1. And the same result with --value:
>> 
>> $ bitbake-getvar --value UNDEFINED_VAR
>> The variable 'UNDEFINED_VAR' is not defined! [on stderr]
>
> That seems reasonable to me, without the "!" though.
>
>> If -s or --no-messages (borrowed from `grep`) is also specified, then
>> no error message is output and the exit code is 0.
>
> I'd suggest only a long option --ignore-undefined. That way when you
> see it in a shell script, you know exactly what risk is being taken.

How about providing a --default parameter?  The behavior of
bitbake-getvar would then be:

* If the requested variable is defined, print its value and exit zero
  (in this case --default is irrelevant).

* If the requested variable is not defined and --default <value> is
  provided, print <value> and exit zero.
  
* If the requested variable is not defined and --default is not
  provided, exit non-zero.

Rationale:

* The proposed behavior/API allows for:

  * Detecting undefined variables.

  * Controlling when errors should be raised.

  * Using custom fallback values for undefined variables.

All the best.
Mario
-- 
http://parenteses.org/mario

