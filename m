Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A38C54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 12:50:58 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.53875.1673527851913433382
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jan 2023 04:50:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cmF1/ITf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id e3so8760200wru.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tqc/wyY8CZGEyCIFyh0P1UpHOlOlEFdBGFwTlPRNZ7A=;
        b=cmF1/ITfjz4CMaFko5naMo91gjfglydYume0PnlmyNnmFv5PKybo/L6GNe28NiCxGF
         wjL0MMqeNClOvNZK82XC/enhW0NjGvPsmtkNTizJdIrx/62WoJWaAqKjonCTjAOyhyzU
         ATUZVicIqY/VEwVN1X8FMSolL7eIiRADLbFfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tqc/wyY8CZGEyCIFyh0P1UpHOlOlEFdBGFwTlPRNZ7A=;
        b=WgXbUEbGQ0cHUUlvbQJ5fg1CLq4BtQlHjDlkExaKdhcKO4v36DhMF1bWGcqSasnlW3
         KcNtZKnZqTdOHAU4XSn6WPO5NsxfchfwN75JQH880krduepiHidumQ6FYXCnriItMZGf
         X0NODCu83Tgdb2tUrbHKOqJsvwbbSBpz1K9TR9U4eCOeaJE4+kg43Dyox+11AbfI9igl
         Kw/O5zeqvabAl7e2iKM1ZV/QvnB73+9/xlY+W91PiswZqRdQzEatf0r3LPjqkdjTdf96
         f7h0b+r4QhIcq83wXydJ5mtSJP/CIBIYu6HfjcPlKJQRij5i7J0EcHzsLQF7OVPFnkSe
         Yhug==
X-Gm-Message-State: AFqh2kp9On20q4aS5yR7jI+74MtulvSQSB2v7xbHQ+qfF1T7YzoK0Ru/
	l7zDtdUs8/xbz4EoheTZVW54oA==
X-Google-Smtp-Source: AMrXdXuHkyNGcUNiHLSyma6YZRow/jNWWBKTnho6FJ+f4cqgun907D/piJRlVeM0zmvJ6oznzvmGVw==
X-Received: by 2002:a05:6000:1c05:b0:261:d8be:3046 with SMTP id ba5-20020a0560001c0500b00261d8be3046mr51597114wrb.0.1673527850057;
        Thu, 12 Jan 2023 04:50:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a64e:9cdc:56b5:438b? ([2001:8b0:aba:5f3c:a64e:9cdc:56b5:438b])
        by smtp.gmail.com with ESMTPSA id m10-20020adff38a000000b002bc83b85180sm7864002wro.114.2023.01.12.04.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:50:49 -0800 (PST)
Message-ID: <ff985da2d6dc93e4a75adc94bb84ecd176f26495.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>, Yoann Congal
	 <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Jan 2023 12:50:48 +0000
In-Reply-To: <CANPvuRku0dQQPQVX5Hxcw27zZQhLTM-3X0SAV0hZ4JTkVe26Ag@mail.gmail.com>
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
	 <CANPvuRku0dQQPQVX5Hxcw27zZQhLTM-3X0SAV0hZ4JTkVe26Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 12:50:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14310

On Thu, 2023-01-12 at 11:43 +0000, Jose Quaresma wrote:
> Hi Yoann,
>=20
>=20
> Yoann Congal <yoann.congal@smile.fr> escreveu no dia quarta, 11/01/2023 =
=C3=A0(s) 22:38:
> > Sqlite can't open the cachefile when its path is too long (>=3D 505 cha=
r by
> > my tests).
> >=20
> > We do have a path length check in sanity.bbclass but this code is calle=
d
> > before sanity checks.
> >=20
> > Treat the error in the exception instead of checking before hand in cas=
e
> > sqlite eventually fixes this.
> >=20
> > Fixes [YOCTO #12374]
> >=20
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> > =C2=A0lib/bb/persist_data.py | 18 +++++++++++++++++-
> > =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
> > index ce84a158..a027f912 100644
> > --- a/lib/bb/persist_data.py
> > +++ b/lib/bb/persist_data.py
> > @@ -249,4 +249,20 @@ def persist(domain, d):
> >=20
> > =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(cachedir)
> > =C2=A0 =C2=A0 =C2=A0cachefile =3D os.path.join(cachedir, "bb_persist_da=
ta.sqlite3")
> > -=C2=A0 =C2=A0 return SQLTable(cachefile, domain)
> > +
> > +=C2=A0 =C2=A0 try:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return SQLTable(cachefile, domain)
> > +=C2=A0 =C2=A0 except sqlite3.OperationalError:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sqlite fails to open database when its p=
ath is too long.
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # After testing, 504 is the biggest path l=
ength that can be opened by
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sqlite.
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Note: This code is called before sanity.=
bbclass and its path length
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_len =3D 504
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(cachefile) > max_len:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.critical("The path of=
 the cache file is too long "
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
f"({len(cachefile)} chars > {max_len}) to be opened by sqlite! "
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
f"Your cache file is \"{cachefile}\"")
> >=20
>=20
>=20
> As fair as I know bitbake don't use python fstrings=C2=A0anywhere=C2=A0
>=20
> grep --include=3D\*.py =C2=A0-rnw bitbake/lib/ -e 'f".*"'=20
> bitbake/lib/bb/data_smart.py:345: =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Get the l=
ine where a operation is made on a variable in file f"""
> bitbake/lib/bb/main.py:135: =C2=A0 =C2=A0parser.add_option("-f", "--force=
", action=3D"store_true", dest=3D"force", default=3DFalse,
> bitbake/lib/bb/tests/runqueue.py:305: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0tasks =3D self.run_bitbakecmd(["bitbake", "mc:mc_2:a1", "-c", "compil=
e", "-f"], tempdir, "", extraenv=3Dextraenv, cleanup=3DTrue)
> bitbake/lib/pyinotify.py:2255: =C2=A0 =C2=A0parser.add_option("-f", "--ra=
w-format", action=3D"store_true",

We don't, no.

We do now meet the minimum python requirements so in theory we could
but it would mean the code can't be backported. A fix like this could
be useful in older releases so it is perhaps sticking to the older
syntax but I know others would prefer to be able to use it. I'm torn on
it...


Cheers,

Richard


