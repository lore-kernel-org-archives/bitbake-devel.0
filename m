Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web11.6669.1616494022788060664
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Mar 2021 03:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [192.168.67.164] (mm-65-41-120-178.brest.dynamic.pppoe.byfly.by [178.120.41.65])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 12NA6w9X025848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 11:06:59 +0100
Subject: Re: [bitbake-devel] [PATCH] fetch2/__init__.py: Use relative symlink for mirrors
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <20210323085039.168551-1-amikan@ilbers.de>
 <CA+chaQcdTJJTLWePvrfF-ZGK=t0s0oi+7fuDX54JGV4-Jo2gOQ@mail.gmail.com>
From: "Anton Mikanovich" <amikan@ilbers.de>
Message-ID: <5ca65d65-c21e-5ad5-5f5d-381ba504dbac@ilbers.de>
Date: Tue, 23 Mar 2021 13:06:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CA+chaQcdTJJTLWePvrfF-ZGK=t0s0oi+7fuDX54JGV4-Jo2gOQ@mail.gmail.com>
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,HTML_MESSAGE
	autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on shymkent.ilbers.de
Content-Type: multipart/alternative;
 boundary="------------A8123FAF457A3EECD1EEE053"
Content-Language: en-US

--------------A8123FAF457A3EECD1EEE053
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id 12NA6w9X025848

23.03.2021 12:02, Martin Jansa wrote:
> Is this really different from
>
> https://lists.openembedded.org/g/bitbake-devel/topic/78342988#11853=20
> <https://lists.openembedded.org/g/bitbake-devel/topic/78342988#11853>
>
> which got reverted in
> https://git.openembedded.org/bitbake/commit/?id=3D5775d9463ecedf8681cb6c=
919b240b80fe70f5a3=20
> <https://git.openembedded.org/bitbake/commit/?id=3D5775d9463ecedf8681cb6=
c919b240b80fe70f5a3>
> ?
>
> On Tue, Mar 23, 2021 at 9:50 AM Anton Mikanovich <amikan@ilbers.de=20
> <mailto:amikan@ilbers.de>> wrote:
>
>     When running bitbake in chroot with external DL_DIR mounted to other
>     location symlink for repo obtained from MIRRORS point to wrong
>     location.
>     There is no need in absolute path here, because destination will
>     always
>     be in the same directory. So it is better to use relative symlink.
>
>     Signed-off-by: Anton Mikanovich <amikan@ilbers.de
>     <mailto:amikan@ilbers.de>>
>     ---
>     =C2=A0lib/bb/fetch2/__init__.py | 2 +-
>     =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>     index cf0201c4..ac7a6748 100644
>     --- a/lib/bb/fetch2/__init__.py
>     +++ b/lib/bb/fetch2/__init__.py
>     @@ -1066,7 +1066,7 @@ def ensure_symlink(target, link_name):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# same time, in which case we do n=
ot want the second task to
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# fail when the link has already b=
een created by the
>     first task.
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(target, link_n=
ame)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(os.path.basena=
me(target), link_name)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except FileExistsError:
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass
>
>     --=20
>     2.25.1
>
>
>    =20
>
Thank you for quick response.
Sorry for duplicating, I didn't notice previous thread.
Current patch can be dropped, we will work on Cedric's version and try=20
to see what's wrong there.

--=20
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov


--------------A8123FAF457A3EECD1EEE053
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by shymkent.ilbers.de id 12NA6w9X025848

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    23.03.2021 12:02, Martin Jansa wrote:<br>
    <blockquote type=3D"cite"
cite=3D"mid:CA+chaQcdTJJTLWePvrfF-ZGK=3Dt0s0oi+7fuDX54JGV4-Jo2gOQ@mail.gma=
il.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUT=
F-8">
      <div dir=3D"ltr">Is this really different from
        <div><br>
        </div>
        <div><a
href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/78342988#1185=
3"
            moz-do-not-send=3D"true">https://lists.openembedded.org/g/bitb=
ake-devel/topic/78342988#11853</a><br>
        </div>
        <div><br>
        </div>
        <div>which got reverted in</div>
        <div><a
href=3D"https://git.openembedded.org/bitbake/commit/?id=3D5775d9463ecedf86=
81cb6c919b240b80fe70f5a3"
            moz-do-not-send=3D"true">https://git.openembedded.org/bitbake/=
commit/?id=3D5775d9463ecedf8681cb6c919b240b80fe70f5a3</a><br>
        </div>
        <div>?</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 23, 2021 at 9:50
          AM Anton Mikanovich &lt;<a href=3D"mailto:amikan@ilbers.de"
            moz-do-not-send=3D"true">amikan@ilbers.de</a>&gt; wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">W=
hen
          running bitbake in chroot with external DL_DIR mounted to
          other<br>
          location symlink for repo obtained from MIRRORS point to wrong
          location.<br>
          There is no need in absolute path here, because destination
          will always<br>
          be in the same directory. So it is better to use relative
          symlink.<br>
          <br>
          Signed-off-by: Anton Mikanovich &lt;<a
            href=3D"mailto:amikan@ilbers.de" target=3D"_blank"
            moz-do-not-send=3D"true">amikan@ilbers.de</a>&gt;<br>
          ---<br>
          =C2=A0lib/bb/fetch2/__init__.py | 2 +-<br>
          =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
          <br>
          diff --git a/lib/bb/fetch2/__init__.py
          b/lib/bb/fetch2/__init__.py<br>
          index cf0201c4..ac7a6748 100644<br>
          --- a/lib/bb/fetch2/__init__.py<br>
          +++ b/lib/bb/fetch2/__init__.py<br>
          @@ -1066,7 +1066,7 @@ def ensure_symlink(target, link_name):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# same time, in which case we =
do not want the second
          task to<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# fail when the link has alrea=
dy been created by the
          first task.<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
          -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(target, li=
nk_name)<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(os.path.ba=
sename(target), link_name)<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except FileExistsError:<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
          <br>
          -- <br>
          2.25.1<br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <p>Thank you for quick response.<br>
      Sorry for duplicating, I didn't notice previous thread.<br>
      Current patch can be dropped, we will work on Cedric's version and
      try to see what's wrong there.<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov</pre>
  </body>
</html>

--------------A8123FAF457A3EECD1EEE053--
