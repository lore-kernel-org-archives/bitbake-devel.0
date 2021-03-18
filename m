Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web09.841.1616100021374018433
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Mar 2021 13:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 8B03840BE9
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 20:40:19 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apjn3P2q0G38 for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Mar 2021 20:40:19 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 7D3F840A47
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 20:40:19 +0000 (UTC)
Received: from gimli.denix (unknown [192.168.30.6])
	by mail.denix.org (Postfix) with ESMTP id BFE6517454E;
	Thu, 18 Mar 2021 16:40:18 -0400 (EDT)
From: "Denys Dmytriyenko" <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denis@denix.org>
Subject: [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
Date: Thu, 18 Mar 2021 16:39:59 -0400
Message-Id: <1616099999-47367-1-git-send-email-denis@denix.org>
X-Mailer: git-send-email 2.7.4

When first mirror returns an outdated fullmirror tarball, its clonedir stays
behind for successive mirror tries. Even when latest tarball gets fetched
next, it doesn't get unpacked, as clonedir already exists. Cleanup old
clonedir and unpack the new fullmirror tarball, when the old clonedir is
no good and requires update.

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
---
 lib/bb/fetch2/git.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e3ba80a..cb62dcc 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -337,7 +337,8 @@ class Git(FetchMethod):
         if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
             ud.localpath = ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
+        elif os.path.exists(ud.fullmirror) and (not os.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):
+            bb.utils.remove(ud.clonedir, recurse=True)
             bb.utils.mkdirhier(ud.clonedir)
             runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
 
-- 
2.7.4

