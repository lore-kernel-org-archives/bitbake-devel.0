Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D1C77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 08:07:06 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.3354.1686125216024504325
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jun 2023 01:06:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mDepll9L;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686125213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZW5tlMovnc5XXCvHrPlw3l8mDdpUOjEwEdaVTqYEOk=;
	b=mDepll9Lkomq53pUT/AB3jL/Asd6cpbknPFOZEK5vguYfA2fhb4WnmukGaK+tSgtXoiyHB
	u0fbJplDMwpTm+7+uyPC9uokWhtBG1/IBiPzjSSIdabcibinoY/Rvq3fjqYccx+V7/A3uv
	ec+W7TAidQ2r4VzT8LaE8hFfS22B6bd4ka+mznHCIHxlhqDGR6v/plZJprtstM5XcdwKwp
	weEjps73OJsXhOeFxY1Pto+h2eLDWuPlfpviI38WQ9Odd5cCTn522Giae4nGw/Xp/Vf4yf
	Ui8hMR6WbM502Ke3igVbMebRerzb10PyNoWvZ+bhRlSV7PfcPzNwxb3SlA0NUA==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FF01E0004;
	Wed,  7 Jun 2023 08:06:52 +0000 (UTC)
Message-ID: <dcd41763-0357-8aa7-156d-c7d553d22310@bootlin.com>
Date: Wed, 7 Jun 2023 10:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: Wu Zhenyu <wuzhenyu@ustc.edu>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <5imhhzz3zyhmcdfwxllkuebgbxribyxoqo65zdxgfkncgbsgnk@o2khpunlhc22>
Content-Language: en-US
Subject: Re: Missing subject
Organization: Bootlin
In-Reply-To: <5imhhzz3zyhmcdfwxllkuebgbxribyxoqo65zdxgfkncgbsgnk@o2khpunlhc22>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Jun 2023 08:07:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14831

Hi Wu

On 06.06.23 at 18:31, Wu Zhenyu wrote:
> From: Wu Zhenyu <wuzhenyu@ustc.edu>
> To: bitbake-devel@lists.openembedded.org
> Cc: docs@lists.yoctoproject.org,
> michael.opdenacker@bootlin.com
> Subject: [PATCH] support package
> Date: Wed, 7 Jun 2023 00:31:11 +0800
> Message-Id: <20230606163111.579144-1-wuzhenyu@ustc.edu>
> X-Mailer: git-send-email 2.40.1
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
>
> use `python -m build` to build package
> set PYPI_API_TOKEN to upload it to PYPI
> ---
> .github/workflows/python.yml | 44 ++++++++++++
> .gitignore | 128 ++++++++++++++++++++++++++++++++++-
> lib/bb/server/process.py | 5 +-
> pyproject.toml | 108 +++++++++++++++++++++++++++++
> 4 files changed, 282 insertions(+), 3 deletions(-)
> create mode 100644 .github/workflows/python.yml
> create mode 100644 pyproject.toml


Thank you for proposing this patch!
However, I see two issues:

* The title of the patch doesn't appear in the e-mail. That's weird
because apparently you used "git send-email"...
* The patch is missing "Signed-off-by" information. You should use
"git commit -s".

I'd suggest to send the e-mail to yourself first, until this is fixed.

Note that the documentation changes should be separate and produced 
against the "yocto-docs" repository.

I hope this helps...

Cheers,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


