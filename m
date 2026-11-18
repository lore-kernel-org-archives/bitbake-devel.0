Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7143.1794983415630524995
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 22:30:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@waymondrang.com header.s=zmail header.b=deVWzq5A;
 spf=pass (domain: waymondrang.com, ip: 165.173.180.52, mailfrom: me@waymondrang.com)
ARC-Seal: i=1; a=rsa-sha256; t=1794983413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZLgh2Q3xTgOnbpd5ftaO1FAmLhvhtlnCAciVN4opuUrY9AHGKjaa7yg/sijoMyUzAymHbjRP0gPumy9xrYjFXkpUjQ4arslXQq1NX+wUXC/tj9BBESisrqAwQep6Dk8dzSjevxnftYepDXG8Ai+Go8Sz4/zVZyI3Q+gYltm5rQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794983413; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hhKVnVNd8IusUCf/0XnMD2JgYwP5AykVrcULPawG/KA=; 
	b=SuvE483Y89kg3CAAOQNF2suONpO9WOemVN3iWQjYvNUof8AhhG87L3tlIJpUdLzQIPi+9UT0rOsCY9c/l5RG4fJ5sZFHDeZjQ7pJXGL32ChxEfmXTEdfN63X7RajP1N+dkbMO0fVXM8rmLK8iqbYcmJsOC4wB0vEZjR6rATjzNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=waymondrang.com;
	spf=pass  smtp.mailfrom=me@waymondrang.com;
	dmarc=pass header.from=<me@waymondrang.com>
DKIM-Signature: a=rsa-sha256; b=deVWzq5AXmSSkkg60yBb/JfAUemAr8vPKKySnBUNLoxDMb6NfBvHauNMy/vhx+eE1fFATcySbE/2Te0ScJGNZcpgU+2+ZN3WoXnggAlFQ3m0G5R1/QmV9ZTW1CYelfJWpo24Gkcay+YiyM3zVCWPmfaTRkVbI6rGYTcvde6JLiM=; c=relaxed/relaxed; s=zmail; d=waymondrang.com; v=1; bh=hhKVnVNd8IusUCf/0XnMD2JgYwP5AykVrcULPawG/KA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794983410985604.41427064351;
	Tue, 17 Nov 2026 22:30:10 -0800 (PST)
From: Raymond Wang <me@waymondrang.com>
To: bitbake-devel@lists.openembedded.org
Cc: Raymond Wang <me@waymondrang.com>
Subject: [PATCH] utils: fix 'polution' misspelling
Date: Tue, 17 Nov 2026 22:30:49 -0800
Message-ID: <20261118063049.619717-1-me@waymondrang.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 06:30:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20454
Content-Type: text/plain; charset="utf-8"

* lib/bb/utils.py (mkdirhier): Fix 'polution' misspelling with
'pollution'
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0e2677f8e..fdc243737 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -954,7 +954,7 @@ def mkdirhier(directory):
     No return value.
     """
     if '${' in str(directory):
-        bb.fatal("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR polution.".format(directory))
+        bb.fatal("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR pollution.".format(directory))
     try:
         os.makedirs(directory)
     except OSError as e:
-- 
2.56.1

