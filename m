Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A19FC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 12:53:35 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.13019.1714136008022155181
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 05:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mfu9RENx;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC1D44000B;
	Fri, 26 Apr 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714136006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaZjlItwH8e13DzoV6E1GSav8/o1mRQVI++1+fKrPiA=;
	b=mfu9RENx25xjutWDQOhNKTv0UEFoyYw933ujJnxf66NgfJsHnrJc1vyx+KdIIsHGGziZYd
	YxyPNGDyG/AH8e2o3NFx+MKHBFaeMmmZQdwb7tB00gLy95mqx1QC2aZ68/yzMapPn96VPO
	xCAs/veWb2iEESObhQUpv0LVxfvrRUo1od5iyNRJIzYM6AKq+u0njK/uX4IeBm/zK9oDcS
	QqOTlangSOHWA7GIVPTfrqvCR5XS5iekWpP8byjX5hhNlXw4sDs4Kr48LxBK/7rchAwAz1
	MDcKKL98fEdX7ZgZIq6VDZquXYsGqJD2HSScMSDM2bSav7vAZdecK6QmKrfmbQ==
Message-ID: <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com>
Date: Fri, 26 Apr 2024 14:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
 <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org>
 <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 12:53:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16142

Hi Joshua

Many thanks for the tips!

On 4/24/24 at 16:23, Joshua Watt wrote:
> On Wed, Apr 24, 2024 at 3:20 AM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
>> Hi Joshua
>>
>> On 4/24/24 at 10:15, Michael Opdenacker via lists.openembedded.org wrote:
>>> Which branch did you use to generate your patch? I can't manage to
>>> apply it to either "master", "master-next" or the branch I shared
>>> recently...
>>>
>>> Ah, just found it. You used "nanbield".
>>>
>>> I'll test it in my branch and "torture" it with regular tests and my
>>> new bitbake selftests.
>> Oops, the tests are failing:
>>
>> ======================================================================
>> ERROR: test_0b_db (prserv.tests.FunctionTests)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>     File "/home/mike/work/yocto/poky/bitbake/lib/prserv/tests.py", line
>> 114, in test_0b_db
>>       self.assertTrue(self.table.test_package(version, pkgarch))
>>     File "/home/mike/work/yocto/poky/bitbake/lib/prserv/db.py", line 76,
>> in test_package
>>       row=data.fetchone()
>> sqlite3.ProgrammingError: Cannot operate on a closed cursor.
> Ah right. Ok so instead of doing the cursor operation in the
> _exectue(), you'll need to do it in each API call. The general
> strategy is to do:
>
>   def _importHist():
>       if self.read_only:
>           return None
>       with closing(self.conn.cursor()) as cursor:
>           # Use cursor.execute() for all statements, e.g.
>           row = cursor.execute("SELECT value ....")
>           data = row.fetchone()
>
> You can use the same cursor for multiple queries, so you only need the
> one for each API call (e.g. you don't need to make a new one for each
> execute statement).
>
> With this strategy I don't think you'll ever get DB locking errors, so
> you should be able to eliminate the _execute() wrapper
>
> Just make sure you _always_ use a cursor to execute any database
> queries. It will ruin your day if you combine self.conn.execute() with
> cursor queries :)
>
> The cursor makes your database modifications atomic, that is any
> changes you make to the database aren't applied until the cursor is
> closed, and then they are applied atomically so either all the changes
> you made are commited, or none of them. Keep in mind that this does
> _not_ mean that your database reads are also atomic with your writes;
> if another process commits to the database between your read and write
> (or even between two reads) it's possible you will be dealing with a
> stale understanding of the database when you commit.
>
> Sorry about the nanbield branch, I wasn't paying attention

What you suggest seems to work fine.

By the way, I still had empty databases after leaving the tests, but adding:
self.conn.commit()
after a group or INSERT or UPDATE commands did the trick.

What's strange is that the hashserver code does without doing this.

Anyway, let me test that two servers can access the same database now. 
If everything works, I'll be able to send a V5 soon!

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


