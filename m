Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 9E187606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:52:50 +0000 (UTC)
Received: by padhk6 with SMTP id hk6so238978pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=NbEjimQdylq2unkhC7jKxMzl79omZlalDkzDmWrnf40=;
	b=O7Zx6WGJvNLoUzXeCNiXWVwbaZMwrkm3ELR8y2aQT92Bo7UQfokAMdWjnXTWdU5Mc0
	XzvsNuOOjnBifR5XHlSAzxufQ0TZrRJHIlQ4K5yqMHK5AGkWEovq77UZPjMWmOOSEA3u
	ni7/bmyoiL9069/f7YePrBoiYSbG43DCfNjaazCdl/AfJeSzCpDwbIiBAs43BM/JLxuH
	nHAaHzB9SRdlw2SsA0Yzg/tWQuKRQRG7L6ShqJQkmUZsX7JrPI4LQki5RocKSHWnoqak
	PXw9VPbcCP30O3oFR+8dpUrGpHpobdCgoEhzg/VtVj+awsqDmM7lR6FSe3Ozer1oxzD+
	JO4w==
X-Received: by 10.66.178.225 with SMTP id db1mr13215829pac.46.1449719570896;
	Wed, 09 Dec 2015 19:52:50 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	sg4sm14980624pac.48.2015.12.09.19.52.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:52:50 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:31 -0800
Message-Id: <cover.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/18] toaster: upgrade to Django 1.8
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
X-List-Received-Date: Thu, 10 Dec 2015 03:52:51 -0000

This rather large patchset upgrades toaster to work with Django 1.8.
It was tested with Django 1.8.6 and 1.8.7.

yay for LTS!
-b

The following changes since commit 2cb81fb08395ec9cd68b02bc48391c9610eac9d9:

  toasterui: process SetBRBE event (2015-12-09 19:45:13 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/toaster/django_upgrade-8364
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/toaster/django_upgrade-8364

Ed Bartosh (9):
  toaster: Remove South migrations
  toaster: Fix references to app paths
  toaster: rename get_query_set -> get_queryset
  toaster: use OneToOneField instead of ForeignKey
  toaster: fixed format strings
  toaster: work around 'database is locked' error
  toaster: removed extra calls of migrate
  toaster: monkey patch Queryset
  toaster: rework checking of Django version

Elliot Smith (9):
  toaster: Upgrade to Django 1.8.6 and remove South
  toaster: Create default project with get_or_create* method
  toaster: Start Django machinery for database access
  toaster: Update API used to make runbuilds methods run in transactions
  toaster: Prevent deprecation warnings for RedirectView
  toaster: Update deprecated manage.py command
  toaster: Check Django version against toaster-requirements.txt
  toaster: Remove compatible_layerversions() method
  toaster: Amend regex for MySQL database URLs

 bin/toaster                                        |  44 +-
 lib/bb/ui/buildinfohelper.py                       |  26 +-
 lib/toaster/bldcollector/urls.py                   |   1 -
 lib/toaster/bldcontrol/bbcontroller.py             |   4 +-
 lib/toaster/bldcontrol/localhostbecontroller.py    |  13 +-
 .../bldcontrol/management/commands/runbuilds.py    |   6 +-
 lib/toaster/bldcontrol/migrations/0001_initial.py  | 265 +++---
 ...onment_sourcedir__add_field_buildenvironment.py | 106 ---
 .../0003_auto__add_field_brlayer_dirpath.py        |  99 ---
 .../bldcontrol/migrations/0004_loadinitialdata.py  | 104 ---
 .../migrations/0005_auto__add_brerror.py           | 112 ---
 .../migrations/0006_auto__add_brbitbake.py         | 128 ---
 ...st_environment__chg_field_buildrequest_build.py | 145 ----
 .../bldcontrol/migrations/0008_brarchive.py        | 138 ---
 .../0009_auto__add_field_brlayer_layer_version.py  | 180 ----
 lib/toaster/bldcontrol/models.py                   |   2 +-
 lib/toaster/bldcontrol/tests.py                    |   6 +-
 lib/toaster/orm/migrations/0001_initial.py         | 928 ++++++++++++---------
 .../0002_auto__add_field_build_timespent.py        | 180 ----
 lib/toaster/orm/migrations/0003_timespent.py       | 182 ----
 .../0004_auto__add_field_package_installed_name.py | 181 ----
 ...e__add_target_file__add_field_variablehistor.py | 281 -------
 ...ge_size__add_field_target_license_manifest_p.py | 235 ------
 .../orm/migrations/0007_auto__add_helptext.py      | 214 -----
 ...story_operation__chg_field_recipe_descriptio.py | 225 -----
 ..._add_projectlayer__add_projecttarget__add_pr.py | 286 -------
 ...anch__add_field_project_short_description__a.py | 257 ------
 .../0011_auto__add_field_projectlayer_dirpath.py   | 242 ------
 ...layer_optional__add_field_projecttarget_task.py | 252 ------
 ...erversiondependency__add_unique_layerversion.py | 710 ----------------
 ...mmary__chg_field_layer_summary__chg_field_re.py | 336 --------
 ...web_url__add_field_layer_vcs_web_tree_base_u.py | 336 --------
 ...lptext__chg_field_release_branch__add_index_.py | 359 --------
 ...faultlayer__add_releaselayersourcepriority__.py | 396 ---------
 .../0018_auto__add_field_layer_version_project.py  | 331 --------
 .../orm/migrations/0019_auto__add_buildartifact.py | 342 --------
 ...ion_local_path__add_field_recipe_pathflags__.py | 361 --------
 ...ect__chg_field_project_bitbake_version__chg_.py | 371 --------
 ...k__add_field_layer_version_local_path__del_f.py | 343 --------
 ...ings_no__del_field_build_errors_no__del_fiel.py | 353 --------
 .../0024_auto__add_field_recipe_is_image.py        | 338 --------
 .../0025_auto__add_field_project_is_default.py     | 346 --------
 .../orm/migrations/0026_set_default_project.py     | 374 ---------
 ...e__add_unique_customimagerecipe_name_project.py | 375 ---------
 .../0028_auto__chg_field_logmessage_message.py     | 345 --------
 lib/toaster/orm/models.py                          | 108 ++-
 lib/toaster/toastergui/urls.py                     |   2 +-
 lib/toaster/toastergui/views.py                    |  24 +-
 lib/toaster/toastermain/settings.py                |   4 +-
 lib/toaster/toastermain/urls.py                    |   2 +-
 toaster-requirements.txt                           |   3 +-
 51 files changed, 779 insertions(+), 10222 deletions(-)
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0003_auto__add_field_brlayer_dirpath.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0007_auto__add_field_buildrequest_environment__chg_field_buildrequest_build.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0008_brarchive.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0002_auto__add_field_build_timespent.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0003_timespent.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0004_auto__add_field_package_installed_name.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0005_auto__add_target_image_file__add_target_file__add_field_variablehistor.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0007_auto__add_helptext.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0009_auto__add_projectvariable__add_projectlayer__add_projecttarget__add_pr.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0011_auto__add_field_projectlayer_dirpath.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0014_auto__chg_field_package_summary__chg_field_layer_summary__chg_field_re.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0015_auto__add_field_layer_vcs_web_url__add_field_layer_vcs_web_tree_base_u.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0016_auto__add_field_release_helptext__chg_field_release_branch__add_index_.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0019_auto__add_buildartifact.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0024_auto__add_field_recipe_is_image.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0026_set_default_project.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0027_auto__add_customimagerecipe__add_unique_customimagerecipe_name_project.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py

--
1.9.1

