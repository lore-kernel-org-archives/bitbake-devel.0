Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id 6ABD6720B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 13:43:01 +0000 (UTC)
Received: by mail-ob0-f179.google.com with SMTP id m8so9001617obr.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 05:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=MPN7mc3KCoEbvQmj7PrIaKEGHJJKUolooNc7vrrpj5c=;
	b=PCkzPg8g6Or6s0K9jZBTlpM6eZFYlsN8pT+iKanFAyfSd6fERfOwyhhN45AEVOGWpz
	p+/OQ7FkcMI53jKSehMxK0wy/exRLBjqSBnnkYSoV5ltBEhrktuqJLurgXRWyG6gFiqH
	fL7IH5Wzs0nc4bjYkDAleoVWujQzsahegv2KOD7B+1rtTQHn32DgoUBzw+FeVvssHDeC
	xsTro2jR9DXwCkVV+t+zRLEE2ET8yzGwFl0PiNBsN32HfO2kkcqDGNn+1kbsG5jT20Y3
	juir+fBjr2QlGMwacLQpBnduW5sM6/e9RLolsU0q8gE4yxBXEWX9SGovpHxe5yGf93xv
	FISw==
X-Gm-Message-State: ALoCoQn5Wi3GntOm68hmB5/KvnLUyIan5kkfE86f6UH4ON/MhljZWqucJbiajCIYJ5x6+Mh1Fg5p
X-Received: by 10.60.177.137 with SMTP id cq9mr2705168oec.45.1415799782342;
	Wed, 12 Nov 2014 05:43:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.134.106 with HTTP; Wed, 12 Nov 2014 05:42:42 -0800 (PST)
In-Reply-To: <cover.1415799384.git.alexandru.damian@intel.com>
References: <cover.1415799384.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 12 Nov 2014 13:42:42 +0000
Message-ID: <CAJ2CSBsJKQOJEyCCyCsksrZx907rSPbQJQxq-hHi26yRT_cGuA@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: Re: [PATCH 00/14] toaster patchset for build functionality
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
X-List-Received-Date: Wed, 12 Nov 2014 13:43:05 -0000
Content-Type: multipart/alternative; boundary=089e01184810199b140507a99324

--089e01184810199b140507a99324
Content-Type: text/plain; charset=UTF-8

Hello,

Certain files in this patchset are breaking the 998 characters line length
limit , and git send-email refuses to deal with them.

Can you please pull from:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141112-submission

Cheers,
Alex

