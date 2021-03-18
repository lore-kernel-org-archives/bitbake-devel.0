Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.2433.1616106529863688457
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Mar 2021 15:28:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gqjzuK8p;
 spf=pass (domain: gmail.com, ip: 209.85.208.42, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f42.google.com with SMTP id h13so8590830eds.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDORI2NlwS3CEhNdcXBpIPz6YTMoGO8TzYE9SjBg3ys=;
        b=gqjzuK8pdhy+0hGtOQ4LupEd8+RCH2E3C5uuwNBDmESvBVTFKo0zdskORwj9Rq6mxk
         rgzAfgUW5c/eOuPZNHNPhjBpvXEhDhW81npSWI9t5zyEGhhZ2Ep1Qtx+EzmnEsrCPWXM
         QV9v3htVS4Qe9MwfOmKjJ5/dFOxMda71yfJbBkDE55ctDqnpjRhbYPR8EJWobzptWsYS
         uawSA/iD2bXE8RrWOlEleR/yOFDfPsyMlv4lI89Lnb5q6K9nBpxDhlsOKFjBR/sTNye1
         BtRdJm2/PuLALw+TvrhVSSuKtWwpO+kOOxHmIUwHrDZWA5+sbLM00w4R1Myevasphu16
         ltEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDORI2NlwS3CEhNdcXBpIPz6YTMoGO8TzYE9SjBg3ys=;
        b=Fw4U4t9cw6hdB/XBwfOzbI1pTI/PRvb+KkV0UQjJw7BR26cEk9iepEZ97FmiuftrjM
         Ps+miKZ4dRLo53Q/4sib76beSlaU5AeqxwYX6VL3oC2dBUwnDrSb+NZW41v/urQYJxxy
         VhvshXa6sYy+Pg62K2fLI/NqifmNgyHCOnElmMhbyfMPl+eFmma8SxJzlbji6tr9EP5v
         yERzYfSBAhjfhPfUXQrdvIgTFWtKrYSRAgRZ/i4MR7cTnLWGQaqSrXKxbnvzZZ2yDabI
         H/iuqyypSt6FkGHFAhaaFy6FgeCj1lYy9q24gR+kBO9vr0qzCh2s6Rz2HdGJ9PR+mc6z
         51QQ==
X-Gm-Message-State: AOAM531rnHVXZBsy7RY+/aHhCuwYe0nKwcuQ4uHlN7wOzcid2PYjn7C9
	Tm7lPFLSVQ9UMzFx5LRq4JfzrUZ9Aw8K3ccSo4Q=
X-Google-Smtp-Source: ABdhPJye6U96VwVAZLn3ZrLWgZn6x6KtFOe6GV3yLo6oBi0IeFznNVRjQCnM8O+p4EfHrqwXLV/TwXLchjDNbkF1irA=
X-Received: by 2002:a05:6402:1115:: with SMTP id u21mr6280912edv.383.1616106528184;
 Thu, 18 Mar 2021 15:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1616099999-47367-1-git-send-email-denis@denix.org> <336663df14ccfcaddd49f5ae3345ffef5a44d658.camel@linuxfoundation.org>
In-Reply-To: <336663df14ccfcaddd49f5ae3345ffef5a44d658.camel@linuxfoundation.org>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Thu, 18 Mar 2021 15:28:36 -0700
Message-ID: <CABcZANnicqNdbiV-mkDsChRp=sT2_PA_Y+YS5CEoxU3adAdpig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Denys Dmytriyenko <denis@denix.org>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000881d3a05bdd71f1d"

--000000000000881d3a05bdd71f1d
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 18, 2021 at 3:23 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2021-03-18 at 16:39 -0400, Denys Dmytriyenko wrote:
> > When first mirror returns an outdated fullmirror tarball, its clonedir
> stays
> > behind for successive mirror tries. Even when latest tarball gets fetched
> > next, it doesn't get unpacked, as clonedir already exists. Cleanup old
> > clonedir and unpack the new fullmirror tarball, when the old clonedir is
> > no good and requires update.
> >
> > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > ---
> >  lib/bb/fetch2/git.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index e3ba80a..cb62dcc 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -337,7 +337,8 @@ class Git(FetchMethod):
> >          if ud.shallow and os.path.exists(ud.fullshallow) and
> self.need_update(ud, d):
> >              ud.localpath = ud.fullshallow
> >              return
> > -        elif os.path.exists(ud.fullmirror) and not
> os.path.exists(ud.clonedir):
> > +        elif os.path.exists(ud.fullmirror) and (not
> os.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):
> > +            bb.utils.remove(ud.clonedir, recurse=True)
> >              bb.utils.mkdirhier(ud.clonedir)
> >              runfetchcmd("tar -xzf %s" % ud.fullmirror, d,
> workdir=ud.clonedir)
>
> I talked a little with Denys about this. I'm worried that if you specify
> SRCREV incorrectly it will start blowing away clone directories and
> for large ones like linux-yocto, the failure mode is *really* annoying
> and has the potential for data loss (you shouldn't be putting important
> data
> here, but...).
>
> I agree that we do need a test case. We can put artefacts on yp.org urls
> if needed.
>
> I also wonder if we can't check the new mirror tarball is any better before
> we blow away the existing directory.
>

I'm assuming this is for the case where the clonedir can't be updated
directly, ie premirrorsonly?

That's a good idea, unpack the new one to a temporary location, see if that
one is good enough first. It makes me wonder if there's a way to use git
bundles or something that can be interacted with more directly. I'm
assuming this is for the case where the clonedir can't be directly updated,
i.e. premirrorsonly?
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000881d3a05bdd71f1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 18, 2021=
 at 3:23 PM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfounda=
tion.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding=
-left:1ex">On Thu, 2021-03-18 at 16:39 -0400, Denys Dmytriyenko wrote:<br>
&gt; When first mirror returns an outdated fullmirror tarball, its clonedir=
 stays<br>
&gt; behind for successive mirror tries. Even when latest tarball gets fetc=
hed<br>
&gt; next, it doesn&#39;t get unpacked, as clonedir already exists. Cleanup=
 old<br>
&gt; clonedir and unpack the new fullmirror tarball, when the old clonedir =
is<br>
&gt; no good and requires update.<br>
&gt; <br>
&gt; Signed-off-by: Denys Dmytriyenko &lt;<a href=3D"mailto:denis@denix.org=
" target=3D"_blank">denis@denix.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/fetch2/git.py | 3 ++-<br>
&gt; =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
&gt; index e3ba80a..cb62dcc 100644<br>
&gt; --- a/lib/bb/fetch2/git.py<br>
&gt; +++ b/lib/bb/fetch2/git.py<br>
&gt; @@ -337,7 +337,8 @@ class Git(FetchMethod):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ud.shallow an=
d os.path.exists(ud.fullshallow) and self.need_update(ud, d):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0ud.localpath =3D ud.fullshallow<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0return<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(ud.fullmirror) and no=
t os.path.exists(ud.clonedir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(ud.fullmirror) and (n=
ot os.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.clonedir=
, recurse=3DTrue)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0bb.utils.mkdirhier(ud.clonedir)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0runfetchcmd(&quot;tar -xzf %s&quot; % ud.fullmirror, d, workdir=3D=
ud.clonedir)<br>
<br>
I talked a little with Denys about this. I&#39;m worried that if you specif=
y=C2=A0<br>
SRCREV incorrectly it will start blowing away clone directories and<br>
for large ones like linux-yocto, the failure mode is *really* annoying <br>
and has the potential for data loss (you shouldn&#39;t be putting important=
 data<br>
here, but...).<br>
<br>
I agree that we do need a test case. We can put artefacts on <a href=3D"htt=
p://yp.org" rel=3D"noreferrer" target=3D"_blank">yp.org</a> urls<br>
if needed.<br>
<br>
I also wonder if we can&#39;t check the new mirror tarball is any better be=
fore<br>
we blow away the existing directory.<br></blockquote><div><br></div><div><s=
pan>I&#39;m assuming this is for the case where the clonedir can&#39;t be u=
pdated directly, ie premirrorsonly?</span><br></div><div><span><br></span><=
/div><div>That&#39;s a good idea, unpack the new one to a temporary locatio=
n, see if that one is good enough first. It makes me wonder if there&#39;s =
a way to use git bundles or something that can be interacted with more dire=
ctly. I&#39;m assuming this is for the case where the clonedir=C2=A0can&#39=
;t be directly updated, i.e. premirrorsonly?</div><div></div></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D=
"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, =
OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div>=
</div></div></div></div></div>

--000000000000881d3a05bdd71f1d--
