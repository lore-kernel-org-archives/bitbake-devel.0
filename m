Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id A40FE70476
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:28 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id q58so7849747wes.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HSspxfB2HFbgGSkdiA3mXvO3x0photrGmDKki0u4Rn0=;
	b=EGmSoTHyIMLHyga6N5sEjjXlFn1AOp/obuqgYNBx4rNJm5MuaRehvVvXlabcnR1Vni
	xb6/hNKeyoEMZhPcwNMUZEDPetcBoydimoiUeKLMpa+es4MF1Jg2Q1jsMxlBPQxqhuim
	zzM2hvYIxg8zde1/k7+RSwrB8KTB8SjqRrIIXlOcWnwVyDC0Q8uXBzo6kHnSD6ABFZMq
	Dj7mJPAY8qpJxut7N3I9URGWAug5EP37wajwJG0N/+2+9O/cc7NErl0/uktCB3dsDz/5
	rYHuABg1Y65PrkSHKkeGNp79YY8EvEXnPQTI0le/1kQSWizRBp5YyJiZKmsipsRbngHn
	yPEg==
X-Gm-Message-State: ALoCoQlLZvkNDgm6RSdRXeQOZ3+2LSLAm+3l4iPD0RyAzPwvkkbTmzxdAbqdWJ1zglRzHd2twsis
X-Received: by 10.194.177.168 with SMTP id cr8mr4465734wjc.134.1404924929978; 
	Wed, 09 Jul 2014 09:55:29 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id o9sm21286640wib.22.2014.07.09.09.55.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9359E560A37; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:20 +0100
Message-Id: <9949948f92bbe2717a05a380d3df63a332d39c9a.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:30 -0000

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


