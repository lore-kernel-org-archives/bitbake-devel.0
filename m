Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A024C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 14:34:53 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.14667.1713364491883171823
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 07:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=SI3jOjMW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 994DD1C0003;
	Wed, 17 Apr 2024 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+Tm87zdFR4AtnCBe/jvnSsO3RES1HQwjh+ZuEu34Y4=;
	b=SI3jOjMWjKIXNwlIfjM4/O26+vz6NtN9YNA4J6xIsfkyrcbf9BSeRw+uxrY99V9drtgsbW
	1XFIkuwydB0ku+3u8PsIMpZutmCEsq3jYH1UGr6qPtHPi4J7gbTRm9apZk7ieHTEFrhv5F
	y9SmEUezJfTVRXI2IKQfBid5rBZ1j64BMwWdRuyFY6+zFIBl8D8zopo6TUO7Cm1FXt5aHA
	tPW3wD/3VODrOhKvIUSxqiEsXuqN5NlW7YYo8iUO7INLQuV/Y1zAEC9CdaF5AX65uFqDYz
	hDgqJSC/2hOxbqmv8VB0lYoMk130y1az5vGsV3HkB24dJN8DU3JhtpG7Kw3JVg==
Message-ID: <fc00a4dd-7a56-45fe-b35e-ef3b50a4df9c@bootlin.com>
Date: Wed, 17 Apr 2024 16:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC][PATCH 3/3] prserv: start bitbake selftests
To: bitbake-devel@lists.openembedded.org
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
 <17C6D263417A3CF2.12347@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C6D263417A3CF2.12347@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 14:34:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16103

Greetings,

I eventually found out why I didn't have any logging...

On 4/16/24 at 19:19, Michael Opdenacker via lists.openembedded.org wrote:
> +class PRTestSetup(object):
> +
> +    server_index = 0
> +    client_index = 0
> +
> +    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
> +
> +        self.server_index += 1
> +
> +        if dbpath is None:
> +            dbpath = self.make_dbpath()
> +
> +        def cleanup_server(server):
> +            if server.process.exitcode is not None:
> +                return
> +
> +            server.process.terminate()
> +            server.process.join()
> +
> +        server = create_server(socket.gethostbyname("localhost") + ":0",
> +                               dbpath,
> +                               upstream=upstream,
> +                               read_only=read_only)
> +
> +        server.serve_as_process(prefunc=prefunc, args=(self.server_index))

I was missing a comma at the end of "args" in the above line. It should 
have been:
server.serve_as_process(prefunc=prefunc, args=(self.server_index,)

Without the comma, the prefunc function was never called and I got no 
logging.

Now, I'm studying the server logs :)
Thanks Joshua for the tips!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


