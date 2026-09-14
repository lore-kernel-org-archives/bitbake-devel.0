Return-Path: <zhangqiang.zq307@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D6C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 10:04:14 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16762.1789380248437029956
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 03:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ImoP1pU3;
 spf=pass (domain: gmail.com, ip: 209.85.161.45, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6c1983dfaffso2247517eaf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 03:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380247; cv=none;
        d=google.com; s=arc-20260327;
        b=LFNQHXuHp/h5NOOmFAHJ3Mf9mt8z81U89zojGyfb/bubiZMU6yITx5ac6g4twlc0C5
         9I13toHn9fDwyNzPxlEeNMT0UCyC/uKblknu5GxxnlHUp621tJN6clX8B9o00RFLAczF
         JdfkDzmE7owa0oummNpT0IsJTKp78BCr+ut/rnRqm2nmaSBb+lrekhWAmunOBIZvfmlA
         JPmT2ZjbFbaUejtRiSkUY6A+ffRZVXSmH2GqpvQEkNe3H5xBZrBbw4bJ69Sa4wUZVGs1
         tHoxyoi7ADQk5QSGo//+gPIOR1/1s3ZuAETYXVe4PjCU2x2+7/g7XQAf2UAoGmUSx0LS
         Ocwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D8tu9PwsG07HDKQxgvQAiWecZ0boD9T7pOtVWb4zkVs=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=JmpUDuNlsvkgBhlipmyFmoojLgDKzf2dIvI9qvRPhlqy5pFe7ELvZmIU/GCC3ME9jC
         R3Y9O7Y9qekpTaL9gGa1v8gBwidsvLCS8Mg26QJJmZ78LmKRjP0ezr+M7eLERbiiakA0
         nOUiIhu9DqAhutqUn56hb1MOMYPTQbF0bNApDPfabRdC2vEU7xRBC0F+tswPMhY1tYdp
         3r3Cf2epZgeksPrBxsbbCXhmXKjpevh1K9nOx7y6jGwaWgERK0P5529lTfrjBPI5bgiW
         wKqK7n5/Eaziwm9xX0v+WBbLLYACr17tO8DV2a5qJAiftOyvQejZjTMA+MB3YEVxYuqi
         2ZWQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789380247; x=1789985047; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8tu9PwsG07HDKQxgvQAiWecZ0boD9T7pOtVWb4zkVs=;
        b=ImoP1pU3Hjnlei8u1nkGqilE4zwIjCN8CAqB1NfsnIh8Vr0gQbr3Ae910ZGOCu8z0j
         1PZZYx/UN1LsChcsr//WKgQHs2OE35lhqXoFpjmozM3jjx2iziSH27UlRzmsFzhTmIlq
         Vh4TQF/3YrS9xYFKxgpKb23sfrGR8E+VkF2Y9R+KxUpgQ7ArvD+/JpEwWL2mlV8gBttp
         dFcbzqAhGYj4O7RcuDSQnFC/+wCXzc13IB0imBRUFJmBzNiC0NI6bd3KL1ydFl91tPDn
         TG+eoxTU0s8+QHJJ6prDsftj4JgwwuJee4azMEsrCpr50g+vE3o8Hvx+sn4ETAE69De4
         I84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380247; x=1789985047;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8tu9PwsG07HDKQxgvQAiWecZ0boD9T7pOtVWb4zkVs=;
        b=Bv3BClH4WpxCs7FvstZGoxUSS68ttjUS/S4G6kn0/TAjOGgWxNA6qn96dY/hJW1INS
         hrwTPk7MKwivS7JgnbF+z0tuP8PrS0VWWqXXa+wspF0Qkbdzcct3L4NKRIGSnZkXE+VL
         FIlzXM43NWhmP2wrfHMCxasurL95TVEc/WPpAuX8cMiwfVqsTArlOPL29C416+OSMR+g
         n4/J86at5ti+m858GRC/FZaZ4Ik8jKFvUwNcNg2odmXpdTkzkDGPZcz6z2VfrIk744W2
         JUXLv2gHysCc/qhI2q886tjXa+5989OQXgbYwa88u616q9uYufh13Nnww2jFpmMZjqMR
         BfeQ==
X-Gm-Message-State: AFuF++mwzPIiLu1Nv5hmms7JXg5TcEgxGBSlOUqfrEdYGYwQfKhtCTV+
	8RCnt8ACKaFEB2oPuBzDdP2deS52rQyjZnhQfhelMkYdBWHtK4gs2y4Q1sEz5l5Wl8p657W0W9F
	xkrlMcBcj3z+jQLA8k4MGD8R3ZnPTywQ=
X-Gm-Gg: AYBFou2q6quzmtz3nSFQVvQhPm5q55R0rfkKCJBEQeZVpjQiKKJQQM80KXZ3le5Majy
	9l+QfLmVwtDg10KrINo5cJv0BC9Fa7ql8Qzgh6G7rQnPPI2mB6IBTP7tCFVtvlPEajBZZ00Bzgt
	8X7QuR2CPgnyLjPko6Day3qaij9Qx1Xqg/y/mxhdoPf4gCWMzNV45p2H5uJNP9mgCB9Ytkabm0z
	8/qOEQ3QasTLQ/txmF40Xgl+w7mjWkKTR/9L7SktIIhNbGU04KxFXnqnwGUNCKhFPRqJeaeFzZ9
	XHIZB9e0NCE6ExxY+gQ0TepXdhxjOtG+NSin/em87HeUU5iWsxFdkxs4GGIgeGvFrA==
X-Received: by 2002:a05:6820:1f03:b0:6b0:4fbc:aecf with SMTP id
 006d021491bc7-6c54057c67dmr796766eaf.24.1789380247500; Mon, 14 Sep 2026
 03:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com> <1166440fd2b4a63232ad5959369f7602a43de82f.camel@linuxfoundation.org>
In-Reply-To: <1166440fd2b4a63232ad5959369f7602a43de82f.camel@linuxfoundation.org>
From: =?UTF-8?B?5byg5by6?= <zhangqiang.zq307@gmail.com>
Date: Mon, 14 Sep 2026 18:03:55 +0800
X-Gm-Features: AcwNN1V5DUTGN-BU2N8lAmut6mcKONUPb51dZgxg66UWQga--BBd_Ug7DeDZApQ
Message-ID: <CAFb4brP7OpopstkUKCCGyFPEaGwjab+AR+FFPh0pvGjK+Uhsxw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch: Add log_errors parameter to Fetch.download()
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000053ae7065b6e8e39"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 10:04:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20193

--000000000000053ae7065b6e8e39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree an index/object mismatch on the mirror is a real error that
needs fixing, and I'm not trying to silence that class of failure.

The case I'm hitting is different: the fetch fails with a transient
network error (connection reset / timeout between the builder and the
mirror), not "the mirror advertised something it doesn't have". The
task then falls back to running the real task and succeeds, so nothing
actually failed - yet bitbake still exits non-zero purely because of
that ERROR line, since ERROR messages count towards the exit code. In
CI this turns a fully recovered build into a red one, with no way to
tell it apart from a genuine failure.

A recovered sstate miss is already a normal, designed-for path; the
goal is just to make the exit code reflect the actual outcome.
If log_errors is not the right shape, would either of these be more
acceptable?
- keep ERROR only for "mirror is lying" (404 / checksum mismatch) and
log network-level errors (timeout, connection reset) at WARNING, or
- have download() raise instead of logging, and let the caller pick
the level.
Both keep real mirror problems loud while not failing a build over a
network blip. Happy to respin the patch in whichever direction you
prefer.

Qiang,

Richard


Richard Purdie <richard.purdie@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=80 17:24=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, 2026-09-14 at 13:11 +0800, zhangqiang.zq307 via
> lists.openembedded.org wrote:
> > From: =E5=BC=A0=E5=BC=BA <zhangqiang.zq307@gmail.com>
> >
> > Fetching an sstate object from a mirror can fail transiently and is
> > recoverable when the caller falls back to running the real task.
> > The unconditional logger.error() in download() makes bitbake exit
> > non-zero even though every task ends up succeeding, as bitbake counts
> > any ERROR message towards its exit code.
> >
> > Add a log_errors parameter so such callers can request the first
> > fetch failure to be logged at WARNING instead of ERROR. The default
> > (True) keeps the current behaviour for all existing callers.
> >
> > Signed-off-by: =E5=BC=A0=E5=BC=BA <zhangqiang.zq307@gmail.com>
> > ---
> >  lib/bb/fetch/__init__.py | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
>
> There have been a few attempts at changes like this over the years and
> we've not taken them. If the mirror says something is available, then
> for some reason it isn't that is an error and should be reported as
> such, it really needs fixing.
>
> Cheers,
>
> Richard
>

--000000000000053ae7065b6e8e39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail-universal-card-markdown-code-bloc=
k__code-line">I agree an index/object mismatch on the mirror is a real erro=
r that
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ne=
eds fixing, and I&#39;m not trying to silence that class of failure.
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line"><b=
r></div><div class=3D"gmail-universal-card-markdown-code-block__code-line">
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">Th=
e case I&#39;m hitting is different: the fetch fails with a transient
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ne=
twork error (connection reset / timeout between the builder and the
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">mi=
rror), not &quot;the mirror advertised something it doesn&#39;t have&quot;.=
 The
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ta=
sk then falls back to running the real task and succeeds, so nothing
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ac=
tually failed - yet bitbake still exits non-zero purely because of
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">th=
at ERROR line, since ERROR messages count towards the exit code. In
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">CI=
 this turns a fully recovered build into a red one, with no way to
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">te=
ll it apart from a genuine failure.
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line"><b=
r></div><div class=3D"gmail-universal-card-markdown-code-block__code-line">
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">A =
recovered sstate miss is already a normal, designed-for path; the
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">go=
al is just to make the exit code reflect the actual outcome.
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">If=
 log_errors is not the right shape, would either of these be more
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ac=
ceptable?
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">- =
keep ERROR only for &quot;mirror is lying&quot; (404 / checksum mismatch) a=
nd
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">  =
log network-level errors (timeout, connection reset) at WARNING, or
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">- =
have download() raise instead of logging, and let the caller pick
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">  =
the level.
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">Bo=
th keep real mirror problems loud while not failing a build over a
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">ne=
twork blip. Happy to respin the patch in whichever direction you
</div><div class=3D"gmail-universal-card-markdown-code-block__code-line">pr=
efer.</div></div><div class=3D"gmail-universal-card-markdown-code-block__co=
de-line"><br></div><div class=3D"gmail-universal-card-markdown-code-block__=
code-line">Qiang,</div><div class=3D"gmail-universal-card-markdown-code-blo=
ck__code-line"><br></div><div class=3D"gmail-universal-card-markdown-code-b=
lock__code-line">Richard<br></div><div class=3D"gmail-universal-card-markdo=
wn-code-block__code-line"><br></div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &l=
t;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linu=
xfoundation.org</a>&gt; =E4=BA=8E2026=E5=B9=B49=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=B8=80 17:24=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Mon, 2026-09-14 at 13:11 +0800, zhangqiang=
.zq307 via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" tar=
get=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; From: =E5=BC=A0=E5=BC=BA &lt;<a href=3D"mailto:zhangqiang.zq307@gmail.=
com" target=3D"_blank">zhangqiang.zq307@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Fetching an sstate object from a mirror can fail transiently and is<br=
>
&gt; recoverable when the caller falls back to running the real task.<br>
&gt; The unconditional logger.error() in download() makes bitbake exit<br>
&gt; non-zero even though every task ends up succeeding, as bitbake counts<=
br>
&gt; any ERROR message towards its exit code.<br>
&gt; <br>
&gt; Add a log_errors parameter so such callers can request the first<br>
&gt; fetch failure to be logged at WARNING instead of ERROR. The default<br=
>
&gt; (True) keeps the current behaviour for all existing callers.<br>
&gt; <br>
&gt; Signed-off-by: =E5=BC=A0=E5=BC=BA &lt;<a href=3D"mailto:zhangqiang.zq3=
07@gmail.com" target=3D"_blank">zhangqiang.zq307@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/fetch/__init__.py | 10 ++++++++--<br>
&gt; =C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
There have been a few attempts at changes like this over the years and<br>
we&#39;ve not taken them. If the mirror says something is available, then<b=
r>
for some reason it isn&#39;t that is an error and should be reported as<br>
such, it really needs fixing.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000053ae7065b6e8e39--

