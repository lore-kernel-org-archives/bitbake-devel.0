Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
	[209.85.214.171])
	by mail.openembedded.org (Postfix) with ESMTP id A8B0360673
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Dec 2014 14:45:01 +0000 (UTC)
Received: by mail-ob0-f171.google.com with SMTP id uz6so3286112obc.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Dec 2014 06:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=gKQTXwZ2kuy2ALTBZC5KLwaVsg+5Qk478rqtnZ3ia7E=;
	b=cz6eDe2ZIfxhiEC15lyxjdKC+HAzbsQddkIeEU4aTeBQ5ECpP2zVPUl7LbaMCIRmZV
	+uRtowZHCNvr/pfj85NgHRvrR4GsDt4EFhEAWWwH4o6nJmnNZsjyWpjwnpihd+jEyQh+
	VKR8HQtymigbPqwc3xC7nUve9DArQ4zNS+NmAB6L73Kbe1kmWuLNDjpwsaEmtRoa68Ii
	HXis2xxFVU2vJg2dJ/J9az2outsf25lTSxtwk5Lk1s9N6uYOm7IuhM+7qrDh6E/NA4CJ
	x9sqwuvEfIH37hKRXLcqtHzYmYo8X8PvoyEIXJ1A+ErK8SV7dhMkqrgT05292OrrlPxo
	UE2A==
X-Gm-Message-State: ALoCoQkK4wR5Zk7GMXb0np85qkDPi1vycJhQlfbvq4IMX8jzPmumQUJn34xdQpXZa/7uR5tdkViA
X-Received: by 10.60.57.10 with SMTP id e10mr6550576oeq.45.1418309102086; Thu,
	11 Dec 2014 06:45:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.134.71 with HTTP; Thu, 11 Dec 2014 06:44:40 -0800 (PST)
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Thu, 11 Dec 2014 14:44:40 +0000
Message-ID: <CAJ2CSBvzewJOmh8gi4C3a30AvoTMrbu-jsCZgE63WdguRtxchg@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: Re: [PATCH 00/11] Toaster patchset with new features and bugfixes
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
X-List-Received-Date: Thu, 11 Dec 2014 14:45:06 -0000
Content-Type: multipart/alternative; boundary=089e0149bb28363eae0509f1d26b

--089e0149bb28363eae0509f1d26b
Content-Type: text/plain; charset=UTF-8

Hello,

Can you please DO NOT MERGE this patchset ?

I have a wrong patch in there - I'll be re-submitting shortly


Cheers,
Alex

