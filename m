Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B91CA5FED
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 16:40:38 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.518.1791304832680537549
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Oct 2026 09:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BAZ3HhOY;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: setairidis@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20c95e412so7554931fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 09:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791304831; cv=none;
        d=google.com; s=arc-20260327;
        b=fP0N1lphnEKPRRbCSwjiP5N7eIdK5eEg++xK3BSoPuFxIBlktoo8QyDX2cIygwNJ9N
         WP/baF75sdVnRyTssdO791TjfqXWNgL66x5+rE2AT6rHvFJP7wgp0dHcDurLwZXmERYI
         i2z+YuixKXNkU01q9+0H1jH8nvanH9mscaXXOe5l0t6h46DXp3tCX0HOFLjE+SSWhw+3
         N4GNOhS7eWR1LLwi02MGio2osRyFSieew5D/AJgLDmzxvUsEpUquBgPhlwQGWh75J4B4
         X/AIMxxkOkAUNWixqdPRNly4Ri4cyq83Y8fhVjNEbzT1p7c13ufUpuMn+5U1bGupmOCp
         divg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pSAsFLvZ/ODh76ZdZ72cJU1CHYa3fvKBuXfNJRYh4Oo=;
        fh=dtYYFBMK5CW3AibVUG9VO8wj3/FXF3iz2pjNzKpyonM=;
        b=Tp/0coOpOiO4ibemCQgn3AwdmLb2Ppk8iLIu7QvaZvnis2M2aJgwKPd/VhxZK4+9FG
         zwrI9jE7rnCw3tKzB1dLKUqShupLgRMAakdWJYdgMY/HZ956eqOECIGSOo7TnwrNS/7r
         6DLPh8RqpfqjkpuqqInwiG9mV/tdp3kexelNOXPv6E1wNFqQc2eUlCisIS+vyAA4AWRW
         BnyHhOKVaDOA9oQ8WL/P3C6NAO8SE71x55nqvrhzPvk3KOvBo22IKmJSUwILH4jFStPz
         H1eMoI3yeHNdZZSusmdaSPY0qEJQ58j/aFVZ6Kt3tsISMbrp7itky8UbMd+i+ciBg3JU
         ov4g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791304831; x=1791909631; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSAsFLvZ/ODh76ZdZ72cJU1CHYa3fvKBuXfNJRYh4Oo=;
        b=BAZ3HhOYNG80bad6+m2VNls9TFcnQl468Bs06shzkzEMgw02/h1HgdZPMZai4iX0qr
         aKvY70KFnAfXgEkeCgQ1HK4VWgFEaPHhHOtE6c0zXpDRSBuy2+CB+GYIJYjwpVE8NGJv
         CufdYVJKvaCuFSvJXLKvWSOBgnzBXgC85AZabwAurACHmiOVb/GLS50EqXUvEr1PO485
         abGkAjQ/YnST9ohV4xBfPb2xPF3yumheavQhsP0igaioqm7Nf2kxo/yRsfv/mOYGIOuM
         jPRK81Cgo2nY6pDL/itwPz5W2rHyulypY0hl5nghAnUcWPeryHHcQVqkmdIFoVnQw4pD
         DsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791304831; x=1791909631;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pSAsFLvZ/ODh76ZdZ72cJU1CHYa3fvKBuXfNJRYh4Oo=;
        b=2m0r0ouDqw8mw1T7iPKfh+8fsjpM6RVRGDT3dTCCpFf4TBDo7xb9JEXFRNEEE0x9G6
         /5rqp1rRo+wirwnRHZ8rftsXU8vzZPmTBN5a9aMhmHuDFVI2+u8gb/mDTduJ1/K+VrRk
         lBTZS0LgtVVO406TiiXtSDZvYq7hr1NUxFXNBtv2xQHPk+8skiYwqKitZ7kMlppdj79M
         1By3JNPqGRq3MlP5ys7s7PjlGuL7DLGprnwmSYAz7LFm3Medj+CDzcKsqlY8oKvkm5LP
         63HH8NK9vFmsReN+JZkRpwXNBnfJJU1THrGMGJIMJqvlCnQNlk4GuISx1a4KcKTQ0LJr
         a/jQ==
