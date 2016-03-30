Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8278E62133
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 09:32:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u2U9WuSq022297
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 02:32:57 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Wed, 30 Mar 2016 02:32:56 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Mar 2016 02:32:55 -0700
Message-ID: <96108bac83f88289ad4851f781742f515e882f5d.1459330331.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1459330331.git.liezhi.yang@windriver.com>
References: <cover.1459330331.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cookerdata.py: remove slash in the end
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
X-List-Received-Date: Wed, 30 Mar 2016 09:32:56 -0000
Content-Type: text/plain

It's very possible that we added layer as:
BBLAYERS += "/path/to/meta/"

then there would be warning:
WARNING: No bb files matched BBFILE_PATTERN_core '^/path/to/meta//'

This patch can fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index c5fdf66..50259a9 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -292,6 +292,8 @@ class CookerDataBuilder(object):
                 parselog.debug(2, "Adding layer %s", layer)
                 if 'HOME' in approved and '~' in layer:
                     layer = os.path.expanduser(layer)
+                if layer.endswith('/'):
+                    layer = layer.rstrip('/')
                 data.setVar('LAYERDIR', layer)
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
-- 
2.7.4


