Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A7C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 03:07:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.267.1702264030694520292
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Dec 2023 19:07:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=eXhpwala;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 89AA69C27A2;
	Sun, 10 Dec 2023 22:07:09 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0I7C6nogW1j8; Sun, 10 Dec 2023 22:07:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 345D79C3D77;
	Sun, 10 Dec 2023 22:07:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 345D79C3D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702264029; bh=0mh8TWiYE4EElT3R5X3rI6SNTSCnT8mo5fLatwKOqlw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=eXhpwalaoOOQ++Zw2uRwiqlNPnpwuVRhyo2Uj2MbafYR7/tRkIa2zCqe+Yetw0yDx
	 eGENTwrUYxezmlYOMEQv3NSkCRSiMQnod5M6A6MaJQVDz9+P3Gb3MYYNP8DTpPxrmC
	 vRlwCgNdY4m0WAj1vybwrj1MPHQkpu25CPZ++Dol9U149fHfmUjlWBwJ63LMPehYa4
	 XGWcNaIZBsc6++18xqUFnoDEh/SZ+PdhiBCbq/8RzgJBAA0NA5y/cpccDXmaXqCDhE
	 MCnwq/CLz4E0LMX1hLu586OQIv8f9h10rMs99Ke6dkxFn5FW9koxCsboX9nU/2kfhH
	 spW+8QTqaYybw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9ai3HBR8ajBc; Sun, 10 Dec 2023 22:07:09 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0C9609C08AD;
	Sun, 10 Dec 2023 22:07:09 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [toaster][PATCHv5 0/1] toaster: Added new feature to import eventlogs 
Date: Sun, 10 Dec 2023 22:07:05 -0500
Message-Id: <20231211030706.108629-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 03:07:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15644


Added new feature to import eventlogs in toaster from the build directory=
.
v5: Added seek(0) value to reset script read variable, update toaster-eve=
ntreplay script, remove test assert because new buttom contains text used=
 for validation, fix test in test_layerdetails


