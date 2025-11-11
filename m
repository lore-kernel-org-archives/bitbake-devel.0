Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D16CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 21:18:36 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.658.1762895915310717097
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 13:18:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VxZKH6uV;
 spf=pass (domain: smile.fr, ip: 209.85.218.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b725ead5800so26657866b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762895913; x=1763500713; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9gmcP+CMQrNcf0cRGQPEYkivEeZ/hW32Y7pYq0t3YQ=;
        b=VxZKH6uVx5PIBUuvYcK5vyOfwktT5PaOwnIpw906RzvvgW0qQNIIp48lpPm/3Vgleh
         dPXTbuBFEMjsNZxgyNTszZSpP6WKoAsIimlGnHe6p8MHGQOQ8+BcE56Uh6vOr8F8dIB8
         669BZPOjzUi7P33zshw6+m6+nVt64fuftPdHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762895913; x=1763500713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9gmcP+CMQrNcf0cRGQPEYkivEeZ/hW32Y7pYq0t3YQ=;
        b=pakl8PtvoGoxxUXwy+Mcc1bZlNvpMs83kBnz7WFIcCwsvT2bLgOkh09m8d+aGx1gcj
         C3oviVEBP8jwL9S3lsDJG9L+boMaVcp9u3EUJcuGjwtTY6CV2aQ0SYU9W0x6QHavzeNB
         +BSDXB2PgQieMzZYKolrmuibhr1VPylbQzOQ7NrKadShVj2PbiP4XjWHNZjPVQ443AJ8
         yY4ypEVQYtbtBiK74wO+jLqe45gDLgUj1f4nONwyaOE/58DAFOyPmJ1C7H96udfL9N6A
         8se6Be7D7w0jNJW59Byc62MFHaDGlYJFsF+E592hzn8SYjzv6I2ZbipGiec15rOurqu4
         YDrA==
X-Gm-Message-State: AOJu0Yw8lcc3PX/cj4Fk3mej258EpXUeMV9lRbCp5aEB29d7yZwaUGoK
	3cSW6+Jl9nEy4AuxnhKuFs+tM/V1bwniAgJf37hJkjYZkBg5Hvk+jFa9SCqQDL28zoSK6rYQ8b8
	dcOcNkcgDyCH7/0aanmNWkwgObhUVU+bYB13o2DpN/Q==
X-Gm-Gg: ASbGnctoD4GualMW0SBvMN1G77j6amWdMSqBOkXs91DqVT7ry/P01SmAtJOmrqHp0XC
	56xSDy/iblo9SiqmHjNojHgbCSE6FwN15bYXVeH96EfQ6EDT622NUWgYvBzyA6IoLCilrFV9Lne
	B1kdsWuBdhosfdJdajGgeeGvb67jCRHqq7mUJ+m2sdfT9+fdbiah3ZqD4KXtgK7tRcDjRn9TEoF
	tXB62/X+pbcq9V6Wg/5aGuHQSMenOGlBrAGbepOg1e9JdMEwBs7xifjkaPsSUcaY+uVIs77b9VC
	Bau1cz3eONxVxyJCWcjVZYSPrmrj7w==
X-Google-Smtp-Source: AGHT+IG6/mYkiMdxglUYXAdAsIzhiMHWgM556sMjCLDeE9zY+1UCpJH60VkV21gIRl/Gjf0HilviVhglWLMw3698HM0=
X-Received: by 2002:a17:906:c10a:b0:b70:50f0:e6ae with SMTP id
 a640c23a62f3a-b7331acde32mr49033666b.46.1762895913507; Tue, 11 Nov 2025
 13:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20251111173841.2842051-1-JPEWhacker@gmail.com>
In-Reply-To: <20251111173841.2842051-1-JPEWhacker@gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 11 Nov 2025 22:18:05 +0100
X-Gm-Features: AWmQ_bl2diuC1Ue46HscvkDRD_87RPn0bamyuNBQmoZv3COhiJaCLp48VSGkIvc
Message-ID: <CAMSfU+7iftgMgVfkC0KwV2JTQpi-aR9+RXKcoxQ_mZ4mMM0xMA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] bitbake-setup: Improve continue prompt
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b36ae406435830d9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 21:18:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18335

--000000000000b36ae406435830d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Le mar. 11 nov. 2025 =C3=A0 18:38, Joshua Watt via lists.openembedded.org
<JPEWhacker=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

> Reworks the prompt to continue with the setup wizard in a number of
> ways:
>  1) Default to 'Y' if the user just hits enter. In general, users are
>     more likely to want to continue than they want to exit.
>

In the absence of Alex, I'd like to remind what he said about defaulting to
No: https://lists.openembedded.org/g/bitbake-devel/message/18113:

> There was some discussion as to whether this should be Y/n (e.g. hit
> Enter to proceed). I'd rather err on the cautious side here, as people
> nowadays have muscle memory to agree and accept with anything and
> everything, and proceed as quickly as possible, they would do it here
> too, without reading what the tool is going to do, and only then
> realize it's not what they wanted.


Personally, I'm slightly in favor of defaulting to Yes: This will make the
experience more fluid for new users and answering Y instead of N is not
that dangerous for bitbake-setup (IIRC, we're not erasing any data just
putting files in an unexpected directory)


