Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3FEB1053
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 14:10:38 +0000 (UTC)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40361.1773150450897857591
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ew.tq-group.com header.s=default2602 header.b=KOhwfriL;
 spf=pass (domain: ew.tq-group.com, ip: 188.40.3.216, mailfrom: alexander.feilke@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=3odScZoSkzXUrOSa0ukpuddkvzi81Dp/0OwtRznWeU4=; b=KOhwfriLHWeqk+o/ABX+DLuvD4
	GDjYDqF0oFXmm6HfYtzeQml6+cSwf2o8qNUMTvWAwy1sfeKM0bvECN6ygGTGor+3XgtNOTgU1NA6J
	uQRw6+p8F15Bjbkvmknvm6xobOZ/6uLaM2yFpgxW3yfC4FJEMnZhSIfY9jPFE8RzYRjw4BDYi3mKj
	p+UgJaIWuFz3GFclZW3SMrBsxHbgPuYJB0ry2pAm8lo8+kBo9KOT5GoviiWOW5akSdcjMuQEKvAXx
	+r2v5q+/iD/5pPcREwMvsffLaVFtwajOfrphkbwqGmZzBywK7bXNIekxdab40s5BdyC0VFju1g66C
	wLvjC6Ww==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1vzxQm-000FZZ-2s;
	Tue, 10 Mar 2026 14:47:28 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1vzxQm-0002pc-2A;
	Tue, 10 Mar 2026 14:47:28 +0100
From: "Alexander Feilke" <alexander.feilke@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH 0/1] Backport to 2.8: fetch2: don't try to preserve all
Date: Tue, 10 Mar 2026 14:46:55 +0100
Message-ID: <20260310134659.882794-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/27936/Tue Mar 10 07:24:39 2026)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 14:10:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19140

This patch would be nice to have in version 2.8 as it wasn't backported yet

Ross Burton (1):
  fetch2: don't try to preserve all attributes when unpacking files

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


