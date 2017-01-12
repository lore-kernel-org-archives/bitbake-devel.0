Return-Path: <msm-oss@mcclintock.net>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 85D3D71988
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 00:44:23 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id j15so713371oih.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jan 2017 16:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=ie0X3s3r1h624ic8n7ZqWe/nUmx+brCkxTy51kKrwF0=;
	b=IZxNeCm5BKJ6rPi4sCEBysnxVfsGDZZDsGbLTuwNm3mLdLozFrUWfkI8ROKxk/K6h/
	TgOKVFj/uTH42KJ3pef3rOIIbxaTDOhy32avDfGwZqfxnGQKfa26xAsTsU/9k+MHDMeX
	z9doqnvV+xg7O4BgB0UBTXRKmp6rJjX70bJC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ie0X3s3r1h624ic8n7ZqWe/nUmx+brCkxTy51kKrwF0=;
	b=NfSgbYhI2yCQx0QIQIL3Jd5CshW0/wCVKF7ZswuULvTMuXPtlafiSSCZfiGtYu1aTL
	b/KmpoDBZKn/Nrs70GrXGGsrkBzNAONll4jzHrtNiVpz+0+fKGWWCbaC+USHNSzlRobt
	y+GH/qa6PCqNY/ciiaQb2ljdr1r8R5gaJ49IjDlZXezioNGGhWf1KLtFGR7nXfhRkdb3
	8OFBoTUyLNy6/rYQ3rrsMHsV/+Z6ob8clLHnqUy8aIMH6zNcSwb5NvrITbrLHxqJDbWU
	GK4zQWCjocUAGPLLsrKNGkBChx47Ac6E7KaN5Z+NehdBKLNNBCBKmUIMk8QC+eA43xsD
	jBbw==
X-Gm-Message-State: AIkVDXK5Bw3GCblanuGiuQi8HfAYOuktWWw9wizb9DiFppk0wEq1fIRIRXNZGEvWUonbog==
X-Received: by 10.202.207.202 with SMTP id f193mr5895693oig.81.1484181863294; 
	Wed, 11 Jan 2017 16:44:23 -0800 (PST)
Received: from pandora.lan ([2605:6000:1019:149:5a77:b80:8e7b:e835])
	by smtp.gmail.com with ESMTPSA id r28sm3387381otd.0.2017.01.11.16.44.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 11 Jan 2017 16:44:22 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2017 18:44:18 -0600
Message-Id: <1484181858-2247-1-git-send-email-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] bitbake-layers: show-appends: add optional argument to limit package list
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
X-List-Received-Date: Thu, 12 Jan 2017 00:44:23 -0000

Add ability to limit output per package:

$ bitbake-layers show-appends m4
=== Matched appended recipes ===
m4_1.4.17.bb:
  /home/mattsm/git/openembedded-core/meta-selftest/recipes-test/m4/m4_1.4.17.bbappend

Useful for writing tools to process the output, and debugging
bbappends for specific packages

Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
---
 lib/bblayers/query.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 5def717..bef3af3 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -242,17 +242,22 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 
 Lists recipes with the bbappends that apply to them as subitems.
 """
-
-        logger.plain('=== Appended recipes ===')
+        if args.pnspec:
+            logger.plain('=== Matched appended recipes ===')
+        else:
+            logger.plain('=== Appended recipes ===')
 
         pnlist = list(self.tinfoil.cooker_data.pkg_pn.keys())
         pnlist.sort()
         appends = False
         for pn in pnlist:
+            if args.pnspec and pn != args.pnspec:
+                continue
+
             if self.show_appends_for_pn(pn):
                 appends = True
 
-        if self.show_appends_for_skipped():
+        if not args.pnspec and self.show_appends_for_skipped():
             appends = True
 
         if not appends:
@@ -477,7 +482,8 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
         parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
-        self.add_command(sp, 'show-appends', self.do_show_appends)
+        parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
+        parser_show_appends.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_cross_depends = self.add_command(sp, 'show-cross-depends', self.do_show_cross_depends)
         parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
-- 
2.7.4


