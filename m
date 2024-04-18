Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6DC4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 19:42:14 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.3399.1713469328586581278
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Apr 2024 12:42:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WV3aG02z;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51E8BC0002;
	Thu, 18 Apr 2024 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713469326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GqqEEKWia1bEKT/kUBHlbdAi4UP/7IHD+hdayz5ZciY=;
	b=WV3aG02zMHZkIOIz8fOwFci30oNBrBI6yob+hfm05eryFxLjqqqoWYe6X84jSPM5kl1RBk
	5FXdVYBHPV6AwqkyRvXcByjwjRyLisxcwghotUd9XkY1FU8G4YhcmnZ2L6E/dhdEsPIwIG
	+BftvUxPn3rFLV4+5Ta8DK1JTl4SseJ065UT+2/4Mv6hZ4nl5T3xfB6qugLLm0di398Erj
	z7zXh795SEK6U6mEQZKP5asL98Z1iIrtzrhCCi5dNY3asNO2chQKtCyLOEKJD5g/rbbgzm
	+jJRGM2H+rl8FvydG8LzSQEXx+DSx3aXGFFrj7nxavlcPejh9GBRoqan7J3x8w==
Message-ID: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
Date: Thu, 18 Apr 2024 21:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Language: en-US
To: Joshua Watt <JPEWhacker@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: bitbake-selftest losing sqlite3 database contents!
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Apr 2024 19:42:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16111

Hi Joshua and list.

Maybe you can give me hints on this...

I'm currently implementing bitbake-selftests for the PR server. I've got 
my first series of tests working, inserting several values into the 
database and then making queries to check that the stored values are 
correct.

However, for the second series of tests, I want to start from the 
sqlite3 database file from the first series (prtest-basic.sqlite3), and 
this time use it to start the server in read-only mode. However, the 
table is empty when I open it!

This is confirmed by making an SQL query from the command line:
$ sqlite3 prtest-basic.sqlite3
SQLite version 3.37.2 2022-01-06 13:25:41
Enter ".help" for usage hints.
sqlite> select * from PRMAIN;
sqlite>

What could explain that the stored PR data are not flushed to the 
database file during my tests, but I have no such issue when I make an 
image with BitBake?

I also changed the prserv/db.py file to run:
self.connection.execute("PRAGMA synchronous = NORMAL;")
self.connection.execute("PRAGMA journal_mode = WAL;")

However, that didn't help.
Any clues for debugging this?
Thanks in advance
Cheers
Michael.


-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


