Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 089FD79B30
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 12:36:56 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j10so3671834wru.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=fHwXAUEaalRnjq1NdwbmRfh9vqm37AFF0wEGIO1e/P0=;
	b=B+Oj5gqdjntOz212NMjKE/9Vl61b75SHinDq6ZMAxrw9zzSpe6bRkA4YaFnGQDKzdw
	mGDJhyDW9crubvmB2cccQ6i8Z2e05u8ffupnlLseVIR1g5TW4SIugPb1SGey21RoLN4x
	8/188hslvac6NS7FH6MqW+iReWDMU4MPhj6Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fHwXAUEaalRnjq1NdwbmRfh9vqm37AFF0wEGIO1e/P0=;
	b=PNHsEPqnePUbQySOQcQrW1T+8HZISVVTgquwOX9aA4bgpyyfVrLWjEtecNe8/YQSoq
	NOpYqzWdjNya9xjjmlu0Ky9eG4ICnHA5FQiRG57fydTOk3McVdYXr23xYCW/L6IcWjZ8
	I75CJCEl+kkk2fWbY44b1xaV8CDfg+8Yko8NWvcPIq+fHjw4INVEtqFfNYt1IlIDkSND
	DcLMGc27ADueCFVRI2n2TFbWdYreK+ImFuZk0NF6Czn1Xt3ISckjGN2IMvJtLevanPtl
	jFfENVKwofQTFxsJIMiguG9d7TY1lR7NeVY+k+HRpuz4OhX+bcIFCOKUJLHnLi+sciPy
	uYUA==
X-Gm-Message-State: AA+aEWaCSy1OLRVmjZ6KfkZcL2SgOIzfv3mNiqZSGOBm8l6im+zvOk/5
	DWWsjGjHuMxzZLnuC4ujWf+pQDm2AcM=
X-Google-Smtp-Source: AFSGD/WjjFLX/Xi1bBgN4lMz4Tk79t2E5FXGj/86R/UvZrMwcaCGwWvpUCyUeShbr7F22aITdq1AAA==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr1783031wrw.113.1544186217474; 
	Fri, 07 Dec 2018 04:36:57 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g198sm5216657wmd.23.2018.12.07.04.36.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Dec 2018 04:36:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Dec 2018 12:36:54 +0000
Message-Id: <20181207123654.13832-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207123654.13832-1-richard.purdie@linuxfoundation.org>
References: <20181207123654.13832-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] cooker: Add some timing debug messages to the server startup
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
X-List-Received-Date: Fri, 07 Dec 2018 12:36:57 -0000
Content-Transfer-Encoding: 8bit

We're seeing slow startup in bitbake, add some timeing debug messages so
the logs are more useful for debugging when its slow.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 16681ba244..18979362b6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -175,18 +175,31 @@ class BBCooker:
 
         self.configuration = configuration
 
+        bb.debug(1, "BBCooker starting %s" % time.time())
+        sys.stdout.flush()
+
         self.configwatcher = pyinotify.WatchManager()
+        bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
+        sys.stdout.flush()
+
         self.configwatcher.bbseen = []
         self.configwatcher.bbwatchedfiles = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
+        bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
+        sys.stdout.flush()
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
         self.watcher = pyinotify.WatchManager()
+        bb.debug(1, "BBCooker pyinotify3 %s" % time.time())
+        sys.stdout.flush()
         self.watcher.bbseen = []
         self.watcher.bbwatchedfiles = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
+        bb.debug(1, "BBCooker pyinotify complete %s" % time.time())
+        sys.stdout.flush()
+
         # If being called by something like tinfoil, we need to clean cached data
         # which may now be invalid
         bb.parse.clear_cache()
@@ -196,6 +209,9 @@ class BBCooker:
 
         self.initConfigurationData()
 
+        bb.debug(1, "BBCooker parsed base configuration %s" % time.time())
+        sys.stdout.flush()
+
         # we log all events to a file if so directed
         if self.configuration.writeeventlog:
             # register the log file writer as UI Handler
@@ -233,6 +249,9 @@ class BBCooker:
         # Let SIGHUP exit as SIGTERM
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
+        bb.debug(1, "BBCooker startup complete %s" % time.time())
+        sys.stdout.flush()
+
     def process_inotify_updates(self):
         for n in [self.confignotifier, self.notifier]:
             if n.check_events(timeout=0):
-- 
2.19.1


