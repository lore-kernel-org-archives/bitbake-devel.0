Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T3sBa-0001jz-8N
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:24:15 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 10:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,803,1336374000"; d="scan'208";a="136563950"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.105])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Aug 2012 10:12:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 18:11:47 +0100
Message-Id: <262ce12f39ee02a69ef4b4721bed43db114cde78.1345568965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake-layers: use parsable title for show-appends
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
X-List-Received-Date: Tue, 21 Aug 2012 17:24:15 -0000

Print title text surrounded by === as we do with other subcommands so
that you can filter it out in scripts. (You will also want to filter out
lines starting with "WARNING:" if you just want the list).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6d18d94..f473711 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -521,7 +521,7 @@ Recipes are listed with the bbappends that apply to them as subitems.
             logger.plain('No append files found')
             return
 
-        logger.plain('State of append files:')
+        logger.plain('=== Appended recipes ===')
 
         pnlist = list(self.cooker_data.pkg_pn.keys())
         pnlist.sort()
-- 
1.7.9.5



