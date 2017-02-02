Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 08C8F71A8E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Feb 2017 22:26:14 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 02 Feb 2017 14:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,326,1477983600"; d="scan'208";a="929558135"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.128.122])
	by orsmga003.jf.intel.com with ESMTP; 02 Feb 2017 14:26:14 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Feb 2017 16:29:21 -0600
Message-Id: <1486074561-27644-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH] bitbake-layers: Handle exception raised bytinfoil.prepare()
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
X-List-Received-Date: Thu, 02 Feb 2017 22:26:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tinfoil.prepare method can raise Exceptions when is parsing initial
 data so add this call inside try, finally to avoid get blocked for
don't call tinfoil.shutdown().

The tinfoil_init function was remove because isn't make sense now since
 tinfoil.prepare() needs to be inside try, finally closures.

Example of raised exception and gets blocked:

$ bitbake-layers add-layer ~/repos/meta-openembedded/meta-python/

Traceback (most recent call last):
  File "/home/alimon/repos/poky/bitbake/bin/bitbake-layers", line 83, in
main
    tinfoil.prepare(True)
...
  File "/home/alimon/repos/poky/bitbake/lib/bb/tinfoil.py", line 268, in
run_command
    raise TinfoilCommandFailed(result[1])
bb.tinfoil.TinfoilCommandFailed: Traceback (most recent call last):
  File "/home/alimon/repos/poky/bitbake/lib/bb/command.py", line 81, in
runCommand
    result = command_method(self, commandline)
...
  File "/home/alimon/repos/poky/bitbake/lib/bb/cooker.py", line 1314, in
handleCollections
    raise CollectionError("Errors during parsing layer configuration")
bb.cooker.CollectionError: Errors during parsing layer configuration

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bin/bitbake-layers | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 1e2cfbc..66fc7ca 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -31,15 +31,6 @@ sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
 
-
-def tinfoil_init(parserecipes):
-    import bb.tinfoil
-    tinfoil = bb.tinfoil.Tinfoil(tracking=True)
-    tinfoil.prepare(not parserecipes)
-    tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    return tinfoil
-
-
 def logger_create(name, output=sys.stderr):
     logger = logging.getLogger(name)
     loggerhandler = logging.StreamHandler(output)
@@ -86,8 +77,10 @@ def main():
     logger_setup_color(logger, global_args.color)
 
     plugins = []
-    tinfoil = tinfoil_init(False)
+    tinfoil = bb.tinfoil.Tinfoil(tracking=True)
+    tinfoil.logger.setLevel(logger.getEffectiveLevel())
     try:
+        tinfoil.prepare(True)
         for path in ([topdir] +
                     tinfoil.config_data.getVar('BBPATH').split(':')):
             pluginpath = os.path.join(path, 'lib', 'bblayers')
-- 
2.1.4


