Received: from mail-la0-f51.google.com ([209.85.215.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1U2OVL-0006pG-3X
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Feb 2013 17:02:50 +0100
Received: by mail-la0-f51.google.com with SMTP id fo13so4634101lab.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Feb 2013 07:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Fco4ZnEWcgDtEMQ9pB/Wxys607o1FPu5L8xNvWEdlPY=;
	b=UyWKs480H/kqs69R+PlZ6Vw/M8lkdLMTh9pr8jt6ty5H+P1nRJHpuOtD03/9phFtAA
	7znURzsoxuOR8FzGhlEcZUo7NM4tExsqWmbp4vGNupCwC+OLQWGd+9XK1rRR4LaXUfNN
	+WYhl3fdPAQ0USasMeZafs9VFP8NeWKCz4WkGhZvB97556NtxlrhHtY2MY05nC9JQgRw
	DZo1hh8Lsif/nU1dIdqqPgrCKavQhT90/te4WzPaoYCfafF6G/93p4DSSl6S/sCHWrLE
	lHh2zKXZHEe0fA9Z/qU4tnqZ7D9BJuX1Ox/QJfjw6KoKiMPo+/HwM+Wth9KOiDo8Csos
	nhqA==
X-Received: by 10.152.136.20 with SMTP id pw20mr19516858lab.16.1359992818380; 
	Mon, 04 Feb 2013 07:46:58 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Mon, 4 Feb 2013 07:46:38 -0800 (PST)
In-Reply-To: <9d21459877d1d94bdaff1cbe8ca4dd84f5f692fd.1359948771.git.liezhi.yang@windriver.com>
References: <cover.1359948771.git.liezhi.yang@windriver.com>
	<9d21459877d1d94bdaff1cbe8ca4dd84f5f692fd.1359948771.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 4 Feb 2013 08:46:38 -0700
X-Google-Sender-Auth: OvFakOaEVrZekHpc6cfZ3vP32HI
Message-ID: <CABcZAN=g5073uzZ_nu4Q585_BXmEiSTDcjZwQs4RvWQVhde1eA@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] perforce.py: fix the perforce fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 04 Feb 2013 16:02:50 -0000
X-List-Received-Date: Mon, 04 Feb 2013 16:02:50 -0000
Content-Type: multipart/alternative; boundary=f46d042f9210d62de104d4e8001c

--f46d042f9210d62de104d4e8001c
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 4, 2013 at 2:27 AM, Robert Yang <liezhi.yang@windriver.com>wrote:

> The bb.process.run() will return one tuple, e.g:
>
> p4file = ('strA\nStrB\nstrC\n'), then there will be an iteration on p4file:
>
> for i in p4file:
>         [snip]
>
> The i will be 's t r A ...', this is incorrect. use:
>
> p4file = p4file.splitlines()
>
> will fix the problem.
>
> [YOCTO #3619]
>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/perforce.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/perforce.py
> b/bitbake/lib/bb/fetch2/perforce.py
> index df3a3a3..86ec9ba 100644
> --- a/bitbake/lib/bb/fetch2/perforce.py
> +++ b/bitbake/lib/bb/fetch2/perforce.py
> @@ -170,7 +170,7 @@ class Perforce(FetchMethod):
>          logger.info("Fetch " + loc)
>          logger.info("%s%s files %s", p4cmd, p4opt, depot)
>          p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt,
> depot))
> -        p4file = p4file.strip()
> +        p4file = p4file.splitlines()
>

Note that splitlines doesn't chop off the trailing newlines from the
individual strings. It *probably* wont cause an issue in this case due to
how it's passed to the shell in the subsequent subprocess call, but from a
correctness standpoint, I'd suggest changing this to something like p4files
= [f.rstrip() for f in p4file.splitlines], or doing an rstrip on the
individual files in the later iteration.
-- 
Christopher Larson

--f46d042f9210d62de104d4e8001c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Feb 4, 2013 at 2:27 AM, Robert Yang <span dir=3D"ltr">&lt;<a href=
=3D"mailto:liezhi.yang@windriver.com" target=3D"_blank">liezhi.yang@windriv=
er.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1a0">The bb.process.run() will r=
eturn one tuple, e.g:<br>
<br>
p4file =3D (&#39;strA\nStrB\nstrC\n&#39;), then there will be an iteration =
on p4file:<br>
<br>
for i in p4file:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [snip]<br>
<br>
The i will be &#39;s t r A ...&#39;, this is incorrect. use:<br>
<br>
p4file =3D p4file.splitlines()<br>
<br>
will fix the problem.<br>
<br>
[YOCTO #3619]<br>
<br>
Signed-off-by: Robert Yang &lt;<a href=3D"mailto:liezhi.yang@windriver.com"=
>liezhi.yang@windriver.com</a>&gt;<br>
---<br>
<div class=3D"im">=C2=A0bitbake/lib/bb/fetch2/perforce.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
</div>diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch=
2/perforce.py<br>
index df3a3a3..86ec9ba 100644<br>
--- a/bitbake/lib/bb/fetch2/perforce.py<br>
+++ b/bitbake/lib/bb/fetch2/perforce.py<br>
@@ -170,7 +170,7 @@ class Perforce(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://logger.info" target=3D"=
_blank">logger.info</a>(&quot;Fetch &quot; + loc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://logger.info" target=3D"=
_blank">logger.info</a>(&quot;%s%s files %s&quot;, p4cmd, p4opt, depot)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file, errors =3D bb.process.run(&quot;%=
s%s files %s&quot; % (p4cmd, p4opt, depot))<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file =3D p4file.strip()<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file =3D p4file.splitlines()</div></blockquo=
te></div><br>Note that splitlines doesn&#39;t chop off the trailing newline=
s from the individual strings. It *probably* wont cause an issue in this ca=
se due to how it&#39;s passed to the shell in the subsequent subprocess cal=
l, but from a correctness standpoint, I&#39;d suggest changing this to some=
thing like p4files =3D [f.rstrip() for f in p4file.splitlines], or doing an=
 rstrip on the individual files in the later iteration.<br>

-- <br>Christopher Larson</div></div>

--f46d042f9210d62de104d4e8001c--
