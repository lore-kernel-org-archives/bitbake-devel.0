Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id A25D965F11
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:17 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id f8so6702027wiw.14
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pgpNqoQDYZfxc0L7cXhkJJI0prKPP5fKtOWbVsfWNSk=;
	b=iYMEng5LKP25JKHG+P5c+hn3TtLCAct90+wK4DUxnNejVUrV88/8PHoLTi8b+RCWGz
	y1qTX+A2WoCJJl9VT+Wt+p85tZHVWMbPAxr6HsbpkH4x4715+wW3Qr/7R1D3rVktG34h
	l3nTRMPMiaAgqqVazEdb+TxPz1ACGADik44RLhQer+06lyohWF6+fjZ+Iz1hcZUlTydm
	7OikSr1s8RgQZJy9tqifPz+l5i7mnfTBnD5NyzEHAnrkxjbJI/EkBbAMHo2DncpSVXg7
	sDVcj7A8HWK+iuNVGPQnjhBXKF7HhW78CoxDwpiD1QvlZP5ymF66vm8Zg2UzKGFha7TJ
	qmuA==
X-Gm-Message-State: ALoCoQmM2vCPB1L52L2AC70quG5IkSa1m9o+SVIZNZCw5Zsy+CdPBEBxQ4mBQrVoi8Jpwb89Am37
X-Received: by 10.180.101.98 with SMTP id ff2mr8748116wib.40.1401809177728;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ht5sm44719487wjb.49.2014.06.03.08.26.16 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CB7B15605CC; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:12 +0100
Message-Id: <7b0af0cdbae865c2e0b961fae17c217b1e4ac31a.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/9] uievent: retry on handler registration failure
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The registration of a remote UI event handler may fail
if the server cooker is currently in some certain states.
This may happen, for example, when a remote UI is started
very fast after the bitbake server is started, and the
server hadn't time to finish initial configuration parsing.

Rather than fail outright, we have the remote UI event retry
registration for five time at one-second intervals,
in the hope it will succeed.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/uievent.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index eb760c0..c6b100c 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -44,10 +44,26 @@ class BBUIEventQueue:
         server.register_function( self.send_event, "event.sendpickle" )
         server.socket.settimeout(1)
 
-        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
+        self.EventHandler = None
+        count_tries = 0
 
-        if (self.EventHandle == None):
-            bb.warn("Could not register UI event handler %s:%d" % (self.host, self.port))
+        # the event handler registration may fail here due to cooker being in invalid state
+        # this is a transient situation, and we should retry a couple of times before
+        # giving up
+
+        while self.EventHandler == None and count_tries < 5:
+            self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
+
+            if (self.EventHandle != None):
+                break
+
+            bb.warn("Could not register UI event handler %s:%d, retry" % (self.host, self.port))
+            count_tries += 1
+            import time
+            time.sleep(1)
+
+
+        if self.EventHandle == None:
             raise Exception("Could not register UI event handler")
 
         self.server = server
-- 
1.9.1


