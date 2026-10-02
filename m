Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A910CA5FE5
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 20:49:11 +0000 (UTC)
Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4058.1790974150386589842
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Oct 2026 13:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LwtigkvY;
 spf=pass (domain: gmail.com, ip: 74.125.230.98, mailfrom: setairidis@gmail.com)
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a652b710a5so3397831fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 13:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790974148; cv=none;
        d=google.com; s=arc-20260327;
        b=jveM1lByB+4G7Hp/+z/afQ3sGCSce8P/OzwbkQEGw0R88u6fNSDY0xonCSgA9QQecn
         r4/KcJtsmz3tQ4WU1rdwGEJAjGhE0ocO0ApmpFXhjN/4O09QIujoY5TaUlNIjcXrsTxV
         Mh0tKK8Q+PdNDITdx7HQSLtVOdp+g9Fld6UM2z8nxrs16+bMypqlsES30fNEEs4SEgI0
         ISDH2XeUfm2TKOMsjlA3YBnpdfOSO6/2yCBUqoYp9dbaS7AZ+wU8rTQ2ZLObvbrecvkb
         w4OO71JyRXay/xQxXUxTsaaw8jbrj5jcWvHk1zcbfgnJdwl37fk0ASPQV5A0/v25fZlx
         ESRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cu3DexCStxYRsOfjtHb78//CqqZqBNYRUKJpWXXRP2w=;
        fh=dtYYFBMK5CW3AibVUG9VO8wj3/FXF3iz2pjNzKpyonM=;
        b=lVIZ6fqIUbtRcgVS2BQNRNWBcKW9Hnv1oh28XiO3rEGsJJyc0/ajy5B3Zeww46SJgZ
         pACf4y+KNQ/0oDkFWMrRaQrGj6s/bxVVPjPJoIiqiA6cZppT86l5jrbDNQkPsPSWc18a
         jwRNUcR6VtUFGSNXq2HHnPkl/useGT9PYlQZAVHZc8bI1sieoQ0X8r8WOjCuZVR6EW3R
         bPRcc32jxcucYh0R45Gl5RU0ttCxk1x6cj4V1VLrKXfQygZZHUXTip0FXoga6kSocNT5
         6bqzz5cFmgdDiqEOjP03VHKDBEMVqdgOJZO2b0sNSDxBcfJmYjgkQgSWG2QmdCTtcmnG
         ZIZg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790974148; x=1791578948; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cu3DexCStxYRsOfjtHb78//CqqZqBNYRUKJpWXXRP2w=;
        b=LwtigkvYcx+3SgQLZTcyivL3ASfF3kMjWxdob4MZ1o4Y4p9rvM6vbCnw4U5WZCkalr
         ilz2PrfcYg54VGt+y1O3fwqkTZqTN17zUOKIgT7ZKeaqcb89Jtsgb0CLHQs7OXp0PGdc
         0uYV+KqMf/z64U+eTp0x5ZBG00PUdkHNl9SHY583skFmOiCQ1HlADL/xne4yNXCGBFWx
         3l6V+m3OTLh/4ZVYGRq4fLIgyyaou/zWTOx2R4y7+a7Gz4iVIy7VaCLNeCGWHR2hbBKE
         rve3gycZHLHCx9Jd0MjBZ9YD4fxSmiUr11H7IVEqe8ftaUcB/rO2Omq2zMM0KbGEvAj2
         zhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974148; x=1791578948;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cu3DexCStxYRsOfjtHb78//CqqZqBNYRUKJpWXXRP2w=;
        b=k7MlyNKdZP2ZCRriGeqjYDKqjDEb+WgTTCpI0GPrgBjKwRHjJEFmrynup/oUVHCJKz
         S3BQk0VQrCn05cozLb/gYcDL0/IhrqjBmW2WwGKVT0/UrXe/9/HPmhGic9iT6YDiL8zL
         lZF1Wx3+YRnRxXtu7td63dxOsLj/Zl0av4Czp4a13QE0R6mfeVzON5STmlGu3gJqbJF5
         tsmriVSQYEr6JE5yQ/iVsY2VqEKb8ZAbBv4XcRGXZoOStUA6d2CIOra97iWGavcHcg64
         8G2igIaHsDXm3ggPM2697sDlcsy81uYgNUjehLDzHG0BdT1+SbyjRZwieyJziMoXdVhd
         52eA==
