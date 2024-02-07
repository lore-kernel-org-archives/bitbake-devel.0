Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD7C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:36:32 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.4159.1707345382583205346
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 14:36:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=AVoFH6rB;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 052D540005;
	Wed,  7 Feb 2024 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707345380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trOVqDRRMVkqwNZECi/o3BeySxpjjbIiU6peqfGGXig=;
	b=AVoFH6rBeBRRJnD1exKlyitqqk8ndUgBFvPyEA9vNAqysWUd09E3xAcngyUtpxtEpTqZEa
	Ngzhm+MsiVNLcNQN99V4HcPbmLE8MKRFLEVV/dGmgAb0fc1Y+oW0jm1IH+tACmZEwRPb1w
	zQ1oz1ZpOVWr+5K1j509hjvfbC3YvQ4R0Nnsl5JzlJT90D+A+yzOM8NdtjcbZOZWxMcVJc
	eMqBwakjossZbYIR3xjd7Fcx8pGtAToAL/5Wietqi0hR8UAWB8oUFZmmv2BpJkifFuyZOy
	IdwnWgvmhD3fhvqbs5tdvh7k8kmmpmqA8re3rMv2At7PR1BQWpdJGbqiGZob8A==
Date: Wed, 7 Feb 2024 23:36:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: nvhieudt11@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] Support add-layer to prepend
Message-ID: <202402072236195f1ece48@mail.local>
References: <HOgI.1707132673041693756.jdfH@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HOgI.1707132673041693756.jdfH@lists.openembedded.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 22:36:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15838

Hello,

Your patch doesn't apply, it is missing whitespaces at the beginning of
lines. Can you fix and resend?

Thanks!

On 05/02/2024 03:31:13-0800, nvhieudt11@gmail.com wrote:
> As you know, layer order in BBLAYERS can affect in parsing recipes process,
> in some cases, users want to add a layer on the top of BBLAYERS variable
> 
> So, add "--prepend" option for bitbake-layers to support add-layer to prepend
> 
> Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> ---
> lib/bb/utils.py� � � � | 7 +++++--
> lib/bblayers/action.py | 3 ++-
> 2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 068b631c..086f1cc8 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1412,7 +1412,7 @@ def edit_metadata_file(meta_file, variables, varfunc):
> return updated
> 
> -def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
> +def edit_bblayers_conf(bblayers_conf, add, remove, prepend=None, edit_cb=None):
> """Edit bblayers.conf, adding and/or removing layers
> Parameters:
> bblayers_conf: path to bblayers.conf file to edit
> @@ -1482,7 +1482,10 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
> for addlayer in addlayers:
> if addlayer not in bblayers:
> updated = True
> -� � � � � � � � � � bblayers.append(addlayer)
> +� � � � � � � � � � if prepend:
> +� � � � � � � � � � � � bblayers.insert(0,addlayer)
> +� � � � � � � � � � else:
> +� � � � � � � � � � � � bblayers.append(addlayer)
> del addlayers[:]
> 
> if edit_cb:
> diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
> index a8f26993..57d7195c 100644
> --- a/lib/bblayers/action.py
> +++ b/lib/bblayers/action.py
> @@ -49,7 +49,7 @@ class ActionPlugin(LayerPlugin):
> shutil.copy2(bblayers_conf, backup)
> 
> try:
> -� � � � � � notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
> +� � � � � � notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None, args.prepend)
> self.tinfoil.modified_files()
> if not (args.force or notadded):
> try:
> @@ -267,6 +267,7 @@ build results (as the layer priority order has effectively changed).
> def register_commands(self, sp):
> parser_add_layer = self.add_command(sp, 'add-layer', self.do_add_layer, parserecipes=False)
> parser_add_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to add')
> +� � � � parser_add_layer.add_argument('--prepend', action='store_true', help='Prepend layer directory/directories')
> 
> parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
> parser_remove_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
> --
> 2.43.0

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15823): https://lists.openembedded.org/g/bitbake-devel/message/15823
> Mute This Topic: https://lists.openembedded.org/mt/104173959/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