>  2) The tools prints "Exiting" when the user doesn't want to continue,
>     as a clear indication that the script exited without doing anything.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bin/bitbake-setup | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 282fa82ff..9c6d787bf 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -134,6 +134,14 @@ def checkout_layers(layers, layerdir, d):
>
>      return layers_fixed_revisions
>
> +def prompt_continue(non_interactive):
> +    if not non_interactive:
> +        p =3D input('Continue? (Y/n): ')
> +        if p and p.lower() !=3D 'y':
> +            print("Exiting")
> +            exit()
> +        print()
> +
>  def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
>      def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
>          os.makedirs(build_conf_dir)
> @@ -483,11 +491,7 @@ def init_config(top_dir, settings, args, d):
>          return
>
>      print("Initializing a setup directory in\n    {}".format(setupdir))
> -    if not args.non_interactive:
> -        y_or_n =3D input('Continue? (y/N): ')
> -        if y_or_n !=3D 'y':
> -            exit()
> -        print()
> +    prompt_continue(args.non_interactive)
>
>      os.makedirs(setupdir, exist_ok=3DTrue)
>
> @@ -676,10 +680,7 @@ def create_siteconf(top_dir, non_interactive=3DTrue)=
:
>          print('A site.conf file already exists. Please remove it if you
> would like to replace it with a default one')
>      else:
>          print('A common site.conf file will be created, please edit or
> replace before running builds\n    {}\n'.format(siteconfpath))
> -        if not non_interactive:
> -            y_or_n =3D input('Proceed? (y/N): ')
> -            if y_or_n !=3D 'y':
> -                exit()
> +        prompt_continue(non_interactive)
>
>          os.makedirs(os.path.dirname(top_dir), exist_ok=3DTrue)
>          with open(siteconfpath, 'w') as siteconffile:
> --
> 2.51.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18332):
> https://lists.openembedded.org/g/bitbake-devel/message/18332
> Mute This Topic: https://lists.openembedded.org/mt/116242231/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000b36ae406435830d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 11 nov. 2025=
 =C3=A0=C2=A018:38, Joshua Watt via <a href=3D"http://lists.openembedded.or=
g">lists.openembedded.org</a> &lt;JPEWhacker=3D<a href=3D"mailto:gmail.com@=
lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; a =C3=A9cr=
it=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Rework=
s the prompt to continue with the setup wizard in a number of<br>
ways:<br>
=C2=A01) Default to &#39;Y&#39; if the user just hits enter. In general, us=
ers are<br>
=C2=A0 =C2=A0 more likely to want to continue than they want to exit.<br></=
blockquote><div><br></div><div>In the absence of Alex, I&#39;d like to remi=
nd what he said about defaulting to No:=C2=A0<a href=3D"https://lists.opene=
mbedded.org/g/bitbake-devel/message/18113">https://lists.openembedded.org/g=
/bitbake-devel/message/18113</a>:</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">There was some discussion as to whether this should be Y/n (e=
.g. hit<br>Enter to proceed). I&#39;d rather err on the cautious side here,=
 as people<br>nowadays have muscle memory to agree and accept with anything=
 and<br>everything, and proceed as quickly as possible, they would do it he=
re<br>too, without reading what the tool is going to do, and only then<br>r=
ealize it&#39;s not what they wanted.</blockquote><div><br></div><div>Perso=
nally, I&#39;m slightly in favor of defaulting=C2=A0to Yes: This will make =
the experience more fluid for new users and answering Y instead of N is not=
 that dangerous for bitbake-setup (IIRC, we&#39;re not erasing any data jus=
t putting files in an unexpected directory)</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A02) The tools prints &quot;Exiting&quot; when the user doesn&#39;t wan=
t to continue,<br>
=C2=A0 =C2=A0 as a clear indication that the script exited without doing an=
ything.<br>
<br>
Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" targ=
et=3D"_blank">JPEWhacker@gmail.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 19 ++++++++++---------<br>
=C2=A01 file changed, 10 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 282fa82ff..9c6d787bf 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -134,6 +134,14 @@ def checkout_layers(layers, layerdir, d):<br>
<br>
=C2=A0 =C2=A0 =C2=A0return layers_fixed_revisions<br>
<br>
+def prompt_continue(non_interactive):<br>
+=C2=A0 =C2=A0 if not non_interactive:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D input(&#39;Continue? (Y/n): &#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if p and p.lower() !=3D &#39;y&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exiting&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print()<br>
+<br>
=C2=A0def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):=
<br>
=C2=A0 =C2=A0 =C2=A0def _setup_build_conf(layers, filerelative_layers, buil=
d_conf_dir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.makedirs(build_conf_dir)<br>
@@ -483,11 +491,7 @@ def init_config(top_dir, settings, args, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
<br>
=C2=A0 =C2=A0 =C2=A0print(&quot;Initializing a setup directory in\n=C2=A0 =
=C2=A0 {}&quot;.format(setupdir))<br>
-=C2=A0 =C2=A0 if not args.non_interactive:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 y_or_n =3D input(&#39;Continue? (y/N): &#39;)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if y_or_n !=3D &#39;y&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print()<br>
+=C2=A0 =C2=A0 prompt_continue(args.non_interactive)<br>
<br>
=C2=A0 =C2=A0 =C2=A0os.makedirs(setupdir, exist_ok=3DTrue)<br>
<br>
@@ -676,10 +680,7 @@ def create_siteconf(top_dir, non_interactive=3DTrue):<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;A site.conf file already exist=
s. Please remove it if you would like to replace it with a default one&#39;=
)<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;A common site.conf file will b=
e created, please edit or replace before running builds\n=C2=A0 =C2=A0 {}\n=
&#39;.format(siteconfpath))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not non_interactive:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y_or_n =3D input(&#39;Proceed? (=
y/N): &#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if y_or_n !=3D &#39;y&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prompt_continue(non_interactive)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.makedirs(os.path.dirname(top_dir), exi=
st_ok=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(siteconfpath, &#39;w&#39;) as s=
iteconffile:<br>
-- <br>
2.51.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18332): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18332" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18332</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116242231/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116242231/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000b36ae406435830d9--