X-Gm-Message-State: AFq9FYI8DQi6xdX8oYRineeWdjgO2VkKdUDenc0/eZ70PKTQjRer0aIp
	KsEoW3PU/rzJ+3KBSem6B6MRlfSa+sw2XFyXbHF9clrjoeNasm06lR1TmPcIEu/NQrBXIDhAWxg
	duQiFXrGJ2ScXyy3UJt5VPafirXEJFCY=
X-Gm-Gg: AYBFou2N/Rt4aREp3Zyj1P+09rh2SUP4j+RYEQoqVbgl4+1zcv3pDmGUU8Fpgfbcop+
	GdubRTJB1rXCSTdl33UiswPKgA2L6ejrZ1YRFTPLyblPk9FGDiNQ8MVMprdxS5EwQAxdaVKbpne
	dKB0WTQcPLEPBFE2AMYq4nxZdcT5RERLiqEPOe2biJ6cebdvZzNmKSiWBIDwO7rWp01331+1X/5
	mpdtJYygXDdg8IiLi/fnkFtI2z7Uk3myehUs1oOcNOTrgug1ObWRBufq5lwUm59StgdHRiHhJhH
	o5XP18k3DIVj7X+Vmpi+kU4OuKJUwR+I8KuJtphsHLR3vS07IbE4epqbh4mpPaxe7XjbEwJJH36
	QabLsZ2HsxzE/5Q==
X-Received: by 2002:a2e:bc29:0:b0:3a7:7a0e:56ef with SMTP id
 38308e7fff4ca-3a887678f0dmr10414351fa.4.1790974148152; Fri, 02 Oct 2026
 13:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <abf12d51916cac8780914605168243c54494ca32.camel@pbarker.dev>
 <20261001205344.99638-1-setairidis@gmail.com> <5ca946b125e9eb46bde8e236c4a04eaa06ff45af.camel@pbarker.dev>
In-Reply-To: <5ca946b125e9eb46bde8e236c4a04eaa06ff45af.camel@pbarker.dev>
From: Sawas Etairidis <setairidis@gmail.com>
Date: Fri, 2 Oct 2026 22:48:56 +0200
X-Gm-Features: AclHuK9i2Ms4SYI3H3wBsp8t1nBYDwLWyyKUiObEZ2yfMpuUI8SKajC7Tg_sMKw
Message-ID: <CAKJXz6ecab40e-HXeYqSNNLcMK=Prrrgytq6qiqus6pCb3vPGQ@mail.gmail.com>
Subject: Re: [PATCH v7] fetch/local: verify checksums for file:// urls
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e71373065ce1a926"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 20:49:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20292

--000000000000e71373065ce1a926
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The new stamp file mechanism was there to cover the following case:

Developer A builds with file:///mnt/nas/foo.tar.xz;sha256sum=3D<X>, which
caches the file's checksums in a donestamp. Developer B then replaces the
file on the NAS with an older version that keeps its older timestamp (e.g.
mv, cp -p, rsync -a). On A's next build the file is older than the
donestamp, so the cached checksums are trusted and B's file is used in
place without being hashed, even though it no longer matches <X>.

As that was a larger code change, it needed more unit tests.
To me it is better to have one test too many than one too few, with
priority given to edge cases, as long as the tests take seconds or less
to run.

I will send a new version where the existing donestamp is enabled for
file:// urls that have a checksum, with the two original unit tests: one
for a matching checksum and one for a mismatch. Note that this version
does not cover the case above.

Regards,
Savvas


