Return-Path: <alexandru.damian@intel.com>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
	[209.85.218.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3110273A99
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Mar 2015 19:03:35 +0000 (UTC)
Received: by oier21 with SMTP id r21so2195942oie.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Mar 2015 12:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-type;
	bh=WMZLhkbsSenKxXnqV3XLuPTRFTm8n1i0XeOP7FEISEo=;
	b=i7gPgUN3UyH2W0Tt+PnEYQcC7fs5PhYVwogjbc/u11B79iG4NkbdOIB9kNQv2h6wuZ
	VHTQcg7Qj46G7zM87WLx0OLeUDlTNpi5E4oUIniRQjryT0fGbJyVkWsdBjnSi6nvtbb/
	v5X/QxZHRvcICcD8EQrZSBKf8kZRiFz441yKHhiHe324gJZ4XFV7zVdU/R6F27+Dg9Kv
	Aj74khV/uSWSeikgnmGEQNOp0lY4PSiIU9gnloZw91AWWTX15kPWISqRiLQOy057iYxQ
	yByu77s/0g1hm5mAD58Vi5fohW8jjdX6Eq/cuVU+yxQAWhSzWfoV3WihwUi4xXpCZmbD
	6OaA==
X-Gm-Message-State: ALoCoQmWvD77oxWocs6Wexw3pbi0bbLjtda6JdF4NoXdWpLZUOtLzf6bb2dHRLqb+f9/RTd/b6Jf
X-Received: by 10.202.231.85 with SMTP id e82mr4227672oih.104.1427223816690;
	Tue, 24 Mar 2015 12:03:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Tue, 24 Mar 2015 12:03:16 -0700 (PDT)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Tue, 24 Mar 2015 19:03:16 +0000
Message-ID: <CAJ2CSBtRVbj6n2vu5PfCir0eWEBsRAfQPhNhTQHFeOK1rSMjmw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 00/18] Toaster bugfixing patchset
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
X-List-Received-Date: Tue, 24 Mar 2015 19:03:36 -0000
Content-Type: multipart/alternative; boundary=001a11417b209bf41d05120d701a

--001a11417b209bf41d05120d701a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

This is a toaster bugfixing patchset - the patches have been reviewed and
tested on the mailing list.

The patches contain long-lines and binary files that sendmail refuses to
send,

Can you please pull from

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian/201=
50324-submission-bb


before the 1.8 merge window closes ?

Thank you,
Alex


The following changes since commit fc0cec1f38aa6f2d09434cc008a429d350a5706f=
:

  toaster: insure IMAGE_INSTALL_append values have a space prefix
