Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 667CD65CC0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 06:27:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s636RMUL016518
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 2 Jul 2014 23:27:22 -0700 (PDT)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Wed, 2 Jul 2014 23:27:22 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 14:42:03 +0800
Message-ID: <cover.1404369559.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/3] fix no newline at end of file
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
X-List-Received-Date: Thu, 03 Jul 2014 06:27:27 -0000
Content-Type: text/plain

The following changes since commit 0ed5a13f5f9478e2c22f517fb3504b738422f85c:

  python3: fix builtins imports (2014-06-30 16:36:44 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/bb_noeol
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/bb_noeol

Robert Yang (3):
  toaster: fix no newline at end of file
  bitbake: doc: fix no newline at end of file
  bitbake: lib: fix no newline at end of file

 bitbake/doc/template/component.title.xsl                                | 2 +-
 bitbake/doc/template/division.title.xsl                                 | 2 +-
 bitbake/doc/template/formal.object.heading.xsl                          | 2 +-
 bitbake/lib/bb/pysh/sherrors.py                                         | 2 +-
 bitbake/lib/prserv/__init__.py                                          | 2 +-
 bitbake/lib/toaster/bldcontrol/migrations/0001_initial.py               | 2 +-
 bitbake/lib/toaster/bldviewer/static/css/bootstrap.css                  | 2 +-
 bitbake/lib/toaster/orm/migrations/0001_initial.py                      | 2 +-
 .../lib/toaster/orm/migrations/0002_auto__add_field_build_timespent.py  | 2 +-
 .../orm/migrations/0004_auto__add_field_package_installed_name.py       | 2 +-
 ..._add_target_image_file__add_target_file__add_field_variablehistor.py | 2 +-
 ..._add_field_target_image_size__add_field_target_license_manifest_p.py | 2 +-
 bitbake/lib/toaster/orm/migrations/0007_auto__add_helptext.py           | 2 +-
 ..._chg_field_variablehistory_operation__chg_field_recipe_descriptio.py | 2 +-
 ..._add_projectvariable__add_projectlayer__add_projecttarget__add_pr.py | 2 +-
 bitbake/lib/toaster/toastergui/static/css/prettify.css                  | 2 +-
 bitbake/lib/toaster/toastergui/static/js/bootstrap.min.js               | 2 +-
 bitbake/lib/toaster/toastergui/static/js/jquery-2.0.3.min.map           | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

-- 
1.8.3.1


