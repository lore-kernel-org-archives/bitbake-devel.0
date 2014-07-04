Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id 4DF1C6AC9C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:28 +0000 (UTC)
Received: by mail-we0-f182.google.com with SMTP id q59so1641054wes.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HSspxfB2HFbgGSkdiA3mXvO3x0photrGmDKki0u4Rn0=;
	b=Q/gAZSToXGj4t/ApVZ5KVTJwrWIEecKt0/p6QWTKjWpBhp3nGbk2T0J/Fu2HBa8R4A
	eIh0CAAXVj4QA3SLzt/R/3INgV3Rjo57qS8Vn7D6+Rj70mtw1Mv7IMwyU5e03YaHnxrq
	cEkAP/q4AhzhdohADrPZgYEO1K9G3E7Q1fBQKfimnXk1YP3nu7tLkxJdiuIHjApDB/qz
	0nzf18/AID3GrOSfLPSk/Qdzg44yLNIHGH7OXXlIDO+H/vDwgKN9tX6y3vbWp3bwixqG
	ORWtD6eH2NePlRKSZ2m8W/XQtmCSmvSTwP67H0wJ3QMHKH9lp6BVgiuIAfQNbKIpg6bI
	M4IQ==
X-Gm-Message-State: ALoCoQlL0F09qxDLvbcaLcoVz8S7Vxg/rCFUsD85VtCzsb3i/+S7zfU4hzpjdVtzM0xacAYKngbc
X-Received: by 10.180.198.116 with SMTP id jb20mr17433926wic.59.1404477869601; 
	Fri, 04 Jul 2014 05:44:29 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l2sm25035425wjw.31.2014.07.04.05.44.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 22A595611B0; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:21 +0100
Message-Id: <9949948f92bbe2717a05a380d3df63a332d39c9a.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/9] toasterui: Show in the log that ToasterUi is ready to receive events.
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:32 -0000

From: Dave Lerner <dave.lerner@windriver.com>

Issue: TA53702

It was observed that a sequence in a script such as
   bitbake --server-only ..
   bitbake --observe-only ..
   bitbake <some target>
could generate events from the server to the observer before
the observer was ready to read the events, and the early events
of builds were consistently dropped.  Adding a "ready" note in the
log allows the script to scan for that message before proceeding
to building a target.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/toasterui.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index b1c80cc..5f87a9d 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -91,6 +91,7 @@ def main(server, eventHandler, params ):
     errors = 0
     warnings = 0
     taskfailures = []
+    first = True
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
@@ -98,6 +99,9 @@ def main(server, eventHandler, params ):
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
+            if first:
+                first = False
+                logger.info("ToasterUI waiting for events")
 
             if event is None:
                 if main.shutdown > 0:
-- 
1.9.1


