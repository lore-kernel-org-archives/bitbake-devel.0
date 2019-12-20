Return-Path: <ola.x.nilsson@axis.com>
X-Greylist: delayed 429 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 20 Dec 2019 14:30:29 UTC
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id 2CF4E79CC0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2019 14:30:28 +0000 (UTC)
IronPort-SDR: fSYc/Tz84OXr/tlCyOOL+Is9MTVWk3el1MUu5qX0xkjyagVqWE05lI8yg9hz8JmMZTcei1h2fI
	wBXTxGiQHA70sdmoqgcxww0yg7lOJh1ddknOxpYLawZhX71TJSdsi1HamB5yfhsPCN1JZ4YKv8
	wI/cC+vguoxJcuIPp+VCz9/CffYeIbyW1L6BBbHFje4Xb4X4d+GoSvL7zYyYsgfDBEnTOvLjXU
	xgPnmmzfQbtrkDXeaV7j+KLTXZdIZEUzwk2UKnmWd4xzgdVZbxza0lQgl1efudyATxgXM1/edv
	2mM=
X-IronPort-AV: E=Sophos;i="5.69,336,1571695200"; 
   d="scan'208";a="3808694"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2019 15:23:20 +0100
Message-Id: <20191220142320.17724-2-olani@axis.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220142320.17724-1-olani@axis.com>
References: <20191220142320.17724-1-olani@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/2] bitbake-layers: Keep loglevel in colored logger
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
X-List-Received-Date: Fri, 20 Dec 2019 14:30:29 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 bin/bitbake-layers | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index a884dc1f..149f1b1a 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -52,7 +52,9 @@ def main():
 
     # Need to re-run logger_create with color argument
     # (will be the same logger since it has the same name)
-    bb.msg.logger_create('bitbake-layers', output=sys.stdout, color=global_args.color)
+    bb.msg.logger_create('bitbake-layers', output=sys.stdout,
+                         color=global_args.color,
+                         level=logger.getEffectiveLevel())
 
     plugins = []
     tinfoil = bb.tinfoil.Tinfoil(tracking=True)
-- 
2.11.0


