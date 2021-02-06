Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.13626.1612652935313022123
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=CgsxxD9X;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: akuster808@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id x23so5420314pfn.6
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=K4G3tgUKGR9aiqW21t6dYCu0SXay/oalN1lnc1qJzk8=;
        b=CgsxxD9XWWgPkBHbtN8mofwRamJ0hfI5dRBolnfKM+UPJeJrZm1OafCJvAbjOP78gA
         bCltRbLu4CVduyow6JmSg90BikYhdJaXKWwaEVn1p0Zs9C84xIyvoTryFYaPLCk9JnF7
         118Aq2r/4I5D6nQTm36dGKwm0v5DZEHaKj7Kjt4BdJ076zMjp2lyPsd+XjF/Sc7TsdOd
         5iea400BvleRj0aLHKk4DO9RuZUJ6AcCASuI4527fXfzJHk0dX+r8s52otWWGFzuHkDN
         xDGaPsKinX7bz5BcY2qgiYkF03EthITn/2Yvurr8wkK6zgM+xFeYsP+E255qpsGPugZc
         h5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=K4G3tgUKGR9aiqW21t6dYCu0SXay/oalN1lnc1qJzk8=;
        b=N7PH41BCk+RIPkipvHZWCOWuZRCEwhIPYvBCmJp0q/bRDWxSTdedUB+an0kfn/vtsf
         zFkaMqVXtkpCxMJLuR+tCyXjUuSyCbxJc0HI8pbjg3H+J5v5FMyRMJefaroh0KzI4fIv
         jhI9TDgtk3jK+O2F1FNGJC6esxnO2TywW0dfT8GRhA0J6etM+Td0Oat36AAYU95ieTCy
         IDB1D/ZlyEWEVRGAtm7ZZyTVhE7vIqrvmoOUuMsR9dPpavlkYemHebff3RI41szonnUI
         7ogeN2SeXN6l56AzmsyjG0O69p185Uq3gRdZccATn61wLplavviieN0gOrjyXv+HDndA
         Phhw==
X-Gm-Message-State: AOAM533ZXi+oghgr1YTJ5STmHvPRHSASqFbGvjedYdqWQR+hx2F5ipdO
	UYQ/rF+WL6e/N0G+05gaK0VBkCIvmetlAQ==
X-Google-Smtp-Source: ABdhPJwDV8LArKTy49t+BfGH5K/cLf+euQr6MFeAruPgkEkf3YpF3ydoOeeIJOwTOo0hN9z6fO/qgg==
X-Received: by 2002:a65:5b0c:: with SMTP id y12mr11374249pgq.407.1612652934492;
        Sat, 06 Feb 2021 15:08:54 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:54 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 03/10] xmlsec1: Fix configure QA error caused by host lookup path
Date: Sat,  6 Feb 2021 15:08:40 -0800
Message-Id: <027407dfdc5a9cdab33eb4abc5fd0da350093e84.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: Anatol Belski <anbelski@linux.microsoft.com>

The configure script contains hardcoded lookup paths to /usr and other
paths that might interfere with the host. These are overwritten with the
staging dir locations for Poky compatibility.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 74b66d1911118bac53033f77ba6d3923f4809d5a)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../xmlsec1/ensure-search-path-non-host.patch | 22 +++++++++++++++++++
 .../recipes-support/xmlsec1/xmlsec1_1.2.30.bb |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch

diff --git a/meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch b/meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch
new file mode 100644
index 0000000000..a5a298af0d
--- /dev/null
+++ b/meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch
@@ -0,0 +1,22 @@
+xmlsec1: Fix configure QA error caused by host lookup path
+
+ERROR: mc:my-sdk:xmlsec1-1.2.30-r0 do_configure: QA Issue: This autoconf log indicates errors, it looked at host include and/or library paths while determining system capabilities.
+
+It will eventually arise after the configure QA as the configure script should only look at the staging sysroot dir, not at the host.
+
+Upstream-Status: Inappropriate [embedded specific]
+Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
+
+--- a/configure.ac.orig   2021-01-13 14:37:42.254991177 +0000
++++ b/configure.ac        2021-01-13 14:40:56.546269330 +0000
+@@ -250,8 +250,8 @@
+ dnl ==========================================================================
+ dnl Common installation locations
+ dnl ==========================================================================
+-COMMON_INCLUDE_DIR="/usr/include /usr/local/include"
+-COMMON_LIB_DIR="/usr/lib /usr/lib64 /usr/local/lib"
++COMMON_INCLUDE_DIR="${STAGING_INCDIR}"
++COMMON_LIB_DIR="${STAGING_LIBDIR}"
+ case $host in
+     i*86-*-linux-gnu)   COMMON_LIB_DIR="$COMMON_LIB_DIR /usr/lib/i386-linux-gnu" ;;
+     x86_64-*-linux-gnu) COMMON_LIB_DIR="$COMMON_LIB_DIR /usr/lib/x86_64-linux-gnu" ;;
diff --git a/meta-oe/recipes-support/xmlsec1/xmlsec1_1.2.30.bb b/meta-oe/recipes-support/xmlsec1/xmlsec1_1.2.30.bb
index 93b0d6a67f..2a74d18899 100644
--- a/meta-oe/recipes-support/xmlsec1/xmlsec1_1.2.30.bb
+++ b/meta-oe/recipes-support/xmlsec1/xmlsec1_1.2.30.bb
@@ -19,6 +19,7 @@ SRC_URI = "http://www.aleksey.com/xmlsec/download/${BP}.tar.gz \
     file://xmlsec1-examples-allow-build-in-separate-dir.patch \
     file://0001-nss-nspr-fix-for-multilib.patch \
     file://run-ptest \
+    file://ensure-search-path-non-host.patch \
     "
 
 SRC_URI[md5sum] = "b66ec21e0a0ac331afb4b1bc5c9ef966"
-- 
2.17.1

