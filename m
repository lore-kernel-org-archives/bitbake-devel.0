Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F08C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 09:13:29 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.16042.1713518003143323530
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Apr 2024 02:13:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=JGqvIYjd;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57C0540004;
	Fri, 19 Apr 2024 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713518000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DJDav0a24Ax80JCZsVlp6o5/9u2aUCIXPGGBlVgjYY=;
	b=JGqvIYjdctM7hkrkXN+O7RJ04uaWy1OcVfZUCtHd6mYyYe87GWuBGmvYSIAS2nFpCVr/6U
	ngRM2LOAq6TSnhQCr4TwyB/8boUQ5fNSXyqDqaB8r9jZwhqchEvv6Fwje7faDOvBgYPTE8
	a0mYW+QrJ7RXREqb4iyqNXYeWHHiwQ/4RTzaScbhlKqD8Mz4OyIZMypAw/fZcPONHdgc8N
	zDaplABh5MOTRxWcc4tJuLG5lKBpj43bi7CR/xDEfGFV4JrFkISOJmCQBE/wgJKFM0i4jt
	Hb7n/BPI72/qUBjC/c+8LZKNhQrtgnBsXq2er/xXj85/siOlBgEpiUxiJ/PcZQ==
Message-ID: <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
Date: Fri, 19 Apr 2024 11:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] bitbake-selftest losing sqlite3 database
 contents!
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Joshua Watt <JPEWhacker@gmail.com>
References: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <04d7efd9d4de05d1c3971a733187887708930d7f.camel@linuxfoundation.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <04d7efd9d4de05d1c3971a733187887708930d7f.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Apr 2024 09:13:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16113

Hi Richard,

On 4/18/24 at 23:04, Richard Purdie wrote:
> On Thu, 2024-04-18 at 21:42 +0200, Michael Opdenacker via lists.openembedded.org wrote:
>> I'm currently implementing bitbake-selftests for the PR server. I've got
>> my first series of tests working, inserting several values into the
>> database and then making queries to check that the stored values are
>> correct.
>>
>> However, for the second series of tests, I want to start from the
>> sqlite3 database file from the first series (prtest-basic.sqlite3), and
>> this time use it to start the server in read-only mode. However, the
>> table is empty when I open it!
>>
>> This is confirmed by making an SQL query from the command line:
>> $ sqlite3 prtest-basic.sqlite3
>> SQLite version 3.37.2 2022-01-06 13:25:41
>> Enter ".help" for usage hints.
>> sqlite> select * from PRMAIN;
>> sqlite>
>>
>> What could explain that the stored PR data are not flushed to the
>> database file during my tests, but I have no such issue when I make an
>> image with BitBake?
>>
>> I also changed the prserv/db.py file to run:
>> self.connection.execute("PRAGMA synchronous = NORMAL;")
>> self.connection.execute("PRAGMA journal_mode = WAL;")
>>
>> However, that didn't help.
>> Any clues for debugging this?
> Most selftests are designed to run in isolation. There is no "run X
> after Y" mechanism since you can specify a single test to run. You may
> need to merge the tests if you need the same database.

Thanks for your help.

Ouch, I'm trying but that looks complicated in my case:

  * It seems I can't open the same database before the end of the test
    with another, read-only server. Anyway, databases are not meant to
    be shared between servers.
  * It's not straightforward  to make a copy of the current database to
    another file. It would be necessary to add a special server and
    database hook for this purpose.
  * I could export the current database, but I wouldn't be able to
    import it into a read-only server.
  * I can't make the current server  turn read-only. I could add a
    client hook to do this, but do we want to allow clients to do this?
  * I want to generate the database I use for the read-only tests,
    because a ready-made one would have to be updated manually every
    time we modify the database contents.

That's why it would have been ideal to reuse a database from previous tests.

Anyway, I'm not stuck and can implement the "upstream" tests anyway.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