On Wed, Dec 10, 2014 at 3:12 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Hello,
>
> This is a patchset with new features and bug fixes. Patches have been
> individually
> reviewed on the toaster mailing list.
>
> Among the features submitted, we have the import layers pages, the
> download artifacts
> patchset, a new command line option for bitbake to write event log files,
> and corresponding
> command to import log files into toaster, as well as new debug options.
>
> We also have fixes around the layout and refactoring to make code cleaner.
>
> Can you please pull at your convenience ?
>
> Thanks,
> Alex
>
> The following changes since commit
> 9e27bb2869e8ec6781d2f68d0585ebbf9ca6f3d8:
>
>   bitbake-user-manual-metadata.xml: Updated do_package_write example
> (2014-12-09 22:25:11 +0000)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20141210-submission
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141210-submission
>
> Alexandru DAMIAN (6):
>   add build artifacts table and other improvements
>   toastergui: implement UI changes to allow file download
>   add option to write offline event log file
>   add POST endpoint for uploading eventlog files
>   toasterui: add extra debug and development infos
>   toasterui: refactor project layer finding logic
>
> Belen Barros Pena (2):
>   toaster: base Only show change project icon when > one project
>   toaster: Initialise the 'change' icon tooltips
>
> Michael Wood (3):
>   toaster: libtoaster Add a error handler to GET in makeTypehead
>   toaster: libtoaster Add editProject and getLayerDepsForProject
>   toaster: Add import layer feature.
>
>  bin/bitbake                                        |   7 +-
>  bin/toaster-eventreplay                            | 179 +++++++++++
>  lib/bb/cooker.py                                   |  75 ++++-
>  lib/bb/cookerdata.py                               |   1 +
>  lib/bb/ui/buildinfohelper.py                       |  83 +++--
>  lib/bb/ui/toasterui.py                             |  25 +-
>  lib/toaster/bldcontrol/localhostbecontroller.py    |  27 +-
>  .../management/commands/checksettings.py           |   2 +-
>  .../bldcontrol/management/commands/runbuilds.py    |  13 +-
>  lib/toaster/bldcontrol/models.py                   |  10 +-
>  .../orm/migrations/0019_auto__add_buildartifact.py | 342
> +++++++++++++++++++++
>  lib/toaster/orm/models.py                          |  50 ++-
>  lib/toaster/orm/urls.py                            |  27 ++
>  lib/toaster/orm/views.py                           |  60 ++++
>  lib/toaster/toastergui/static/js/base.js           |   4 +
>  lib/toaster/toastergui/static/js/importlayer.js    | 190 ++++++++++++
>  lib/toaster/toastergui/static/js/libtoaster.js     |  57 ++++
>  lib/toaster/toastergui/static/js/projectapp.js     |   6 +
>  lib/toaster/toastergui/templates/base.html         |  18 +-
>  lib/toaster/toastergui/templates/build.html        |  29 +-
>  .../toastergui/templates/builddashboard.html       | 131 +++++---
>  .../toastergui/templates/configuration.html        |   6 +-
>  lib/toaster/toastergui/templates/importlayer.html  |  80 +++--
>  .../toastergui/templates/layers_dep_modal.html     |  68 ++++
>  .../toastergui/templates/package_detail_base.html  |   3 +
>  lib/toaster/toastergui/templates/recipe.html       |  11 +-
>  lib/toaster/toastergui/templates/recipes.html      |   7 +-
>  lib/toaster/toastergui/templates/target.html       |   8 +-
>  lib/toaster/toastergui/templates/task.html         |  18 +-
>  lib/toaster/toastergui/templates/tasks.html        |  12 +-
>  lib/toaster/toastergui/urls.py                     |   2 +
>  lib/toaster/toastergui/views.py                    | 293
> ++++++++++++------
>  lib/toaster/toastermain/settings.py                |  27 +-
>  lib/toaster/toastermain/urls.py                    |  10 +-
>  34 files changed, 1630 insertions(+), 251 deletions(-)
>  create mode 100755 bin/toaster-eventreplay
>  create mode 100644
> lib/toaster/orm/migrations/0019_auto__add_buildartifact.py
>  create mode 100644 lib/toaster/orm/urls.py
>  create mode 100644 lib/toaster/orm/views.py
>  create mode 100644 lib/toaster/toastergui/static/js/importlayer.js
>  create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--089e0149bb28363eae0509f1d26b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">Can you please DO NOT MERGE this patchset ?</div><div =
class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><=
div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">I have =
a wrong patch in there - I&#39;ll be re-submitting shortly</div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Cheers,<=
/div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">A=
lex</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Wed, Dec 10, 2014 at 3:12 PM, Alex DAMIAN <span dir=3D"ltr">&lt;<a href=3D=
"mailto:alexandru.damian@intel.com" target=3D"_blank">alexandru.damian@inte=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Alexand=
ru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.com">alexandru.damia=
n@intel.com</a>&gt;<br>
<br>
Hello,<br>
<br>
This is a patchset with new features and bug fixes. Patches have been indiv=
idually<br>
reviewed on the toaster mailing list.<br>
<br>
Among the features submitted, we have the import layers pages, the download=
 artifacts<br>
