Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA409C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 16:47:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.580.1702313238285906689
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Dec 2023 08:47:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=IZDgKIef;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0EC839C284E;
	Mon, 11 Dec 2023 11:47:17 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jkBHqzMFPEWX; Mon, 11 Dec 2023 11:47:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B36E89C3502;
	Mon, 11 Dec 2023 11:47:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B36E89C3502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702313236; bh=1gk6TNRL721vibu1US/YoEIoIyD2SQRUaoxG+IZWkMo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IZDgKIefVgjH1e6hrgcr2upj5p8OvtJ7Xc5viKnzklXotu0nf4rm46My8W2MIYZBS
	 yJ/CkEU73D5X9ABjshkgvG9jx+mj9DfsSd/EuF/IS5dyjr4ONmk7XGCTdXoZRpv7x4
	 v8Z+lxW63LevgqorBeQHIDlOzkNvsxsRtgmcKlfBX38SgR0H9Hn0DI4u/zudIaKqlW
	 tFiLDBirTB33BGqXecCUw+1BE+I1UAUjDghDbkylQaiVbb49FWfM++lmQIRVSS7fzW
	 +YWWckJNPIB6w3Wg29P26V7QOQtDn0B2PnJwvOMO369EY7JbSf5YcFTYFbr4PT9UNY
	 68WxDqjgqcsEg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GHgfxT004bri; Mon, 11 Dec 2023 11:47:16 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 87B849C284E;
	Mon, 11 Dec 2023 11:47:16 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCHv6 0/1] toaster: Added new feature to import eventlogs  
Date: Mon, 11 Dec 2023 11:47:04 -0500
Message-Id: <20231211164705.34450-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 16:47:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15648


Added new feature to import eventlogs in toaster from the build directory=
.
V6: Added seek(0) value to reset screipt read, update toaster-eventreplay=
 script, remove test assert because new buttom contains text used for val=
idation, fix test in test_layerdetails, rebase from master


