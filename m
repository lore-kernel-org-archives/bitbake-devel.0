Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 6254571DDA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 06:42:02 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 19so13142075pfo.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Feb 2017 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=eNXqsX76Prjiiwt2NcxMetg713qeK7MTS/M1izDu1eM=;
	b=SBQVAYsaJzyOKB9+3sdDHfGkirrWbhLMYGlUoc2OkDfLpSP0W4kQK9dQEnu8NkUI8h
	7c1Hbm7jqtYm35o5MQtlZ3yxSVt1VkwM5Cn7MFSYh7kxQ7un6GJ+QdiEYTUmaYOy5I9M
	rm3FBMy3yGwVZJsY+qk0u2PnYKXvZx31wXgDNVaLvxCjtYzG493kl8hUgMJh+CjC5DaB
	fstVdZkqftHfKvTPL5WiEn7h9SBD88EjimOKJnckPM3T3GVwYrFxgBOw/8juutCUxEPM
	nWSzX+jUR9eFdOeoO6DukamKJgmIyPNzOg851nht9A1cDbKjyTA8h7Gl8oa3xsdUMsja
	91JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=eNXqsX76Prjiiwt2NcxMetg713qeK7MTS/M1izDu1eM=;
	b=StHpWRP0t5MBsT+dJdMrSiJKW273xhGmz4XNcWKp7MgqSwXtra0SnFkF3HJsCaE17S
	pJCFnTU6arYQfdA9ZSrOOfx72E1EJlC/OvcIZ5C5TM8Tk4U5MTr03WHdG3Xkp7gl+JLz
	QBqQDSY1TufNDQQAZ97C5pS9azAZgsdbPBA7IyI3Ct5TZ1KlUvnV2tuKgpFk40dzAQLX
	qj71ySB+8ImYLeos2NiOzLHp0X/PRGZaKu6ZSlRkOF02ktvQ05U5DR2xM6qaLc2XFQ25
	LuYRGb9Z5UD3eICcP7hN9NgiTxRBTWKGjNZLHxyYZvjcBat3jNTeLzok/FJQOg5PcBRa
	XV2w==
X-Gm-Message-State: AMke39nQPIJeNoUCeMuSc8aUomn6qeUkZ3gaehP/TH4xJbqh2tn21pg4qhN3FR0T9YJKkQ==
X-Received: by 10.84.160.197 with SMTP id v5mr2136497plg.161.1486622523382;
	Wed, 08 Feb 2017 22:42:03 -0800 (PST)
Received: from localhost.localdomain (c-76-102-32-192.hsd1.ca.comcast.net.
	[76.102.32.192])
	by smtp.gmail.com with ESMTPSA id t6sm25524218pgt.8.2017.02.08.22.42.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 Feb 2017 22:42:01 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Feb 2017 22:41:50 -0800
Message-Id: <20170209064150.11946-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.11.1
Cc: Balaji Punnuru <balaji_punnuru@cable.comcast.com>
Subject: [PATCH] fetch2: Add NFS Stale file exception handling
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
X-List-Received-Date: Thu, 09 Feb 2017 06:42:04 -0000

- In some cases the file descriptor
  is held by nfs client and none of os.path.* is catching
  that, it could mean that error is not doled out because
  client has cached the stat info. In this case we are
  out of luck. Needed to catch IOError, which would be
  causing the Stale error.

- In download method, update_stamp is invoked
  md5sum validation which is found to be throwing
  Stale errors.
- Added error handling to fix the stale errors.

Signed-off-by: Balaji Punnuru <balaji_punnuru@cable.comcast.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/bb/fetch2/__init__.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 525f47e4..69944a8b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -35,6 +35,7 @@ import operator
 import collections
 import subprocess
 import pickle
+import errno
 import bb.persist_data, bb.utils
 import bb.checksum
 from bb import data
@@ -998,6 +999,12 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     except bb.fetch2.NetworkAccess:
         raise
 
+    except IOError as e:
+        if e.errno in [os.errno.ESTALE]:
+            logger.warn("Stale Error Observed %s." % ud.url)
+            return False
+        raise
+
     except bb.fetch2.BBFetchException as e:
         if isinstance(e, ChecksumError):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
@@ -1646,6 +1653,11 @@ class Fetch(object):
 
                 update_stamp(ud, self.d)
 
+            except IOError as e:
+                if e.errno in [os.errno.ESTALE]:
+                    logger.error("Stale Error Observed %s." % u)
+                    raise ChecksumError("Stale Error Detected")
+
             except BBFetchException as e:
                 if isinstance(e, ChecksumError):
                     logger.error("Checksum failure fetching %s" % u)
-- 
2.11.1


