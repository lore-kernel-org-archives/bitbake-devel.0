Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51])
	by mail.openembedded.org (Postfix) with ESMTP id B3D7871AC3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 16:54:06 +0000 (UTC)
Received: by mail-vk0-f51.google.com with SMTP id r199so2347526vke.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=zFvgpU714bu7jjpY668uXUWaZxGd9xuvZ17Pin6My5c=;
	b=nl8Yr7ELt9n22OtEhkdp2J/pQYRN0LkhUxADTc6yCpgvzw8TXoBAUGD3aXfIMBzd0m
	tdYzywWbkF4cOgXBAuwt54yslZw/8QmOtYwWMpOdXxlY4K1xejwHRbLoInZYmJ4FjV8r
	do45pr8wmURC5ESvzfbSIo2D7qdVeR4cdz7w5q4Gd0Q0HtpxE2E3j1lRnCRoK4y/oYC/
	bCkpY/csSrkALbco5o38xU3W+mYAcTU4eS+SdctPT9P+TqnaRs1pD6NGbbqLiIGH0euZ
	McziwRqoNM739JHoPesE9v0Y837bmuVZ/65y/NDhBpnJVSR5LnfPyftQ6xfOGCNgk0Kc
	76bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=zFvgpU714bu7jjpY668uXUWaZxGd9xuvZ17Pin6My5c=;
	b=Mogq69LumPaNOpfRxKhv8E/BgDuQ4tSiFIy5K1KJZ/ZMsaQz3Bjnlzz+2XvBKcUgdK
	me/QpzOD4/G010Pbie/ZimfgRRYf/dZCxjMdxbvlfcRM2IjoTjHWg/Qu6XBuSvQ+yu8O
	gcc2Uwoi0T4wGF3j2wqJzGqNzkiH2Iguzf2JaLkwc2jeNJzWYfAyqNh5XPk8txnfcaWF
	A5FDJKm1oVwmEp+XKUMuIldyDESVyY0RpuLvmN+JW300yk61oa6bmKfVzWhcQLXwPDAK
	8goG4n0ypjfL6j7HjI8Iyno15WyCedQnyyrnFexYQbQfpnMwUdTo+XGuQr4A0eTk9TcB
	vlNg==
X-Gm-Message-State: AHYfb5hhaKV/5M+IoS3EcV2jEMNiDyw5oqG40VbTLb+sc9VZn7iPKExa
	YL0LYzqLVtL7ZJFIO8z2DDzVEW29BQ==
X-Received: by 10.31.157.195 with SMTP id g186mr2120950vke.156.1503507247586; 
	Wed, 23 Aug 2017 09:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.12 with HTTP; Wed, 23 Aug 2017 09:53:47 -0700 (PDT)
In-Reply-To: <CABcZANmgdB1sgqceeFSLhjboeu8V+ST91qmE8vqiQsH7BeWy7g@mail.gmail.com>
References: <20170821163741.28301-2-kergoth@gmail.com>
	<20170821165708.13223-1-kergoth@gmail.com>
	<1503483750.32591.142.camel@linuxfoundation.org>
	<CABcZANmgdB1sgqceeFSLhjboeu8V+ST91qmE8vqiQsH7BeWy7g@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 23 Aug 2017 09:53:47 -0700
Message-ID: <CABcZAN=taWEW9bnxftXWM1WbmLuzFuN0DFjezGGt735QMzMhHQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCHv2] fetch2/gitsm: copy submodules from DL_DIR in unpack
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
X-List-Received-Date: Wed, 23 Aug 2017 16:54:06 -0000
Content-Type: multipart/alternative; boundary="001a1142607e68e5e805576e8fb3"

--001a1142607e68e5e805576e8fb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 8:01 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> On Wed, Aug 23, 2017 at 3:22 AM, Richard Purdie <richard.purdie@
> linuxfoundation.org> wrote:
>
>> On Mon, 2017-08-21 at 21:57 +0500, Christopher Larson wrote:
>> > From: Christopher Larson <chris_larson@mentor.com>
>> >
>> > Revert "fetch2/gitsm: Fix when repository change submodules"
>> >
>> > This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.
>>
> [=E2=80=A6]
>
>> 2017-08-23 11:20:14,819 - oe-selftest - INFO - Ran 1 test in 33.385s
>> 2017-08-23 11:20:14,819 - oe-selftest - INFO - FAILED
>> 2017-08-23 11:20:14,819 - oe-selftest - INFO -  (failures=3D1)
>> 2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS:
>> 2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS -
>> devtool.DevtoolTests.test_devtool_add_fetch_git - Testcase 1161: FAILED
>> 2017-08-23 11:20:14,824 - oe-selftest - INFO - SUMMARY:
>> 2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest () - Ran 1
>> test in 33.391s
>> 2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest - FAIL -
>> Required tests failed
>>
>> Could you take a look at that test case and see what the issue is please=
?
>>
>
> Will do, thanks, sorry about that. I ran the bitbake selftests, but didn=
=E2=80=99t
> think to re-run the oe selftests. *eyeroll*
>


