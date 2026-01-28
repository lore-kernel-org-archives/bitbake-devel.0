Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25824D46BF2
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 19:06:14 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2631.1769627164314817658
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 11:06:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=Vb2hBj7e;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.176, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fdb90b670so1692717b3.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 11:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769627163; cv=none;
        d=google.com; s=arc-20240605;
        b=bfbeIhcg6CukUWqP8iriqFp66c2ikxChSnCM3P5XfP0DaPNDJjnhYAvdMsJR3JM6Mi
         RJnbSYbFASVUh1Nw7Ni/NpKFgNXpK2vkdTwd5qUAsqSdPUsQ5cKYyKcOhRYIWMhK75Bp
         29LQhgUVg+0q6Q+KJ/NL6BFrQmwI2tYSi2keTFbJfMmaPOkBwqgIXfmLsgEHlH5bNz/J
         T/2U2UJjrjgfXhoO93SMxCd0pxqZdSE/DGbPNBXQN3f5yI00qMMBmOjRwSmXcSlkm1n1
         Tkl8D5mODH3DiasmcugS+yWN7oMa0h8fKlBPH/UGNxIbTw7QQiX+YRwkYvcFDtw1xRV+
         XKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oOZiu60Y7E4VtX9VyTo6kGKvDf7d/seOx8YxV+rm4t8=;
        fh=mTvk0ClZ29uesmJabIEbRmIpV977vTZfZOCj00+Avuo=;
        b=el6pIe0KwvMMpIMp2+uiYXhqfx39f7NjowGjUAQkMdjWP/yaRPFGVwpTqw0x2TgQ66
         8nYMZC6QTG7k9oLRvax9g4v6frqBMsoJtvW6vv/A/g/j8YkrSEOIuXzMpMpY353BhlJp
         dgbc+Um7eX3bCMp24SyF8h6W5ZhPhzsCEQhGT0nxQ24Wk95C8nNpyYZb+lrmCt3scQzf
         jaayqt0XBE4gfQcnbs0mryKQIoWaKSqMyOosSRsD5FvMp7PdChajHVQQBOj5m1tq4bPn
         TaNJI/sTUVg0CA0+ybdXTIDpAHJms6jTkXbIMMBRl0HBLQAKPsW6zG4gqHMVxAEb5FQv
         iOBQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769627163; x=1770231963; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oOZiu60Y7E4VtX9VyTo6kGKvDf7d/seOx8YxV+rm4t8=;
        b=Vb2hBj7eNHBPdaY29ET5PtP8cZyYpzxbqRDQUPdBxQIyJScLtqy4awiuenQ+DXfxXo
         qETiMileOTSCJ+HvfnGk1v7erAdhAiq5k85CmrHsmhVY7+5+PCtpcLAkuRRAe3zW18pP
         PME9I1NuRf9zwgAne/i3TgM56MSwFJOQFfy3cWDwmm7pD32QKW8OwUEdCcodFqNjDQ5p
         c5qaMS4RbOwz+TktMDVlHpK3PGmbT2bi7n4FOKBioRqHx5onUlpI7N6kSXo8K/1YJQVZ
         kjJi/i1mAJAqX6lqH3SwaEudGrsIlxgNVOVtayMOxEDXSMQ1RIJ0P5eHiQ0hGEDnPgk+
         xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627163; x=1770231963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOZiu60Y7E4VtX9VyTo6kGKvDf7d/seOx8YxV+rm4t8=;
        b=hlH79jAg9yzjKeBElU7vE73lhFyB5TAXP1OW1eEz6TxAOF/mpPWM59J/7DBXavVtdv
         0q1cT7AvDuzQ5/nF4csdQyHYgsV33kQYXeZjxGOy8pAn77mv8nJ0TVEpFB2CIYjTtNz3
         zGCDNwv6faTaqKCFCCvSa+tez+52H61Gj52U2BJGtUCpLD8nLfJ/GZS0t28OxAOKdeRD
         787o8I243jYxXEcMdDbhh/YvLOKZdP0r1AMJ5QXOm2ZohK+SqKqXEo81yBiY0RiMCzLX
         OY4e89WdPOh7qo6De9pPxLj0U6mrHjbJG582ibDUMK/YAQTaKyqmfKc6tyweQTjGknpx
         o3cw==
