Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E253CCA47B
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:44:24 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web12.2653.1655286261729289998
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 02:44:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jnK8prlA;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 42814100002;
	Wed, 15 Jun 2022 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655286259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfkl+aauN+TrEeIBl8tZrvVQZZmAVoh/35kYvU1kRDo=;
	b=jnK8prlASyp1tKarW/Ynitkfz3saHdkB0ASVUdXoy4E8fm3gbWBs9A84hkinRq1c6oZWN5
	3ISwHz0zvnCxgebS2Iok0HeU1mK/0k7jx3WpmoBhRKoJ/+5RaXDFaxoQ8NFlYyv9me2XXe
	bR3h5T2sJgC6eGU1zVhtWhqidwIb42SBfuNznjOpPTTcWaewIhAtqs8Ub6RH0ei2aeS5jL
	mvnIMDhwERZ8dykAsHlBMwflgdUHrI4pdAO8Vg4wDMufTT9Uzu+9TlCCXWXda2qCb81B1U
	HfuIyRDEtHuAdwkBANGhlVl1C0R/eIT9oOvQAjEzyz82Ox0LOEAAFm3xFC6aTA==
Message-ID: <715f8434-2e2b-4155-365b-3d8a2518e579@bootlin.com>
Date: Wed, 15 Jun 2022 11:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH v5] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20220615092345.327707-1-jacob.kroon@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220615092345.327707-1-jacob.kroon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jun 2022 09:44:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13766

Hi Jacob

On 6/15/22 11:23, Jacob Kroon wrote:
> Stating that the assignment is done at the end of parsing is misleading.
> The weak default value is the value which a variable will expand to if no value
> has been assigned to it using any of the assignment operators.
>
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>


Many thanks for the updates. The patch looks very useful.
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


