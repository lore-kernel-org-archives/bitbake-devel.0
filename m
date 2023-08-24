Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D3C3DA6F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 16:03:06 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.1057.1692892984345510650
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 09:03:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=3jBWc3K9;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 91B685C0096;
	Thu, 24 Aug 2023 18:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1692892981; x=1694707382; bh=N4
	YE1Gz7N1SDk+PNuyOtgX0L29b/jh8Mci9o0H0Ts88=; b=3jBWc3K9kpzFEGj7Vk
	ntTxgeScN92GPxD/dxEMILWSE887RvRsDbnY9iRZK2m39EsOWMc2srzVfN37flrJ
	jD12iYXfWP9r0X5qicmY4v3TbuXVTIQ9O1+vDu6WmhODC0aprwD9GOL5qA6Uf8JX
	PjXB83BN2pdKFRQtKU41M72E8=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RmO7vnW3ytbz; Thu, 24 Aug 2023 18:03:01 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 4DF3E5C0095;
	Thu, 24 Aug 2023 18:03:01 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2023 18:03:01 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
 carlo@piana.eu, luca.ceresoli@bootlin.com, peter.kjellerstedt@axis.com
Subject: [PATCH v4 3/3] fetch2: Add tests for upstream source tracing
In-Reply-To: <20230824155655.448755-1-alberto@pianon.eu>
References: <20230824155655.448755-1-alberto@pianon.eu>
Message-ID: <d7e3529a7651f009a557ba2449ae95a4@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 16:03:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14978

Hi,
I submit this third patch by just sending the link to the commit, since 
the patch contains some big compressed JSON files that would be too 
large for an email message. From reading tests and test data, you may 
get what is the final goal/result of this series of patches.

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace3&id=43707aefb22c59a6508af04c02219423f42806ba

This series of patches works also with the new format of 
npm-shrinkwrap.json files, supported by the latest revision of the npmsw 
fetcher. I included a specific test case also for that one.

Cheers,
Alberto

