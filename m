Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
	[209.85.208.182])
	by mail.openembedded.org (Postfix) with ESMTP id D94CA65CE9
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jul 2019 19:55:39 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id m8so4297312lji.7
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 07 Jul 2019 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=PeIWx0xhyjBELIK3MwCWMqqj9LNUrSkaiaiyN8Tp7zo=;
	b=YwYoFZJUOd2VO8Sbj0QBNKr0yLc/Z9ufmYl7YmPycHBscpKWCI7lfgY4cGNmSFUk+m
	gc8tNFOhVuF3XAlLTCjeuo5FxotEUOukbGeMm3Kiz2V5l3eBvq7jn+2d+ZVLZlQqnepk
	HPFXWbCO7RlXNn+Nlzfj2sSkgOYJvVQ8ArdQEyecA5adQOZEt89v918tIlFeiV2N7aJ+
	KhVdpW7VSkhYiPwEbXL3phIyWNQkXmIYK5BV78SSVtAdG5fEMi7fL9ky14cuAhgH3HI8
	NrBCOPqoAoLn+jbvn/vKymur+z5FL8nq7KZAUJ+ebyXhEyX4/bUS6yspiOxAF/M5HWCJ
	p94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=PeIWx0xhyjBELIK3MwCWMqqj9LNUrSkaiaiyN8Tp7zo=;
	b=MKUabB6dSaIEXOEjYBD2BtGDeDgDAKF+AqEJ/RFVQGSxkyt4eshCkl6RBHqMxDRs2n
	DVX2igrSh82BeFoneq6IZ7DaRcwwGlzYnielqB6a/7+NyjtvCQG1V3Ns2AaPn7YhalCO
	XjRM5+eu8D0O/AgA0/8rND0QplkRjYX9Rl8pPC1YSeY+cayrO4bnVXuN2P0XV+hh4QOV
	oyUaIZKw7Q5U9z00uoGeKWT3ASpofwy8Qv2t2DrSKWy7IFiUgrCGQtpjGMUdTWZefa6R
	otzule/n+5DhPOZ2mhlD1aMwn0GWbBYTqoiGPDdhlXd777rvvUk24gEgH/ShcO7SiGUT
	LthA==
X-Gm-Message-State: APjAAAX5S/CGewh4e+GUqU9AhbpT77792OXRXkYHgcymc69eQyTQ7jJn
	8ZQACSuhM06m7OAPyv5Gw+zKelmqTlk+wMZRRdytaw==
X-Google-Smtp-Source: APXvYqwZnNW7AvSqUxaiH2HYy19bA8j86z0NQpCOERqS6ZgoWN/5m/2AK+hej8cmhy7MS7yqLFgaKvCdBRcw0tseeGA=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr7956623ljj.68.1562529340004;
	Sun, 07 Jul 2019 12:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
In-Reply-To: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Mon, 8 Jul 2019 07:55:28 +1200
Message-ID: <CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 07 Jul 2019 19:55:40 -0000
Content-Type: multipart/alternative; boundary="000000000000431b38058d1cb66e"

--000000000000431b38058d1cb66e
Content-Type: text/plain; charset="UTF-8"

Ping

Regards
Ankur

On Thu, 4 Jul 2019, 4:45 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com> wrote:

> Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 59a2ee8f..a8fcc2bf 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -156,6 +156,9 @@ class Git(FetchMethod):
>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https',
> 'rsync'):
>              raise bb.fetch2.ParameterError("Invalid protocol type",
> ud.url)
>
> +        if ud.proto in ('http', 'https'):
> +            ud.path = ud.path.replace(" ", "%20")
> +
>          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
>
>          ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
> --
> 2.17.1
>
>

--000000000000431b38058d1cb66e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping<div dir=3D"auto"><br></div><div dir=3D"auto">Regards=
</div><div dir=3D"auto">Ankur</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, 4 Jul 2019, 4:45 p.m. Ankur Tyag=
i, &lt;<a href=3D"mailto:ankur.tyagi85@gmail.com">ankur.tyagi85@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Ankur =
Tyagi &lt;<a href=3D"mailto:ankur.tyagi85@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">ankur.tyagi85@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/git.py | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 59a2ee8f..a8fcc2bf 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -156,6 +156,9 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.proto in (&#39;git&#39;, &#39;f=
ile&#39;, &#39;ssh&#39;, &#39;http&#39;, &#39;https&#39;, &#39;rsync&#39;):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetch2.ParameterEr=
ror(&quot;Invalid protocol type&quot;, ud.url)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.proto in (&#39;http&#39;, &#39;https&#39=
;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.path =3D ud.path.replace(&quo=
t; &quot;, &quot;%20&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.nocheckout =3D ud.parm.get(&quot;noche=
ckout&quot;,&quot;0&quot;) =3D=3D &quot;1&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.rebaseable =3D ud.parm.get(&quot;rebas=
eable&quot;,&quot;0&quot;) =3D=3D &quot;1&quot;<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--000000000000431b38058d1cb66e--