X-Gm-Message-State: AFq9FYJUoVyIn0BpI67yi0MrUeT1ON2xnhIZBc0dNlR/1xtouvLwWkHq
	WAh0iRA0M/XKXpfi0doFnBZtqd8I0Isa0Pqlw+PcgoK0SDOpcUmfEHnIQq9BL5c1FLqFcquFnqj
	Chs0RWALZVMTTWIOjudf7243Hy/nBzCk=
X-Gm-Gg: AYBFou2KsapBDf7Kk+RAGb2322apJ79G9ohtzwq3g580V6ARjmYCtQ+Fz4fDP6ahPU/
	IUtQ42OljKwkmmcRn1SqgBwwGqBsdJCNLTlZSC6gv+697rMD/1DQOsmJcUVyb2VkjXr5LWECxka
	IxFn9FupSLHbrXy0yJYHKmH8cBNtRXgv8tqJG8Tac7AmeHCdbsDKWez3LmxvaucXigyy4LIOSYS
	+n+6YuIRE8pkLE+OFaYHH6zGh4zlVP8OY8OestbE6KXIlBeOZlDbxNoa/wpVD97ukwTDK3k2lj9
	GXqSGJxSG6KyWDagFyKW9cTy89HRXbVr1fcsC43RMcpSthFVNYkFUgbXYM68IIfCca5wxhKL+9D
	v4bhqhaodJg3pXw==
X-Received: by 2002:a2e:be91:0:b0:3a4:9e40:d7fb with SMTP id
 38308e7fff4ca-3a99acf0edfmr4525091fa.7.1791304830556; Tue, 06 Oct 2026
 09:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJXz6ecab40e-HXeYqSNNLcMK=Prrrgytq6qiqus6pCb3vPGQ@mail.gmail.com>
 <20261002205054.72441-1-setairidis@gmail.com> <4db70d3630cc76a86d7c388ef142af1a7699853e.camel@pbarker.dev>
In-Reply-To: <4db70d3630cc76a86d7c388ef142af1a7699853e.camel@pbarker.dev>
From: Sawas Etairidis <setairidis@gmail.com>
Date: Tue, 6 Oct 2026 18:40:19 +0200
X-Gm-Features: AclHuK-mg9VHr1zagU9ASvl4whfJI7yLZ7ZQz6sFsw2n8S0ygUMVJn11a67EolY
Message-ID: <CAKJXz6fQSkK6_WhpWT5E3dfgxXSs8vtepQuESg2aXBZLvushcw@mail.gmail.com>
Subject: Re: [PATCH v8] fetch/local: verify checksums for file:// urls
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001c1fba065d2ea8d4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 16:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20299

--0000000000001c1fba065d2ea8d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Path of least resistance: I noticed the isinstance check above and thought
it was acceptable.
My bad I sends this as a personal response previously.

Regards,
Savvas

