Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3207ECAAD5
	for <webhook@archiver.kernel.org>; Mon, 29 Aug 2022 12:46:35 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web11.69734.1661777193717954095
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Aug 2022 05:46:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ILHYBshu;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BD1C3100008;
	Mon, 29 Aug 2022 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1661777191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83NU8HmPV4iZg8zsC/KrrexIslEreUv2wQJ3yabFEW8=;
	b=ILHYBshu6bIn1CFczgHhWubu4CvK3lfrEP8jEPoffDKz9VPPnYenA3k/T9/6aJbrNvifMp
	YNf6PnSCiMnIojFR78UQ8jfHV22slcUm6VCcD42APTjaRZ8y66p2IYDEse9d+Ee9NFqOs1
	aGFEJtJV/Z7kKDrZALYvHqS8WolgBks7tMg4ZOqXSS0FxGngoPgbCq1u2ujauY3/CPkOJI
	fIrV9Zki0VJaTdIduGwxEa0HcBYbE8tdce61oF3Brhcg9y3sTqBY8rAlpmG8/qX6rclqHV
	9hm+5yDTSKiEZcoaDJCk49nM44Hj7aq00vwjF/Crpc3uRgd0Uu7q/SXGvesbSQ==
Message-ID: <a7c1377a-b3e1-fea0-9b67-5d5cb652871a@bootlin.com>
Date: Mon, 29 Aug 2022 14:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual: Add definition for
 BB_PRESSURE_MAX variables
Content-Language: en-US
To: Aryaman Gupta <aryaman.gupta@windriver.com>,
 bitbake-devel@lists.openembedded.org
References: <20220812182236.1650194-1-aryaman.gupta@windriver.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220812182236.1650194-1-aryaman.gupta@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Aug 2022 12:46:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13944

Hi Aryaman,

Many thanks for the patch! Apologies for the late review, I was away on 
vacation.

See my comments below:

On 8/12/22 20:22, Aryaman Gupta wrote:
> Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
> bitbake varibales glossary. Further information on how to determine a good
> threshold will be added to the Yocto reference manual in a later commit.
>
> Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
> Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst     | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 12aef3cb..9b2027de 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -482,6 +482,36 @@ overview of their function and contents.
>   
>            You must set this variable in the external environment in order
>            for it to work.
> +
> +   :term:`BB_PRESSURE_MAX_CPU`
> +      The threshold for maximum CPU pressure before BitBake prevents the
> +      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
> +      is exceeded, new tasks are not started until the pressure subsides to
> +      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
> +      pressure is not monitored. A threshold can be set in ``conf/local.conf``
> +      as:
> +      ::


Actually, here you can just use "as::" instead of "as:" followed by "::" 
in the next line.

> +
> +         BB_PRESSURE_MAX_CPU = "500"
> +
> +      Information about how to set a suitable value and some other caveats to
> +      consider can be found in the
> +      :ref:`Reference Manual </ref-manual/variables:BB_PRESSURE_MAX_CPU>``


I'm afraid you'll have to add this reference in a later commit, because 
for the moment, this creates a warning that is turned into an error. 
Sorry, this is the pain of managing two manuals at once. You may say 
"Yocto Project Reference Manual" then.

By the way, you had an extra backquote at the end of your reference.

> +
> +   :term:`BB_PRESSURE_MAX_IO`
> +      The threshold for maximum IO pressure experienced before BitBake
> +      prevents the scheduling of new tasks. The IO pressure is regulated in the
> +      same way as :term:`BB_PRESSURE_MAX_CPU`. At this point in time,
> +      experiments show that IO pressure tends to be short-lived and regulating
> +      just the CPU can help to reduce it.
> +
> +   :term:`BB_PRESSURE_MAX_MEMORY`
> +      The threshold for maximum memory pressure experienced before BitBake
> +      prevents the scheduling of new tasks. The memory pressure is regulated in
> +      the same way as :term:`BB_PRESSURE_MAX_CPU`. Note that any memory
> +      pressure indicates that a system is being pushed beyond it's capacity. At


s/it's/its/

> +      this point in time, experiments show that memory pressure tends to be
> +      short-lived and regulating just the CPU can help to reduce it.
>   
>      :term:`BB_RUNFMT`
>         Specifies the name of the executable script files (i.e. run files)


Would you mind sending a V3 fixing these, please? This one should be 
ready to merge.
Thanks in advance, and thank you for your patience :)

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


