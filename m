Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9D6C021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 19:14:53 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.14171.1740597284920263225
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 11:14:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dEKnEk6G;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so827565ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597284; x=1741202084; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXCo+Zj9tk2Tomyo9z5M2VNU3/uPDXlFjK2TMMABq7E=;
        b=dEKnEk6GW6KREBwh3c2Sk3/dIWCWFn+bR6w+h4nT75w2CGF5Jvo1jZEQKFVY5veTuu
         LZobeagy4353ukPP8QQDvU1TYqhnIX0LbVHut+ZT/MhnvnahOIvJuu/e9N8s1/kWMVn9
         OkCRKESUXJROJK0COXTrzzYd9Pw7U0Qnavd8dJ0R7B6mVAraE1wGlUShfK34+jqWlz7w
         QrgzvSOWn/0ijMY9WCVKbgP+cc9nwmnmE82ku20njIu9Y6Mht0ZHOjUAg8mZYKxjwGgi
         aJGZOa5ZnuQ4zlo58M+PnKIl9ESC9nCNiFhLgekCU3wS5cd7+zlVJECKFbX334jtmUNI
         8S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597284; x=1741202084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXCo+Zj9tk2Tomyo9z5M2VNU3/uPDXlFjK2TMMABq7E=;
        b=BgzXiCOdltYqqpebY1K4IAEmbweKtAEJ0pZBgx3eZw8bLgMjHNjAvyLHZYAY55gqRo
         sM9lytyJmMIXBhbS/Mlowu9aJc39c/i/03nOA1uxSK+H1cDA8XSWfo4dpxorHlUmqczs
         YJrPVIZbqxkBanpz+HqKsmvaDbLrCVaTEwoM3npTzGncbe4Gx4KhWbhhfMk/XfOIWF9k
         mzE54TJ6vgqqcqqsu/PqBu6C5j4O5UfPeE/1wrpTzf8ee3sjQNTZq9YvlKpfqseBBqlD
         YarFeFGfhVpxQnhJ6ofK7QuQDqclTnemRoFN+R5Bu2bopl94NMHYM98Y9wDjLyyvuPC4
         1guw==
X-Gm-Message-State: AOJu0YwjbeeJdi+mWYeVr7WBpQ5q1MEvVSaKw9WGNWU0Zk7MU3/tWYlz
	9kul4AgwmnOk8goaip+XHZLf60+w33fmCZ1A48lMjhkFSp0wCMa9W0bytgikP5YgRPfGQTWMfr6
	y0NKlXUnO+nWLPXksWrq18NitmqI=
X-Gm-Gg: ASbGncvPfymKBvBiAt0qnXdEzxRw/vo+fWChNdXrY3Zo10ZA0sza0XKKToPZ2mGftUG
	c9D65OuXNa4Eptebs+0ELq/AhzqSr3pXZ5TLE9brW1s7WttifwQsfkrOQBynUIBSiN/R70rwZ5o
	Nvg8kJ2NTfHhiE/P89wQROwhUM3h73zt/tFXoSNEZd
X-Google-Smtp-Source: AGHT+IHqVlPGg4Wgh1ZENToND/osGsO5uGYyDX0JjHUxt5LxNmaGIkayxG8I0oIxyg4tUCWUNaRqiN9ggk3yJjnPPAE=
X-Received: by 2002:a05:6e02:3a0d:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d2cb5153a9mr250776045ab.18.1740597284105; Wed, 26 Feb 2025
 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20250226124720.6462-1-eric.meyers@arthrex.com> <20250226124720.6462-2-eric.meyers@arthrex.com>
In-Reply-To: <20250226124720.6462-2-eric.meyers@arthrex.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Wed, 26 Feb 2025 11:14:27 -0800
X-Gm-Features: AQ5f1Jq7YZ0W79Ukd7STAhc_qbsiaV_yqrcqsw7mNtbeN4AKmxm1USDKKvyllKg
Message-ID: <CAB=6tBS6MwA_rwuttiwcfmr+QfWuvtt7FGihTVAFO0qQ2vMmZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d0f7ce062f106235"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 19:14:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17333

