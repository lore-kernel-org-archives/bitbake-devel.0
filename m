Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id E07A67FAA8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 20:54:19 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id 4so2797766wro.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BPF75SOhAS+BJKTcDaSTxiofLTTojdl5H0ZeKRbyu24=;
	b=CGDv2gwXxTXYdCOwebcGRTo9yNqL4szOUr2kDZRxKwhXL0dQrpKnylB89GAKdQmRs+
	netFgY/lz30S0R44yToC5VnEMIWXdAowsa7I1Lg8d7eotLAhkYSGVwLPr+am0pTwTsMa
	96/UOdoudqTM3vJXNLR3qDk1hkwCQGDmQlpIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BPF75SOhAS+BJKTcDaSTxiofLTTojdl5H0ZeKRbyu24=;
	b=DXqHa3ob87F1wTyZVGt2uCiO31vajCS3hIQ4Poge+srI5gaswZPjK/cGwgUZgeQ+y2
	EylTVAl7jlRPT7gDQW9FnpAeDj1oNZwFGLt7gtX8E0+jHvx2uJiLDqFOS6W6lrUan9/J
	xD1a3F1faNYbG93z5UHBsB5CIb0mTdzkqUkI4ggrgU7mlr7M95KNWRBqWy7LtSiej/fM
	Ej/XowhWwVsisGX095HQj2JdLcHFkfT9Ea3JP9tircbW/va+mXPOkzngoG6dIsRdf1hc
	f4rRZkN7vly9T1seoWNp58QhUODmVgTvii4c/uyYE+OtkIV2rsa3NvNGZ92vZPkckCVe
	8Thg==
X-Gm-Message-State: APjAAAWmbzqRSLyhaaseLAGtBpcZpq8wNdSinD7DKneiMrj+WHfRz1pc
	JR9UUjjJYPPuIpODks4gHiuRotXpHt8=
X-Google-Smtp-Source: APXvYqy5lhIBQi+Ut8syTT3Tfiqc5fiuX2zPWRytSbfKjJunCNNcWufvx7v+U0aAA84YiXoTlKgXNg==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr13212063wrv.316.1574369660320;
	Thu, 21 Nov 2019 12:54:20 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w12sm925982wmi.17.2019.11.21.12.54.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 21 Nov 2019 12:54:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2019 20:54:13 +0000
Message-Id: <20191121205415.25946-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/5] sanity: Add check for tar older than 1.28
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
X-List-Received-Date: Thu, 21 Nov 2019 20:54:20 -0000
Content-Transfer-Encoding: 8bit

Older versions break opkg-build when reproducible builds are enabled.
Rather than trying to be selective based on which features are enabled,
lets just make this a minimum version.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 meta/classes/sanity.bbclass | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meta/classes/sanity.bbclass b/meta/classes/sanity.bbclass
index a14bf53883c..12ea14796e8 100644
--- a/meta/classes/sanity.bbclass
+++ b/meta/classes/sanity.bbclass
@@ -523,6 +523,7 @@ def check_wsl(d):
 
 # Tar version 1.24 and onwards handle overwriting symlinks correctly
 # but earlier versions do not; this needs to work properly for sstate
+# Version 1.28 is needed so opkg-build works correctly when reproducibile builds are enabled
 def check_tar_version(sanity_data):
     from distutils.version import LooseVersion
     import subprocess
@@ -532,7 +533,9 @@ def check_tar_version(sanity_data):
         return "Unable to execute tar --version, exit code %d\n%s\n" % (e.returncode, e.output)
     version = result.split()[3]
     if LooseVersion(version) < LooseVersion("1.24"):
-        return "Your version of tar is older than 1.24 and has bugs which will break builds. Please install a newer version of tar.\n"
+        return "Your version of tar is older than 1.24 and has bugs which will break builds. Please install a newer version of tar (1.28+).\n"
+    if LooseVersion(version) < LooseVersion("1.28"):
+        return "Your version of tar is older than 1.28 and does not have the support needed to enable reproducible builds. Please install a newer version of tar (you could use the projects buildtoold-tarball from our last release).\n"
     return None
 
 # We use git parameters and functionality only found in 1.7.8 or later
-- 
2.20.1


