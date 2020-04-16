Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web11.2212.1587023145312014130
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Apr 2020 00:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: hongxu.jia@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 03G7ie5m008553
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
	Thu, 16 Apr 2020 00:44:55 -0700
Received: from jiahongxu-OptiPlex-990.wrs.com (128.224.162.134) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Apr 2020 00:44:29 -0700
From: "hongxu" <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>, <paul.eggleton@linux.intel.com>
Subject: [PATCH] tinfoil: fix config_data mess up insane check while parsing multiple recipes
Date: Thu, 16 Apr 2020 15:44:27 +0800
Message-ID: <20200416074427.1716-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain

Since commit [tinfoil: Simplify remote datastore connections][1] and
[tinfoil: Add back ability to parse on top of a datastore][2] applied,
bitbake run command parseRecipeFile with param config_data.dsindex rather
than config_data.

While calling tinfoil.parse_recipe_file() with one config_data (with the same
config_data.dsindex) to parse multiple recipes, it will mess up insane check.

It broke update_layer.py on layerindex, here are the simplified steps:
[snip]
t= bb.tinfoil.Tinfoil()
t.prepare()
data = bb.data.createCopy(t.config_data)
fn = "path_to/oe-core/meta/recipes-graphics/images/core-image-clutter.bb"
t.parse_recipe_file(fn, appends=False, config_data=data)
fn = "path_to/oe-core/meta/recipes-graphics/packagegroups/packagegroup-core-x11-base.bb"
t.parse_recipe_file(fn, appends=False, config_data=data)

|  File "path_to/oe-core/meta/classes/insane.bbclass", line 1303,
in __anon_1304__path_to_oe_core_meta_classes_insane_bbclass
|    bb.fatal("Fatal QA errors found, failing task.")
[snip]

In above failure, RDEPENDS is assigned `${PACKAGE_INSTALL} ${LINGUAS_INSTALL}
${IMAGE_INSTALL_DEBUGFS}' in core-image-clutter.bb, but it broke insane check
on packagegroup-core-x11-base.bb

From commit [remotedata: enable transporting datastore from the client to
the server][3], it create a new DataSmart to save receive_datastore's remote_data
Similarly, make a copy of config_data(with different config_data.dsindex) could
fix the issue.

[1] http://git.openembedded.org/bitbake/commit/?id=85e03a64dd0a4ebe71009ec4bdf4192c04a9786e
[2] http://git.openembedded.org/bitbake/commit/?id=4618da2094189e4d814b7d65672cb65c86c0626a
[3] http://git.openembedded.org/bitbake/commit/?id=784d2f1a024efe632fc9049ce5b78692d419d938

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 lib/bb/tinfoil.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 7d53608b2..8c9b6b8ca 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -636,6 +636,7 @@ class Tinfoil:
             if appends and appendlist == []:
                 appends = False
             if config_data:
+                 config_data = bb.data.createCopy(config_data)
                  dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, config_data.dsindex)
             else:
                 dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
-- 
2.17.1

