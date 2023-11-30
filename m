Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434FCC4167B
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 21:42:51 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.6281.1701380565686628955
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Nov 2023 13:42:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=oX0Dt/5l;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 54D1C9C320B;
	Thu, 30 Nov 2023 16:42:44 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GTovOdAVYJZG; Thu, 30 Nov 2023 16:42:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF5DE9C33F8;
	Thu, 30 Nov 2023 16:42:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BF5DE9C33F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701380563; bh=9aapNNRtPAlxMMZAtDIYyx7De+FZdC9o3G59ziRWsnI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=oX0Dt/5lKSFGIyrdTtjfSUyRzKwz9yN7W4/oiARMI4+bHiEgizY3d1td7gTvIA6J1
	 vpQGi5783mC+FCbhZ6j3n00DpHLteqzcT9OqrsvbNVu9IAd6QFRbJ7bfKVWeLNUYSC
	 hr8hPsm7LmIlUDFES/QF5zje8w51x0t6Pbz3423LanBuKEPqWe+bvqrTF5qcMOti8j
	 Tlaj6Jf1NIFin3cncMVfLSovkYdyqh8EoeNfeOrAMsV8X65sLyz6TblOgo2LdNGcBq
	 hg1OqLv9rrEEcoRXm6h0PlrAvC0kXNgZXDo+jkZHdKZc2ROLlcMhmIFynBQIZeGnOb
	 ioX5Gt/H9rsCQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id efpFxzKPs9cn; Thu, 30 Nov 2023 16:42:43 -0500 (EST)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A74F69C320B;
	Thu, 30 Nov 2023 16:42:43 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [toaster][PATCHv2 0/2] New Feature to import eventlogs in toaster 
Date: Thu, 30 Nov 2023 16:42:33 -0500
Message-Id: <20231130214235.20330-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Nov 2023 21:42:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15590


Added new feature to import eventlogs in toaster from the build directory=
.
V2: Changed UI interaction with user to redicrect to build page after imp=
ort is triggered, added new button on landing page to target import event=
log page, fix min-width for button in home page