On Wed, Nov 12, 2014 at 1:41 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Hi,
>
> This patchset contains user interface pages for all layers and all targets
> pages;
> fixes for the project page and other pages; and fixes for the backend
> build functionality.
>
> The patches have gone through multiple rounds of review and testing.
>
> Can you please pull at your convenience ?
>
>
> Cheers,
> Alex
>
> The following changes since commit
> 9f171ea755644ecd9d2b3d7ed13bf8ec09ec917a:
>
>   data_smart.py: fix variable splitting at _remove mechanism (2014-11-08
> 11:01:36 +0000)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20141112-submission
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141112-submission
>
> Alexandru DAMIAN (10):
>   toaster script: webport option and other improvements
>   toasterui: performance improvements
>   toaster: SQL query logging
>   toaster: update Release model to pinpoint to specific Branch
>   adding angular-animate plugin
>   toastergui: Various fixes for projects, layers and targets page
>   toaster: separate the load configuration file command
>   toastergui: changes for the Project page, round 3 of reviews
>   toaster: importing angular service
>   toastergui: fix XSS injection points in projects page
>
> Belen Barros (1):
>   toastergui: Silly UI fixes
>
> Michael Wood (3):
>   toaster: Fix the table data so that it matches the column order
>   toaster: Update filter count labels when Add/Remove layers
>   toaster: Replace bootstrap js with the correct version
>
>  bin/toaster                                        |    96 +-
>  lib/bb/ui/buildinfohelper.py                       |   207 +-
>  lib/bb/ui/toasterui.py                             |    10 +-
>  lib/toaster/bldcontrol/bbcontroller.py             |    19 +
>  lib/toaster/bldcontrol/localhostbecontroller.py    |    38 +-
>  .../management/commands/checksettings.py           |   140 +-
>  .../bldcontrol/management/commands/loadconf.py     |   157 +
>  lib/toaster/bldcontrol/models.py                   |    35 +-
>  lib/toaster/bldcontrol/sshbecontroller.py          |    46 +-
>  lib/toaster/bldcontrol/tests.py                    |     2 +-
>  ...lptext__chg_field_release_branch__add_index_.py |   359 +
>  lib/toaster/orm/models.py                          |    65 +-
>  lib/toaster/toastergui/static/css/default.css      |    33 +-
>  .../toastergui/static/js/angular-animate.min.js    |    28 +
>  .../toastergui/static/js/angular-route.min.js      |    14 +
>  .../toastergui/static/js/angular-sanitize.min.js   |    15 +
>  lib/toaster/toastergui/static/js/bootstrap.min.js  |    11 +-
>  lib/toaster/toastergui/static/js/jquery-ui.js      | 15003
> -------------------
>  lib/toaster/toastergui/static/js/projectapp.js     |   207 +-
>  lib/toaster/toastergui/templates/base.html         |     3 +-
>  .../toastergui/templates/basetable_bottom.html     |    13 +-
>  .../toastergui/templates/filtersnippet.html        |     4 +-
>  lib/toaster/toastergui/templates/layers.html       |   137 +-
>  lib/toaster/toastergui/templates/mrb_section.html  |    11 +-
>  lib/toaster/toastergui/templates/project.html      |   135 +-
>  lib/toaster/toastergui/templates/target.html       |    10 +-
>  lib/toaster/toastergui/templates/targets.html      |   350 +-
>  lib/toaster/toastergui/templatetags/projecttags.py |     6 +-
>  lib/toaster/toastergui/views.py                    |   228 +-
>  lib/toaster/toastermain/settings.py                |    21 +
>  30 files changed, 1696 insertions(+), 15707 deletions(-)
>  create mode 100644 lib/toaster/bldcontrol/management/commands/loadconf.py
>  create mode 100644
> lib/toaster/orm/migrations/0016_auto__add_field_release_helptext__chg_field_release_branch__add_index_.py
>  create mode 100644 lib/toaster/toastergui/static/js/angular-animate.min.js
>  create mode 100644 lib/toaster/toastergui/static/js/angular-route.min.js
>  create mode 100644
> lib/toaster/toastergui/static/js/angular-sanitize.min.js
>  delete mode 100644 lib/toaster/toastergui/static/js/jquery-ui.js
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--089e01184810199b140507a99324
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,<br><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif">Certain files in this patchset are breaking the 99=
8 characters line length limit , and git send-email refuses to deal with th=
em.<br><br>Can you please pull from:<br><br><a href=3D"http://git.yoctoproj=
ect.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20141112-submission">http://=
git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20141112-submis=
sion</a><br><br></div><div class=3D"gmail_default" style=3D"font-family:tah=
oma,sans-serif">Cheers,<br>Alex<br></div></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Wed, Nov 12, 2014 at 1:41 PM, Alex DAMIAN =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alexandru.damian@intel.com" target=
=3D"_blank">alexandru.damian@intel.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.=
damian@intel.com">alexandru.damian@intel.com</a>&gt;<br>
<br>
Hi,<br>
<br>
This patchset contains user interface pages for all layers and all targets =
pages;<br>
fixes for the project page and other pages; and fixes for the backend build=
 functionality.<br>
