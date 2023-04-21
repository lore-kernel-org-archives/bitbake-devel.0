Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86473C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:28:10 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.6320.1682062087910553594
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 00:28:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NVmsOiL6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E6CCEFF808;
	Fri, 21 Apr 2023 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1682062086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBaeGnu1Cu0W9yFi11m8LIOYw1CpqQDnpTyN1aFouKw=;
	b=NVmsOiL6oqKa2tLKr/p2VhVMJ2QZTvWfjwPTobUK/bRc/kRxReeLvz0Itk5LgDvaCL+uJ2
	ZtiP6gvBl63uBAAhm3TwA5I9TDmlnAq6hirg64GjtmSRU7yZ/SPdGES3ip5DJCctK+WQ0m
	90iWuRtv53OWTzsMOQwuyYE0NkaLpUuFXV5UAShjkJko3BGuL+8Q1qI8a4DT9uZPZv/slo
	Pv7hQFXCCcSZELGjeMsOir147L9kbkBbH6ew/jf/r1K7e9FyDG37DKwkSmQjWUAwakAiWz
	omMRWQiIiDKLaNfTCTZTevYdg0TXYT0CGfo/W4mYTGnzA30ANISNYj3wXdQXug==
Date: Fri, 21 Apr 2023 09:28:03 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Alberto Pianon" <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
Message-ID: <20230421092803.081e3cd6@booty>
In-Reply-To: <20230421070525.333494-1-alberto@pianon.eu>
References: <20230421070525.333494-1-alberto@pianon.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 07:28:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14731

Hello Alberto,

On Fri, 21 Apr 2023 09:05:23 +0200
"Alberto Pianon" <alberto@pianon.eu> wrote:

> From: Alberto Pianon <alberto@pianon.eu>
> 
> License compliance, SBoM generation and CVE checking require to be able
> to trace each source file back to its corresponding upstream source. The
> current implementation of bb.fetch2 makes it difficult, especially when
> multiple sources are combined together.
> 
> This patch provides an interface to solve the issue by implementing a
> process that unpacks each SRC_URI element into a temporary directory,
> creates an entrypoint to collect relevant provenance metadata on each
> source file, moves everything to the recipe rootdir, and saves metadata
> in a JSON file.
> 
> This patch contains required modifications to fetchers' code plus a
> TraceUnpackBase class that implements the above described process. Data
> collection logic should be separately implemented by subclassing
> TraceUnpackBase, implementing _collect_data() and _process_data()
> methods.
> 
> Splitting the above described solution in multiple patches aims
> at easing review and merge process, and also at decoupling the
> development of the data processing logic from the process that enables
> it.
> 
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>

Thank you for having fixed the subject! Now I can apply your patches
with a clean git commit.

Do you think the build failures I reported on the v1 series are fixed
by this v2? If you think so, then I can test v2 on the autobuilders.

Also, I see this patch set is not bisectable as well as v1: you define
class TraceUnpack in patch 2 and use it in patch 1.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

