Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 02FE374601
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 07:34:21 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8U7YNBc013202
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 00:34:23 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 30 Sep 2018 00:34:22 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 30 Sep 2018 00:31:09 -0700
Message-ID: <06d5fd40199751dfd5dbacb6c88d6e8cb2fbc518.1538292172.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1538292172.git.David.Reyna@windriver.com>
References: <cover.1538292172.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/1] [SUMO] toaster: [Sumo] fix bitbake flexible path error from Bugzilla #12891
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
X-List-Received-Date: Sun, 30 Sep 2018 07:34:23 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

Commit 15340edce23e63b060c75114d508e1f76757239c introduced a way which
allowed bitbake to be found from the PATH variable when directory
structures different from poky are used. This just drops a leftover
bitbake definition which made the earlier implementation meaningless
by reassigning the path relative to oe-core/meta.

[YOCTO #12942]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 3850334..63b4187 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -360,12 +360,12 @@ class LocalhostBEController(BuildEnvironmentController):
             for path in os.environ["PATH"].split(os.pathsep):
                 if os.path.exists(os.path.join(path, 'bitbake')):
                     bitbake = os.path.join(path, 'bitbake')
+                    logger.info("Found Bitbake at: %s" % path)
                     break
             else:
                 logger.error("Looks like Bitbake is not available, please fix your environment")
 
         # run bitbake server from the clone
-        bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
         toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
         self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
                        '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_init,
-- 
1.9.1


