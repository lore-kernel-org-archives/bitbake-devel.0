Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9CAC4332F
	for <webhook@archiver.kernel.org>; Sat, 17 Dec 2022 08:48:40 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.4036.1671266911846116924
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Dec 2022 00:48:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dezabPLX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id bx10so4602319wrb.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxOI6sN8QzZMgKY4B/f0m04WZCLy0cJeT1KkUEC0I+8=;
        b=dezabPLXo+qcbQhLff8HDVxpUUe/jYoGlIhBQxUte/Tt/am/1WmTY3qcnqomAxBvqJ
         gsLRjPzvQbxztJZ2pDSpWrxcmhS9ia/boVvKgGIlQgUrGAX6O8dltTCPd7xF7laB2eNG
         L8c5ar6Q7aDZiijkxGW24E47yPUacQ6WCWbXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxOI6sN8QzZMgKY4B/f0m04WZCLy0cJeT1KkUEC0I+8=;
        b=PaYXq3jLpUlOuOXzVIRjYTjpNVJd2NyMjxVb7dtEOOh1xS5Pf/DJYsu7w1RxpmPwy3
         E5ayhdwsTLxsyptcqXkNfQ9bSazDPwVzoNiCqI03EIlLt9+GPRWp+ubsdPFQY+V40Juu
         VoxW9WZ2iZlK0jkLV9O3q6gNlEsud4uK/+Aw2pVz5B9k/nG3+ebWmRo2hgBUmhXTGYuF
         WbpINsry8fvh5H3iICF1l+dFWVO/1NPAr7ts0utnpAwVIQDuyQON5BL7kV/m3c3wRuJA
         irHKaPjfk1uN0Oq1fUAaPcNxPymCF/LU3x1b+59hBaaztnapIpvYVt5h3Ep2U3LNrqBD
         /LUQ==
X-Gm-Message-State: ANoB5pkRiX19nw5Pl7jaEkjU4m4txOpkIJRigj1RTpra2852lKs0Er44
	EmJExKNVRjuu2m25I/XBMLu1dpDOUi1zTbLO
X-Google-Smtp-Source: AA0mqf5j8Q6SF2l6oChQlAG87q+L7mJv5faBrZ5/qh3dhobjYQ/t+8EyvsTsDK6hPgIFCwgdPH/2Ng==
X-Received: by 2002:adf:f5ce:0:b0:242:5698:6fb5 with SMTP id k14-20020adff5ce000000b0024256986fb5mr21141606wrp.3.1671266909977;
        Sat, 17 Dec 2022 00:48:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:17b:a3fe:f7a:35a6])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d4a85000000b0023662245d3csm4268321wrq.95.2022.12.17.00.48.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 00:48:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] codeparser/data: Add vardepsexclude support to module dependency code
Date: Sat, 17 Dec 2022 08:48:28 +0000
Message-Id: <20221217084828.242224-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 08:48:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14190

We need to be able to exclude dependencies from the python module
dependency code. Add support for the vardepexclude flag for these. It
only works from the configuration namespace rather than per recipe
for efficiency.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 6 ++++++
 lib/bb/cookerdata.py | 1 +
 2 files changed, 7 insertions(+)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index c0b1d7966f..ecae7b0808 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -84,6 +84,12 @@ def add_module_functions(fn, functions, namespace):
         modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
         #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, src, parser.references, parser.execs, parser.var_execs, parser.contains))
 
+def update_module_dependencies(d):
+    for mod in modulecode_deps:
+        excludes = set((d.getVarFlag(mod, "vardepsexclude") or "").split())
+        if excludes:
+            modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3]]
+
 # A custom getstate/setstate using tuples is actually worth 15% cachesize by
 # avoiding duplication of the attribute names!
 class SetCache(object):
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 59ecbec69d..650ae05ec9 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -311,6 +311,7 @@ class CookerDataBuilder(object):
             logger.exception("Error parsing configuration files")
             raise bb.BBHandledException()
 
+        bb.codeparser.update_module_dependencies(self.data)
 
         # Handle obsolete variable names
         d = self.data
-- 
2.37.2


