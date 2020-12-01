Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web09.12640.1606840025156139508
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:27:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=NfjDb4IM;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: ernstp@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id f18so3892487ljg.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7gTmjRU/HQmV7R0CTRUW0ekJ33di5Bz4R3wZhmmw6M=;
        b=NfjDb4IMmmaV/wn2wOk4rHuY3fl3swv3V0Gd2z9WdkK30fYoHQ8Py1uSYv2a26pcMN
         vwp6rrR4Q3av5mhKD/zPwD45CDFMhsUVYNXfDfkZniBJraE3LX3IxAYkcimJWD5ERzJ0
         AhrqMHV7iGAnmgVO//vKkxkQSVI2MNtXwXOCUs7RiGbJL++SmdTPGZsOa03ax7fuIksa
         /K5bQTI65tm9swRMMKzZ6heXe0vaTTj2NGv/4pJVPBhcEpODRAV38BLb8sESToHWpRN1
         Ha8aQ19d2YFP9F6YfasNeEI/qvczBsDrQR+hoLtO1Wv1ZL+dr/ttzPhhZPNH3MDps11L
         2Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7gTmjRU/HQmV7R0CTRUW0ekJ33di5Bz4R3wZhmmw6M=;
        b=K/UsiKuCK5VO/QltnQLH8EWiKis0Ur+1VBSzwah3djGOmtm8cMPFCUoZIBmf5G+evO
         z4kp0xFKW2PEBsYKs1uOFa8a145Di7E0/GtluzqCZTaTtbVnQwcx2Kno7ISH9zyY9JRM
         iiyZ8C+9gmtRJqA97J1bNgeyTp9hq0tI4IfuHC1n0YAOBDEtq4WUTJhRaeCUH9leYvgu
         ZwsIfIr8YO7r4HXOTxmeWmZTyJoEqbsMK4dVLqyUsbyiv51R1TCuketNy4EJ+GhvwEaJ
         FUt+/M+MCPKI6fVZpfOA11aqAsY3FF1avcP2mUqJN4Xs3mBnxUreDIAbcZFWsUlNv85I
         E8dw==
X-Gm-Message-State: AOAM533QFXu75FhRGy1Z/muzWsnLkE36oyuhUcPPglkUYPZkguNiHhMd
	V9AnMmnS5pxKTO63KFYgTBF+Oev/Gx4=
X-Google-Smtp-Source: ABdhPJxC/WuYqy1IRC+uywdsjLdgfFSuv5IkgCO8On+3Pb714hQzJHZnoixoB7HL6q9KKMxAAOPewA==
X-Received: by 2002:a2e:9092:: with SMTP id l18mr1668117ljg.205.1606840023294;
        Tue, 01 Dec 2020 08:27:03 -0800 (PST)
Return-Path: <ernstp@gmail.com>
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se. [83.254.138.119])
        by smtp.gmail.com with ESMTPSA id j131sm248746lfd.209.2020.12.01.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:27:02 -0800 (PST)
From: =?UTF-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernstp@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell 4/5] meta: drop _PYTHON_SYSCONFIGDATA_NAME hacks
Date: Tue,  1 Dec 2020 17:26:26 +0100
Message-Id: <20201201162627.47760-4-ernstp@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201162627.47760-1-ernstp@gmail.com>
References: <20201201162627.47760-1-ernstp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

(From OE-Core rev: d3a81dd0e72a3495bfc7cc969c2bb806b666023d)

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit acfdab8daa3a67ebabc65fb7e152cc3a476b4333)
---
 meta/classes/scons.bbclass          | 3 ---
 meta/lib/oe/prservice.py            | 4 ----
 meta/recipes-core/glib-2.0/glib.inc | 4 ----
 meta/recipes-graphics/mesa/mesa.inc | 5 -----
 4 files changed, 16 deletions(-)

