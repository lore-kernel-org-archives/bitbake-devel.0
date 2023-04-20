Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D21C77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 08:56:37 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web11.3505.1681980989599160215
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Apr 2023 01:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=X8SEp/1+;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 358B4100002;
	Thu, 20 Apr 2023 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681980987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTd3Wo4kZBjcJWi+BPaJeLehwarBi+bMOUkpKuCmWx0=;
	b=X8SEp/1+FcGdBNS8ag92IksIZ1P+s0foZVqz0hTr/8BIfIbDOIk5kOdAQBwBkGMZI0fMqN
	DWrDJWxwhYfMjBe5TrSbch9K8ztMW3H65XjV0V8KGizIJnLvLStNnVU+MS1q8HkISox1Kk
	jlJqcZGkLDZ3F3h61nqsO5YgWdvabReMlj1Ekp5Ag5YIA+pTacGM1GswSdYg4F9KySAQyM
	YYxCjH7zQSK0etmPLD/3ZedQ595EWu0E7VPcCmzWxDaoiE4HZL1ZdRgF0h4j2R/UDbIuFN
	XW5qmoqt6IimAyTD5wQbrQUhT+gtIbkPuLUyGnUD335tzCpzQzvawHQmDtJutw==
Date: Thu, 20 Apr 2023 10:56:24 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Alberto Pianon" <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: base process
 (patch 1/3)
Message-ID: <20230420105624.12f67d72@booty>
In-Reply-To: <20230420062024.134035-1-alberto@pianon.eu>
References: <20230420062024.134035-1-alberto@pianon.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Apr 2023 08:56:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14724

Hello Alberto,

thanks for your patches!

I'm not going into the details of the implementation but I have a few
comments on formal aspects.

First, I would recommend to remove the "(patch 1/3)" from the subject,
or it will be part of the final commit message when applying the patch
using 'git am'. This is something that won't make sense later on, when
one will look at the git history. 'git format-patch origin/master' will
generate patches with an appropriate header for you, and for patch 3
which is special you can do a manual handling but still keep the
standard format: "[PATCH 3/3] ...commit title..."

On Thu, 20 Apr 2023 08:20:24 +0200
"Alberto Pianon" <alberto@pianon.eu> wrote:

> From: Alberto Pianon <alberto@pianon.eu>
> 
> License compliance, SBoM generation and CVE checking require to be able
> to trace each source file back to its corresponding upstream source. The
> current implementation of bb.fetch2 makes it difficult, especially when
> multiple sources are combined together.
> 
> This series of patches provides a solution to the issue by implementing
> a process that unpacks each SRC_URI element into a temporary directory,
> collects relevant provenance metadata on each source file, moves
> everything to the recipe rootdir, and saves metadata in a JSON file.
> 
> The proposed solution is split into a series of patches, with the first
> patch containing required modifications to fetchers' code and a
> TraceUnpackBase class that implements the process, and the second patch
> implementing the data collecting logic in a separate TraceUnpack
> subclass. The final patch includes test data and test cases to
> demonstrate the solution's efficacy.

Your comment is identical for patches 1 and 2. Instead a commit message
should describe what the single patch/commit does. Being this a pretty
complex patch set you certainly can include a couple lines giving the
big picture, but the bulk of the text should really be about _why_ we
need the patch, and also about _what_ it does in case it is not obvious
from the diff.

> 
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> ---
>  bin/bitbake-selftest        |   1 +
>  lib/bb/fetch2/__init__.py   |  57 +++++++-
>  lib/bb/fetch2/crate.py      |   2 +
>  lib/bb/fetch2/gitsm.py      |  24 +++-
>  lib/bb/fetch2/hg.py         |   1 +
>  lib/bb/fetch2/npm.py        |   1 +
>  lib/bb/fetch2/npmsw.py      |  26 +++-
>  lib/bb/fetch2/trace_base.py | 254 ++++++++++++++++++++++++++++++++++++
>  lib/bb/tests/trace_base.py  | 227 ++++++++++++++++++++++++++++++++
>  9 files changed, 584 insertions(+), 9 deletions(-)
>  create mode 100644 lib/bb/fetch2/trace_base.py
>  create mode 100644 lib/bb/tests/trace_base.py
> 
> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
> index f25f23b1..6d60a5d2 100755
> --- a/bin/bitbake-selftest
> +++ b/bin/bitbake-selftest
> @@ -31,6 +31,7 @@ tests = ["bb.tests.codeparser",
>           "bb.tests.runqueue",
>           "bb.tests.siggen",
>           "bb.tests.utils",
> +         "bb.tests.trace_base",
>           "bb.tests.compression",
>           "hashserv.tests",
>           "layerindexlib.tests.layerindexobj",
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 1a86d8fd..96a7c7b0 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -27,6 +27,10 @@ import bb.persist_data, bb.utils
>  import bb.checksum
>  import bb.process
>  import bb.event
> +try:
> +    from .trace import TraceUnpack

The trace module is introduced in a later patch, which is not very good
practice as the git history would not be bisectable. Commits should
first introduce basic components, and later commits should start using
them, and in case there is a good reason to not do so, they should be
merged in a single commit.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

