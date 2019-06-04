Return-Path: <Leif.Middelschulte@klsmartin.com>
Received: from ironport.klsmartin.com (ironport.klsmartin.com [212.211.191.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6296F7DE7D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2019 16:09:23 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.60,550,1549926000"; 
   d="scan'208";a="1788398"
Received: from unknown (HELO hera.klsmartin.com) ([172.30.5.66])
	by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	04 Jun 2019 18:02:19 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
	by hera.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id
	x54G2801016093 for <bitbake-devel@lists.openembedded.org>;
	Tue, 4 Jun 2019 18:02:10 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.60) by
	SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Tue, 4 Jun 2019 18:02:13 +0200
From: Leif Middelschulte <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Jun 2019 18:01:37 +0200
Message-ID: <20190604160137.5636-2-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
References: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.2.60]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 04.06.2019 11:03:00
Cc: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH 1/1] bitbake: fetch2/git: set password in https clones too
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
X-List-Received-Date: Tue, 04 Jun 2019 16:09:23 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fetching submodules via https, using the basic HTTP auth scheme, failed.

Example for a broken URL:
SRC_URI = "gitsm://example.com/some_repo.git;protocol=https;user=john:secret"

Now, if some_repo.git had a relative submodule, the initial clone would fail:
> fatal: could not read Username for 'https://example.com':
> No such device or address

This happended, because the password was correctly read into another
`ud`-field (`pswd`), but not added back, when the URL was rebuilt.

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e171aa7e..7afc2b52 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -570,7 +570,9 @@ class Git(FetchMethod):
         """
         Return the repository URL
         """
-        if ud.user:
+        if ud.user and ud.pswd:
+            username = "%s:%s@" % (ud.user, ud.pswd)
+        elif ud.user:
             username = ud.user + '@'
         else:
             username = ""
-- 
2.21.0


