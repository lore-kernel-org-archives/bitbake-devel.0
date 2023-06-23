Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84EAEB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 10:11:24 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.38807.1687515078495666135
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jun 2023 03:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=S7Y5f28u;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687515076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr4l9lOvfHlLJxwekwqaQqycPsrfcjIhFUDTRuq/kJk=;
	b=S7Y5f28uwnU/jlr0SGf2z7SAxzgdk9O8Z/aVmkz66FHItFLfTsfLPC+xgYsSi11YpEWmrE
	4m3giVhCVVORmZIeSq9cUS5GvCpo7k+6SQLZbk0dzNPOg5asezdbrwcMdSoMdPLLSa0bNf
	41dWCML8/93PlFxEN0d5xMTyIoDXSGPr4srnQCIz7LghJT+UM0ThiYOz+2PBwgSh8E7Bwu
	CU5kfSChuzyZduVqXOIxpkky4syClWKTxYWn9wYfWSgeQvLQGKy/uEzsu019US2O918Pta
	2ycxiwlzR74ntUS4VGBY68uHFPnPd3gupAIOlGQWSOQMfBPwUtdWi2PkWZT9Ow==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADE0C4000F;
	Fri, 23 Jun 2023 10:11:15 +0000 (UTC)
Message-ID: <861e6ff6-c43b-8ee4-497b-ae8a128f4885@bootlin.com>
Date: Fri, 23 Jun 2023 12:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [bitbake-devel] [PATCH] docs: bitbake-user-manual:
 bitbake-user-manual-hello: add links and highlights for variables
Content-Language: en-US
To: quentin.schulz@theobroma-systems.com, bitbake-devel@lists.openembedded.org
References: <20230622-typos-202306-v1-1-dce56bcb2f37@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230622-typos-202306-v1-1-dce56bcb2f37@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jun 2023 10:11:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14858

Hi Quentin,

On 22.06.23 at 18:48, Quentin Schulz via lists.openembedded.org wrote:
> Some variables are described in the glossary so add a term role to the
> references. For the others, highlight them by surrounding them with
> two backticks.
>
> Cc: Quentin Schulz <foss+yocto@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> index c8251d2a0..654196ca2 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> @@ -209,12 +209,12 @@ Following is the complete "Hello World" example.
>   
>       .. note::
>   
> -       Without a value for PN , the variables STAMP , T , and B , prevent more
> -       than one recipe from working. You can fix this by either setting PN to
> +       Without a value for :term:`PN`, the variables :term:`STAMP`, :term:`T`, and :term:`B`, prevent more
> +       than one recipe from working. You can fix this by either setting :term:`PN` to
>          have a value similar to what OpenEmbedded and BitBake use in the default
> -       bitbake.conf file (see previous example). Or, by manually updating each
> -       recipe to set PN . You will also need to include PN as part of the STAMP
> -       , T , and B variable definitions in the local.conf file.
> +       ``bitbake.conf`` file (see previous example). Or, by manually updating each
> +       recipe to set :term:`PN`. You will also need to include :term:`PN` as part of the :term:`STAMP`,
> +       :term:`T`, and :term:`B` variable definitions in the ``local.conf`` file.
>   
>       The ``TMPDIR`` variable establishes a directory that BitBake uses
>       for build output and intermediate files other than the cached
> @@ -319,9 +319,9 @@ Following is the complete "Hello World" example.
>   
>       .. note::
>   
> -       We are setting both LAYERSERIES_CORENAMES and LAYERSERIES_COMPAT in this particular case, because we
> +       We are setting both ``LAYERSERIES_CORENAMES`` and :term:`LAYERSERIES_COMPAT` in this particular case, because we
>          are using bitbake without OpenEmbedded.
> -       You should usually just use LAYERSERIES_COMPAT to specify the OE-Core versions for which your layer
> +       You should usually just use :term:`LAYERSERIES_COMPAT` to specify the OE-Core versions for which your layer
>          is compatible, and add the meta-openembedded layer to your project.
>   
>       You need to create the recipe file next. Inside your layer at the
>
> ---
> base-commit: 0556c7bdc82cf665faa141989f2e07dd59517735
> change-id: 20230622-typos-202306-00945b0f2a25


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


