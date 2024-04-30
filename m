Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0893C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 08:57:27 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.10636.1714467440998262578
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 01:57:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FcS8VxK4;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECC93C0009;
	Tue, 30 Apr 2024 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714467439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoGuB69WrLDv0OLFanQhmY1lGKd25P5gYkD6DGl+N7s=;
	b=FcS8VxK4NWvy4rIJJ+P+RGfbP/7Ndlkb3aE6yTkqmwjHmLEiiYkhTZxhFKBFS9qhtDXpV1
	Tbh/rFpJCz9SnIzpT4ukYPySNpC3NDZZ0oOvaAet7/bJARnAtW9vuUXjKn1YXx+XNQU8Ek
	jnRN7PCFCvBKCCAR0PHmEcmAixp5cG3/TuiJZWi+FrEif+DbNIEXqt8B7i7SUU4PCR5ddR
	raNvO4k9CIJsyRCyJ6YQKaxXK9vtTE1aIZH/sgmD8a/z1RfhfcfcOB2SvJpfWrxoUnTWo7
	wQg5nj8Oj5ZuHGzURsLGHLd7dYVhRehv732B+iJmqz1CkuMGmAGyIE7YEQKLhQ==
Message-ID: <2245b58e-41b3-49d9-8eb2-d20a95d942a7@bootlin.com>
Date: Tue, 30 Apr 2024 10:57:18 +0200
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
 <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com>
 <CAJdd5GZRt8NXpVhh14-Fnpp4ixfj0XcEZUFjoeg0nqheOpkGYg@mail.gmail.com>
 <6e4bf9bc-c5f9-4d85-9100-3cd1c4f000c2@bootlin.com>
 <CAJdd5GaEuVw+p=aw5D5cw6i1jAwS+eDDRqSF-s_5p4324GEWKA@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GaEuVw+p=aw5D5cw6i1jAwS+eDDRqSF-s_5p4324GEWKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 08:57:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16160

Hi Joshua,

On 4/29/24 at 23:03, Joshua Watt wrote:
> On Mon, Apr 29, 2024 at 2:27 PM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
>> Hi Joshua,
>>
>> On 4/26/24 at 19:55, Joshua Watt wrote:
>>> It has commit() calls also, look in sqlite.py. I frequently forget
>>> that the cursor doesn't implicitly commit when closed (unlike SQL
>>> Alchemy, which _does_ do that) :)
>> Correct, I must have checked the wrong file.
>>
>> Actually, my code should have all the commit() calls it needs. I put one
>> every time a change is made to the database.
>>
>> However, I still have this very weird issue:
>>
>>    * NOK: in bitbake-selftests, the tests that use the PR server run
>>      successfully (except test_3b_readonly, because of the issue), but
>>      the PR table is empty in the database file (if opened through the
>>      sqlite3 command line). It seems that the table is only updated in
>>      memory. It must be so, otherwise the tests wouldn't pass.
>>    * OK: the only bitbake-selftests that use the DB functions directly
>>      don't have this issue
>>    * OK: creating an image with BitBake does create a non empty table in
>>      the PR database file (cache/prserv.sqlite3)
>>
>> Would anyone have any clue why?
> I think it might actually be returning the correct value ("0").
> Remember that each test case starts with a blank database, and I don't
> see any code in that populates anything into the database in that
> test.... so "0" seems like it would be the correct PR value?


Wow, your remark made me understand that the setUp() function is run 
before *every test*, and not only once for each class of tests!
If I merge my read-only tests with the previous ones, making only one 
test, they now work as expected (except for the very last one, maybe a 
bug in my code).

Many thanks! You saved my day :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


