Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A8AC83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 07:53:36 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.33889.1751270006262098410
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Jun 2025 00:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ywp+awcj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso14206785e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751270005; x=1751874805; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsIANQJzXAFLS8TlPrvpv0aOvaapJwWSYgqm5lMyb1M=;
        b=Ywp+awcjUpmtNWdRP4YkYi6rNF1hzF1Y6kMoAUCQQ0dO9hqP3nGA7CHfQtuCTIqOu3
         fZ/bjBLYvPJa7eBKUNufqm1CqvVfSHSMInFU+7K0zATY4Nr7iFH3L1PinrT2FLpEY6HL
         BGfh0Qu4116WiqOdK6DA5v58Ehb2qgwuJ1vAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270005; x=1751874805;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsIANQJzXAFLS8TlPrvpv0aOvaapJwWSYgqm5lMyb1M=;
        b=o62nWaF13tg+cNxI86Ebw5uupb02NSTEadrl0pIMqm12nHaDrZ+GnVsMMbBCHTM8Hv
         yGBofTBBgnwDfXygqN0aHn/CIrs3CzebilXdBzPfvUGgC4APVgAvTRvUiBe/FXokghya
         4zX0X3wqG3dvBr+zYsWWRbCbBbJwuCusqcBs8Oc3eFtU2BFQ3pvUAstJtrQ09jkoLEMc
         B1f1aP+loOaugv9bYvHjf3aqwvkYB+KBWa91pkNf3Ct48v3TDUHAfpO0vKe2o4/0Wvlq
         0PccYskq0yR1c81g/zwauols/h13iPhsgbV6uSSk957+zNCdj2SJv4y2K2PRIWRxudMG
         8SxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdlK/vUTFxUwsrWO8ejEzsOQR++U2Mv+GMnPVDyNP0u26ICewwewSdoiWJX99tNdozoFsl2KKt53VsK91V@lists.openembedded.org
X-Gm-Message-State: AOJu0YxwnkOCa85TbO+JjY2OuPOyH5X3Iw/s+idr1LiN2R+Yo1uuK9fR
	1H1KaxeaCZlOQhMaoX3GZwVUFBeRu07Ud9+RPkpLZ1VuXNber9GT7Bi0N3NVzmxQbRk=
X-Gm-Gg: ASbGncuz8z7Y0+0FRcVG6LfMXuDPjJxfWjvGukl+yTYYLjHJv9UJFC9VUXdy3ph/Eyi
	uonlUadF5UMTGOnc2kccMVeCIOukgKUiPHkbZoBz7sjrab9Jlu93V0O5ASbl6LjtD+EIqK7pZ/Q
	bZUjtH4gu/mQ61WVArPeIQmOOCF3nxrBcVpEQSTs6CSj4jFANZtnSPylTwq9eJldnIviwffbxCe
	c1d9JqNbF3567idRYkDg+PUKp72jxcpDzgqyjD9QO2CCh6JK97F5SLeS/+U6BFRkz0s6LnOgcTF
	u0/ZpjfV70wRyKCZwfuQB36vR+7mskviJFH3OZY3IpqRuDrh5zBPiTE3Z1hzQL/BqGh1fS9vSJx
	1vR3iUweL8kLetXrxzLS1lxA61xqUW8XToGj9dvHg1ZmCqipgIgw=
