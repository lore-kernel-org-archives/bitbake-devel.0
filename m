Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0F6C43217
	for <webhook@archiver.kernel.org>; Mon, 14 Nov 2022 16:47:40 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.7900.1668444453156669063
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Nov 2022 08:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Hc4J5WW1;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id c1so20231824lfi.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Nov 2022 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QbP/t7kgxLpLeYhxyrzoh7dljXmXm6gD1nzpRKiupzU=;
        b=Hc4J5WW1wsCEB+hm/NkscA5WiRQvdTQLIy4vrKk3luGAmblGhQvaM7gtW8zPMtB30m
         6h+w8uYRK5f/RhcOWB5cNFaVrbzUuYYQngRIlzt4K89Zy4JnB2rkZLWjzc0VUWCbiDfh
         mQDizvCnbo5SN/K7PCkIkycvOXywnZ6/ieHyVL7WCl/ap4hWrPu/BBp331GV9pFSt6QK
         vZrJXtLmKrJXF0YO4CjWbAF4KysSnxTCB3YPOX58yyWsKbFQIvojg1PDo1s0tG338bcO
         eKG835cGV6lzChblkZ7cb5gJD8vWiZD2zdN0yNniSgHDikEIuHLFQRw9IeJdDmMhwIA/
         Z5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbP/t7kgxLpLeYhxyrzoh7dljXmXm6gD1nzpRKiupzU=;
        b=dXklrTngS0DmgdENudPChp5d9C70QZNaZtzfzGpiIvkaVE1SrGUseh2hNhaFIoA/PY
         PdcWzXn3JnQlHVS+iyVD0I3KsLCabhX8GWeQ8Rkddqr44PGMYTSmMBS22n/wnjbH/qN7
         Rj8SdSgsEO6k4VWtwRfVgqmEL7/VLeTGqRMP51wjSW9Q5ErAoWEOqk2Yn069mO8pfOxL
         GZ8bc426c3SIKldrT+UJNMgr0IqB4sCXhyYS76oeydgvxeQ5Ru/2mM8nUfuYqwBlh2Rd
         NGAvT4bmKwJCAxFvcjeWQ4G++mcLkv1WErj++/0KIdL8qvR7wkys6ztI61Qv8eRvnOuZ
         8UUA==
X-Gm-Message-State: ANoB5plelVpJQJsMUf/AQSwgz/4JCVtOqgF0Vl0YtDPHX2LCWiIt4fQr
	/E6pMfImDn7mG6rp/piQVTKkriPJJf38sAnpAYE=
X-Google-Smtp-Source: AA0mqf5WwuquMPMgxErHn6xKHJ6YgJmSPYDvrxolPFRlmPrYQLNCkg38neYg/bIDNFklk3Rvo6MEcbykITzB8xc5gcY=
X-Received: by 2002:a05:6512:b82:b0:4a2:2af6:98e5 with SMTP id
 b2-20020a0565120b8200b004a22af698e5mr4302571lfv.5.1668444451002; Mon, 14 Nov
 2022 08:47:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLh1+LhxH8yuQprUntwjibAP_iuwF7tXnHjfhAZhLCCG-A@mail.gmail.com>
 <CAOuPNLgEs7Obni8kOqgznv_mLW8JQ4cF0CUS8jaV6AXEhw6aOg@mail.gmail.com>
In-Reply-To: <CAOuPNLgEs7Obni8kOqgznv_mLW8JQ4cF0CUS8jaV6AXEhw6aOg@mail.gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 14 Nov 2022 16:47:19 +0000
Message-ID: <CANPvuR=RT3YBSBmRHNtoeCMST2DJ3Wqq7fzh6jj2C1oxUxR0EA@mail.gmail.com>
Subject: Re: [linux-yocto] Removing DISTRO_FEATURES from a specific machine type
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: yocto@lists.yoctoproject.org, linux-yocto@lists.yoctoproject.org, 
	poky@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d45f1d05ed70fe75"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Nov 2022 16:47:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14083

--000000000000d45f1d05ed70fe75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pintu,

Pintu Agarwal <pintu.ping@gmail.com> escreveu no dia segunda, 14/11/2022
=C3=A0(s) 16:35:

