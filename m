Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 2C91160169
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 00:38:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7J0cJlJ011279
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Aug 2014 17:38:20 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 18 Aug 2014 17:38:19 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Aug 2014 17:38:18 -0700
Message-ID: <201af937a0a45dd0203b1a4a00cffa7a24a31c20.1408408667.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1408408667.git.liezhi.yang@windriver.com>
References: <cover.1408408667.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] newbb.vim: remove PR
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
X-List-Received-Date: Tue, 19 Aug 2014 00:38:19 -0000
Content-Type: text/plain

We don't need the "PR = r0" in the bb, so remove it to avoid misleading
the user.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/contrib/vim/plugin/newbb.vim |    1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/contrib/vim/plugin/newbb.vim b/bitbake/contrib/vim/plugin/newbb.vim
index 3019c85..874e338 100755
--- a/bitbake/contrib/vim/plugin/newbb.vim
+++ b/bitbake/contrib/vim/plugin/newbb.vim
@@ -53,7 +53,6 @@ fun! NewBBTemplate()
     put ='LICENSE = \"\"' 
     put ='SECTION = \"\"'
     put ='DEPENDS = \"\"'
-    put ='PR = \"r0\"'
     put =''
     put ='SRC_URI = \"\"'
 
-- 
1.7.9.5


