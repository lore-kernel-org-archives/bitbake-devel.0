Return-Path: <n.merinov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8497C02196
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 16:43:11 +0000 (UTC)
Received: from ksserv.inango.com (ksserv.inango.com [31.154.135.10])
 by mx.groups.io with SMTP id smtpd.web11.92358.1738600983274454158
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 08:43:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com header.s=45A440E0-D841-11E8-B985-5FCC721607E0 header.b=IskQcAAZ;
 spf=pass (domain: inango-systems.com, ip: 31.154.135.10, mailfrom: n.merinov@inango-systems.com)
Received: from ksserv.inango.com (localhost [127.0.0.1])
	by ksserv.inango.com (Proxmox) with ESMTP id A427921FCB;
	Mon,  3 Feb 2025 18:43:00 +0200 (IST)
Received: from mail.inango-systems.com (unknown [172.31.254.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ksserv.inango.com (Proxmox) with ESMTPS id 7F06F21FC2;
	Mon,  3 Feb 2025 18:43:00 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id D42C41080575;
	Mon,  3 Feb 2025 18:42:59 +0200 (IST)
Authentication-Results: mail.inango-systems.com (amavis);
 dkim=pass (2048-bit key) header.d=inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8ecBFrCB9lbo; Mon,  3 Feb 2025 18:42:59 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id B7DED108055D;
	Mon,  3 Feb 2025 18:42:59 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com B7DED108055D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1738600979;
	bh=HbyCTqBHO6afSft7ueB2rmKEfnFVvjzMQiKl/gFMnz0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IskQcAAZuRFkeFwLE2b0G/g9ozX/3V9yul/OQQQSLhkJNzPID6TLJagVWe2merI+F
	 7Q0alrZGlKYYpYhUPR4kXseD/r8VYuye+G52YWs5+ALGT8nq9zGpGamoinNW0vgNWB
	 /eayCdvdftpZHroNJCOp5T8ue5C7be1F9gO1tig8A+S+g4FSVtnbdZU31M1Ebfni3M
	 8+eCJUdiNajqJH7SY9Z7YF6sk6CX/y322L7vP2avukZCuL6Z4e07HM2YaWuxrKcHpj
	 oY0+ZSNDLyjiG0HA8XSl8kA7Uis2r2rmfvx/kew2hl+KbAXkIZOte8LbltFuPvY8WE
	 sUqRJLy23VTmA==
X-Virus-Scanned: amavis at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lVJwF_d_-4Ga; Mon,  3 Feb 2025 18:42:59 +0200 (IST)
Received: from wksv-012.inango.loc (ksserv.inango.com [31.154.135.10])
	by mail.inango-systems.com (Postfix) with ESMTPSA id 381B510804E9;
	Mon,  3 Feb 2025 18:42:59 +0200 (IST)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Cc: Nikolai Merinov <n.merinov@inango-systems.com>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to ${.}, ${+}, and ${:} variables
Date: Mon,  3 Feb 2025 18:42:35 +0200
Message-Id: <20250203164235.1503956-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
References: <fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 16:43:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17123

Hi Richard,

> I'm worried that if we do what you patch does, we're complicating the
> code and potentially setting ourselves up for other new interesting
> future problems.

How about moving complicated part out of regular expression?

Please take a look to the second version of the patch.

Regards,
Nikolai


