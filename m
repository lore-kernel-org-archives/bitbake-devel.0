Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
	[209.85.213.179])
	by mail.openembedded.org (Postfix) with ESMTP id 9C67D765EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 19:18:09 +0000 (UTC)
Received: by igr7 with SMTP id 7so22551329igr.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=FbeQMCTvvPmOHVxXkO3gpoVglSQC+nfIuuWE7pL674Q=;
	b=mUcegza/FuGJdGh/0LdzOMjFQ1+5coGnZtRP75yQ7S5RnLg5RLaOsx+00KwZd1My++
	8F1VJ8pp7w+TgBRy8vFGOMsyeGQBWJ5C6gjDswyBP+DhOiDFjlZr3uiPuFD9tekicZZZ
	M5vor4+COnp0v81Urnm1j6+rtf0MbPNKopkBH1dmE5VXpUTMHazxLI3kmQhVzArWvwOf
	XkfVX2hB4ImKwTkQqMQIXe7sheOEvA/X3fMXChK1NsTSzwuOl3WpGk4+cdRw4ilgIf5n
	m/PGm4nNT1kYykLbBOqdMB6ZWDL9h2Rajfn0KdDGbOqXSe0C4B4ys8poGe0Hbi3DJelc
	UzJg==
X-Received: by 10.50.134.42 with SMTP id ph10mr8355816igb.79.1438370289328;
	Fri, 31 Jul 2015 12:18:09 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Fri, 31 Jul 2015 12:17:49 -0700 (PDT)
In-Reply-To: <CABcZANkVY3Xf8kS7SktwRjCzDxY=YfHJPWXdp+2b9X8mJccYGA@mail.gmail.com>
References: <1438363893-11812-1-git-send-email-kergoth@gmail.com>
	<CABcZANkVY3Xf8kS7SktwRjCzDxY=YfHJPWXdp+2b9X8mJccYGA@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 31 Jul 2015 12:17:49 -0700
X-Google-Sender-Auth: 6uE49bMDfCxqzscJmqHfgN0gM6w
Message-ID: <CABcZANmK7Xu9aM1J6JV1Pk5GySJvcq9WRiX6G=uFj7TfCQ5dow@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: let addtask undo a deltask
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
X-List-Received-Date: Fri, 31 Jul 2015 19:18:11 -0000
Content-Type: multipart/alternative; boundary=047d7b41471a26a95f051c30ae65

--047d7b41471a26a95f051c30ae65
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 11:41 AM, Christopher Larson <
chris_larson@mentor.com> wrote:

>
> On Fri, Jul 31, 2015 at 10:31 AM, Christopher Larson <kergoth@gmail.com>
> wrote:
>
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> While we're in that part of the code, also fix 'not foo in bar' to 'foo
>> not in
>> bar', as is preferred in python.
>>
>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>>
>
> Hold off on applying this. While it=E2=80=99s a start, it=E2=80=99s not n=
ecessarily ideal
> either, since it doesn=E2=80=99t reset the intra-recipe inter-task depend=
encies.
> Re-adding a deleted task will resurrect it exactly as it was, rather than
> with new specified dependencies. I=E2=80=99m looking into a more thorough=
 deletion
> now.
>

I=E2=80=99m currently testing a version which has deltask delete the task=
=E2=80=99s deps
flag, and iterates over __BBTASKS to delete the task from other task=E2=80=
=99s deps
flags. My up front parse times aren=E2=80=99t changing, so it doesn=E2=80=
=99t seem to have
a great deal of impact on performance, which was my only concern with that.
The alternative, if the performance is an issue, would likely be to start
maintaining revdep information.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b41471a26a95f051c30ae65
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Jul 31, 2015 at 11:41 AM, Christopher Larson <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:chris_larson@mentor.com" target=3D"_blan=
k">chris_larson@mentor.com</a>&gt;</span> wrote:<br><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_extra"><span class=3D""><br><div class=3D"gmail_quo=
te">On Fri, Jul 31, 2015 at 10:31 AM, Christopher Larson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"ove=
rflow:hidden">From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@m=
entor.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
<br>
While we&#39;re in that part of the code, also fix &#39;not foo in bar&#39;=
 to &#39;foo not in<br>
bar&#39;, as is preferred in python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;</div></blockquote><=
/div><br></span>Hold off on applying this. While it=E2=80=99s a start, it=
=E2=80=99s not necessarily ideal either, since it doesn=E2=80=99t reset the=
 intra-recipe inter-task dependencies. Re-adding a deleted task will resurr=
ect it exactly as it was, rather than with new specified dependencies. I=E2=
=80=99m looking into a more thorough deletion now.</div></div></blockquote>=
<div><br></div><div>I=E2=80=99m currently testing a version which has delta=
sk delete the task=E2=80=99s deps flag, and iterates over __BBTASKS to dele=
te the task from other task=E2=80=99s deps flags. My up front parse times a=
ren=E2=80=99t changing, so it doesn=E2=80=99t seem to have a great deal of =
impact on performance, which was my only concern with that. The alternative=
, if the performance is an issue, would likely be to start maintaining revd=
ep information.</div></div>-- <br><div class=3D"gmail_signature"><div dir=
=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics</div></div>
</div></div>

--047d7b41471a26a95f051c30ae65--
