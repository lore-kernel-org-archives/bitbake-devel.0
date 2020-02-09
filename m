Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
	[209.85.215.182])
	by mail.openembedded.org (Postfix) with ESMTP id 31EF260F02
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:21 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id j15so2523513pgm.6
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=cvL06cyv1l6oPDblufFcFa5ccpI+33CpXfXABFGonUc=;
	b=DvrroWH7W/c3xABECFqX4pgEfHzwRpJR/wN3bCWITXy3XB8MOlG50s/mMko6vjOZTV
	QHevQBzzXVbhTDZboD3D7tR0h1+IwHKkpBgu6Li/DFWs5rCmiMCuvKJuPEs6n8rmbfcK
	yWpCGAaStzjW/YUXB7umIf8yOxD20x1/yCLG8PKPZl2W1fYcx3EOTY17Qajp9KCUlkWd
	aUWsA32B0rCiJtJgO4Wo7kJSMoAOPJ4t4/+YBu5NXabh7E50KxqngRBx4bErRuTXOWh6
	adCGBsJ3e6Lk/44M3i6vUAESjm0Ryd55qRyRRY5Pn13vIcEEESan4iiL9EdAJHu7qwEk
	aiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=cvL06cyv1l6oPDblufFcFa5ccpI+33CpXfXABFGonUc=;
	b=h/5A+te6f5UCnmhnTzOwoZzMfRV3I31ijoOK4/b8ygiznHJvcRXU9al4X5ZpoIfW6t
	3AMvD4qDUMc1KTxi9vKCOw0B7oFzxTENktpER7a2U8t0NxE/L9gmzb8JnP9VnF17oTYk
	SWLRgy2fs2asvsEvHxfDB1WKAmwuBqygZcyDzFkltf8raqCxBYZv4nSdl4QMp9uhXFGc
	1a5zpIRU7LK3ETzeekYrU3DkqAWood0260UsWHeE2CsJ7CJXu/g0BDEQvkfmNyWNAGIv
	G+bJYGV/MfyoubdjKOyCAHeN7R1831p/NLteD2AKuJ1p+w4S+0hLdwzpoXNLwTyF9rfy
	8XNw==
X-Gm-Message-State: APjAAAXBcr+lxUBiZDCRpCp2ND9NHlzj7xDWcAWQ6RPDeFpn+SLhaE9l
	tr/ntmjjvFsqUTq0MCwgbiEX5kY0
X-Google-Smtp-Source: APXvYqz3wtFlFFuEvktQiUoeMQI/anzOdgKCQrRtoO5QF/iolqDbH99WH/XPgxhmlYYPkj3v3SHBlg==
X-Received: by 2002:a63:5807:: with SMTP id m7mr9128113pgb.83.1581264202069;
	Sun, 09 Feb 2020 08:03:22 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.21
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:21 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:12 -0800
Message-Id: <c131015f1ac152f1fea4b83a3d451c3e4d05ebec.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 4/7] cooker/toaster: replaced deprecated method warn() with warning()
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:21 -0000

From: Frazer Clews <frazer.clews@codethink.co.uk>

Removed the deprecated methods as it will only cause problems later on,
and since warn() just calls warning(), it shouldn't change anything

Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a194f275235f22411cb2368f06a44f61ceb6a0f3)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cooker.py                                        | 2 +-
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b74affa7..911805a6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1788,7 +1788,7 @@ class CookerCollectFiles(object):
                 # When constructing an older style single regex, it's possible for BBMASK
                 # to end up beginning with '|', which matches and masks _everything_.
                 if mask.startswith("|"):
-                    collectlog.warn("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
+                    collectlog.warning("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
                     mask = mask[1:]
                 try:
                     re.compile(mask)
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 50ec4098..19f659ec 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -168,17 +168,17 @@ class Command(BaseCommand):
         try:
             self.cleanup()
         except Exception as e:
-            logger.warn("runbuilds: cleanup exception %s" % str(e))
+            logger.warning("runbuilds: cleanup exception %s" % str(e))
 
         try:
             self.archive()
         except Exception as e:
-            logger.warn("runbuilds: archive exception %s" % str(e))
+            logger.warning("runbuilds: archive exception %s" % str(e))
 
         try:
             self.schedule()
         except Exception as e:
-            logger.warn("runbuilds: schedule exception %s" % str(e))
+            logger.warning("runbuilds: schedule exception %s" % str(e))
 
     def handle(self, **options):
         pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
-- 
2.17.1


