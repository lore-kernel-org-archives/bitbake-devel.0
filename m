Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CC4BC60DFC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 02:19:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBP2JaV4008057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 18:19:37 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 24 Dec 2013 18:19:36 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 21:19:29 -0500
Message-ID: <02469d66b7b241105ad15e5732bea68417178bb3.1387937195.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1387937195.git.liezhi.yang@windriver.com>
References: <cover.1387937195.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] bitbake: imagedetailspage: Fix crash with more than 15 layers
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
X-List-Received-Date: Wed, 25 Dec 2013 02:19:36 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If you had more than 15 layers the system would crash since one more
value is added to one array than the other. This fixes the code
so equal numbers of values are added to the arrays and hence
doesn't crash when many layers are enabled.

(Bitbake master rev: 4e65463886a2ef245b2f8974e82e9cb942af224b)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index b5d9660..ac82e27 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -355,9 +355,9 @@ class ImageDetailsPage (HobPage):
             vallist.append(base_image)
             i = 0
             for layer in layers:
-                varlist.append(" - ")
                 if i > layer_num_limit:
                     break
+                varlist.append(" - ")
                 i += 1
             vallist.append("")
             i = 0
-- 
1.7.10.4


