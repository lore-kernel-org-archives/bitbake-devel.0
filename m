Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 9C8BF759D5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:36 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97492869pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=CdlY2oJbSE2v2YdyEYadJpKg+ZQRkYCW3joJtYfWOdw=;
	b=EUoFl9iMPqmLx3xHulw9XBpgzN92GFtU/szr82f5u6Oh3hLVFXVEIER3IlgL2NUu7R
	o2cU7fDG9dWpfmrqcRDqOOO0pYFpAKwYH6LxhEM45U4OYAjhJF20dg/3yr6HiyMrwXFS
	mEs5rPVLe7AZbO8DVvTktQvgvpf0NTtqj3LHzA98kjP5lwK/oZVt6wBc0A2bptIVpscm
	9w1tn/dS0plME5yo6rmkRDrCuEIfXSRhauQs0iXzE+FZXEjMhrFcCwbs4D4txI8PsNhM
	gAFdIRpjnxihlUbsknl8UiaiNlMYI1lanCymLkOir1WMFYBoVAAgCE/QaipgWhftgaMU
	IvOg==
X-Received: by 10.66.234.138 with SMTP id ue10mr31185152pac.9.1443501816621;
	Mon, 28 Sep 2015 21:43:36 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	b7sm22537205pbu.20.2015.09.28.21.43.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:35 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:12 -0700
Message-Id: <cover.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/22] image customization
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:37 -0000

This large patch set brings the databse changes needed to support image
customization as well as the skeleton of the image customization user 
interface.  The ui for image customization is off/hidden by default. 
The database changes fix bugs 7967,8035,8147, and 8403.

Thanks,
Brian

The following changes since commit f78f90240a3041be426c6ba9085849352164ee8b:

  bitbake: prserv/serv.py: Better messaging when starting/stopping the server with port=0 (2015-09-28 12:00:33 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/20150928_ic5.1
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/20150928_ic5.1

Ed Bartosh (5):
  toaster: make a workaround for old style index
  toaster: create custom layer and recipes for Image customisation
  toaster: implement decorator for REST responses
  toaster: Add new ReST API for Image Customisation feature
  toaster: Add test cases for new Image customisation features

Michael Wood (17):
  toaster: tables Move the title and name into the widget
  toaster: widgets ToasterTable add logger to notify when cache hit
  toaster: widgets ToasterTable Add more info to search field exception
  toaster: add nocache option to the ToasterTable widget
  toaster: ToasterTable remove unused class definition
  toaster: Add CustomImageRecipe model
  toaster: add toggle for enabling image customisation feeature
  toaster: Fix indentation of jsunittests view
  toaster: Add ToasterTables for Image customisation feature
  toaster: Add Image customisation frontend feature
  toaster: Special case the openembedded-core layer to avoid duplicates
  toaster: Create a relationship between build information and toaster
    layers
  toaster: Prioroitise the layer more generic vcs reference over the sha
  toaster: tables show all recipes in the layerdetails even duplicates
  toaster: buildinfohelper Create a copy of the built layer and recipe
  Revert "bitbake: toaster: don't re-create Target objects"
  toaster: orm remove the complicated querying on the ORM

 lib/bb/ui/buildinfohelper.py                       |  95 +++++-
 lib/toaster/bldcontrol/localhostbecontroller.py    |  51 ++-
 .../0009_auto__add_field_brlayer_layer_version.py  | 180 ++++++++++
 lib/toaster/bldcontrol/models.py                   |   3 +-
 ...e__add_unique_customimagerecipe_name_project.py | 375 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  91 +++--
 lib/toaster/toastergui/static/js/customrecipe.js   |  50 +++
 lib/toaster/toastergui/static/js/layerBtn.js       |  13 +
 lib/toaster/toastergui/static/js/newcustomimage.js |  49 +++
 lib/toaster/toastergui/tables.py                   | 230 +++++++++++--
 .../toastergui/templates/baseprojectpage.html      |   7 +-
 .../toastergui/templates/customise_btn.html        |   9 +
 lib/toaster/toastergui/templates/customrecipe.html | 142 ++++++++
 .../toastergui/templates/newcustomimage.html       |  54 +++
 .../toastergui/templates/pkg_add_rm_btn.html       |  16 +
 lib/toaster/toastergui/templates/project.html      |   2 +-
 .../toastergui/templates/projecttopbar.html        |   9 +-
 lib/toaster/toastergui/tests.py                    | 187 +++++++++-
 lib/toaster/toastergui/typeaheads.py               |   5 +-
 lib/toaster/toastergui/urls.py                     |  49 ++-
 lib/toaster/toastergui/views.py                    | 195 ++++++++++-
 lib/toaster/toastergui/widgets.py                  |  50 ++-
 lib/toaster/toastermain/settings.py                |   5 +
 23 files changed, 1724 insertions(+), 143 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0027_auto__add_customimagerecipe__add_unique_customimagerecipe_name_project.py
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/customrecipe.js
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/newcustomimage.js
 create mode 100644 bitbake/lib/toaster/toastergui/templates/customise_btn.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/customrecipe.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/newcustomimage.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/pkg_add_rm_btn.html

-- 
1.9.1


