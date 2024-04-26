Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89243C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 12:56:55 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.13083.1714136210907014570
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 05:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=S82a3M6a;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9A6B1BF206;
	Fri, 26 Apr 2024 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714136209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKYCLtnWWITXytoumRrv7iaYMyw/BUpW2VPAkDRPP8o=;
	b=S82a3M6a/OfStaCY1RSDfdh5adDG0iwc0xTZ2iKeiw5bDbkjXkJNRfwRQvW0ATlnzfdE8K
	LHQlrvbUqsrWxjjdp2pJyMhp0Ik69o+m1EbMaYyQoHoom1t9eo/awKtFd9cvQPuDrWgxA/
	CizviSXR9iN4j4MPwVZFlEJbmmRANuuWmb4TF+Hf4jZ+pFxos4KLcsP0MxXnZoZ51kS1y2
	SyaRXMoYgGEpWxj4F6Lf9h6EKAmgHVjS+TdExBnp0Oc5TlSo83yCe4cW/3ohSbUWve7Tbl
	ih3YhY3GKyN0Thv36GQcVLpbWpVqB7/69atuijEd8PaN0DueiRJy4hjLMqoejQ==
Message-ID: <f2d334bc-4c26-45cb-9395-0bfc642d74e5@bootlin.com>
Date: Fri, 26 Apr 2024 14:56:48 +0200
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
 <17C9D59E2FED0839.6322@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C9D59E2FED0839.6322@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 12:56:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16143


On 4/26/24 at 14:53, Michael Opdenacker via lists.openembedded.org wrote:
> By the way, I still had empty databases after leaving the tests, but 
> adding:
> self.conn.commit()
> after a group or INSERT or UPDATE commands did the trick.


For the record, my database was created with the below settings:

self.connection.execute("PRAGMA synchronous = NORMAL;")
self.connection.execute("PRAGMA journal_mode = WAL;")

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