=CE=A3=CF=84=CE=B9=CF=82 =CE=94=CE=B5=CF=85 5 =CE=9F=CE=BA=CF=84 2026 =CF=
=83=CF=84=CE=B9=CF=82 4:36=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Paul Barke=
r <paul@pbarker.dev>
=CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> On Fri, 2026-10-02 at 22:50 +0200, Savvas Etairidis wrote:
> > [YOCTO #9993]
> >
> > A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
> > UNINATIVE_URL points at a local file://) was never verified, because
> > Local disables the donestamp and so verify_checksum() was never called.
> > Enable the donestamp for file:// urls that carry a checksum.
> >
> > Based on a patch by Jhonata Poma-Hansen.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
> >
> > ---
> > changes in v8:
> > - Dropped the local-checksums stamps and re-used the regular donestamp,
> >   enabled only for file:// urls with a checksum. local.py is unchanged
> >   again.
> > - Tests reduced to a checksum match and a mismatch test.
> > - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetc=
h
> >
> > changes in v7:
> > - We shouldn't assume that anything coming from a file:// URL is
> >   "typically small", or that it is on fast local storage (it could be o=
n
> a
> >   HDD array accessed over NFS).
> > * Rework the code to avoid re-hashing the file on every fetch, and
> >   instead only re-hash it when the checksum is actually expected to be
> verified.
> > - You don't need to mention this if it didn't result in actual change.
> > * Wont do in the future.
> > - Such as? This is a completely different approach so it's useful to kn=
ow
> >   which bits of feedback were actually relevant and which were made
> >   obsolete by the change in approach.
> > * Hoped I did better this time.
> > - What does "edited with an old mtime" mean?
> > * In that test the file attributes are modified to have an old mtime,
> >   which is a corner case that was not handled correctly before.
> >   This test was removed in v6 because the new approach doesn't have
> >   that issue anymore.
> > - Why complicate this by using different hash algorithms for the
> different
> >   tests?
> >   The test wants to cover the case where we have a valid md5sum but an
> >   invalid sha256sum or a invalid md5sum but a valid sha256sum.
> > - Added a test to covern new functionality.
> >
> > changes in v6:
> > - Rebased on top of master
> > - Fixed issues reported by reviewer
> > - Check the file directly in Local.verify_donestamp(), via a new
> >   FetchData.verify_checksum_if_expected() helper, instead of enabling
> >   the donestamp. Fixes stale checksums for files edited with an old
> >   mtime and DL_DIR stamp/lock path collisions
> > - Drop the rename_bad_checksum() refactor, no longer needed
> > - Document the cost of re-hashing on every fetch
> > - Tests: use a correct md5sum and a wrong sha256sum in the mismatch
> >   test, add a test for a file edited with an old mtime, and check that
> >   nothing is written to DL_DIR
> > - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetc=
h
> >
> > changes in v5:
> > - Rebased on top of master, added changelog entry
> >
> > changes in v4:
> > - Rebased on top of master
> >
> > changes in v3:
> > - Cherry-picked the patch from Jhonata Poma-Hansen
> >
> > ---
> > ---
> >  lib/bb/fetch/__init__.py | 16 ++++++++++++++++
> >  lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> > index eb3483a48..6401ce1b8 100644
> > --- a/lib/bb/fetch/__init__.py
> > +++ b/lib/bb/fetch/__init__.py
> > @@ -1087,6 +1087,10 @@ def rename_bad_checksum(ud, suffix,
> localpath=3DNone):
> >      if ud.localpath is None:
> >          return
> >
> > +    # A file:// url refers to the user's own file, leave it in place
> > +    if isinstance(ud.method, local.Local):
> > +        return
>
> Adding special cases in the base fetcher code is poor design and
> complicates maintenance. Why have you taken this approach instead of
> making rename_bad_checksum() a method of the Fetch class and overriding
> it as you did in v4 of this patch? I'm looking for an explanation not a
> v9 patch.
>
> Best regards,
>
> --
> Paul Barker
>
>

--0000000000001c1fba065d2ea8d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Path of least resistance: I noticed=
 the isinstance check above and thought it was acceptable.</div><div>My bad=
 I sends this as a personal response previously.</div><div><br></div><div>R=
egards,</div><div>Savvas</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">=CE=A3=CF=84=CE=B9=CF=
=82 =CE=94=CE=B5=CF=85 5 =CE=9F=CE=BA=CF=84 2026 =CF=83=CF=84=CE=B9=CF=82 4=
:36=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Paul Barker &lt;<a href=3D"mailto=
:paul@pbarker.dev">paul@pbarker.dev</a>&gt; =CE=AD=CE=B3=CF=81=CE=B1=CF=88=
=CE=B5:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, =
2026-10-02 at 22:50 +0200, Savvas Etairidis wrote:<br>
&gt; [YOCTO #9993]<br>
&gt; <br>
&gt; A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when<br>
&gt; UNINATIVE_URL points at a local file://) was never verified, because<b=
r>
&gt; Local disables the donestamp and so verify_checksum() was never called=
.<br>
&gt; Enable the donestamp for file:// urls that carry a checksum.<br>
&gt; <br>
&gt; Based on a patch by Jhonata Poma-Hansen.<br>
&gt; <br>
&gt; AI-Generated: Uses Claude Code (Claude Opus 5.5)<br>
&gt; Signed-off-by: Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail=
.com" target=3D"_blank">setairidis@gmail.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; changes in v8:<br>
&gt; - Dropped the local-checksums stamps and re-used the regular donestamp=
,<br>
&gt;=C2=A0 =C2=A0enabled only for file:// urls with a checksum. local.py is=
 unchanged<br>
&gt;=C2=A0 =C2=A0again.<br>
&gt; - Tests reduced to a checksum match and a mismatch test.<br>
&gt; - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fet=
ch<br>
&gt; <br>
&gt; changes in v7:<br>
&gt; - We shouldn&#39;t assume that anything coming from a file:// URL is<b=
r>
&gt;=C2=A0 =C2=A0&quot;typically small&quot;, or that it is on fast local s=
torage (it could be on a<br>
&gt;=C2=A0 =C2=A0HDD array accessed over NFS).<br>
&gt; * Rework the code to avoid re-hashing the file on every fetch, and<br>
&gt;=C2=A0 =C2=A0instead only re-hash it when the checksum is actually expe=
cted to be verified.<br>
&gt; - You don&#39;t need to mention this if it didn&#39;t result in actual=
 change.<br>
&gt; * Wont do in the future.<br>
&gt; - Such as? This is a completely different approach so it&#39;s useful =
to know<br>
&gt;=C2=A0 =C2=A0which bits of feedback were actually relevant and which we=
re made<br>
&gt;=C2=A0 =C2=A0obsolete by the change in approach.<br>
&gt; * Hoped I did better this time.<br>
&gt; - What does &quot;edited with an old mtime&quot; mean?<br>
&gt; * In that test the file attributes are modified to have an old mtime,<=
br>
&gt;=C2=A0 =C2=A0which is a corner case that was not handled correctly befo=
re.<br>
&gt;=C2=A0 =C2=A0This test was removed in v6 because the new approach doesn=
&#39;t have<br>
&gt;=C2=A0 =C2=A0that issue anymore.<br>
&gt; - Why complicate this by using different hash algorithms for the diffe=
rent<br>
&gt;=C2=A0 =C2=A0tests?<br>
&gt;=C2=A0 =C2=A0The test wants to cover the case where we have a valid md5=
sum but an<br>
&gt;=C2=A0 =C2=A0invalid sha256sum or a invalid md5sum but a valid sha256su=
m.<br>
&gt; - Added a test to covern new functionality.<br>
&gt; <br>
&gt; changes in v6:<br>
&gt; - Rebased on top of master<br>
&gt; - Fixed issues reported by reviewer<br>
&gt; - Check the file directly in Local.verify_donestamp(), via a new<br>
&gt;=C2=A0 =C2=A0FetchData.verify_checksum_if_expected() helper, instead of=
 enabling<br>
&gt;=C2=A0 =C2=A0the donestamp. Fixes stale checksums for files edited with=
 an old<br>
&gt;=C2=A0 =C2=A0mtime and DL_DIR stamp/lock path collisions<br>
&gt; - Drop the rename_bad_checksum() refactor, no longer needed<br>
&gt; - Document the cost of re-hashing on every fetch<br>
&gt; - Tests: use a correct md5sum and a wrong sha256sum in the mismatch<br=
>
&gt;=C2=A0 =C2=A0test, add a test for a file edited with an old mtime, and =
check that<br>
&gt;=C2=A0 =C2=A0nothing is written to DL_DIR<br>
&gt; - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fet=
ch<br>
&gt; <br>
&gt; changes in v5:<br>
&gt; - Rebased on top of master, added changelog entry<br>
&gt; <br>
&gt; changes in v4:<br>
&gt; - Rebased on top of master<br>
&gt; <br>
&gt; changes in v3:<br>
&gt; - Cherry-picked the patch from Jhonata Poma-Hansen<br>
&gt; <br>
&gt; ---<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch/__init__.py | 16 ++++++++++++++++<br>
&gt;=C2=A0 lib/bb/tests/fetch.py=C2=A0 =C2=A0 | 30 ++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 2 files changed, 46 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py<br>
&gt; index eb3483a48..6401ce1b8 100644<br>
&gt; --- a/lib/bb/fetch/__init__.py<br>
&gt; +++ b/lib/bb/fetch/__init__.py<br>
&gt; @@ -1087,6 +1087,10 @@ def rename_bad_checksum(ud, suffix, localpath=
=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ud.localpath is None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 # A file:// url refers to the user&#39;s own file, leav=
e it in place<br>
&gt; +=C2=A0 =C2=A0 if isinstance(ud.method, local.Local):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
<br>
Adding special cases in the base fetcher code is poor design and<br>
complicates maintenance. Why have you taken this approach instead of<br>
making rename_bad_checksum() a method of the Fetch class and overriding<br>
it as you did in v4 of this patch? I&#39;m looking for an explanation not a=
<br>
v9 patch.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div>

--0000000000001c1fba065d2ea8d4--

