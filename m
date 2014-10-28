Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id C8F096E6A6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 14:06:02 +0000 (UTC)
Received: by mail-ob0-f169.google.com with SMTP id va2so567060obc.14
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 07:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=gCKm+6LAh0mltW0fRW6axfABB0mQcLaI/tDmsa2iA20=;
	b=B61A29ZoC+c61fz+PSTULmWZ9pszySiFOrrdzF/t1a7sMBdXu5QdSLjR3UfpRcaCBr
	8k5SHsnJQ+Ce0ITb0g81GwhGoaGnsrdcBDz7w4/Uf+fWsOKjsM5vcrZuQJ+ISW4NjAoJ
	Wax6rTkHXolphUi5JYRCHpGrU6lxEUkhfWZ2vnvYBWo2f1iXJe0TdWYuAdP335wT6klk
	8js6U08BPPP2IBGkcsHMWooB8dAsDPKh8nfOsQ63t9mbvj79zoNIm8S+T4vGZMOUbR3n
	houX581AIfQDqlwCjxGTEe+tjUP/USB49aqmb+QarmvnnWlTWZdqBDpebxZ2EIZadgPO
	ZNgw==
X-Gm-Message-State: ALoCoQlRmrQJHOhwKE12NCSyHKu7OSH1lkhBFI2pIi/dDUliPI19KbTKjIw69hvQMaLsr6vdDUSd
X-Received: by 10.202.222.9 with SMTP id v9mr842220oig.112.1414505161712; Tue,
	28 Oct 2014 07:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.134.106 with HTTP; Tue, 28 Oct 2014 07:05:41 -0700 (PDT)
In-Reply-To: <cover.1414504737.git.alexandru.damian@intel.com>
References: <cover.1414504737.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Tue, 28 Oct 2014 14:05:41 +0000
Message-ID: <CAJ2CSBskai7eT+d7i8kO3tUt8=MPkVHDRPvZ8gwVRDThQtGdHg@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: Re: [PATCH 00/25] Toaster build functionality patchset
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
X-List-Received-Date: Tue, 28 Oct 2014 14:06:10 -0000
Content-Type: multipart/alternative; boundary=001a113cf39eb27cc905067c2580

--001a113cf39eb27cc905067c2580
Content-Type: text/plain; charset=UTF-8

Hello,

Due to the line length of one of the patches (verbatim copies of the
angular-cookie library), sendmail/procmail refuses to send this patchset.


Can you please pull from

poky-contrib:adamian/20141028-bb-submission
<http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/20141028-bb-submission>

Thank you,
Alex

