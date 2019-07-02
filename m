Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id BAC757EB91
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 11:05:38 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id u18so776255wru.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jul 2019 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GczQCQQpXzhSqIzIZXLTdeqgiF3r10/dSQDXRKlhMtE=;
	b=IhMl0awU3YkKMccsbNJsJULWCVx7wXJKkxp7rHAd0CoWMjTVWFtJKihFknIWDxpaGg
	bKsMVLx0CaeTLRonB7xiUUO0kfmgvpsmOze3QZVxRxfJWqwbWlR4KspjU59DytrmJu+h
	Rjs//Eg2hNFshvJLemM0KZe38ceCVbKrsyIv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GczQCQQpXzhSqIzIZXLTdeqgiF3r10/dSQDXRKlhMtE=;
	b=OEgp36Vp+rv9E9vnyMOhBy5tcR5Zb1N/1fzBJzP8ymHCUgAA2zyI2SFZNVFLLp/6G8
	U3xSSQDgcw3IXywquA1pd1ykPDd4xy1yyXwetO1ss69CvLnny6S4mdU/Y6UwvFJiTHUR
	Vpb0iqDQKlFZtno2vYh61AYBPq7z5I473AX86VqGhLnE3B4fJd7ZGdOwm+n17vpNPOc/
	5cZgE+QkMe0P6H3IgJqcQvoECa1ExoIhxE8+gGwzfg+WEE3ltLdJZ3Ue73g69dZ0uwfm
	425Qc6AMAjpmVyelPnVMH14idDC/6F7tptxtGTU2aL8D90KyCfzwdSfWyxcZ1NuTvJ8y
	o0yg==
X-Gm-Message-State: APjAAAVTDYuZPLDXS2IvvRgqcu7Of3BI80Bk8nO0MtV6uzaymXQAkBuD
	XJxrCN/Y7Ue4aN73epfrmZpd+WVyXDo=
X-Google-Smtp-Source: APXvYqymucp0kI3TactaawGHU2wSDpJ+MklRRtLiBwJSqQRf3dRBmn+1Qy0c3g5uEbz68FBM6Xr4Xg==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr7273946wrr.51.1562065539185; 
	Tue, 02 Jul 2019 04:05:39 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm2801068wrw.23.2019.07.02.04.05.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 02 Jul 2019 04:05:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Jul 2019 12:05:35 +0100
Message-Id: <20190702110537.13349-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/3] event: Clear ui_queue after handling it
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
X-List-Received-Date: Tue, 02 Jul 2019 11:05:38 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 7cbb5ca47e..248fc1a6f8 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -124,6 +124,7 @@ def fire_class_handlers(event, d):
 ui_queue = []
 @atexit.register
 def print_ui_queue():
+    global ui_queue
     """If we're exiting before a UI has been spawned, display any queued
     LogRecords to the console."""
     logger = logging.getLogger("BitBake")
@@ -168,6 +169,7 @@ def print_ui_queue():
             logger.removeHandler(stderr)
         else:
             logger.removeHandler(stdout)
+        ui_queue = []
 
 def fire_ui_handlers(event, d):
     global _thread_lock
-- 
2.20.1


