Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD57C77B76
	for <webhook@archiver.kernel.org>; Sun, 23 Apr 2023 06:07:03 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.22618.1682230015463721933
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Apr 2023 23:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=REyOMbu3;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 454395C0096;
	Sun, 23 Apr 2023 08:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682230012; x=1684044413; bh=4a
	ZNz6HIwxEg1J+FMBkLBJOSniiU5gvuhYjZ9QSv0kU=; b=REyOMbu3+ZRnulmFGB
	OY6uH0ofUN6mpJfflroNjjG5lLy6TpbUte1NGcK0+U78913zqZXpnmG2RmGw8k+b
	EkYm1lNGg3sEFBt5kAdImEelb9KH/e0lfIj91iHfwT78ReIvphwj/TcP3jAh5TZm
	FiwkrS625OAkU10EQji44vKN0=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E2zvSU8FqQ6O; Sun, 23 Apr 2023 08:06:52 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 84A8E5C0095;
	Sun, 23 Apr 2023 08:06:52 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Apr 2023 08:06:52 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
 carlo@piana.eu, luca.ceresoli@bootlin.com, peter.kjellerstedt@axis.com
Subject: [PATCH v3 3/3] fetch2: Add tests for upstream source tracing
In-Reply-To: <17587B0322F0706C.7408@lists.openembedded.org>
References: <17587B0322F0706C.7408@lists.openembedded.org>
Message-ID: <c60ae87138dd2e87e2601ba700fb2f05@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 23 Apr 2023 06:07:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14742

Hi,

as agreed in the last weekly meeting I submit this third patch by just 
sending the link to the commit, since the patch contains some big 
compressed JSON files that would be too large for an email message. From 
reading tests and test data, you may get what is the final goal/result 
of this series of patches.

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace2&id=2477ce1f715dc906376472e9e5e26be66a072962

Cheers,

Alberto

