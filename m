Return-Path: <alexandru.damian@intel.com>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
	[209.85.218.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6717D73929
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2015 13:20:15 +0000 (UTC)
Received: by oifu20 with SMTP id u20so29108551oif.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2015 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=xxVF4dSzT6jrUZjFf5oHtjTjJXeJJOJr/rZhiIzg29Y=;
	b=bS4tS7/ioHkwWY+2dRFOHz+67DtAOgvpaH3Lk1qxEFGjp9207FKtC6nZJIlfSJVjwH
	xO75+SjMOwxfypDBbQtDQyANDHAPwK5mBQL/nQ7l7KgkDGM/V7jNahGlW5jwFivlIhMq
	/rbzKwxuiExzbDV5UZvcDPZiAwLrYGOo/RMOg1TvPZEj4dG6gPBv1DuJNUO4ZqXjdrb7
	Vrrqeoz1UUgUQPDHwvXWz/tY1H1b0ZkYESzdJ8jYhp/CA55a0IYcc0tj6PbEf2KWuTzf
	Ih+HBBufguNqwo2t3KdeMAz8PjhjwGgtpksuNTqfI2UzrCfdr2VMqQLnCdm+Xx74VOMA
	bJPw==
X-Gm-Message-State: ALoCoQlRkh25a1RsRMbfmlIVQwcOkoMQZP8LikGUN0sHabEE+sQBYh9DiUztJL6rcCA5ZmUBtKQ2
X-Received: by 10.202.190.6 with SMTP id o6mr20499666oif.28.1425907216201;
	Mon, 09 Mar 2015 06:20:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Mon, 9 Mar 2015 06:19:56 -0700 (PDT)
In-Reply-To: <cover.1425906999.git.alexandru.damian@intel.com>
References: <cover.1425906999.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 9 Mar 2015 13:19:56 +0000
Message-ID: <CAJ2CSBtHciyNQppqG+7R6Z-GGQCKsWjtextGFjmt3Jo=+rB7Ng@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: Re: [PATCH 00/21] Toaster bug fixing patchset
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
X-List-Received-Date: Mon, 09 Mar 2015 13:20:15 -0000
Content-Type: multipart/alternative; boundary=001a113ddb801ace3f0510dae52a

--001a113ddb801ace3f0510dae52a
Content-Type: text/plain; charset=UTF-8

Hello,

This patchset contains long lines, which the git mail refuses to send.

Can you please pull from

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/20150309-submission-bb
?

Thank you,
Alex

On Mon, Mar 9, 2015 at 1:18 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Hello,
>
> This is a toaster bugfix patchset. It has been reviewed and tested
> on the toaster mailing list.
>
> Can you please pull at your convenience ?
>
> Cheers,
> Alex
>
>
>
> The following changes since commit
> baec2940c2b4ec792cacad5cc8d8056d9162919b:
>
>   toaster: config var layout fixes (2015-02-27 07:35:10 +0000)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20150309-submission-bb
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150309-submission-bb
>
> Alexandru DAMIAN (8):
>   cooker: read file watches on server idle
>   toaster: delete test data
>   xmlrpcserver: do not connect client on error
>   cooker: make sure state is properly used to accept clients
>   xmlrpc server: delete function on errors
>   toaster: models.py do not use transactions
>   toastergui: bring back base URLs for pages that need them
>   toaster: projectapp.js - clear up jslint warnings
>
> Belen Barros Pena (5):
>   toasterui: don't open layer details in a new tab
>   toasterui: fix the h1 in the project builds page
>   toasterui: apply correct class to latest builds targets
>   toasterui: give some space to the download log button
>   toaterui: shorten the unavailable artifact message
>
> Dave Lerner (4):
>   toaster: add sort, search, paging to recipe package page
>   toaster: layer rev tooltip only if necessary
>   toaster: commit id format on layers page
>   toaster: cached outcome download button
>
> David Reyna (2):
>   toaster: hide special code for core vars not present, disable add
>     button
>   toaster: reconcile non-manage-mode landing classes
>
> Michael Wood (2):
>   toaster: Enforce unique layer names
>   toaster: libtoaster Fix a few warnings picked up by jshint
>
>  lib/bb/cooker.py                                   |     36 +-
>  lib/bb/server/xmlrpc.py                            |      6 +
>  lib/toaster/bldviewer/tests.py                     |      5 +-
>  lib/toaster/orm/fixtures/orm_views_testdata.json   | 140835
> ------------------
>  lib/toaster/orm/models.py                          |     34 +-
>  lib/toaster/toastergui/static/css/default.css      |      1 +
>  lib/toaster/toastergui/static/js/.jshintrc         |     11 +
>  lib/toaster/toastergui/static/js/importlayer.js    |     94 +-
>  lib/toaster/toastergui/static/js/libtoaster.js     |     79 +-
>  lib/toaster/toastergui/static/js/projectapp.js     |    181 +-
>  lib/toaster/toastergui/templates/base.html         |      2 +-
>  .../toastergui/templates/builddashboard.html       |      4 +-
>  .../templates/detail_pagination_bottom.html        |     60 +
>  .../toastergui/templates/detail_search_header.html |     68 +
>  .../toastergui/templates/detail_sorted_header.html |     25 +
>  lib/toaster/toastergui/templates/importlayer.html  |     41 +-
>  lib/toaster/toastergui/templates/layerdetails.html |      8 +-
>  lib/toaster/toastergui/templates/layers.html       |     15 +-
>  lib/toaster/toastergui/templates/project.html      |     10 +-
>  .../toastergui/templates/projectbuilds.html        |     26 +-
>  lib/toaster/toastergui/templates/projectconf.html  |     81 +-
>  lib/toaster/toastergui/templates/recipe.html       |     52 +-
>  .../toastergui/templates/recipe_packages.html      |    123 +
>  lib/toaster/toastergui/templates/task.html         |      8 +
>  .../toastergui/templates/unavailable_artifact.html |     10 +-
>  lib/toaster/toastergui/templatetags/projecttags.py |     12 +
>  lib/toaster/toastergui/urls.py                     |      8 +-
>  lib/toaster/toastergui/views.py                    |    110 +-
>  28 files changed, 798 insertions(+), 141147 deletions(-)
>  delete mode 100644 lib/toaster/orm/fixtures/orm_views_testdata.json
>  create mode 100644 lib/toaster/toastergui/static/js/.jshintrc
>  create mode 100644
> lib/toaster/toastergui/templates/detail_pagination_bottom.html
>  create mode 100644
> lib/toaster/toastergui/templates/detail_search_header.html
>  create mode 100644
> lib/toaster/toastergui/templates/detail_sorted_header.html
>  create mode 100644 lib/toaster/toastergui/templates/recipe_packages.html
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--001a113ddb801ace3f0510dae52a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,<br><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif">This patchset contains long lines, which the git m=
ail refuses to send.<br><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:tahoma,sans-serif">Can you please pull from <br><br><a href=3D"htt=
p://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian/201503=
09-submission-bb">http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/lo=
g/?h=3Dadamian/20150309-submission-bb</a> ?<br><br></div><div class=3D"gmai=
l_default" style=3D"font-family:tahoma,sans-serif">Thank you,<br></div><div=
 class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Alex<br></=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon,=
 Mar 9, 2015 at 1:18 PM, Alex DAMIAN <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:alexandru.damian@intel.com" target=3D"_blank">alexandru.damian@intel.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Alexandru DAM=
IAN &lt;<a href=3D"mailto:alexandru.damian@intel.com">alexandru.damian@inte=
l.com</a>&gt;<br>
<br>
Hello,<br>
<br>
This is a toaster bugfix patchset. It has been reviewed and tested<br>
on the toaster mailing list.<br>
<br>
Can you please pull at your convenience ?<br>
<br>
Cheers,<br>
Alex<br>
<br>
<br>
<br>
The following changes since commit baec2940c2b4ec792cacad5cc8d8056d9162919b=
:<br>
<br>
=C2=A0 toaster: config var layout fixes (2015-02-27 07:35:10 +0000)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20150309-submission-=
bb<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20150309-submission-bb" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150309-submission-bb</a><br>
<br>
Alexandru DAMIAN (8):<br>
=C2=A0 cooker: read file watches on server idle<br>
=C2=A0 toaster: delete test data<br>
=C2=A0 xmlrpcserver: do not connect client on error<br>
=C2=A0 cooker: make sure state is properly used to accept clients<br>
=C2=A0 xmlrpc server: delete function on errors<br>
=C2=A0 toaster: models.py do not use transactions<br>
=C2=A0 toastergui: bring back base URLs for pages that need them<br>
=C2=A0 toaster: projectapp.js - clear up jslint warnings<br>
<br>
Belen Barros Pena (5):<br>
=C2=A0 toasterui: don&#39;t open layer details in a new tab<br>
=C2=A0 toasterui: fix the h1 in the project builds page<br>
=C2=A0 toasterui: apply correct class to latest builds targets<br>
=C2=A0 toasterui: give some space to the download log button<br>
=C2=A0 toaterui: shorten the unavailable artifact message<br>
<br>
Dave Lerner (4):<br>
=C2=A0 toaster: add sort, search, paging to recipe package page<br>
=C2=A0 toaster: layer rev tooltip only if necessary<br>
=C2=A0 toaster: commit id format on layers page<br>
=C2=A0 toaster: cached outcome download button<br>
<br>
David Reyna (2):<br>
=C2=A0 toaster: hide special code for core vars not present, disable add<br=
>
=C2=A0 =C2=A0 button<br>
=C2=A0 toaster: reconcile non-manage-mode landing classes<br>
<br>
Michael Wood (2):<br>
=C2=A0 toaster: Enforce unique layer names<br>
=C2=A0 toaster: libtoaster Fix a few warnings picked up by jshint<br>
<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A036 +-<br>
=C2=A0lib/bb/server/xmlrpc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =
6 +<br>
=C2=A0lib/toaster/bldviewer/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 5 +-<br>
=C2=A0lib/toaster/orm/fixtures/orm_views_testdata.json=C2=A0 =C2=A0| 140835=
 ------------------<br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A034 +-=
<br>
=C2=A0lib/toaster/toastergui/static/css/default.css=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A0 1 +<br>
=C2=A0lib/toaster/toastergui/static/js/.jshintrc=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A011 +<br>
=C2=A0lib/toaster/toastergui/static/js/importlayer.js=C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 =C2=A094 +-<br>
=C2=A0lib/toaster/toastergui/static/js/libtoaster.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A079 +-<br>
=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 181 +-<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A0 2 +-<br>
=C2=A0.../toastergui/templates/builddashboard.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A0 4 +-<br>
=C2=A0.../templates/detail_pagination_bottom.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A060 +<br>
=C2=A0.../toastergui/templates/detail_search_header.html |=C2=A0 =C2=A0 =C2=
=A068 +<br>
=C2=A0.../toastergui/templates/detail_sorted_header.html |=C2=A0 =C2=A0 =C2=
=A025 +<br>
=C2=A0lib/toaster/toastergui/templates/importlayer.html=C2=A0 |=C2=A0 =C2=
=A0 =C2=A041 +-<br>
=C2=A0lib/toaster/toastergui/templates/layerdetails.html |=C2=A0 =C2=A0 =C2=
=A0 8 +-<br>
=C2=A0lib/toaster/toastergui/templates/layers.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A015 +-<br>
=C2=A0lib/toaster/toastergui/templates/project.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A010 +-<br>
=C2=A0.../toastergui/templates/projectbuilds.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A026 +-<br>
=C2=A0lib/toaster/toastergui/templates/projectconf.html=C2=A0 |=C2=A0 =C2=
=A0 =C2=A081 +-<br>
=C2=A0lib/toaster/toastergui/templates/recipe.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A052 +-<br>
=C2=A0.../toastergui/templates/recipe_packages.html=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 123 +<br>
=C2=A0lib/toaster/toastergui/templates/task.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A0 8 +<br>
=C2=A0.../toastergui/templates/unavailable_artifact.html |=C2=A0 =C2=A0 =C2=
=A010 +-<br>
=C2=A0lib/toaster/toastergui/templatetags/projecttags.py |=C2=A0 =C2=A0 =C2=
=A012 +<br>
=C2=A0lib/toaster/toastergui/urls.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 8 +-<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 110 +-<br>
=C2=A028 files changed, 798 insertions(+), 141147 deletions(-)<br>
=C2=A0delete mode 100644 lib/toaster/orm/fixtures/orm_views_testdata.json<b=
r>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/.jshintrc<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/detail_pagination=
_bottom.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/detail_search_hea=
der.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/detail_sorted_hea=
der.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/templates/recipe_packages.h=
tml<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></d=
iv><div>SSG / OTC=C2=A0</div></div></div>
</div>

--001a113ddb801ace3f0510dae52a--
