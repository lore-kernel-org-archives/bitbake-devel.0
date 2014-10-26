Return-Path: <koen@dominion.thruhere.net>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 9EEB960097
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Oct 2014 15:09:50 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id d1so933373wiv.11
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Oct 2014 08:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=utyet3Wy9TPgaMp4IT/3VQzQn5ozfzoFIvJb5DCBvMQ=;
	b=DFq9oHbEVN9P5ubq3ZjcxaswvvHEplIo4aw1Uw77Jf325rxEbV/UnhaAfmcT1fTRDR
	Hw3l6Ypxd+vEJZN2qsGmUgtXLN1HSr1TU+CEnd+qBSJ9YTsCusNkttvj64N1KScjWSzA
	9FOtHs4ze/7zSR15H270Lv4DE/Ty0/5vQ02fb+Jxdulp/nPFa3RVsIqnE2iYvvhGhogI
	Zx0nRtfP1z1laz1RA5VQt8EQyL5AlNHzJS1GB6EsSRCTK8WajOQz+P2N4t6BzWkrNmrF
	6Y/Xdf2s7mwM53v1yDJduyuiZEl395JZ+Tr2NsSHylH7qbKwXThxNGBJ7CsCcbaEbjW6
	ck/A==
X-Gm-Message-State: ALoCoQkepL44rhXQ4drqVnLpYEQTZuOMoqnlG5QUDkzpE4NW5AXQWyRxkb3Gun1mEVBICa+P8avO
X-Received: by 10.194.63.145 with SMTP id g17mr2514877wjs.80.1414336190771;
	Sun, 26 Oct 2014 08:09:50 -0700 (PDT)
Received: from localhost ([2001:610:612:0:beee:7bff:fe9e:ae56])
	by mx.google.com with ESMTPSA id ce1sm12314561wjc.2.2014.10.26.08.09.49
	for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Sun, 26 Oct 2014 08:09:50 -0700 (PDT)
From: Koen Kooi <koen@dominion.thruhere.net>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 26 Oct 2014 16:09:47 +0100
Message-Id: <1414336187-20182-1-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 1.9.0
Cc: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH] fetch2: add .lz compression support
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
X-List-Received-Date: Sun, 26 Oct 2014 15:09:54 -0000

See http://www.nongnu.org/lzip/lzip.html for details on the compression
format.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 lib/bb/fetch2/__init__.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 59a7f1b..cc29864 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1198,7 +1198,7 @@ class FetchMethod(object):
                      (file, urldata.parm.get('unpack')))
 
         dots = file.split(".")
-        if dots[-1] in ['gz', 'bz2', 'Z', 'xz']:
+        if dots[-1] in ['gz', 'bz2', 'Z', 'xz', 'lz']:
             efile = os.path.join(rootdir, os.path.basename('.'.join(dots[0:-1])))
         else:
             efile = file
@@ -1219,6 +1219,10 @@ class FetchMethod(object):
                 cmd = 'xz -dc %s | tar x --no-same-owner -f -' % file
             elif file.endswith('.xz'):
                 cmd = 'xz -dc %s > %s' % (file, efile)
+            elif file.endswith('.tar.lz'):
+                cmd = 'lzip -dc %s | tar x --no-same-owner -f -' % file
+            elif file.endswith('.lz'):
+                cmd = 'lzip -dc %s > %s' % (file, efile)
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)
-- 
1.9.0


