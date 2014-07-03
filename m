Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 69A486084E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 06:34:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s636Ybng017064
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 2 Jul 2014 23:34:37 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Wed, 2 Jul 2014 23:34:36 -0700
Message-ID: <53B4F97B.7030202@windriver.com>
Date: Thu, 3 Jul 2014 14:34:35 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1404369559.git.liezhi.yang@windriver.com>
In-Reply-To: <cover.1404369559.git.liezhi.yang@windriver.com>
Subject: [PATCH 1/3] toaster: fix no newline at end of file
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
X-List-Received-Date: Thu, 03 Jul 2014 06:34:37 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

This is the [PATCH 1/3] which is too big and blocked by the mailing
list, I just send the header here, you can get the patch from the
PULL.

// Robert

Add a '\n' to the last line of the file to fix:

No newline at end of file

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
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
  13 files changed, 13 insertions(+), 13 deletions(-)