On Tue, Oct 28, 2014 at 2:02 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> This patchset brings in the toaster build function updates,
> with backend features and new frontend pages.
>
> Can you please pull at your convenience ?
>
> Cheers,
> Alex
>
>
> The following changes since commit
> afa2431c21b8271b05dc4cca4265f98d9f338007:
>
>   toastergui fix size rendering in dirinfo page (2014-09-29 14:11:20 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20141028-bb-submission
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141028-bb-submission
>
> Alexandru DAMIAN (16):
>   toasterbld: update checksettings command
>   toasterui: save build id in build request on first chance
>   toastergui: update breadcrumb in analysis pages
>   toaster: we add static copies of AngularJS and related libraries
>   toaster: fix layer source update code
>   toaster: fix Project page in order to trigger builds
>   toastergui: project edit capabilities in all layers page
>   toastergui: refactor objects get in views.py
>   toastergui: protect variable value reads
>   toaster: changes to the landing page
>   toaster: use modified validators for git url fields
>   toaster: improvements for admin pages
>   toaster: change startup parameter passing to avoid race
>   toastergui: provide download file capability
>   toaster: update web vcs fields for layers
>   bitbake: clarify startup message
>
> Belen Barros (1):
>   toastergui: Amend show rows options
>
> Belen Barros Pena (8):
>   toastergui: Fix help text in packages 'Reverse runtime dependencies'
>     tab
>   toastergui: Add missing task descriptions
>   toastergui: Fix reverse dependencies tab for packages included
>   toastergui: Fix blue highlight for failed tasks
>   toastergui: Remove sorting from "Size over total" column
>   toastergui: Remove extra <div> from build dashboard
>   toastergui: Tiny change to help text
>   toastergui: Show failed tasks in the build dashboard
>
>  bin/bitbake                                        |   2 +-
>  bin/toaster                                        |  15 +-
>  lib/bb/ui/buildinfohelper.py                       |  16 +-
>  lib/bb/ui/toasterui.py                             |   5 +-
>  lib/toaster/bldcontrol/bbcontroller.py             |   6 +-
>  lib/toaster/bldcontrol/localhostbecontroller.py    |  39 +-
>  .../management/commands/checksettings.py           |  47 +-
>  .../bldcontrol/management/commands/runbuilds.py    |  19 +-
>  ...st_environment__chg_field_buildrequest_build.py | 145 +++++
>  lib/toaster/bldcontrol/models.py                   |  16 +-
>  lib/toaster/bldcontrol/sshbecontroller.py          |   4 +-
>  lib/toaster/bldcontrol/tests.py                    |  10 +-
>  lib/toaster/orm/admin.py                           |  23 +-
>  ...mmary__chg_field_layer_summary__chg_field_re.py | 336 +++++++++++
>  ...web_url__add_field_layer_vcs_web_tree_base_u.py | 336 +++++++++++
>  lib/toaster/orm/models.py                          | 180 ++++--
>  lib/toaster/toastergui/static/css/default.css      |  65 +-
>  .../toastergui/static/js/angular-cookies.min.js    |   8 +
>  lib/toaster/toastergui/static/js/angular.min.js    | 215 +++++++
>  .../toastergui/static/js/angular.min.js.map        |   8 +
>  lib/toaster/toastergui/static/js/projectapp.js     | 531 +++++++++++++++++
>  .../static/js/ui-bootstrap-tpls-0.11.0.js          |  10 +
>  .../static/js/ui-bootstrap-tpls-0.11.0.min.js      |  10 +
>  lib/toaster/toastergui/templates/base.html         |  12 -
>  .../toastergui/templates/basebuilddetailpage.html  |   5 +-
>  .../toastergui/templates/basebuildpage.html        |   7 +-
>  .../toastergui/templates/baseprojectpage.html      |   8 +-
>  .../toastergui/templates/basetable_bottom.html     |   2 +-
>  .../toastergui/templates/basetable_top.html        |   3 +-
>  .../templates/basetable_top_buildprojects.html     |  16 +
>  .../toastergui/templates/basetable_top_layers.html |   5 +
>  .../templates/basetable_top_projectbuilds.html     |  16 +
>  lib/toaster/toastergui/templates/build.html        |  85 +--
>  .../toastergui/templates/builddashboard.html       |  27 +-
>  lib/toaster/toastergui/templates/landing.html      |  66 +++
>  lib/toaster/toastergui/templates/layers.html       | 290 +++++----
>  lib/toaster/toastergui/templates/mrb_section.html  | 102 ++++
>  lib/toaster/toastergui/templates/newproject.html   |   7 -
>  .../package_included_reverse_dependencies.html     |   4 +-
>  lib/toaster/toastergui/templates/project.html      | 652
> ++++++++++-----------
>  lib/toaster/toastergui/templates/projects.html     |  36 ++
>  lib/toaster/toastergui/templates/task.html         |   9 +-
>  lib/toaster/toastergui/templatetags/projecttags.py |  11 +
>  lib/toaster/toastergui/urls.py                     |  12 +-
>  lib/toaster/toastergui/views.py                    | 516 +++++++++++++---
>  45 files changed, 3198 insertions(+), 739 deletions(-)
>  create mode 100644
> lib/toaster/bldcontrol/migrations/0007_auto__add_field_buildrequest_environment__chg_field_buildrequest_build.py
>  create mode 100644
> lib/toaster/orm/migrations/0014_auto__chg_field_package_summary__chg_field_layer_summary__chg_field_re.py
>  create mode 100644
> lib/toaster/orm/migrations/0015_auto__add_field_layer_vcs_web_url__add_field_layer_vcs_web_tree_base_u.py
>  create mode 100644 lib/toaster/toastergui/static/js/angular-cookies.min.js
>  create mode 100644 lib/toaster/toastergui/static/js/angular.min.js
>  create mode 100644 lib/toaster/toastergui/static/js/angular.min.js.map
>  create mode 100644 lib/toaster/toastergui/static/js/projectapp.js
>  create mode 100644
> lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.js
>  create mode 100644
> lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.min.js
>  create mode 100644
> lib/toaster/toastergui/templates/basetable_top_buildprojects.html
>  create mode 100644
> lib/toaster/toastergui/templates/basetable_top_layers.html
>  create mode 100644
> lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
>  create mode 100644 lib/toaster/toastergui/templates/landing.html
>  create mode 100644 lib/toaster/toastergui/templates/mrb_section.html
>  create mode 100644 lib/toaster/toastergui/templates/projects.html
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--001a113cf39eb27cc905067c2580
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,<br><br>Due to the line length of one of the patches (verb=
atim copies of the angular-cookie library), sendmail/procmail refuses to se=
nd this patchset.<br><br><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:tahoma,sans-serif">Can you please pull from<br><br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">poky-contrib:<=
a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Da=
damian/20141028-bb-submission">adamian/20141028-bb-submission</a><br><br></=
div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Th=
ank you,<br>Alex<br></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Oct 28, 2014 at 2:02 PM, Alex DAMIAN <span dir=3D"=
ltr">&lt;<a href=3D"mailto:alexandru.damian@intel.com" target=3D"_blank">al=
exandru.damian@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.c=
om">alexandru.damian@intel.com</a>&gt;<br>
<br>
This patchset brings in the toaster build function updates,<br>
with backend features and new frontend pages.<br>
<br>
Can you please pull at your convenience ?<br>
<br>
Cheers,<br>
Alex<br>
<br>
<br>
The following changes since commit afa2431c21b8271b05dc4cca4265f98d9f338007=
:<br>
<br>
=C2=A0 toastergui fix size rendering in dirinfo page (2014-09-29 14:11:20 +=
0100)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20141028-bb-submissi=
on<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20141028-bb-submission" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20141028-bb-submission</a><br>
<br>
Alexandru DAMIAN (16):<br>
=C2=A0 toasterbld: update checksettings command<br>
=C2=A0 toasterui: save build id in build request on first chance<br>
=C2=A0 toastergui: update breadcrumb in analysis pages<br>
=C2=A0 toaster: we add static copies of AngularJS and related libraries<br>
=C2=A0 toaster: fix layer source update code<br>
=C2=A0 toaster: fix Project page in order to trigger builds<br>
=C2=A0 toastergui: project edit capabilities in all layers page<br>
=C2=A0 toastergui: refactor objects get in views.py<br>
=C2=A0 toastergui: protect variable value reads<br>
=C2=A0 toaster: changes to the landing page<br>
=C2=A0 toaster: use modified validators for git url fields<br>
=C2=A0 toaster: improvements for admin pages<br>
=C2=A0 toaster: change startup parameter passing to avoid race<br>
=C2=A0 toastergui: provide download file capability<br>
=C2=A0 toaster: update web vcs fields for layers<br>
=C2=A0 bitbake: clarify startup message<br>
<br>
Belen Barros (1):<br>
=C2=A0 toastergui: Amend show rows options<br>
<br>
Belen Barros Pena (8):<br>
=C2=A0 toastergui: Fix help text in packages &#39;Reverse runtime dependenc=
ies&#39;<br>
=C2=A0 =C2=A0 tab<br>
=C2=A0 toastergui: Add missing task descriptions<br>
=C2=A0 toastergui: Fix reverse dependencies tab for packages included<br>
=C2=A0 toastergui: Fix blue highlight for failed tasks<br>
=C2=A0 toastergui: Remove sorting from &quot;Size over total&quot; column<b=
r>
=C2=A0 toastergui: Remove extra &lt;div&gt; from build dashboard<br>
=C2=A0 toastergui: Tiny change to help text<br>
=C2=A0 toastergui: Show failed tasks in the build dashboard<br>
<br>
=C2=A0bin/bitbake=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0bin/toaster=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 15 +-<br>
=C2=A0lib/bb/ui/buildinfohelper.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0lib/bb/ui/toasterui.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 =
+-<br>
=C2=A0lib/toaster/bldcontrol/bbcontroller.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0lib/toaster/bldcontrol/localhostbecontroller.py=C2=A0 =C2=A0 |=C2=A0 =
39 +-<br>
=C2=A0.../management/commands/checksettings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 47 +-<br>
=C2=A0.../bldcontrol/management/commands/runbuilds.py=C2=A0 =C2=A0 |=C2=A0 =
19 +-<br>
=C2=A0...st_environment__chg_field_buildrequest_build.py | 145 +++++<br>
=C2=A0lib/toaster/bldcontrol/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0lib/toaster/bldcontrol/sshbecontroller.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0lib/toaster/bldcontrol/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0lib/toaster/orm/admin.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 +-<br>
=C2=A0...mmary__chg_field_layer_summary__chg_field_re.py | 336 +++++++++++<=
br>
=C2=A0...web_url__add_field_layer_vcs_web_tree_base_u.py | 336 +++++++++++<=
br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 180 ++++--<br>
=C2=A0lib/toaster/toastergui/static/css/default.css=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 65 +-<br>
=C2=A0.../toastergui/static/js/angular-cookies.min.js=C2=A0 =C2=A0 |=C2=A0 =
=C2=A08 +<br>
=C2=A0lib/toaster/toastergui/static/js/angular.min.js=C2=A0 =C2=A0 | 215 ++=
+++++<br>
=C2=A0.../toastergui/static/js/angular.min.js.map=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A08 +<br>
=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0 =C2=A0 =C2=A0| 5=
31 +++++++++++++++++<br>
=C2=A0.../static/js/ui-bootstrap-tpls-0.11.0.js=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 10 +<br>
=C2=A0.../static/js/ui-bootstrap-tpls-0.11.0.min.js=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 10 +<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 12 -<br>
=C2=A0.../toastergui/templates/basebuilddetailpage.html=C2=A0 |=C2=A0 =C2=
=A05 +-<br>
=C2=A0.../toastergui/templates/basebuildpage.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0.../toastergui/templates/baseprojectpage.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A08 +-<br>
=C2=A0.../toastergui/templates/basetable_bottom.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0.../toastergui/templates/basetable_top.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0.../templates/basetable_top_buildprojects.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 16 +<br>
=C2=A0.../toastergui/templates/basetable_top_layers.html |=C2=A0 =C2=A05 +<=
br>
=C2=A0.../templates/basetable_top_projectbuilds.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 16 +<br>
=C2=A0lib/toaster/toastergui/templates/build.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 85 +--<br>
=C2=A0.../toastergui/templates/builddashboard.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 27 +-<br>
=C2=A0lib/toaster/toastergui/templates/landing.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 66 +++<br>
=C2=A0lib/toaster/toastergui/templates/layers.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 290 +++++----<br>
=C2=A0lib/toaster/toastergui/templates/mrb_section.html=C2=A0 | 102 ++++<br=
>
=C2=A0lib/toaster/toastergui/templates/newproject.html=C2=A0 =C2=A0|=C2=A0 =
=C2=A07 -<br>
=C2=A0.../package_included_reverse_dependencies.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +-<br>
=C2=A0lib/toaster/toastergui/templates/project.html=C2=A0 =C2=A0 =C2=A0 | 6=
52 ++++++++++-----------<br>
=C2=A0lib/toaster/toastergui/templates/projects.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 36 ++<br>
=C2=A0lib/toaster/toastergui/templates/task.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A09 +-<br>
=C2=A0lib/toaster/toastergui/templatetags/projecttags.py |=C2=A0 11 +<br>
=C2=A0lib/toaster/toastergui/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 516 +++++++++++++---<br>
=C2=A045 files changed, 3198 insertions(+), 739 deletions(-)<br>
=C2=A0create mode 100644 lib/toaster/bldcontrol/migrations/0007_auto__add_f=
ield_buildrequest_environment__chg_field_buildrequest_build.py<br>
=C2=A0create mode 100644 lib/toaster/orm/migrations/0014_auto__chg_field_pa=
ckage_summary__chg_field_layer_summary__chg_field_re.py<br>
=C2=A0create mode 100644 lib/toaster/orm/migrations/0015_auto__add_field_la=
yer_vcs_web_url__add_field_layer_vcs_web_tree_base_u.py<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular-cookies.m=
in.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular.min.js<br=
>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular.min.js.ma=
p<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/projectapp.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/ui-bootstrap-tpls=
-0.11.0.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/ui-bootstrap-tpls=
-0.11.0.min.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/basetable_top_bui=
ldprojects.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/basetable_top_lay=
ers.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/basetable_top_pro=
jectbuilds.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/landing.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/mrb_section.html<=
br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/projects.html<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div><=
/div>
</div>

--001a113cf39eb27cc905067c2580--
