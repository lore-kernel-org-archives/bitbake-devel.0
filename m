Return-Path: <martin@mko.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAABC433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 10:26:51 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web09.43193.1636367209784632333
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 02:26:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mko.dev header.s=mail header.b=jwO0yNvn;
 spf=pass (domain: mko.dev, ip: 116.202.209.171, mailfrom: martin@mko.dev)
Message-ID: <5538dd6d-94df-af1f-8141-4d6b63f119d1@mko.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mko.dev; s=mail;
	t=1636367206; bh=4s5SLwBziC+FHsFhq3kJaGN3woehiawCnrkbDAtE+E4=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=jwO0yNvncwsi7w3G8E1X1mmvjPk0bT0pOAPfUtnFeQuvf1HNCnXIW4rk7+mnZGezF
	 lK2kLRc46WUKKQl49aLFOyNNSyNcz4s1HaJ5v48XHu42kV/7L4JfHAlk8V0I2sx+ht
	 6/G8xgKV0G/puEcB1UuNPRQi0aGN4GMA17GzwKvd5/ej67Xg6IIirqRx5x5hegCmy8
	 OebyiYgRfCT/NU/7oNpeE5tZhsMk008LdnB54tHZ47RbQo1kuQh5Ayusulwy3Uuf8F
	 z9/piC4nDEAZ/awYCT8N9fU8JRR3iau8yRQzrB902d7jmA3iov+g2UWhMJgsKqywAn
	 aG3awqnbhRdMg==
Date: Mon, 8 Nov 2021 11:26:46 +0100
Mime-Version: 1.0
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch2: Fix race condition in
 latest_revision
Content-Language: en-US-large
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Daniel.Baumgart@iris-sensing.net,
 openembedded-core@lists.openembedded.org,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
References: <20211105133048.19879-1-jasper@fancydomain.eu>
 <20211105133048.19879-2-jasper@fancydomain.eu>
 <cf04f6c310491ca861ce5073dc14554bcba99ebc.camel@linuxfoundation.org>
From: Martin Koppehel <martin@mko.dev>
In-Reply-To: 
 <cf04f6c310491ca861ce5073dc14554bcba99ebc.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 10:26:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12933

-- snip
> I'm afraid I don't understand why this is a race condition? Where is the timeout
> that stops one being set?

The commit message is misleading here, will change that. It is actually 
not a race condition as we originally thought, but more a problem of 
recursive calls to _latest_revision.

The git fetcher does something similar in _lsremote, where the git 
lsremote would be called recursively to populate the environment, and 
there's code in place to prevent that.

In our case, since we persist the revs, we have to filter out empty revs 
because otherwise the next repo fetcher invocation would also try to 
populate the environment but then revs[key] would already be set to an 
empty string, causing a metadata mismatch later.

Therefore we only populate the revision cache if _latest_revision 
actually returns a valid value.
We did reproduce this with multiple recipes that used up the same 
SRC_URI and therefore influencing each other, this case works fine now.

Cheers,
Martin


