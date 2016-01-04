Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
	[209.85.213.181])
	by mail.openembedded.org (Postfix) with ESMTP id 26C9A6FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 18:06:57 +0000 (UTC)
Received: by mail-ig0-f181.google.com with SMTP id to18so224146158igc.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Jan 2016 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Fb9cmBoRn5ZCjqdRT/4nt8bmpNgXDjhG+k/8HJ4xdwg=;
	b=vPAVKSlVd67+Cdd0cx3Qfqrj0JVyByro8qErt4D2/kWDYCva+gzXCjfSP7bBEFXbGW
	q/ZiGXXeTbgnDZWC1svR+LVSpFd/Xmng6m6xGuu88XEqj5b9WhqQDbEJNjJngEsyp1pg
	DC4C3PUqI8iXKg02HR/e9smtztsOglpGO/J2AFGXhNrzRsW0r1rkaY1ZpJZIVNLQrblr
	0GwxaXrR93DqgeDUkvq+OerTlfMZMKnTsF1YpjfrUanJEffJq2M8rWBW+kMeGgoGq7J2
	TowOa7zqssaI0JbhJvcec5+Bw6q9jxNDGtcuT2xfwc2icHgD1QU4b8ZoopqNWITqPgI2
	CIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Fb9cmBoRn5ZCjqdRT/4nt8bmpNgXDjhG+k/8HJ4xdwg=;
	b=f52mTmN49Qm1k7tY5GOHwZEJ9vd/W8W0gkFeQSxKAXiC+k16MD9sVbGLqn0/n0FskG
	sVSnqh9DbHW/SOKDm0m7mYdwAu98Ys45P0GHFZXBPZUeSgz3ByVbR0sGVArBTPY7ez0j
	7tK2wRfLarF03U6ZHBijbfZ80Pn+p0L0qNmO0QzPyLb5kNIR03T9QhsPR6MrMRT7PAx6
	tbCAGK2dRd9NpIsWZwhuroFE7hUpgRnPJtE5lauVsJfXq+CKRX/87L4JN+f4DzSPpdpH
	lLSq+QCzVgwiGQAQc9faoyq7wYxl5kPjRYMjSdQCbRjRfFTw9Q38uGIzhPjVSxZfTHs7
	HtWg==
X-Received: by 10.50.79.165 with SMTP id k5mr86825712igx.10.1451930818101;
	Mon, 04 Jan 2016 10:06:58 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.104.194 with HTTP; Mon, 4 Jan 2016 10:06:38 -0800 (PST)
In-Reply-To: <1451928842.7598.16.camel@linuxfoundation.org>
References: <1451928842.7598.16.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 4 Jan 2016 11:06:38 -0700
X-Google-Sender-Auth: eAQcB_-ZaGiNkfrFFheU7JwkePw
Message-ID: <CABcZANn67KvtNe8PUtdVJX_z5bOGmEjEztEcfK5Rr9LmVO=e_Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Remove double compile from better_compile
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
X-List-Received-Date: Mon, 04 Jan 2016 18:06:58 -0000
Content-Type: multipart/alternative; boundary=089e013a032ea6caf7052885fc31

--089e013a032ea6caf7052885fc31
Content-Type: text/plain; charset=UTF-8

On Mon, Jan 4, 2016 at 10:34 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Poking around the ast to correct linenumbers works well for runtime
> failures
> but not for parsing ones. We can use blank linefeeds to correct the line
> numbers instead, with the advantage that we don't need to double compile.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index cd5fced..9a3efb2 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -292,7 +292,7 @@ def _print_trace(body, line):
>              error.append('     %.4d:%s' % (i, body[i-1].rstrip()))
>      return error
>
> -def better_compile(text, file, realfile, mode = "exec", lineno = None):
> +def better_compile(text, file, realfile, mode = "exec", lineno = 0):
>      """
>      A better compile method. This method
>      will print the offending lines.
> @@ -301,10 +301,9 @@ def better_compile(text, file, realfile, mode =
> "exec", lineno = None):
>          cache = bb.methodpool.compile_cache(text)
>          if cache:
>              return cache
> -        code = compile(text, realfile, mode, ast.PyCF_ONLY_AST)
> -        if lineno is not None:
> -            ast.increment_lineno(code, lineno)
> -        code = compile(code, realfile, mode)
> +        # We can't add to the linenumbers for compile, we can pad to the
> correct number of blank lines though
> +        text2 = "\n" * int(lineno) + text
> +        code = compile(text2, realfile, mode)
>

A SyntaxError can have its line numbers adjusted fairly easily, if that's
your concern. Afaik that's the usual case which ast.increment_lineno isn't
sufficient to handle. See
https://gist.github.com/kergoth/743677#file-compile-py-L67-L86.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e013a032ea6caf7052885fc31
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jan 4, 2016 at 10:34 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div id=3D":pc" class=3D"" style=3D"overflow:hid=
den">Poking around the ast to correct linenumbers works well for runtime fa=
ilures<br>
but not for parsing ones. We can use blank linefeeds to correct the line<br=
>
numbers instead, with the advantage that we don&#39;t need to double compil=
e.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
<br>
diff --git a/<span class=3D"">bitbake</span>/lib/<span class=3D"">bb</span>=
/utils.py b/<span class=3D"">bitbake</span>/lib/<span class=3D"">bb</span>/=
utils.py<br>
index cd5fced..9a3efb2 100644<br>
--- a/<span class=3D"">bitbake</span>/lib/<span class=3D"">bb</span>/utils.=
py<br>
+++ b/<span class=3D"">bitbake</span>/lib/<span class=3D"">bb</span>/utils.=
py<br>
@@ -292,7 +292,7 @@ def _print_trace(body, line):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error.append(&#39;=C2=A0 =
=C2=A0 =C2=A0%.4d:%s&#39; % (i, body[i-1].rstrip()))<br>
=C2=A0 =C2=A0 =C2=A0return error<br>
<br>
-def better_compile(text, file, realfile, mode =3D &quot;exec&quot;, lineno=
 =3D None):<br>
+def better_compile(text, file, realfile, mode =3D &quot;exec&quot;, lineno=
 =3D 0):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0A better compile method. This method<br>
=C2=A0 =C2=A0 =C2=A0will print the offending lines.<br>
@@ -301,10 +301,9 @@ def better_compile(text, file, realfile, mode =3D &quo=
t;exec&quot;, lineno =3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache =3D <span class=3D"">bb</span>.meth=
odpool.compile_cache(text)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cache:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return cache<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D compile(text, realfile, mode, ast.PyC=
F_ONLY_AST)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if lineno is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ast.increment_lineno(code, linen=
o)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D compile(code, realfile, mode)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We can&#39;t add to the linenumbers for comp=
ile, we can pad to the correct number of blank lines though<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 text2 =3D &quot;\n&quot; * int(lineno) + text<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D compile(text2, realfile, mode)</div><=
/blockquote></div><br></div><div class=3D"gmail_extra">A SyntaxError can ha=
ve its line numbers adjusted fairly easily, if that&#39;s your concern. Afa=
ik that&#39;s the usual case which ast.increment_lineno isn&#39;t=C2=A0 suf=
ficient to handle. See <a href=3D"https://gist.github.com/kergoth/743677#fi=
le-compile-py-L67-L86">https://gist.github.com/kergoth/743677#file-compile-=
py-L67-L86</a>.<br>-- <br><div class=3D"gmail_signature">Christopher Larson=
<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaur=
us<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--089e013a032ea6caf7052885fc31--
