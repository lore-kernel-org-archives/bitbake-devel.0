Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB0C25B76
	for <webhook@archiver.kernel.org>; Sat,  8 Jun 2024 10:16:37 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.3938.1717841791492606639
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Jun 2024 03:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=d8hfEC+P;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 324D740003;
	Sat,  8 Jun 2024 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717841789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIzXmjjjr0Iea/PHPEoH/mlhMA0B7gGeRaV/rXin2Ag=;
	b=d8hfEC+POnalHummWQP87RZiPrkSp6u/pcMk3z7IMmndtrO1nXBL6jGrwBH2xhyNr986Eh
	J2YfMBHtyVwxwthRd5JSMbEYRBuknpDaODYmsFg/VvF8spUHz1TEOr3K25EyrElzAQ1AsU
	YQBq2HeN8U7o7Y26AM4bTcYhjOWWfGvURM6BcTTv6XySaC4hioIHJ/Dqw0FGhTFRWlbM+8
	kpmjunuSrWHi9c7XEffi4cXetz29B/y4cCOv5oRqoi7CJsckX63B3Tz6Fb5Z4DadKv+I/1
	BuaT+39jTggRzIgOaQj8U8Eqcy3TgygRUCmLJTRpkcgRUmdMsKoadcBtySORlg==
Date: Sat, 8 Jun 2024 12:16:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] siggen: Drop copy_unihashes function
Message-ID: <202406081016282d36c3ad@mail.local>
References: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 10:16:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16330

Hello Richard,


On 04/06/2024 15:28:02+0100, Richard Purdie wrote:
> The code in OE-Core using this has been replaced with something more fit
> for purpose. Drop these function calls as they were never a great idea in the
> first place and cause IO slowdown for runqueue needing to sync the cache.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/siggen.py | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 92066da00c..89b70fb6a4 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -201,9 +201,6 @@ class SignatureGenerator(object):
>      def save_unitaskhashes(self):
>          return
>  
> -    def copy_unitaskhashes(self, targetdir):
> -        return
> -
>      def set_setscene_tasks(self, setscene_tasks):
>          return
>  
> @@ -418,9 +415,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
>      def save_unitaskhashes(self):
>          self.unihash_cache.save(self.unitaskhashes)
>  
> -    def copy_unitaskhashes(self, targetdir):
> -        self.unihash_cache.copyfile(targetdir)
> -

It breaks sstatetests.SStateBundles.test_minimal_bundle which uses copy_unitaskhashes

>      def dump_sigtask(self, mcfn, task, stampbase, runtime):
>          tid = mcfn + ":" + task
>          mc = bb.runqueue.mc_from_tid(mcfn)

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16316): https://lists.openembedded.org/g/bitbake-devel/message/16316
> Mute This Topic: https://lists.openembedded.org/mt/106483284/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

