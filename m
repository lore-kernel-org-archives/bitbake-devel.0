Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id AAFB970022
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:29:01 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id u206so39018995wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8L20qwejzOzUWe3lQikUXKbxHJtPQNUyfmXxFY5XDqo=;
	b=S571P8axYGFWJOLuom3tfXLqm2O6AlMEEiVMJ43TqVgrgujwiW+IWKiXKiGoVYaGNX
	kuVNeADfsCD9dHbQkxtVynEGUrPVSECH73g0OoeTcXBPMAZN0HxLaxSaqm0CphFl8U8X
	FSR2kGKHGDKJfjTmjP+CjfwUrMh5luJEYWAjXOKwzmtR2QXE/lq902rfk/hsAwEXTzJx
	ww7Z2aaiQ95yh2p4E70YkwhmkEGwZml/YRdXOWXcMzzKpFzObJs1ElqcWmp6Ul5fIThL
	he3JIuiFKe0k2VXX/FpGScCqgmv9np9spBxIxechDczS8/eSUuguiVqj8m6VxjTMlc3a
	V/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8L20qwejzOzUWe3lQikUXKbxHJtPQNUyfmXxFY5XDqo=;
	b=ciIhbOn0lRThwpBaP9xeDPdhY7Dcg1OtGfq0OXzylYOy/HTX6zq31Qsu8x8yz7pMBT
	q26E0lHpGNQJFG6IoFl87k/BaL2YI4ZxF3dkkrh1Q1zBC67uBUE0MBD0xRVOJHsxK3mz
	Vc0d4c/l8Qc+i68cRrw3xWhhpEvvRNy0+O3XiIOYjM26ilFCC++LTWl7iJzspyQzWhCu
	AEcbNRDJrqYCSZ8uPOwjV8SECHEOJJVKYhq0rpBCqQsuqIfzg9bWR/AQiEJRlgiX8N2R
	SmTTp7IqXPu4oP1sSk0KHUogiTAWq4v/YcTSmXGd5H0ZZIYt6LOh62XChhaEl7U1OCyV
	Z0og==
X-Gm-Message-State: AOPr4FXj/K94UxnR9Jr5eBzXo9halow45fVI+rcbPPW6f+ITKuJvg7hriMjQ7PELMxhdKUPD
X-Received: by 10.194.166.228 with SMTP id zj4mr4225138wjb.83.1461083341849;
	Tue, 19 Apr 2016 09:29:01 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.29.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:29:01 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:44 +0100
Message-Id: <1461083327-11668-8-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 07/10] toaster-tests: make helper click on input before entering text
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
X-List-Received-Date: Tue, 19 Apr 2016 16:29:02 -0000

From: Elliot Smith <elliot.smith@intel.com>

The Selenium helper's enter_text() method doesn't cause
keyup events to trigger unless the element where text is
being entered has been clicked.

Prefix all text entry with a click() on the element to ensure
that keyup events fire.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/browser/selenium_helpers.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index d3ab3ca..56dbe2b 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -185,7 +185,11 @@ class SeleniumTestCase(StaticLiveServerTestCase):
 
     def enter_text(self, selector, value):
         """ Insert text into element matching selector """
-        field = self.wait_until_present(selector)
+        # note that keyup events don't occur until the element is clicked
+        # (in the case of <input type="text"...>, for example), so simulate
+        # user clicking the element before inserting text into it
+        field = self.click(selector)
+
         field.send_keys(value)
         return field
 
-- 
2.5.0


