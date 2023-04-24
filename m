Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6FDC7618E
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 10:41:51 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.47528.1682332908861079295
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Apr 2023 03:41:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=zV1AMnsA;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 459A15C0096;
	Mon, 24 Apr 2023 12:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682332905; x=1684147306; bh=96
	T9+iNljUBAaWJvfWotbPrv5T/TF/SGFKL6FWvGaU8=; b=zV1AMnsAXutjetuFBK
	T1n2Xb9bXAKrzI2M+S++5AG16/CmBQWgEtYRUkk4YiEFSNfcvoB6rD89Z2bblsqK
	hWqwG7FnZ6ezZE1j+bsFHhMPC2MfCEvHiOuc68aveVI1Uku1jYLmTgnvUkpd5dy9
	Eckzu5tWUqvzY1SksW0eXdjTI=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SgJcRZXa_ems; Mon, 24 Apr 2023 12:41:45 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 698DE5C0095;
	Mon, 24 Apr 2023 12:41:45 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2023 12:41:45 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu,
 luca.ceresoli@bootlin.com, peter.kjellerstedt@axis.com
Subject: Re: [bitbake-devel] [PATCH v3 1/3] fetch2: Add support for upstream
 source tracing
In-Reply-To: <ZEZIwF3cCgdkOuG2@nuoska>
References: <20230423060143.63665-1-alberto@pianon.eu>
 <ZEZIwF3cCgdkOuG2@nuoska>
Message-ID: <f298a6d0a5f2700cd2c534531c760525@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Apr 2023 10:41:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14745

Hi Mikko,

thanks for your feedback.

On 2023-04-24 11:15 Mikko Rapeli wrote:
> Hi,
> 
> On Sun, Apr 23, 2023 at 08:01:42AM +0200, Alberto Pianon wrote:
>> From: Alberto Pianon <alberto@pianon.eu>
>> 
>> License compliance, SBoM generation and CVE checking require to be 
>> able
>> to trace each source file back to its corresponding upstream source. 
>> The
>> current implementation of bb.fetch2 makes it difficult, especially 
>> when
>> multiple upstream sources are combined together.
> 
> No comment to the patch itself, which seems to create a way to capture
> checksums of recipe source files which can be mapped to SRC_URI 
> entries.

Not only to SRC_URI entries but to actual upstream download locations,
especially for file:// SRC_URIs (which are local, but they usually have
an upstream source such as a git repo) and for npmsw:// and gitsm://
SRC_URIs (a single SRC_URI may map to multiple download locations).

To grasp a better idea of the final result, you may have a look at
(compressed) test data in the last patch, and at the corresponding
test cases in TraceUnpackIntegrationTest:

http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace2

> Would be nice to have this as an optional feature though, unless the
> performance impact on builds is close to zero. Measurements?
> 

bitbake core-image-full-cmdline on a 16-core 32GB-ram VM, using an 
existing
download cache (to avoid differences due to network performance) took
41m57.043s without the patches, and 42m26.727s with the patches. That's
roughly 30s more; IMHO it seems acceptable.
Keep also in mind that source tracing is done only once and then data 
should
be stored somehow in sstate-cache (WIP).
BTW the thing would require some more performance testing in an adequate
testing infrastructure, could you (or others) help in this respect?

> But I see no connection toe CVE checking? The problem I have is that
> I've seen SPDX and SBOM things sold as solutions to CVE checking while
> in reality they have done nothing. Yocto has cve-check.bbclass which
> uses PN/CVE_PRODUCT and PV/CVE_VERSION to query data from CVE database
> and to generate reports about affected, patched and unpatched CVEs,
> which then also include info from patch files (CVE number, if any)
> and list of ignored CVEs from recipe metadata.
> 
> Even if SRC_URI can be split to individual entries, and each file in
> soure tree can be mapped to exact SRC_URI entry, then what's the link
> to CVEs?
> 
> CVEs don't map to SRC_URI entries even if they in theory could. CVEs
> don't map the exact source file checksums. Multiple versions of a 
> source
> file can be mapped to be affected by a CVE they contain the same bug,
> which is usually encoded in CVEs as SW component name and upstream
> release version range. The SRC_URI entry SW component name and version 
> are not
> added in this patch, and the CVE metadata about ignored and patched 
> CVEs
> are not exported, so I don't see any links to CVEs.

Actually the commit message could be improved in this respect. Being 
able
to get upstream download locations (especially with recipes mixing 
multiple
upstream sources, and with gitsm and npmsw fetchers) is a pre-condition 
to
identify the relevant components and therefore do CVE checks, but CVE 
checks
as such are not covered by the patch. I may clarify that.

For example, a possible improvement in this respect could be to 
calculate not
only download locations (SPDX), but also purls 
(https://github.com/package-url/purl-spec),
which may be used to do CVE checks against commercial or, even better, 
open
databases (such as VulnerableCode https://www.nexb.com/vulnerablecode/).

Cheers,

Alberto

