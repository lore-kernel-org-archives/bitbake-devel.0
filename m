Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF13C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:55:37 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web11.690.1698764130663852894
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PtgbZafG;
 spf=pass (domain: gmail.com, ip: 209.85.219.172, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5259998276.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698764130; x=1699368930; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMpNuSaNE5ozRgzGHpnVWxq0p5E0K619u2VGY0xUhOM=;
        b=PtgbZafGJuqIqvMsGPQhmCd6LeQOl3OJQLd9as4LxrZIcZ9G7tEdRTi4t88SDdzVny
         3wB+BYT839crvp4PD8Y0LxV6gvzFCM9eflzQEeiPgVSRb6B8poGRTOFTeyaO+zTXcozC
         MbFVuaSDz8AbSRy8fLt2K9BFj+kShp9RsuIrF7XGNPvaMWRQ5ORWiV4829yqHQ2FGnP4
         hucnNCnfeMvBc1fvuEt6RCdaW1pMx7qA20idruLxgWN7p2sWLZOjg3l43Xo9dK1JZBNj
         065VlCmgffBk2neFmIbVca2p7NL9CyY3SFQM/nTS3ecDYNZTj1YWqQ+gXs3BN4Ayda7m
         cZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764130; x=1699368930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMpNuSaNE5ozRgzGHpnVWxq0p5E0K619u2VGY0xUhOM=;
        b=Uei5LL7ZYH1d6a2OyMAXWKCTF8btAUMVGEH2h2QdVjaPw5ixxy/DfczvXkIokoXz3H
         uaD7gNWZnear9DPjb1TazQ3XoR1eW8qOy9hHqSxq4q52IUwk4GYmXB3jkXph1OrrAW+I
         9rC0WfR5Ii2VtP4SzHFxPjZ4W74l6SllpOBbwXZAM3eX4Zf599HBHLodF2UZXJ1yP9el
         yplCaiB5lIACAjp+t+uCcQ3gdf0Yi6q5Ci3oTwjQaWx0yGADcu5cty4YD7AD6wU4sxWl
         eARm2J8ejPudjXQ6Xnvevitvd34AO/sif+YZypfSylI7YF6ylOvKNXoeIRI2jMKoBsim
         EJtQ==
X-Gm-Message-State: AOJu0YxPzWDeO/lToo1LEiUFpumIihsLyVfPcpKAAxEFbGEktxhntacG
	oR+i9baMldBYCI3UGD6G4nprbC+AzVxyabyX3sk=
X-Google-Smtp-Source: AGHT+IHGDXcIevCRZZdibj7S3w2/PgihqOvuV9Vo1jmkRlCzUpgIMJWf+s0IsesPBGKWhteOGqayLvroAYw6FYOnBVE=
X-Received: by 2002:a25:ca0a:0:b0:da0:365c:ff67 with SMTP id
 a10-20020a25ca0a000000b00da0365cff67mr11582138ybg.12.1698764129723; Tue, 31
 Oct 2023 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-5-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-5-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:55:18 -0700
Message-ID: <CANx9H-BdHGUs=n0LAMLpXR+5Fa3O9CCE7E+vjCULNrzvpdaixg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 5/8] Toaster: Bug-fix django.db.utils.IntegrityError:
 Problem installing fixture
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000826bc306090458b8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:55:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15342

--000000000000826bc306090458b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> toastergui-unittest-data.xml fixture contains a release objects with
> name=3D"master" or an release with same name seem existing
>

This is likely because we have a "master" release (the development branch)
in both oe-core.xml and poky.xml
https://git.openembedded.org/bitbake/tree/lib/toaster/orm/fixtures

Those fixtures are very important to provide the expected drop down
menus for choosing a release for a project.

- Change release name and fix bitbakeversion instead of bitbake_version
>

Good catch on the bad "orm.bitbake_version" field, that must have been a
typo.

>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
>
Reviewed-by: Tim Orling <tim.orling@konsulko.com>