patchset, a new command line option for bitbake to write event log files, a=
nd corresponding<br>
command to import log files into toaster, as well as new debug options.<br>
<br>
We also have fixes around the layout and refactoring to make code cleaner.<=
br>
<br>
Can you please pull at your convenience ?<br>
<br>
Thanks,<br>
Alex<br>
<br>
The following changes since commit 9e27bb2869e8ec6781d2f68d0585ebbf9ca6f3d8=
:<br>
<br>
=C2=A0 bitbake-user-manual-metadata.xml: Updated do_package_write example (=
2014-12-09 22:25:11 +0000)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20141210-submission<=
br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20141210-submission" target=3D"_blank">http://git.yoctoproject.o=
rg/cgit.cgi/poky-contrib/log/?h=3Dadamian/20141210-submission</a><br>
<br>
Alexandru DAMIAN (6):<br>
=C2=A0 add build artifacts table and other improvements<br>
=C2=A0 toastergui: implement UI changes to allow file download<br>
=C2=A0 add option to write offline event log file<br>
=C2=A0 add POST endpoint for uploading eventlog files<br>
=C2=A0 toasterui: add extra debug and development infos<br>
=C2=A0 toasterui: refactor project layer finding logic<br>
<br>
Belen Barros Pena (2):<br>
=C2=A0 toaster: base Only show change project icon when &gt; one project<br=
>
=C2=A0 toaster: Initialise the &#39;change&#39; icon tooltips<br>
<br>
Michael Wood (3):<br>
=C2=A0 toaster: libtoaster Add a error handler to GET in makeTypehead<br>
=C2=A0 toaster: libtoaster Add editProject and getLayerDepsForProject<br>
=C2=A0 toaster: Add import layer feature.<br>
<br>
=C2=A0bin/bitbake=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0bin/toaster-eventreplay=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 179 +++++++++++<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 75 ++++-<br>
=C2=A0lib/bb/cookerdata.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0lib/bb/ui/buildinfohelper.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 83 +++--<br>
=C2=A0lib/bb/ui/toasterui.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +-<br=
>
=C2=A0lib/toaster/bldcontrol/localhostbecontroller.py=C2=A0 =C2=A0 |=C2=A0 =
27 +-<br>
=C2=A0.../management/commands/checksettings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0.../bldcontrol/management/commands/runbuilds.py=C2=A0 =C2=A0 |=C2=A0 =
13 +-<br>
=C2=A0lib/toaster/bldcontrol/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br>
=C2=A0.../orm/migrations/0019_auto__add_buildartifact.py | 342 ++++++++++++=
+++++++++<br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 50 ++-<br>
=C2=A0lib/toaster/orm/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++<br>
=C2=A0lib/toaster/orm/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 60 ++++<br>
=C2=A0lib/toaster/toastergui/static/js/base.js=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0lib/toaster/toastergui/static/js/importlayer.js=C2=A0 =C2=A0 | 190 ++=
++++++++++<br>
=C2=A0lib/toaster/toastergui/static/js/libtoaster.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 57 ++++<br>
=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A06 +<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 18 +-<br>
=C2=A0lib/toaster/toastergui/templates/build.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 29 +-<br>
=C2=A0.../toastergui/templates/builddashboard.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 131 +++++---<br>
=C2=A0.../toastergui/templates/configuration.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0lib/toaster/toastergui/templates/importlayer.html=C2=A0 |=C2=A0 80 ++=
+--<br>
=C2=A0.../toastergui/templates/layers_dep_modal.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 68 ++++<br>
=C2=A0.../toastergui/templates/package_detail_base.html=C2=A0 |=C2=A0 =C2=
=A03 +<br>
=C2=A0lib/toaster/toastergui/templates/recipe.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 11 +-<br>
=C2=A0lib/toaster/toastergui/templates/recipes.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A07 +-<br>
=C2=A0lib/toaster/toastergui/templates/target.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0lib/toaster/toastergui/templates/task.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 18 +-<br>
=C2=A0lib/toaster/toastergui/templates/tasks.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 12 +-<br>
=C2=A0lib/toaster/toastergui/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 293 ++++++++++++------<br>
=C2=A0lib/toaster/toastermain/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 +-<br>
=C2=A0lib/toaster/toastermain/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A034 files changed, 1630 insertions(+), 251 deletions(-)<br>
=C2=A0create mode 100755 bin/toaster-eventreplay<br>
=C2=A0create mode 100644 lib/toaster/orm/migrations/0019_auto__add_buildart=
ifact.py<br>
=C2=A0create mode 100644 lib/toaster/orm/urls.py<br>
=C2=A0create mode 100644 lib/toaster/orm/views.py<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/importlayer.js<br=
>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.=
html<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Pro=
ject<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--089e0149bb28363eae0509f1d26b--