X-Gm-Message-State: AOJu0YwsbYEMoeokO1Mpdg2OHpM/dDnIRx9LOXooy6l8gBUOZXkKVUxk
	9J5Fj9Xjhah3Pur/Ah2fvhOImUkixsZTvD/vtb5cpTGxTCM34CFZgHUi5FqxAto+WzM5PnbG89Y
	ExDQDNIReEki7TmY8LYX+tjdKyJ7LdoppUiD1sCgwhg==
X-Gm-Gg: AZuq6aJxbzXGoGDkRHkAWa2PT+jVcg0YDSf4lpJewYz3cDGn2miJpWapTuamnyx1Pv7
	qiwupQwoRdfYsc3d39P6y0Ww/8OPnm7PnCE1o4YvjMf6dHxwhOM+oMbw9Mgvi33F6r52MwMAQyi
	IgZmOov5EhoGxzUlVFcl6MAjlXa9sWCWU4AmwTE9zib2hHo9SNI0sNRZSU7Oq8J2gIVD52Grw/M
	nyZ6HAx8b1QrkHIb941+SoOaDY+YOwUmQj5E5qW+SB8lPslwjzqqqkObKbJP+JgqOOKPQkltSlN
	yVXPaaewYKTZTkG+xgZUhz7fIfsNKIWWtYD3d/XSUQIcGDjR8aSPoZqbGzFJtH/PnAYo
X-Received: by 2002:a05:690c:39c:b0:794:215:d575 with SMTP id
 00721157ae682-7947ac7f244mr49861737b3.56.1769627163403; Wed, 28 Jan 2026
 11:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com>
 <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com>
 <188EF863C74CB2B9.4042470@lists.openembedded.org> <CAOU5ZMvLpHs6ETo847GR2=N7iL8qPxwjuo15aLWpehpmpsucrQ@mail.gmail.com>
 <CANNYZj976uHS__6bsfjeYYpL-d4NqtkRitEyx3g8FvWHVT2GgQ@mail.gmail.com>
In-Reply-To: <CANNYZj976uHS__6bsfjeYYpL-d4NqtkRitEyx3g8FvWHVT2GgQ@mail.gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 28 Jan 2026 13:05:51 -0600
X-Gm-Features: AZwV_QgHUz_BuWYpVQykI910L2G3GAhLz32BLPg0MinU8k7OzG-8yudiP3EGxz4
Message-ID: <CAOU5ZMsjxJ3cxwo441hR3bvm9Ro9+EPzqZhoq5cwaDnG1bWyig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, 
	jonas@limonsoftware.com
Content-Type: multipart/alternative; boundary="00000000000075b3f90649776ea6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 19:06:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18925

--00000000000075b3f90649776ea6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:42=E2=80=AFPM Alexander Kanavin <alex.kanavin@gm=
ail.com>
wrote:

> On Wed, 28 Jan 2026 at 19:30, Anibal Limon <anibal@limonsoftware.com>
> wrote:
> > - setup project with bitbake-setup
> > - add meta-freescale layer to the config
> > - setup project with bitbake-setup (fine)
> > - checkout previous revision  without meta-freescale
> > - setup project with bitbake-setup (break)
>
> I'm sorry but now I don't understand. Are you setting up the project
> twice from two different configurations? Why does the second one break
> if it doesn't even have meta-freescale?
>

Sending v2, the case is when removing a layer from the configuration and
calling bitbake-setup again, on the
same directory.

Anibal


>
> Alex
>

--00000000000075b3f90649776ea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28,=
 2026 at 12:42=E2=80=AFPM Alexander Kanavin &lt;<a href=3D"mailto:alex.kana=
vin@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, 28 Jan 2026 at 19:30, Anibal L=
imon &lt;<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">anib=
al@limonsoftware.com</a>&gt; wrote:<br>
&gt; - setup project with bitbake-setup<br>
&gt; - add meta-freescale layer to the config<br>
&gt; - setup project with bitbake-setup (fine)<br>
&gt; - checkout previous revision=C2=A0 without meta-freescale<br>
&gt; - setup project with bitbake-setup (break)<br>
<br>
I&#39;m sorry but now I don&#39;t understand. Are you setting up the projec=
t<br>
twice from two different configurations? Why does the second one break<br>
if it doesn&#39;t even have meta-freescale?<br></blockquote><div><br></div>=
<div>Sending v2, the case is when removing a layer from the configuration a=
nd calling bitbake-setup again,=C2=A0on the</div><div>same directory.</div>=
<div><br></div><div>Anibal</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div>

--00000000000075b3f90649776ea6--

