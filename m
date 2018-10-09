Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 6FB4371B27
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Oct 2018 18:01:27 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id y11-v6so2777632wma.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Oct 2018 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=1YQfxVnOC/dlkcPomnyELceM6Vk+Gty18ql46V7967Y=;
	b=MA+4drjwwvVxT4cEbLLqgX7/jwXjGUVvzzI/Ykcv6PrCUavkQkcDiSMH1K6czm0Xyq
	yZRTh995/lJ0zL7iuwU8seHvX6XYiwK1lmjofQwuIZo5L/jF1Mq+MsGZ4/y5a7/RRqcU
	pQ+agUocjfTElzBUlf3TGpK6tgW5vYvolmHeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=1YQfxVnOC/dlkcPomnyELceM6Vk+Gty18ql46V7967Y=;
	b=jpoLyt7FqfXIMkvC3FVV7MVwuATkGj8SS4k6zhLZKGNHDM4/CV0z8JYCrP7corc7E7
	+AU83o0/ws4MOk1hor0Wal4gl7VOOFuheqFvZjkditk3SIRtleZpA+9qATz4VmkFe+Ea
	jtO9VXukXaN5Io09Z/X7RBxhP89cUoNhYf23QHH+B98keHKh+V6G7GHjNOooSQCh+uDc
	7vnJdrbDti7zfnrc4VgwMNTSCs8KmI1BhN6LB0ZHNmnXLVNmvkRRjkvgdWlfVglRmM2a
	/Ip0+b8+39U0V8XsnACavB3ZB87ESn8mzE+7a7zykQVqzQ6RooR6+Xnw/efCMu23gAPX
	anIg==
X-Gm-Message-State: ABuFfohvatKCMEMAIp6nkmvfSEJ+LV7BTWtTxmJZQd9YPWzNcal0fBls
	qlaksiv7H6VoekdNAppIUkpAMx24FC0=
X-Google-Smtp-Source: ACcGV62tqfVNLAhX+0HCFk2Bhwbwt3zWGyXcqVvW+pOltVQ0mm5QibS6GXKcNtsvzyuVf8CpiWzIaw==
X-Received: by 2002:a1c:b90c:: with SMTP id
	j12-v6mr2936264wmf.32.1539108087569; 
	Tue, 09 Oct 2018 11:01:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x8-v6sm36200168wrd.54.2018.10.09.11.01.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Oct 2018 11:01:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  9 Oct 2018 19:01:25 +0100
Message-Id: <20181009180125.19874-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] main: Fix environment handling for UI module imports
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
X-List-Received-Date: Tue, 09 Oct 2018 18:01:28 -0000

The environment was being cleared before the UI imports occurred which
caused problems for graphical UIs like taskexp. The full environment was
intended to be available to UI clients and it was only meant to be cleared
for the server/cooker, so tweak the code order so this is the case.

This fixes problems reported for taskexp.

[YOCTO #12670]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index f4474e410f..732a315404 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -405,9 +405,6 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
         # In status only mode there are no logs and no UI
         logger.addHandler(handler)
 
-    # Clear away any spurious environment variables while we stoke up the cooker
-    cleanedvars = bb.utils.clean_environment()
-
     if configParams.server_only:
         featureset = []
         ui_module = None
@@ -423,6 +420,10 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
 
     server_connection = None
 
+    # Clear away any spurious environment variables while we stoke up the cooker
+    # (done after import_extension_module() above since for example import gi triggers env var usage)
+    cleanedvars = bb.utils.clean_environment()
+
     if configParams.remote_server:
         # Connect to a remote XMLRPC server
         server_connection = bb.server.xmlrpcclient.connectXMLRPC(configParams.remote_server, featureset,
-- 
2.17.1


