Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835CC27C53
	for <webhook@archiver.kernel.org>; Sun,  9 Jun 2024 21:07:07 +0000 (UTC)
Subject: Re: [PATCH] fetch2/wget: Add user_agent parameter so it can be used optionally
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: Budapest, HU (80.98.74.198)
X-Originating-Platform: Windows Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 09 Jun 2024 14:07:04 -0700
References: <29B1D1C3-2E2F-467F-85BC-B265097BB933@arm.com>
In-Reply-To: <29B1D1C3-2E2F-467F-85BC-B265097BB933@arm.com>
Message-ID: <24273.1717967224466915192@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 09 Jun 2024 21:07:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16334

Randomly there are many servers which failed with default wget's user-agent=
. There were a commit about it a half year ago:
https://github.com/openembedded/bitbake/commit/d6fa261a9603677f0b3abbd309c1=
ca6073b63f4c

But later it reverted because Jfrog Artifactory does not like it.
https://github.com/openembedded/bitbake/commit/feef5cd12e877f42ffcace168d44=
b0e6eb80a907

There is also an AMD-Xilinx link which is failed to download without any Br=
owser user-agent:
https://support.xilinx.com/s/question/0D54U00008RolRMSAZ/yocto-metaxilinxco=
re-cannot-find-pmuromnative-url?language=3Den_US

Best practice to use a latest FireFox user-agent like "Mozilla/5.0 (X11; Ub=
untu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0" it was fine for=
 me, also.

