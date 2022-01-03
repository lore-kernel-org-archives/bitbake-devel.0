Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5BC433EF
	for <webhook@archiver.kernel.org>; Mon,  3 Jan 2022 16:22:51 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web09.30422.1641226969969402104
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 08:22:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id ABD5CC000F;
	Mon,  3 Jan 2022 16:22:46 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>
Subject: Re: [bitbake-devel] [PATCH] doc: document override style operators
 not working for task dependencies
To: Daniel Wagenknecht <dwagenknecht@emlix.com>,
 bitbake-devel@lists.openembedded.org
References: <20211216152555.815291-1-dwagenknecht@emlix.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <da20e941-ec99-5f58-8c9d-bc4577bf26a1@bootlin.com>
Date: Mon, 3 Jan 2022 17:22:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216152555.815291-1-dwagenknecht@emlix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Jan 2022 16:22:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13211

Hi Daniel,

On 12/16/21 4:25 PM, Daniel Wagenknecht wrote:
> Override style operators do not work for specifying task dependencies.
> This is not obvious and should be highlighted in the documentation.
>
> Signed-off-by: Daniel Wagenknecht <dwagenknecht@emlix.com>
> ---
>
> I have experienced this problem with external layers "in the wild" leading to
> dependencies being undeclared and builds sometimes failing. Additional
> documentation will not necessarily fix the problem, but might make it easier to
> find the problem. I'm not sure if there's also some mechanism in bitbake that
> could detect such mistakes and provide a warning?
>
> CC: qschulz, we talked about this on IRC:
>   https://www.yoctoproject.org/irc/%23yocto.2021-11-30.log.html#t2021-11-30T14:18:08
>
> Sincerely
> Daniel Wagenknecht
>
>  .../bitbake-user-manual-metadata.rst          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index d802a8d3..181c0997 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1689,6 +1689,14 @@ This section describes several ways to declare dependencies. Remember,
>  even though dependencies are declared in different ways, they are all
>  simply dependencies between tasks.
>  
> +.. note::
> +
> +   Override style operators do not work for declaring task dependencies.
> +   See
> +   :ref:`bitbake-user-manual/bitbake-user-manual-metadata:Inter-Task Dependencies`
> +   for details.
> +
> +
>  .. _dependencies-internal-to-the-bb-file:
>  
>  Dependencies Internal to the ``.bb`` File
> @@ -1813,6 +1821,17 @@ must have completed before the ``do_patch`` task can execute.
>  The ``[rdepends]`` flag works in a similar way but takes targets in the
>  runtime namespace instead of the build-time dependency namespace.
>  
> +Note that dependencies are specified via
> +:ref:`bitbake-user-manual/bitbake-user-manual-metadata:Variable Flag Syntax`
> +and thus override style operators do not work for declaring task
> +dependencies. You can add a task dependency for a specific override
> +(e.g. a specific machine) by declaring an intermediary variable and using
> +overrides for setting that variable::
> +
> +   # Does not work: do_compile:machine[depends] += "another_target:do_task"
> +   EXTRA_DO_COMPILE_DEPENDS:machine = "another_target:do_task"
> +   do_compile[depends] += "${EXTRA_DO_COMPILE_DEPENDS}"
> +
>  Functions You Can Call From Within Python
>  =========================================


Thanks for the patch. I believe it could already be merged, and further
improvements remain possible.

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


