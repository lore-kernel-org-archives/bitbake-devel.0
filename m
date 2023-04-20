Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B54C77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 06:25:06 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web10.1954.1681971900614688922
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Apr 2023 23:25:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=0qUM3wtm;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 2FDBD5C0096;
	Thu, 20 Apr 2023 08:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:subject:subject:from:from:date:date
	:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1681971897; x=1683786298; bh=oC
	DEVC+r5U8D3CkFnHD4dKBHRLOgIMk8exJcK71Kiv0=; b=0qUM3wtmcULiUNNTiO
	Yh4vR2pvBqxrsrl4tbWdTl9XfBcctS7FID1ANvKcesKCy/cXt9BLrM77+se1PX4v
	k8gU6SN7MrzthNsZB5VgTx1bNJoL3ld5qb0lOc6JuuM4M6ShoH2cFukBN10GlpSx
	dk2rJhtvb2XmWyU2EnNIVs+DM=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 27NpjEBVFlg5; Thu, 20 Apr 2023 08:24:57 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 9A73C5C0095;
	Thu, 20 Apr 2023 08:24:57 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2023 08:24:57 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Joshua Watt
 <jpewhacker@gmail.com>, 'Carlo Piana' <carlo@piana.eu>
Subject: [PATCH] upstream source tracing: tests (patch 3/3)
Message-ID: <860a2f7354d9d299244da7f8e8ee2b40@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Apr 2023 06:25:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14723

Hi,

as agreed in the last weekly meeting I submit this third patch by just 
sending the link to the commit, since the patch contains some big 
compressed JSON files that would be too heavy for an email message.

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace2&id=5d831407819374c14fbb4ddf298d5c2c7a34283c

Cheers,

Alberto

