Return-Path: <Chong.Lu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 442ED65D59
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 08:52:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0J8qtUV005196
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 00:52:55 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Mon, 19 Jan 2015 00:52:54 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 Jan 2015 16:48:23 +0800
Message-ID: <dcc1cd29cdf4dbcf242fda70bbd03fe9a2e84263.1421657244.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421657244.git.Chong.Lu@windriver.com>
References: <cover.1421657244.git.Chong.Lu@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: prserv/serv: sync database after thead quit
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
X-List-Received-Date: Mon, 19 Jan 2015 08:52:56 -0000
Content-Type: text/plain

We need sync database after thread quit, else we may get a empty table
after import a PR database.

[YOCTO #6752]

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
---
 bitbake/lib/prserv/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 25eb46a..c774c5e 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -87,7 +87,7 @@ class PRServer(SimpleXMLRPCServer):
                 self.finish_request(request, client_address)
                 self.shutdown_request(request)
                 iter_count = (iter_count + 1) % iterations_between_sync
-                if iter_count == 0:
+                if iter_count == 0 or self.quit:
                     self.table.sync_if_dirty()
             except:
                 self.handle_error(request, client_address)
-- 
1.9.1


