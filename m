Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222DC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 12:35:22 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.17184.1713875716682508144
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 05:35:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pWhMAslx;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59C40C0005;
	Tue, 23 Apr 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713875714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZG5qpInW67rxzfVdTm5zFVkU9Gi4TwVR5uz8ErrVeQ=;
	b=pWhMAslxmwoUAWhQ7TBu4ckXySfEPLXz4YyLXLKsm8xnqBkAqbeNUP6gMvrPfLFdc4wPUO
	9TL7jVzHyoOH7Ao/jrttEyhvIUA+uHVPxbqox8JYyT8vj6vExGDRv8zlDTt5H9y59oq8ic
	S2Mys3nD5VyhnGR3NeCf9Bxrevp4A1v+d7hrFQnH+u4s7RlsHVdnUG5UE6ftNNS7iFC6dU
	nr/DdKWs0UZs6jkUecDr9TP87lga8rRLAVwxClwLUz0cve2EZ0Oidpz0cgq/3V8QO4UnRb
	WwmC4nz3AnojbVxNFcIdLSjJ0Ec+FK8MNm92EaC1Hjv2ezr2k68fwdpv9UdjVw==
Message-ID: <ee1bc3e1-9fcb-48e7-8d64-3461f66c0fb4@bootlin.com>
Date: Tue, 23 Apr 2024 14:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] bitbake-selftest losing sqlite3 database
 contents!
To: Joshua Watt <jpewhacker@gmail.com>
References: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <04d7efd9d4de05d1c3971a733187887708930d7f.camel@linuxfoundation.org>
 <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
 <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 12:35:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16132


On 4/20/24 at 22:35, Joshua Watt wrote:
> I'm not exactly sure what the purpose of the read-only prserv is in
> the first place; based on these requirements, it sort of sounds like
> there isn't anyway to make a read-only server that has actual data in
> it :)
>
> Ostensibly, you should be able to write a test fixture that does
> whatever a real-life PR server installation would do to populate a
> database and then make it read-only. You would then do this process on
> the test database before each test where you needed to test the read
> only functionality. You have to do it for each test because as you
> noticed, you should not ever have "carry-over" in state from one test
> to another. Having carry-over between tests is not a good idea for a
> lot of reasons, which is why the hash server tests are setup the way
> that they are with an empty database for each test.
>
> If you need help figuring out how to do this I'm more than happy to
> talk though how you might do it.

I agree with the approach. It's just that I need to stop the read-write 
server, and start it again in read-only mode, without losing the database.
For the moment, I managed to run read-only tests on the database I 
created "manually", that by testing the database functions, not by using 
a PR server client.

This being said, I now have non empty databases which I could use too 
for read-only tests. No problem to generate one of them at every new 
test series, provided I don't get an empty  database again.

I'll continue later if I can, because my priority before the end of the 
month is the image upgrade tests.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