--000000000000d0f7ce062f106235
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:47=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> Cc: Alexander Kanavin <alex.kanavin@gmail.com>
> Cc: Chuck Wolber <chuckwolber@gmail.com>
> ---
>  lib/bb/fetch2/npm.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index c09f05044..7486049b8 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -107,6 +107,22 @@ class NpmEnvironment(object):
>          """Run npm command in a controlled environment"""
>          with tempfile.TemporaryDirectory() as tmpdir:
>              d =3D bb.data.createCopy(self.d)
> +
> +            # If the user opts to use their own NPMRC file, then use it
> within the NPM environment
> +            # (along with the user provided configs). Otherwise, leave i=
t
> blank.
> +            if d.getVar("BB_USE_HOME_NPMRC_FILE") =3D=3D "1":
> +                home_npmrc_file =3D os.path.join(os.environ.get("HOME"),
> ".npmrc")
> +                tmp_npmrc_file =3D os.path.join(tmpdir, ".npmrc")
> +                bb.warn("BB_USE_HOME_NPMRC_FILE flag is set - NPM fetche=
r
> will now use the .npmrc file in the HOME directory.")
> +                if os.path.exists(home_npmrc_file):
> +                    bb.utils.copyfile(home_npmrc_file, tmp_npmrc_file)
> +                    # Still need to append the contents of the user
> config created in __init__
> +                    with open(tmp_npmrc_file, 'a') as t:
> +                        with open(self.user_config.name, 'r') as u:
> +                            t.write(u.read())
> +                            t.flush()
> +                    self.user_config.name =3D tmp_npmrc_file
> +
>              d.setVar("PATH", d.getVar("PATH"))  # PATH might contain
> $HOME - evaluate it before patching
>              d.setVar("HOME", tmpdir)
>
>

Thank you for the patch! I see a few nits.

Recommendations further down in this message somewhat obviate this first
one, but I am including it anyway for completeness. I think you should
combine the two if statements. There does not seem to be any point in
printing the bb.warn if there is no ${HOME}/.nmprc file.

I like the use of the BB_USE_ prefix, because it vests the policy decision
to
allow outside influence with bitbake, where it belongs. However I recommend
shortening it a bit to BB_USE_HOME_NPMRC. The addition of _FILE seems a
little
redundant, and it narrows the future options a bit more than necessary.

And, given that you are adding a new variable, I think you should include a
patch to add that variable to the bitbake manual.

Rather than clutter things up in the run() method, you can simplify your
change greatly by creating a separate instance method (e.g.
__home_npmrc(..))
in the NpmEnvironment class which only returns a file path, or None. It is
in
that method that you would check for the ${HOME}/.npmrc file, the
BB_HOME_NPMRC
flag, and do the bb.warn. Then you would return the string that is the file
path to the user's .npmrc. No need for any file copy, or renaming.

Then in NpmEnvironment __init__ you would do something like this:

self.user_config =3D self.home_npmrc(self, d)
if self.user_config is None:
    self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", buffering=
=3D1)
for key, value in configs:
    self.user_config.write("%s=3D%s\n" % (key, value))

That way you get everything you were looking for without an extra file copy
and name swap.

**IMPORTANT** There is an obvious bug in my example code that I do not have
time to resolve. You need to open the self.user_config file for appending
if it
is not None. You should do all this in a with block so you do not have to
worry
about closing file handles.

Also worth noting, the npm.bbclass in oe-core uses the configs variable in
__init__ for global config, which is then interpreted as user_config. I do
not think that is necessarily going to present a problem, but it might be a
refactor target down the line (or now?) to make the distinction between use=
r
and global config more clear.

..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--000000000000d0f7ce062f106235
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div>On Wed, Feb 26, 2025 at 4:47=E2=80=AFAM=
 Eric Meyers &lt;<a href=3D"mailto:eric.meyers15310@gmail.com">eric.meyers1=
