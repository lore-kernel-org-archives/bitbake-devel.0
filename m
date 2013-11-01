Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 813086D634
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337449"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:32 +0000
Message-Id: <b5df847f1de4c38a9cb3273b310e912bc8d3a267.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/8] toaster: fix timezone settings
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes an issue where, if not defined,
the timezone defaults to 'America/Chicago'.

The solution is to set the timezone to current computer's
timezone.

[YOCTO #5186]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/toaster/toastermain/settings.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index dd1e25c..9435087 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -48,7 +48,8 @@ ALLOWED_HOSTS = []
 # In a Windows environment this must be set to your system time zone.
 
 # Always use local computer's time zone
-#TIME_ZONE = ''
+import time
+TIME_ZONE = time.tzname[0]
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
@@ -65,7 +66,7 @@ USE_I18N = True
 USE_L10N = True
 
 # If you set this to False, Django will not use timezone-aware datetimes.
-USE_TZ = False
+USE_TZ = True
 
 # Absolute filesystem path to the directory that will hold user-uploaded files.
 # Example: "/var/www/example.com/media/"
-- 
1.8.1.2


