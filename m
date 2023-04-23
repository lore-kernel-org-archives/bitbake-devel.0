Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6562C77B73
	for <webhook@archiver.kernel.org>; Sun, 23 Apr 2023 06:50:33 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.22951.1682232630978411651
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Apr 2023 23:50:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=gFQTp0vC;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 316B65C0096;
	Sun, 23 Apr 2023 08:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682232628; x=1684047029; bh=Iq
	UGUCo+yLTv3L7ULSXcF31I6L3CDTgFzud8AS69VI4=; b=gFQTp0vCysgbmDE2AZ
	sZjSIyHBYXnLJsvn87k6rmVUHH9XA9YgVHvgcCElV44gS0tZOs/hOcN/UT0q+MY4
	r+8rp8FivT/oVVXw7+Gk+ldCj4GnjgR50eMAA6Ca3ylvEWDs+dUrCUSVu1it0Vww
	wXD9pWhGwYeVWl/uyXDRp/5Ag=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oKHwZNgSW3u4; Sun, 23 Apr 2023 08:50:28 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 274505C0095;
	Sun, 23 Apr 2023 08:50:28 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Apr 2023 08:50:28 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: luca.ceresoli@bootlin.com
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
In-Reply-To: <20230421181518.23d8a279@booty>
References: <20230421070525.333494-1-alberto@pianon.eu>
 <20230421092803.081e3cd6@booty> <3afd4fe2d1581be5720508538c0c2287@pianon.eu>
 <DB5PR02MB102133408DCA18D8EB0999BEBEF609@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <20230421181518.23d8a279@booty>
Message-ID: <edb210896b744174afb760d294d2a65d@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 23 Apr 2023 06:50:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14743

I tested all patches, they should be OK now (hopefully). I also changed 
subjects following Peter's suggestion.
I just sent them to the ML
Cheers,
Alberto

Il 2023-04-21 18:15 Luca Ceresoli via lists.openembedded.org ha scritto:
> Hello Peter, Alberto,
> 
> On Fri, 21 Apr 2023 13:50:25 +0000
> "Peter Kjellerstedt" <peter.kjellerstedt@axis.com> wrote:
> 
>> > >
>> > > Also, I see this patch set is not bisectable as well as v1: you define
>> > > class TraceUnpack in patch 2 and use it in patch 1.
>> > >
>> >
>> > do you mean that:
>> >
>> > import TraceUnpackBase as TraceUnpack
>> >
>> > in patch 1 is not good, and that I should use just TraceUnpackBase
>> > as a class name/alias in patch 1?
>> 
>> My guess is that Luca missed the `import ... as` line. I believe you
>> should be fine as you are.
> 
> You're right Peter, my review was too quick. Indeed Alberto's patches
> are OK in that respect. Sorry for the noise.
> 
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14734): 
> https://lists.openembedded.org/g/bitbake-devel/message/14734
> Mute This Topic: https://lists.openembedded.org/mt/98405736/1160266
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub 
> [alberto@pianon.eu]
> -=-=-=-=-=-=-=-=-=-=-=-

