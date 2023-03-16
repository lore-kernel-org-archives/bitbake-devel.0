Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E3C74A5B
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:37:17 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.10894.1678970227235788100
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Y/KmQYma;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id h9so1527742ljq.2;
        Thu, 16 Mar 2023 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678970225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=feTMGz5B121/r+nj9lgyMBZ9En8jZ7kh75F/1P74wY4=;
        b=Y/KmQYmaLoGTX8MGJI0qZC/yQhiVRKFctYfSOkjc+rzQHp9CCzc3PGXr6Z3AvwKcMZ
         pt2GqrESAwJadWDRqCAhKTdUq/rPu9N8/XO9KWcUNfxJ06GbEPeD6JDN0WW70f/ZS3Pr
         f0fvwhhio8L7CVeulmvipbLRwj9fG4LjmRZhgLvdIs6txWQF/sq1hC07Y39QwsJM9KzY
         RBa8qqMZkZGSkbsOqbT/DLCG9HJ0CS73GrS4Vo2JN3ZXFA5Pq/dE0Wcc6akfcelL1m1w
         tuqWNFyX/iZ+EiGFM+iaFfhAiPjZ8zAve6Woo9n1bruBr58IkJ2SXnQhxByM4aUySJs/
         OWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678970225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feTMGz5B121/r+nj9lgyMBZ9En8jZ7kh75F/1P74wY4=;
        b=2jBhMjKdYE3g6s+jUKUtXG7GNIom5RFqyO3CpXy6j4hSXXSB1MWVxlbYyI7EgNf9kt
         Jf0RSlPeK+XrGB1YSBbSkHEsNYhKuWhZi1Tu7+g4oCg9YMsUHt9t22SogOyeJnFFk7vn
         EDtFA66+WmBMzVESEx6JN6SSufERvOoAlAqwA2yokVg1D02xGBmKpda8gxqPMZdcq4gT
         L2pbXYFbzLp0v9YpFfHF1ZlFPy0noOaMEYvu8y08vmTknI6xwE0RDQ4mS88wk0wnhXDb
         reObitLYGcZdZ6a9BbjaXmVh7GYQJrV0RjXa7Htf99sxxD3SKr2UWDlOvX1NIunL42P1
         msNA==
X-Gm-Message-State: AO0yUKVQBbCF2hul4y2iSWtNdS5ys5FOImSwfoIapUhtCAGoR3QK3uYy
	PtelExgtuBFLz4hJwOErdH5Ri6Tyv0q3As573/c6fCp7
X-Google-Smtp-Source: AK7set88+BbtGg5NI605BoGcCjKN91GSQC+3CEXdQlUNO5YmCV7kHQTK5H7WY2lJT4u6bRBv/XtABGBHY6BLgccGjoo=
X-Received: by 2002:a05:651c:490:b0:295:a82e:ec06 with SMTP id
 s16-20020a05651c049000b00295a82eec06mr2057356ljc.3.1678970224947; Thu, 16 Mar
 2023 05:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230316121249.28209-1-frederic.martinsons@gmail.com>
In-Reply-To: <20230316121249.28209-1-frederic.martinsons@gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 16 Mar 2023 13:36:53 +0100
Message-ID: <CA+cAkeoO-QE7-mJ=VDrw5hL0NMptR7N33x-tO-TZNc+G3WqsEQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cargo-update-recipe-crates: generate checksum for
 each crates
To: openembedded-core@lists.openembedded.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d8b88a05f703b7d0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:37:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14589

--000000000000d8b88a05f703b7d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I messed up with the different mailing list, this patch series
should be for openembedded-core

Le jeu. 16 mars 2023, 13:12, <frederic.martinsons@gmail.com> a =C3=A9crit :

> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>
> This is related to checksum verification introduction from
>
> https://patchwork.yoctoproject.org/project/bitbake/patch/20230315131513.5=
0635-1-frederic.martinsons@gmail.com/
>
> I also choose to raise an exception if:
>  - no crates can be found
>  - no Cargo.lock file exist
>
> Otherwise the generated inc file will silently be emptied.
>
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> ---
>  .../cargo-update-recipe-crates.bbclass        | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/meta/classes-recipe/cargo-update-recipe-crates.bbclass
> b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
> index 697460d215..daa363b0dd 100644
> --- a/meta/classes-recipe/cargo-update-recipe-crates.bbclass
> +++ b/meta/classes-recipe/cargo-update-recipe-crates.bbclass
> @@ -16,11 +16,14 @@
>  addtask do_update_crates after do_patch
>  do_update_crates[depends] =3D "python3-native:do_populate_sysroot"
>  do_update_crates[nostamp] =3D "1"
> +do_update_crates[doc] =3D "Update the recipe by reading Cargo.lock and
> write in ${THISDIR}/${BPN}-crates.inc"
>
>  # The directory where to search for Cargo.lock files
>  CARGO_LOCK_SRC_DIR ??=3D "${S}"
>
>  do_update_crates() {
> +    TARGET_FILE=3D"${THISDIR}/${BPN}-crates.inc"
> +
>      nativepython3 - <<EOF
>
>  def get_crates(f):
> @@ -28,19 +31,52 @@ def get_crates(f):
>      c_list =3D '# from %s' % os.path.relpath(f, '${CARGO_LOCK_SRC_DIR}')
>      c_list +=3D '\nSRC_URI +=3D " \\\'
>      crates =3D tomllib.load(open(f, 'rb'))
> -    for c in crates['package']:
> -        if 'source' in c and 'crates.io' in c['source']:
> +
> +    # Build a list with crates info that have crates.io in the source
> +    crates_candidates =3D list(filter(lambda c: 'crates.io' in
> c.get('source', ''), crates['package']))
> +
> +    if not crates_candidates:
> +        raise ValueError("Unable to find any candidate crates that use
> crates.io")
> +
> +    # Build a list of crates name that have multiple version
> +    crates_multiple_vers =3D []
> +    tmp =3D []
> +    for c in crates_candidates:
> +        if c['name'] in tmp:
> +            crates_multiple_vers.append(c['name'])
> +        else:
> +            tmp.append(c['name'])
> +
> +    # Update crates uri and their checksum, to avoid name clashing on th=
e
> checksum
> +    # we need to rename crates of the same name but different version
> +    cksum_list =3D ''
> +    for c in crates_candidates:
> +        if c['name'] in crates_multiple_vers:
> +            rename =3D "%s-%s" % (c['name'], c['version'])
> +            c_list +=3D '\n    crate://crates.io/%s/%s;name=3D%s \\\' %
> (c['name'], c['version'], rename)
> +        else:
> +            rename =3D c['name']
>              c_list +=3D '\n    crate://crates.io/%s/%s \\\' % (c['name']=
,
> c['version'])
> +        if 'checksum' in c:
> +            cksum_list +=3D '\nSRC_URI[%s.sha256sum] =3D "%s"' % (rename=
,
> c['checksum'])
> +
>      c_list +=3D '\n"\n'
> +    c_list +=3D cksum_list
> +    c_list +=3D '\n'
>      return c_list
>
>  import os
>  crates =3D "# Autogenerated with 'bitbake -c update_crates ${PN}'\n\n"
> +found =3D False
>  for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
>      for file in files:
>          if file =3D=3D 'Cargo.lock':
>              crates +=3D get_crates(os.path.join(root, file))
> -open(os.path.join('${THISDIR}', '${BPN}'+"-crates.inc"),
> 'w').write(crates)
> -
> +            found =3D True
> +if not found:
> +    raise ValueError("Unable to find Cargo.lock in ${CARGO_LOCK_SRC_DIR}=
")
> +open("${TARGET_FILE}", 'w').write(crates)
>  EOF
> +
> +    bbnote "Successfully update crates inside '${TARGET_FILE}'"
>  }
> --
> 2.34.1
>
>

--000000000000d8b88a05f703b7d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Sorry, I messed up with the different mai=
ling list, this patch series should be for openembedded-core</div><div dir=
=3D"auto"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">Le jeu. 16 mars 2023, 13:12,  &lt;<a href=3D"mailto:frederic.mart=
insons@gmail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt; a=
 =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gmai=
l.com" rel=3D"noreferrer" target=3D"_blank">frederic.martinsons@gmail.com</=
a>&gt;<br>
<br>
This is related to checksum verification introduction from<br>
<a href=3D"https://patchwork.yoctoproject.org/project/bitbake/patch/2023031=
5131513.50635-1-frederic.martinsons@gmail.com/" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://patchwork.yoctoproject.org/project/bitbake/pat=
ch/20230315131513.50635-1-frederic.martinsons@gmail.com/</a><br>
<br>
I also choose to raise an exception if:<br>
=C2=A0- no crates can be found<br>
=C2=A0- no Cargo.lock file exist<br>
<br>
Otherwise the generated inc file will silently be emptied.<br>
<br>
Signed-off-by: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinson=
s@gmail.com" rel=3D"noreferrer" target=3D"_blank">frederic.martinsons@gmail=
.com</a>&gt;<br>
---<br>
=C2=A0.../cargo-update-recipe-crates.bbclass=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4=
4 +++++++++++++++++--<br>
=C2=A01 file changed, 40 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/meta/classes-recipe/cargo-update-recipe-crates.bbclass b/meta/=
classes-recipe/cargo-update-recipe-crates.bbclass<br>
index 697460d215..daa363b0dd 100644<br>
--- a/meta/classes-recipe/cargo-update-recipe-crates.bbclass<br>
+++ b/meta/classes-recipe/cargo-update-recipe-crates.bbclass<br>
@@ -16,11 +16,14 @@<br>
=C2=A0addtask do_update_crates after do_patch<br>
=C2=A0do_update_crates[depends] =3D &quot;python3-native:do_populate_sysroo=
t&quot;<br>
=C2=A0do_update_crates[nostamp] =3D &quot;1&quot;<br>
+do_update_crates[doc] =3D &quot;Update the recipe by reading Cargo.lock an=
d write in ${THISDIR}/${BPN}-crates.inc&quot;<br>
<br>
=C2=A0# The directory where to search for Cargo.lock files<br>
=C2=A0CARGO_LOCK_SRC_DIR ??=3D &quot;${S}&quot;<br>
<br>
=C2=A0do_update_crates() {<br>
+=C2=A0 =C2=A0 TARGET_FILE=3D&quot;${THISDIR}/${BPN}-crates.inc&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0nativepython3 - &lt;&lt;EOF<br>
<br>
=C2=A0def get_crates(f):<br>
@@ -28,19 +31,52 @@ def get_crates(f):<br>
=C2=A0 =C2=A0 =C2=A0c_list =3D &#39;# from %s&#39; % os.path.relpath(f, &#3=
9;${CARGO_LOCK_SRC_DIR}&#39;)<br>
=C2=A0 =C2=A0 =C2=A0c_list +=3D &#39;\nSRC_URI +=3D &quot; \\\&#39;<br>
=C2=A0 =C2=A0 =C2=A0crates =3D tomllib.load(open(f, &#39;rb&#39;))<br>
-=C2=A0 =C2=A0 for c in crates[&#39;package&#39;]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;source&#39; in c and &#39;<a href=3D"h=
ttp://crates.io" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io<=
/a>&#39; in c[&#39;source&#39;]:<br>
+<br>
+=C2=A0 =C2=A0 # Build a list with crates info that have <a href=3D"http://=
crates.io" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io</a> in=
 the source<br>
+=C2=A0 =C2=A0 crates_candidates =3D list(filter(lambda c: &#39;<a href=3D"=
http://crates.io" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io=
</a>&#39; in c.get(&#39;source&#39;, &#39;&#39;), crates[&#39;package&#39;]=
))<br>
+<br>
+=C2=A0 =C2=A0 if not crates_candidates:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(&quot;Unable to find any cand=
idate crates that use <a href=3D"http://crates.io" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">crates.io</a>&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Build a list of crates name that have multiple version<br>
+=C2=A0 =C2=A0 crates_multiple_vers =3D []<br>
+=C2=A0 =C2=A0 tmp =3D []<br>
+=C2=A0 =C2=A0 for c in crates_candidates:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c[&#39;name&#39;] in tmp:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crates_multiple_vers.append(c[&#=
39;name&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp.append(c[&#39;name&#39;])<br=
>
+<br>
+=C2=A0 =C2=A0 # Update crates uri and their checksum, to avoid name clashi=
ng on the checksum<br>
+=C2=A0 =C2=A0 # we need to rename crates of the same name but different ve=
rsion<br>
+=C2=A0 =C2=A0 cksum_list =3D &#39;&#39;<br>
+=C2=A0 =C2=A0 for c in crates_candidates:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c[&#39;name&#39;] in crates_multiple_vers:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename =3D &quot;%s-%s&quot; % (=
c[&#39;name&#39;], c[&#39;version&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_list +=3D &#39;\n=C2=A0 =C2=A0=
 crate://<a href=3D"http://crates.io/%s/%s;name=3D%s" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">crates.io/%s/%s;name=3D%s</a> \\\&#39; % (c[&#39=
;name&#39;], c[&#39;version&#39;], rename)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename =3D c[&#39;name&#39;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_list +=3D &#39;\n=C2=A0 =
=C2=A0 crate://<a href=3D"http://crates.io/%s/%s" rel=3D"noreferrer norefer=
rer" target=3D"_blank">crates.io/%s/%s</a> \\\&#39; % (c[&#39;name&#39;], c=
[&#39;version&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;checksum&#39; in c:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cksum_list +=3D &#39;\nSRC_URI[%=
s.sha256sum] =3D &quot;%s&quot;&#39; % (rename, c[&#39;checksum&#39;])<br>
+<br>
=C2=A0 =C2=A0 =C2=A0c_list +=3D &#39;\n&quot;\n&#39;<br>
+=C2=A0 =C2=A0 c_list +=3D cksum_list<br>
+=C2=A0 =C2=A0 c_list +=3D &#39;\n&#39;<br>
=C2=A0 =C2=A0 =C2=A0return c_list<br>
<br>
=C2=A0import os<br>
=C2=A0crates =3D &quot;# Autogenerated with &#39;bitbake -c update_crates $=
{PN}&#39;\n\n&quot;<br>
+found =3D False<br>
=C2=A0for root, dirs, files in os.walk(&#39;${CARGO_LOCK_SRC_DIR}&#39;):<br=
>
=C2=A0 =C2=A0 =C2=A0for file in files:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if file =3D=3D &#39;Cargo.lock&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crates +=3D get_crates(os.p=
ath.join(root, file))<br>
-open(os.path.join(&#39;${THISDIR}&#39;, &#39;${BPN}&#39;+&quot;-crates.inc=
&quot;), &#39;w&#39;).write(crates)<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D True<br>
+if not found:<br>
+=C2=A0 =C2=A0 raise ValueError(&quot;Unable to find Cargo.lock in ${CARGO_=
LOCK_SRC_DIR}&quot;)<br>
+open(&quot;${TARGET_FILE}&quot;, &#39;w&#39;).write(crates)<br>
=C2=A0EOF<br>
+<br>
+=C2=A0 =C2=A0 bbnote &quot;Successfully update crates inside &#39;${TARGET=
_FILE}&#39;&quot;<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>
</div>

--000000000000d8b88a05f703b7d0--