This is uglier than I had been thinking. If the upstream url for an
existing module changes between srcrevs or branches, we=E2=80=99re in troub=
le,
since the modules/ dir in clonedir won=E2=80=99t line up with .gitmodules. =
I was
thinking about adding a needs_update() to GitSM to check for the case where
it doesn=E2=80=99t match up, but then if multiple recipes need different se=
ts of
modules for the same clonedir at the same time, they=E2=80=99d both run dow=
nload()
and first one would switch to one configuration, then the other would
switch back..

The perils of using a single directory in a single clone for multiple
possible sets of modules and revs.. I don=E2=80=99t think it=E2=80=99s wort=
h trying to
handle this with a stopgap measure, best to just punt on this for this
release and pursue the rewrite of gitsm after the release. Feel free to
drop these patches. Thanks.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a1142607e68e5e805576e8fb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Aug 23, 2017 at 8:01 AM, Christopher Larson <span dir=3D"ltr">&=
lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><=
span class=3D"">On Wed, Aug 23, 2017 at 3:22 AM, Richard Purdie <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@<wbr>linuxfoundation.org</a>&gt;</span> wrote:<b=
r></span><div class=3D"gmail_extra"><div class=3D"gmail_quote"><span class=
=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div class=3D"m_8893467195293992359HOE=
nZb"><div class=3D"m_8893467195293992359h5">On Mon, 2017-08-21 at 21:57 +05=
00, Christopher Larson wrote:<br>
&gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com=
" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
&gt;<br>
&gt; Revert &quot;fetch2/gitsm: Fix when repository change submodules&quot;=
<br>
&gt;<br>
&gt; This reverts commit 12f6c0651af8bd5d6efb751690571c<wbr>f2fcd3eeb0.</di=
v></div></blockquote></span><div>[=E2=80=A6]=C2=A0</div><span class=3D""><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div class=3D"m_8893467195293992359HOEnZb"><di=
v class=3D"m_8893467195293992359h5"><span style=3D"color:rgb(34,34,34)">201=
7-08-23 11:20:14,819 - oe-selftest - INFO - Ran 1 test in 33.385s</span><br=
></div></div>
2017-08-23 11:20:14,819 - oe-selftest - INFO - FAILED<br>
2017-08-23 11:20:14,819 - oe-selftest - INFO -=C2=A0=C2=A0(failures=3D1)<br=
>
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS:<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - RESULTS - devtool.DevtoolTes=
ts.test_devt<wbr>ool_add_fetch_git - Testcase 1161: FAILED<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - SUMMARY:<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest () - Ran 1 test =
in 33.391s<br>
2017-08-23 11:20:14,824 - oe-selftest - INFO - oe-selftest - FAIL - Require=
d tests failed<br>
<br>
Could you take a look at that test case and see what the issue is please?<b=
r></blockquote><div><br></div></span><div>Will do, thanks, sorry about that=
. I ran the bitbake selftests, but didn=E2=80=99t think to re-run the oe se=
lftests. *eyeroll*=C2=A0</div></div></div></div></blockquote><div><br></div=
><div>=C2=A0</div></div>This is uglier than I had been thinking. If the ups=
tream url for an existing module changes between srcrevs or branches, we=E2=
=80=99re in trouble, since the modules/ dir in clonedir won=E2=80=99t line =
up with .gitmodules. I was thinking about adding a needs_update() to GitSM =
to check for the case where it doesn=E2=80=99t match up, but then if multip=
le recipes need different sets of modules for the same clonedir at the same=
 time, they=E2=80=99d both run download() and first one would switch to one=
 configuration, then the other would switch back..</div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">The perils of using a single d=
irectory in a single clone for multiple possible sets of modules and revs..=
 I don=E2=80=99t think it=E2=80=99s worth trying to handle this with a stop=
gap measure, best to just punt on this for this release and pursue the rewr=
ite of gitsm after the release. Feel free to drop these patches. Thanks.<br=
>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmai=
l dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software=
 Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--001a1142607e68e5e805576e8fb3--