X-Google-Smtp-Source: AGHT+IGrPen2u6G6db/el9tyyAuvmRoHl8hUPMABMqKxCMCK37dI7qGxbemjH3F7uB4KXkukZsDjzA==
X-Received: by 2002:a05:600c:46cb:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-4538f88348fmr100437895e9.23.1751270004602;
        Mon, 30 Jun 2025 00:53:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7e4f:7802:84c8:7b76? ([2001:8b0:aba:5f3c:7e4f:7802:84c8:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e74fbsm9805652f8f.10.2025.06.30.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:53:23 -0700 (PDT)
Message-ID: <4c5cdb568c75f3f82f39b5e943215c016b6b1388.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] utils: Refactor filemode variable
 conversion to a function
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jun 2025 08:53:23 +0100
In-Reply-To: <DAZP6D0RAN17.9KSXN8XWORHR@bootlin.com>
References: <20250627091604.3275870-1-richard.purdie@linuxfoundation.org>
	 <DAZP6D0RAN17.9KSXN8XWORHR@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 07:53:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17726

On Mon, 2025-06-30 at 09:42 +0200, Antonin Godard wrote:
> Hi Richard,
>=20
> On Fri Jun 27, 2025 at 11:16 AM CEST, Richard Purdie via lists.openembedd=
ed.org wrote:
> > We have other places in the code where we need to take filemode/mask
> > information from a bitbake variable and turn it into a real python
> > number. Turn this internal code into public API in bb.utils and
> > add some tests for it.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0bin/bitbake-worker=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++-----
> > =C2=A0lib/bb/tests/utils.py | 11 +++++++++++
> > =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++=
++
> > =C2=A03 files changed, 23 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> > index 35fa1ab62be..9f33195176f 100755
> > --- a/bin/bitbake-worker
> > +++ b/bin/bitbake-worker
> > @@ -182,11 +182,8 @@ def fork_off_task(cfg, data, databuilder, workerda=
ta, extraconfigdata, runtask):
> > =C2=A0=C2=A0=C2=A0=C2=A0 elif workerdata["umask"]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 umask =3D workerdata["=
umask"]
> > =C2=A0=C2=A0=C2=A0=C2=A0 if umask:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # umask might come in as a =
number or text string..
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 umask =3D int(umask, 8)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except TypeError:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pass
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Convert to a python numer=
ic value as it could be a string
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.to_filemode(umask)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 dry_run =3D cfg.dry_run or runtask['dry_run']
> > =C2=A0
> > diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
> > index 48e61dfcea0..52b7bf85bf4 100644
> > --- a/lib/bb/tests/utils.py
> > +++ b/lib/bb/tests/utils.py
> > @@ -692,3 +692,14 @@ class EnvironmentTests(unittest.TestCase):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("A", os.=
environ)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(os.en=
viron["A"], "this is A")
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("B", =
os.environ)
> > +
> > +class FilemodeTests(unittest.TestCase):
> > +=C2=A0=C2=A0=C2=A0 def test_filemode_convert(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(0o775, bb.=
utils.to_filemode("0o775"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(0o775, bb.=
utils.to_filemode(0o775))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(0o775, bb.=
utils.to_filemode("775"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(Valu=
eError):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
utils.to_filemode("xyz")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(Valu=
eError):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
utils.to_filemode("999")
> > +
> > diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> > index a2806fd360d..01f7cf81f46 100644
> > --- a/lib/bb/utils.py
> > +++ b/lib/bb/utils.py
> > @@ -1211,6 +1211,16 @@ def which(path, item, direction =3D 0, history =
=3D False, executable=3DFalse):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "", hist
> > =C2=A0=C2=A0=C2=A0=C2=A0 return ""
> > =C2=A0
> > +def to_filemode(input):
> > +=C2=A0=C2=A0=C2=A0 """
> > +=C2=A0=C2=A0=C2=A0 Take a bitbake variable contents defining a file mo=
de and return
> > +=C2=A0=C2=A0=C2=A0 the proper python representation of the number
> > +=C2=A0=C2=A0=C2=A0 """
>=20
> It could be nice to keep the same format as the other functions in this f=
ile:
> explicit the arguments and the return value.
>=20
> > +=C2=A0=C2=A0=C2=A0 # umask might come in as a number or text string..
> > +=C2=A0=C2=A0=C2=A0 if type(input) is int:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return input
> > +=C2=A0=C2=A0=C2=A0 return int(input, 8)
> > +
> > =C2=A0@contextmanager
> > =C2=A0def umask(new_mask):
> > =C2=A0=C2=A0=C2=A0=C2=A0 """
>=20
> I think this triggered a wall of errors of the autobuilder:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1910
>=20
> Locally I also reproduced the issue:
>=20
> ERROR: Task (/data/yoctoproject/ws/repos/openembedded-core/meta/recipes-b=
sp/efivar/efivar_39.bb:do_recipe_qa) failed with exit code '1'
>=20
> If I drop this commit (and the two others on OE-Core that use to_filemode=
),
> then re-run it becomes successful again. Cleaning the sstate of the recip=
e
> then, and re-introducing your commit only, triggers the error. I don't ha=
ve any
> log to show because I think the issue happens before do_recipe_qa is run.

Thanks, I've tweaked the docstring and fixed the issue in v2.

Cheers,

Richard

