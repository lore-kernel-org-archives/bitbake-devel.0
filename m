Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6DC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 09:33:03 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.8049.1707816777231866661
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 01:32:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gopXlkXA;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECB2A1C0005;
	Tue, 13 Feb 2024 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707816775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7PnkuD+DTTdqN1AVevkkkqOZCb35PxUV11XV1h0BS0=;
	b=gopXlkXAGNr0t2wzyrY0vAJyAM2+Q6ZmUs7tdbpZyZJj7xy5N8ZQY4LmTOwEL47UEuO7e2
	TUWFpTe6zD1ZmuvJYS34ZsbMiVH/9qZiDGu3qzD/4Jqrs0lYO+by6gQA7ubvLeATh/2cmy
	owQbHHBxxI7eTcVdO7IG5DV5RI2kJxrEUA4pa/Sk+uaEp3evcX2jZ1qKE1aIbV5EW/qE64
	jQNwEill/GAPSUBPs07FF/Squu9ucZazMH6dmNoL1HLYhI2qauTd4W/IAyp3B0wJnFtcju
	K28Rmkgv9ULSsIKppWbcKrANFmboL+AhZBCmELs+Y9q/lHV/NoHC3p/WRyRhpA==
Message-ID: <8d232168-57f1-48f2-8932-db3e7dcbc54d@bootlin.com>
Date: Tue, 13 Feb 2024 10:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bitbake: doc: Add section for variable
 context
Content-Language: en-US
To: =?UTF-8?Q?Simone_Wei=C3=9F?= <simone.p.weiss@posteo.com>
References: <20240211104056.85709-1-simone.p.weiss@posteo.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240211104056.85709-1-simone.p.weiss@posteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 09:33:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15883

Hi Simone,

Thanks a lot for the new document. It looks super useful!

On 2/11/24 at 11:40, Simone Weiß wrote:
> From: Simone Weiß <simone.p.weiss@posteo.com>
>
> This is inspired by the same section in the yocto-docs. It aims to provide
> information in what contexts(recipes, .conf, bbclass,...) a variable is usually
> used. For that I tried to group similar variables, so that a short overview is
> given. This was inspired by [YOCTO #14072], but of course does not implement a
> warning if a variable is used in an unintended context.
>
> Signed-off-by: Simone Weiß <simone.p.weiss@posteo.com>
> ---
>   ...bake-user-manual-ref-variables-context.rst | 77 +++++++++++++++++++
>   bitbake/doc/index.rst                         |  1 +
>   2 files changed, 78 insertions(+)
>   create mode 100644 bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
>
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst

Oops, you should generate this patch from the bitbake source repository, 
not from Poky. I managed to tweak your patch so that it applies, but you 
don't want to add extra work on RP's shoulders.

> new file mode 100644
> index 0000000000..9b94e09299
> --- /dev/null
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: CC-BY-SA-2.0-UK
> +
> +****************
> +Variable Context
> +****************
> +
> +Variables might only have an impact or can be used in certain contexts. Some
> +should only be used in global files like ``.conf``, while others are intended only
> +for local files like ``.bb``. This chapter aims to describe some important variable
> +contexts.
> +
> +.. _ref-varlcontext-configuration:
> +
> +#.  **BitBakes own configuration**: Variables starting with `BB_` usually


For the prefix of variable names, I'd use double quotes through out the 
document (here ``BB_``), as you did for "PREFERRED_" at the end by the 
way ;)
This looks more natural to me.

> +    configure the behaviour of BitBake itself. For example, one could configure:
> +
> +    - system resources, like disk space to be used (:term:`BB_DISKMON_DIRS`),
> +      or number of tasks to be run in parallel by BitBake (:term:`BB_NUMBER_THREADS`).

s/number of tasks/the number of tasks/


Another thing is that we usually capitalize the list items, so here it 
would be "- System resources" instead. Could you change this everywhere 
in your patch?

