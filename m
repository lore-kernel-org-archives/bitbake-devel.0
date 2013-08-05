Return-Path: <ross.burton@intel.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id 360006B41A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Aug 2013 16:12:31 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id q58so2645285wes.20
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Aug 2013 09:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=hr6yga9NKYleVQ/DzISfyi4PRgmeni018TqfYJPfgE4=;
	b=Z2CTCd2vKxdG4lcs/fAw9cF8d1vd7uPOhkO3SqYuGB6J4/ikpc6kYUeCEkasyRQcOL
	JWMrCoqZKGQuHvbkxls/kBvl9zxUnH+IRVRciFptnns+GmgFs42Oz4R4QI0X7lter3Nz
	azK4UrOfv9XTSyTO3a8lSs7HEqmDGy833M5TM0LG/dfxaJ2mL3yVMVTIB0w1pOBB5TXA
	6bzSuWJuCjKmVdV3cpPFcP6kRyLVOlnkGzYKcvZ/w0YydKtXMmxb6n2P92sWZzg2wZhx
	Dnc0Ck1XJAnf3Zffs2QFeQieAnytZ1mdThFar86jJvlSp1ZDtIZkvsIZKWLbl+ujsXmn
	i5UQ==
X-Received: by 10.194.123.69 with SMTP id ly5mr13755391wjb.29.1375719151260;
	Mon, 05 Aug 2013 09:12:31 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id
	fd3sm22434156wic.10.2013.08.05.09.12.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 09:12:30 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Aug 2013 17:12:22 +0100
Message-Id: <87a392c25c6fed471c96b1bd781bfc481f1f03c4.1375718812.git.ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
X-Gm-Message-State: ALoCoQkTUUKNV8Bvw2gV9OX16NFM6Hv3/J3mUpEG7IxAA8P6/f/OaHyE6gHVzVDk9ZVfOFXQRbqb
Subject: [PATCH 2/3] depexp: insert data instead of append/set, for speed
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
X-List-Received-Date: Mon, 05 Aug 2013 16:12:32 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index b7e6f8f..03ed823 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -165,21 +165,15 @@ class DepExplorer(gtk.Window):
 
     def parse(self, depgraph):
         for package in depgraph["pn"]:
-            self.pkg_model.set(self.pkg_model.append(), COL_PKG_NAME, package)
+            self.pkg_model.insert(0, (package,))
 
         for package in depgraph["depends"]:
             for depend in depgraph["depends"][package]:
-                self.depends_model.set (self.depends_model.append(),
-                                        COL_DEP_TYPE, TYPE_DEP,
-                                        COL_DEP_PARENT, package,
-                                        COL_DEP_PACKAGE, depend)
+                self.depends_model.insert (0, (TYPE_DEP, package, depend))
 
         for package in depgraph["rdepends-pn"]:
             for rdepend in depgraph["rdepends-pn"][package]:
-                self.depends_model.set (self.depends_model.append(),
-                                        COL_DEP_TYPE, TYPE_RDEP,
-                                        COL_DEP_PARENT, package,
-                                        COL_DEP_PACKAGE, rdepend)
+                self.depends_model.insert (0, (TYPE_RDEP, package, rdepend))
 
 
 class gtkthread(threading.Thread):
-- 
1.7.10.4


