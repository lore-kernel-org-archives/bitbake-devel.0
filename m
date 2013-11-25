Return-Path: <nickdademo@gmail.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id 0330C6D282
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 07:26:56 +0000 (UTC)
Received: by mail-pd0-f177.google.com with SMTP id q10so4916427pdj.36
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2013 23:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=pg/QiZnE6eMe1zMQ/fX8pbHwD6xtDFGCvjTREJT40lg=;
	b=fVXVDvf6y8/q23pDNrpjwI92Bn8/45GJ+DufjS3JYa7pKSWp7Ij4+JZ1ip1Cm7Hmst
	IYcVpxBh7/HAMs1kPq5S8dqhVETtqKqPm+lwN5225hhfsg0pnIdQTc5x/OD4zWxrEUfm
	L9fA+7irjCMBi2rEnBuHuzHB4XEEIDeHK3hKpoHvzvGaQTAjPJ/3U2fWZfY3tLvtWGhs
	FL9mkb4HRtgkNYohwrTx0iBo3oTTbE5Hp8RNMXOtV7/swmLZAjro6o2wdt/iJBeoWE3U
	Q3ThQ/JfurQMWccQSw07RmTrVz4BGYug6brNEusrhv4sisnXp/Vrxw1g5GaaGq4BFghP
	y9Kg==
X-Received: by 10.66.249.134 with SMTP id yu6mr26274387pac.37.1385364416612;
	Sun, 24 Nov 2013 23:26:56 -0800 (PST)
Received: from localhost.localdomain
	(d110-32-96-161.meb801.vic.optusnet.com.au. [110.32.96.161])
	by mx.google.com with ESMTPSA id
	gw10sm33203155pbd.13.2013.11.24.23.26.54 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sun, 24 Nov 2013 23:26:56 -0800 (PST)
From: Nick D'Ademo <nickdademo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Nov 2013 18:26:11 +1100
Message-Id: <1385364371-16092-1-git-send-email-nickdademo@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-Mailman-Approved-At: Fri, 29 Nov 2013 18:03:38 +0000
Cc: Nick D'Ademo <nickdademo@gmail.com>
Subject: [PATCH] Change call to latest_revision() to match parameters in function definition.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 25 Nov 2013 07:26:57 -0000

This fixes the "latest_revision() takes exactly 4 arguments (5 given)" Python TypeError which occurs when attempting to fetch via SSH.

Signed-off-by: Nick D'Ademo <nickdademo@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b236631..a9470e4 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -125,7 +125,7 @@ class Git(FetchMethod):
             if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
                 if ud.revisions[name]:
                     ud.branches[name] = ud.revisions[name]
-                ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
+                ud.revisions[name] = self.latest_revision(ud, d, name)
 
         gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
         # for rebaseable git repo, it is necessary to keep mirror tar ball
-- 
1.7.9.5


