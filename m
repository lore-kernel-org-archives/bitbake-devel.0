Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 9057A731B8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:52:54 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id r187so17997461pfr.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+nC0ZTZ70sJdMEefqZnocjhHk/IRrESDxzn6aKhN+3I=;
	b=CCrt/qJxjGpumgC5uq1tzFuFacfuMElouf/d8vHsDoGm+cXugIxgHcFXHshvFs0KTw
	n7stR1QNlTK+hTrVfAG0SCTG5CnJGaHjezEDm0X/I+fNaOFeTyZmz7yf6ySGLtTimW6y
	GzbjK2gYY+nKAn8lm6YOmOleGMME0hUzGaDcEg0xCN3tlMVlffevuO/sn3I1A6ikU9fz
	w9srtEKE31UwjXnJVF2IHy+ZlVptwnPP0Pstb+DtND7AJbUhT9OCxwLpbRMhKlkHrlka
	hfQv/aySM/iAXONcz7kSfNoyiAb8/7oo6JOcE1yHYqM8BCOM4TuaeA0EhcHMhnWU3roO
	sIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+nC0ZTZ70sJdMEefqZnocjhHk/IRrESDxzn6aKhN+3I=;
	b=T8WbvmjBzDLRNIaPULyLHuCzyNrEvGeTYYn2e8i62SSMxrD1is9gU8pWvv3JOOPtpg
	cbjM8O/MsYFxgYudonONoR475N9rkxhgUV4Qhbs/n7rIKYDErAQ2fOhqGU4ingiito+u
	qMjBENoS6heIECT7E9kNCf+pGJoymzldYGhDoVoN15Unjd8gGmXLpJ0+p/6wuKg8fLjQ
	bFc4Vk4dcd4uBxhjIlFHdgig7WCMPUc8jAdYWKrBSzwjIzfQtd/ih0lVXObnlguHpBTk
	6NoZJW3JeSda8dyFiSynHj/LpvBFj4qzBGuubDO6HhszmHZiU/CAF8FWV+9Cwa/6hlbD
	oDZA==
X-Gm-Message-State: AOPr4FVSWIVGYcJSHFiOWyZHdmzfdQYAAe1qFR7STwXtgOrxrHyaQKNnrFLoSd2Hb5G9RA==
X-Received: by 10.98.68.208 with SMTP id m77mr39234640pfi.25.1462045975217;
	Sat, 30 Apr 2016 12:52:55 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z2sm33247522pfa.90.2016.04.30.12.52.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:52:53 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:52:46 -0700
Message-Id: <1462045969-14538-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] bb.cooker: show limited traceback for parsing ExpansionError
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
X-List-Received-Date: Sat, 30 Apr 2016 19:52:55 -0000

From: Christopher Larson <chris_larson@mentor.com>

It's useful to see tracebacks for ExpansionErrors, but only if we skip the
leading bitbake-internal elements, otherwise we see elements of the expansion
process.

As one example:

Before:

    ERROR: ExpansionError during parsing /scratch/yocto-new/external-as-needed/poky/meta/recipes-core/glibc/glibc-locale_2.23.bb: Failure expanding variable PV[:=], expression was ${@get_external_libc_version(d)} which triggered exception AttributeError: 'module' object has no attribute 'external'

After:

    ERROR: ExpansionError during parsing /scratch/yocto-new/external-as-needed/poky/meta/recipes-core/glibc/glibc-locale_2.23.bb
    Traceback (most recent call last):
      File "PV[:=]", line 1, in <module>
      File "/scratch/yocto-new/external-as-needed/meta-sourcery/recipes-external/glibc/glibc-external-version.inc", line 3, in get_external_libc_version(d=<bb.data_smart.DataSmart
    object at 0x7f05d2566950>):
             sopattern = os.path.join(d.getVar('base_libdir', True), 'libc-*.so')
        >    found_paths = oe.external.find_sysroot_files([sopattern], d)
             if found_paths:
    ExpansionError: Failure expanding variable PV[:=], expression was ${@get_external_libc_version(d)} which triggered exception AttributeError: 'module' object has no attribute 'external'

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cooker.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9b565fc..d60453e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2153,8 +2153,11 @@ class CookerParser(object):
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
-            _, value, _ = sys.exc_info()
-            logger.error('ExpansionError during parsing %s: %s', value.recipe, str(exc))
+            bbdir = os.path.dirname(__file__) + os.sep
+            etype, value, _ = sys.exc_info()
+            tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
+            logger.error('ExpansionError during parsing %s', value.recipe,
+                         exc_info=(etype, value, tb))
             self.shutdown(clean=False)
             return False
         except Exception as exc:
-- 
2.8.0


