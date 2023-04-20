Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD46C77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 10:30:47 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.4605.1681986644752421530
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Apr 2023 03:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=ImMQbIKC;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id CE24F5C0096;
	Thu, 20 Apr 2023 12:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1681986641; x=1683801042; bh=A0
	qgrQoULT8pQXCQyJ8YsKmE+3og1v59/RZbTBiO9wQ=; b=ImMQbIKC4tTilhZTVP
	9G0LjbQILqc+L5d6RgP6iE+4nrlzOEpJKJ8TgngJa/Y8Br9G1imX2OmlPg1xSA0q
	qt+z40RezCP3UnHPfh/rzfU8id165sNQgc+TS28ZHxawogQTq/1xAZoDu4sVTfl1
	v0f9AwqPht2Xkam4xRhXZPl3E=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fSn2hk8xU7fb; Thu, 20 Apr 2023 12:30:41 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 000365C0095;
	Thu, 20 Apr 2023 12:30:40 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2023 12:30:40 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: base process
 (patch 1/3)
In-Reply-To: <20230420105624.12f67d72@booty>
References: <20230420062024.134035-1-alberto@pianon.eu>
 <20230420105624.12f67d72@booty>
Message-ID: <c0728e2088b793ba5438c4cdde8833f7@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Apr 2023 10:30:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14725

Hello Luca,
thanks for your suggestions, I will definitely try to follow them, 
re-submitting the patches.
Best,
Alberto


Il 2023-04-20 10:56 Luca Ceresoli ha scritto:
> Hello Alberto,
> 
> thanks for your patches!
> 
> I'm not going into the details of the implementation but I have a few
> comments on formal aspects.
> 
> First, I would recommend to remove the "(patch 1/3)" from the subject,
> or it will be part of the final commit message when applying the patch
> using 'git am'. This is something that won't make sense later on, when
> one will look at the git history. 'git format-patch origin/master' will
> generate patches with an appropriate header for you, and for patch 3
> which is special you can do a manual handling but still keep the
> standard format: "[PATCH 3/3] ...commit title..."
> 
> On Thu, 20 Apr 2023 08:20:24 +0200
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
>> This series of patches provides a solution to the issue by 
>> implementing
>> a process that unpacks each SRC_URI element into a temporary 
>> directory,
>> collects relevant provenance metadata on each source file, moves
>> everything to the recipe rootdir, and saves metadata in a JSON file.
>> 
>> The proposed solution is split into a series of patches, with the 
>> first
>> patch containing required modifications to fetchers' code and a
>> TraceUnpackBase class that implements the process, and the second 
>> patch
>> implementing the data collecting logic in a separate TraceUnpack
>> subclass. The final patch includes test data and test cases to
>> demonstrate the solution's efficacy.
> 
> Your comment is identical for patches 1 and 2. Instead a commit message
> should describe what the single patch/commit does. Being this a pretty
> complex patch set you certainly can include a couple lines giving the
> big picture, but the bulk of the text should really be about _why_ we
> need the patch, and also about _what_ it does in case it is not obvious
> from the diff.
> 
>> 
>> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
>> ---
>>  bin/bitbake-selftest        |   1 +
>>  lib/bb/fetch2/__init__.py   |  57 +++++++-
>>  lib/bb/fetch2/crate.py      |   2 +
>>  lib/bb/fetch2/gitsm.py      |  24 +++-
>>  lib/bb/fetch2/hg.py         |   1 +
>>  lib/bb/fetch2/npm.py        |   1 +
>>  lib/bb/fetch2/npmsw.py      |  26 +++-
>>  lib/bb/fetch2/trace_base.py | 254 
>> ++++++++++++++++++++++++++++++++++++
>>  lib/bb/tests/trace_base.py  | 227 ++++++++++++++++++++++++++++++++
>>  9 files changed, 584 insertions(+), 9 deletions(-)
>>  create mode 100644 lib/bb/fetch2/trace_base.py
>>  create mode 100644 lib/bb/tests/trace_base.py
>> 
>> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
>> index f25f23b1..6d60a5d2 100755
>> --- a/bin/bitbake-selftest
>> +++ b/bin/bitbake-selftest
>> @@ -31,6 +31,7 @@ tests = ["bb.tests.codeparser",
>>           "bb.tests.runqueue",
>>           "bb.tests.siggen",
>>           "bb.tests.utils",
>> +         "bb.tests.trace_base",
>>           "bb.tests.compression",
>>           "hashserv.tests",
>>           "layerindexlib.tests.layerindexobj",
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 1a86d8fd..96a7c7b0 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -27,6 +27,10 @@ import bb.persist_data, bb.utils
>>  import bb.checksum
>>  import bb.process
>>  import bb.event
>> +try:
>> +    from .trace import TraceUnpack
> 
> The trace module is introduced in a later patch, which is not very good
> practice as the git history would not be bisectable. Commits should
> first introduce basic components, and later commits should start using
> them, and in case there is a good reason to not do so, they should be
> merged in a single commit.
> 
> Best regards,
> Luca

