Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA4C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:51:38 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.129140.1680699096426638407
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=l+aeBTWx;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id o20so34263825ljp.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGCzHu5Y/kTttH3NIHGwtCgL8PjnbDToB7Tpl7gfJRM=;
        b=l+aeBTWxywaUx/dnM2QgWqU3944KrqAj3yS+DVYBVwhRrL+jLDUbGh+oM5sE5HHhSb
         5OyDWBmPxThxF2hQF0HTxYblH23hhWSnhnDpnQuAov+5MPNWhaH+lnP0zL0dDwOVOM77
         BYkRfRA5CbK2MeIoBUQmyp+KSQMdnlE58Ylwis3IsZptyZVElcpR0e+y5QzcQKkEtib8
         yMhj9ZpJc3tzbp3+lbKpcEdenPOfBarT5Ai7o7xasQCkdC3T9bEy7V4GMFlIsE1D9xdh
         QiYg1wDFbqUZogH94wf9vILUXQihCZJDPaN9RqIOthRg5wtcupJrFdyAiOFJ0f8dQ/i1
         Il5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGCzHu5Y/kTttH3NIHGwtCgL8PjnbDToB7Tpl7gfJRM=;
        b=IQahjK9dwKqcT4hlhYx9Q1tBo64m2pprn1Y738XcrezVEC3KNpv0izd6vOH1A+TtXS
         yyDyCfqwg5WZRaQVIGSOQiZGtSLeBCXaTMZy1cJXjAXbspCsiu3vjCc2DkY2JwBY4JwW
         cWzVHSM1eAm9gUCdYuo/JPd9Vyc8dN/sdUWroqQ0jRh9p9drl1z9W5SLuc15lICpyCGw
         V/odpzcN748CJBMjZkzZnqPhEep8sa/qrtUCojtLIqrktazrk0vvWGs8ly+OD5Z8N6+I
         21ep0WbIyIIn4kh3yRoHHEp35OAvSfTGtRLTSwrES0Ub9EMgCmHfnbNnjBAAULpS8CNp
         Cq2w==
X-Gm-Message-State: AAQBX9fl7zmUioF8K62sF6+qcJc9Yx9GBxijHwFd2iRl2nBiwhE3ZiEq
	zNaDrX9+7xUn7YSHycBM9uE+8Iq2We/B+ODas+85q52H
X-Google-Smtp-Source: AKy350ZqBqYgiTY3Q0lEwpYroyxgYSf9UEpukh2emRhYBVNLI+gBwZ9nA7cAlgFFP+uEOhxQmamFawLMGlRfaIhkuOU=
X-Received: by 2002:a2e:a40e:0:b0:294:6de5:e642 with SMTP id
 p14-20020a2ea40e000000b002946de5e642mr2237941ljn.3.1680699094453; Wed, 05 Apr
 2023 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com> <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com> <d3bdc504-a8d2-b925-cfd4-78655df7e4cd@mvista.com>
In-Reply-To: <d3bdc504-a8d2-b925-cfd4-78655df7e4cd@mvista.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 14:51:23 +0200
Message-ID: <CA+cAker7RbVScDT_C8PmsRJ_03dXCx62WwGDRQbtSnkSBe1ujw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: akuster <akuster@mvista.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007fd39805f8964089"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:51:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14657

--0000000000007fd39805f8964089
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is the problem of having name there?

The bitbake fetcher (master) handles that.

Le mer. 5 avr. 2023, 14:25, akuster <akuster@mvista.com> a =C3=A9crit :

>
>
> On 4/5/23 1:20 AM, Fr=C3=A9d=C3=A9ric Martinsons wrote:
> > I looked at the suricata recipe in meta-security and it didn't use
> > cargo-update-recipes.bbclass
> >
> > You should modify your rust recipes to use this class and have access
> > to "bitbake -c update_crates" .
> >
> > You can take some examples from , i.e python3-cryptography in
> > openembedded-core or python3-pyruvate
> > in meta-python.
> >
> > The first issue you'll encounter is some kind of bootstrapping (since
> > update_crates needs to fetch
> > to be able to write checksum but the fetcher needs the checksum ...).
> > With this error , you'll
> > see all the data you need to add to the suricata-crates.inc.
> >
> > For curiosity, I tested locally the modification of suricata and it
> > seems that this package embeds
> > unexpected Cargo.lock format (in
> > rust/vendor/alloc-no-stdlib/Cargo.lock) which doesn't contain
> > a source entry (the package doesn't have any dependency).
>
> I deleted the Cargo.* in the offending crates ( I found another) and I
> was able to finish running the update_creates. I notice "name" is now
> part of the crates URI and the SRC_URI hashes. It wont build now but I
> think I can work around that.
>
> - armin
> >
> > I don't know how to handle such a file (simply ignore it in the class
> > instead of raising an error ?)
> >
> >
> > On Tue, 4 Apr 2023 at 23:35, Martin Jansa <martin.jansa@gmail.com>
> wrote:
> >
> >     On Tue, Apr 4, 2023 at 11:08=E2=80=AFPM akuster <akuster@mvista.com=
> wrote:
> >
> >
> >
> >         On 4/4/23 1:07 PM, Martin Jansa wrote:
> >         > On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster <akuster@mvist=
a.com>
> >         wrote:
> >         >
> >         >
> >         >
> >         >     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
> >         >     > From: Frederic Martinsons <frederic.martinsons@gmail.co=
m
> >
> >         >     >
> >         >     > Instead of only display the first and stop.
> >         >     > For recipe (crago based) that can contains several
> >         artifacts
> >         >     > to fetch with their checksum, it will particularly hand=
y
> >         >     > to display all of missing one.
> >         >     >
> >         >     > An example of error message would be
> >         >
> >         >     I am confused. Is this patch supposed to add the pkg
> >         version or
> >         >     not?  I
> >         >     am not seeing any. Any ideas?
> >         >
> >         >
> >         > name parameter with pkg version was added to bbclass in:
> >         >
> >
> https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad0=
9b011afcc7cc3bf6dc49475b19a
> >         >
> >         > this change only allows all missing/incorrect checksums to
> >         be showsn
> >         > at the same time, instead of one checksum per do_fetch failur=
e.
> >
> >         I get multiple hashes for the same package.
> >
> >         SRC_URI[wasi.sha256sum] =3D
> >
>  "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
> >         SRC_URI[wasi.sha256sum] =3D
> >
>  "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
> >
> >         so why no version info after the pkg name?
> >
> >
> >     Did you regenerate the SRC_URIs with updated bbclass? It works for
> >     me as in:
> >
> https://github.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07=
ccddce0b9f2bcd90d39
> >
>
>

