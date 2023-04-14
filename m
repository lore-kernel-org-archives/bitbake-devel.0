Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDF5C77B72
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 16:08:22 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.14692.1681488492102046210
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Apr 2023 09:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=EVGp5eOy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so10058992wms.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Apr 2023 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681488490; x=1684080490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBxW/bCBTtCP3MfJZ7gIX4rtn9NfudHVAfeTEf4jreY=;
        b=EVGp5eOyuzDAXvEMtKvxlE+2kHTcxwBcp2Msf651WaxOytYUcUQkigYyelZOH70Beg
         XWcnaV1RxkhY5I83hb37X8rFKtzNzcDoUZGzeAPpiAd0SWUpsPuD6usnAbUW2qeYACQW
         dDo3CM2E9XJLaGZvAoRoLztuTTgTTC3P5E+AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681488490; x=1684080490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBxW/bCBTtCP3MfJZ7gIX4rtn9NfudHVAfeTEf4jreY=;
        b=YlAUf4X6/oCiRFJ3ouwNCVhkQI4K7boR3vlYUhfostWWDRqAHTM+1I7+VfrV8oWLp3
         m4Dx7F/Qq8l7rTALxEu/mBBYkvwo+gwP2+G1xG4AUCTt5NMP2Tl3y5YPW74quMfqIKYC
         4TDF+dUg4dOfV9GXkw7qYfoka0UoTtH33h7sBvOZQtM7TANv4TT1X9s8x3KL/s5/fclB
         fHnfkrGNlsdtdWDqjTjhSzshROA8Aqz20DcijrWlLNlvWS5GIiYGC4p8mtI15tOKzZwX
         L/6OaCgmz88ynMkF1pjoCnhe6zy9nlzvuTksD0q8s+v76KLJ4PpQewc4IGMLtCMeQVNx
         wVNQ==
X-Gm-Message-State: AAQBX9eIJoOOhDxCXSKB3FiCQBg+YbHga02uioG7OvFI8DjRUqsRS4cK
	166ipyTtjphAsORWx6oTWSzlBQ==
X-Google-Smtp-Source: AKy350YFqVvUR3thWwr4YYqrQtWDVp844g98Ql7rZFxe34bwj8RteAKP9QR0KgRkWR4YPfZ+9NRxwA==
X-Received: by 2002:a7b:c7d4:0:b0:3eb:39e0:3530 with SMTP id z20-20020a7bc7d4000000b003eb39e03530mr4617568wmk.41.1681488490414;
        Fri, 14 Apr 2023 09:08:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4676:d773:dc86:c4a1? ([2001:8b0:aba:5f3c:4676:d773:dc86:c4a1])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b003ede2c4701dsm8184632wmc.14.2023.04.14.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:08:09 -0700 (PDT)
Message-ID: <80bc21e893c165f9ea24b125fed26fcf5cb305cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Problems having both git and npmsw sources in
 recipe #bitbake
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: public@smn.dk, bitbake-devel@lists.openembedded.org
Date: Fri, 14 Apr 2023 17:08:08 +0100
In-Reply-To: <ppBZ.1681472517878402202.SeyY@lists.openembedded.org>
References: <ppBZ.1681472517878402202.SeyY@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Apr 2023 16:08:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14700

On Fri, 2023-04-14 at 04:41 -0700, public@smn.dk wrote:
> I have posted the following topic under the group Openembedded-issues. I =
am a little unsure if that is the right place, as there seems to be little =
or no activity in that group?=C2=A0
>=20
> Openembedded-issues@lists.openembedded.org | Problems having both git and=
 npmsw sources in recipe
>=20
> Hi
>=20
> I am experiencing problems with a recipe where I have both a git and a np=
msw source in the SRC_URI. It seems that when the fetcher is fetching from =
the shrinkwrap, the SRCREV variable has been deleted but it still ends up f=
etching from the git source resulting in an error because SRCREV is undefin=
ed.
>=20
> The problem occurs because the Fetch class defaults to the value of SRC_U=
RI if the urls parameter contains an empty list. The following change to th=
e npmsw.py file seems to solve the problem:
>=20
> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
> index=C2=A0a8c4d3528f..4d700a537a=C2=A0100644
> ---=C2=A0a/bitbake/lib/bb/fetch2/npmsw.py
> +++=C2=A0b/bitbake/lib/bb/fetch2/npmsw.py
> @@=C2=A0-193,7=C2=A0+193,9=C2=A0@@=C2=A0class=C2=A0NpmShrinkWrap(FetchMet=
hod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# This fetcher reso=
lves multiple URIs from a shrinkwrap file and then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# forwards it to a =
proxy fetcher. The management of the donestamp file,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# the lockfile and =
the checksums are forwarded to the proxy fetcher.
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.proxy =3D Fetch([dep["url"=
] for dep in ud.deps if dep["url"]], data)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0shrinkwrap_urls=C2=A0=3D=
=C2=A0[dep["url"]=C2=A0for=C2=A0dep=C2=A0in=C2=A0ud.deps=C2=A0if=C2=A0dep["=
url"]]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0shrinkwrap_urls:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ud.proxy=C2=A0=3D=C2=A0Fetch(shrinkwrap_urls,=C2=A0data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.needdonestamp=C2=
=A0=3D=C2=A0False
>=20
> Are=C2=A0this=C2=A0change=C2=A0OK=C2=A0or=C2=A0can=C2=A0it=C2=A0result=C2=
=A0in=C2=A0other=C2=A0issues?
>=20
> Also more generally why does the Fetch class default to the value of SRC_=
URI variable if the urls parameter contains an empty list? Isn't this a str=
ange implementation? It also seems to result in issues if the shrinkwrap fi=
le contains no dependencies.
>=20
> Please note that I am fairly new to bitbake and completely new to the sou=
rce code. :)

I think your patch is right. The Fetch class defaults to use SRC_URI
for legacy reasons based on how things were abstracted and extended, it
made sense at the time. I'm not sure if we still need it or not now.

If you send the above patch as a proper patch we can test it and likely
merge.

Cheers,

Richard

