Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8EC7EE2D
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 18:38:43 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web10.2643.1677523121769006955
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 10:38:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=arVR3IZT;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5ADAE100004;
	Mon, 27 Feb 2023 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677523119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSxH9bNB2OP0TtV0+CaS4BzlQsdzdKdy9WzxO7w8rFc=;
	b=arVR3IZTuXInBGcswCALV/yq+lRNO8CHHvtnzxbQZHp+/TgrYqU2z3cZVICxqBpyAxs4Hb
	X0pTu55m0l4tGrTJGhFl1q3DYcG8e84lWVf7WRlih+jtC+0VvxUgvgSvNkhr8rxDDNEqcS
	RXpBdAtLM4lceDWU/rw7gb2MCkZ0tHv7OLPqAUCjEFDD+JKVMoucaANvqjSmb0tyZEeUve
	4OU1RSOntuy0m9GOoBZtouXJFuMdUAI1sbyZgL7wFqwuAfe3xZTaVtraFzENXMXYEEsuxZ
	T1tpI7ix9nm/oXkUcLtHteA4z6pr5xEYa74s97fOk/G2Aq8O9TtPRZDhX7qGaw==
Message-ID: <808f2823-0454-bca2-f84b-c1a5748ab21e@bootlin.com>
Date: Mon, 27 Feb 2023 19:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] bitbake-user-manual: fix reference to "Obtaining
 BitBake" section
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <1747C11CB08A98CF.5262@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <1747C11CB08A98CF.5262@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 18:38:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14505


On 27.02.23 at 19:14, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> The section making this reference was making a reference to itself
> instead of referring to the section in bitbake-user-manual-intro.rst.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> index 722dc5a2..ccaef5f8 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> @@ -18,7 +18,7 @@ it.
>   Obtaining BitBake
>   =================
>   
> -See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
> +See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for


Oops, forget this patch. I realize it was already fixed in Fawzi 
Khaber's patch for this file.
Apologies for the noise.

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


