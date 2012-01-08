Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rjrdp-0005Vj-O6
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Jan 2012 13:14:25 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Jan 2012 04:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="95755847"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.80])
	by orsmga002.jf.intel.com with ESMTP; 08 Jan 2012 04:06:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Jan 2012 12:06:51 +0000
Message-Id: <ed8b9e7f2cfdc88cb692148a61a9c13663329388.1326023910.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326023910.git.paul.eggleton@linux.intel.com>
References: <cover.1326023910.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326023910.git.paul.eggleton@linux.intel.com>
References: <cover.1326023910.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake-layers: close files in apply_append()
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
X-List-Received-Date: Sun, 08 Jan 2012 12:14:26 -0000

It's recommended practice to close files when finished with them and the
code in this function was not doing this.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index b4c4127..b4cfd55 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -307,6 +307,8 @@ build results (as the layer priority order has effectively changed).
         recipefile.write('\n')
         recipefile.write('##### bbappended from %s #####\n' % self.get_append_layer(appendname))
         recipefile.writelines(appendfile.readlines())
+        recipefile.close()
+        appendfile.close()
 
     def do_show_appends(self, args):
         """list bbappend files and recipe files they apply to
-- 
1.7.5.4



