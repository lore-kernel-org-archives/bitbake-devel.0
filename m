Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBFAE9E2EB
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 11:46:46 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17199.1770810405117793091
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 03:46:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mDP9mhrz;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8e526081ceso124938766b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 03:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770810403; cv=none;
        d=google.com; s=arc-20240605;
        b=OPk58CkZ2pYdj+8HuwwgksmS6BVKCMH6sYKys9VMvMcP51gR2Rw3SQPP0RrBsDyrc8
         c9BJsC2KYQc+68CrRtJ/OvmE3QOnkO1BW9UznugPejpxfyYjAqOJHTuDP+bvUQfjxaxl
         7dn3dVx6uvRNEm5xWTLczOLHGvlO3v7mHuhZqBuBY58wnXiPF2wcuZ6YAKzt8Wm6QNme
         4D5oIHtJvaCbKv74itx2Q5AiwdNTh4YQ+zVwxDoAmQcgn6rx59ghHfdEItZu8DFpVuKd
         rQOUNusLFOXU6xOKRXcDrpPopVXuAhLSPR/HaOQak1hpwaZ1SgIVBojNecWJQrzYRFfr
         RoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FYSrmuW0lz39/67kv1qG2GV5cdHr+SiiOi8XNLrrdr4=;
        fh=mAMibwyv/oYlW/MV+mUJRTziaIeLO4wDMj5EHBE14SQ=;
        b=L2Se9sJop+4/2baDYIFCOoShZRn54Qd4OeCg9DWsC9oDk8c6YlhQ7jioBAGzJdgBYO
         B2qVmGIkgn4//XU+LTiWskgqP27lYvECOscUEjYDdp35FMRrqkDzlr1LS0EBxpIwmCsi
         HO831bqHu6VXMHj7RUN70qwfwpg5JQuanAl2pfOOOKXj1lav5zfCAJj1QMhx+NA8ri+j
         CizplSSEOPl82KH5VzqvVzgNcTN51HCgO6xDJsy0RzRbAIMvvKa1KeGgdZuZt7u4zbfL
         c+Tzrtw4PQSzCBm7bEbPyuFnTg0URgITPAaQD83Q+1FthfhTiIV8k8BvAaS2cQFdD76m
         W39w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770810403; x=1771415203; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FYSrmuW0lz39/67kv1qG2GV5cdHr+SiiOi8XNLrrdr4=;
        b=mDP9mhrzN1d8781EuMGXHTi5uTKaYfMrUrPyVdsnZP9opvsvpwvvGAtl9d9cjAs130
         /TP+ZN/qCEiRnKtBryxPY3us8PRn5Mnn+dB/CG6DefsHrDEwPw5QISoGDfD2KarTEZtf
         tAOUlXPzyAGv0sBVa+VSvbkapBJCNdXjEbZXMB2ppV5skvRlEsi/E8sUh1/eivfEjNh2
         qoG+dNk1ONRzhD5vcvGZikgr75R+KCF+qHb+UfyviYZ2K9vTNnaX4yZoJyEjV+vgftWf
         FbUbeTzGpegX992XJP7PQoY+OU9wtc7M7FZyDiAMQENTUBCmyS6suZMxcQY+d0nidwFN
         HTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770810403; x=1771415203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYSrmuW0lz39/67kv1qG2GV5cdHr+SiiOi8XNLrrdr4=;
        b=ChLpZK8CfvRYOL7AORtc9MJd6b9PGvP0zPrJTqXpiaULxpUME2qAhR0CAjn4dF9YAC
         pVKWlQ9OTR5KZFn4ipy82vYLv+HsG3cCh2Ey+XetrOpE8MoobRSkrnJATOX/5gvUtpeE
         7p4bLIiXoGuFWIjb51f9xYJMqBkp1y20CochJsQVxCJ2RnZxD4UTwGidFGhXgQLWZ5++
         Tjjed8G8mOSRlVe4UjR6KURaNuQru5F7oD+kbdtqSndQfsdpnVhzajGAmwtD8zdNO1nL
         qJwxNGmdiGUUVJ9guMTYnEnMBuxMQ7MgMnrRjwx7oEc20TZLi/wfOOWyPyoI9EO9iRMm
         Hq9Q==
X-Gm-Message-State: AOJu0Yy9pcTf5pJ87ONXVujPrRzAxiXhHqAl5pZhu+KlbOsJ+ghpSjCk
	PbbEsmr5efB6khX0qLZd7i7rGkkRjFOVNhohw04EMdiOa5NgOStnB6CYbqxLQYTPjshWUSJdFc1
	TsWZ9mcFfGFicIYMc38q5PtSTm38POZs=
