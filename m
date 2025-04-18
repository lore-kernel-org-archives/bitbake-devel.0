Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591BDC369CF
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 13:48:09 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.205])
 by mx.groups.io with SMTP id smtpd.web10.12003.1744984085941807982
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 06:48:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=X94Thyug;
 spf=pass (domain: freemail.hu, ip: 46.107.16.205, mailfrom: egyszeregy@freemail.hu)
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.one.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4ZfGLC2KS3zJLW;
	Fri, 18 Apr 2025 15:48:03 +0200 (CEST)
Message-ID: <9855f240-a4ac-4887-a39a-91c9feaa605c@freemail.hu>
Date: Fri, 18 Apr 2025 15:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: hu
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Subject: Re: [PATCH] bitbake: cooker: Fix performance issue in EventWriter()
 class
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1744984083;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
	l=118; bh=rbvq8Z80l9q9gXc+/IihfIoaz3ZcTMNe67C8TDpOStc=;
	b=X94Thyug7DAtyHe3bKt+pxWtSx1TgqdSsmL75ef/E10w6ff32pdLNpD88YGvizmi
	BuI83M0qM8lLA430o4r5mp6dYoxV1phhBJ6ZP8vr4H0JvcQJBCyLT8RH0RZMMiqPrdN
	NYCnbnFeaXitAVlxz+UrwMqV7CkuNrSCewOmsizuch+cijb1erysXi9O270n0lJqI9x
	sQQDAGsC97HGDWxT5klCSSvPahjiIryRzP1RU05P6SkZ8xtV0CppzimsMHlWulfZvAT
	A4n0kAhukV/t9m6AC22n7DLheZh7SeoX0rauKMsloE8Gtd9zUJsbLLWOmD/SlM/7P8b
	bEmwODyeQw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 13:48:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17532

Hi,

When it will be reviewed and merged to bitbake?
https://lists.openembedded.org/g/bitbake-devel/message/17082


