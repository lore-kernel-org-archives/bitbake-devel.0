Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 06FE96AD0D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 09:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t549gd5I007600 for <bitbake-devel@lists.openembedded.org>;
	Thu, 4 Jun 2015 10:42:39 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MYGk_UOS6zp0 for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 10:42:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t549gQLx007587
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 4 Jun 2015 10:42:38 +0100
Message-ID: <1433410946.7135.2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Jun 2015 10:42:26 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] parse/BBHandler: Avoid repeatedly resetting FILE
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
X-List-Received-Date: Thu, 04 Jun 2015 09:42:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we're not going to change the value of FILE, or we know it isn't
going to have changed (ext == bbclass), don't set FILE.

This avoids messy looking history of the variable as well as optimises
parsing speed slightly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 85c27c2..03109df 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -148,7 +148,7 @@ def handle(fn, d, include):
     statements = get_statements(fn, abs_fn, base_name)
 
     # DONE WITH PARSING... time to evaluate
-    if ext != ".bbclass":
+    if ext != ".bbclass" and abs_fn != oldfile:
         d.setVar('FILE', abs_fn)
 
     try:
@@ -166,7 +166,7 @@ def handle(fn, d, include):
     if ext != ".bbclass" and include == 0:
         return ast.multi_finalize(fn, d)
 
-    if oldfile:
+    if ext != ".bbclass" and oldfile and abs_fn != oldfile:
         d.setVar("FILE", oldfile)
 
     return d



