Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96EC77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 12:53:02 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.10701.1682081574748347692
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 05:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=nkvsGj+Q;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id DADA25C0096;
	Fri, 21 Apr 2023 14:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682081571; x=1683895972; bh=Rs
	uG9Io3/AZj1SBwQJHajOuaraBsZcxc9stMxSTXXjI=; b=nkvsGj+QtseyF8I8bF
	l/ry/QcF953PSvCpJ6S1CXFOHNt6CdQAjx8rUhzIfPBjujwwFOBi+V4T3CySGtfk
	VlypuLo4FasQQE614fCo16iIElFzuaTkmw8Nyhh9zdYA3hOuu9sxPbi5Y9jluZgB
	qYwNwPz9XdtTI72YvjiL/YBFQ=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ecmoBE80G4Cb; Fri, 21 Apr 2023 14:52:51 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 4656F5C0095;
	Fri, 21 Apr 2023 14:52:51 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2023 14:52:51 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
In-Reply-To: <20230421092803.081e3cd6@booty>
References: <20230421070525.333494-1-alberto@pianon.eu>
 <20230421092803.081e3cd6@booty>
Message-ID: <3afd4fe2d1581be5720508538c0c2287@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 12:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14732

Il 2023-04-21 09:28 Luca Ceresoli ha scritto:
> Hello Alberto,
> 
> On Fri, 21 Apr 2023 09:05:23 +0200
> "Alberto Pianon" <alberto@pianon.eu> wrote:
> 
>> From: Alberto Pianon <alberto@pianon.eu>
>> 
>> License compliance, SBoM generation and CVE checking require to be 
>> able
>> to trace each source file back to its corresponding upstream source. 
>> The
>> current implementation of bb.fetch2 makes it difficult, especially 
>> when
>> multiple sources are combined together.
>> 
>> This patch provides an interface to solve the issue by implementing a
>> process that unpacks each SRC_URI element into a temporary directory,
>> creates an entrypoint to collect relevant provenance metadata on each
>> source file, moves everything to the recipe rootdir, and saves 
>> metadata
>> in a JSON file.
>> 
>> This patch contains required modifications to fetchers' code plus a
>> TraceUnpackBase class that implements the above described process. 
>> Data
>> collection logic should be separately implemented by subclassing
>> TraceUnpackBase, implementing _collect_data() and _process_data()
>> methods.
>> 
>> Splitting the above described solution in multiple patches aims
>> at easing review and merge process, and also at decoupling the
>> development of the data processing logic from the process that enables
>> it.
>> 
>> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> 
> Thank you for having fixed the subject! Now I can apply your patches
> with a clean git commit.
> 
> Do you think the build failures I reported on the v1 series are fixed
> by this v2? If you think so, then I can test v2 on the autobuilders.

No but I'm working on it. Actually, I should have found the problem:
it's just that in some tests WORKDIR/temp is not created so I added
a check to create it if it's not present. I'm testing it, but
oe-selftest is taking forever in my build machine. So far, no error
in the logs...

> 
> Also, I see this patch set is not bisectable as well as v1: you define
> class TraceUnpack in patch 2 and use it in patch 1.
> 

do you mean that:

import TraceUnpackBase as TraceUnpack

in patch 1 is not good, and that I should use just TraceUnpackBase
as a class name/alias in patch 1?

