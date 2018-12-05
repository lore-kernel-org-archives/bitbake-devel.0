Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id D3399744DB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Dec 2018 13:07:05 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id p4so19605717wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Dec 2018 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=HXxZuDTfaVivytmSMkcwXhhJZyy0ICS1kbrVROXc0Qc=;
	b=Z82qNK8K04TsA3Qf9lpl0R+ReRC7of3Je22eRDOJa/MuPVP0eFhL5ptKg1iNMzkIgO
	0C6u3IVXrxi3wbUjXLVrjh/wd7bwcpTYI1Q2MnePYhfIh0W9HYgDy4b16NYHPFs3OWqa
	scng3SDboTfDp6Y8wHRdoSvKNPiZ9dGDVnXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HXxZuDTfaVivytmSMkcwXhhJZyy0ICS1kbrVROXc0Qc=;
	b=kNqf1L+GmDzx68T8Jux8qUMbfxhnc584gblUi03r1wIc5Nkv+J3rt8KP0QadfbKSVg
	BAvmsM+fost26zfcOKm9OIUEPx/06NBkZEQJcVsg/vhrPMnAdjsPLL65Alb0e/FsO3Dn
	31MwhMPFLpXpe100AhpzGqnfJyIQbtgc8K9raADh9KQDn1ZIx8u9/IVJE9ky/AGCPEhv
	+huduwX/5rxuvW/d1lKJ8DgvZCFCVwpiYNdk4dQ0AUjj4Evmw5/C/M8ck3I30x0QRmiU
	rWz8V+W3HZQXCSVVOb/+zalKYOSwNi7yS+8my0mGCepw8bUm13JM7Av/oLBXQVK+ka4w
	kZww==
X-Gm-Message-State: AA+aEWYvFDTbwuZv/jjV3kPTIQ98CytQefLrBTb/gcmLZUMIKqR4X6Tc
	yyVY2pgZT0w+8eKg1xgeftjfEwIiZiE=
X-Google-Smtp-Source: AFSGD/XWJEERyIeoAmXCj8G1KiCgVcabUUbOv9/IEWNvdsmlPyfN+kqtwzMcsGPikrSvr6rospwSNA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr21106707wrs.268.1544015226217;
	Wed, 05 Dec 2018 05:07:06 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l197sm11825711wma.44.2018.12.05.05.07.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Dec 2018 05:07:05 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Dec 2018 13:07:01 +0000
Message-Id: <20181205130703.13546-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
References: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] server/process: Handle short reads
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
X-List-Received-Date: Wed, 05 Dec 2018 13:07:06 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index d56681c5a9..fd1ba47fd5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -407,9 +407,9 @@ class BitBakeServer(object):
             except EOFError:
                 # Trap the child exitting/closing the pipe and error out
                 r = None
-        if not r or r != "ready":
+        if not r or r[0] != "r":
             ready.close()
-            bb.error("Unable to start bitbake server")
+            bb.error("Unable to start bitbake server (%s)" % str(r))
             if os.path.exists(logfile):
                 logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
                 started = False
@@ -450,7 +450,7 @@ class BitBakeServer(object):
         os.close(self.readypipe)
         writer = ConnectionWriter(self.readypipein)
         self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
-        writer.send("ready")
+        writer.send("r")
         writer.close()
         server.cooker = self.cooker
         server.server_timeout = self.configuration.server_timeout
-- 
2.19.1


