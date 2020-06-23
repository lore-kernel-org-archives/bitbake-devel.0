Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web12.1763.1592894456252705442
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2020 23:40:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=qRaZU5el;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: onea.alex@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id n5so15521748otj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Jun 2020 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnOigafuHAu4Y2GlSbmgYRrK5NqyHjclvzqHXB2HPUo=;
        b=qRaZU5elY+aFQfRh8OlPtFmBcHphYRnWQFtKziOP0bZulOs+c+KRRQnpB79WU+XB2L
         2YmPH6JSMBceh4IJ5OqucxzeWynJrNhKCppKibJvxFNjytgXCoGBjrt/1rvvufa0ASwt
         uUOyBuwPZmSDyHxAthT/EcWLRaVRH2GSeMXTblFYQb8UmnZKOXlsSC+4180vE0YnL47n
         BMk7dXhGkI1/O/NXKbhByOIe13ZrMocdBn65yvADUePx6nrGFTdbOzS62Za0Rz4Avs6+
         9AsUUV9/iOLXg4PrpE58huQqxcu4uClhnYPFdQzJT5ifhkejgTvmw6pWXpZJl0rKjDNU
         VU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnOigafuHAu4Y2GlSbmgYRrK5NqyHjclvzqHXB2HPUo=;
        b=c7NH6lPRo3+d1XRpoEpWDrd83jbS0CLkrwaASZOp/o2L2RgqY8gf6YYv83XVP4Tc/P
         jzqHxfO2yNwbf1L1dofP/hrpB3QDcXaM2RozGRImd6+xK/7DDedyZdUj9BJfBgKUKzAf
         l6P5i8vqxjSmo8HvDjvWMeJ3Ltfx7zZalmJ/MqIv0sVV61n/eAj3S4rBr+ug99Yyet1+
         +hr0od8Eh+Sj3teHVt5CJv8GPDBzSV4FbAs3bjx+5N4IvKh3iEtRDao3+46hIGQsbivl
         uqwLgymZjBPY7vLmuDymgeP5CSZVanFwpa6YdWWuqutnQiJF1JFldiyqko0iJ6TWAia2
         qLlA==
X-Gm-Message-State: AOAM531AbHMDX3t28N+GJ+c3tdkjQSc0noBmSiR9vWXqTV76a5BeFRmB
	KqLLlhu2FiH7OaqjJs71oMoBDe7G9/4pMqHHues=
X-Google-Smtp-Source: ABdhPJwL8RNCd1BUXZ5elc6CLEpXXySa0BW9VjvwwtfTbWk+1NldII1EUmWieZ30xoFmNfC1v1nlNIal/+9nqqHzBEA=
X-Received: by 2002:a9d:7d0a:: with SMTP id v10mr18484314otn.280.1592894455539;
 Mon, 22 Jun 2020 23:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgSc4zktj90d5DXXoSa8vE8=F58puwKD0YKUTMA0etGn3U=XQ@mail.gmail.com>
 <aa5431eddbc52496d0cc0a2a848489dad6fd0d01.camel@linuxfoundation.org>
In-Reply-To: <aa5431eddbc52496d0cc0a2a848489dad6fd0d01.camel@linuxfoundation.org>
From: "Alexandru N. Onea" <onea.alex@gmail.com>
Date: Tue, 23 Jun 2020 09:40:44 +0300
Message-ID: <CAJgSc4zUtVEXmETMWZh58Uw-dPZ7QUiWHXC-Jrhok4fAFJz7ww@mail.gmail.com>
Subject: Re: [bitbake-devel] [fetcher2] perforce fetcher download dir
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002fead205a8baa457"

--0000000000002fead205a8baa457
Content-Type: text/plain; charset="UTF-8"

Hi,

Indeed, there is an overlap between the "destdir" option introduced by the
patch and the "subdir" option of the unpack. Their behavior is only
slightly different but the subdir option can be used to achieve the same
result. I will drop the "destdir" option. The other options do not have any
overlap with existing unpack functionality.

I will prepare a new version of the patch including updated documentation.

Best regards,
Alexandru Onea


