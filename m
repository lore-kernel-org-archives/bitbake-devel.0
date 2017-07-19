Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0C4FA78216
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:44 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410409"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:02 +0200
Message-Id: <bd4c5b7667997e2ac83464df804be85ea9513875.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/12] tinfoil: set a flag when recipes have been parsed
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:44 -0000

Make it easy to determine if recipes are parsed (and thus information
about available recipes is in memory).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index e027930..cba157c 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -217,6 +217,7 @@ class Tinfoil:
         self.tracking = tracking
         self.ui_module = None
         self.server_connection = None
+        self.recipes_parsed = False
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
@@ -270,6 +271,7 @@ class Tinfoil:
                 self.run_command('parseConfiguration')
             else:
                 self.run_actions(config_params)
+                self.recipes_parsed = True
 
             self.config_data = bb.data.init()
             connector = TinfoilDataStoreConnector(self, None)
@@ -303,6 +305,7 @@ class Tinfoil:
         """
         config_params = TinfoilConfigParameters(config_only=False)
         self.run_actions(config_params)
+        self.recipes_parsed = True
 
     def run_command(self, command, *params):
         """
-- 
2.9.4