> +
> +    - how the fetchers shall behave, e.g., :term:`BB_FETCH_PREMIRRORONLY` is used
> +      by BitBake to determine if BitBake's fetcher shall search only
> +      :term:`PREMIRRORS` for files.
> +
> +    Those variables are usually configured globally.
> +
> +#.  **BitBake configuration**: There are variables:
> +
> +    - like :term:`B` or :term:`T`, that are used to specify directories used by
> +      BitBake during the build of a particular recipe. Those variables are
> +      specified in ``bitbake.conf``. Some, like :term:`B`, are quite often
> +      overwritten in recipes.
> +
> +    - starting with `FAKEROOT` configure how the fakeroot command is handled.


I would improve this line by writing:

- starting with ``FAKEROOT``, to configure how the ``fakeroot`` command 
is handled.

> +      Those are usually set by ``bitbake.conf`` and might get adapted in a
> +      ``bbclass``.
> +
> +    - detailing where BitBake will store and fetch information from for


s/from for/from, for/

> +      preservation between build runs like :term:`CACHE`, :term:`DL_DIR` or

s/preservation/data reuse/?
This may be more explicit.

> +      :term:`PERSISTENT_DIR`. Those are usually global.
> +
> +
> +#.  **Layers and files**: Variables starting with `LAYER` configure how
> +    BitBake handles layers. Additionally, variables starting with `BB` configure
> +    how layers and files are handled. For example:
> +
> +    - :term:`LAYERDEPENDS` is used to configure on which layers a given layer
> +      depends.
> +
> +    - the configured layers are contained in :term:`BBLAYERS` and files in
> +      :term:`BBFILES`.
> +
> +    Those variables are often used in the files ``layer.conf`` and ``bblayers.conf``.
> +
> +#.  **Recipes and packages**: Variables handling recipes and packages can be split into:
> +
> +    - :term:`PN`, :term:`PV` or :term:`PF` for example, contain information about the
> +      name or revision of a recipe or package. Usually, the default set in
> +      ``bitbake.conf`` is used, but those are from time to time overwritten in recipes.
> +
> +    - :term:`SUMMARY`, :term:`DESCRIPTION`, :term:`LICENSE` or :term:`HOMEPAGE`
> +      contain the expected information and should be set specifically for every
> +      recipe.
> +
> +    - In recipes, variables are also used to control build and runtime
> +      dependencies between recipes/packages with other recipes/packages. The
> +      most common should be: :term:`PROVIDES`, :term:`RPROVIDES`, :term:`DEPENDS`,
> +      and :term:`RDEPENDS`.
> +
> +    - There are further variables starting with `SRC` that specify the sources in
> +      a recipe like :term:`SRC_URI` or :term:`SRCDATE`. Those are also usually set
> +      in recipes.
> +
> +    - Which version or  provider of a recipe should be given preference when
> +      multiple recipes would provide the same item, is controlled by variables
> +      starting with ``PREFERRED_``. Those are normally set in the configuration
> +      files of a ``MACHINE`` or ``DISTRO``.
> +
> diff --git a/bitbake/doc/index.rst b/bitbake/doc/index.rst
> index 3ff8b1580f..30d2a5e3c7 100644
> --- a/bitbake/doc/index.rst
> +++ b/bitbake/doc/index.rst
> @@ -15,6 +15,7 @@ BitBake User Manual
>      bitbake-user-manual/bitbake-user-manual-metadata
>      bitbake-user-manual/bitbake-user-manual-fetching
>      bitbake-user-manual/bitbake-user-manual-ref-variables
> +   bitbake-user-manual/bitbake-user-manual-ref-variables-context
>      bitbake-user-manual/bitbake-user-manual-hello


Weird, I don't see the new document in the left menu bar after the 
variable index.

IMHO, it would make more sense to have this right after the 
"bitbake-user-manual-metadata" document, because it would be too late 
after the variable index.
You'll also have to change the header settings (title with "===" instead 
of "***").

Thanks in advance for the V2. There's not so much to change :}
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


