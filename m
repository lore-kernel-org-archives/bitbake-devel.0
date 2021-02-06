Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web08.13826.1612652937507422159
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=fX9yhC7D;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id t11so3636561pgu.8
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=P8G2jf3+MYwHVZwBZ6naT76C1hk9WRlKfWE2fnn10AM=;
        b=fX9yhC7D9mhXSIXQH8r/ElXvVLSCyYYiLjvBRucqsf+AwYe1J4WMAQtIopScyMfRUH
         3/8TF+X/pj/b/fR1MHe6DvbHbT66cm63svEHA0nMiX850AUYn7oceoM0ZuUOTGvKLrsL
         solSrQhVW+olrQX9DHvEbGfUCfjZCI50LAce9i8j95VNFTl2V1GEcIU0DiqqA8706Jj7
         yGe1ByakiKy6PdeD+nzgjlmLJ3Ezgg93rJmeOT7gXa89sIbZYDZhNuiSl7QkJuKARa7m
         11W1hgxXjGY32+714llt3aw9MjpsmOB/YGUkpGOUBalZb+Bpn1E4+PECo9hzju9ftrHS
         xujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=P8G2jf3+MYwHVZwBZ6naT76C1hk9WRlKfWE2fnn10AM=;
        b=C2sSSMRxBfeRaL6055ylUVXOFTtvPjXFQBQLoCcy3Poi6Dy1+SeDFfYGb13sFPXNq9
         dPeZjk6bzyULdYvcHreXLg7/hNvYQrK8l52HWXXP0WF2HlCDOJmmYHc2vdrqYV1vp+bW
         cYVa7dKKra6xLyRUdlWfjib7lTSTDSxchMniHt1NtvGxhpcPcOtcgPVHdeAHZOkwx3gF
         8on3fev3o+xdUzMnncByNesT/YeRKNatdbvcRdEb+VUZkoMOIwkVnGFAJhQFxFAuyqSQ
         uLJo/UNbcIg/rxLcF8MTqRvAJtcEoNq9DTDJrYKB6bjRTWK8DkIjbj2x+CDMTpXS7RWp
         HgNw==
X-Gm-Message-State: AOAM531GoUv9+QmtmNJSxPrf7EHSAhEgDQo5CAbCrgA/sVxAgv6ofU67
	c5uFxR7OmaFv+hAYF6sr9OrhuO2Bo6wF2g==
X-Google-Smtp-Source: ABdhPJyQLDBuVNraSmVHICQXEZVNiThSGP0V1qHIAoZ0y4p/LLlQLtmecGetXnNFSS0NzIOoLLaCkg==
X-Received: by 2002:a63:8f59:: with SMTP id r25mr5927402pgn.161.1612652936955;
        Sat, 06 Feb 2021 15:08:56 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:56 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 05/10] sip3: simplify recipe
Date: Sat,  6 Feb 2021 15:08:42 -0800
Message-Id: <ba3c1dcf19ee018963471015b2e8b30ef9830d35.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: "S. Lockwood-Childs" <sjl@vctlabs.com>

The custom configure block can be shared between target
and native if you just configure the sysroot option accordingly
and use STAGING_INCDIR to locate the python headers to build
against.

Signed-off-by: S. Lockwood-Childs <sjl@vctlabs.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 5fe362171c7f3426fced0c7889facec397c9cc5e)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-devtools/sip/sip3_4.19.23.bb | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/meta-oe/recipes-devtools/sip/sip3_4.19.23.bb b/meta-oe/recipes-devtools/sip/sip3_4.19.23.bb
index 320755b844..ae8df5055a 100644
--- a/meta-oe/recipes-devtools/sip/sip3_4.19.23.bb
+++ b/meta-oe/recipes-devtools/sip/sip3_4.19.23.bb
@@ -19,24 +19,17 @@ PACKAGES += "python3-sip3"
 
 BBCLASSEXTEND = "native"
 
-do_configure_prepend_class-target() {
-    echo "py_platform = linux" > sip.cfg
-    echo "py_inc_dir = %(sysroot)/${includedir}/python%(py_major).%(py_minor)${PYTHON_ABI}" >> sip.cfg
-    echo "sip_bin_dir = ${D}/${bindir}" >> sip.cfg
-    echo "sip_inc_dir = ${D}/${includedir}" >> sip.cfg
-    echo "sip_module_dir = ${D}/${libdir}/python%(py_major).%(py_minor)/site-packages" >> sip.cfg
-    echo "sip_sip_dir = ${D}/${datadir}/sip" >> sip.cfg
-    ${PYTHON} configure.py --configuration sip.cfg --sip-module PyQt5.sip --sysroot ${STAGING_DIR_HOST} CC="${CC}" CXX="${CXX}" LINK="${CXX}" STRIP="" LINK_SHLIB="${CXX}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LFLAGS="${LDFLAGS}"
-}
+CONFIGURE_SYSROOT = "${STAGING_DIR_HOST}"
+CONFIGURE_SYSROOT_class-native = "${STAGING_DIR_NATIVE}"
 
-do_configure_prepend_class-native() {
+do_configure_prepend() {
     echo "py_platform = linux" > sip.cfg
-    echo "py_inc_dir = ${includedir}/python%(py_major).%(py_minor)${PYTHON_ABI}" >> sip.cfg
+    echo "py_inc_dir = ${STAGING_INCDIR}/python%(py_major).%(py_minor)${PYTHON_ABI}" >> sip.cfg
     echo "sip_bin_dir = ${D}/${bindir}" >> sip.cfg
     echo "sip_inc_dir = ${D}/${includedir}" >> sip.cfg
     echo "sip_module_dir = ${D}/${libdir}/python%(py_major).%(py_minor)/site-packages" >> sip.cfg
     echo "sip_sip_dir = ${D}/${datadir}/sip" >> sip.cfg
-    ${PYTHON} configure.py --configuration sip.cfg --sip-module PyQt5.sip --sysroot=${STAGING_DIR_NATIVE}
+    ${PYTHON} configure.py --configuration sip.cfg --sip-module PyQt5.sip --sysroot ${CONFIGURE_SYSROOT} CC="${CC}" CXX="${CXX}" LINK="${CXX}" STRIP="" LINK_SHLIB="${CXX}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LFLAGS="${LDFLAGS}"
 }
 
 do_install() {
-- 
2.17.1

