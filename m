Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.web08.1089.1631029788153042509
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 08:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=e91AgY+M;
 spf=pass (domain: gmail.com, ip: 209.85.222.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f51.google.com with SMTP id t26so5781520uao.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wT8AaSadfv4/ALR00QzAaXZKsTXlm/oSB3CBC3yRPkw=;
        b=e91AgY+Mjv0ztMzngoQ5falCt5BYxOWWY5NI0X+VXbyG1H9FmT4cPMF9gOxAEtFEu5
         yfEcjS6sHE/Y9Q9pe/qVloHi7O/4Lyk4IoDchJpyQ3P+mvqd20ohZ6IKmUXKmbuiVcGz
         A25Exi7ggJ0R02leyig80X3WfktcdSp67eE69UcuJU7K7QuJJ6H5a9rWRbRy4vzuQVxA
         95RwmvM6+RHGGxm0feVqHcU68HXzM40Yw5gep5pRxlXc+vBlMfRCaRk6LmOTFAHgsElM
         6fL/VVasD2Op4HDj3wEFslcD9uzLb0BbGUxTGyz6y8b1DehRMmcs4SJXwHTRrzhmSoLY
         a8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT8AaSadfv4/ALR00QzAaXZKsTXlm/oSB3CBC3yRPkw=;
        b=qiDDzVyx2OSRqyTnO16eg8q0/CTUp4leZ9KVPCNrBCmp0ljaB4j0QAfM0erFoS3DwH
         NH1MtUTjXWKztk7eyhkgezKSfCRaKdYVDBbAmSgXk5pwQ13y/hq3EkigIiOaF/iBkwLV
         mIKeVtjb3a3IDerO0LZtqdMb2/q/NbONdB3DpzpPcbJvRbNvRyUhuCC5wDtCxjYWIMtw
         b3XPtQbR/vzjzs7k/waoBh1CqrlKResJ633hurUWRnMVgLuBJk5hFh3rQmIgMOnsvpwT
         wzEuE58z4tcSPZdl+/nK2xebwJOYNYfhy8XmVr/6Z4gMBMGbBBLY9SLdpOGrZLlJwvXC
         zfHA==
X-Gm-Message-State: AOAM531Q5aEvWLcrFE8SV1o7GUhSfkFfVLZWhDDti7ac+jjVmEbBjxtw
	42sQixCfzz9I/OzFE1IsYt+MJccs7CBFSMrRYDsGB0D3
X-Google-Smtp-Source: ABdhPJx6DI6RFPwFojY1HtFrq+bcvhqGghsVaTrY4tWuz97mJyeeT4+UnEhu+Ig1fHBnlQT2IPPEQbU/D2JUnbfHDZs=
X-Received: by 2002:ab0:6ec7:: with SMTP id c7mr9270809uav.93.1631029787275;
 Tue, 07 Sep 2021 08:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj8J0OSx4Ce+_xQ4jq24QnZxwJJ0eFNk1BUdt_xNrAuU2w@mail.gmail.com>
 <11311.1631028931620734107@lists.openembedded.org>
In-Reply-To: <11311.1631028931620734107@lists.openembedded.org>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Tue, 7 Sep 2021 17:49:36 +0200
Message-ID: <CANNYZj88WpKLuHORum8vMnhW6UVWqJMYLDM1vz-+MX3uu3Lh7w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000016b35e05cb69b738"

--00000000000016b35e05cb69b738
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Sept 2021 at 17:35, Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
wrote:

> >>So the question is why we have to modify also (a) to make (c) happy?
>
> >I still do not understand what the problem is. meta-clang does have a
> dunfell branch, that sets LAYERSERIES_COMPAT accordingly, why are you not
> using that?
>
> Please assume that we can't, if this would make it possible to finally
> answer my aforementioned question.
>

Sorry, not possible. If dunfell branch doesn't do what you need it to, the
correct solution is to send patches for the branch, or backport the needed
changes into your internal copy of that layer. But certainly not to start
mixing layer revisions from different releases and demand that this must be
supported and easy.

Alex

--00000000000016b35e05cb69b738
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 7 Sept 2021 at 17:35, Damian Wrobel &lt;<a href=3D"mailto:dw=
robel@ertelnet.rybnik.pl">dwrobel@ertelnet.rybnik.pl</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;&gt;So the question=
 is why we have to modify also (a) to make (c) happy?<br><br>&gt;I still do=
 not understand what the problem is. meta-clang does have a dunfell branch,=
 that sets LAYERSERIES_COMPAT accordingly, why are you not using that?<br><=
br>Please assume that we can&#39;t, if this would make it possible to final=
ly answer my aforementioned question.<br></blockquote></div><div class=3D"g=
mail_quote"><br></div><div class=3D"gmail_quote">Sorry, not possible. If du=
nfell branch doesn&#39;t do what you need it to, the correct solution is to=
 send patches for the branch, or backport the needed changes into your inte=
rnal copy of that layer. But certainly not to start mixing layer revisions =
from different releases and demand that this must be supported and easy.<br=
></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Alex=
<br></div></div>

--00000000000016b35e05cb69b738--
