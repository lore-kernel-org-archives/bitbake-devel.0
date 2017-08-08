Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 540E860125
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:12 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v789CB0a002039
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:14 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:10 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:05 -0700
Message-ID: <115139f3daf8d3aa5c540658c981816d930b54de.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 1/5] btiabke: main.py: remove unneeded float()
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:13 -0000
Content-Type: text/plain

There is already a type=float, so the float() is not needed, which also makes
the error clearer:

$ export BB_SERVER_TIMEOUT=10000AA
With float():
$ bitbake quilt-native
[snip]
ValueError: could not convert string to float: '10000AA'

Without float():
$ bitbake quilt-native
[snip]
optparse.OptionValueError: option --idle-timeout: invalid floating-point value: '10000AA'

The second one tells clearly where is wrong.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 431f6f47940..62f9e1eacf1 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -259,7 +259,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="The name/address for the bitbake xmlrpc server to bind to.")
 
         parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
-                          default=float(os.environ.get("BB_SERVER_TIMEOUT", 0)) or None,
+                          default=os.environ.get("BB_SERVER_TIMEOUT", 0) or None,
                           help="Set timeout to unload bitbake server due to inactivity")
 
         parser.add_option("", "--no-setscene", action="store_true",
-- 
2.11.0