X-Gm-Gg: AZuq6aLcvIHn8LJ57iu+MqWSgK0Ox60D9RLbaz61Zc6YEHAvMtRyeRWi48w016HjB18
	h9OmuG4xveMgxr0YKxiHInxQWvYIConRwLL94s0BMkgZTUr3ht9IXlVLGMXuVKti+lKT0fpwbCu
	ZS8AQ8TSOEC/Vm1vP2i3J4gfYHXO9oxCMUV/7sRVOJxH+UsbdxeeAuujIUdnr9MrrYpAPcOUrXH
	OUp5eIHNLdxMt7gu1HyqbqjV09L7h0d4ykxzhyqVd1YrFotiGR9pOU18CM5VTLR8g6XSOZo0pYD
	74AKM2mBHg==
X-Received: by 2002:a17:907:9281:b0:b88:504a:f386 with SMTP id
 a640c23a62f3a-b8f50bc354dmr293891566b.21.1770810403027; Wed, 11 Feb 2026
 03:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20260129120421.4413-1-alex.kanavin@gmail.com> <CANPvuR=3_qR3ZFbq_JArT0OjZ67jEh65jPM=zmjx9rktayq6yQ@mail.gmail.com>
 <CANNYZj9n=Y+S_0_FL3jaALiW1N4pytJ4sDD-_pUu0QqbDeAJ7A@mail.gmail.com>
In-Reply-To: <CANNYZj9n=Y+S_0_FL3jaALiW1N4pytJ4sDD-_pUu0QqbDeAJ7A@mail.gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 11 Feb 2026 11:46:31 +0000
X-Gm-Features: AZwV_QjdIdhiai7xlvir29OoWx60YRz_gV9g9dyev9sEoVI4TlVClZ-Gec3wSFs
Message-ID: <CANPvuR=34p9JPFndBC0yRFumR1diFag7a5SJPMD9kS+e_Bh+Dg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/2] cooker: use BB_HASHSERVE_DB_DIR
 for hash server database location
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000098164064a8aed72"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 11:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19001

--000000000000098164064a8aed72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexander Kanavin <alex.kanavin@gmail.com> escreveu (quarta, 11/02/2026
=C3=A0(s) 11:39):

> On Tue, 10 Feb 2026 at 16:36, Jose Quaresma <quaresma.jose@gmail.com>
> wrote:
> >> +                bb_hashserve_db_dir =3D
> self.data.getVar("BB_HASHSERVE_DB_DIR")
> >> +                if bb_hashserve_db_dir and
> utils.is_path_on_nfs(bb_hashserve_db_dir):
> >
> >
> > There is little issue on this, we should check if the
> bb_hashserve_db_dir exists on the file system first before checking the
> is_path_on_nfs.
> > Because is the user provide a path that does not exist and will be
> created bellow in os.makedirs it fails with:
> >
> > stat: cannot read file system information for '/path/to/my/hashserve':
> No such file or directory
>
> The patch has merged to master, can you make a followup please?
>
> Alex
>

Sure, I am still doing some tests and will propose a fix today or tomorrow.

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000098164064a8aed72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Alexander Kanav=
in &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>=
&gt; escreveu (quarta, 11/02/2026 =C3=A0(s) 11:39):<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 10 Feb 2026 at 16:36, Jose Quar=
esma &lt;<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank">quare=
sma.jose@gmail.com</a>&gt; wrote:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb_hashse=
rve_db_dir =3D self.data.getVar(&quot;BB_HASHSERVE_DB_DIR&quot;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if bb_has=
hserve_db_dir and utils.is_path_on_nfs(bb_hashserve_db_dir):<br>
&gt;<br>
&gt;<br>
&gt; There is little issue on this, we should check if the bb_hashserve_db_=
dir exists on the file system first before checking the is_path_on_nfs.<br>
&gt; Because is the user provide a path that does not exist and will be cre=
ated bellow in os.makedirs it fails with:<br>
&gt;<br>
&gt; stat: cannot read file system information for &#39;/path/to/my/hashser=
ve&#39;: No such file or directory<br>
<br>
The patch has merged to master, can you make a followup please?<br>
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><div>Sure, I am still doing=
 some tests and will propose a fix today or tomorrow.</div><div><br></div><=
span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quare=
sma</div></div></div></div>

--000000000000098164064a8aed72--

