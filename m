Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0FCCD184
	for <webhook@archiver.kernel.org>; Sun, 19 Oct 2025 21:06:41 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.4605.1760907996809150644
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Oct 2025 14:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=u/NitSrF;
 spf=pass (domain: smile.fr, ip: 209.85.221.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece1102998so3253268f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 Oct 2025 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760907994; x=1761512794; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB0EInyjiO+9Dq+NCr3ghZcy3kb6nHQlbyeqCFSAQA4=;
        b=u/NitSrFsDWWo42gKETMXVhhoyDT+m9awjJB+3irESlbM60S12vcRixks0ZDSq9Djz
         FukQSNq9j4ZNwihdkbZR4rlveDtl8iuF1tNcY6xsofr2HBrcKt7reIKYgi/9cd3witlx
         SxDp01oUmLeA5DDlCdYa4A9/bvO5+GPthUD/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760907994; x=1761512794;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB0EInyjiO+9Dq+NCr3ghZcy3kb6nHQlbyeqCFSAQA4=;
        b=jMypXUDE05VWSjEAS5Aqs6F1wxnPiz8I6zrZjzQ3ycAo0vr0GxzA4sRXUzToH273Nk
         fmLui2TEt2Cmw8p/T60JTcJVTuy9ESD1H859oRgvNg5Z6h9I10PzTY+WTyZGF/FjqmF1
         e9kBmFzOwggvJOeJ1mC3pE85kPv5rkH+FCad/3DRlg3fibnIaRISSldKKHH3cX2l0j8r
         +r5ajE135GM9tPBekNkzb0gZgCifHWSbJzyhcwgb74DJWXr/V2dWGxlmlak7zJXrU1u4
         CpjMvPeoX0BcehdGtOZD5q1TFSOheKQ4umUPxMgvKEyToN2jYsB4Z9ND5s095nL4aPWh
         xgrw==
X-Gm-Message-State: AOJu0YyNAXZlKmqtu8/oulsnQqCyYscOAAM1FPje+ll0rd96k41kmUa2
	HZhilWVf9be1+P7NHKiQEuKINty4cr1JPyfUjGvRF3ZNCB4hj2CgbekLw1eXeaVi7M/ZNuwCwcL
	qcl0B9vCGXS3QYa1sW26HeGq5PHQzZhPG6J8XtqHTij1ay1TDh5VW4aeg8Q==
X-Gm-Gg: ASbGnct39cxWBImbTCyY7LNqS3CVrdVnzVfUoRyckSkBnV8mW0PV7sA73+Zt46iAo/Q
	UxUQiNUl4A0dKVyEVlJh0MtLoLAI5f5t8SDmTLxG/tvMjtwQpCAdMRWvcgZuVhBiPiTb/dleYQn
	yFDTNWQvmj41TySoG03vnvnl5jg5H3QUWeWSQb9S5mx7g6cwiJtKUFeKN3QeBLd9AkbO3QaYw5e
	Qlq1IHe6vNBlVSRa3sYuGdkvl91fy3feSUs8JvJbzkpM63qNfCzw0riS5Hmu8eO5vyzdt/vEBPi
	/zNtaXwLW2DAFHmGslc=
X-Google-Smtp-Source: AGHT+IH3J8nhIW/dTdqNJt/ZKDVNr0Es0+LEFMj0z5Zro0SRH8msNH2KhPtZ0tlhUXzAE9dCqpmZsdlPLTN5fO3Yhy8=
X-Received: by 2002:a05:6000:22c3:b0:407:23f7:51 with SMTP id
 ffacd0b85a97d-42704d83118mr6699808f8f.1.1760907994218; Sun, 19 Oct 2025
 14:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251017231444.374436-1-yoann.congal@smile.fr>
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sun, 19 Oct 2025 23:06:08 +0200
X-Gm-Features: AS18NWD4PbGcT3tSWsRMT4biZ69shvQXZ6EeoYLDBnAuRXO_AP8LeY1uDLsrLh8
Message-ID: <CAMSfU+7miM_1uRnh8X0w1QP+gbrL-M+a==h0=sG=EYxYZfiPkA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Bitbake-setup configuration schema
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007a587b06418957e9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 19 Oct 2025 21:06:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18195

--0000000000007a587b06418957e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 18 oct. 2025 =C3=A0 01:15, Yoann Congal <yoann.congal@smile.fr> a =
=C3=A9crit :

> This series focuses on adding a JSON-schema for the bitbake-setup
> configuration format. I still have some doubt about how strict I should
> make the schema (hence this RFC).
>
> Also I tested by adding a validation step to the bitbake-setup
> selftest but it has non-stdlib dependcies (also a RFC about how to
> handle that).
>

Mathieu tested this on AB (thanks!), as expected, it failed on
"ModuleNotFoundError: No module named 'jsonschema'" [0]

Thinking about it, a less intrusive test could be to reproduce the layers
schema test [1]: building the jsonschema dependency with OE-Core and use it
to validate the schema & default-registry.
But, this approach has one drawback : it can not be used to validate the
configs used inside bitbake-setup selftests (which can't depend on
oe-core). And IMHO, this is where the new config elements will appear.

Finally, given where we are in the release cycle, "less intrusive" is key.
So, I think I will send a patch series with this and go from there.

[0]:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2576/ste=
ps/12/logs/stdio
[1]:
https://git.yoctoproject.org/poky/tree/meta/lib/oeqa/selftest/cases/bblayer=
s.py

>
> Regards,
>
> Yoann Congal (5):
>   schemas: import layers.schema.json from OE-Core
>   schemas: add $schema specification to the layers schema
>   schemas: Add bitbake-setup JSON schema
>   bitbake-setup: Add an option to validate the schema
>   lib/bb/tests/setup.py: validate JSON schema during tests
>
>  bin/bitbake-setup                 |  41 ++++++++++++
>  lib/bb/tests/setup.py             |   2 +-
>  schemas/bitbake-setup.schema.json | 108 ++++++++++++++++++++++++++++++
>  schemas/layers.schema.json        |  77 +++++++++++++++++++++
>  4 files changed, 227 insertions(+), 1 deletion(-)
>  create mode 100644 schemas/bitbake-setup.schema.json
>  create mode 100644 schemas/layers.schema.json
>
>

--=20
Yoann Congal
Smile ECS

--0000000000007a587b06418957e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Le=C2=A0sam. 18 oct. 2025 =C3=A0=C2=A001:=
15, Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr">yoann.congal@=
smile.fr</a>&gt; a =C3=A9crit=C2=A0:</div><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This seri=
es focuses on adding a JSON-schema for the bitbake-setup<br>
configuration format. I still have some doubt about how strict I should<br>
make the schema (hence this RFC).<br>
<br>
Also I tested by adding a validation step to the bitbake-setup<br>
selftest but it has non-stdlib dependcies (also a RFC about how to<br>
handle that).<br></blockquote><div><br></div><div>Mathieu tested this on AB=
 (thanks!), as expected, it failed on &quot;ModuleNotFoundError: No module =
named &#39;jsonschema&#39;&quot; [0]</div><div><br></div><div>Thinking abou=
t it, a less intrusive test could be to reproduce the layers schema test [1=
]: building the jsonschema dependency with OE-Core and use it to validate t=
he schema &amp; default-registry.</div><div>But, this approach has one draw=
back : it can not be used to validate the configs used inside bitbake-setup=
 selftests (which can&#39;t depend on oe-core). And IMHO, this is where the=
 new config elements will appear.</div><div><br></div><div>Finally, given w=
here we are in the release cycle, &quot;less intrusive&quot; is key. So, I =
think I will send a patch series with this and go from there.</div><div><br=
></div><div>[0]:=C2=A0<a href=3D"https://autobuilder.yoctoproject.org/valky=
rie/#/builders/35/builds/2576/steps/12/logs/stdio">https://autobuilder.yoct=
oproject.org/valkyrie/#/builders/35/builds/2576/steps/12/logs/stdio</a></di=
v><div>[1]:=C2=A0<a href=3D"https://git.yoctoproject.org/poky/tree/meta/lib=
/oeqa/selftest/cases/bblayers.py">https://git.yoctoproject.org/poky/tree/me=
ta/lib/oeqa/selftest/cases/bblayers.py</a></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
Regards,<br>
<br>
Yoann Congal (5):<br>
=C2=A0 schemas: import layers.schema.json from OE-Core<br>
=C2=A0 schemas: add $schema specification to the layers schema<br>
=C2=A0 schemas: Add bitbake-setup JSON schema<br>
=C2=A0 bitbake-setup: Add an option to validate the schema<br>
=C2=A0 lib/bb/tests/setup.py: validate JSON schema during tests<br>
<br>
=C2=A0bin/bitbake-setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 41 ++++++++++++<br>
=C2=A0lib/bb/tests/setup.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A02 +-<br>
=C2=A0schemas/bitbake-setup.schema.json | 108 +++++++++++++++++++++++++++++=
+<br>
=C2=A0schemas/layers.schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 77 ++++=
+++++++++++++++++<br>
=C2=A04 files changed, 227 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 schemas/bitbake-setup.schema.json<br>
=C2=A0create mode 100644 schemas/layers.schema.json<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000007a587b06418957e9--