--0000000000007fd39805f8964089
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>What is the problem of having name there?=C2=A0</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">The bitbake fetcher (master)=
 handles that.=C2=A0<br><br><div class=3D"gmail_quote" dir=3D"auto"><div di=
r=3D"ltr" class=3D"gmail_attr">Le mer. 5 avr. 2023, 14:25, akuster &lt;<a h=
ref=3D"mailto:akuster@mvista.com">akuster@mvista.com</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 4/5/23 1:20 AM, Fr=C3=A9d=C3=A9ric Martinsons wrote:<br>
&gt; I looked at the suricata recipe in meta-security and it didn&#39;t use=
 <br>
&gt; cargo-update-recipes.bbclass<br>
&gt;<br>
&gt; You should modify your rust recipes to use this class and=C2=A0have ac=
cess <br>
&gt; to &quot;bitbake -c update_crates&quot; .<br>
&gt;<br>
&gt; You can take some examples from , i.e=C2=A0python3-cryptography in <br=
>
&gt; openembedded-core or python3-pyruvate<br>
&gt; in meta-python.<br>
&gt;<br>
&gt; The first issue you&#39;ll encounter is some kind of bootstrapping=C2=
=A0(since <br>
&gt; update_crates needs to fetch<br>
&gt; to be able to write checksum but the fetcher needs the checksum ...). =
<br>
&gt; With this error , you&#39;ll<br>
&gt; see all the data you need to add to the suricata-crates.inc.<br>
&gt;<br>
&gt; For curiosity, I tested locally the modification of suricata and it <b=
r>
&gt; seems that this package embeds<br>
&gt; unexpected Cargo.lock format (in <br>
&gt; rust/vendor/alloc-no-stdlib/Cargo.lock) which doesn&#39;t contain<br>
&gt; a source entry (the package doesn&#39;t have any dependency).<br>
<br>
I deleted the Cargo.* in the offending crates ( I found another) and I <br>
was able to finish running the update_creates. I notice &quot;name&quot; is=
 now <br>
part of the crates URI and the SRC_URI hashes. It wont build now but I <br>
think I can work around that.<br>
<br>
- armin<br>
&gt;<br>
&gt; I don&#39;t know how to handle such a file (simply ignore it in the cl=
ass <br>
&gt; instead of raising an error ?)<br>
&gt;<br>
&gt;<br>
&gt; On Tue, 4 Apr 2023 at 23:35, Martin Jansa &lt;<a href=3D"mailto:martin=
.jansa@gmail.com" target=3D"_blank" rel=3D"noreferrer">martin.jansa@gmail.c=
om</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Apr 4, 2023 at 11:08=E2=80=AFPM akuster &lt=
;<a href=3D"mailto:akuster@mvista.com" target=3D"_blank" rel=3D"noreferrer"=
>akuster@mvista.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 4/4/23 1:07 PM, Martin Jansa wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Tue, Apr 4, 2023 at 6:50=E2=
=80=AFPM akuster &lt;<a href=3D"mailto:akuster@mvista.com" target=3D"_blank=
" rel=3D"noreferrer">akuster@mvista.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On 4/1/23 11:=
21 AM, Frederic Martinsons wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Fr=
ederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">frederic.martinsons@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Instead =
of only display the first and stop.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; For reci=
pe (crago based) that can contains several<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0artifacts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; to fetch=
 with their checksum, it will particularly handy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; to displ=
ay all of missing one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; An examp=
le of error message would be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0I am confused=
. Is this patch supposed to add the pkg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0not?=C2=A0 I<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0am not seeing=
 any. Any ideas?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; name parameter with pkg version =
was added to bbclass in:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.openembedded.o=
rg/openembedded-core/commit/?id=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://git.openembedded.o=
rg/openembedded-core/commit/?id=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; this change only allows all miss=
ing/incorrect checksums to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be showsn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; at the same time, instead of one=
 checksum per do_fetch failure.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I get multiple hashes for the same pa=
ckage.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI[wasi.sha256sum] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;1a143597ca7c7793eff794def352d41=
792a93c481eb1042423ff7ff72ba2c31f&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI[wasi.sha256sum] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cccddf32554fecc6acb585f82a32a72=
e28b48f8c4c1883ddfeeeaa96f7d8e519&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so why no version info after the pkg =
name?<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Did you regenerate the SRC_URIs with updated bbclas=
s? It works for<br>
&gt;=C2=A0 =C2=A0 =C2=A0me as in:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/shr-project/meta-webo=
sose/commit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">https://github.com/shr-project/meta-webosose/com=
mit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39</a><br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000007fd39805f8964089--

