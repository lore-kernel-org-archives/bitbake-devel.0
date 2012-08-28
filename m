Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T6C1a-0004Un-Tp
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Aug 2012 04:59:31 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7S2lH5b026482
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 27 Aug 2012 19:47:17 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.309.2; Mon, 27 Aug 2012 19:47:17 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 28 Aug 2012 10:47:21 +0800
Message-ID: <79f157731c01cb12b134acc269bb576bd1e8985c.1346121294.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1346121294.git.kai.kang@windriver.com>
References: <cover.1346121294.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 3/3] image_types.bbclass: add variable for Hob
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
X-List-Received-Date: Tue, 28 Aug 2012 02:59:31 -0000
Content-Type: text/plain

Add a new variable "IMAGE_EXTENSION_live" for Hob to map image type
"live" with real image file extension names.

This is for Hob to remove the hard-coded maps.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 meta/classes/image_types.bbclass |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/meta/classes/image_types.bbclass b/meta/classes/image_types.bbclass
index d286eea..6f8514f 100644
--- a/meta/classes/image_types.bbclass
+++ b/meta/classes/image_types.bbclass
@@ -247,3 +247,6 @@ RUNNABLE_IMAGE_TYPES ?= "ext2 ext3"
 RUNNABLE_MACHINE_PATTERNS ?= "qemu"
 
 DEPLOYABLE_IMAGE_TYPES ?= "hddimg iso" 
+
+# Use IMAGE_EXTENSION_xxx to map image type 'xxx' with real image file extension name(s) for Hob
+IMAGE_EXTENSION_live = "hddimg iso"
-- 
1.7.5.4



