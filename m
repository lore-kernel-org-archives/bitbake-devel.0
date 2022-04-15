Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67AAC71137
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:03 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.6148.1650022889170188703
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 04:41:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=L4ZUVuv1;
 spf=pass (domain: gmail.com, ip: 209.85.208.43,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id z99so9657109ede.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+6YPgPwTvEpt4h8reyrNZrGDLgF790TvwKgMyDH2SOc=;
        b=L4ZUVuv1O3Q5ytZr3N5JOFSwYzCWO8oWBc4UtZCHYrlByWRTJ/4h8YQuRuWRLalHTq
         mLO8C07jrdL7xaMPe+MnB+ATRXMOJtWumJhSJ0XD4bEA/TJbRnvOA1WgYygEduoAcQGJ
         XKmqdQIlTeKgPCwLMesb4PbE1VVKF4G5r05y6ei3MV5xAeXPqkUnaAFN8RIzozOrXGwW
         teajYJWVTigTAqdCNsMGrgf4cEa9c3S3tdxldAu2yvyLFTiACbndGAu6mIaoB9WmCBAf
         GHhp901E3DkUx28BHZ70JR7/PwBTzMO8kgqLIuNOmFyBswq0Wxg1Dikp15WEugimn44Z
         zXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+6YPgPwTvEpt4h8reyrNZrGDLgF790TvwKgMyDH2SOc=;
        b=SH53NYEFcW+XFp7n9d0NVx9mc8/WHqb3qOl4AVARLntNHreuj4Wd8r+zcCyEDa7dPB
         1XzjgyQJOT9Ns57En/cdD7XOfJtkHDrGHNUD8FxACQWV3CTdKkUrGtMB/Bfkcz19smZD
         JPVPrj3K/Ey0MW0beThFPKR0JW2H69qiP5kRX4s4nzM2Ota1CrLRpZ5A5C4rgytQjqCP
         HBgvbWEVxN5xDUovcVU+VbryRAM3PWGTeFyZKi2khj6VkcFga1W8PIPXD5LdLOIG5liz
         ctq/e5bg8jWT5V2IEAuuybUvsEVJnWteokzzIRQiCSb0SB91VCgFKfyDVR67i2vTHSYr
         nyYQ==
X-Gm-Message-State: AOAM531d4QA8b8HxOkb0nxk8+0ESJpHc9X0WY3mGtrqjKmJ/oIeTL6Bm
	ZkQSzop9raOu/5s9PhqXTdY=
X-Google-Smtp-Source: 
 ABdhPJyqGrOdKl6t+S/ZDmQqkdUufbLA7FIaTnSpCvwPA21bKJR9L5jOya9Iu7aSDhS0A5gl2qDrYg==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr7738788ede.218.1650022887478;
        Fri, 15 Apr 2022 04:41:27 -0700 (PDT)
Received: from smtpclient.apple
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 m3-20020a17090679c300b006cf9ce53354sm1611779ejo.190.2022.04.15.04.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 04:41:25 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Message-Id: <86C9216C-B730-4C31-9858-0B8D13C55530@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_2D1705E2-589B-4D56-9880-80A0AC1C4C4E"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Date: Fri, 15 Apr 2022 13:41:23 +0200
In-Reply-To: <21a09c414ff08dcb87f1b5a2c127069e9aacfe45.camel@intel.com>
Cc: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
To: "Mittal, Anuj" <anuj.mittal@intel.com>
References: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
 <20220414170846.55417ac0@melee>
 <9418ABBB-4F3C-4062-860A-53068272E18A@gmail.com>
 <21a09c414ff08dcb87f1b5a2c127069e9aacfe45.camel@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13632


--Apple-Mail=_2D1705E2-589B-4D56-9880-80A0AC1C4C4E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Dear Anuj,

Thanks! That helped. I went through this document =
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded =
<https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded>

But I think the document you sent, especially the =E2=80=9CWhere to Send =
Patches=E2=80=9D is way more explicit and straight forward to follow =
than the =E2=80=9CSubscribe to the mailing list=E2=80=9D section. I =
think it would be helpful especially for first committers to either have =
that linked or integrated into the =E2=80=9CHow to submit a patch to =
OpenEmbedded=E2=80=9D document.

Best regards

Marius


PS.: @Luca, sorry for the typo in your name in my last email :)

