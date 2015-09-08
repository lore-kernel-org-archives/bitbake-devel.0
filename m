Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id EFD187422C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 09:42:02 +0000 (UTC)
Received: by iofh134 with SMTP id h134so111474341iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Sep 2015 02:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:content-type;
	bh=k/KCPSAQRF1ib7M/T3WmbTdP/urzDiMY+ZBYxpoECRE=;
	b=fmfH7Bfc4NAI/QXrL+Anq5mtEePN96lroQE/ik6rfSYhxoGKR95lG0172i9b7S0/dI
	VN3+RMvAyfVtxRBqHBZsbQVSKriv77r8rJCumV3V2c1aQ0HdRTqVdyu1foNKL6P81UNh
	maYDT2aNt6+ANWgnQ9wueGfg3sGMzBvuZKAzAJIl8qNC5conlS6MkUcODrr0CMVZqrok
	jjaQHsw49PVqzBStnqgonH7RU9HWa1tCPj6y3B/BC7+Qs3OPL+2+Ekl+mbMdo3UVrzOJ
	Vn/FP56kLqcIvOGK7xB6oyrENd4Qi4PRk0FHf9JMi+nR5ppnM/MLoI9tK9Zx8weaBfX7
	Nsmw==
X-Gm-Message-State: ALoCoQlwb4N57RSjfwpm/lbbVpUw96RfKWMd+2sBZEbIX5GDURfuTnO0hWYc2cFAl/P0cebwOA0Q
MIME-Version: 1.0
X-Received: by 10.107.157.1 with SMTP id g1mr35983450ioe.38.1441705322008;
	Tue, 08 Sep 2015 02:42:02 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Tue, 8 Sep 2015 02:42:01 -0700 (PDT)
In-Reply-To: <cover.1441705002.git.elliot.smith@intel.com>
References: <cover.1441705002.git.elliot.smith@intel.com>
Date: Tue, 8 Sep 2015 10:42:01 +0100
Message-ID: <CA+1hgUg0zKSFX=ej7gGK88ek-PqPE74xoqLUkHEJmOKQOZYAwA@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Fix presentation issues on "all builds" page
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
X-List-Received-Date: Tue, 08 Sep 2015 09:42:04 -0000
Content-Type: multipart/alternative; boundary=001a1141bb4896e298051f392d79

--001a1141bb4896e298051f392d79
Content-Type: text/plain; charset=UTF-8

Apologies, I neglected the signed-off-by lines in this patches series (they
are in the branch now). I will resubmit them.

Elliot

On 8 September 2015 at 10:40, Elliot Smith <elliot.smith@intel.com> wrote:

> Fixes for some small presentation issues in the all builds page.
>
> The following changes since commit
> c1df471feacaf2590216aa476ce242908dac38cf:
>
>   pseudo_1.7.3.bb: New version of pseudo (2015-09-06 15:26:27 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib
> elliot/submit/bbarrosp/all-builds
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/all-builds
>
> Belen Barros Pena (3):
>   toaster: remove unnecessary white space
>   toaster: fix project names in latest builds
>   toaster: replace ETA with % of tasks done
>
>  lib/toaster/toastergui/templates/mrb_section.html | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a1141bb4896e298051f392d79
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies, I neglected the signed-off-by lines in this pat=
ches series (they are in the branch now). I will resubmit them.<div><br></d=
iv><div>Elliot</div></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On 8 September 2015 at 10:40, Elliot Smith <span dir=3D"ltr">&lt;<=
a href=3D"mailto:elliot.smith@intel.com" target=3D"_blank">elliot.smith@int=
el.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Fixes for so=
me small presentation issues in the all builds page.<br>
<br>
The following changes since commit c1df471feacaf2590216aa476ce242908dac38cf=
:<br>
<br>
=C2=A0 <a href=3D"http://pseudo_1.7.3.bb" rel=3D"noreferrer" target=3D"_bla=
nk">pseudo_1.7.3.bb</a>: New version of pseudo (2015-09-06 15:26:27 +0100)<=
br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" rel=3D"no=
referrer" target=3D"_blank">git.yoctoproject.org/poky-contrib</a> elliot/su=
bmit/bbarrosp/all-builds<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Delliot/submit/bbarrosp/all-builds" rel=3D"noreferrer" target=3D"_blank">=
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Delliot/submit/bb=
arrosp/all-builds</a><br>
<br>
Belen Barros Pena (3):<br>
=C2=A0 toaster: remove unnecessary white space<br>
=C2=A0 toaster: fix project names in latest builds<br>
=C2=A0 toaster: replace ETA with % of tasks done<br>
<br>
=C2=A0lib/toaster/toastergui/templates/mrb_section.html | 10 +++++++---<br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
<br>
--<br>
1.9.3<br>
<br>
---------------------------------------------------------------------<br>
Intel Corporation (UK) Limited<br>
Registered No. 1134945 (England)<br>
Registered Office: Pipers Way, Swindon SN3 1RJ<br>
VAT No: 860 2173 47<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Soft=
ware Engineer<br>Intel Open Source Technology Centre</div></div></div>
</div>

--001a1141bb4896e298051f392d79--
