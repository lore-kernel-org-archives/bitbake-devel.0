Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D304EE3F29
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 20:55:46 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web10.1776.1694552144368716942
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 13:55:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=0k98hdMo;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id F0D895C0096;
	Tue, 12 Sep 2023 22:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:subject:subject:from:from:date:date
	:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1694552141; x=1696366542; bh=LU
	iOzwsoawSYoKtszjYTBaYmyxOHL9/m/9TvD0+yeXA=; b=0k98hdMo38sgEm86ys
	wawkB61f7yyTjG4D6EWaoLIWPrq8vhsexP65B1EInWnUmKsXjWeUJGJgYi62ZhTx
	YJ8cRQQbOLYbRZ0SQyOHR03A1EFPQ3AekE+N7Vls1QOaO36TJRz9E9JYZndOiwj6
	eSCEW2gvr9DI5WFcExSq4PNQs=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HdZRooUbbRMn; Tue, 12 Sep 2023 22:55:41 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 5B1365C0095;
	Tue, 12 Sep 2023 22:55:41 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2023 22:55:41 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Bitbake Devel
 <bitbake-devel@lists.openembedded.org>
Cc: 'Carlo Piana' <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Subject: initial idea for hooks needed for source tracing
Message-ID: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 20:55:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15033

Hi Richard,

as I said at today's meeting there is no hurry, but right after the 
meeting I had an idea and I wanted to fix it in my mind and test it 
before losing it :)

It's just a temporary/WIP patch, but it should not be too far from a 
working implementation of the hooks we were talking about:

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace4&id=ecb065e7fe2eece566cd387e24abc3b6079146d8

There is no interference nor modification to the unpack process any 
more, just collection of needed metadata through the urldata object.
Modifications to the core unpack function are minimal and (I hope!) 
straightforward, and there is no fetcher-specific logic in it ant more.

When you find some time, could you please have a look and tell me if 
this may be the right direction?

Thanks!

Cheers

Alberto


