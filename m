Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id 46C7374120
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 11:24:20 +0000 (UTC)
Received: by iepk2 with SMTP id k2so56040443iep.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 04:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=+bAONn7xfd8bpEjlQ+9PiwyGwX8UWQ4G6rcHyPTDlUk=;
	b=lf+cNlsHVqXswrMkKXOOvqrCZqaBSNuagDgD6ORWEZUyF90sTfIFNunh0p3rc7ya4c
	45djIUGkNmRcy6mCk1iU5mEwH19ZLd/nsg5OzRV2tTeEXG8lsx5CuAkBsxnkugz1Fpt9
	OqnZ0MBboWx1I4YbVtbX0l0UoI7Nhbq6LT/x586X7hkjY58497LXxABYbGJuEggY8Uwh
	qyjNN9flQzf1lTYdeomy4LFqdFEBFaop1A3BVeWgxhNO3WzM87GDf89v9rgSBueUv/NR
	QRRInCl4mhC2nYT3VTEc2hCcmBWr/BipbiZ82HHiitu8khiuoMABAbwyRGIyD3IWefaq
	zloQ==
X-Gm-Message-State: ALoCoQlsTVfXJPq1Q4SPreDmTrC9dskbnIkNsAvivmfGWP6sjX6WtMsVoyLwfh8tsPSTrfTqkaNd
X-Received: by 10.42.200.8 with SMTP id eu8mr14188205icb.65.1431602661872;
	Thu, 14 May 2015 04:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.10.67 with HTTP; Thu, 14 May 2015 04:24:01 -0700 (PDT)
In-Reply-To: <cover.1431598055.git.alexandru.damian@intel.com>
References: <cover.1431598055.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Thu, 14 May 2015 12:24:01 +0100
Message-ID: <CAJ2CSBvVz-O0afZa0cVN4=Q775VZfbsxmGnOQxPx0SxuLgnf=A@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/8] Toaster patchset
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
X-List-Received-Date: Thu, 14 May 2015 11:24:22 -0000
Content-Type: multipart/alternative; boundary=90e6ba6148d21eeb1b051608f8c2

--90e6ba6148d21eeb1b051608f8c2
Content-Type: text/plain; charset=UTF-8

Hello,

Postfix refuses to mail this patchsed due to very long lines in files.

Can you please pull from

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150514-submission-bb

Thank you,
Alex


