Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T4qAd-00066A-G2
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 11:27:16 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7O9F6Bs025656
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 24 Aug 2012 02:15:06 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Fri, 24 Aug 2012 02:15:06 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 24 Aug 2012 17:15:11 +0800
Message-ID: <b081443c18a09548804fe39eb718355e0f067ff5.1345799414.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1345799414.git.kai.kang@windriver.com>
References: <cover.1345799414.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 3/3] bitbake.conf: add variable IMAGE_TYPES_MAP
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
X-List-Received-Date: Fri, 24 Aug 2012 09:27:16 -0000
Content-Type: text/plain

Add variable IMAGE_TYPES_MAP to replace the hob2 hard-coded image types
map.

The format of IMAGE_TYPES_MAP is:
"image_type1:realname_extend1 image_type2:realname_extend2,extend3 ..."

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 meta/conf/bitbake.conf |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index ad98756..7d2a9b9 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -770,3 +770,6 @@ BB_SIGNATURE_EXCLUDE_FLAGS ?= "doc defaultval _append _prepend deps depends lock
 
 MLPREFIX ??= ""
 MULTILIB_VARIANTS ??= ""
+
+# Used by to Hob to filter image files
+IMAGE_TYPES_MAP = "btrfs:btrfs cpio.gz:cpio.gz cpio.lzma:cpio.lzma cpio.xz:cpio.xz cpio:cpio cramfs:cramfs elf:elf ext2.bz2:ext2.bz2 ext2.gz:ext2.gz ext2.lzma:ext2.lzma ext2:ext2 ext3.gz:ext3.gz ext3:ext3 jffs2:jffs2 live:hddimg,iso squashfs-lzma:squashfs-lzma squashfs:squashfs sum.jffs2:sum.jffs2 tar.bz2:tar.bz2 tar.gz:tar.gz tar.xz:tar.xz tar:tar ubi:ubi vmdk:vmdk"
-- 
1.7.5.4



