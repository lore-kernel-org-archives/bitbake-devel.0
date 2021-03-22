Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.603.1616426431056292137
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Mar 2021 08:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from [10.0.0.8] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BAECC24000B;
	Mon, 22 Mar 2021 15:20:28 +0000 (UTC)
Cc: michael.opdenacker@bootlin.com
Subject: Re: [bitbake-devel] [PATCH] doc: mention that addtask handles multiple dependencies
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <169a106e-fd23-64de-fcf3-e06afb421ac6@crashcourse.ca>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <0fba9cce-66f6-86a1-2bc2-7b437851d709@bootlin.com>
Date: Mon, 22 Mar 2021 16:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <169a106e-fd23-64de-fcf3-e06afb421ac6@crashcourse.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 3/22/21 11:19 AM, Robert P. J. Day wrote:
> Add a note explaining that "addtask" can accept multiple dependencies,
> just in case someone runs across such an example and is confused.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 7ea68ade..5ecda744 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1296,6 +1296,17 @@ For more information on task dependencies, see the
>  See the ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:variable flags`" section for information
>  on variable flags you can use with tasks.
>
> +.. note::
> +
> +   While it's infrequent, it's possible to define multiple tasks as
> +   dependencies when calling ``addtask``. For example, here's a snippet
> +   from the OpenEmbedded class file ``package_tar.bbclass``::
> +
> +     addtask package_write_tar before do_build after do_packagedata do_package
> +
> +   Note how the ``package_write_tar`` task has to wait until both of
> +   ``do_packagedata`` and ``do_package`` complete.
> +
>  Deleting a Task
>  ---------------
>

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Thanks!

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

