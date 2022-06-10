Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3766CCA47D
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 18:03:50 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web08.30326.1654884221894241096
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jun 2022 11:03:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=W1BY8Y3v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7053CFF803;
	Fri, 10 Jun 2022 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1654884220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvKpOv/PB52XAHrUv7X1wPADmPx9AIuY9MxNnECi+S0=;
	b=W1BY8Y3vFr3UoAWtxD9cROwR/zpjKv3QWK9bXolKS5ougKVzUY6oAMNMtgqigwMmv7m73h
	8o71KH/eYBJPpMYe+Zb7Zh6Bgg6fQIQyQFigdkoU0V3YlIa78dF3TwACFzuEdbT9XVOYWD
	YssemxSfjl15/5V632Gxynm/6oCtFtkCjN2WvyNaKOzK16OIkBUEVWcPJYJQvth0x3tDA3
	RgALP5o5C39m8XJO1cLKiLKlemS+eljw23gctYxD71OVujF65vctDZvGOJIqeR8H69c2P9
	HRQR2EYWDIoa6k9Dq2MqwP4NpaKCns8ziS3Y/TTV87P7ov0qr8Z9pBcdWWPqcA==
Message-ID: <0b1a2f8c-ec06-837a-6e75-656f4029f35e@bootlin.com>
Date: Fri, 10 Jun 2022 20:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20220603123618.32173-1-jacob.kroon@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220603123618.32173-1-jacob.kroon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jun 2022 18:03:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13752

Hi Jacob

Many thanks for this update to the BitBake manual.

On 6/3/22 14:36, Jacob Kroon wrote:
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>
> Changes in v2:
> * Add comment to line with immediate variable expansion


Would it also possible to mention what was wrong in the previous 
description?
The fact that the assignment is made at the end of the parsing process, 
which isn't correct given the example that you give? Otherwise, A := 
"${W}" wouldn't work, right?

>
>   .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>   1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index af4b1358..cfe46562 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is set to "aval".
>   Setting a weak default value (??=)
>   ----------------------------------
>   
> -It is possible to use a "weaker" assignment than in the previous section
> -by using the "??=" operator. This assignment behaves identical to "?="
> -except that the assignment is made at the end of the parsing process
> -rather than immediately. Consequently, when multiple "??=" assignments
> -exist, the last one is used. Also, any "=" or "?=" assignment will
> -override the value set with "??=". Here is an example::
> -
> -   A ??= "somevalue"
> -   A ??= "someothervalue"
> -
> -If ``A`` is set before the above statements are
> -parsed, the variable retains its value. If ``A`` is not set, the
> -variable is set to "someothervalue".
> -
> -Again, this assignment is a "lazy" or "weak" assignment because it does
> -not occur until the end of the parsing process.
> +The weak default value of a variable is the value which that variable
> +will expand to if no value has been assigned to it via one of the other
> +assignment operators. Here is an example::

Shouldn't we say "via any of the other assignment operators" instead?
It would sound a little better to me.

Thanks again
Michael

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


