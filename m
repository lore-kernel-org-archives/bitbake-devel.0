Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id D9D4573CBD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 17:52:55 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id f126so6982711wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=19/56HnfaO/x6On5zNmYCcdxsBei9K4+dle6jaAdTSU=;
	b=wnLjZKPABPSKGUNVwTDUzSgNOrz/DISfE5VHrfNioN0g2lrqIRQimZZI+ZzkZoivzs
	h0J/z0T0jP6P2m5PtgxDnAdQ+VmgB7rtKk4iglkyaJYrgqZcFwF8bQ1yB0ZDB8KvecRk
	KUsjMPK2lVlFET/ev8Q/L7e615of2mNRDGIxwppMN4pJ5DaJ0kX8v69j+VJA7pcSnBNy
	QGqmYRaDxi6IGAfvnKeon5SnPq4VBf9vO19HMTpWGLesp1JqK9w1RoDEuUzrpzts+KzB
	2DOpsZRQmc54+2OYB67jttbI3HeQT4VObQNeGcPj0pLa44XNsqIu5Y+W3+yVqHRTj+BK
	SrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=19/56HnfaO/x6On5zNmYCcdxsBei9K4+dle6jaAdTSU=;
	b=GsS7E6rLJOYwnJ02DJFAYDre9hTX5485wBxIG8PGvqqgy/N+RFC6MVKmlTbSo8wmyV
	YwCTaS81lHCPJ5Vu8EyaKRPFJeIor/ymdl1zeK6VwpJCCeAeTEV4DvHKCuIqLmpXPdzN
	prTUfrDmcpPVoLzNP1T9T4bng2O6KJFzLzvd/I7mGEB0NjBp5W2YIJICnxlHr225KoQC
	pmrnVhoWIV7v5PRFT6+u7M9SWVCNoQndKnIG/gjwyu/edyR45D+czuJ4Blt8HLTuFeUI
	wHcmZEAWU9ljvSAc/+ayBk3kuzBsbJ6QXFDoWmLikg58veMKqi+cQcQYDyDBWiT9lgbk
	znkA==
X-Gm-Message-State: ALyK8tKgaXZy/mA5QAWij8WBB1zNS593mrB1maMFU43T6qSEgHOSrXUdiyetZbPKkVLeLQCv
X-Received: by 10.28.223.215 with SMTP id w206mr780785wmg.61.1466185975655;
	Fri, 17 Jun 2016 10:52:55 -0700 (PDT)
Received: from localhost.localdomain
	(host86-169-85-169.range86-169.btcentralplus.com. [86.169.85.169])
	by smtp.gmail.com with ESMTPSA id a129sm488171wma.2.2016.06.17.10.52.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 17 Jun 2016 10:52:54 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jun 2016 18:52:50 +0100
Message-Id: <1466185971-18537-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/2] toaster-tests: remove click on disabled element in test
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
X-List-Received-Date: Fri, 17 Jun 2016 17:52:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

On Firefox 47, attempting to click on the "Submit" button in
the test which attempts to create a project with a duplicate name
fails, as the button is not enabled if the name is a duplicate. This
also causes the test to fail.

Remove the call to the click() method which causes the test to fail.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/browser/test_new_project_page.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index 1b038ac..180a690 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -80,7 +80,7 @@ class TestNewProjectPage(SeleniumTestCase):
         """
         Should not be able to create a new project whose name is the same
         as an existing project
-       """
+        """
 
         project_name = "dupproject"
 
@@ -100,10 +100,6 @@ class TestNewProjectPage(SeleniumTestCase):
         self.assertTrue(("Project names must be unique" in element.text),
                         "Did not find unique project name error message")
 
-        # Try and click it anyway, if it submits we'll have a new project in
-        # the db and assert then
-        self.click("#create-project-button")
-
         self.assertTrue(
             (Project.objects.filter(name=project_name).count() == 1),
-            "New project not found in database")
+            "New project not found in database")
\ No newline at end of file
-- 
2.7.4


