Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5576C43217
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:25:57 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web12.16662.1650095784488038452
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Apr 2022 00:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qYsLpH7M;
 spf=pass (domain: gmail.com, ip: 209.85.218.54,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id r13so18814128ejd.5
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Apr 2022 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1kPfyV23wggmZypMPCZGj2IMVfEPm3QJcb/h1/kx6zM=;
        b=qYsLpH7MUMnqvFD9n9iixEappTbAtlLR6AivyW9ei8VeSNfzQQPEQPUJwZeNcIQxAK
         tGv5ESdQc9jB2oB/rAizWZBenW1HeldYgkLqgiMY6Jq3LQ0jD27H9fVKj74nPMx+yhSL
         6DWoWbMcYC3GjK+iIajty9dHUcFt5GQnvbMXVFeUR0J+AHZVjtalXnY2nC2tY2prjPdV
         M5c0d7GQvX+2BA0lbsGZm6LaBe12QS5PPtsj6oHhkfbt0zwXhHEImrKYhdEc45p3w85L
         U+fUrpAvk5sbuq8oCZBrdy+TZl0S1ovFVjN0CTxuEdCCzxMjxd3z30kp1gnvcCEThBXN
         WfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1kPfyV23wggmZypMPCZGj2IMVfEPm3QJcb/h1/kx6zM=;
        b=ZefGsf7xGv3+tyBiBQrlke+D6SIpLtDJMj+paDYrPtjQVYwsGH18BwyuPBTRxkVBsc
         scbEoiZNxC3mxOjWi23NfEOuqVyiC11VqZoiTdTZGMotqpvvhmMdidtUkb62Ui4jUxvb
         MjbLhg/I4qCbPLXj0Rkyx5r85VN103HLwKEomhbA7lxHXlaKncpswNgXDHHSpEXd+m5t
         XuE+baRxHNOW7TXBqId/x8xlzptwwyr0LJ0eGqv5Rs4kWlynO4tthMOe15pgeB5dycNC
         tXEyhj7FkCfT2bK/gyyLhzLNsjpuXLCsaXghcVaUQGRI3ugrwq/3LhX4KRjqnZVWh4Aj
         nCcw==
X-Gm-Message-State: AOAM531aaJnjzQZ6swveVeMm5LhKiPoei4sNZpcyDZ+BFrlRekNbDrJA
	RnV0WKWhLTK9uVBtFZx168Y=
X-Google-Smtp-Source: 
 ABdhPJxiOMJ1NXELXXHj5sMMZwwJ5x7G6HcIntFMsg9IMKfzDHbrNr/aCdMAr4ZvZZlb7TQuIpyNWQ==
X-Received: by 2002:a17:907:7882:b0:6e8:946f:adb3 with SMTP id
 ku2-20020a170907788200b006e8946fadb3mr1982383ejc.564.1650095782691;
        Sat, 16 Apr 2022 00:56:22 -0700 (PDT)
Received: from smtpclient.apple
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 r29-20020a50c01d000000b00415fb0dc793sm3897437edb.47.2022.04.16.00.56.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Apr 2022 00:56:22 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Message-Id: <979FD4CA-0C74-4288-BCFF-049C93786CAC@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_0E25856E-EBA2-4229-8AEC-DAF692FD5B41"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [bitbake-devel] Branch switch doesn't work on openembedded.org
Date: Sat, 16 Apr 2022 09:56:21 +0200
In-Reply-To: 
 <CADfgfoZiBuY0JeJPqZa_=w+bE+d4mQTbPSENepKVt-=hqOoXow@mail.gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
To: Michael Halstead <mhalstead@linuxfoundation.org>
References: <D247F1F9-1C2C-4B53-828A-ABB4D29800DF@gmail.com>
 <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
 <75e09aed-e62e-f596-32ea-c2ac76d9b186@theobroma-systems.com>
 <CADfgfoZiBuY0JeJPqZa_=w+bE+d4mQTbPSENepKVt-=hqOoXow@mail.gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:25:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13637


--Apple-Mail=_0E25856E-EBA2-4229-8AEC-DAF692FD5B41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Dear Michael,

Thanks a lot! Posted to the cgit mailing list.
Best

Marius



> On 15. Apr 2022, at 19:05, Michael Halstead =
<mhalstead@linuxfoundation.org> wrote:
>=20
> Hi Marius,
> If I understand correctly you want to get a 404 page when the path =
specified doesn't exist in the branch selected. Dropping the id from the =
query string when switching branches would accomplish that. The correct =
place to propose these changes is on the cgit mailing list. You can join =
at https://lists.zx2c4.com/mailman/listinfo/cgit =
<https://lists.zx2c4.com/mailman/listinfo/cgit>. Once the changes are in =
cgit you can email it-coreprojects-helpdesk@linuxfoundation.org =
<mailto:it-coreprojects-helpdesk@linuxfoundation.org> to request we pull =
them into production.
>=20
> On Fri, Apr 15, 2022 at 4:32 AM Quentin Schulz =
<quentin.schulz@theobroma-systems.com =
<mailto:quentin.schulz@theobroma-systems.com>> wrote:
> Hi Marius,
>=20
> =
http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-dev=
tools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832dc=
9b90f9d5a6&h=3Dmaster =
<http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-de=
vtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832d=
c9b90f9d5a6&h=3Dmaster>
>=20
> is actually going to show you the state of the file at the given =
commit=20
> hash passed in the id argument and the branch (h argument) will be =
ignored.
>=20
> I assume we'd like to remove the id argument when the dropdown menu =
for=20
> versions is used to switch between branches.
>=20
> I don't know where to do this so I'll let the competent people do it =
or=20
> guide us :)
>=20
> Cheers,
> Quentin
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13631): =
https://lists.openembedded.org/g/bitbake-devel/message/13631 =
<https://lists.openembedded.org/g/bitbake-devel/message/13631>
> Mute This Topic: https://lists.openembedded.org/mt/90421898/1003190 =
<https://lists.openembedded.org/mt/90421898/1003190>
> Group Owner: bitbake-devel+owner@lists.openembedded.org =
<mailto:bitbake-devel%2Bowner@lists.openembedded.org>
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =
<https://lists.openembedded.org/g/bitbake-devel/unsub> =
[mhalstead@linuxfoundation.org <mailto:mhalstead@linuxfoundation.org>]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20
>=20
> --=20
> Michael Halstead
> Linux Foundation / Yocto Project
> Systems Operations Engineer


