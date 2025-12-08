Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01218D3B7E2
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 16:12:32 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.573.1765210348809578683
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 08:12:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=L8Lfkmnd;
 spf=pass (domain: smile.fr, ip: 209.85.128.65, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so43535105e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765210347; x=1765815147; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsMjO54hs84j14yQTI9yAUbH3oozPoVXFPR8x+hS+PE=;
        b=L8LfkmndBCxYhO7qQdTYtUQTgdNQclAjBJp3ItAoUv+IU5unnAaGqf735Ti5PuaB2p
         NLKZvs3nVL/ZOvqvajT/lPBsJbuGwMj0ubbcqyvzVjpl9WXGFWc+Y2UrUPjqzvtouBoU
         KASjXcmapdb8cg7EvC00XcP6KoqmBZ9NQqFW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210347; x=1765815147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsMjO54hs84j14yQTI9yAUbH3oozPoVXFPR8x+hS+PE=;
        b=AmtCwjBDG7H4VdU8bAE3Cs3O8vgBRJBIXSgd+P7BF6lPmnrsRaJC4Ih0n2Mm6ZoNjg
         8BlPkDEhihul2jl/Z+cKrNjQhUdaQmdlzg3n1cDOPtJ6nnbS4WozP5qev79bkmvzYKtL
         ENe7H4Grd5rMatvC0sIk6R50HwRCV3nfRev5R6UFHKHp76u/oArWIovGujuXTI2jqM67
         Q6ZV60umkaj3SUBJSDTwlOHd/IKYdh1cVHhanarRipimzjyooL9eGuWm1WUA2hov7Hsw
         9CFSrebqwp2A7wRkDAgaPvOtOSuNHtq+lBO/t89Cg9I7zqO/VZfmCNWQbdgjVi1b788r
         fpKQ==
X-Gm-Message-State: AOJu0YyZGynQplNZfmzXQsz8i+ecXUNqcqzcelRlXMS295m1KIbfurcj
	Xj2n+LQsFslhjchvssb7qyXmpkPG/AQF7TuWzbjk+Z63b7V/Y3pdHCOK4TC9tVJudJZaEjKK2L/
	CuS52p89Px1WK
X-Gm-Gg: ASbGnctSD915guvh2oL6kW4t2wPgvXaW6pojXRVXB6Zb8U0iMFE2tVXd8oNzamzyCKh
	Z8YAmIS6K0VneSK4PkTrG4c6TycB3XS9CS8B6mmbGPP3md0jy/d8vYEgyhMNu1xPD89Ap0J67Wx
	/KYvjk2ueBH1JLN8mz0/iPbby0Ya/Vaw2EOeSockadJmDezkPsL+QqvfGdQSJVigMKbaFXyqieH
	Oj8PSGT901nUFlMaBPr9KAaE7eGOuoFWR7PE8nvJiwIy9XxlkTlXYz1cly+8lylX0YCCGipIAxw
	Z13zTCLGYZ2hE+VjNOWN36Um8xi20Rni8FC4L68G2/eBGmRJMicUumJ6etzblscBqAPJ3Mkk5oA
	/HyiBYPax1iasCXVl3FCreBMRDFWlpKj8x/8vTm+aYgo6VtVLPlhuzQL+IdNP2UczcgAtyqo/OT
	qPHPXzESrySKruj3ZscJBpDoyXVPq4Cy9Jem8T4oVeNrwuxWthX5D/5tx2Vo27s4gE9/H572GtX
	bdndvxeFEqq9GHOTrH+lzeaVYQlew==
X-Google-Smtp-Source: AGHT+IHV6nTB13hzdrY/JezxcpJVeWoBgLPuH9AiUrFiiikTI9DWjW+wKGTEhuW+fZn6D/VXkCdiBg==
X-Received: by 2002:a05:600c:1d28:b0:475:de68:3c30 with SMTP id 5b1f17b1804b1-47939e27931mr122177975e9.16.1765210347065;
        Mon, 08 Dec 2025 08:12:27 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311e7142sm250963915e9.11.2025.12.08.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:12:26 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH] fetch2: Skip AUTOREV management if no SCM URI
Date: Mon,  8 Dec 2025 17:12:19 +0100
Message-ID: <20251208161219.41335-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 16:12:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18552

AUTOREV allows to fetch the latest revision. If no SCM URI is used (e.g. git://, ...),
AUTOREV has no effect. However there is one case in which a recipe with AUTOREV
but no SCM URI will lead to a parsing error:

ERROR: /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools/i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to work properly, please set the variables earlier in parsing. Erroring instead of later obtuse build failures.

This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is not acted
upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
srcrev_internal_helper() function to run, and read the value of SRCREV. If
SRCREV = "${AUTOREV}", then AUTOREV will be acted upon.

If the recipe does not have an SCM URI, SRCREV is not parsed and AUTOREV remains
unchanged. However, if SRCREV is expanded during the parsing time in Python code
(either pure or evaluated from BitBake code), then AUTOREV will be expanded too
and resulting in the setting of __BBAUTOREV_SEEN. However, as there is no SCM
URI, the code flow that would act upon AUTOREV is never run.

The fix slightly changes the way AUTOREV is handled: if no SCM URI is provided,
AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN will not be
defined).

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 lib/bb/fetch2/__init__.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bdd497394..a1e2def95 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -769,8 +769,16 @@ def mark_recipe_nocache(d):
         d.setVar('BB_DONT_CACHE', '1')
 
 def get_autorev(d):
-    mark_recipe_nocache(d)
-    d.setVar("__BBAUTOREV_SEEN", True)
+    fetcher = Fetch(d.getVar('SRC_URI').split(), d)
+    urldata = fetcher.ud
+    for u in urldata:
+        if not urldata[u].method.supports_srcrev():
+            continue
+
+        mark_recipe_nocache(d)
+        d.setVar("__BBAUTOREV_SEEN", True)
+        break
+
     return "AUTOINC"
 
 def _get_srcrev(d, method_name='sortable_revision'):
-- 
2.49.0


