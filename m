Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1UINUH-0002HF-4b
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Mar 2013 19:11:45 +0100
Received: by mail-qa0-f41.google.com with SMTP id bs12so3244405qab.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Mar 2013 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
	bh=+iJSfmKbMcpddxy7zsgqMSzqlMNPMEtUoyZU0sPGY34=;
	b=EHoHsLutC9RFmxgdk2+dl3Snim46Fv8+cexNv1diq5idoYuOXsxfWb3esqK9FoFDZo
	RF/XEd0wHz+EeCTwhvmtenA3DydE0+OPrEgCNCq4TJWibGLw1PuAkR8dICMYm8yKs96E
	6bSoxFOQJjQppTkLm6Jt7foKYh+K3/Ghr6XcJuR99nKiHZZsOftJ+u+ffbFUEN++ANcH
	20u9yIUDCxbIKDrS1r8QFdA2ULYnIlZTc0sigrcWZVqfvqagwv0CckL+FbFj9D3deL9o
	18JMcp2dC7twAX5rQM2ij94vMXBi3zgvlvWMruYqvwBfhFZosbSl/4b3BkELPhVLXSDp
	hHvQ==
X-Received: by 10.229.72.195 with SMTP id n3mr55135qcj.136.1363802093671;
	Wed, 20 Mar 2013 10:54:53 -0700 (PDT)
Received: from nano.lab.ossystems.com.br ([187.23.144.59])
	by mx.google.com with ESMTPS id e3sm47584606qeo.0.2013.03.20.10.54.51
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 20 Mar 2013 10:54:53 -0700 (PDT)
Sender: Otavio Salvador <otavio.salvador@gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Mar 2013 14:59:56 -0300
Message-Id: <1363802396-12282-1-git-send-email-otavio@ossystems.com.br>
X-Mailer: git-send-email 1.8.1
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH] data_smart.py: Rename variable flags
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 20 Mar 2013 18:12:05 -0000

The variable expansion needs to handle variable flags as well
otherwise those do not behave as expected. One example of this is:

,----
| ALTERNATIVE_TARGET_${PN}-foo[name] = "value"
`----

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 bitbake/lib/bb/data_smart.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5bf11e5..2e43a8e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -515,13 +515,17 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
             self.setVar(newkey, val, ignore=True)
 
-        for i in ('_append', '_prepend'):
+        for i in (self.getVarFlags(key) or {}).keys():
             src = self.getVarFlag(key, i)
             if src is None:
                 continue
 
-            dest = self.getVarFlag(newkey, i) or []
-            dest.extend(src)
+            if i in ('_append', '_prepend'):
+                dest = self.getVarFlag(newkey, i) or []
+            else:
+                dest = self.getVarFlag(newkey, i) or ''
+            dest += src
+
             self.setVarFlag(newkey, i, dest, ignore=True)
 
             if i in self._special_values and key in self._special_values[i]:
-- 
1.8.1