On Mon, 22 Jun 2020 at 23:18, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Hi,
>
> On Sat, 2020-06-20 at 15:33 +0300, Alexandru N. Onea wrote:
> > I just started using the perforce fetcher and I am a bit confused by
> > how the fetcher implementation handles the location of the downloaded
> > sources. In particular, in cases where SRC_URI points to a directory,
> > expressed by the typical "/..." termination, the below code seems to
> > prepare the final filename by only taking into account the part of
> > the remote path which would follow the "/...".
> >
> > if depot_filename:
> >     if ud.pathisdir: # Remove leading path to obtain filename
> >         filename = depot_filename[len(ud.path)-1:]
> >     else:
> >         filename = depot_filename[depot_filename.rfind('/'):]
> >     filename = filename[:filename.find('#')] # Remove trailing '#rev'
> >
> > This comes with a limitation: if one has multiple perforce SRC_URI
> > entries, one ends up with a mixture of files, not
> > necessarily belonging together. Moreover, the comment is a bit
> > misleading, since the value of filename after the removal of the
> > leading path is not actually the filename but a filepath, stripped of
> > the "visible" repo path given in SRC_URI.
> >
> > Of course, there might be a strong argument in favor of this
> > behavior, however I failed so far to find it. I am writing to you in
> > the hope that someone can help me find the argument and understand
> > the rationale of the current implementation.
> >
> > If there is no argument in favor of the mentioned behavior, I would
> > like to prepare a patch for an alternative where the user has the
> > option to either keep the full remote file path (similar to how a
> > perforce client would sync the files) or strip the visible SRC_URI
> > part of the path, but specify a subdir name for each perforce SRC_URI
> > entry in order to keep things separated.
>
> Unfortunately the perforce fetcher is a bit of a black box to me and
> most other bitbake developers, we don't have the tool or any repos to
> use/test with it.
>
> We're therefore reliant on users reporting and fixing issues they run
> into.
>
> Thanks for your patches I saw yesterday, at a first glance they look
> reasonable. My only real concern is whether they overlap with any of
> our unpack options. I also wondered if we should be updating the
> bitbake manual with any of these new options or more information about
> the perforce fetcher?
>
> Cheers,
>
> Richard
>
>

--0000000000002fead205a8baa457
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Indeed, there is an overlap between=
 the &quot;destdir&quot; option introduced by the patch and the &quot;subdi=
r&quot; option of the unpack. Their behavior is only slightly different but=
 the subdir option can be used to achieve the same result. I will drop the =
&quot;destdir&quot; option. The other options do not have any overlap with =
existing unpack functionality.</div><div><br></div><div>I will prepare a ne=
w version of the patch including updated=C2=A0documentation.</div><div><br>=
</div><div>Best regards,<br clear=3D"all"><div><div dir=3D"ltr" class=3D"gm=
ail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Alexandr=
u Onea</div></div></div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, 22 Jun 2020 at 23:18, Richard Pur=
die &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdi=
e@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi,<br>
<br>
On Sat, 2020-06-20 at 15:33 +0300, Alexandru N. Onea wrote:<br>
&gt; I just started using the perforce fetcher and I am a bit confused by<b=
r>
&gt; how the fetcher implementation handles the location of the downloaded<=
br>
&gt; sources. In particular, in cases where SRC_URI points to a directory,<=
br>
&gt; expressed by the typical &quot;/...&quot; termination, the below code =
seems to<br>
&gt; prepare the final filename by only taking into account the part of<br>
&gt; the remote path which would follow the &quot;/...&quot;.<br>
&gt; <br>
&gt; if depot_filename:<br>
&gt;=C2=A0 =C2=A0 =C2=A0if ud.pathisdir: # Remove leading path to obtain fi=
lename<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename =3D depot_filename[len(ud.pa=
th)-1:]<br>
&gt;=C2=A0 =C2=A0 =C2=A0else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename =3D depot_filename[depot_fil=
ename.rfind(&#39;/&#39;):]<br>
&gt;=C2=A0 =C2=A0 =C2=A0filename =3D filename[:filename.find(&#39;#&#39;)] =
# Remove trailing &#39;#rev&#39;<br>
&gt; <br>
&gt; This comes with a limitation: if one has multiple perforce SRC_URI<br>
&gt; entries, one ends up with a mixture of files, not<br>
&gt; necessarily belonging together. Moreover, the comment is a bit<br>
&gt; misleading, since the value of filename after the removal of the<br>
&gt; leading path is not actually the filename but a filepath, stripped of<=
br>
&gt; the &quot;visible&quot; repo path given in SRC_URI.<br>
&gt; <br>
&gt; Of course, there might be a strong argument in favor of this<br>
&gt; behavior, however I failed so far to find it. I am writing to you in<b=
r>
&gt; the hope that someone can help me find the argument and understand<br>
&gt; the rationale of the current implementation.<br>
&gt; <br>
&gt; If there is no argument in favor of the mentioned behavior, I would<br=
>
&gt; like to prepare a patch for an alternative where the user has the<br>
&gt; option to either keep the full remote file path (similar to how a<br>
&gt; perforce client would sync the files) or strip the visible SRC_URI<br>
&gt; part of the path, but specify a subdir name for each perforce SRC_URI<=
br>
&gt; entry in order to keep things separated. <br>
<br>
Unfortunately the perforce fetcher is a bit of a black box to me and<br>
most other bitbake developers, we don&#39;t have the tool or any repos to<b=
r>
use/test with it.<br>
<br>
We&#39;re therefore reliant on users reporting and fixing issues they run<b=
r>
into.<br>
<br>
Thanks for your patches I saw yesterday, at a first glance they look<br>
reasonable. My only real concern is whether they overlap with any of<br>
our unpack options. I also wondered if we should be updating the<br>
bitbake manual with any of these new options or more information about<br>
the perforce fetcher?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000002fead205a8baa457--