> On 15. Apr 2022, at 07:00, Mittal, Anuj <anuj.mittal@intel.com> wrote:
>=20
> On Thu, 2022-04-14 at 20:21 +0200, Marius Kriegerowski wrote:
>>=20
>> Thanks for the clarification! Phew, if only there was a repository
>> where I could open a merge request just as I=E2=80=99m used to=E2=80=A6=
 ;)
>>=20
>> Anyway, so just for me to get this right in the future: There is one
>> repository named poky (https://git.yoctoproject.org/poky). If I patch
>> something in the bitbake subdirectory, I send that patch to bitbake-
>> devel. If I patch something in the any other subdirectory I send a
>> patch to openembedded-core?
>> Is there a place where all that info is aggregated like a table with
>> left column repo/directory and right column mailing list?
>=20
> Its explained here:
>=20
> https://git.yoctoproject.org/poky/tree/meta-poky/README.poky.md
>=20
> Thanks,
>=20
> Anuj
>=20


--Apple-Mail=_2D1705E2-589B-4D56-9880-80A0AC1C4C4E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Dear =
Anuj,<div class=3D""><br class=3D""></div><div class=3D"">Thanks! That =
helped. I went through this document <a =
href=3D"https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmb=
edded" =
class=3D"">https://www.openembedded.org/wiki/How_to_submit_a_patch_to_Open=
Embedded</a></div><div class=3D""><br class=3D""></div><div class=3D"">But=
 I think the document you sent, especially the =E2=80=9CWhere to Send =
Patches=E2=80=9D is way more explicit and straight forward to follow =
than the =E2=80=9CSubscribe to the mailing list=E2=80=9D section. I =
think it would be helpful especially for first committers to either have =
that linked or integrated into the =E2=80=9CHow to submit a patch to =
OpenEmbedded=E2=80=9D document.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Best regards</div><div class=3D""><br =
class=3D""></div><div class=3D"">Marius</div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div class=3D"">PS.:=
 @Luca, sorry for the typo in your name in my last email :)</div><div =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 15. Apr 2022, at 07:00, Mittal, Anuj &lt;<a =
href=3D"mailto:anuj.mittal@intel.com" =
class=3D"">anuj.mittal@intel.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">On =
Thu, 2022-04-14 at 20:21 +0200, Marius Kriegerowski wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Thanks =
for the clarification! Phew, if only there was a repository<br =
class=3D"">where I could open a merge request just as I=E2=80=99m used =
to=E2=80=A6 ;)<br class=3D""><br class=3D"">Anyway, so just for me to =
get this right in the future: There is one<br class=3D"">repository =
named poky (<a href=3D"https://git.yoctoproject.org/poky" =
class=3D"">https://git.yoctoproject.org/poky</a>). If I patch<br =
class=3D"">something in the bitbake subdirectory, I send that patch to =
bitbake-<br class=3D"">devel. If I patch something in the any other =
subdirectory I send a<br class=3D"">patch to openembedded-core?<br =
class=3D"">Is there a place where all that info is aggregated like a =
table with<br class=3D"">left column repo/directory and right column =
mailing list?<br class=3D""></blockquote><br class=3D"">Its explained =
here:<br class=3D""><br class=3D""><a =
href=3D"https://git.yoctoproject.org/poky/tree/meta-poky/README.poky.md" =
class=3D"">https://git.yoctoproject.org/poky/tree/meta-poky/README.poky.md=
</a><br class=3D""><br class=3D"">Thanks,<br class=3D""><br =
class=3D"">Anuj<br class=3D""><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_2D1705E2-589B-4D56-9880-80A0AC1C4C4E--

