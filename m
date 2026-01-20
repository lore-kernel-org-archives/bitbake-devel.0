Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E25D262A3
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 21:19:42 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17339.1768943981834625476
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 13:19:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z3IDbkLP;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927b1620ddso4598317b3.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 13:19:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768943981; cv=none;
        d=google.com; s=arc-20240605;
        b=FTXBdidV0DfJSziAbLSEN1PjZCXeKzm2Llcbp4ZaT+JeV+cksQ/rouV/gTHHxqWbvt
         iE7acHitLLQEY59Zj34O6hGmDg62+rjoc0QFTBb459g4QFblim/M63wdQKUyLqbr5uWC
         4K2aODw22sp5Mjg0LxOWWe/+rEkAKP28wdtr4BOGvpdElrJlI7Q61oLKwyx54wOAWqMk
         YZDbYqJx9tq3YZeUCCWZSxAq8BMLwkJaGp6X+UTSLci4Z2hqZnkypqCQ6cIIw6w+URYe
         BRcTm1OF563d1DE9bLdN26vvaifVYsUjJF4q5wO0TpQSkPEsaMm+SWi4ssgA3XIjIl/4
         S+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7SEvy2uKkKAblDtsg6VFTACJPg0pr6aYWso3FDvDBQc=;
        fh=CBLIpFpDSR1ZSgtLtgUQ15hbal3lIR5M0HdUWYcS4mQ=;
        b=QZRVvQJ+PdRXCL+pMxUaimpscJtiHZw/eHQV+7qn/i7Jfsmkrut95n8DUnHhVH8ZcF
         T1bM7lPeZpWehZLwSrhiCG5bFWn7JlYRBx0TDsUgM/lGqX0/zJ/Ky9OX0vS/AxiDXq/P
         G+J59kyqzKXL5xNW/bkYIwu0/Oeoq0HUjjTK7r32J52LXpXIlTtMjcg+gAkUzjck8ri7
         W/p5simmhP/q/bVovel5Uqf93ubBx4o0Cjb2r6hq7vOHo3xab9Mt3yLHru7MPX1UmPj5
         uaWuvMvLC3TctKdJP9ud79FFmWYGJ7sLvi9wZmGmycFeRgASuflDayFSk7as9dF7diAV
         E9Vg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943981; x=1769548781; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7SEvy2uKkKAblDtsg6VFTACJPg0pr6aYWso3FDvDBQc=;
        b=Z3IDbkLPR0xBfT6X0qo5LXT3ymgKBPRU3seoluw75hHYiHEgzbOHVPtcP+QpYUUD5r
         LF2Q2RKgOu/q1IHpDFkhI8aVPKD8w2VpG8LSbbceGfIGfFSjEAKfEjgyfJcZgCfURkta
         /HgaiCesPlY/atoGc7XAgK+svH6/TlpQzc4NiWNcgjCtsaxdnd9czDR4SS6ClSRM9Iej
         5NXkT0GK7I7FGnrTvFP4dpmfjztRhQOhSZhIw/b3S3OEDH8VNAPW3flKOjhqxKbIKpEg
         BL4PI5l53+0o7qpPpjwDkhNgZrPNqQGzzKdoUyxCCC38Pu22pXFA3+t9lovfpRVexPr1
         buyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943981; x=1769548781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SEvy2uKkKAblDtsg6VFTACJPg0pr6aYWso3FDvDBQc=;
        b=Ch3xrC5t4ZY6EWpuOU1ln2KfcQtB/WI4IEtK7H6K1w+LnmRelsX5xytgQoakESl2Jz
         Y0FEr7xR5iayjHqjTj+lLSbuq3CcocM3kwzNa0JOCPFXlr0Jtn7N0L3OelYn6Zbgxw6t
         il59Xq3NmP1s6rmLHFvatx0Hr77FL47VVbe1NDJEUtA2CA958bj4NatdONSsqplEVIVr
         UhhlJe2cUoTBuRwPGZCNZk8BWELoYcJehyueU3XwPQac8K/2x/dUl64gsXmXFfaS3fAd
         AwenjGar+nIMhnJrDPq4HVqAJatpPH8NaK8M0qThA4C4yb236041Ub7gewV8h0up/ffj
         Nr/w==
X-Forwarded-Encrypted: i=1; AJvYcCXn2E/9tnHKpKEPw1mnPlfvMQLV01NqNdPUF0kMobIMmMcBJenrgrhS2ZMvDJhZihCedc8DlmW3O90ZEgqM@lists.openembedded.org
X-Gm-Message-State: AOJu0YxfE8hvkcL4Jl61l8RVYV3NhA+LgIAm2lhcFellmHG3erCJSlz5
	Z1igVgAo/TgPQJUaE2tunhJLm/vsRjwxWVdazS4Mh/4hZm57+XsjsG1umsqqBMpGeBRqd68C1KI
	JLXOGJOyLUW3ZKGFdjJjzOfcYfWhv4YI=
