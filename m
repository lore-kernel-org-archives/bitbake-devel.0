Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBTtG-0002uw-Kg
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Sep 2012 19:04:46 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Sep 2012 09:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,406,1344236400"; d="scan'208";a="191458845"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.206])
	by azsmga001.ch.intel.com with ESMTP; 11 Sep 2012 09:52:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 17:52:00 +0100
Message-Id: <2b9acb9c7fca686d4df885152458cae2e22f2cc5.1347382193.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/command.py: ensure setVariable only sets values as strings
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 11 Sep 2012 17:04:47 -0000

This is the interface Hob uses to set variable values in many instances,
and at the moment it is possible that some of the values it passes are
not strings. If a non-string value gets into the datastore it can
trigger exceptions during parsing when we attempt to expand the variable
and substitute in the non-string value.

This fixes using the meta-ti layer within Hob - it currently has a
reference to BB_NUMBER_THREADS within a shell function and since this
is a variable that Hob was setting from its configuration as an integer,
due to the above this was triggering an ExpansionError.

Fixes [YOCTO #2875].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/command.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index fd8912a..27b5171 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -157,7 +157,7 @@ class CommandsSync:
         Set the value of variable in configuration.data
         """
         varname = params[0]
-        value = params[1]
+        value = str(params[1])
         command.cooker.configuration.data.setVar(varname, value)
 
     def initCooker(self, command, params):
-- 
1.7.9.5



