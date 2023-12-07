Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C42DC10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:25:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.85415.1701959130296695723
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 06:25:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=LsEWdqJu;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 32A059C2B49;
	Thu,  7 Dec 2023 09:25:29 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mkyXQ3nez5Ek; Thu,  7 Dec 2023 09:25:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B4FC29C319F;
	Thu,  7 Dec 2023 09:25:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B4FC29C319F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701959128; bh=NePSTXcDCVtMW5O2fGiTFznB/WUzXZ6zWBUUXs+5lTk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=LsEWdqJuvJJ7sVZVKg5xt1GngGP+8W7g+PIZGFppSCSNdCzTUtO4NRLQsedHT7kuz
	 GDlCTj68Q5cqhdsEUX3KlQsOmV+MIwb/kzW1w35stNAiria/AqxBrjIcW04ITVJ3Tj
	 /Uw7LNmb489OaVQ+Kqi288Zg+y3xXTdmwMOaVVpNzyijxuckZbThGnzkA7eQSKgjN3
	 hOVgvfsLQv6cpGe4Cbdi+mOPGSxQqxZzoE2z75ERJPhQ2RX0nNs2gNVIf0ZxMLy2uQ
	 pe9/lQRL/WZqDXUbkOyJXcxieOqIVLnB3GLvug+yNY4DIm8sfvGgZo553q7c2wZs8H
	 VmjfTQkqmKdKw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jQBP0F3xQ-XX; Thu,  7 Dec 2023 09:25:28 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 894E89C112D;
	Thu,  7 Dec 2023 09:25:28 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [toaster][PATCHv4 0/1] toaster: feat to import eventlogs
Date: Thu,  7 Dec 2023 09:25:13 -0500
Message-Id: <20231207142514.29752-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Dec 2023 14:25:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15630


Added new feature to import eventlogs in toaster from the build directory=
.
V4: Updated eventreplay library based on changes on eventreplay script, a=
dded file size listing, squash commits for consistency


