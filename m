Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE484C3DA7D
	for <webhook@archiver.kernel.org>; Sun,  1 Jan 2023 16:55:55 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.14929.1672592147139108363
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jan 2023 08:55:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=D4B3aLd5;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: kergoth@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id b2so27062383pld.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Jan 2023 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:references:in-reply-to:message-id:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkRrNV0+JZ1YMaWTKwl408KPgO4oI2chzUifSagi8gc=;
        b=D4B3aLd57/V1iGzxtvk0G97GlmJdD1ZXXwvKVAVBKGJPgTmc/BXCIFwoNK0eq/Ldq0
         Hw/I9Ra77+TLklnxdquxlEGhFzd/Hx5QlQUzLMxRybDPKg2pTAmBVBIlinZlwMPbpLI/
         Bn+2h8dykpwo6cFf+elddWv+jE+5JVNTY0Lird/g3TEyxrWsVepXLu3q7QzcS4FGYHn1
         rDS8ABlMY9xSELBB+Bjxx9Cuu+uTTNj4fbrkfuELsCHdmtEUAKStCGxnj4f0eOSHTdHO
         cq8w+LAIp2VJXN49R7mDlSQrMUfobowGSBVwznsjlx0WfOvQfyNRk8JcRbZGV2nKdfsV
         Dn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:subject:references:in-reply-to:message-id:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkRrNV0+JZ1YMaWTKwl408KPgO4oI2chzUifSagi8gc=;
        b=swjhp5dqQ29E/S8aKUoiPIBfK/f/cvsMNcWNDBXEiNalXRIofLCKMnjZdXfPg0c7kY
         u5lcXbANjA2Zplpp8B9/bGvF+vVa1Z+6zqH2gGvU7mRKhE/m/SBFY4vzK7LakxrE2NZM
         xs/FT+pV02jXobDC12ydNmQ1Xi33Pk+Pb1vOMAY3qaNCNIpaejucTOZuOgUEvvmO08qy
         xle+AJTNr+c6jfT1QTjkShVIycgw9S5QZbOF02vrYb3cVKYqfkip31HLo0/UCELOLW9l
         oP2A+hbLdEWoM20PTbh3NNiQ9rjcwwMJT8EG1T2izr9FHjgwX5OTJ97gCXIn7cxJHSDx
         uzgw==
X-Gm-Message-State: AFqh2koMweoeVrzq7BxJqnIVmahScT1sLupg3rJztwP/q0eR23ZoS41A
	dAznXYhQRs9Ms5BJBYSZusDm1ThOfuNsIA==
X-Google-Smtp-Source: AMrXdXttdjQXqeNq8Om941XVEMHiV2jMVSNEGpneRox8rfnEv9uX+LY/XFYm2QlGVdBgssfU0owHEg==
X-Received: by 2002:a17:902:9687:b0:192:9ab2:fd1c with SMTP id n7-20020a170902968700b001929ab2fd1cmr13969477plp.26.1672592145964;
        Sun, 01 Jan 2023 08:55:45 -0800 (PST)
Received: from [2600:8800:6cc0:300:e89c:ae46:f87f:0] ([2600:8800:6cc0:300::1011])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00188c04258c9sm18419723plg.52.2023.01.01.08.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jan 2023 08:55:45 -0800 (PST)
Date: Sun, 1 Jan 2023 09:55:30 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Message-ID: <59224516-17d8-4c43-9f2b-38c5034cfdba@Spark>
In-Reply-To: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
References: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Fix cache/reparsing
 issue
X-Readdle-Message-ID: 59224516-17d8-4c43-9f2b-38c5034cfdba@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="63b1bb0f_643c9869_77bd"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Jan 2023 16:55:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14274

--63b1bb0f_643c9869_77bd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Jan 1, 2023 at 7:25 AM -0700, Richard Purdie <richard.purdie=40linuxfo=
undation.org>, wrote:
> When setting the LAYERSERIES=5FCOMPAT and LAYERSERIES=5FCORENAMES varia=
bles,
> we need to be deterministic. The random ordering from the sets was caus=
ing
> unexpected reparses.
>
> Signed-off-by: Richard Purdie <richard.purdie=40linuxfoundation.org>
> ---
> lib/bb/cookerdata.py =7C 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index b4e0c4216b..8198f509e2 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> =40=40 -425,7 +425,7 =40=40 class CookerDataBuilder(object):
> data.delVar('LAYERDIR=5FRE')
> data.delVar('LAYERDIR')
> for c in compat=5Fentries:
> - data.setVar(=22LAYERSERIES=5FCOMPAT=5F%s=22 % c, compat=5Fentries=5Bc=
=5D)
> + data.setVar(=22LAYERSERIES=5FCOMPAT=5F%s=22 % c, sorted(compat=5Fentr=
ies=5Bc=5D))

Missed a =E2=80=9C =E2=80=9C.join() here, it=E2=80=99s currently setting =
the variable to a generator object, afaik :)

--63b1bb0f_643c9869_77bd
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Jan 1, 2023 at 7:25 AM -0700, Richard Purdie &lt=
;richard.purdie=40linuxfoundation.org&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 5px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>When setting the LAYERSERIES=5FCOMPAT and LAYERSERIES=5FCORENAMES variab=
les,<br />
we need to be deterministic. The random ordering from the sets was causin=
g<br />
unexpected reparses.<br />
<br />
Signed-off-by: Richard Purdie &lt;richard.purdie=40linuxfoundation.org&gt=
;<br />
---<br />
lib/bb/cookerdata.py =7C 4 ++--<br />
1 file changed, 2 insertions(+), 2 deletions(-)<br />
<br />
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py<br />
index b4e0c4216b..8198f509e2 100644<br />
--- a/lib/bb/cookerdata.py<br />
+++ b/lib/bb/cookerdata.py<br />
=40=40 -425,7 +425,7 =40=40 class CookerDataBuilder(object):<br />
data.delVar('LAYERDIR=5FRE')<br />
data.delVar('LAYERDIR')<br />
for c in compat=5Fentries:<br />
- data.setVar(=22LAYERSERIES=5FCOMPAT=5F%s=22 % c, compat=5Fentries=5Bc=5D=
)<br />
+ data.setVar(=22LAYERSERIES=5FCOMPAT=5F%s=22 % c, sorted(compat=5Fentrie=
s=5Bc=5D))</blockquote>
<div dir=3D=22auto=22><br />
Missed a =E2=80=9C =E2=80=9C.join() here, it=E2=80=99s currently setting =
the variable to a generator object, afaik :)</div>
</div>
</body>
</html>

--63b1bb0f_643c9869_77bd--