X-Gm-Gg: AZuq6aL8Qc7tLXVsyRqLqfaoGFJQhOiIR/NfKnFhPebY9ZNEIlYXZy4t+HFvJ2dAeG5
	oA0Ib2424LjMAKx+tQ6IHeUraUU2fnk6LEVhqxWgdlwXF/+3jwFjslR8n3xfO2bRZlDoGKLXfMe
	yzCvdWadV+wvQn+JETCgKjvhVYFL0iRGERCqduOmaHM10Yfzs8HZQ7QV3zzRgt4fFvWSBd/q4eV
	2nJwDXZknQKK1eQCUmIDYHnuDdy+3C0+v3z3y3k+W6JKSf8hxsKZ2sNdwn2CZSBVQ528n0G5sY/
	+h3WOyRoDiJjT6bHZ5ZyXj8kisA=
X-Received: by 2002:a05:690c:9c0b:b0:78f:cd29:51b9 with SMTP id
 00721157ae682-793c57f0aa2mr129653977b3.10.1768943980844; Tue, 20 Jan 2026
 13:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20260114113348.2991476-1-alex.kanavin@gmail.com> <188AEF393CB94A54.3093368@lists.openembedded.org>
In-Reply-To: <188AEF393CB94A54.3093368@lists.openembedded.org>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Tue, 20 Jan 2026 16:19:29 -0500
X-Gm-Features: AZwV_QjaoZRvPxUBCjd_NLHmFFZ9kbmbB6vkaMdvMSCpOQrBIzY_tEmFjJ_WVV4
Message-ID: <CAGAhMBxt23tFCAqfmCycxTyByXN_5=F4jHsfv0-XhjoFjsAeNA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-setup: use internal registry
 if run from git checkout, bitbake repo otherwise
To: rob.woolleywr@gmail.com
Cc: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="0000000000009b1a5a0648d85d15"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 21:19:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18821

--0000000000009b1a5a0648d85d15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I tested your fix and confirm that it works both with and without the .git
directory present.  When .git/ is missing I see the lines:

NOTE: Fetching configuration registry
    git://
git.openembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster
into

/ala-lpggp21/rwoolley/vanilla-bitbake-setup/bitbake-builds/.bitbake-setup-c=
ache/configurations

In both cases, "bitbake-setup init" completes successfully.

I also rebased my Python packaging changes and hope to push the patches
soon.

Regards,
Rob

On Thu, Jan 15, 2026 at 9:53=E2=80=AFAM Rob Woolley via lists.openembedded.=
org
<rob.woolleywr=3Dgmail.com@lists.openembedded.org> wrote:

> Hi Alex,
>
> Thanks! I will give this a try.
>
> I have a need to be able to use bitbake-setup for air-gapped builds. I
> will experiment with how we might make this work for situations where
> git.openembedded.org is unavailable.  (In the past I have used git
> "insteadof" to accomplish this)
>
> Regards,
> Rob
>
> On Wed, Jan 14, 2026 at 6:33=E2=80=AFAM Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
>
>> From: Alexander Kanavin <alex@linutronix.de>
>>
>> If bitbake-setup is packaged and obtained from pypi, or another package
>> feed
>> it needs to be able to find standard configurations. It is not impossibl=
e
>> to package configurations into some location inside the package
>> and add logic to find them, but it is much easier to just fetch the
>> bitbake
>> repo and use that as a configuration registry. The other benefit is that
>> such packaged/installed bitbake-setup will not have to be updated in ord=
er
>> to obtain latest configurations: it will simply check the registry and
>> fetch
>> them as needed, which is the original intent of config registries as
>> repos.
>>
>> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
>> ---
>>  bin/bitbake-setup | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
>> index 2c2b6d8ec..4ed06fc62 100755
>> --- a/bin/bitbake-setup
>> +++ b/bin/bitbake-setup
>> @@ -21,8 +21,6 @@ import signal
>>  import functools
>>  import string
>>
>> -default_registry =3D os.path.normpath(os.path.dirname(__file__) +
>> "/../default-registry")
>> -
>>  bindir =3D os.path.abspath(os.path.dirname(__file__))
>>  sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
>>
>> @@ -37,6 +35,17 @@ GLOBAL_ONLY_SETTINGS =3D (
>>      "top-dir-name",
>>  )
>>
>> +# If bitbake is from a release tarball or somewhere like pypi where
>> +# updates may not be straightforward, prefer to use the git repo as the
>> +# default registry
>> +def get_default_registry():
>> +    internal_registry =3D os.path.normpath(os.path.dirname(__file__) +
>> "/../default-registry")
>> +    git_registry =3D "git://
>> git.openembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmast=
er"
>> +    if os.path.exists(os.path.dirname(__file__) + "/../.git"):
>> +        return internal_registry
>> +    else:
>> +        return git_registry
>> +
>>  def cache_dir(top_dir):
>>      return os.path.join(top_dir, '.bitbake-setup-cache')
>>
>> @@ -1084,7 +1093,7 @@ def main():
>>          builtin_settings['default'] =3D {
>>                           'top-dir-prefix':os.getcwd(),
>>                           'top-dir-name':'bitbake-builds',
>> -                         'registry':default_registry,
>> +                         'registry':get_default_registry(),
>>                           'use-full-setup-dir-name':'no',
>>                           'common-sstate':'yes',
>>                           }
>> --
>> 2.47.3
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18782):
> https://lists.openembedded.org/g/bitbake-devel/message/18782
> Mute This Topic: https://lists.openembedded.org/mt/117259398/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000009b1a5a0648d85d15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>I tested your fix and confirm =
that it works both with and without the .git directory present.=C2=A0 When =
.git/ is missing I see the=C2=A0lines:</div><div><br></div><div>NOTE: Fetch=
ing configuration registry<br>=C2=A0 =C2=A0 git://<a href=3D"http://git.ope=
nembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster">git.op=
enembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster</a><br=
>into<br>=C2=A0 =C2=A0 /ala-lpggp21/rwoolley/vanilla-bitbake-setup/bitbake-=
builds/.bitbake-setup-cache/configurations<br><br>In both cases, &quot;bitb=
ake-setup init&quot; completes successfully.<br><br>I also rebased my Pytho=
n packaging changes and hope to push the patches soon.<br><br>Regards,</div=
><div>Rob</div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 15, 2026 at 9:53=E2=80=AFA=
M Rob Woolley via <a href=3D"http://lists.openembedded.org">lists.openembed=
ded.org</a> &lt;rob.woolleywr=3D<a href=3D"mailto:gmail.com@lists.openembed=
ded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Alex,<div><br>=
</div><div>Thanks! I will give this a try.</div><div><br></div><div>I have =
a need to be able to use bitbake-setup for air-gapped builds. I will experi=
ment with how we might make this work for situations where <a href=3D"http:=
//git.openembedded.org" target=3D"_blank">git.openembedded.org</a> is unava=
ilable.=C2=A0 (In the past I have used git &quot;insteadof&quot; to accompl=
ish this)</div><div><br>Regards,</div><div>Rob</div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 14, 2026 at=
 6:33=E2=80=AFAM Alexander Kanavin via <a href=3D"http://lists.openembedded=
