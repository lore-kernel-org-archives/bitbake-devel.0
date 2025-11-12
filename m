Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F6CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:24:24 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8664.1762935854623424738
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 00:24:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=naC1bdHU;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8823dfa84c5so6041256d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762935854; x=1763540654; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=040cOe+myzsIXyDxID6UtgJbw5SaQGj12PQtdoMddBo=;
        b=naC1bdHUB6+V9FAuyIwMn8BbWgvY6is7cKxSOm1vYgFxb9NV84iDmLxRK324hhC7uj
         fYv2tGPC2lqwMiIzCanShsmAJ0uBqYsyDgmGmmXAPVLHeRC0WrTxFLJdUwbD8JNg7sLV
         fKr9cNBtb5UvBKtRTdnR9yZHN006TNUmtpM3rOGUn+sc0zjkAdL9ptu7D37c/rRvfctC
         zGqlaJiitkKD18wQS/wbuS4vGoUMRpBOnjJcWBNSXqpyokcgD06zXX1b8lklRElmr3f1
         /CTppT+BFXCf1bBtzDu3KNV7DX7lqR9YjNFw41GzFJJHyPN2MQNbUGo5LtQkRkCB8HJQ
         Cfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762935854; x=1763540654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=040cOe+myzsIXyDxID6UtgJbw5SaQGj12PQtdoMddBo=;
        b=MuBWZpQ39XRY6xhgcNIuASHUz6xXLl+Ih39ueZJ/p6tR8OKqKQnSGXVhSdGeTxEYEO
         A1JUQIeJU45bY7YChvWADFqDSqi8FNaIW0X+i4mjuVqqjVds8DUWSx4+BmhZ8KZ+qz4H
         sLxkiZ2r9OKza0RZGC2UPeJDgzEEtYq4cScokIds7Gwtmjqa7VG1r36/QJcVOForY8Sc
         pzfiQZZUphrMkQP9jDDmcycAjFix3aaApwLxUZclgL2AvffyAOAHYWP2bCOaVUdjBD2a
         yJC4jhRISKqeonvOtDV9ALwWzWZLxcIKol3wEYBSw+mlVAxIvrbndIqFsltouQ7ovHbV
         DJOQ==
X-Gm-Message-State: AOJu0Yy1i9OBM1D6RZ5xRUitsCZSvvkIXGpmMbU6Tvg+lsXW+uyoA1Wu
	ifu/ZVvIRqL8XTTYocf33l9M/wOD9KZ0iOeIQyJEGxS/OhuVpoYAzNczFVeVGwgtnpjMHJ4HdB8
	agFRXsC3vc6psdq7hidrWY0cJtKyudLg=
X-Gm-Gg: ASbGncsuoQrpSeMcjijlB09yEnBmiQ97dvFqjIG8lhMirXUiWHUDExuWUPgDLQZbwPB
	MDkvhgkbvY5vqoLJryiAl73486AsBAxXD9ZlUVwpd1Kj6IJm6uXeJ9tNm5izRLD2iVWcGJrgv9S
	QoPlaG24OpsuR4kvwrOHiMseTuPj0GBYDkd8LnCzpzgSxki4911fFo+GEaEV+UnQ+7W6+l9kSN/
	+N1RRE79n0VA7CjJU0bdcDJ+o/QykrNkgKKkJenEYDS8h+P128pzS/2EABxoHbqfq4ANskKm1TT
	O/YATWjqSOsMCT1LWHPP2zixgrOc
X-Google-Smtp-Source: AGHT+IHCeKM1Y+25HZ1tWMWq9s+FsAgFLE+eKN8n+QhoTf3hoz+muJcO9D4GnRDoB9zV7Znh6v0SAXDrWiE2iFH/XTQ=
X-Received: by 2002:a05:6214:2244:b0:880:460a:96ce with SMTP id
 6a1803df08f44-88271a3c033mr31933326d6.63.1762935853583; Wed, 12 Nov 2025
 00:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
 <20251111223325.2034322-3-adrian.freihofer@siemens.com> <CANNYZj-msfr_qFD_3UNTB2BCm_Vqr25cuOfPn9=0yNo0jzYjEg@mail.gmail.com>
 <AS1PR10MB5724943BCBB7E6AF8B5923D88ECCA@AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB5724943BCBB7E6AF8B5923D88ECCA@AS1PR10MB5724.EURPRD10.PROD.OUTLOOK.COM>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Nov 2025 09:24:02 +0100
X-Gm-Features: AWmQ_bnOB3_ypSYCjvWvLkxccZbLWWbasW04j2Y6xlnljNRgfHFR2ypE1SzTuRU
Message-ID: <CANNYZj8BtageRSAV96x-UQmgyozwZ=fpXswkwMs8skq7+B-fRg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] bitbake-setup: default top-dir to
 empty string
To: "Freihofer, Adrian" <adrian.freihofer@siemens.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000005090920643617d94"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:24:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18347

--0000000000005090920643617d94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You don=E2=80=99t create a top dir, you create only the prefix for it and t=
hen run
=E2=80=98init=E2=80=99 from it. Think of it as unpacking a tarball. This al=
lows running
init without having to create a top dir at all, and it would still do the
right thing by default.

If you prefer that top dir is the current dir, and not just the prefix, you
can tweak the settings but I maintain that should not be default for all.

Alex

On Wed 12. Nov 2025 at 9.05, Freihofer, Adrian <adrian.freihofer@siemens.co=
m>
wrote:

> Hi Alex
>
> The workflow looks like this:
>
>   mkdir top-dir
>   cd top-dir
>   bitbake-setup init
>
> If top-dir is created by bitbake-setup, we get one useless level of
> directories.
>
> We could argue that it must be used like that:
>
>   mkdir top-dir
>   bitbake-setup --top-dir=3Dtop-dir
>
> But that's not what I would expect or prefer to type.
>
>
> Maybe the logic should be:
>   top-dir-prefix=3D""
>   top-dir=3D.
> ?
>
> Regards,
> Adrian
>

--0000000000005090920643617d94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You don=E2=80=99t create a top dir, you create only the p=
refix for it and then run =E2=80=98init=E2=80=99 from it. Think of it as un=
packing a tarball. This allows running init without having to create a top =
dir at all, and it would still do the right thing by default.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">If you prefer that top dir is the cur=
rent dir, and not just the prefix, you can tweak the settings but I maintai=
n that should not be default for all.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Alex=C2=A0</div><div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed 12. Nov 2025 at 9=
.05, Freihofer, Adrian &lt;<a href=3D"mailto:adrian.freihofer@siemens.com">=
adrian.freihofer@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">




<div dir=3D"ltr">
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Hi Alex</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
The workflow looks like this:</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 mkdir top-dir</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 cd top-dir</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 bitbake-setup init</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
If top-dir is created by bitbake-setup, we get one useless level of directo=
ries.</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
We could argue that it must be used like that:</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 mkdir top-dir</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 bitbake-setup --top-dir=3Dtop-dir</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
But that&#39;s not what I would expect or prefer to type.</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Maybe the logic should be:</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 top-dir-prefix=3D&quot;&quot;</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
=C2=A0 top-dir=3D.</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
?</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Regards,</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Adrian</div>
</div>

</blockquote></div></div>

--0000000000005090920643617d94--

