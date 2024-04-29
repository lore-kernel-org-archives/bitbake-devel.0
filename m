Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB8C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 20:27:21 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.32787.1714422432835404832
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 13:27:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=izneMqPH;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A44AEFF806;
	Mon, 29 Apr 2024 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714422431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GJYK3PqwiCtjjZlpto4k0JbfTVZZM8sKgDiAsTPMxM=;
	b=izneMqPHtT/VlMaBb5N6EkuKze37kDZ5hplj2DJ5jqwku+k29PRhHqmia+eUzyPAoC+l17
	bZFmIfu+0XQxbbl7WUNeVO1bYoh/wcCXrJPAirEM0ub3D0y4OUqWG3O/wsq7qnsZJPSaQZ
	zyfa9uj0WzFW4sh6a6NtF2yP83QE0hfsdWN7LfxaxOhrC6Sg+4vKwz4QqlxW/eil4ndaI9
	SOQD/uQKwm8xkSII718jCdau1bS9K8DBiiHzkCJ3M+azYmKZrOqVuZYr5ODzNJxDXXT9VS
	qbFdgKE38tNcNq/aMXeETXnLGq+I6/Na9Sjd2PKdLfxKI83gJ3aCTYym+XMf+A==
Message-ID: <6e4bf9bc-c5f9-4d85-9100-3cd1c4f000c2@bootlin.com>
Date: Mon, 29 Apr 2024 22:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Joshua Watt <JPEWhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
 <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org>
 <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
 <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com>
 <CAJdd5GZRt8NXpVhh14-Fnpp4ixfj0XcEZUFjoeg0nqheOpkGYg@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZRt8NXpVhh14-Fnpp4ixfj0XcEZUFjoeg0nqheOpkGYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 20:27:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16155

Hi Joshua,

On 4/26/24 at 19:55, Joshua Watt wrote:
> It has commit() calls also, look in sqlite.py. I frequently forget
> that the cursor doesn't implicitly commit when closed (unlike SQL
> Alchemy, which _does_ do that) :)

Correct, I must have checked the wrong file.

Actually, my code should have all the commit() calls it needs. I put one 
every time a change is made to the database.

However, I still have this very weird issue:

  * NOK: in bitbake-selftests, the tests that use the PR server run
    successfully (except test_3b_readonly, because of the issue), but
    the PR table is empty in the database file (if opened through the
    sqlite3 command line). It seems that the table is only updated in
    memory. It must be so, otherwise the tests wouldn't pass.
  * OK: the only bitbake-selftests that use the DB functions directly
    don't have this issue
  * OK: creating an image with BitBake does create a non empty table in
    the PR database file (cache/prserv.sqlite3)

Would anyone have any clue why?

I've just submitted the latest version of my code if you want to have a 
look or test by yourself:
https://lore.kernel.org/bitbake-devel/20240429201418.657042-1-michael.opdenacker@bootlin.com/T/#t

You can run the bitbake selftests as follows:
bitbake-selftest prserv.tests

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


