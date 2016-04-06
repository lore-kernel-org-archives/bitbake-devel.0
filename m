Return-Path: <elliot.smith@intel.com>
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com
	[209.85.161.174])
	by mail.openembedded.org (Postfix) with ESMTP id DA38F77045
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 14:03:44 +0000 (UTC)
Received: by mail-yw0-f174.google.com with SMTP id g3so57333869ywa.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=zQ2d7jjUm6Vt7tX+lk8ood//aQLNHm5lcDChvLNsrFE=;
	b=bvYEWpfHJ/LjgEq7aa3/0UNA5OuHToXcwYsA4HewMBrkzfdEZPcnKT03itA9tNdQuh
	uJiNuFoQeM7P72TK6VoqO4CCybhQBkHhVu1u7BnaBWJeS4df4hqASji/Yxaa/Irf7Kxv
	ozkKhjpIokctD2X/qGrN4ocC+12LkNis9s4DvTcSlpv3QIpnjRVoHdFO43ff/K4CB3ID
	7rEPdK5wzxmRKrXXtszvVEo/NtFu9TihMquSgywbq3zknIpgfoX4vJiPl9lZlzDe2AxN
	3/4iGGHrPcGd6+REaAzfYjXVq7wh0kbcwrsRS5ZcPErsRMZbkmy7VHPfm8PMBrQjw6Kr
	yevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=zQ2d7jjUm6Vt7tX+lk8ood//aQLNHm5lcDChvLNsrFE=;
	b=RIECA+nTAk/J2rRLWfBjQPYev5Zmd9eVEsMseTtigdINyGaaq7fQAyTdUbuh5mPPjh
	nEitVYWmzQ+T3NYXP8ZiGFVFsvopnApk7YvNcw9IC/MhhSw6YDVlfRJWOepfeE/yzEs7
	GYd1+csbvgJx06AfBfGFpOrEeZV0h5hmfbMYhgvTOQBE/jTmTk+CqpwbrhvETzn3T32i
	/oaqMaSeXuz+5rT4M6i2hJ9QKAg7R7x5wi1iOkieikwffWqkh9OvfBqKvfuDajx3upEF
	3UTcsEY/1IuReuQzWqnF5byRSEuUwpfUX1dkumtb2Hx2LHleB2BZZLSML+wNGAoe6l+k
	rmZw==
X-Gm-Message-State: AD7BkJJwFUKAtFAhrlgu8GkG4SL0y7JF3pSNMrxuVy4mTnRDt0CEqxnC4zC9IJ/AAFvWrN5cZho+pdbZ81QactsR
MIME-Version: 1.0
X-Received: by 10.13.208.2 with SMTP id s2mr26968452ywd.86.1459950991300; Wed,
	06 Apr 2016 06:56:31 -0700 (PDT)
Received: by 10.129.53.2 with HTTP; Wed, 6 Apr 2016 06:56:31 -0700 (PDT)
In-Reply-To: <cover.1459950757.git.elliot.smith@intel.com>
References: <cover.1459950757.git.elliot.smith@intel.com>
Date: Wed, 6 Apr 2016 14:56:31 +0100
Message-ID: <CA+1hgUg=LaGFQskem0M-nrw7ab717ZD8iy6Lci4XMZSNAysXRw@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/6] Incorporate QUnit tests
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
X-List-Received-Date: Wed, 06 Apr 2016 14:03:47 -0000
Content-Type: multipart/alternative; boundary=001a114d7c5c3a2e12052fd154f0

--001a114d7c5c3a2e12052fd154f0
Content-Type: text/plain; charset=UTF-8

Note that sending the patches to the mailing list failed, as one contains a
line which is too long for git send-email.

Please treat this as a pull request for the
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/toaster/michaelw/unit_tests
 branch.

Thanks.
Elliot

On 6 April 2016 at 14:54, Elliot Smith <elliot.smith@intel.com> wrote:

