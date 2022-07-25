Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D7C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 09:42:46 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.26115.1658742165548534534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 02:42:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ETjzOyo/;
 spf=pass (domain: gmail.com, ip: 209.85.221.49,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id u5so15148537wrm.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P2PbgzgkYgGIMjzZRTYun1mUS+li2DmpXNR0m7zFio=;
        b=ETjzOyo/6nDX5FwnwRQEPcb0XjR9r2VpF4UD1B12Ulv4uif+jMDx63yxE5Z3R/xk1G
         7intQqIEaSphuNkptMyqxkWhgsqab5fpT0tsnSbvgtMyw0jZQ8O2qyUN9NB32TCYPb9I
         bfvzw6t4IYSm1XNUWrsTXxOpFMHkYpT4FgrymHPps9PSQ6PIgx6aRzgRiIHlyI+fhZHp
         Jx9DEx2axh6F0XcghnOe2+d7bPcPF8lVVFG1xS0xpCbkNp6a8iMzWMG7my7tfxHj2OuJ
         7mH+LTE14TMQMe+2ek2LfIeKq7lRJzLkmJLUMVvx/Yivnu+oYuWajlM5ni/n9LhqoMXe
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P2PbgzgkYgGIMjzZRTYun1mUS+li2DmpXNR0m7zFio=;
        b=GNr9QzSnbQD/mz0ytAvsu7X6S8ao/oBXWE+v95c7xDxEB97zICGF5c5uYisjHP9hnM
         m41eaQ2ypmhNm5c0udf4FkUN+/skPFVtxgFKlwDKSnX734uLHs01EhuJH6ngmJtC4aRW
         HY5qVSqfOCAEAvfycP+j/wZnCnP8uErxj/TXQsj7yPamp0iTGx3k/rpRSEKKCusb6AXB
         VVgOO+PzIXwA48+FNLF3oUkLnIQZXCuf5N9uv6IoyzaLhgzDMw9kQqK8hsDkpD+Bd6bL
         lSTC0Bl/3ebrEqM2LggLl6SmSS9YsWE+ebSqM3vjjL2Emld7hLjADvixaTP7t74KKnVK
         d2qA==
X-Gm-Message-State: AJIora8tApywOu8eHKC/VIqzu9Z7nr4IL3lmcfSBlOmade9yNEuzh1aR
	u6HPPdplr9LW9603Y0d5p0SBwBFlyF0tZKWggs0=
X-Google-Smtp-Source: 
 AGRyM1vDzU8UJ16rOtg0kAa8iYH1JhsqY6mCjiisraaTbme6lPlvI5qco6yAnkk1NqXR5ImxbH7+KAZ9Bj9UTk01j10=
X-Received: by 2002:adf:fb03:0:b0:21d:70cb:d6b5 with SMTP id
 c3-20020adffb03000000b0021d70cbd6b5mr6903237wrr.548.1658742163774; Mon, 25
 Jul 2022 02:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220723011305.311655-1-marex@denx.de>
 <3839828d-f538-a865-8e87-64ce8d04ac21@theobroma-systems.com>
 <7349096f-f252-51d2-e12e-f9f21606892b@denx.de>
In-Reply-To: <7349096f-f252-51d2-e12e-f9f21606892b@denx.de>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 25 Jul 2022 11:42:16 +0200
Message-ID: 
 <CA+chaQdh3BM8gNLE5qmWNk5COzdq81xRR+YhW5tqoHQnHeyXvg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Document override
 :append, :prepend, :remove order
To: Marek Vasut <marex@denx.de>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000721f6505e49e016c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 09:42:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13841

--000000000000721f6505e49e016c
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 25, 2022 at 11:40 AM Marek Vasut <marex@denx.de> wrote:

> On 7/25/22 10:36, Quentin Schulz wrote:
> > Hi Marek,
>
> Hi,
>
> > On 7/23/22 03:13, Marek Vasut wrote:
> >> The application order of override syntax :append, :prepend, :remove is
> >> inobvious and undocumented. The order does not match variable parse
> >> history, i.e. output of "bitbake -e", either.
> >>
> >> Add note documenting the exact order in which :append, :prepend, :remove
> >> are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
> >> that this order does not match the variable parse history order. This
> >> is mostly to prevent others from running into this and scratching their
> >> heads, trying to find out what is going on.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> ---
> >>   .../bitbake-user-manual-metadata.rst                 | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> >> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> >> index 33782161..651116ce 100644
> >> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> >> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> >> @@ -351,6 +351,18 @@ The variable ``FOO`` becomes
> >>   Like ":append" and ":prepend", ":remove" is applied at variable
> >>   expansion time.
> >> +.. note::
> >> +
> >> +   The overrides are applied in this order, ":append", ":prepend",
> >> ":remove".
> >> +   This implies it is not possible to re-append previously removed
> >> strings.
> >> +
> >> +.. note::
> >> +
> >> +   Override application order may not match variable parse history,
> i.e.
> >> +   the output of ``bitbake -e`` may contain ":remove" before ":append",
> >> +   but the result will be removed string, because ":remove" is handled
> >> +   last.
> >> +
> >
> > I can suggest a more concise note, since I don't think we care about the
> > actual order of append and prepend:
> > ```
> > ``:remove`` is final. Any string appearing in ``:remove`` cannot be
> > added back regardless of when ``:remove`` was parsed.
> > ```
> > Up to you :)
>
> I'd argue it's better to keep the information full and complete, esp.
> since its not easy to find within bitbake sources.
>

