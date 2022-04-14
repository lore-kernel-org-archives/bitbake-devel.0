Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A17C4321E
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 19:26:44 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web09.770.1649960492260126401
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 11:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VPa3eZ3E;
 spf=pass (domain: gmail.com, ip: 209.85.218.49,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id s18so11704372ejr.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/W62PxyFCXvwix4x+hh3alaugjwYJGJlup5fJFNqTXc=;
        b=VPa3eZ3EMr3n6DTeWJ7MhYYnTl1haooUHPsXrlv94hw/Ke5Zg9+d9tp0bAtKmH+cP0
         dCmyTdu5Tg13VyYxx9L8bK0i9gG/KNMFDwJ17xX3iCpsUMj93TBmgmMCEqPA+gIBY5ru
         J4magQfjqlWXcez9nGZJrw27a1norZsOZ7/JapsroMUp6cwz/o0yBjLqO6FBdl7aY3Ia
         hIGkndIVJf5cojQ0Cf9eN+GCkQdciM/r8Mai5SzgtKSMMcYUEhgdS9vLwYj1d/SqY/fJ
         YjQRLEYyNbLoLiaJew8rX+5kks47w4OG4nB+CmcHPYlOe+rK77RzFiw8tt7W9arFoM38
         0x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/W62PxyFCXvwix4x+hh3alaugjwYJGJlup5fJFNqTXc=;
        b=uX2rr2CxNHKpdhPeqep7ZXpoy9LpgiUWHKxBa9m2r8iOID2JxyjptOXD93OYjiCHw/
         YAM++XKVsCtKKKSW2hH3rDLB82U5rsDUZQzC6Rbv8y82WKBSJS8JJCiYfDz4pO1Gzf+K
         MhoIZ4j1Df8wqtPv+AsPovzTDVrNFbsap6IeLoTHxUQfb+1u7HTKHDXxbuQBHh13sZUE
         HQ8R3wIjXoF+ZTaFiiT7wjgq196cJNYEUI9UrWsq6wIiF412nU87oo3KImBMyojXJYdr
         QusXvqs6KHn0DW76o+9Knx0ypyae5XKQPdRY7cMCAwTPGRqDaDMXyUM+3Kgu+IyOWbHP
         UCgg==
X-Gm-Message-State: AOAM533Wh8HOk4z7Kue/cImqibn+V4jWooc+cMlykcgNdAcJBMqwqIay
	3RNjkDSzbAAMxBtPthad854=
X-Google-Smtp-Source: 
 ABdhPJwBOoaqWhEEFEkhuWa+LLIKG7ufekgokGRg1nA3TIJRDm7bt20ZHrZTqjDhTTLz81wV77Jciw==
X-Received: by 2002:a17:907:720e:b0:6e8:bf62:baea with SMTP id
 dr14-20020a170907720e00b006e8bf62baeamr3392897ejc.121.1649960490584;
        Thu, 14 Apr 2022 11:21:30 -0700 (PDT)
Received: from smtpclient.apple
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 r3-20020aa7cb83000000b0041b573e2654sm1352837edt.94.2022.04.14.11.21.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 11:21:30 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Message-Id: <9418ABBB-4F3C-4062-860A-53068272E18A@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_75405AE1-F071-409E-82AB-D0F977DFA319"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Date: Thu, 14 Apr 2022 20:21:29 +0200
In-Reply-To: <20220414170846.55417ac0@melee>
Cc: bitbake-devel@lists.openembedded.org
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
 <20220414170846.55417ac0@melee>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 19:26:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13623


--Apple-Mail=_75405AE1-F071-409E-82AB-D0F977DFA319
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Dear Lica,

Thanks for the clarification! Phew, if only there was a repository where =
I could open a merge request just as I=E2=80=99m used to=E2=80=A6 ;)

Anyway, so just for me to get this right in the future: There is one =
repository named poky (https://git.yoctoproject.org/poky =
<https://git.yoctoproject.org/poky>). If I patch something in the =
bitbake subdirectory, I send that patch to bitbake-devel. If I patch =
something in the any other subdirectory I send a patch to =
openembedded-core?
Is there a place where all that info is aggregated like a table with =
left column repo/directory and right column mailing list?

Thanks for your hints in advance!

Marius





> On 14. Apr 2022, at 17:08, Luca Ceresoli <luca.ceresoli@bootlin.com> =
wrote:
>=20
> Hi Marius,
>=20
> Il giorno Thu, 14 Apr 2022 13:40:09 +0200
> "Marius Kriegerowski" <marius.kriegerowski@gmail.com> ha scritto:
>=20
>> Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
>> ---
>> scripts/lib/scriptutils.py | 23 +++++++++++++++--------
>=20
> This file does not exist in bitbake. This is why it does not apply.
>=20
> I think this patch is against oe-core, so you should send it to
> openembedded-core@lists.openembedded.org instead.
>=20
> Best regards
> --=20
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


--Apple-Mail=_75405AE1-F071-409E-82AB-D0F977DFA319
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Dear =
Lica,<div class=3D""><br class=3D""><div class=3D"">Thanks for the =
clarification! Phew, if only there was a repository where I could open a =
merge request just as I=E2=80=99m used to=E2=80=A6 ;)<div class=3D""><br =
class=3D""></div><div class=3D"">Anyway, so just for me to get this =
right in the future: There is one repository named poky (<a =
href=3D"https://git.yoctoproject.org/poky" =
class=3D"">https://git.yoctoproject.org/poky</a>). If I patch something =
in the bitbake subdirectory, I send that patch to bitbake-devel. If I =
patch something in the any other subdirectory I send a patch to =
openembedded-core?</div><div class=3D"">Is there a place where all that =
info is aggregated like a table with left column repo/directory and =
right column mailing list?</div><div class=3D""><br class=3D""></div><div =
class=3D"">Thanks for your hints in advance!</div><div class=3D""><br =
class=3D""></div><div class=3D"">Marius</div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 14. Apr 2022, at 17:08, Luca Ceresoli &lt;<a =
href=3D"mailto:luca.ceresoli@bootlin.com" =
class=3D"">luca.ceresoli@bootlin.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">Hi =
Marius,<br class=3D""><br class=3D"">Il giorno Thu, 14 Apr 2022 13:40:09 =
+0200<br class=3D"">"Marius Kriegerowski" &lt;<a =
href=3D"mailto:marius.kriegerowski@gmail.com" =
class=3D"">marius.kriegerowski@gmail.com</a>&gt; ha scritto:<br =
class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">Signed-off-by: Marius Kriegerowski &lt;<a =
href=3D"mailto:marius.kriegerowski@gmail.com" =
class=3D"">marius.kriegerowski@gmail.com</a>&gt;<br class=3D"">---<br =
class=3D""> scripts/lib/scriptutils.py | 23 +++++++++++++++--------<br =
class=3D""></blockquote><br class=3D"">This file does not exist in =
bitbake. This is why it does not apply.<br class=3D""><br class=3D"">I =
think this patch is against oe-core, so you should send it to<br =
class=3D""><a href=3D"mailto:openembedded-core@lists.openembedded.org" =
class=3D"">openembedded-core@lists.openembedded.org</a> instead.<br =
class=3D""><br class=3D"">Best regards<br class=3D"">-- <br =
class=3D"">Luca Ceresoli, Bootlin<br class=3D"">Embedded Linux and =
Kernel engineering<br class=3D""><a href=3D"https://bootlin.com" =
class=3D"">https://bootlin.com</a><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></div></div></body></html>=

--Apple-Mail=_75405AE1-F071-409E-82AB-D0F977DFA319--

