Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D2C77B78
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:11:20 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.6104.1682061077134590965
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 00:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=YDtKDF77;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 51ACA5C0096;
	Fri, 21 Apr 2023 09:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682061074; x=1683875475; bh=qy
	IbMBvks+BWG8tExjMPp+bMMT9dIQMelrqo4XnoxPk=; b=YDtKDF77zqzxovcOqH
	7pQOaWVGk34g2ANVmouHvvVVy1ApsEaoiauFjQxre4BWCM38mQCDleEkjpG0uxAM
	CH7U5LnjCNl2ooRUGHBiXP8z8X35up0yrtAUq+CFD9fmmM6mNlYl+XUB0dTg2rfm
	ok0KDjoptLrLvG6TAc3nTXdXQ=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7u9RR_NkRuRz; Fri, 21 Apr 2023 09:11:14 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id D37EF5C0095;
	Fri, 21 Apr 2023 09:11:14 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2023 09:11:14 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
 carlo@piana.eu, luca.ceresoli@bootlin.com
Subject: [PATCH v2 3/3] upstream source tracing: tests
In-Reply-To: <20230421070525.333494-1-alberto@pianon.eu>
References: <20230421070525.333494-1-alberto@pianon.eu>
Message-ID: <6e7f7d24293b23e9c3c250fbe59b658b@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 07:11:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14729

Hi,

as agreed in the last weekly meeting I submit this third patch by just 
sending the link to the commit, since the patch contains some big 
compressed JSON files that would be too large for an email message. From 
reading tests and test data, you may get what is the final goal/result 
of this series of patches.

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace2&id=f1aaf9fe1233ad9340bddd129331d33aa6c951d4

Cheers,

Alberto

