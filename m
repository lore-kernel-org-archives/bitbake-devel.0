Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC5CCF9ED
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 19:58:00 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.25844.1727294271881436343
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Sep 2024 12:57:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=G96kAoVA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D7A220004;
	Wed, 25 Sep 2024 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727294269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5k7wifYajkv0WbkI4fQf+87MoflLpcmYeUGH0kkd3U=;
	b=G96kAoVAYiUVwJ1aM9PaKphsfTZ3D/uu5aZCWZGWvCuZ0hUYyN+XXMwjTjghOPnku88M8t
	6SyT7gpqw1r9bl9w61/pZQduOUBGDaauXRh9syTwp3V1mbtoNycmB3IuDbedMIk6FxMJIF
	5Pf304ZdSU/TH3V2hWYGK4rd7Q6iCXm3mP1eNHy4fBA+5EDgiAh1SM7WmjI0NFROUlMi8+
	NjCDQkAjPcqwwDM2sNOe4VIJ/pxfYJXNZwwZnraINlNXMXy/Jmh5CDTQ8hCLqz+wDu3ShI
	AYwsuOmq3CdwLwQsglfA/yfXLc8sEtxmKsXfA0z7y+eo7RIUpoyzjX0ysTwwgg==
Date: Wed, 25 Sep 2024 21:57:48 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [RFC PATCH 4/3 v2] data_smart: remove old
 override syntax check
Message-ID: <202409251957489e611f83@mail.local>
References: <20240924090905.4097-1-kweihmann@outlook.com>
 <GV1PR07MB912042E2A43F852836D065DBA8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR07MB912042E2A43F852836D065DBA8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 19:58:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16601

Please send properly versioned and complete series, don't expect
maintainers to do your work and collected patches send a random times
with random versions.

On 24/09/2024 09:09:08+0000, Konrad Weihmann wrote:
> after the override syntax change is now out in the field for
> a longer time, the expensive check for the old syntax can be
> removed.
> 
> This will save time while parsing, and should be side effect free,
> as variables in the old syntax are simply rendered into
> unapplicable variables.
> 
> A more complete check (e.g. RDEPENDS_${PN} checks) could be implemented elsewhere. as part of a sanity check
> 
> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
> ---
>  lib/bb/data_smart.py  |  9 ---------
>  lib/bb/tests/parse.py | 35 -----------------------------------
>  2 files changed, 44 deletions(-)
> 
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 0523744de..fe4c50740 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -539,15 +539,6 @@ class DataSmart(MutableMapping):
>          return var in self.overridedata
>  
>      def setVar(self, var, value, **loginfo):
> -        if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
> -            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is not None:
> -                info = "%s" % var
> -                if "file" in loginfo:
> -                    info += " file: %s" % loginfo["file"]
> -                if "line" in loginfo:
> -                    info += " line: %s" % loginfo["line"]
> -                bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
> -
>          shortvar = var.split(":", 1)[0]
>          if shortvar in self._var_renames:
>              _print_rename_error(shortvar, loginfo, self._var_renames, fullvar=var)
> diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> index 2da3a2a22..6832952f8 100644
> --- a/lib/bb/tests/parse.py
> +++ b/lib/bb/tests/parse.py
> @@ -132,41 +132,6 @@ DESCRIPTION:${PN}-dev = "${DESCRIPTION} B"
>  PN = "bc"
>  """
>  
> -    override_old_append = """
> -EXTRA_OECONF_append = " c"
> -"""
> -
> -    def test_parse_old_override_syntax_append(self):
> -        f = self.parsehelper(self.override_old_append)
> -        try:
> -            bb.parse.handle(f.name, self.d)['']
> -            self.fail('Pattern should have raised bb.BBHandledException')
> -        except bb.BBHandledException:
> -            pass
> -
> -    override_old_prepend = """
> -EXTRA_OECONF_prepend = " c"
> -"""
> -
> -    def test_parse_old_override_syntax_prepend(self):
> -        f = self.parsehelper(self.override_old_prepend)
> -        try:
> -            bb.parse.handle(f.name, self.d)['']
> -            self.fail('Pattern should have raised bb.BBHandledException')
> -        except bb.BBHandledException:
> -            pass
> -
> -    override_old_remove = """
> -EXTRA_OECONF_remove = " c"
> -"""
> -
> -    def test_parse_old_override_syntax_remove(self):
> -        f = self.parsehelper(self.override_old_remove)
> -        try:
> -            bb.parse.handle(f.name, self.d)['']
> -            self.fail('Pattern should have raised bb.BBHandledException')
> -        except bb.BBHandledException:
> -            pass
>  
>      override_old_valid_append = """
>  do_appendsomething () {
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16598): https://lists.openembedded.org/g/bitbake-devel/message/16598
> Mute This Topic: https://lists.openembedded.org/mt/108625078/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