> ---
>  lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
> b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
> index 1d522f88..df106934 100644
> --- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
> +++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
> @@ -19,9 +19,9 @@
>       <field type=3D"CharField" name=3D"description">poky_distro2
> description</field>
>    </object>
>    <object pk=3D"1" model=3D"orm.release">
> -     <field type=3D"CharField" name=3D"name">master</field>
> +     <field type=3D"CharField" name=3D"name">foo_master</field>
>       <field type=3D"CharField" name=3D"description">master project</fiel=
d>
> -     <field to=3D"orm.bitbake_version" name=3D"bitbake_version">1</field=
>
> +     <field to=3D"orm.bitbakeversion" name=3D"bitbake_version">1</field>
>    </object>
>    <object pk=3D"1" model=3D"orm.project">
>      <field type=3D"CharField" name=3D"name">a test project</field>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15329):
> https://lists.openembedded.org/g/bitbake-devel/message/15329
> Mute This Topic: https://lists.openembedded.org/mt/102283461/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000826bc306090458b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">toastergui-unittest-data.xml =
fixture contains a release objects with<br>
name=3D&quot;master&quot; or an release with same name seem existing<br></b=
lockquote><div><br></div><div>This is likely because we have a &quot;master=
&quot; release (the development branch) in both oe-core.xml and poky.xml=C2=
=A0</div><div><a href=3D"https://git.openembedded.org/bitbake/tree/lib/toas=
ter/orm/fixtures">https://git.openembedded.org/bitbake/tree/lib/toaster/orm=
/fixtures</a><br></div><div><br></div><div>Those fixtures are very importan=
t to provide the expected drop down menus=C2=A0for choosing a release for a=
 project.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
- Change release name and fix bitbakeversion instead of bitbake_version<br>=
</blockquote><div><br></div><div>Good catch on the bad &quot;orm.bitbake_ve=
rsion&quot; field, that must have been a typo.=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br></blockquote><div>Reviewed-by: Tim Orling &lt;<a href=3D"mailto:t=
im.orling@konsulko.com">tim.orling@konsulko.com</a>&gt;=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml | 4 ++--=
<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b=
/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml<br>
index 1d522f88..df106934 100644<br>
--- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml<br>
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml<br>
@@ -19,9 +19,9 @@<br>
=C2=A0 =C2=A0 =C2=A0 &lt;field type=3D&quot;CharField&quot; name=3D&quot;de=
scription&quot;&gt;poky_distro2 description&lt;/field&gt;<br>
=C2=A0 =C2=A0&lt;/object&gt;<br>
=C2=A0 =C2=A0&lt;object pk=3D&quot;1&quot; model=3D&quot;orm.release&quot;&=
gt;<br>
-=C2=A0 =C2=A0 =C2=A0&lt;field type=3D&quot;CharField&quot; name=3D&quot;na=
me&quot;&gt;master&lt;/field&gt;<br>
+=C2=A0 =C2=A0 =C2=A0&lt;field type=3D&quot;CharField&quot; name=3D&quot;na=
me&quot;&gt;foo_master&lt;/field&gt;<br>
=C2=A0 =C2=A0 =C2=A0 &lt;field type=3D&quot;CharField&quot; name=3D&quot;de=
scription&quot;&gt;master project&lt;/field&gt;<br>
-=C2=A0 =C2=A0 =C2=A0&lt;field to=3D&quot;orm.bitbake_version&quot; name=3D=
&quot;bitbake_version&quot;&gt;1&lt;/field&gt;<br>
+=C2=A0 =C2=A0 =C2=A0&lt;field to=3D&quot;orm.bitbakeversion&quot; name=3D&=
quot;bitbake_version&quot;&gt;1&lt;/field&gt;<br>
=C2=A0 =C2=A0&lt;/object&gt;<br>
=C2=A0 =C2=A0&lt;object pk=3D&quot;1&quot; model=3D&quot;orm.project&quot;&=
gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;field type=3D&quot;CharField&quot; name=3D&quot;nam=
e&quot;&gt;a test project&lt;/field&gt;<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15329): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15329" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15329</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283461/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283461/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000826bc306090458b8--