Then I would suggest also to mention a way to undo :remove with separate
variable as discussed on IRC.

Cheers,

--000000000000721f6505e49e016c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jul 25, 2022 at 11:40 AM Marek Va=
sut &lt;<a href=3D"mailto:marex@denx.de">marex@denx.de</a>&gt; wrote:<br></=
div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 7/25/22 10:36, Quentin Schulz wrote:<br>
&gt; Hi Marek,<br>
<br>
Hi,<br>
<br>
&gt; On 7/23/22 03:13, Marek Vasut wrote:<br>
&gt;&gt; The application order of override syntax :append, :prepend, :remov=
e is<br>
&gt;&gt; inobvious and undocumented. The order does not match variable pars=
e<br>
&gt;&gt; history, i.e. output of &quot;bitbake -e&quot;, either.<br>
&gt;&gt;<br>
&gt;&gt; Add note documenting the exact order in which :append, :prepend, :=
remove<br>
&gt;&gt; are applied to variable in lib/bb/data_smart.py getVarFlag(). Add =
note<br>
&gt;&gt; that this order does not match the variable parse history order. T=
his<br>
&gt;&gt; is mostly to prevent others from running into this and scratching =
their<br>
&gt;&gt; heads, trying to find out what is going on.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de" ta=
rget=3D"_blank">marex@denx.de</a>&gt;<br>
&gt;&gt; Cc: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfound=
ation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 .../bitbake-user-manual-metadata.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 12 ++++++++++++<br>
&gt;&gt; =C2=A0 1 file changed, 12 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.=
rst <br>
&gt;&gt; b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt;&gt; index 33782161..651116ce 100644<br>
&gt;&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt;&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt;&gt; @@ -351,6 +351,18 @@ The variable ``FOO`` becomes<br>
&gt;&gt; =C2=A0 Like &quot;:append&quot; and &quot;:prepend&quot;, &quot;:r=
emove&quot; is applied at variable<br>
&gt;&gt; =C2=A0 expansion time.<br>
&gt;&gt; +.. note::<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0 The overrides are applied in this order, &quot;:appe=
nd&quot;, &quot;:prepend&quot;, <br>
&gt;&gt; &quot;:remove&quot;.<br>
&gt;&gt; +=C2=A0=C2=A0 This implies it is not possible to re-append previou=
sly removed <br>
&gt;&gt; strings.<br>
&gt;&gt; +<br>
&gt;&gt; +.. note::<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0 Override application order may not match variable pa=
rse history, i.e.<br>
&gt;&gt; +=C2=A0=C2=A0 the output of ``bitbake -e`` may contain &quot;:remo=
ve&quot; before &quot;:append&quot;,<br>
&gt;&gt; +=C2=A0=C2=A0 but the result will be removed string, because &quot=
;:remove&quot; is handled<br>
&gt;&gt; +=C2=A0=C2=A0 last.<br>
&gt;&gt; +<br>
&gt; <br>
&gt; I can suggest a more concise note, since I don&#39;t think we care abo=
ut the <br>
&gt; actual order of append and prepend:<br>
&gt; ```<br>
&gt; ``:remove`` is final. Any string appearing in ``:remove`` cannot be <b=
r>
&gt; added back regardless of when ``:remove`` was parsed.<br>
&gt; ```<br>
&gt; Up to you :)<br>
<br>
I&#39;d argue it&#39;s better to keep the information full and complete, es=
p. <br>
since its not easy to find within bitbake sources.<br></blockquote><div><br=
></div><div>Then I would suggest also to mention a way to undo :remove with=
 separate variable as discussed on IRC.</div><div><br></div><div>Cheers,</d=
iv></div></div>

--000000000000721f6505e49e016c--

