Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f180.google.com (mail-wj0-f180.google.com
	[209.85.210.180])
	by mail.openembedded.org (Postfix) with ESMTP id C985D71B6F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:27 +0000 (UTC)
Received: by mail-wj0-f180.google.com with SMTP id v7so30973739wjy.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jrXLBcDuwXvTtOaQwEdXR9rmRZ7zn1FdPS/g2BA89tQ=;
	b=pWcCxBOsSN12GJuRBtvcjEAVsebZzJcbk1IzZF6veQRUJ6I03BlHGnwEBLcGhEtbav
	QMpKq9A3FsZCYrfk/uLnkym9Mj9hFSLke8xwFiqPlUGWwP8Cg5e6ovvJ7LFPrXo3Xz+I
	CezxRL0R7kqEIJsWdyahQRPhaNjWrbLwlY/cS2DTIp1Cpt87v7K6wPoGRmlOyR2cEg5d
	6FZ2QeAJGJZfepH/bPXzBTmAex/MPnwimByhBH/G4SNTIFs8DzThuvW+XMxKAZFMzTRY
	rS0bu2ikKBHeB7QctxhMnY7rZisqn3lJxQdvDmj19HJ7SqtkfJWR5spZg8hwBBzDEf7A
	mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jrXLBcDuwXvTtOaQwEdXR9rmRZ7zn1FdPS/g2BA89tQ=;
	b=fttsdzGEGxFi4MyTN2uZUCD/5iOrmfL5BQ0fB8bk0zlUVCz4Wvi8A3PT3I57N0jCrZ
	EWM5vW/OGL6FuTVRtGRMy4IBpvU736R4XAI1RUCa4IjJQ9N6lFupRpRUwUBID/IBFZKa
	+AxBLTtcxuUBPWcGXWgNgx6y6Owwwfo/4EFofXk4hhp3UYc8x1Z3GEkeCAVhp0QzYISP
	kZAWmGpjHxLijYJwRqTQ0slFTXKSeZdnOnSRr5Tvm47S45bRF+TnrwXiDREx9MOdevBb
	w3UHOpzIcp2sWrwOBQ78HZpeiy22ggZ5mu0TltR9Cqje2cuwE2HFw/XGW1xRhoPGGZKU
	NmLA==
X-Gm-Message-State: AKaTC018WiFU5//9TlS3DPjaidi7StaA9v7D2sLcUSzbMdj6o5B4iHVMLEny8jtIAEKY/23a
X-Received: by 10.194.44.41 with SMTP id b9mr2121694wjm.56.1479986428820;
	Thu, 24 Nov 2016 03:20:28 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:28 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:59 +0000
Message-Id: <1479986406-4657-9-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 08/15] toaster: localhostbecontroller write toaster layers for project to toaster-bblayers.conf
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:28 -0000

From: Sujith H <sujith.h@gmail.com>

Instead of updating conf/bblayers, here we update toaster-bblayers.conf
file. So extra effort to update bblayers.conf can be removed safely.

Signed-off-by: Sujith H <sujith.h@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 3896a82..11335ac 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -286,19 +286,8 @@ class LocalhostBEController(BuildEnvironmentController):
                        self.be.sourcedir)
 
         # update bblayers.conf
-        bblconfpath = os.path.join(builddir, "conf/bblayers.conf")
-        conflines = open(bblconfpath, "r").readlines()
-        skip = False
+        bblconfpath = os.path.join(builddir, "conf/toaster-bblayers.conf")
         with open(bblconfpath, 'w') as bblayers:
-            for line in conflines:
-                if line.startswith("# line added by toaster"):
-                    skip = True
-                    continue
-                if skip:
-                    skip = False
-                else:
-                    bblayers.write(line)
-
             bblayers.write('# line added by toaster build control\n'
                            'BBLAYERS = "%s"' % ' '.join(layers))
 
@@ -311,9 +300,10 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # run bitbake server from the clone
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
-        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s '
+        toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
+        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
                        '--server-only -t xmlrpc -B 0.0.0.0:0\"' % (oe_init,
-                       builddir, bitbake, confpath), self.be.sourcedir)
+                       builddir, bitbake, confpath, toasterlayers), self.be.sourcedir)
 
         # read port number from bitbake.lock
         self.be.bbport = ""
-- 
2.7.4


