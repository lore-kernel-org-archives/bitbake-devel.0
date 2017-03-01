Return-Path: <armccurdy@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 60FA871D9F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Mar 2017 23:56:52 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id j5so4883450pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Mar 2017 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=GRniyjSEbpUPXUpUMtKW4JY1EK/T/HNQqQRGMQEw+sw=;
	b=HpV5seYQhaUOrQCsSZwN+w16CkHklWv40vcmAKSuctpQ8XS4j4CONqGprEV2xIUnh5
	+Fxkw4VSNCsWyOGeD+uGi+AgcUepf4IkkQ1mDQz32i23ZW1FOdDMC4fxbDDRHlijt9Rc
	UDu9YjhPMfOLpAa6C0PnSNOrhI3lRuSeFKHq8OrOa0jNbvbYZkEAfmzMEfJZ75HIPBGy
	OyoNJym3EzrUX07MYkvmEinESBAeo/OehKvvyhFtGBnfk8VkKMsuMdgEFmbgOsXVmVcA
	LG/hSYMyvjx5ehBUUm9Gj1Wo5lMZZYYlDZyCGDVR9511tqhjf2qSPgAvo5Pos+FKlusr
	7+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GRniyjSEbpUPXUpUMtKW4JY1EK/T/HNQqQRGMQEw+sw=;
	b=qHEwekgbjbwuWAEqfoHH9JUedWOxtIgl4iSAxFymjRep6ZwLMURSfnXJfnFfSOnwtA
	7F2WFwkwZsNO5TESVhldu6gVmDTEeK0cEKmLwmw1bWiJz5fqNb1QzHCxarEdEbDPupOW
	PeT6RFPpu7rWoDRIs0s0kGvwXhF+GmFldJk6eq4EL/1NwrY02hlN+pEqf4oY8pNIXiT8
	O516ar8r9WI4Y6NzQs7eVr3zfavthiUzAWZqXOBKoVofWBPOD2n40PYDOtknaZhEzesh
	VvfrhkHMkx6CLnfgPHhk69p3aN2CCV54bnm0wccVaePt8RQKmH4lvdGOpuBR8kCRR9i2
	Xrkw==
X-Gm-Message-State: AMke39mn8QUQ9z7C/Juk19yLOkAtCZL1b8gR3KL+GXebo+AMlN6B7ycGseXP/47NADbcLQ==
X-Received: by 10.99.111.138 with SMTP id k132mr12001879pgc.138.1488412614264; 
	Wed, 01 Mar 2017 15:56:54 -0800 (PST)
Received: from e6520.guest-wifi.scl.liberty.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	d10sm12668492pfl.59.2017.03.01.15.56.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 Mar 2017 15:56:53 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Mar 2017 15:56:46 -0800
Message-Id: <1488412606-1754-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: add initial Amazon AWS S3 fetcher
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
X-List-Received-Date: Wed, 01 Mar 2017 23:56:53 -0000

Class for fetching files from Amazon S3 using the AWS Command Line
Interface. The aws tool must be correctly installed and configured
prior to use.

The class supports both download() and checkstatus(), which therefore
allows S3 mirrors to be used for SSTATE_MIRRORS.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py |  6 ++-
 lib/bb/fetch2/s3.py       | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 lib/bb/fetch2/s3.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 760e24f..0205c3d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1196,13 +1196,13 @@ class FetchData(object):
             self.sha256_name = "sha256sum"
         if self.md5_name in self.parm:
             self.md5_expected = self.parm[self.md5_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
             self.md5_expected = None
         else:
             self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
+        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
             self.sha256_expected = None
         else:
             self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
@@ -1787,6 +1787,7 @@ from . import svn
 from . import wget
 from . import ssh
 from . import sftp
+from . import s3
 from . import perforce
 from . import bzr
 from . import hg
@@ -1804,6 +1805,7 @@ methods.append(gitannex.GitANNEX())
 methods.append(cvs.Cvs())
 methods.append(ssh.SSH())
 methods.append(sftp.SFTP())
+methods.append(s3.S3())
 methods.append(perforce.Perforce())
 methods.append(bzr.Bzr())
 methods.append(hg.Hg())
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
new file mode 100644
index 0000000..27993aa
--- /dev/null
+++ b/lib/bb/fetch2/s3.py
@@ -0,0 +1,96 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake 'Fetch' implementation for Amazon AWS S3.
+
+Class for fetching files from Amazon S3 using the AWS Command Line Interface.
+The aws tool must be correctly installed and configured prior to use.
+
+"""
+
+# Copyright (C) 2017, Andre McCurdy <armccurdy@gmail.com>
+#
+# Based in part on bb.fetch2.wget:
+#    Copyright (C) 2003, 2004  Chris Larson
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import os
+import bb
+import urllib.request, urllib.parse, urllib.error
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import FetchError
+from bb.fetch2 import runfetchcmd
+
+class S3(FetchMethod):
+    """Class to fetch urls via 'aws s3'"""
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with s3.
+        """
+        return ud.type in ['s3']
+
+    def recommends_checksum(self, urldata):
+        return True
+
+    def urldata_init(self, ud, d):
+        if 'downloadfilename' in ud.parm:
+            ud.basename = ud.parm['downloadfilename']
+        else:
+            ud.basename = os.path.basename(ud.path)
+
+        ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
+
+    def download(self, ud, d):
+        """
+        Fetch urls
+        Assumes localpath was called first
+        """
+
+        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path, ud.localpath)
+        bb.fetch2.check_network_access(d, cmd, ud.url)
+        runfetchcmd(cmd, d)
+
+        # Additional sanity checks copied from the wget class (although there
+        # are no known issues which mean these are required, treat the aws cli
+        # tool with a little healthy suspicion).
+
+        if not os.path.exists(ud.localpath):
+            raise FetchError("The aws cp command returned success for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path, ud.localpath))
+
+        if os.path.getsize(ud.localpath) == 0:
+            os.remove(ud.localpath)
+            raise FetchError("The aws cp command for s3://%s%s resulted in a zero size file?! Deleting and failing since this isn't right." % (ud.host, ud.path))
+
+        return True
+
+    def checkstatus(self, fetch, ud, d):
+        """
+        Check the status of a URL
+        """
+
+        cmd = 'aws s3 ls s3://%s%s' % (ud.host, ud.path)
+        bb.fetch2.check_network_access(d, cmd, ud.url)
+        output = runfetchcmd(cmd, d)
+
+        # "aws s3 ls s3://mybucket/foo" will exit with success even if the file
+        # is not found, so check output of the command to confirm success.
+
+        if not output:
+            raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
+
+        return True
-- 
1.9.1


