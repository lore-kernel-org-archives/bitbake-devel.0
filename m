Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 6F95E76FDE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 14:07:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 23 Sep 2015 07:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,577,1437462000"; d="scan'208";a="775316594"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.24.133])
	by orsmga001.jf.intel.com with ESMTP; 23 Sep 2015 07:06:20 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:05:40 +0100
Message-Id: <1443017140-31250-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: support selenium testing from mac OS X
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
X-List-Received-Date: Wed, 23 Sep 2015 14:07:17 -0000

From: brian avery <avery.brian@gmail.com>

* added a mac section to the cfg file
* added mac specific screenshot code

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/contrib/tts/toasteruitest/toaster_automation_test.py    | 5 ++++-
 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg      | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index 2a2078f..edd699b 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -321,7 +321,10 @@ class toaster_cases_base(unittest.TestCase):
             log_path = log_dir + os.sep +  self.browser + '-' +\
                     item + '-' + add_name + '-' + str(self.screenshot_sequence) + '.png'
             if item == 'native':
-                os.system("scrot " + log_path)
+                if self.host_os == "linux":
+                    os.system("scrot " + log_path)
+                elif self.host_os=="darwin":
+                    os.system("screencapture -x " + log_path)
             elif item == 'selenium':
                 self.driver.get_screenshot_as_file(log_path)
             self.screenshot_sequence += 1
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
index 6405f9a..685a9ee 100644
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
@@ -18,4 +18,8 @@ test_browser = ['ie', 'firefox', 'chrome']
 test_cases = [901, 902, 903]
 logging_level = 'DEBUG'
 
-
+[toaster_test_darwin]
+toaster_url = 'http://127.0.0.1:8000'
+test_browser = 'firefox'
+test_cases = [901, 902, 903, 904, 906, 910, 911, 912, 913, 914, 915, 916, 923, 924, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 955, 956]
+logging_level = 'INFO'
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