> Modify QUnit tests so that they run as part of the Selenium test suite.
>
> The following changes since commit 385df903ddf0c8647667d7025c2bfd6175e98fa5
> (toaster-next):
>
>   toaster: add rev dep column to image detail pages (2016-04-06 14:43:57
> +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib
> elliot/toaster/michaelw/unit_tests
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/toaster/michaelw/unit_tests
>
> Elliot Smith (1):
>   bitbake: update LICENSE file with QUnit details
>
> Michael Wood (5):
>   toaster: Add quint to project so that it can be used offline
>   toaster: tests Set MACHINE for the test projects
>   toaster: views jsunittest Add MACHINE and an extra layer to test
>     project
>   toaster: testsjs Add call back to append elements on completion of
>     tests
>   tests: browser Add test to run the js unit tests
>
>  LICENSE                                            |   2 +
>  lib/toaster/tests/browser/test_js_unit_tests.py    |  57 ++++
>  .../fixtures/toastergui-unittest-data.xml          |   4 +-
>  lib/toaster/toastergui/static/css/qunit-1.18.0.css |   1 +
>  lib/toaster/toastergui/static/js/qunit-1.18.0.js   | 347
> +++++++++++++++++++++
>  lib/toaster/toastergui/static/js/tests/test.js     |   7 +
>  .../toastergui/templates/js-unit-tests.html        |   4 +-
>  lib/toaster/toastergui/views.py                    |  18 +-
>  8 files changed, 432 insertions(+), 8 deletions(-)
>  create mode 100644 bitbake/lib/toaster/tests/browser/test_js_unit_tests.py
>  create mode 100644
> bitbake/lib/toaster/toastergui/static/css/qunit-1.18.0.css
>  create mode 100644
> bitbake/lib/toaster/toastergui/static/js/qunit-1.18.0.js
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
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a114d7c5c3a2e12052fd154f0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Note that sending the patches to the mailing list failed, =
as one contains a line which is too long for git send-email.<div><br></div>=
<div>Please treat this as a pull request for the=C2=A0<span style=3D"font-s=
ize:16px">=C2=A0</span><a href=3D"http://git.yoctoproject.org/cgit.cgi/poky=
-contrib/log/?h=3Delliot/toaster/michaelw/unit_tests" rel=3D"noreferrer" ta=
rget=3D"_blank" style=3D"font-size:16px">http://git.yoctoproject.org/cgit.c=
gi/poky-contrib/log/?h=3Delliot/toaster/michaelw/unit_tests</a>=C2=A0branch=
.</div><div><br></div><div>Thanks.</div><div>Elliot</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On 6 April 2016 at 14:54, E=
lliot Smith <span dir=3D"ltr">&lt;<a href=3D"mailto:elliot.smith@intel.com"=
 target=3D"_blank">elliot.smith@intel.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Modify QUnit tests so that they run as part of the S=
elenium test suite.<br>
<br>
The following changes since commit 385df903ddf0c8647667d7025c2bfd6175e98fa5=
<br>
(toaster-next):<br>
<br>
=C2=A0 toaster: add rev dep column to image detail pages (2016-04-06 14:43:=
57 +0100)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" rel=3D"no=
referrer" target=3D"_blank">git.yoctoproject.org/poky-contrib</a> elliot/to=
aster/michaelw/unit_tests<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Delliot/toaster/michaelw/unit_tests" rel=3D"noreferrer" target=3D"_blank"=
>http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Delliot/toaster/=
michaelw/unit_tests</a><br>
<br>
Elliot Smith (1):<br>
=C2=A0 bitbake: update LICENSE file with QUnit details<br>
<br>
Michael Wood (5):<br>
=C2=A0 toaster: Add quint to project so that it can be used offline<br>
=C2=A0 toaster: tests Set MACHINE for the test projects<br>
=C2=A0 toaster: views jsunittest Add MACHINE and an extra layer to test<br>
=C2=A0 =C2=A0 project<br>
=C2=A0 toaster: testsjs Add call back to append elements on completion of<b=
r>
=C2=A0 =C2=A0 tests<br>
=C2=A0 tests: browser Add test to run the js unit tests<br>
<br>
=C2=A0LICENSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0lib/toaster/tests/browser/test_js_unit_tests.py=C2=A0 =C2=A0 |=C2=A0 =
57 ++++<br>
=C2=A0.../fixtures/toastergui-unittest-data.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0lib/toaster/toastergui/static/css/qunit-1.18.0.css |=C2=A0 =C2=A01 +<=
br>
=C2=A0lib/toaster/toastergui/static/js/qunit-1.18.0.js=C2=A0 =C2=A0| 347 ++=
+++++++++++++++++++<br>
=C2=A0lib/toaster/toastergui/static/js/tests/test.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A07 +<br>
=C2=A0.../toastergui/templates/js-unit-tests.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A08 files changed, 432 insertions(+), 8 deletions(-)<br>
=C2=A0create mode 100644 bitbake/lib/toaster/tests/browser/test_js_unit_tes=
ts.py<br>
=C2=A0create mode 100644 bitbake/lib/toaster/toastergui/static/css/qunit-1.=
18.0.css<br>
=C2=A0create mode 100644 bitbake/lib/toaster/toastergui/static/js/qunit-1.1=
8.0.js<br>
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
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div>

--001a114d7c5c3a2e12052fd154f0--
