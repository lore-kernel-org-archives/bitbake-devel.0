Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AC2457403A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 09:04:07 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4I948kl026143
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 02:04:08 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Mon, 18 May 2015 02:04:07 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 May 2015 02:04:07 -0700
Message-ID: <fdb3fd5daedd8287c602a298324dcb255c539e1d.1431939814.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1431939814.git.liezhi.yang@windriver.com>
References: <cover.1431939814.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/hg.py: add clean function
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
X-List-Received-Date: Mon, 18 May 2015 09:04:12 -0000
Content-Type: text/plain

Fixed when bitbake vim -ccleanall:

File: '/path/to/bitbake/lib/bb/fetch2/__init__.py', lineno: 1462, function: clean
     1458:    def clean(self, urldata, d):
     1459:        """
     1460:        Clean any existing full or partial download
     1461:        """
 *** 1462:        bb.utils.remove(urldata.localpath)
     1463:
     1464:    def try_premirror(self, urldata, d):
     1465:        """
     1466:        Should premirrors be used?
File: '/path/to/bitbake/lib/bb/utils.py', lineno: 633, function: remove
     0629:        subprocess.call(['rm', '-rf'] + glob.glob(path))
     0630:        return
     0631:    for name in glob.glob(path):
     0632:        try:
 *** 0633:            os.unlink(name)
     0634:        except OSError as exc:
     0635:            if exc.errno != errno.ENOENT:
     0636:                raise

Exception: OSError: [Errno 21] Is a directory: '/path/to/downloads/hg/vim.googlecode.com/hg/vim'

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/hg.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 6547cca..3c80725 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -163,6 +163,11 @@ class Hg(FetchMethod):
         logger.debug(1, "Running %s", updatecmd)
         runfetchcmd(updatecmd, d)
 
+    def clean(self, ud, d):
+        """ Clean the hg dir """
+
+        bb.utils.remove(ud.localpath, True)
+
     def supports_srcrev(self):
         return True
 
-- 
1.7.9.5