(2015-03-21 00:00:02 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150324-submission-bb

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150324=
-submission-bb

Alexandru DAMIAN (2):
  uievent: catch and log exceptions in receiving events
  toasterui: enable sanity checker

Belen Barros Pena (8):
  toastergui: give button nice rounded corners
  toastergui: changes to the all projects table
  toastergui: changes to release change notifications
  toasterui: update links to Toaster manual
  toasterui: hide release when only one exists
  toasterui: Improve messaging for empty layer details
  toasterui: hide right column if empty
  toasterui: small changes to empty states

Dave Lerner (3):
  toaster: layer-relative paths for config files
  toaster: alert fixes for project release change
  toaster: most-build-targets bug fixes

David Reyna (4):
  toaster: machine not searchable in all builds/projects
  toaster: build date range selections static sources
  toaster: build date range selections
  toaster: PACKAGE_CLASSES variable does not show current value when
    editing

Michael Wood (1):
  toaster: Project page fix targets url and tooltip placement

 lib/bb/ui/toasterui.py                             |   2 +-
 lib/bb/ui/uievent.py                               |   7 +-
 lib/toaster/bldcontrol/models.py                   |   2 +-
 lib/toaster/toastergui/static/css/default.css      |  12 +-
 .../ui-bg_diagonals-thick_18_b81900_40x40.png      | Bin 0 -> 418 bytes
 .../ui-bg_diagonals-thick_20_666666_40x40.png      | Bin 0 -> 312 bytes
 .../css/images/ui-bg_flat_10_000000_40x100.png     | Bin 0 -> 205 bytes
 .../css/images/ui-bg_glass_100_f6f6f6_1x400.png    | Bin 0 -> 262 bytes
 .../css/images/ui-bg_glass_100_fdf5ce_1x400.png    | Bin 0 -> 348 bytes
 .../css/images/ui-bg_glass_65_ffffff_1x400.png     | Bin 0 -> 207 bytes
 .../images/ui-bg_gloss-wave_35_f6a828_500x100.png  | Bin 0 -> 5815 bytes
 .../ui-bg_highlight-soft_100_eeeeee_1x100.png      | Bin 0 -> 278 bytes
 .../ui-bg_highlight-soft_75_ffe45c_1x100.png       | Bin 0 -> 328 bytes
 .../static/css/images/ui-icons_222222_256x240.png  | Bin 0 -> 6922 bytes
 .../static/css/images/ui-icons_228ef1_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ef8c08_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ffd27a_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ffffff_256x240.png  | Bin 0 -> 6299 bytes
 .../toastergui/static/css/jquery-ui.min.css        |   7 +
 .../static/css/jquery-ui.structure.min.css         |   5 +
 .../toastergui/static/css/jquery-ui.theme.min.css  |   5 +
 lib/toaster/toastergui/static/js/filtersnippet.js  |  95 ++++++++++++
 lib/toaster/toastergui/static/js/jquery-ui.min.js  |   7 +
 lib/toaster/toastergui/static/js/layerdetails.js   |   5 +
 lib/toaster/toastergui/static/js/projectapp.js     |  38 ++++-
 lib/toaster/toastergui/templates/base.html         |   2 +-
 lib/toaster/toastergui/templates/build.html        |  17 +++
 lib/toaster/toastergui/templates/configvars.html   |   4 +-
 .../toastergui/templates/filtersnippet.html        |  34 +++--
 lib/toaster/toastergui/templates/landing.html      | 100 ++++++-------
 .../toastergui/templates/landing_not_managed.html  |  12 +-
 lib/toaster/toastergui/templates/layerdetails.html |   6 +-
 lib/toaster/toastergui/templates/layers.html       |  16 +-
 lib/toaster/toastergui/templates/machines.html     |   6 +-
 .../toastergui/templates/managed_builds.html       |  19 ++-
 lib/toaster/toastergui/templates/project.html      |  44 +++---
 lib/toaster/toastergui/templates/projectconf.html  |  42 ++++--
 lib/toaster/toastergui/templates/projects.html     |   3 +-
 lib/toaster/toastergui/templates/targets.html      |  14 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  19 +++
 lib/toaster/toastergui/views.py                    | 166
+++++++++++++++++----
 41 files changed, 521 insertions(+), 168 deletions(-)
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_18_b81900_40=
x40.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_20_666666_40=
x40.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_flat_10_000000_40x100.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_glass_100_f6f6f6_1x400.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_glass_100_fdf5ce_1x400.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_glass_65_ffffff_1x400.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-bg_gloss-wave_35_f6a828_500x100=
.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_100_eeeeee_1x=
100.png
 create mode 100755
lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_75_ffe45c_1x1=
00.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-icons_222222_256x240.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-icons_228ef1_256x240.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-icons_ef8c08_256x240.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-icons_ffd27a_256x240.png
 create mode 100644
lib/toaster/toastergui/static/css/images/ui-icons_ffffff_256x240.png
 create mode 100755 lib/toaster/toastergui/static/css/jquery-ui.min.css
 create mode 100755
lib/toaster/toastergui/static/css/jquery-ui.structure.min.css
 create mode 100755
lib/toaster/toastergui/static/css/jquery-ui.theme.min.css
 create mode 100755 lib/toaster/toastergui/static/js/filtersnippet.js
 create mode 100755 lib/toaster/toastergui/static/js/jquery-ui.min.js

--=20
1.9.1
=E2=80=8B

--=20
Alex Damian
Yocto Project
SSG / OTC

--001a11417b209bf41d05120d701a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif"><br clear=3D"all"></div><div class=3D"gmail_default" style=3D"fo=
nt-family:tahoma,sans-serif">Hello,<br><br>This is a toaster bugfixing patc=
hset - the patches have been reviewed and tested on the mailing list. <br><=
br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-seri=
f">The patches contain long-lines and binary files that sendmail refuses to=
 send,<br><br></div><div class=3D"gmail_default" style=3D"font-family:tahom=
a,sans-serif">Can you please pull from <br><br><a href=3D"http://git.yoctop=
roject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150324-submission-=
bb">http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian=
/20150324-submission-bb</a><br></div><div class=3D"gmail_default" style=3D"=
font-family:tahoma,sans-serif"><br><br>before the 1.8 merge window closes ?=
<br><br>Thank you,<br>Alex<br><br><br>The following changes since commit fc=
0cec1f38aa6f2d09434cc008a429d350a5706f:<br><br>=C2=A0 toaster: insure IMAGE=
_INSTALL_append values have a space prefix (2015-03-21 00:00:02 +0000)<br><=
br>are available in the git repository at:<br><br>=C2=A0 git://<a href=3D"h=
ttp://git.yoctoproject.org/poky-contrib">git.yoctoproject.org/poky-contrib<=
/a> adamian/20150324-submission-bb<br>=C2=A0 <a href=3D"http://git.yoctopro=
ject.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150324-submission-bb">htt=
p://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150324-su=
bmission-bb</a><br><br>Alexandru DAMIAN (2):<br>=C2=A0 uievent: catch and l=
og exceptions in receiving events<br>=C2=A0 toasterui: enable sanity checke=
r<br><br>Belen Barros Pena (8):<br>=C2=A0 toastergui: give button nice roun=
ded corners<br>=C2=A0 toastergui: changes to the all projects table<br>=C2=
=A0 toastergui: changes to release change notifications<br>=C2=A0 toasterui=
: update links to Toaster manual<br>=C2=A0 toasterui: hide release when onl=
y one exists<br>=C2=A0 toasterui: Improve messaging for empty layer details=
<br>=C2=A0 toasterui: hide right column if empty<br>=C2=A0 toasterui: small=
 changes to empty states<br><br>Dave Lerner (3):<br>=C2=A0 toaster: layer-r=
elative paths for config files<br>=C2=A0 toaster: alert fixes for project r=
elease change<br>=C2=A0 toaster: most-build-targets bug fixes<br><br>David =
Reyna (4):<br>=C2=A0 toaster: machine not searchable in all builds/projects=
<br>=C2=A0 toaster: build date range selections static sources<br>=C2=A0 to=
aster: build date range selections<br>=C2=A0 toaster: PACKAGE_CLASSES varia=
ble does not show current value when<br>=C2=A0=C2=A0=C2=A0 editing<br><br>M=
ichael Wood (1):<br>=C2=A0 toaster: Project page fix targets url and toolti=
p placement<br><br>=C2=A0lib/bb/ui/toasterui.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +-<br>=C2=A0lib/bb/ui/uievent.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 +-<br>=C2=A0lib/toaster/bldcontrol/models.py=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-<br>=C2=A0lib/toaster/toastergui/stati=
c/css/default.css=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-<br>=C2=A0.../=
ui-bg_diagonals-thick_18_b81900_40x40.png=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | B=
in 0 -&gt; 418 bytes<br>=C2=A0.../ui-bg_diagonals-thick_20_666666_40x40.png=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -&gt; 312 bytes<br>=C2=A0.../css/ima=
ges/ui-bg_flat_10_000000_40x100.png=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -&gt; 2=
05 bytes<br>=C2=A0.../css/images/ui-bg_glass_100_f6f6f6_1x400.png=C2=A0=C2=
=A0=C2=A0 | Bin 0 -&gt; 262 bytes<br>=C2=A0.../css/images/ui-bg_glass_100_f=
df5ce_1x400.png=C2=A0=C2=A0=C2=A0 | Bin 0 -&gt; 348 bytes<br>=C2=A0.../css/=
images/ui-bg_glass_65_ffffff_1x400.png=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -&gt=
; 207 bytes<br>=C2=A0.../images/ui-bg_gloss-wave_35_f6a828_500x100.png=C2=
=A0 | Bin 0 -&gt; 5815 bytes<br>=C2=A0.../ui-bg_highlight-soft_100_eeeeee_1=
x100.png=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -&gt; 278 bytes<br>=C2=A0...=
/ui-bg_highlight-soft_75_ffe45c_1x100.png=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | Bin 0 -&gt; 328 bytes<br>=C2=A0.../static/css/images/ui-icons_222222_=
256x240.png=C2=A0 | Bin 0 -&gt; 6922 bytes<br>=C2=A0.../static/css/images/u=
i-icons_228ef1_256x240.png=C2=A0 | Bin 0 -&gt; 4549 bytes<br>=C2=A0.../stat=
ic/css/images/ui-icons_ef8c08_256x240.png=C2=A0 | Bin 0 -&gt; 4549 bytes<br=
>=C2=A0.../static/css/images/ui-icons_ffd27a_256x240.png=C2=A0 | Bin 0 -&gt=
; 4549 bytes<br>=C2=A0.../static/css/images/ui-icons_ffffff_256x240.png=C2=
=A0 | Bin 0 -&gt; 6299 bytes<br>=C2=A0.../toastergui/static/css/jquery-ui.m=
in.css=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +<br>=C2=
=A0.../static/css/jquery-ui.structure.min.css=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +<br>=C2=A0.../toastergui/static/css/jqu=
ery-ui.theme.min.css=C2=A0 |=C2=A0=C2=A0 5 +<br>=C2=A0lib/toaster/toastergu=
i/static/js/filtersnippet.js=C2=A0 |=C2=A0 95 ++++++++++++<br>=C2=A0lib/toa=
ster/toastergui/static/js/jquery-ui.min.js=C2=A0 |=C2=A0=C2=A0 7 +<br>=C2=
=A0lib/toaster/toastergui/static/js/layerdetails.js=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +<br>=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 38 ++++-<br>=C2=A0lib/toaster/toastergui/templates/bas=
e.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-<b=
r>=C2=A0lib/toaster/toastergui/templates/build.html=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +++<br>=C2=A0lib/toaster/toastergui/templates=
/configvars.html=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-<br>=C2=A0.../toastergui/tem=
plates/filtersnippet.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 34 +++--<br>=C2=A0lib/toaster/toastergui/templates/landing.html=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 100 ++++++-------<br>=C2=A0.../toastergui/templates=
/landing_not_managed.html=C2=A0 |=C2=A0 12 +-<br>=C2=A0lib/toaster/toasterg=
ui/templates/layerdetails.html |=C2=A0=C2=A0 6 +-<br>=C2=A0lib/toaster/toas=
tergui/templates/layers.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16=
 +-<br>=C2=A0lib/toaster/toastergui/templates/machines.html=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 +-<br>=C2=A0.../toastergui/templates/managed_buil=
ds.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 ++-<br>=C2=A0lib/toa=
ster/toastergui/templates/project.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 44 +++---<br>=C2=A0lib/toaster/toastergui/templates/projectconf.html=C2=
=A0 |=C2=A0 42 ++++--<br>=C2=A0lib/toaster/toastergui/templates/projects.ht=
ml=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-<br>=C2=A0lib/toaster/toasterg=
ui/templates/targets.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-<br>=
=C2=A0lib/toaster/toastergui/templatetags/projecttags.py |=C2=A0 19 +++<br>=
=C2=A0lib/toaster/toastergui/views.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 166 +++++++++++++++++----<br>=C2=A041 files changed, 521 insertions(+=
), 168 deletions(-)<br>=C2=A0create mode 100755 lib/toaster/toastergui/stat=
ic/css/images/ui-bg_diagonals-thick_18_b81900_40x40.png<br>=C2=A0create mod=
e 100755 lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_20_=
666666_40x40.png<br>=C2=A0create mode 100755 lib/toaster/toastergui/static/=
css/images/ui-bg_flat_10_000000_40x100.png<br>=C2=A0create mode 100755 lib/=
toaster/toastergui/static/css/images/ui-bg_glass_100_f6f6f6_1x400.png<br>=
=C2=A0create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_gla=
ss_100_fdf5ce_1x400.png<br>=C2=A0create mode 100755 lib/toaster/toastergui/=
static/css/images/ui-bg_glass_65_ffffff_1x400.png<br>=C2=A0create mode 1006=
44 lib/toaster/toastergui/static/css/images/ui-bg_gloss-wave_35_f6a828_500x=
100.png<br>=C2=A0create mode 100755 lib/toaster/toastergui/static/css/image=
s/ui-bg_highlight-soft_100_eeeeee_1x100.png<br>=C2=A0create mode 100755 lib=
/toaster/toastergui/static/css/images/ui-bg_highlight-soft_75_ffe45c_1x100.=
png<br>=C2=A0create mode 100644 lib/toaster/toastergui/static/css/images/ui=
-icons_222222_256x240.png<br>=C2=A0create mode 100644 lib/toaster/toastergu=
i/static/css/images/ui-icons_228ef1_256x240.png<br>=C2=A0create mode 100644=
 lib/toaster/toastergui/static/css/images/ui-icons_ef8c08_256x240.png<br>=
=C2=A0create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_=
ffd27a_256x240.png<br>=C2=A0create mode 100644 lib/toaster/toastergui/stati=
c/css/images/ui-icons_ffffff_256x240.png<br>=C2=A0create mode 100755 lib/to=
aster/toastergui/static/css/jquery-ui.min.css<br>=C2=A0create mode 100755 l=
ib/toaster/toastergui/static/css/jquery-ui.structure.min.css<br>=C2=A0creat=
e mode 100755 lib/toaster/toastergui/static/css/jquery-ui.theme.min.css<br>=
=C2=A0create mode 100755 lib/toaster/toastergui/static/js/filtersnippet.js<=
br>=C2=A0create mode 100755 lib/toaster/toastergui/static/js/jquery-ui.min.=
js<br><br>-- <br>1.9.1<br>=E2=80=8B</div><br>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / =
OTC=C2=A0</div></div></div>
</div>

--001a11417b209bf41d05120d701a--
