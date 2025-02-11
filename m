Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C887C021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 09:31:59 +0000 (UTC)
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
 by mx.groups.io with SMTP id smtpd.web11.8010.1739265203096876064
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 01:13:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=VrAwXrJ0;
 spf=softfail (domain: syslinbit.com, ip: 46.105.43.105, mailfrom: louis.rannou@syslinbit.com)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.148.65])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4YsbMh5b3bz1vjs
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 09:13:20 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-r2ntt (unknown [10.111.174.16])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9826A1FD7E;
	Tue, 11 Feb 2025 09:13:17 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.109])
	by ghost-submission-5b5ff79f4f-r2ntt with ESMTPSA
	id ZCi5Iq0Uq2eOBQEAP2YfLg
	(envelope-from <louis.rannou@syslinbit.com>); Tue, 11 Feb 2025 09:13:17 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-109S003a1916479-9971-4514-9f28-385fbadb1817,
                    0351088C983A5EEC3986E9566899D09CFC68072E) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
Message-ID: <c0723d2e-7742-4746-bc78-b0aee82fb8ed@syslinbit.com>
Date: Tue, 11 Feb 2025 10:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bitbake-devel@lists.openembedded.org, Steve Sakoman <steve@sakoman.com>
Cc: pascal.eberhard@se.com, Louis Rannou <louis.rannou@non.se.com>
From: "Louis Rannou" <louis.rannou@syslinbit.com>
Subject: [scarthgap] backport request for ??= operator for variable flags fix
X-Ovh-Tracer-Id: 1490691480799272257
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfvvefhufgtgfesthejredttddvjeenucfhrhhomhepnfhouhhishcutfgrnhhnohhuuceolhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeugeevudeihffggeevffetueeikeetkeejieffieeileelgffhffdvuddukeetgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehjeeimgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=hhgUb1fFZO8Gy0JTCdSBFt7c4KXUSyGMI1/4KJicAY0=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739265200; v=1;
 b=VrAwXrJ0tYTEEwD2QzOgec4cnLuiiQVMquY0vPo45UgxStcJeOjdXt2/PX8nQCZLyUUMThxz
 Ai/APf2vrAxvPxCyoSQoRMv/qqGtieGxgNYdlYjBoz8vbfsQQO/C+TLDOB6W2fseBg9WdYxRFnQ
 Tf/jTosZQxHNWmp0TyXEVaWP1BtOiPJJXLZyUBNFAZvIlptnayD8XaVHWZljZ3TTRgC/82xlHCD
 F3Eu90WUW9FkcpW7lMyql60yc9N1xff6s953m2ux07lWyYn0jjFPCZlyjFanCzoInKRX+mKorV7
 xq6J0TuJumonYazOw7RVRlbxhFvIlTkVdl6u+8icNrwHQ==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 09:31:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17188

Hello,

May we apply the commit following commit to scarthgap as the issue also 
exist:

commit 0329a7e3ac694737f2d2c1861f65492551360663
Author: Yoann Congal <yoann.congal@smile.fr>
Date:   Sat Jan 11 15:13:51 2025 +0100

     data_smart: fix ??= operator for variable flags

I suppose the other commit that came along for tests is also fine:

commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -> 2.8)
Author: Yoann Congal <yoann.congal@smile.fr>
Date:   Sat Jan 11 15:13:50 2025 +0100

     tests/parse: add test for ?= and ??= operators for variable flags

Here is the path link for details 
https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.congal@smile.fr/#t

Thanks,
Louis Rannou

