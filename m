Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5150C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 14:42:53 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.14817.1713364969710560796
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 07:42:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=TZTW/uUZ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DC99FF80C;
	Wed, 17 Apr 2024 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKpOfYw8njkqeJ8NJj3ZKsLS8+hYVwWzy8sdu8IPT9k=;
	b=TZTW/uUZ7ivdVU0UdOoAxBD1FCt+6SQVSQjS163jIbylpf8v10wTWqL4IYjlraQf/FanPN
	8O1k+Sz8XBtjSmQJKHbeCEA5bJIVGRKnpiXI3sPb7UlIorjs0eJSbTbbqAD1hRRGkO2VV6
	Z8RqpT8+TSMv/8ElKmewse458xutx3oMLU5VfItgtMh0egmv949+vwTuK6MGqoQXtAh072
	zwuKAxYUQO6X0KSHG+r+I8fIMYgPyO8xdMoSVyE0B0LtVi+uiXmYnWb1o8c7VOj2JGQPFX
	mPqrmXB9AU/hzJYbtzHGnp4xZaB16+cV1i3fGjLilq+bYLXJJmgrhkSoBU7jGA==
Message-ID: <53386f62-1b33-4f9e-a700-4a33cc9e9a31@bootlin.com>
Date: Wed, 17 Apr 2024 16:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC][PATCH 3/3] prserv: start bitbake selftests
To: bitbake-devel@lists.openembedded.org
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
 <17C6D263417A3CF2.12347@lists.openembedded.org>
 <17C717ED8D67DB97.20815@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C717ED8D67DB97.20815@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 14:42:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16104


On 4/17/24 at 16:34, Michael Opdenacker via lists.openembedded.org wrote:
>> + server.serve_as_process(prefunc=prefunc, args=(self.server_index))
>
> I was missing a comma at the end of "args" in the above line. It 
> should have been:
> server.serve_as_process(prefunc=prefunc, args=(self.server_index,)
>
> Without the comma, the prefunc function was never called and I got no 
> logging.


And worse, the asyncrpc server process didn't get started, though the 
rest of the server was (like creating the database).
My first test is now successful and I can implement many more :)

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


