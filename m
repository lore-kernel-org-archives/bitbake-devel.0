Return-Path: <n.merinov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33225C0218F
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 07:14:06 +0000 (UTC)
Received: from ksserv.inango.com (ksserv.inango.com [31.154.135.10])
 by mx.groups.io with SMTP id smtpd.web11.110522.1738653239926878849
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 23:14:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com header.s=45A440E0-D841-11E8-B985-5FCC721607E0 header.b=FpQCowpB;
 spf=pass (domain: inango-systems.com, ip: 31.154.135.10, mailfrom: n.merinov@inango-systems.com)
Received: from ksserv.inango.com (localhost [127.0.0.1])
	by ksserv.inango.com (Proxmox) with ESMTP id 249E0253D5;
	Tue,  4 Feb 2025 09:13:57 +0200 (IST)
Received: from mail.inango-systems.com (unknown [172.31.254.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ksserv.inango.com (Proxmox) with ESMTPS id 9017F253C2;
	Tue,  4 Feb 2025 09:13:56 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 44CB61080564;
	Tue,  4 Feb 2025 09:13:55 +0200 (IST)
Authentication-Results: mail.inango-systems.com (amavis);
 dkim=pass (2048-bit key) header.d=inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IS07qQucBvgl; Tue,  4 Feb 2025 09:13:55 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 28359108055D;
	Tue,  4 Feb 2025 09:13:55 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 28359108055D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1738653235;
	bh=hV95jYvsnL6yHgiFpyRRZAEfnDl7OL3rMc8puIiZ6Ho=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=FpQCowpBPdD3JOOHSCZQhew4hGfRDdzkqTlV/53bapR8CkH4Unb6nvwSOri57DT4M
	 vxnJ2duAIyPY2OC9sP5e1laOASj03aFpFtppHKmuctALc0Wnpal9ITYZQ7WQCx10O2
	 KhnOSvF1weEH4ZUDVuXzRpiLbl3wQcy7ku4UqczpeoF6rHEqRmdzDHSnsNuyDNUCgw
	 aC9crRfyq6VCoi5wdP41OGPSSzxmAGm4eC8xeGmrh2x4ViPXiU6d8PKFB/96XM2oU7
	 JFuoSSMCPNIg2fvmNRvX8zNtdAzM5sBMs46lwqYw+c9F8whxe141KUoIm7px/haqDa
	 L4HQBb5Wp4DQQ==
X-Virus-Scanned: amavis at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xdeM575FjiYN; Tue,  4 Feb 2025 09:13:55 +0200 (IST)
Received: from wksv-012.inango.loc (ksserv.inango.com [31.154.135.10])
	by mail.inango-systems.com (Postfix) with ESMTPSA id 9FDC110804C9;
	Tue,  4 Feb 2025 09:13:54 +0200 (IST)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Cc: Nikolai Merinov <n.merinov@inango-systems.com>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to ${.}, ${+}, and ${:} variables
Date: Tue,  4 Feb 2025 09:13:45 +0200
Message-Id: <20250204071346.1797777-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <25ed9291b59922108451bdec071f56efea34dec3.camel@linuxfoundation.org>
References: <25ed9291b59922108451bdec071f56efea34dec3.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Feb 2025 07:14:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17129

Hi Richard,

> The test name needs changing from test_parse_exports though else it
> will redefinine one of the other tests.

Thank you for noticing this! I checked that I got test failure without
rest part of my patch and immediately forget to ajust test name.

Feel free to fix naming if it looks incorrectfor you.

Regards,
Nikolai


