Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92CC54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 11:43:17 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
 by mx.groups.io with SMTP id smtpd.web10.52673.1673523795529815140
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jan 2023 03:43:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bqJsd7pg;
 spf=pass (domain: gmail.com, ip: 209.85.221.176, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vk1-f176.google.com with SMTP id 6so8616731vkz.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TeGRtiLtFOGTrwFeT1/gyHlV4EsnAXHV45g8BdBoT8I=;
        b=bqJsd7pgUZWVryctgM28Mqlc7z5qkDHF84k767TpiVhJCBIFYYbUTKeYIL345l8Y2v
         Pmri9PLK72ovq3Axm2VH0afGsd53geC6yPYSH9kaTqqAbvWCnxEHDOJPQK5TJ24L5XSd
         sABCyjnTFGfWEZ7x9/pj8f17e8YdvgC+xbwUHTh0db++A7xC/xVxfUjbairAe35rgUl9
         Rr7FOqU39lq9JC9y1kKWo7TkOalVENbe+vXtR5ZdUa+NCnTmYDSSFHz2tjL6TamfBv4H
         geNSGMeQam8R1IQm+ZwL9dW4O03YuzzgY8cU5CDsgx6RMW/00pKnSdCOzPjI7eBZj+lI
         zsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeGRtiLtFOGTrwFeT1/gyHlV4EsnAXHV45g8BdBoT8I=;
        b=B4KYfTKbnq+w6AHs4rC08VyCJ3h9oG61gHR8rnWoBuVXmnUN0uVZfUcEI4qKK/8arW
         b6xrV+0O6poPWPRDXfmhXT4JKLPoHKGwXMbwB6ZkGeXeD6NFgcdmQpBQdAIHC8cnpz0E
         mlpDnFKVq+x0IoC03gJHSEq31kPW36dQ55zJ0AAMnU9vcXuoFyCT+rrZNPeG51tCrKl0
         mv2MKqLc0G6KzsNm5NxNKiffpKqJR3/LbWpZJYBo2Vt682aFlB/xbwxHLHU35CGvxwce
         57Rtsu8yM/2AZG5MOPzqMkl2hmxHjzHwcu8lof8jImhfg8c691iHrSeIr5Qwlm3JV6jY
         Bypg==
X-Gm-Message-State: AFqh2kpB87EllAN/SdZsKZXLdEVDcGZWCi3/yorcD213qMXKHW2KurH+
	zlWARfKOTJiD6s2h4x/6hhHrRzXyOScEN2lz+F4=
X-Google-Smtp-Source: AMrXdXu7ymvswTTCf1KPTLLmNKrnaCeKd58dd4k/KOaSikIuTG1Lum3Hlh5gcUZi+YHNmjDC171TYQ/opP5NeFzilxU=
X-Received: by 2002:ac5:cde3:0:b0:3d5:4531:4c27 with SMTP id
 v3-20020ac5cde3000000b003d545314c27mr8309700vkn.40.1673523793527; Thu, 12 Jan
 2023 03:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
In-Reply-To: <20230111223729.3472181-1-yoann.congal@smile.fr>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 12 Jan 2023 11:43:02 +0000
Message-ID: <CANPvuRku0dQQPQVX5Hxcw27zZQhLTM-3X0SAV0hZ4JTkVe26Ag@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000003c898005f20f9f90"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 11:43:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14309

--0000000000003c898005f20f9f90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yoann,


Yoann Congal <yoann.congal@smile.fr> escreveu no dia quarta, 11/01/2023
=C3=A0(s) 22:38:

> Sqlite can't open the cachefile when its path is too long (>=3D 505 char =
by
> my tests).
>
> We do have a path length check in sanity.bbclass but this code is called
> before sanity checks.
>
> Treat the error in the exception instead of checking before hand in case
> sqlite eventually fixes this.
>
> Fixes [YOCTO #12374]
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  lib/bb/persist_data.py | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
> index ce84a158..a027f912 100644
> --- a/lib/bb/persist_data.py
> +++ b/lib/bb/persist_data.py
> @@ -249,4 +249,20 @@ def persist(domain, d):
>
>      bb.utils.mkdirhier(cachedir)
>      cachefile =3D os.path.join(cachedir, "bb_persist_data.sqlite3")
> -    return SQLTable(cachefile, domain)
> +
> +    try:
> +        return SQLTable(cachefile, domain)
> +    except sqlite3.OperationalError:
> +        # Sqlite fails to open database when its path is too long.
> +        # After testing, 504 is the biggest path length that can be
> opened by
> +        # sqlite.
> +        # Note: This code is called before sanity.bbclass and its path
> length
> +        # check
> +        max_len =3D 504
> +        if len(cachefile) > max_len:
> +            logger.critical("The path of the cache file is too long "
> +                    f"({len(cachefile)} chars > {max_len}) to be opened
> by sqlite! "
> +                    f"Your cache file is \"{cachefile}\"")
>

As fair as I know bitbake don't use python fstrings anywhere

grep --include=3D\*.py  -rnw bitbake/lib/ -e 'f".*"'
bitbake/lib/bb/data_smart.py:345:        """Get the line where a operation
is made on a variable in file f"""
bitbake/lib/bb/main.py:135:    parser.add_option("-f", "--force",
action=3D"store_true", dest=3D"force", default=3DFalse,
bitbake/lib/bb/tests/runqueue.py:305:            tasks =3D
self.run_bitbakecmd(["bitbake", "mc:mc_2:a1", "-c", "compile", "-f"],
tempdir, "", extraenv=3Dextraenv, cleanup=3DTrue)
bitbake/lib/pyinotify.py:2255:    parser.add_option("-f", "--raw-format",
action=3D"store_true",

Jose


> +            sys.exit(1)
> +        else:
> +            raise
> --
> 2.30.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14305):
> https://lists.openembedded.org/g/bitbake-devel/message/14305
> Mute This Topic: https://lists.openembedded.org/mt/96211174/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000003c898005f20f9f90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Yoann,<br><br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Yoann Congal &lt;<a href=
=3D"mailto:yoann.congal@smile.fr">yoann.congal@smile.fr</a>&gt; escreveu no=
 dia quarta, 11/01/2023 =C3=A0(s) 22:38:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Sqlite can&#39;t open the cachefile when its path =
is too long (&gt;=3D 505 char by<br>
my tests).<br>
<br>
We do have a path length check in sanity.bbclass but this code is called<br=
>
before sanity checks.<br>
<br>
Treat the error in the exception instead of checking before hand in case<br=
>
sqlite eventually fixes this.<br>
<br>
Fixes [YOCTO #12374]<br>
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
---<br>
=C2=A0lib/bb/persist_data.py | 18 +++++++++++++++++-<br>
=C2=A01 file changed, 17 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py<br>
index ce84a158..a027f912 100644<br>
--- a/lib/bb/persist_data.py<br>
+++ b/lib/bb/persist_data.py<br>
@@ -249,4 +249,20 @@ def persist(domain, d):<br>
<br>
=C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(cachedir)<br>
=C2=A0 =C2=A0 =C2=A0cachefile =3D os.path.join(cachedir, &quot;bb_persist_d=
ata.sqlite3&quot;)<br>
-=C2=A0 =C2=A0 return SQLTable(cachefile, domain)<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return SQLTable(cachefile, domain)<br>
+=C2=A0 =C2=A0 except sqlite3.OperationalError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sqlite fails to open database when its path =
is too long.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # After testing, 504 is the biggest path lengt=
h that can be opened by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sqlite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Note: This code is called before sanity.bbcl=
ass and its path length<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_len =3D 504<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(cachefile) &gt; max_len:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.critical(&quot;The path o=
f the cache file is too long &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;({len(cachefile)} chars &gt; {max_len}) to be opened by sqlite! &quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Your cache file is \&quot;{cachefile}\&quot;&quot;)<br></blockquote><div=
><br>As fair as I know bitbake don&#39;t use python fstrings=C2=A0anywhere=
=C2=A0<br><br>grep --include=3D\*.py =C2=A0-rnw bitbake/lib/ -e &#39;f&quot=
;.*&quot;&#39; <br>bitbake/lib/bb/data_smart.py:345: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;&quot;&quot;Get the line where a operation is made on a variabl=
e in file f&quot;&quot;&quot;<br>bitbake/lib/bb/main.py:135: =C2=A0 =C2=A0p=
arser.add_option(&quot;-f&quot;, &quot;--force&quot;, action=3D&quot;store_=
true&quot;, dest=3D&quot;force&quot;, default=3DFalse,<br>bitbake/lib/bb/te=
sts/runqueue.py:305: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasks =3D sel=
f.run_bitbakecmd([&quot;bitbake&quot;, &quot;mc:mc_2:a1&quot;, &quot;-c&quo=
t;, &quot;compile&quot;, &quot;-f&quot;], tempdir, &quot;&quot;, extraenv=
=3Dextraenv, cleanup=3DTrue)<br>bitbake/lib/pyinotify.py:2255: =C2=A0 =C2=
=A0parser.add_option(&quot;-f&quot;, &quot;--raw-format&quot;, action=3D&qu=
ot;store_true&quot;,<br><br>Jose<br>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
-- <br>
2.30.2<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14305): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14305" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14305</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/96211174/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/96211174/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--0000000000003c898005f20f9f90--