--Apple-Mail=_0E25856E-EBA2-4229-8AEC-DAF692FD5B41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Dear =
Michael,<div class=3D""><br class=3D""></div><div class=3D"">Thanks a =
lot! Posted to the cgit mailing list.</div><div class=3D"">Best</div><div =
class=3D""><br class=3D""></div><div class=3D"">Marius</div><div =
class=3D""><br class=3D""></div><div class=3D""><br class=3D""><div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 15. =
Apr 2022, at 19:05, Michael Halstead &lt;<a =
href=3D"mailto:mhalstead@linuxfoundation.org" =
class=3D"">mhalstead@linuxfoundation.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div dir=3D"ltr" =
class=3D""><div class=3D"">Hi Marius,</div><div class=3D"">If I =
understand correctly you want to get a 404 page when the path =
specified&nbsp;doesn't exist&nbsp;in the branch selected. Dropping the =
id from the query string when switching branches would accomplish that. =
The correct place to propose these changes is on the cgit mailing list. =
You can join at&nbsp;<a =
href=3D"https://lists.zx2c4.com/mailman/listinfo/cgit" =
class=3D"">https://lists.zx2c4.com/mailman/listinfo/cgit</a>. Once the =
changes are in cgit you can email&nbsp;<a =
href=3D"mailto:it-coreprojects-helpdesk@linuxfoundation.org" =
class=3D"">it-coreprojects-helpdesk@linuxfoundation.org</a> to request =
we pull them into production.</div><br class=3D""><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr =
15, 2022 at 4:32 AM Quentin Schulz &lt;<a =
href=3D"mailto:quentin.schulz@theobroma-systems.com" =
class=3D"">quentin.schulz@theobroma-systems.com</a>&gt; wrote:<br =
class=3D""></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Marius,<br class=3D"">
<br class=3D"">
<a =
href=3D"http://git.openembedded.org/meta-openembedded/tree/meta-python/rec=
ipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428f=
f11832dc9b90f9d5a6&amp;h=3Dmaster" rel=3D"noreferrer" target=3D"_blank" =
class=3D"">http://git.openembedded.org/meta-openembedded/tree/meta-python/=
recipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf6784=
28ff11832dc9b90f9d5a6&amp;h=3Dmaster</a><br class=3D"">
<br class=3D"">
is actually going to show you the state of the file at the given commit =
<br class=3D"">
hash passed in the id argument and the branch (h argument) will be =
ignored.<br class=3D"">
<br class=3D"">
I assume we'd like to remove the id argument when the dropdown menu for =
<br class=3D"">
versions is used to switch between branches.<br class=3D"">
<br class=3D"">
I don't know where to do this so I'll let the competent people do it or =
<br class=3D"">
guide us :)<br class=3D"">
<br class=3D"">
Cheers,<br class=3D"">
Quentin<br class=3D"">
<br class=3D"">
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br class=3D"">
Links: You receive all messages sent to this group.<br class=3D"">
View/Reply Online (#13631): <a =
href=3D"https://lists.openembedded.org/g/bitbake-devel/message/13631" =
rel=3D"noreferrer" target=3D"_blank" =
class=3D"">https://lists.openembedded.org/g/bitbake-devel/message/13631</a=
><br class=3D"">
Mute This Topic: <a =
href=3D"https://lists.openembedded.org/mt/90421898/1003190" =
rel=3D"noreferrer" target=3D"_blank" =
class=3D"">https://lists.openembedded.org/mt/90421898/1003190</a><br =
class=3D"">
Group Owner: <a =
href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org" =
target=3D"_blank" =
class=3D"">bitbake-devel+owner@lists.openembedded.org</a><br class=3D"">
Unsubscribe: <a =
href=3D"https://lists.openembedded.org/g/bitbake-devel/unsub" =
rel=3D"noreferrer" target=3D"_blank" =
class=3D"">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a =
href=3D"mailto:mhalstead@linuxfoundation.org" target=3D"_blank" =
class=3D"">mhalstead@linuxfoundation.org</a>]<br class=3D"">
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br class=3D"">
<br class=3D"">
</blockquote></div><br clear=3D"all" class=3D""><div class=3D""><br =
class=3D""></div>-- <br class=3D""><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr" class=3D"">Michael =
Halstead<div class=3D"">Linux Foundation / Yocto Project</div><div =
class=3D"">Systems Operations Engineer</div></div></div></div>
</div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_0E25856E-EBA2-4229-8AEC-DAF692FD5B41--

