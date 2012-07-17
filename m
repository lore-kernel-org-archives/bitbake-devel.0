Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sr1vH-0000c7-4D
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jul 2012 09:10:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6H6wuAs011524
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Jul 2012 23:58:56 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Mon, 16 Jul 2012 23:58:55 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 17 Jul 2012 14:58:52 +0800
Message-ID: <97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1342495796.git.kai.kang@windriver.com>
References: <cover.1342495796.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] hob2: add elf to hcc supported image types
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
X-List-Received-Date: Tue, 17 Jul 2012 07:10:19 -0000
Content-Type: text/plain

[Yocto #2709]

OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf image
type. This will cause hob build image failed.
Add elf to hcc supoorted image types to fix this issue.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index dba278c..d10c56b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -89,6 +89,7 @@ class hcc:
         "cpio.xz"       : ["cpio.xz"],
         "vmdk"          : ["vmdk"],
         "cpio.lzma"     : ["cpio.lzma"],
+        "elf"           : ["elf"],
     }
 
 class HobViewTable (gtk.VBox):
-- 
1.7.5.4



