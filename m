Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00716C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 12:58:49 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.14591.1714481924733417360
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 05:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=EqJr5gmk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 770EDE000B;
	Tue, 30 Apr 2024 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714481923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwZBew48pyfXPISn4GI+NcVAZ1XB1+ZdePVh1VwUcvg=;
	b=EqJr5gmk5zguyGJ8ScEj3/Uwns7vkYGgPHz3PJIKuzRGdKYv5dygaS2BWB4+/GJbJGXnWw
	15VrzO56J7llKNFdhaY42N0RYa53W+W46vDCmfdERJaZJe90ur/WFejfzFfyndyj40CfHW
	TyfEbimZOiYHgMsSI802Iai1D0N9nB78l6O6ZhivjcnZm3FcMm+sjUq7SSGvJAa3maQmpS
	nYdWD4fG1j9R0+JWMNgBctfu+N3YVgedARdBHhOvGe6PHldii6S0PpYiw1D9jMOHda8Xr4
	MtUFAY98EZWQFZkl3UPTFOzIV+Ny5Vgbb1QeqBYm3vuTexaWY/VmksU7JBL4dg==
Message-ID: <56222882-76c9-44ab-9a20-237a1293489b@bootlin.com>
Date: Tue, 30 Apr 2024 14:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 4/5] prserv: enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-5-michael.opdenacker@bootlin.com>
 <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 12:58:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16161

Hi Joshua

Many thanks for the review and guidance. See my comments and questions 
below.

On 4/29/24 at 22:34, Joshua Watt wrote:
>> +        with closing(self.conn.cursor()) as cursor:
>> +            if self.read_only:
>> +                table_exists = cursor.execute(
>> +                            "SELECT count(*) FROM sqlite_master \
>> +                            WHERE type='table' AND name='%s'" % (self.table))
>> +                if not table_exists:
>> +                    raise prserv.NotFoundError
> This is a race if you run the read-only server first, which seems like
> a bad user experience. I'd probably create the table even if the
> server is read-only (I'm pretty sure hash server works this way also)


Fixed. Thanks.

>
>> +            row = data.fetchone()
>> +            if row is not None:
>> +                val=row[0]
>> +            else:
>> +                #no value found, try to insert
>> +                try:
>> +                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
>> +                               (version, pkgarch, checksum, value))
>> +                except sqlite3.IntegrityError as exc:
>> +                    logger.error(str(exc))
> You probably want to make this whole SELECT / INSERT block a loop, and
> instead of repeating the SELECT below, retry the loop on an integrity
> error. The only reason you should be getting an integrity error is if
> you have a race between multiple servers accessing the database at
> once. In that case, looping back and trying to fall out in the
> previous SELECT is better.
>
> This is especially important if you delete entries in the database, as
> in pathological cases you might have to loop several times before you
> fall out of the loop (although typically, you would only need to retry
> once).
>
> I'd recommend this paradigm any other places you do SELECT / INSERT
> where the INSERT depends on the SELECT.

This is actually coming from the prserv legacy code, which I haven't 
really touched yet.

Is this kind of event really expected to happen with sqlite3? I see that 
hashserve only checks for "sqlite3.IntegrityError" once, so maybe it's 
too pessimistic to anticipate errors here... Do we also want to support 
multiple builders accessing the same PR database?

Anyway, if I really have to do it, I guess I'd also have to do it in the 
store_value() function which currently just logs an error without 
retrying. But if we loop, doesn't it add the risk to create an endless 
loop?

Cheers,
Michael.

-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


