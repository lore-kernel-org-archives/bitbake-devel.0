Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 71E7F7653B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 18:16:50 +0000 (UTC)
Received: by pdbnt7 with SMTP id nt7so46435070pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=s8Fj3CHdar7ifEkcePjlkGyz6fBbCKZP41PouTALV1U=;
	b=lqtRD/A2LQZS51tj/lHsOKNAWj8FW/Wkvbr0mp7vhIaGPdK0wxuG5EtZdi4m/yShrY
	isey9Wf/6uV/7Q8G7YfPyOi3YP8NIuN7INFWBKa+2sAyHcY/6pmr/4vbn+5lC9dkL2BN
	2hOONXu1O5etrrs4dthnBa5UO07IrSx344Cnk6+cfxOAU1vQrMEB0F76P6LFHwDoywff
	ncvXAp4RUQ0jiptpteN7M6/AzO0OHiu7c/CxhbKrApmhkf/1GrpY6cvWm/LiX1sK+sE3
	/HMoK6U9ZwThk1hHthLv3+I7yaHzNl+crIPy7txYK63syssVhHH3L/krywi9tmnmz2TN
	5mmQ==
X-Received: by 10.70.37.207 with SMTP id a15mr9785846pdk.4.1438366610285;
	Fri, 31 Jul 2015 11:16:50 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	bx7sm8870452pdb.82.2015.07.31.11.16.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 31 Jul 2015 11:16:49 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 11:16:45 -0700
Message-Id: <1438366606-23283-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] bb.cookerdata: don't show traceback for ParseError/ExpansionError
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
X-List-Received-Date: Fri, 31 Jul 2015 18:16:50 -0000

From: Christopher Larson <chris_larson@mentor.com>

Tracebacks are of extremely limited usefulness in this context. The exceptions
carry the necessary context already, and the user doesn't care about the calls
in bitbake internals that led to an expansion or parse failure.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cookerdata.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 0ca87a0..57fc6bb 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -173,9 +173,12 @@ def catch_parse_error(func):
     def wrapped(fn, *args):
         try:
             return func(fn, *args)
-        except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+        except IOError as exc:
             import traceback
-            parselog.critical( traceback.format_exc())
+            parselog.critical(traceback.format_exc())
+            parselog.critical("Unable to parse %s: %s" % (fn, exc))
+            sys.exit(1)
+        except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
     return wrapped
-- 
2.2.1