diff --git a/meta/classes/scons.bbclass b/meta/classes/scons.bbclass
index 6b171ca8df..4f3ae502ef 100644
--- a/meta/classes/scons.bbclass
+++ b/meta/classes/scons.bbclass
@@ -5,7 +5,6 @@ DEPENDS += "python3-scons-native"
 EXTRA_OESCONS ?= ""
 
 do_configure() {
-	unset _PYTHON_SYSCONFIGDATA_NAME
 	if [ -n "${CONFIGURESTAMPFILE}" ]; then
 		if [ -e "${CONFIGURESTAMPFILE}" -a "`cat ${CONFIGURESTAMPFILE}`" != "${BB_TASKHASH}" -a "${CLEANBROKEN}" != "1" ]; then
 			${STAGING_BINDIR_NATIVE}/scons --clean PREFIX=${prefix} prefix=${prefix} ${EXTRA_OESCONS}
@@ -17,13 +16,11 @@ do_configure() {
 }
 
 scons_do_compile() {
-	unset _PYTHON_SYSCONFIGDATA_NAME
 	${STAGING_BINDIR_NATIVE}/scons ${PARALLEL_MAKE} PREFIX=${prefix} prefix=${prefix} ${EXTRA_OESCONS} || \
 	die "scons build execution failed."
 }
 
 scons_do_install() {
-	unset _PYTHON_SYSCONFIGDATA_NAME
 	${STAGING_BINDIR_NATIVE}/scons install_root=${D}${prefix} PREFIX=${prefix} prefix=${prefix} ${EXTRA_OESCONS} install || \
 	die "scons install execution failed."
 }
diff --git a/meta/lib/oe/prservice.py b/meta/lib/oe/prservice.py
index 2d3c9c7e50..fcdbe66c19 100644
--- a/meta/lib/oe/prservice.py
+++ b/meta/lib/oe/prservice.py
@@ -3,10 +3,6 @@
 #
 
 def prserv_make_conn(d, check = False):
-    # Otherwise this fails when called from recipes which e.g. inherit python3native (which sets _PYTHON_SYSCONFIGDATA_NAME) with:
-    # No module named '_sysconfigdata'
-    if '_PYTHON_SYSCONFIGDATA_NAME' in os.environ:
-        del os.environ['_PYTHON_SYSCONFIGDATA_NAME']
     import prserv.serv
     host_params = list([_f for _f in (d.getVar("PRSERV_HOST") or '').split(':') if _f])
     try:
diff --git a/meta/recipes-core/glib-2.0/glib.inc b/meta/recipes-core/glib-2.0/glib.inc
index 7ebed0e5fd..c3ddf18387 100644
--- a/meta/recipes-core/glib-2.0/glib.inc
+++ b/meta/recipes-core/glib-2.0/glib.inc
@@ -32,10 +32,6 @@ inherit meson gettext gtk-doc pkgconfig ptest-gnome upstream-version-is-even bas
 
 GTKDOC_MESON_OPTION = "gtk_doc"
 
-# This avoids the need to depend on target python3, which in case of mingw is not even possible.
-# meson's python configuration pokes into python3 configuration, so this provides the native config to it.
-unset _PYTHON_SYSCONFIGDATA_NAME
-
 S = "${WORKDIR}/glib-${PV}"
 
 PACKAGECONFIG ??= "system-pcre libmount \
diff --git a/meta/recipes-graphics/mesa/mesa.inc b/meta/recipes-graphics/mesa/mesa.inc
index b7ef496fdc..a1bf878b1a 100644
--- a/meta/recipes-graphics/mesa/mesa.inc
+++ b/meta/recipes-graphics/mesa/mesa.inc
@@ -26,11 +26,6 @@ PROVIDES = " \
 
 inherit meson pkgconfig python3native gettext features_check
 
-# Unset these to stop python trying to report the target Python setup
-_PYTHON_SYSCONFIGDATA_NAME[unexport] = "1"
-STAGING_INCDIR[unexport] = "1"
-STAGING_LIBDIR[unexport] = "1"
-
 BBCLASSEXTEND = "native nativesdk"
 
 ANY_OF_DISTRO_FEATURES_class-target = "opengl vulkan"
-- 
2.29.2

