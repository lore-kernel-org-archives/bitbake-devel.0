Return-Path: <twoerner@gmail.com>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
	[209.85.213.179])
	by mail.openembedded.org (Postfix) with ESMTP id B1F79756C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 18:16:56 +0000 (UTC)
Received: by igbpi8 with SMTP id pi8so21103810igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=uHSicFPNtIrdQXOtsi/LjUjBLHlGouGn6EBT+AR5HEM=;
	b=ngEsl4CCwTWU+vUwBZsu02zz4QWMX3FlRb66x51xPzZedZOoQhDmnisWL2hFGErwDi
	qNKhsNRDlJH4uYly/NyQIxE3AYKjdvlel5uqqCSrkCncaPsqxq9AlS41FxJSzhqr9qAA
	sAvl1ib01LLvCimFHfnVagwPIff2oethMx7lCTS8Z5KtM5NOjRbzucGWU5yL+UmaDWq3
	iWSQwXvecKOBbtm4lkqM51881soFB4V6gLtL2OGwG4Z4GZm3I+v/Va/qiumRjmoQW+Vb
	9gQCBcT74jUuaiIFPJK+F17mJ9z0M/k4CiDATVA3X6AxdX30d2HNu5unF/h0EhjXIpcQ
	CvXA==
X-Received: by 10.50.59.211 with SMTP id b19mr5594212igr.42.1432923417525;
	Fri, 29 May 2015 11:16:57 -0700 (PDT)
Received: from openSUSE-i7.site (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by mx.google.com with ESMTPSA id
	o19sm2023762igs.18.2015.05.29.11.16.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 29 May 2015 11:16:57 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 May 2015 14:16:41 -0400
Message-Id: <1432923403-31440-1-git-send-email-twoerner@gmail.com>
X-Mailer: git-send-email 2.4.0.194.gc518059
Subject: [PATCH] bitbake-user-manual: add BBLAYERS_FETCH_DIR
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
X-List-Received-Date: Fri, 29 May 2015 18:16:57 -0000

Add BBLAYERS_FETCH_DIR to the Variables Glossary.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../bitbake-user-manual-ref-variables.xml                   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index 86bf30b..bdbf421 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1016,6 +1016,19 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-BBLAYERS_FETCH_DIR'><glossterm>BBLAYERS_FETCH_DIR</glossterm>
+            <glossdef>
+                <para>
+                    Sets the base location where the layers are stored. By
+                    default this is set to <filename>${COREBASE}</filename>.
+                    This is used in conjunction with <filename>bitbake-layers
+                    layerindex-fetch</filename> and tells
+                    <filename>bitbake-layers</filename> where to place the
+                    fetched layer(s).
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-BBMASK'><glossterm>BBMASK</glossterm>
             <glossdef>
                 <para>
-- 
2.4.0.194.gc518059


