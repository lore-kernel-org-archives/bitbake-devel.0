Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C914A6FF56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jun 2018 08:03:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w5S83rxH009936
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jun 2018 01:03:53 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.399.0; Thu, 28 Jun 2018 01:03:52 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 28 Jun 2018 00:59:00 -0700
Message-ID: <cover.1530172216.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 0/1] toaster: project_specific_12785 enhancement set
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
X-List-Received-Date: Thu, 28 Jun 2018 08:03:52 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

1) This is a large set of enhancements and fixes. 

I have posted it as one patch because (a) the changes are tightly
interwoven, (b) they have been debugged and tested together, and
(c) I want to conserve people's time.

2) This work was driven by two things:

  (a) The opportunity to use Toaster as the YP configuration tool for third-party GUIs. 

Wind River is in the process of open sourcing its Eclipse plug-ins for
application and project development. The those plug-ins currently work 
with Wind River Workbench and Intel System Studio, and we are in the 
process of open sourcing them to Eclipse.org for all users.

  (b) Comments from the YP Birds-of-a-Feather meeting at ELCE Prague. 

There were several comments made about limitations with Toaster. Those
needs aligned nicely with my personal goals with Toaster and especially
the requirements of the above opportunity.

3) Here is a summary of the included content:

The primary driving enhancement:

*  Bug 12785 - Support Project Specific configuration for external
   tools (e.g. ISS, Eclipse)

  -  Isolated project-specific configuration page (full Toaster context
     hidden)
  -  Support for new project, reconfigure existing project, and import
     existing command line project
  -  Ability to define variables (e.g. image recipe) and pass them back
     to external GUI
  -  Ability to execute the cloning phase, so that external GUI receive
     a buildable project
  -  Ability to call back to the external GUI when updates are completed
     and ready
  -  Compatibility of above projects with the normal full Toaster interface
  -  Ability to pass to a 'complete' or 'cancel' web page so that the
     external GUI can immediately stop that Toaster instance, and not
     leave dangling servers nor edit sessions open

Here are the supporting enhancements, where at least the
back end is implemented:

*  Bug 12821 - Make Toaster conf changes compatible with command line usage
*  Bug 12822 - Support importing user changes to conf files into Toaster
*  Bug 12823 - Support importing user build directories into Toaster
*  Bug 12824 - Scan imported layers for content so that they are
               immediately available
*  Bug 12825 - show layer clone item in progress bar

Here are defects fixed:

*  Bug 12817 - builddelete.py requires explicit 'add_arguments'
*  Bug 12818 - Remove orphaned imported layers when project is deleted
*  Bug 12819 - build using selected bitbake env, not Toaster's env
*  Bug 12820 - Toaster randomizes the layer order in toaster_bblayers.conf
*  Bug 12826 - fix imported layer management


The following changes since commit a5d1288804e517dee113cb9302149541f825d316:

  meta-yocto-bsp: Workaround the Ethernet malfunction on edgerouter when building with gcc8 (2018-06-21 09:59:26 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/project_specific_12785
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/project_specific_12785

David Reyna (1):
  toaster: project-specific enhancement set

 lib/toaster/bldcontrol/localhostbecontroller.py    | 172 ++++--
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 .../orm/migrations/0018_project_specific.py        |  28 +
 lib/toaster/orm/models.py                          |  58 +-
 lib/toaster/toastergui/api.py                      | 168 +++++-
 lib/toaster/toastergui/static/js/layerBtn.js       |  12 +
 lib/toaster/toastergui/static/js/layerdetails.js   |   3 +-
 lib/toaster/toastergui/static/js/libtoaster.js     | 105 ++++
 lib/toaster/toastergui/static/js/mrbsection.js     |   4 +-
 lib/toaster/toastergui/static/js/projecttopbar.js  |  22 +
 lib/toaster/toastergui/tables.py                   |   4 +
 .../toastergui/templates/base_specific.html        | 128 +++++
 .../templates/baseprojectspecificpage.html         |  48 ++
 .../templates/generic-toastertable-page.html       |   2 +-
 lib/toaster/toastergui/templates/importlayer.html  |   4 +-
 .../toastergui/templates/landing_specific.html     |  50 ++
 lib/toaster/toastergui/templates/layerdetails.html |   3 +-
 lib/toaster/toastergui/templates/mrb_section.html  |   2 +-
 .../toastergui/templates/newcustomimage.html       |   4 +-
 .../toastergui/templates/newproject_specific.html  |  95 ++++
 lib/toaster/toastergui/templates/project.html      |   7 +-
 .../toastergui/templates/project_specific.html     | 162 ++++++
 .../templates/project_specific_topbar.html         |  80 +++
 lib/toaster/toastergui/templates/projectconf.html  |   7 +-
 .../toastergui/templates/recipe_add_btn.html       |  23 +
 lib/toaster/toastergui/urls.py                     |  13 +
 lib/toaster/toastergui/views.py                    | 151 ++++++
 lib/toaster/toastergui/widgets.py                  |   6 +
 .../toastermain/management/commands/builddelete.py |   6 +-
 .../toastermain/management/commands/buildimport.py | 586 +++++++++++++++++++++
 30 files changed, 1899 insertions(+), 56 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0018_project_specific.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/base_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/baseprojectspecificpage.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/landing_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/newproject_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/project_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/project_specific_topbar.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/recipe_add_btn.html
 mode change 100755 => 100644 bitbake/lib/toaster/toastergui/views.py
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/buildimport.py

-- 
1.9.1


