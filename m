Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6CCD06C6EC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 08:19:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0D8K0ox027651
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 00:20:00 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 13 Jan 2014 00:20:00 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 13 Jan 2014 03:19:56 -0500
Message-ID: <69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1389601138.git.liezhi.yang@windriver.com>
References: <cover.1389601138.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: data.py: convert "__" to "-" for PREFERRED_VERSION
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
X-List-Received-Date: Mon, 13 Jan 2014 08:19:59 -0000
Content-Type: text/plain

We can set the PREFERRED_VERSION from the command line:

$ export BB_PRESERVE_ENV=1
$ PREFERRED_VERSION_recipe="pv" bitbake recipe

But it doesn't work if the recipe name contain the "-" since we can't
use "-" in shell's variable name,  use '__' instead of '-' in the env
will make it work.

We also need update the doc, I will mark the bug as "doc changes
required".

[YOCTO #4965]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data.py |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 5840803..666cdcb 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -171,11 +171,20 @@ def expandKeys(alterdata, readdata = None):
 
 def inheritFromOS(d, savedenv, permitted):
     """Inherit variables from the initial environment."""
+    # We can set the PREFERRED_VERSION_recipe from the shell env, but we
+    # can't use "-" in shell's variable name, so we use '__' instead of
+    # '-' in the env, and translate it back here.
+    preferred_version_re = re.compile('PREFERRED_VERSION_.*__')
+
     exportlist = bb.utils.preserved_envvars_exported()
     for s in savedenv.keys():
         if s in permitted:
             try:
-                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
+                if preferred_version_re.match(s):
+                    s_new = s.replace('__', '-')
+                    d.setVar(s_new, getVar(s, savedenv, True), op = 'from env')
+                else:
+                    d.setVar(s, getVar(s, savedenv, True), op = 'from env')
                 if s in exportlist:
                     d.setVarFlag(s, "export", True, op = 'auto env export')
             except TypeError:
-- 
1.7.10.4


