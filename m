Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0CC54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 14:09:14 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.23453.1709647745265691966
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Mar 2024 06:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jUGqapeB;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F2FF1BF207;
	Tue,  5 Mar 2024 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709647742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhZramMh0hDgx2AG4IofWmY6wKlmcIsjRipYj/CbZs4=;
	b=jUGqapeB9OdSwaXyDFyBGVckEPWQ8MfwgtsBOMPTadLn58kFLSdqJR7RE0pu8b7uTrJvC/
	GaKnIlaukXJHrb4nhWI2g2sc+mYX9fE2iXG4P4vSFtgj9493dq0McV2PBdY8UzdoITUeBa
	9YoR+ti9AnSmwXCtXRFjLCcUWlRQdanO3XDTinVkHnSZoWx5dsckO8oMp193dMcHo1NPg3
	9SclYGN+0837tryKB14vvD+soOEUbczxLIxa8gC3tFXywHzIQDB+fl181sZvgkZXBeKZ5l
	slNXnBx2qO8JWT4Nq0D2pTD1asl8yUk3+VadJTiy0vywOdWJqAa7oQ6nkvWT8Q==
Message-ID: <bc190faa-3feb-4480-a8cc-e14b3cd49c1f@bootlin.com>
Date: Tue, 5 Mar 2024 15:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake: how to create a client to an asyncrpc server from
 another server?
Content-Language: en-US
To: Joshua Watt <jpewhacker@gmail.com>
References: <f1ddb6b8-fd5f-435f-8b20-ef60f62066db@bootlin.com>
 <CAJdd5GZgPcC2Oy+V=+eEq0YAB8R-Z1+31SSySgG8kmOJP2uc8g@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZgPcC2Oy+V=+eEq0YAB8R-Z1+31SSySgG8kmOJP2uc8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Mar 2024 14:09:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15987

Hi Joshua

On 3/4/24 at 20:27, Joshua Watt wrote:
> Michael,
>
> Create an async client instead of a blocking client:
>
>    conn = client.PRAsyncClient()
>
> You'll want to do this anyway because you want to make async calls to
> the "upstream" server. If you use a blocking client it will block the
> entire server process during the call which means the server won't be
> able to process any other clients while waiting for a response.

That was exactly what I needed, thanks! Now, the "upstream" server is 
receiving the connections from my local server. The received requests 
are still invalid (investigating) but this is already a nice leap forward.
Many thanks again
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