On Thu, May 14, 2015 at 11:11 AM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> This toaster patchset allows brings in refactoring of some of the table
> pages, removing the "Simple UI", and bringing in the Toaster Test system
> under a contrib/ directory.
>
> Updates are made to bring the project in HTML5 compliance.
>
> Can you please pull when possible ?
>
> Cheers,
> Alex
>
>
> The following changes since commit
> c7263096ba31ba45daeeb9de90c1cb9ebef24a28:
>
>   fetch2: Add BB_ALLOWED_NETWORKS support (2015-05-12 12:17:08 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20150514-submission-bb
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150514-submission-bb
>
> Alexandru DAMIAN (3):
>   toaster: fix html5 compliance
>   toaster/contrib: adding TTS squashed patch
>   toastergui: tables updates for HTML5 compliance
>
> Belen Barros Pena (1):
>   toastergui: change the import layer action help text
>
> Michael Wood (4):
>   toaster: Remove old bldviewer application
>   toaster: managedcontextprocessor requires Project imported
>   toaster: Add toaster table widget
>   toaster: Port All recipes, layers and machines to ToasterTables
>
>  lib/toaster/bldviewer/api.py                       |   44 -
>  lib/toaster/bldviewer/static/css/bootstrap.css     | 4797
> --------------------
>  lib/toaster/bldviewer/static/js/bootstrap.js       | 1982 --------
>  lib/toaster/bldviewer/static/js/jquery-2.0.3.js    |    6 -
>  lib/toaster/bldviewer/templates/simple_base.html   |   30 -
>  .../bldviewer/templates/simple_basebuildpage.html  |   17 -
>  .../bldviewer/templates/simple_basetable.html      |   64 -
>  lib/toaster/bldviewer/templates/simple_bfile.html  |   24 -
>  .../bldviewer/templates/simple_bpackage.html       |   44 -
>  lib/toaster/bldviewer/templates/simple_build.html  |   43 -
>  .../bldviewer/templates/simple_configuration.html  |   22 -
>  lib/toaster/bldviewer/templates/simple_layer.html  |   34 -
>  .../bldviewer/templates/simple_package.html        |   36 -
>  lib/toaster/bldviewer/templates/simple_recipe.html |   50 -
>  lib/toaster/bldviewer/templates/simple_task.html   |   71 -
>  lib/toaster/bldviewer/templatetags/__init__.py     |    0
>  lib/toaster/bldviewer/tests.py                     |  345 --
>  lib/toaster/bldviewer/urls.py                      |   35 -
>  lib/toaster/bldviewer/views.py                     |  287 --
>  lib/toaster/contrib/README                         |    6 +
>  lib/toaster/contrib/tts/README                     |   41 +
>  lib/toaster/contrib/tts/TODO                       |    9 +
>  lib/toaster/contrib/tts/backlog.txt                |    2 +
>  lib/toaster/contrib/tts/config.py                  |   70 +
>  lib/toaster/contrib/tts/launcher.py                |  100 +
>  .../__init__.py => contrib/tts/log/.create}        |    0
>  .../simple_projecttags.py => contrib/tts/recv.py}  |   42 +-
>  lib/toaster/contrib/tts/runner.py                  |  200 +
>  lib/toaster/contrib/tts/scratchpad.py              |   20 +
>  lib/toaster/contrib/tts/settings.json              |    5 +
>  lib/toaster/contrib/tts/shellutils.py              |  139 +
>  lib/toaster/contrib/tts/tests.py                   |   57 +
>  .../contrib/tts/toasteruitest/run_toastertests.py  |   87 +
>  .../tts/toasteruitest/toaster_automation_test.py   | 1924 ++++++++
>  .../contrib/tts/toasteruitest/toaster_test.cfg     |   21 +
>  lib/toaster/contrib/tts/urlcheck.py                |   44 +
>  lib/toaster/contrib/tts/urllist.py                 |   53 +
>  lib/toaster/orm/models.py                          |   13 +-
>  lib/toaster/toastergui/static/css/default.css      |    3 +
>  lib/toaster/toastergui/static/js/layerBtn.js       |    5 +-
>  lib/toaster/toastergui/static/js/libtoaster.js     |    3 +
>  lib/toaster/toastergui/static/js/table.js          |  485 ++
>  lib/toaster/toastergui/tables.py                   |  279 ++
>  lib/toaster/toastergui/templates/base.html         |    8 +-
>  .../toastergui/templates/baseprojectpage.html      |    3 +-
>  .../toastergui/templates/builddashboard.html       |    2 +-
>  .../toastergui/templates/buildrequestdetails.html  |    2 +-
>  .../templates/generic-toastertable-page.html       |   25 +
>  lib/toaster/toastergui/templates/importlayer.html  |   18 +-
>  lib/toaster/toastergui/templates/layer_btn.html    |    9 +
>  lib/toaster/toastergui/templates/layerdetails.html |   50 +-
>  lib/toaster/toastergui/templates/layers.html       |  132 -
>  lib/toaster/toastergui/templates/machine_btn.html  |    8 +
>  lib/toaster/toastergui/templates/machines.html     |   88 -
>  lib/toaster/toastergui/templates/newproject.html   |    7 +-
>  lib/toaster/toastergui/templates/project.html      |  184 +-
>  lib/toaster/toastergui/templates/recipe.html       |    6 +-
>  lib/toaster/toastergui/templates/recipe_btn.html   |    8 +
>  lib/toaster/toastergui/templates/targets.html      |  142 -
>  lib/toaster/toastergui/templates/task.html         |   37 +-
>  lib/toaster/toastergui/templates/toastertable.html |  116 +
>  lib/toaster/toastergui/urls.py                     |   40 +-
>  lib/toaster/toastergui/views.py                    |  285 +-
>  lib/toaster/toastergui/widgets.py                  |  316 ++
>  lib/toaster/toastermain/urls.py                    |    2 -
>  65 files changed, 4272 insertions(+), 8755 deletions(-)
>  delete mode 100644 lib/toaster/bldviewer/api.py
>  delete mode 100644 lib/toaster/bldviewer/static/css/bootstrap.css
>  delete mode 100644 lib/toaster/bldviewer/static/js/bootstrap.js
>  delete mode 100644 lib/toaster/bldviewer/static/js/jquery-2.0.3.js
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_base.html
>  delete mode 100644
> lib/toaster/bldviewer/templates/simple_basebuildpage.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_basetable.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_bfile.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_bpackage.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_build.html
>  delete mode 100644
> lib/toaster/bldviewer/templates/simple_configuration.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_layer.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_package.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_recipe.html
>  delete mode 100644 lib/toaster/bldviewer/templates/simple_task.html
>  delete mode 100644 lib/toaster/bldviewer/templatetags/__init__.py
>  delete mode 100644 lib/toaster/bldviewer/tests.py
>  delete mode 100644 lib/toaster/bldviewer/urls.py
>  delete mode 100644 lib/toaster/bldviewer/views.py
>  create mode 100644 lib/toaster/contrib/README
>  create mode 100644 lib/toaster/contrib/tts/README
>  create mode 100644 lib/toaster/contrib/tts/TODO
>  create mode 100644 lib/toaster/contrib/tts/backlog.txt
>  create mode 100644 lib/toaster/contrib/tts/config.py
>  create mode 100755 lib/toaster/contrib/tts/launcher.py
>  rename lib/toaster/{bldviewer/__init__.py => contrib/tts/log/.create}
> (100%)
>  rename lib/toaster/{bldviewer/templatetags/simple_projecttags.py =>
> contrib/tts/recv.py} (41%)
>  mode change 100644 => 100755
>  create mode 100755 lib/toaster/contrib/tts/runner.py
>  create mode 100644 lib/toaster/contrib/tts/scratchpad.py
>  create mode 100644 lib/toaster/contrib/tts/settings.json
>  create mode 100644 lib/toaster/contrib/tts/shellutils.py
>  create mode 100644 lib/toaster/contrib/tts/tests.py
>  create mode 100755
> lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
>  create mode 100755
> lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
>  create mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
>  create mode 100644 lib/toaster/contrib/tts/urlcheck.py
>  create mode 100644 lib/toaster/contrib/tts/urllist.py
>  create mode 100644 lib/toaster/toastergui/static/js/table.js
>  create mode 100644 lib/toaster/toastergui/tables.py
>  create mode 100644
> lib/toaster/toastergui/templates/generic-toastertable-page.html
>  create mode 100644 lib/toaster/toastergui/templates/layer_btn.html
>  delete mode 100644 lib/toaster/toastergui/templates/layers.html
>  create mode 100644 lib/toaster/toastergui/templates/machine_btn.html
>  delete mode 100644 lib/toaster/toastergui/templates/machines.html
>  create mode 100644 lib/toaster/toastergui/templates/recipe_btn.html
>  delete mode 100644 lib/toaster/toastergui/templates/targets.html
>  create mode 100644 lib/toaster/toastergui/templates/toastertable.html
>  create mode 100644 lib/toaster/toastergui/widgets.py
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--90e6ba6148d21eeb1b051608f8c2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">Postfix refuses to mail this patchsed due to very long=
 lines in files.</div><div class=3D"gmail_default" style=3D"font-family:tah=
