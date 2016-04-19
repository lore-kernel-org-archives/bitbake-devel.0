Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 433E660616
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:55 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id v188so169463773wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=ZjXZ9/cPFQjONbK1rLrgZrSyaroxFdQMzZ5OUXfEaEo=;
	b=x1U8jKjtfwV+0w8xLqBSsrUkflREvDHqGF+f5TB7ybKjoOOQHnF0F8Vc4R5pPwD9hm
	BZByfWbSY61NifguTuBV2z5HkleuKcI/+F/pbaI1AbHPIeP69aBwHuRlOU38UbX2q+pX
	1CgWAM6qqjyZSZ9Kp9rlAv1/35OOi2ZvRMxr6thTfiZnfL77FAvFhcErx6NaHYL/AApi
	VKRTHc09ZgU95JRH/g4u1WymyPhhxtTK1xB2qrBkQ92spi/JhwJwUeLWW8cJGavYsYgX
	+rTzGp7AioN7t5i6frZIGtwgzjPFSp2Ic2blYijUN1q8yqUOCpRaAtWHR00zsakRMuhY
	570A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ZjXZ9/cPFQjONbK1rLrgZrSyaroxFdQMzZ5OUXfEaEo=;
	b=bytN1gqJHgJGnBOq7oRjAz09C0GjXIHo14vg+UIcurTQ41YP6OlTuKQFVOjrUxWzz3
	O4mdbmYyJsPU9IUk+RzqgXU9bGmwFdWltKdxZcTVsdLz95K7h+hsuJlh1hcVwG2XGoE9
	jh4nOqN3xUv9BxwydwSCmR92JUAMqJqUVeKvJfQxw7f0NydmeO8UXUTX+FRUKVgJuYsp
	JqlsD/HO6d7G0d5gVknifCiYGlMNpk1NHFTIF9I82flR8W56L43rcCGHSgzSLlLds1Es
	YyADE6c9gOMLf+1VaNJ4aPC89CYagNuXuZ15PrI6x+r3uIVyJc4C98mtJcAZrbMsieY7
	G+pg==
X-Gm-Message-State: AOPr4FVNl5lxRzde6VHXejME6C9GdIMJ2eKyr6xYg5GnFvGTJQd/R/eI4+SuetYAPwJ3fe12
X-Received: by 10.28.47.206 with SMTP id v197mr1286204wmv.87.1461083335534;
	Tue, 19 Apr 2016 09:28:55 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:54 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:37 +0100
Message-Id: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH 00/10] Patches from Toaster reivew queue
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
X-List-Received-Date: Tue, 19 Apr 2016 16:28:58 -0000

Patches from toaster-next which were held up.

Fixes for:
[YOCTO #8511]
[YOCTO #9011]
[YOCTO #9123]
[YOCTO #9209]

Elliot Smith (9):
  toaster: fix sorting after hiding a column in build tables
  toaster: disable/enable "Add layer" button according to input's
    content
  toaster: only prevent duplicate custom image names within a project
  toaster: prevent exception when Project.release is null
  toaster-tests: add tests for new custom image page
  toaster-tests: make helper click on input before entering text
  toaster: add build dashboard buttons to edit/create custom images
  toaster: add modal to select custom image for editing
  toaster-tests: tests for build dashboard

Michael Wood (1):
  toaster: ensure ToasterTable headings are reset when order by changes

 lib/toaster/orm/models.py                          |  64 +++++-
 lib/toaster/tests/browser/selenium_helpers.py      |   6 +-
 .../tests/browser/test_builddashboard_page.py      | 251 +++++++++++++++++++++
 .../tests/browser/test_new_custom_image_page.py    | 160 +++++++++++++
 lib/toaster/toastergui/static/js/importlayer.js    |  30 ++-
 lib/toaster/toastergui/static/js/layerBtn.js       |   3 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |   5 +
 .../toastergui/static/js/newcustomimage_modal.js   | 104 ++++++++-
 lib/toaster/toastergui/static/js/recipedetails.js  |   3 +-
 lib/toaster/toastergui/static/js/table.js          |   6 +-
 lib/toaster/toastergui/templates/base.html         |   1 -
 .../toastergui/templates/basebuildpage.html        | 213 +++++++++++------
 .../templates/editcustomimage_modal.html           |  71 ++++++
 .../toastergui/templates/newcustomimage_modal.html |  28 ++-
 lib/toaster/toastergui/templates/tasks.html        |   2 +-
 .../templatetags/objects_to_dictionaries_filter.py |  35 +++
 lib/toaster/toastergui/tests.py                    |  87 -------
 lib/toaster/toastergui/views.py                    | 116 ++++++----
 18 files changed, 953 insertions(+), 232 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_builddashboard_page.py
 create mode 100644 lib/toaster/tests/browser/test_new_custom_image_page.py
 create mode 100644 lib/toaster/toastergui/templates/editcustomimage_modal.html
 create mode 100644 lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py

-- 
2.5.0