<br>
The patches have gone through multiple rounds of review and testing.<br>
<br>
Can you please pull at your convenience ?<br>
<br>
<br>
Cheers,<br>
Alex<br>
<br>
The following changes since commit 9f171ea755644ecd9d2b3d7ed13bf8ec09ec917a=
:<br>
<br>
=C2=A0 data_smart.py: fix variable splitting at _remove mechanism (2014-11-=
08 11:01:36 +0000)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20141112-submission<=
br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20141112-submission" target=3D"_blank">http://git.yoctoproject.o=
rg/cgit.cgi/poky-contrib/log/?h=3Dadamian/20141112-submission</a><br>
<br>
Alexandru DAMIAN (10):<br>
=C2=A0 toaster script: webport option and other improvements<br>
=C2=A0 toasterui: performance improvements<br>
=C2=A0 toaster: SQL query logging<br>
=C2=A0 toaster: update Release model to pinpoint to specific Branch<br>
=C2=A0 adding angular-animate plugin<br>
=C2=A0 toastergui: Various fixes for projects, layers and targets page<br>
=C2=A0 toaster: separate the load configuration file command<br>
=C2=A0 toastergui: changes for the Project page, round 3 of reviews<br>
=C2=A0 toaster: importing angular service<br>
=C2=A0 toastergui: fix XSS injection points in projects page<br>
<br>
Belen Barros (1):<br>
=C2=A0 toastergui: Silly UI fixes<br>
<br>
Michael Wood (3):<br>
=C2=A0 toaster: Fix the table data so that it matches the column order<br>
=C2=A0 toaster: Update filter count labels when Add/Remove layers<br>
=C2=A0 toaster: Replace bootstrap js with the correct version<br>
<br>
=C2=A0bin/toaster=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 96 +-<br>
=C2=A0lib/bb/ui/buildinfohelper.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0207 +-<br>
=C2=A0lib/bb/ui/toasterui.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1=
0 +-<br>
=C2=A0lib/toaster/bldcontrol/bbcontroller.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 19 +<br>
=C2=A0lib/toaster/bldcontrol/localhostbecontroller.py=C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 38 +-<br>
=C2=A0.../management/commands/checksettings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0140 +-<br>
=C2=A0.../bldcontrol/management/commands/loadconf.py=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0157 +<br>
=C2=A0lib/toaster/bldcontrol/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 35 +-<br>
=C2=A0lib/toaster/bldcontrol/sshbecontroller.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 46 +-<br>
=C2=A0lib/toaster/bldcontrol/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0...lptext__chg_field_release_branch__add_index_.py |=C2=A0 =C2=A0359 =
+<br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 65 +-<br>
=C2=A0lib/toaster/toastergui/static/css/default.css=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 33 +-<br>
=C2=A0.../toastergui/static/js/angular-animate.min.js=C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 28 +<br>
=C2=A0.../toastergui/static/js/angular-route.min.js=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 14 +<br>
=C2=A0.../toastergui/static/js/angular-sanitize.min.js=C2=A0 =C2=A0|=C2=A0 =
=C2=A0 15 +<br>
=C2=A0lib/toaster/toastergui/static/js/bootstrap.min.js=C2=A0 |=C2=A0 =C2=
=A0 11 +-<br>
=C2=A0lib/toaster/toastergui/static/js/jquery-ui.js=C2=A0 =C2=A0 =C2=A0 | 1=
5003 -------------------<br>
=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0207 +-<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A03 +-<br>
=C2=A0.../toastergui/templates/basetable_bottom.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 13 +-<br>
=C2=A0.../toastergui/templates/filtersnippet.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A04 +-<br>
=C2=A0lib/toaster/toastergui/templates/layers.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0137 +-<br>
=C2=A0lib/toaster/toastergui/templates/mrb_section.html=C2=A0 |=C2=A0 =C2=
=A0 11 +-<br>
=C2=A0lib/toaster/toastergui/templates/project.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0135 +-<br>
=C2=A0lib/toaster/toastergui/templates/target.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 10 +-<br>
=C2=A0lib/toaster/toastergui/templates/targets.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0350 +-<br>
=C2=A0lib/toaster/toastergui/templatetags/projecttags.py |=C2=A0 =C2=A0 =C2=
=A06 +-<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0228 +-<br>
=C2=A0lib/toaster/toastermain/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 21 +<br>
=C2=A030 files changed, 1696 insertions(+), 15707 deletions(-)<br>
=C2=A0create mode 100644 lib/toaster/bldcontrol/management/commands/loadcon=
f.py<br>
=C2=A0create mode 100644 lib/toaster/orm/migrations/0016_auto__add_field_re=
lease_helptext__chg_field_release_branch__add_index_.py<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular-animate.m=
in.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular-route.min=
.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/angular-sanitize.=
min.js<br>
=C2=A0delete mode 100644 lib/toaster/toastergui/static/js/jquery-ui.js<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></d=
iv><div>SSG / OTC=C2=A0</div></div></div>
</div>

--089e01184810199b140507a99324--
