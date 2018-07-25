Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 6807160401
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 13:48:27 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2852743wmc.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=6rvE9N55ceGzAV/NCqIphsI7CkTxabHs5o1YiXX2zpo=;
	b=gu9QJu20xFn3mMalh4j6y4/+EmjjBUn3fCNIWBRR2rEzRvH53T0uFMHQp+IPgHMD2P
	24LVldWvPwt9AOE9jIpvM2GfckX2LWNQFfzdkhBH6A6rwY4hATFbj9wNFCCI+14j93Rj
	agGLx3nUE7manWRhP26KHBYAToKetYdxOC0V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=6rvE9N55ceGzAV/NCqIphsI7CkTxabHs5o1YiXX2zpo=;
	b=qK+hBFsRBA9QP3OOO4R0Dn7kMdp4jBXBwU+qhMJBhtFhJlmTHJ4ILqPw0czP8GguMx
	GwZwFkXgSDmyocHJQNToTz5VPsemCA1p8OUhistKzg9/Fzna58SkX1uoXP7e5Y2nzz2W
	znWxSDiJYQnNvqfmRWhrK3Ntkl2L7CJMfalexwWYDB9pXI0EMDj/pdcioUzPOG5y7++c
	dqlbeEv7KPVNcSLSMgrJo0uQISUG3YOj/AZoQKosoKR1XYlKHKQZAsWLUAQPXBrs/fir
	toE5RY50MXR9guEuVmmtuPlVMCAJ7sgjc/MsDThGUnm26+Wh1DRjsJ+WbtB1ZdDXiyzw
	+6Eg==
X-Gm-Message-State: AOUpUlGKog90Xyp4RmWpu0cJuAH2gwr3YvsaeU9uOl9L0h4ft5iTtn9x
	pnXX2ENK9/YJtFmvj0JqWO/ENqbPPuyNrQ==
X-Google-Smtp-Source: AAOMgpcLUbXUd2XcsNgxgL9F6JjV3PSXxRjQ/uYwPAqiLYXDfyILLYkpnZFPf+Q3tlgdcM56pED+6w==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr4506412wmh.34.1532526507816;
	Wed, 25 Jul 2018 06:48:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l14-v6sm33584123wrw.65.2018.07.25.06.48.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Jul 2018 06:48:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 Jul 2018 14:48:26 +0100
Message-Id: <20180725134826.5732-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] server/process: Always place the server logfile in the build directory
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
X-List-Received-Date: Wed, 25 Jul 2018 13:48:27 -0000

Currently the bitbake-cookerdaemon.log is placed into cwd. This seems like a
bad idea, we can place it in the build directory alongside the lockfile that
represents the server instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 828159ed75..9e5e709f04 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -377,11 +377,12 @@ class BitBakeServer(object):
         if os.path.exists(sockname):
             os.unlink(sockname)
 
+        # Place the log in the builddirectory alongside the lock file
+        logfile = os.path.join(os.path.dirname(self.bitbake_lock.name), "bitbake-cookerdaemon.log")
+
         self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
         # AF_UNIX has path length issues so chdir here to workaround
         cwd = os.getcwd()
-        logfile = os.path.join(cwd, "bitbake-cookerdaemon.log")
-
         try:
             os.chdir(os.path.dirname(sockname))
             self.sock.bind(os.path.basename(sockname))
-- 
2.17.1