=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=B1=CF=81 2 =CE=9F=CE=BA=CF=84 2026 =CF=
=83=CF=84=CE=B9=CF=82 10:50=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 Paul Bark=
er <paul@pbarker.dev>
=CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> On Thu, 2026-10-01 at 22:53 +0200, Savvas Etairidis wrote:
> > [YOCTO #9993]
> >
> > A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
> > UNINATIVE_URL points at a local file://) was never verified, because
> > Local disables the donestamp and so verify_checksum() was never called.
> > Override verify_donestamp() in Local to check the file against those
> > checksums. A mismatch raises ChecksumError before the rename/mirror
> > handling, so the user's file is never renamed.
> >
> > Based on a patch by Jhonata Poma-Hansen.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
> >
> > ---
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
>
> This is now inventing a new stamp file mechanism, and the tests are
> significantly more complicated than they were in the previous version of
> the patch. I'm sorry to say that this is moving further away from a
> solution that we can merge, instead of closer to one.
>
> This should look like the other fetchers and use the existing done
> stamps mechanism. That may not be able to detect changes in files if the
> mtime is moved backwards, but the local filesystem is not a security
> boundary so this is probably ok. It's also better to get something in
> place and document the limitations in the bugzilla entry rather than
> continuing to iterate and add complexity.
>
> There is also no need to test with different hash algorithms here. Two
> simple test cases, one for a matching checksum and one for a mismatch,
> should be enough, and they should use the same hash algorithm for
> consistency. The different hash algorithms should be tested in separate
> unit tests that focus on those features. AI tools really get carried
> away when adding test cases and some judgement is definitely needed to
> keep them under control.
>
> Best regards,
>
> --
> Paul Barker
>
>

--000000000000e71373065ce1a926
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>The new stamp file mechanism was th=
ere to cover the following case:</div><div><span style=3D"background-color:=
transparent"><br></span></div><div><span style=3D"background-color:transpar=
ent">Developer A builds with file:///mnt/nas/foo.tar.xz;sha256sum=3D&lt;X&g=
t;, which</span></div><div>caches the file&#39;s checksums in a donestamp. =
Developer B then replaces the<br>file on the NAS with an older version that=
 keeps its older timestamp (e.g.<br>mv, cp -p, rsync -a). On A&#39;s next b=
uild the file is older than the</div><div>donestamp, so the cached checksum=
s are trusted and B&#39;s file is used in<br>place without being hashed, ev=
en though it no longer matches &lt;X&gt;.</div><div><br></div><div><span st=
yle=3D"background-color:transparent">As that was a larger code change, it n=
eeded more unit tests.=C2=A0</span></div><div><span style=3D"background-col=
or:transparent">To me it is better to have one test too many than one too f=
ew, with</span></div><div><span style=3D"background-color:transparent">prio=
rity given to edge cases, as long as the tests take seconds or less</span><=
/div>to run.<div><br></div><div>I will send a new version where the existin=
g donestamp is enabled for</div><div>file:// urls that have a checksum, wit=
h the two original unit tests: one<br>for a matching checksum and one for a=
 mismatch. Note that this version<br>does not cover the case above.</div><d=
iv><br></div><div>Regards,</div><div>Savvas</div><div><br></div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=B1=CF=81 2 =CE=9F=CE=BA=CF=84=
 2026 =CF=83=CF=84=CE=B9=CF=82 10:50=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 =
Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev">paul@pbarker.dev</a>&gt=
; =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Thu, 2026-10-01 at 22:53 +0200, Savvas Etairidis=
 wrote:<br>
&gt; [YOCTO #9993]<br>
&gt; <br>
&gt; A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when<br>
&gt; UNINATIVE_URL points at a local file://) was never verified, because<b=
r>
&gt; Local disables the donestamp and so verify_checksum() was never called=
.<br>
&gt; Override verify_donestamp() in Local to check the file against those<b=
r>
&gt; checksums. A mismatch raises ChecksumError before the rename/mirror<br=
>
&gt; handling, so the user&#39;s file is never renamed.<br>
&gt; <br>
&gt; Based on a patch by Jhonata Poma-Hansen.<br>
&gt; <br>
&gt; AI-Generated: Uses Claude Code (Claude Opus 5.5)<br>
&gt; Signed-off-by: Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail=
.com" target=3D"_blank">setairidis@gmail.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
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
<br>
This is now inventing a new stamp file mechanism, and the tests are<br>
significantly more complicated than they were in the previous version of<br=
>
the patch. I&#39;m sorry to say that this is moving further away from a<br>
solution that we can merge, instead of closer to one.<br>
<br>
This should look like the other fetchers and use the existing done<br>
stamps mechanism. That may not be able to detect changes in files if the<br=
>
mtime is moved backwards, but the local filesystem is not a security<br>
boundary so this is probably ok. It&#39;s also better to get something in<b=
r>
place and document the limitations in the bugzilla entry rather than<br>
continuing to iterate and add complexity.<br>
<br>
There is also no need to test with different hash algorithms here. Two<br>
simple test cases, one for a matching checksum and one for a mismatch,<br>
should be enough, and they should use the same hash algorithm for<br>
consistency. The different hash algorithms should be tested in separate<br>
unit tests that focus on those features. AI tools really get carried<br>
away when adding test cases and some judgement is definitely needed to<br>
keep them under control.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div>

--000000000000e71373065ce1a926--

