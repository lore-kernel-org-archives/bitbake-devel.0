Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 86B6F6B269
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:55 +0000 (UTC)
Received: by mail-wg0-f50.google.com with SMTP id x13so3484972wgg.33
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jIkgF3KVj5tpa0HGoFtZVClwtCm3XYCcaKaWVNTAEc4=;
	b=RjLV5lC+e/xemkI6c3cPutH9EbVdXZImbvvWJAoiPs6Egxewx4MKdjfmkqsTf6zGMf
	cYsDttvZDt2WdPRsJoIGsKVeeMxpwHIn59znFbWro4GHUX6EKKJe6DWGZvNCxHFU8KQq
	JEVfGahQhRYKJnQuTKk6t6OCEKLU3zJF4R+zXysmb7RQ1bUCcOTPVL/FVIUfsu2C1A/j
	2RUEHGiqx4JgdE2r5y9YULDIRH5CBF1dhMJXAZtWlOXBoLTryq32+ZBlH1GenhdSI7uM
	IypcxaxJdMwLCoci0o9v3YeebX28CwHtDUEM+oDPR1kw2uHV5whnxDihrvWhVlN8oaAd
	ztfQ==
X-Gm-Message-State: ALoCoQkD+Zeq62CBmYAVa4uBqSAjSoVaopWDsEUvuMsqlX59pWgsETb+zxDvANHVO+HleTx2RVPC
X-Received: by 10.194.48.80 with SMTP id j16mr20392724wjn.44.1396620656476;
	Fri, 04 Apr 2014 07:10:56 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h8sm4911108wiz.12.2014.04.04.07.10.54
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:55 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 87F525604B1; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:44 +0100
Message-Id: <6125ccede6e46d08bc05af70e87da47da900bc4b.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/14] toasterui: save warnings from non-build context
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Some warnings and errors may come from a non-build context,
and they were not saved, even if they were counted for the current
build.

This patch saves these messages in memory until we have the
entire build context available.

	[YOCTO #5642]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 18 +++++++++++++-----
 lib/bb/ui/toasterui.py       |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index dd93d0b..6965570 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -933,15 +933,23 @@ class BuildInfoHelper(object):
         self._store_log_information(LogMessage.ERROR, text)
 
     def store_log_event(self, event):
-        # look up license files info from insane.bbclass
-        m = re.match("([^:]*): md5 checksum matched for ([^;]*)", event.msg)
-        if m:
-            (pn, fn) = m.groups()
-            self.internal_state['recipes'][pn].save()
+        if 'build' in self.internal_state and 'backlog' in self.internal_state:
+            if len(self.internal_state['backlog']):
+                tempevent = self.internal_state['backlog'].pop()
+                print "Saving stored event ", tempevent
+                self.store_log_event(tempevent)
+            else:
+                del self.internal_state['backlog']
 
         if event.levelno < format.WARNING:
             return
+
         if not 'build' in self.internal_state:
+            print "Save event for later"
+            if not 'backlog' in self.internal_state:
+                self.internal_state['backlog'] = []
+            self.internal_state['backlog'].append(event)
+
             return
         log_information = {}
         log_information['build'] = self.internal_state['build']
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 37d6b1a..9a9fe6f 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -143,6 +143,8 @@ def main(server, eventHandler, params ):
 
             # these events are unprocessed now, but may be used in the future to log
             # timing and error informations from the parsing phase in Toaster
+            if isinstance(event, (bb.event.SanityCheckPassed, bb.event.SanityCheck)):
+                continue
             if isinstance(event, bb.event.ParseStarted):
                 continue
             if isinstance(event, bb.event.ParseProgress):
@@ -209,7 +211,6 @@ def main(server, eventHandler, params ):
                 continue
 
             if isinstance(event, (bb.event.BuildCompleted)):
-                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 continue
 
             if isinstance(event, (bb.command.CommandCompleted,
-- 
1.9.1