oma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:tahoma,sans-serif">Can you please pull from=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"g=
mail_default"><font face=3D"tahoma, sans-serif"><a href=3D"http://git.yocto=
project.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150514-submission-bb">=
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150514=
-submission-bb</a></font><br></div><div class=3D"gmail_default"><font face=
=3D"tahoma, sans-serif"><br></font></div><div class=3D"gmail_default"><font=
 face=3D"tahoma, sans-serif">Thank you,</font></div><div class=3D"gmail_def=
ault"><font face=3D"tahoma, sans-serif">Alex</font></div><div class=3D"gmai=
l_default" style=3D"font-family:tahoma,sans-serif"><br></div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 14, 2015 at 1=
1:11 AM, Alex DAMIAN <span dir=3D"ltr">&lt;<a href=3D"mailto:alexandru.dami=
an@intel.com" target=3D"_blank">alexandru.damian@intel.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">From: Alexandru DAMIAN &lt;<a href=
=3D"mailto:alexandru.damian@intel.com">alexandru.damian@intel.com</a>&gt;<b=
r>
<br>
This toaster patchset allows brings in refactoring of some of the table<br>
pages, removing the &quot;Simple UI&quot;, and bringing in the Toaster Test=
 system<br>
under a contrib/ directory.<br>
<br>
Updates are made to bring the project in HTML5 compliance.<br>
<br>
Can you please pull when possible ?<br>
<br>
Cheers,<br>
Alex<br>
<br>
<br>
The following changes since commit c7263096ba31ba45daeeb9de90c1cb9ebef24a28=
:<br>
<br>
=C2=A0 fetch2: Add BB_ALLOWED_NETWORKS support (2015-05-12 12:17:08 +0100)<=
br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20150514-submission-=
bb<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20150514-submission-bb" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150514-submission-bb</a><br>
<br>
Alexandru DAMIAN (3):<br>
=C2=A0 toaster: fix html5 compliance<br>
=C2=A0 toaster/contrib: adding TTS squashed patch<br>
=C2=A0 toastergui: tables updates for HTML5 compliance<br>
<br>
Belen Barros Pena (1):<br>
=C2=A0 toastergui: change the import layer action help text<br>
<br>
Michael Wood (4):<br>
=C2=A0 toaster: Remove old bldviewer application<br>
=C2=A0 toaster: managedcontextprocessor requires Project imported<br>
=C2=A0 toaster: Add toaster table widget<br>
=C2=A0 toaster: Port All recipes, layers and machines to ToasterTables<br>
<br>
=C2=A0lib/toaster/bldviewer/api.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A044 -<br>
=C2=A0lib/toaster/bldviewer/static/css/bootstrap.css=C2=A0 =C2=A0 =C2=A0| 4=
797 --------------------<br>
=C2=A0lib/toaster/bldviewer/static/js/bootstrap.js=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 1982 --------<br>
=C2=A0lib/toaster/bldviewer/static/js/jquery-2.0.3.js=C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 6 -<br>
=C2=A0lib/toaster/bldviewer/templates/simple_base.html=C2=A0 =C2=A0|=C2=A0 =
=C2=A030 -<br>
=C2=A0.../bldviewer/templates/simple_basebuildpage.html=C2=A0 |=C2=A0 =C2=
=A017 -<br>
=C2=A0.../bldviewer/templates/simple_basetable.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A064 -<br>
=C2=A0lib/toaster/bldviewer/templates/simple_bfile.html=C2=A0 |=C2=A0 =C2=
=A024 -<br>
=C2=A0.../bldviewer/templates/simple_bpackage.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A044 -<br>
=C2=A0lib/toaster/bldviewer/templates/simple_build.html=C2=A0 |=C2=A0 =C2=
=A043 -<br>
=C2=A0.../bldviewer/templates/simple_configuration.html=C2=A0 |=C2=A0 =C2=
=A022 -<br>
=C2=A0lib/toaster/bldviewer/templates/simple_layer.html=C2=A0 |=C2=A0 =C2=
=A034 -<br>
=C2=A0.../bldviewer/templates/simple_package.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A036 -<br>
=C2=A0lib/toaster/bldviewer/templates/simple_recipe.html |=C2=A0 =C2=A050 -=
<br>
=C2=A0lib/toaster/bldviewer/templates/simple_task.html=C2=A0 =C2=A0|=C2=A0 =
=C2=A071 -<br>
=C2=A0lib/toaster/bldviewer/templatetags/__init__.py=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 0<br>
=C2=A0lib/toaster/bldviewer/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 345 --<br>
=C2=A0lib/toaster/bldviewer/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A035 -<br>
=C2=A0lib/toaster/bldviewer/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 287 --<br>
=C2=A0lib/toaster/contrib/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
=C2=A0lib/toaster/contrib/tts/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A041 +<br>
=C2=A0lib/toaster/contrib/tts/TODO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +<br>
=C2=A0lib/toaster/contrib/tts/backlog.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0lib/toaster/contrib/tts/config.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A070 +<br>
=C2=A0lib/toaster/contrib/tts/launcher.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 100 +<br>
=C2=A0.../__init__.py =3D&gt; contrib/tts/log/.create}=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 0<br>
=C2=A0.../simple_projecttags.py =3D&gt; contrib/tts/recv.py}=C2=A0 |=C2=A0 =
=C2=A042 +-<br>
=C2=A0lib/toaster/contrib/tts/runner.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 200 +<br>
=C2=A0lib/toaster/contrib/tts/scratchpad.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A020 +<br>
=C2=A0lib/toaster/contrib/tts/settings.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
=C2=A0lib/toaster/contrib/tts/shellutils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 139 +<br>
=C2=A0lib/toaster/contrib/tts/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A057 +<br>
=C2=A0.../contrib/tts/toasteruitest/run_toastertests.py=C2=A0 |=C2=A0 =C2=
=A087 +<br>
=C2=A0.../tts/toasteruitest/toaster_automation_test.py=C2=A0 =C2=A0| 1924 +=
+++++++<br>
=C2=A0.../contrib/tts/toasteruitest/toaster_test.cfg=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A021 +<br>
=C2=A0lib/toaster/contrib/tts/urlcheck.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A044 +<br>
=C2=A0lib/toaster/contrib/tts/urllist.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A053 +<br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A013 +-<br>
=C2=A0lib/toaster/toastergui/static/css/default.css=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +<br>
=C2=A0lib/toaster/toastergui/static/js/layerBtn.js=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 5 +-<br>
=C2=A0lib/toaster/toastergui/static/js/libtoaster.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 3 +<br>
=C2=A0lib/toaster/toastergui/static/js/table.js=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 485 ++<br>
=C2=A0lib/toaster/toastergui/tables.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 279 ++<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 8 +-<br>
=C2=A0.../toastergui/templates/baseprojectpage.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +-<br>
=C2=A0.../toastergui/templates/builddashboard.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 2 +-<br>
=C2=A0.../toastergui/templates/buildrequestdetails.html=C2=A0 |=C2=A0 =C2=
=A0 2 +-<br>
=C2=A0.../templates/generic-toastertable-page.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A025 +<br>
=C2=A0lib/toaster/toastergui/templates/importlayer.html=C2=A0 |=C2=A0 =C2=
=A018 +-<br>
=C2=A0lib/toaster/toastergui/templates/layer_btn.html=C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 9 +<br>
=C2=A0lib/toaster/toastergui/templates/layerdetails.html |=C2=A0 =C2=A050 +=
-<br>
=C2=A0lib/toaster/toastergui/templates/layers.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 132 -<br>
=C2=A0lib/toaster/toastergui/templates/machine_btn.html=C2=A0 |=C2=A0 =C2=
=A0 8 +<br>
=C2=A0lib/toaster/toastergui/templates/machines.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A088 -<br>
=C2=A0lib/toaster/toastergui/templates/newproject.html=C2=A0 =C2=A0|=C2=A0 =
=C2=A0 7 +-<br>
=C2=A0lib/toaster/toastergui/templates/project.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 184 +-<br>
=C2=A0lib/toaster/toastergui/templates/recipe.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 6 +-<br>
=C2=A0lib/toaster/toastergui/templates/recipe_btn.html=C2=A0 =C2=A0|=C2=A0 =
=C2=A0 8 +<br>
=C2=A0lib/toaster/toastergui/templates/targets.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 142 -<br>
=C2=A0lib/toaster/toastergui/templates/task.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A037 +-<br>
=C2=A0lib/toaster/toastergui/templates/toastertable.html |=C2=A0 116 +<br>
=C2=A0lib/toaster/toastergui/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A040 +-<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 285 +-<br>
=C2=A0lib/toaster/toastergui/widgets.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 316 ++<br>
=C2=A0lib/toaster/toastermain/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 -<br>
=C2=A065 files changed, 4272 insertions(+), 8755 deletions(-)<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/api.py<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/static/css/bootstrap.css<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/static/js/bootstrap.js<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/static/js/jquery-2.0.3.js<br=
>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_base.html<b=
r>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_basebuildpa=
ge.html<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_basetable.h=
tml<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_bfile.html<=
br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_bpackage.ht=
ml<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_build.html<=
br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_configurati=
on.html<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_layer.html<=
br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_package.htm=
l<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_recipe.html=
<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templates/simple_task.html<b=
r>
=C2=A0delete mode 100644 lib/toaster/bldviewer/templatetags/__init__.py<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/tests.py<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/urls.py<br>
=C2=A0delete mode 100644 lib/toaster/bldviewer/views.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/README<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/README<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/TODO<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/backlog.txt<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/config.py<br>
=C2=A0create mode 100755 lib/toaster/contrib/tts/launcher.py<br>
=C2=A0rename lib/toaster/{bldviewer/__init__.py =3D&gt; contrib/tts/log/.cr=
eate} (100%)<br>
=C2=A0rename lib/toaster/{bldviewer/templatetags/simple_projecttags.py =3D&=
gt; contrib/tts/recv.py} (41%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0create mode 100755 lib/toaster/contrib/tts/runner.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/scratchpad.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/settings.json<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/shellutils.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/tests.py<br>
=C2=A0create mode 100755 lib/toaster/contrib/tts/toasteruitest/run_toastert=
ests.py<br>
=C2=A0create mode 100755 lib/toaster/contrib/tts/toasteruitest/toaster_auto=
mation_test.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test=
.cfg<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/urlcheck.py<br>
=C2=A0create mode 100644 lib/toaster/contrib/tts/urllist.py<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/table.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/tables.py<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/generic-toasterta=
ble-page.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/layer_btn.html<br=
>
=C2=A0delete mode 100644 lib/toaster/toastergui/templates/layers.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/machine_btn.html<=
br>
=C2=A0delete mode 100644 lib/toaster/toastergui/templates/machines.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/recipe_btn.html<b=
r>
=C2=A0delete mode 100644 lib/toaster/toastergui/templates/targets.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/toastertable.html=
<br>
=C2=A0create mode 100644 lib/toaster/toastergui/widgets.py<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Pro=
ject<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--90e6ba6148d21eeb1b051608f8c2--
