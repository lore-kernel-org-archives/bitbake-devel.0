Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A39C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 08:29:27 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.10326.1714465766015230341
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 01:29:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ppiefbUn;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEA46C000F;
	Tue, 30 Apr 2024 08:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714465764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy2d+VGHzSLuEfS0aS51E42qHjK6eWMhwTU6nqDJQcw=;
	b=ppiefbUnYU0oHhvDqZsYy+4rg8mR3+bsCdZ+RVW6QLq9Co4EoUP/Lst81xa3w3EHnnVX9b
	bYrYFMQzMVZh3vjhPFykLHocEgcDiifJPtAsALSi2E6Kw6KyWWLXQIb0zhMPKBlu2LrLEN
	88J8P+GcUvrUZH/5R4W7p9LEdyTMyNRKgrasYxNDS6E0ZprhQ5bg0NNWzKPw82tuI1RSkr
	lxRUh1SYVIv1IInka0WkKh/kEh2X3cT0vgRifr8WizgjOoQQt1eI5x28YZidOG1Kv02B7m
	MD7aDgAiGEF2On8Mk9N0H3bL4QWeh8v6PMUiV59ZjLzCr52JEJwvcxSLrCU/MA==
Message-ID: <9f60ce91-fccb-45fc-8564-1194802bb805@bootlin.com>
Date: Tue, 30 Apr 2024 10:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/5] prserv: add bitbake selftests
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-6-michael.opdenacker@bootlin.com>
 <CAJdd5GZd-UQ6uQh3m__fU21KGOcMvQbt93zeR2S33DOxi02f3Q@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZd-UQ6uQh3m__fU21KGOcMvQbt93zeR2S33DOxi02f3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 08:29:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16159

Hi Joshua

Many thanks for the review!

On 4/29/24 at 23:08, Joshua Watt wrote:
>> +
>> +class PRBasicTests(PRTestSetup, unittest.TestCase):
>> +
>> +    def setUp(self):
>> +        dbfile = "prtest-basic.sqlite3"
> It's generally considered bad form to dump test files in the users CWD
> and also blindly os.remove() things there :)
>
> In the hash server tests, we create a temporary directory and clean it
> up when the test ends by doing this in setUp():
>
>          self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
>          self.addCleanup(self.temp_dir.cleanup)
>
> Then use self.temp_dir as the base whenever you need a path, e.g:
>
>          dbfile = os.path.join(self.temp_dir, "prtest-basic.sqlite3")

Done! Good catch.
I remember now keeping the database files when I was implementing the 
tests so that I could inspect the databases manually.

At least with this approach, I don't have to remove the database file if 
it exists! This almost makes the code smaller :)
This will be included in my next branch update.

Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