.org" target=3D"_blank">lists.openembedded.org</a> &lt;alex.kanavin=3D<a hr=
ef=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gmail.com@=
lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">From: Alexander Kanavin &lt;<a href=3D"mailto:alex@li=
nutronix.de" target=3D"_blank">alex@linutronix.de</a>&gt;<br>
<br>
If bitbake-setup is packaged and obtained from pypi, or another package fee=
d<br>
it needs to be able to find standard configurations. It is not impossible<b=
r>
to package configurations into some location inside the package<br>
and add logic to find them, but it is much easier to just fetch the bitbake=
<br>
repo and use that as a configuration registry. The other benefit is that<br=
>
such packaged/installed bitbake-setup will not have to be updated in order<=
br>
to obtain latest configurations: it will simply check the registry and fetc=
h<br>
them as needed, which is the original intent of config registries as repos.=
<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 15 ++++++++++++---<br>
=C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 2c2b6d8ec..4ed06fc62 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -21,8 +21,6 @@ import signal<br>
=C2=A0import functools<br>
=C2=A0import string<br>
<br>
-default_registry =3D os.path.normpath(os.path.dirname(__file__) + &quot;/.=
./default-registry&quot;)<br>
-<br>
=C2=A0bindir =3D os.path.abspath(os.path.dirname(__file__))<br>
=C2=A0sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), &#39;lib&#39=
;)]<br>
<br>
@@ -37,6 +35,17 @@ GLOBAL_ONLY_SETTINGS =3D (<br>
=C2=A0 =C2=A0 =C2=A0&quot;top-dir-name&quot;,<br>
=C2=A0)<br>
<br>
+# If bitbake is from a release tarball or somewhere like pypi where<br>
+# updates may not be straightforward, prefer to use the git repo as the<br=
>
+# default registry<br>
+def get_default_registry():<br>
+=C2=A0 =C2=A0 internal_registry =3D os.path.normpath(os.path.dirname(__fil=
e__) + &quot;/../default-registry&quot;)<br>
+=C2=A0 =C2=A0 git_registry =3D &quot;git://<a href=3D"http://git.openembed=
ded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster" rel=3D"noref=
errer" target=3D"_blank">git.openembedded.org/bitbake;protocol=3Dhttps;bran=
ch=3Dmaster;rev=3Dmaster</a>&quot;<br>
+=C2=A0 =C2=A0 if os.path.exists(os.path.dirname(__file__) + &quot;/../.git=
&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return internal_registry<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_registry<br>
+<br>
=C2=A0def cache_dir(top_dir):<br>
=C2=A0 =C2=A0 =C2=A0return os.path.join(top_dir, &#39;.bitbake-setup-cache&=
#39;)<br>
<br>
@@ -1084,7 +1093,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0builtin_settings[&#39;default&#39;] =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;top-dir-prefix&#39;:os.getcwd(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;top-dir-name&#39;:&#39;bitbake-builds&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;registry&#39;:default_registry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;registry&#39;:get_default_registry(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;use-full-setup-dir-name&#39;:&#39;no&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;common-sstate&#39;:&#39;yes&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.47.3<br>
<br>
<br>
<br>
<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18782): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18782" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18782</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117259398/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/117259398/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000009b1a5a0648d85d15--

