Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6E51E7FA3E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 20:54:22 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 8so5325176wmo.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=6wWIYq+IRh9PSKdV0ilAz0IXk7J/ubdwyQ0hlRnS2ZI=;
	b=IrA+D+xg1v1TdlM4240ivlGSb5FpcRWlx6+AWcCu5NaAoEKc672dkpDn+8vJkFXP+h
	+CKeW1FzAzPRyKt+EMPc+n4mHNFWDdEdFr1VWD/LMJTNx74K1S5O1AEhGiqACNsbctEk
	ZgW34tSCUoTWFP90ubEbY6gO6ZPtM2PQQI+uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6wWIYq+IRh9PSKdV0ilAz0IXk7J/ubdwyQ0hlRnS2ZI=;
	b=mIjtZy3t9+92217oZE4Q0E3oj3XwSGlOyEzZ9lPuBeyUQAupRXqjlkuUPqgdJPnbML
	MJXiotG8loklXx6wOgTGbLccJ3QAfsv/iqFhfZRl1h9DNi/aopHDSpXYdSYZXe5iKtl+
	Tfk+ud7y+PDKv8D4IdM0A7avq3jJQoKK1+KZEhwavg3ypXIf8PFMhmU7EPpMN/FwSqCv
	9TKJGBZk0oOIiH1t/gX+1d20rIZsEQP8Ar9axi5tYI72OgJLnQRDdm/deExkmpxLIB9F
	rkxcYOTID/vxmmopH+0Zuk5ZkKL2gRQYHr5NhwzbEvCHwGoHWvmNJXCLsFqo8cOz1bOK
	p5Uw==
X-Gm-Message-State: APjAAAVbh6PxGmewED24kb/bEluwrddhHJdW2g1pzX3W6/qc+N7PCKUp
	yA/ZtbdHoehTVPCfBjOJbkP0PleN/lg=
X-Google-Smtp-Source: APXvYqxdlwyr6y4a/gJtgSYomHUhmTaaObvCcHIWlr7i+//ECG5Hdl3NwPuf85MvP5MFXTflkoL71w==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr12111863wmh.82.1574369662836; 
	Thu, 21 Nov 2019 12:54:22 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w12sm925982wmi.17.2019.11.21.12.54.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 21 Nov 2019 12:54:22 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2019 20:54:15 +0000
Message-Id: <20191121205415.25946-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/5] oeqa/selftest/sstatetests: Ensure we don't use hashequiv for sstatesigs tests
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
X-List-Received-Date: Thu, 21 Nov 2019 20:54:22 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 meta/lib/oeqa/selftest/cases/sstatetests.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/meta/lib/oeqa/selftest/cases/sstatetests.py b/meta/lib/oeqa/selftest/cases/sstatetests.py
index 2867cb78abb..6757a0ec689 100644
--- a/meta/lib/oeqa/selftest/cases/sstatetests.py
+++ b/meta/lib/oeqa/selftest/cases/sstatetests.py
@@ -255,6 +255,7 @@ BUILD_ARCH = "x86_64"
 BUILD_OS = "linux"
 SDKMACHINE = "x86_64"
 PACKAGE_CLASSES = "package_rpm package_ipk package_deb"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash")
         bitbake("core-image-sato -S none")
@@ -266,6 +267,7 @@ BUILD_ARCH = "i686"
 BUILD_OS = "linux"
 SDKMACHINE = "i686"
 PACKAGE_CLASSES = "package_rpm package_ipk package_deb"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash2")
         bitbake("core-image-sato -S none")
@@ -298,6 +300,7 @@ PACKAGE_CLASSES = "package_rpm package_ipk package_deb"
 TMPDIR = \"${TOPDIR}/tmp-sstatesamehash\"
 TCLIBCAPPEND = \"\"
 NATIVELSBSTRING = \"DistroA\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash")
         bitbake("core-image-sato -S none")
@@ -305,6 +308,7 @@ NATIVELSBSTRING = \"DistroA\"
 TMPDIR = \"${TOPDIR}/tmp-sstatesamehash2\"
 TCLIBCAPPEND = \"\"
 NATIVELSBSTRING = \"DistroB\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash2")
         bitbake("core-image-sato -S none")
@@ -332,11 +336,13 @@ NATIVELSBSTRING = \"DistroB\"
 TMPDIR = \"${TOPDIR}/tmp-sstatesamehash\"
 TCLIBCAPPEND = \"\"
 MACHINE = \"qemux86-64\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """
         configB = """
 TMPDIR = \"${TOPDIR}/tmp-sstatesamehash2\"
 TCLIBCAPPEND = \"\"
 MACHINE = \"qemuarm\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """
         self.sstate_allarch_samesigs(configA, configB)
 
@@ -352,6 +358,7 @@ MACHINE = \"qemux86-64\"
 require conf/multilib.conf
 MULTILIBS = \"multilib:lib32\"
 DEFAULTTUNE_virtclass-multilib-lib32 = \"x86\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """
         configB = """
 TMPDIR = \"${TOPDIR}/tmp-sstatesamehash2\"
@@ -359,6 +366,7 @@ TCLIBCAPPEND = \"\"
 MACHINE = \"qemuarm\"
 require conf/multilib.conf
 MULTILIBS = \"\"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """
         self.sstate_allarch_samesigs(configA, configB)
 
@@ -404,6 +412,7 @@ MACHINE = \"qemux86\"
 require conf/multilib.conf
 MULTILIBS = "multilib:lib32"
 DEFAULTTUNE_virtclass-multilib-lib32 = "x86"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash")
         bitbake("world meta-toolchain -S none")
@@ -414,6 +423,7 @@ MACHINE = \"qemux86copy\"
 require conf/multilib.conf
 MULTILIBS = "multilib:lib32"
 DEFAULTTUNE_virtclass-multilib-lib32 = "x86"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash2")
         bitbake("world meta-toolchain -S none")
@@ -452,6 +462,7 @@ TIME = "111111"
 DATE = "20161111"
 INHERIT_remove = "buildstats-summary buildhistory uninative"
 http_proxy = ""
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash")
         self.track_for_cleanup(self.topdir + "/download1")
@@ -468,6 +479,7 @@ DATE = "20161212"
 INHERIT_remove = "uninative"
 INHERIT += "buildstats-summary buildhistory"
 http_proxy = "http://example.com/"
+BB_SIGNATURE_HANDLER = "OEBasicHash"
 """)
         self.track_for_cleanup(self.topdir + "/tmp-sstatesamehash2")
         self.track_for_cleanup(self.topdir + "/download2")
-- 
2.20.1