> Hi,
>
> This question is related to Yocto Dunfell specifically.
>
> I have certain distro features defined (by default) in our distro
> include/conf file.
> These distro features are required for certain machines and should not
> be enabled for only one machine.
>

For such cases Yocto have the COMBINED_FEATURES that can be more apropriate
https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term-COM=
BINED_FEATURES

But if the future is only used in some machine maybe the MACHINE_FEATURES
is more apropriate
https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term-MAC=
HINE_FEATURES

In a perfect world the the DISTRO_FEATURES should be independent of the
bsp/machine used
https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term-DIS=
TRO_FEATURES

Jose

For example, we have a distro feature such as "nand-squashfs".
> So, in our distro.inc file we are including like this:
> DISTRO_FEATURES_append =3D " nand-squashfs"
>
> Since this distro.inc file is shared across 2-3 machines, this feature
> will be available to all.
> But we don't want to include it in the "xyz" machine.
>
> So, can I do like this:
> DISTRO_FEATURES_append =3D " nand-squashfs"
> DISTRO_FEATURES_remove_xyz =3D " nand-squashfs"
>
> If there is some other better way please suggest.
>
> Thanks,
> Pintu
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#11882):
> https://lists.yoctoproject.org/g/linux-yocto/message/11882
> Mute This Topic: https://lists.yoctoproject.org/mt/95020630/5052612
> Group Owner: linux-yocto+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/linux-yocto/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000d45f1d05ed70fe75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Pintu,</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">Pintu Agarwal &lt;<a href=
=3D"mailto:pintu.ping@gmail.com">pintu.ping@gmail.com</a>&gt; escreveu no d=
ia segunda, 14/11/2022 =C3=A0(s) 16:35:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hi,<br>
<br>
This question is related to Yocto Dunfell specifically.<br>
<br>
I have certain distro features defined (by default) in our distro<br>
include/conf file.<br>
These distro features are required for certain machines and should not<br>
be enabled for only one machine.<br></blockquote><div><br>For such cases Yo=
cto have the COMBINED_FEATURES that can be more apropriate<br><a href=3D"ht=
tps://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term-COMBI=
NED_FEATURES">https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables=
.html#term-COMBINED_FEATURES</a><br><br>But if the future is only used in s=
ome machine maybe the=C2=A0MACHINE_FEATURES is more apropriate<br><a href=
=3D"https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term=
-MACHINE_FEATURES">https://docs.yoctoproject.org/3.1.20/ref-manual/ref-vari=
ables.html#term-MACHINE_FEATURES</a><br><br>In a perfect world the the DIST=
RO_FEATURES=C2=A0should be independent of the bsp/machine used<br><a href=
=3D"https://docs.yoctoproject.org/3.1.20/ref-manual/ref-variables.html#term=
-DISTRO_FEATURES">https://docs.yoctoproject.org/3.1.20/ref-manual/ref-varia=
bles.html#term-DISTRO_FEATURES</a><br><br>Jose</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
For example, we have a distro feature such as &quot;nand-squashfs&quot;.<br=
>
So, in our distro.inc file we are including like this:<br>
DISTRO_FEATURES_append =3D &quot; nand-squashfs&quot;<br>
<br>
Since this distro.inc file is shared across 2-3 machines, this feature<br>
will be available to all.<br>
But we don&#39;t want to include it in the &quot;xyz&quot; machine.<br>
<br>
So, can I do like this:<br>
DISTRO_FEATURES_append =3D &quot; nand-squashfs&quot;<br>
DISTRO_FEATURES_remove_xyz =3D &quot; nand-squashfs&quot;<br>
<br>
If there is some other better way please suggest.<br>
<br>
Thanks,<br>
Pintu<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#11882): <a href=3D"https://lists.yoctoproject.org/g/lin=
ux-yocto/message/11882" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/linux-yocto/message/11882</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/95020630/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/95020630/5052612</a><br>
Group Owner: <a href=3D"mailto:linux-yocto%2Bowner@lists.yoctoproject.org" =
target=3D"_blank">linux-yocto+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/linux-yocto/unsub"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/linu=
x-yocto/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_bl=
ank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--000000000000d45f1d05ed70fe75--

