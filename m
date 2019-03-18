Return-Path: <prvs=973ddaea1=Stefan.Klug@baslerweb.com>
Received: from mail01.baslerweb.com (mail01.baslerweb.com [80.156.24.166])
	by mail.openembedded.org (Postfix) with ESMTP id 764367C8D4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 14:08:29 +0000 (UTC)
Received: from unknown (HELO ahr206s.basler.corp) ([172.16.20.206])
	by mail01-out.baslerweb.com with ESMTP; 18 Mar 2019 14:58:35 +0100
From: Stefan Klug <stefan.klug@baslerweb.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Mar 2019 14:58:20 +0100
Message-ID: <20190318135820.7344-4-stefan.klug@baslerweb.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318135820.7344-1-stefan.klug@baslerweb.com>
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.85.155]
X-ClientProxiedBy: ahr206s.basler.corp (172.16.20.206) To ahr206s.basler.corp
	(172.16.20.206)
X-C2ProcessedOrg: edc209ba-7b98-423a-8e4d-b8fa22bc0743
Subject: [PATCH 3/3] fetch2/wget: Fix authentication in checkstatus() of the wget fetcher
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
X-List-Received-Date: Mon, 18 Mar 2019 14:08:29 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

I wonder how this used to work for anybody.

Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
---
 lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e2037511..3addb219 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -322,8 +322,8 @@ class Wget(FetchMethod):
                 authheader =3D  "Basic %s" % encodeuser
                 r.add_header("Authorization", authheader)
=20
-            if ud.user:
-                add_basic_auth(ud.user, r)
+            if ud.user and ud.pswd:
+                add_basic_auth(ud.user + ':' + ud.pswd, r)
=20
             try:
                 import netrc, urllib.parse
--=20



