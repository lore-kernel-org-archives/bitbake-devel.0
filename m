Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F9EB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 07:52:45 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.5391.1687247554722958080
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 00:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pO5GKVWh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: luca.ceresoli@bootlin.com)
X-GND-Sasl: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687247552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzeDP4pckFVqX58oydkc8rAYWp/fvkw9AQQEIKKajWI=;
	b=pO5GKVWhnXfhefsv/TaF/FCbtpWXNMDmhklx03vBQWAz1inb5IvS/yKAFzAKbO2W+uEBMe
	O3k++t53X2Pg9L5jEjs6DpfuSYPyHE6sOxoID6wYvSD7/QbhHMCGLmN/JA6PHJwxjDxIbK
	g0EJglZNkWqj1jCKvbI3PWIe7ZvpQIn/XmmpqvVV8ISTSOOoCDU3x93aewFhZf7fcszHvw
	y6OWsWr62yiYgbLcMMdEF9h21koSgfTMIOqUwXZ9rZYaQVkEcwjVJU5NyANB9vA8q5AHoE
	lCavh4aIPrHh3rFz1BNU78CEyQEKP6tQjKL/jLjrYt3cO2kEVUy/oXoF3/JG0Q==
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBB9F1BF20E;
	Tue, 20 Jun 2023 07:52:31 +0000 (UTC)
Date: Tue, 20 Jun 2023 09:52:30 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: explicit variables
 taking a colon separated list
Message-ID: <20230620095230.3847067a@booty>
In-Reply-To: <20230619160614.909233-1-michael.opdenacker@bootlin.com>
References: <20230619160614.909233-1-michael.opdenacker@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 07:52:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14847

Hi Mike,

On Mon, 19 Jun 2023 18:06:14 +0200
"Michael Opdenacker via lists.openembedded.org"
<michael.opdenacker=bootlin.com@lists.openembedded.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> [YOCTO #15128]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 01d4f8d1..ee5d7ba8 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -920,9 +920,9 @@ overview of their function and contents.
>        section.
>  
>     :term:`BBPATH`
> -      Used by BitBake to locate class (``.bbclass``) and configuration
> -      (``.conf``) files. This variable is analogous to the ``PATH``
> -      variable.
> +      A colon-separated list used by BitBake to locate class (``.bbclass``)
> +      and configuration (``.conf``) files. This variable is analogous to the
> +      ``PATH`` variable.
>  
>        If you run BitBake from a directory outside of the build directory,
>        you must be sure to set :term:`BBPATH` to point to the build directory.
> @@ -1165,8 +1165,8 @@ overview of their function and contents.
>        order.
>  
>     :term:`OVERRIDES`
> -      BitBake uses :term:`OVERRIDES` to control what variables are overridden
> -      after BitBake parses recipes and configuration files.
> +      A colon-separated list that BitBake uses to control what variables are
> +      overridden after BitBake parses recipes and configuration files.
>  
>        Following is a simple example that uses an overrides list based on
>        machine architectures: OVERRIDES = "arm:x86:mips:powerpc" You can
> @@ -1225,9 +1225,9 @@ overview of their function and contents.
>           PREFERRED_PROVIDER_virtual/libgl ?= "mesa"
>  
>     :term:`PREFERRED_PROVIDERS`
> -      Determines which recipe should be given preference for cases where
> -      multiple recipes provide the same item. Functionally,
> -      :term:`PREFERRED_PROVIDERS` is identical to
> +      A colon-separated list to determine which recipe should be given
> +      preference for cases where multiple recipes provide the same item.
> +      Functionally, :term:`PREFERRED_PROVIDERS` is identical to
>        :term:`PREFERRED_PROVIDER`. However, the :term:`PREFERRED_PROVIDERS` variable
>        lets you define preferences for multiple situations using the following
>        form::

If I read the docs correctly, PREFERRED_PROVIDERS is not a
colon-separated list but rather a space-separated list [of
colon-separated pairs].

Otherwise looks good, and useful -- thanks!

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