5310@gmail.com</a>&gt; wrote:<div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Eric Me=
yers &lt;<a href=3D"mailto:eric.meyers@arthrex.com" target=3D"_blank">eric.=
meyers@arthrex.com</a>&gt;<br>
Cc: Geoff Parker &lt;<a href=3D"mailto:geoffrey.parker@arthrex.com" target=
=3D"_blank">geoffrey.parker@arthrex.com</a>&gt;<br>
Cc: Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt;<br>
Cc: Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com" target=3D"_bl=
ank">chuckwolber@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/npm.py | 16 ++++++++++++++++<br>
=C2=A01 file changed, 16 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index c09f05044..7486049b8 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -107,6 +107,22 @@ class NpmEnvironment(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run npm command in a co=
ntrolled environment&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory() as tmp=
dir:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D bb.data.createCopy(se=
lf.d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the user opts to use their =
own NPMRC file, then use it within the NPM environment<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (along with the user provided =
configs). Otherwise, leave it blank.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_USE_HOME_NP=
MRC_FILE&quot;) =3D=3D &quot;1&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =
=3D os.path.join(os.environ.get(&quot;HOME&quot;), &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_npmrc_file =3D=
 os.path.join(tmpdir, &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;BB_U=
SE_HOME_NPMRC_FILE flag is set - NPM fetcher will now use the .npmrc file i=
n the HOME directory.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(=
home_npmrc_file):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.u=
tils.copyfile(home_npmrc_file, tmp_npmrc_file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # St=
ill need to append the contents of the user config created in __init__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with=
 open(tmp_npmrc_file, &#39;a&#39;) as t:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 with open(<a href=3D"http://self.user_config.name" rel=3D"norefe=
rrer" target=3D"_blank">self.user_config.name</a>, &#39;r&#39;) as u:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 t.write(u.read())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 t.flush()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a h=
ref=3D"http://self.user_config.name" rel=3D"noreferrer" target=3D"_blank">s=
elf.user_config.name</a> =3D tmp_npmrc_file<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.setVar(&quot;PATH&quot;, =
d.getVar(&quot;PATH&quot;))=C2=A0 # PATH might contain $HOME - evaluate it =
before patching<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.setVar(&quot;HOME&quot;, =
tmpdir)<br>
<br></blockquote></div><div><br><br><div style=3D"font-family:monospace" cl=
ass=3D"gmail_default">Thank you for the patch! I see a few nits.<br><br>Rec=
ommendations further down in this message somewhat obviate this first</div>=
<div style=3D"font-family:monospace" class=3D"gmail_default">one, but I am =
including it anyway for completeness. I think you should</div><div style=3D=
"font-family:monospace" class=3D"gmail_default">combine the two if statemen=
ts. There does not seem to be any point in</div><div style=3D"font-family:m=
onospace" class=3D"gmail_default">printing the bb.warn if there is no ${HOM=
E}/.nmprc file.</div><br></div><div><div style=3D"font-family:monospace" cl=
ass=3D"gmail_default">I like the use of the BB_USE_ prefix, because it vest=
s the policy decision to</div><div style=3D"font-family:monospace" class=3D=
"gmail_default">allow outside influence with bitbake, where it belongs. How=
ever I recommend</div><div style=3D"font-family:monospace" class=3D"gmail_d=
efault">shortening it a bit to BB_USE_HOME_NPMRC. The addition of _FILE see=
ms a little<br>redundant, and it narrows the future options a bit more than=
 necessary.<br><br></div><div style=3D"font-family:monospace" class=3D"gmai=
l_default">And, given that you are adding a new variable, I think you shoul=
d include a</div><div style=3D"font-family:monospace" class=3D"gmail_defaul=
t">patch to add that variable to the bitbake manual.</div><div style=3D"fon=
t-family:monospace" class=3D"gmail_default"><br></div><div style=3D"font-fa=
mily:monospace" class=3D"gmail_default">Rather than clutter things up in th=
e run() method, you can simplify your</div><div style=3D"font-family:monosp=
ace" class=3D"gmail_default">change greatly by creating a separate instance=
 method (e.g. __home_npmrc(..))</div><div style=3D"font-family:monospace" c=
lass=3D"gmail_default">in the NpmEnvironment class which only returns a fil=
e path, or None. It is in</div><div style=3D"font-family:monospace" class=
=3D"gmail_default">that method that you would check for the ${HOME}/.npmrc =
file, the BB_HOME_NPMRC</div><div style=3D"font-family:monospace" class=3D"=
gmail_default">flag, and do the bb.warn. Then you would return the string t=
hat is the file</div><div style=3D"font-family:monospace" class=3D"gmail_de=
fault">path to the user&#39;s .npmrc. No need for any file copy, or renamin=
g.</div><div style=3D"font-family:monospace" class=3D"gmail_default"><br></=
div><div style=3D"font-family:monospace" class=3D"gmail_default">Then in Np=
mEnvironment __init__ you would do something like this:</div><div style=3D"=
font-family:monospace" class=3D"gmail_default"><br>self.user_config =3D sel=
f.home_npmrc(self, d)<br>if self.user_config is None:<br>=C2=A0=C2=A0=C2=A0=
 self.user_config =3D tempfile.NamedTemporaryFile(mode=3D&quot;w&quot;, buf=
fering=3D1)<br></div><div style=3D"font-family:monospace" class=3D"gmail_de=
fault">for key, value in configs:<br>=C2=A0=C2=A0=C2=A0 self.user_config.wr=
ite(&quot;%s=3D%s\n&quot; % (key, value))</div><div style=3D"font-family:mo=
nospace" class=3D"gmail_default"><br></div><div style=3D"font-family:monosp=
ace" class=3D"gmail_default">That way you get everything you were looking f=
or without an extra file copy</div><div style=3D"font-family:monospace" cla=
ss=3D"gmail_default">and name swap.</div><div style=3D"font-family:monospac=
e" class=3D"gmail_default"><br></div><div style=3D"font-family:monospace" c=
lass=3D"gmail_default">**IMPORTANT** There is an obvious bug in my example =
code that I do not have</div><div style=3D"font-family:monospace" class=3D"=
gmail_default">time to resolve. You need to open the self.user_config file =
for appending if it</div><div style=3D"font-family:monospace" class=3D"gmai=
l_default">is not None. You should do all this in a with block so you do no=
t have to worry</div><div style=3D"font-family:monospace" class=3D"gmail_de=
fault">about closing file handles.</div><div style=3D"font-family:monospace=
" class=3D"gmail_default"><br></div><div style=3D"font-family:monospace" cl=
ass=3D"gmail_default">Also worth noting, the npm.bbclass in oe-core uses th=
e configs variable in</div><div style=3D"font-family:monospace" class=3D"gm=
ail_default">__init__ for global config, which is then interpreted as user_=
config. I do</div><div style=3D"font-family:monospace" class=3D"gmail_defau=
lt">not think that is necessarily going to present a problem, but it might =
be a</div><div style=3D"font-family:monospace" class=3D"gmail_default">refa=
ctor target down the line (or now?) to make the distinction between user</d=
iv><div style=3D"font-family:monospace" class=3D"gmail_default">and global =
config more clear.</div><br><div style=3D"font-family:monospace" class=3D"g=
mail_default">..Ch:W..</div><br></div><div><span class=3D"gmail_default" st=
yle=3D"font-family:monospace"><br></span></div><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><div><b><span style=3D"font-family:monospace">=C2=A0 Opinions exp=
ressed are my own. |<br>=C2=A0--------------------------------|------ &quot=
;Perfection must be reached by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand of=
 time.&quot;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -Voltaire</span></b></div></div></div></div>

--000000000000d0f7ce062f106235--

