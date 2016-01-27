Return-Path: <srifenbark@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 36E416E668
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 23:14:56 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id s2so1073805oie.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=pbGUq5OGQ6WVhbR/m+ajWX9YgLjEHlY33AeunqEUoog=;
	b=rtrmHNkD2Oqa93AICAdBctrZsWb4S0iC5mNAI+ndl+DmfAcp0un0SH/K9Xawt8+P+s
	ZQgSCHdWXz0ULdZT1nBByCjTVQIBhbLFJjhe3eN1XiWdwu75iYJhpbRyZ/HsnZ5l9V9i
	37fTRqBX8NyiWnRvLQUxKpt25WIjxGqlcY3AJU6sh6SCFI17Xbt65u0IIdVQFMST+AdF
	ARzHUF/Wa7478U8ce1ZmNn7MaVhfX/NJei6laOVIvGjqUBJKRjmRIrnayW4N0R5JQgDg
	oeZk8q+gd6hoWgyz9hB6et5gmNnMFJ60t1I1YoMAkqxHb5bO+G6N7Eee6BVD9Ywnk03y
	t/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=pbGUq5OGQ6WVhbR/m+ajWX9YgLjEHlY33AeunqEUoog=;
	b=bknGyMzRGrEIVEBNBVN7iDy4LRxLelqKnpxfmOgjzYGrhO5uKAOHtufnKRtS2nt3yd
	3YiWxiYLQtbS0yFw3rm0+x4yMOzdrSFqH5gJrHBEczwE5vttt75emdM0ZQZ0gkKMxqsJ
	8ehjIUW5JW7+z0NjkbN+ScSIDOL8cfHjLQhZdxypK3T3ehwHqtlQrqx/0cvnsG/tB8kA
	jpO9y+HtWbHJG/dEezSUy9MWwmw2AmBYTEs87GkAaiho7e8/50Jp+/IZrLadwpWxZpg5
	T9n84CKQO2KeOVNQPq2tn9pJ9T4gABFOkCA3fpWZ4oVC7LlZk9GSFoD414iJJH5BnsH9
	/txQ==
X-Gm-Message-State: AG10YOS5dKOAai80reVjJhRteGKP8TK/ACUMH/4l5LmGEmCoC62O5RP0+3pGJL4w5md4hBR16o/Ioxvn8Q24Yg==
MIME-Version: 1.0
X-Received: by 10.202.68.196 with SMTP id r187mr4541118oia.62.1453936497485;
	Wed, 27 Jan 2016 15:14:57 -0800 (PST)
Received: by 10.182.251.133 with HTTP; Wed, 27 Jan 2016 15:14:57 -0800 (PST)
In-Reply-To: <f54dd424a32a6ae63ad59355f061c3e6291267e6.1453915249.git.pkj@axis.com>
References: <cover.1453915249.git.pkj@axis.com>
	<f54dd424a32a6ae63ad59355f061c3e6291267e6.1453915249.git.pkj@axis.com>
Date: Wed, 27 Jan 2016 15:14:57 -0800
Message-ID: <CAFNP8OsQk_swUKS=2pfLqBx8k8FFdk1WGme55YnxGk6g3A_K7A@mail.gmail.com>
From: Scott Rifenbark <srifenbark@gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: poky@yoctoproject.org, bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [poky] [PATCH 3/5] ref-manual: Update the help for BBMASK
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
X-List-Received-Date: Wed, 27 Jan 2016 23:14:57 -0000
Content-Type: multipart/alternative; boundary=001a113d6618756e19052a58f84f

--001a113d6618756e19052a58f84f
Content-Type: text/plain; charset=UTF-8

This has been applied.  see
http://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#var-BBMASK.


Thanks

On Wed, Jan 27, 2016 at 9:23 AM, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> Update the help for BBMASK to reflect that it is now allowed to
> contain multiple regular expressions. Also changed the examples for
> BBMASK to be a bit more diverse.
>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  documentation/ref-manual/ref-variables.xml | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/documentation/ref-manual/ref-variables.xml
> b/documentation/ref-manual/ref-variables.xml
> index 673e431..49aea7a 100644
> --- a/documentation/ref-manual/ref-variables.xml
> +++ b/documentation/ref-manual/ref-variables.xml
> @@ -1200,17 +1200,13 @@
>
>          <glossentry id='var-BBMASK'><glossterm>BBMASK</glossterm>
>              <info>
> -                BBMASK[doc] = "Prevents BitBake from processing specific
> recipes or recipe append files. Use the BBMASK variable from within
> conf/local.conf."
> +                BBMASK[doc] = "Prevents BitBake from processing specific
> recipes or recipe append files."
>              </info>
>              <glossdef>
>                  <para role="glossdeffirst">
>  <!--                <para role="glossdeffirst"><imagedata
> fileref="figures/define-generic.png" /> -->
>                      Prevents BitBake from processing recipes and recipe
>                      append files.
> -                    Use the <filename>BBMASK</filename> variable from
> within the
> -                    <filename>conf/local.conf</filename> file found
> -                    in the
> -                    <ulink
> url='&YOCTO_DOCS_DEV_URL;#build-directory'>Build Directory</ulink>.
>                  </para>
>
>                  <para>
> @@ -1218,14 +1214,14 @@
>                      to "hide" these <filename>.bb</filename> and
>                      <filename>.bbappend</filename> files.
>                      BitBake ignores any recipe or recipe append files that
> -                    match the expression.
> +                    match any of the expressions.
>                      It is as if BitBake does not see them at all.
>                      Consequently, matching files are not parsed or
> otherwise
>                      used by BitBake.</para>
>                  <para>
> -                    The value you provide is passed to Python's regular
> +                    The values you provide are passed to Python's regular
>                      expression compiler.
> -                    The expression is compared against the full paths to
> +                    The expressions are compared against the full paths to
>                      the files.
>                      For complete syntax information, see Python's
>                      documentation at
> @@ -1241,18 +1237,16 @@
>       BBMASK = "meta-ti/recipes-misc/"
>                      </literallayout>
>                      If you want to mask out multiple directories or
> recipes,
> -                    use the vertical bar to separate the regular
> expression
> -                    fragments.
> +                    you can specify multiple regular expression fragments.
>                      This next example masks out multiple directories and
>                      individual recipes:
>                      <literallayout class='monospaced'>
> -     BBMASK = "meta-ti/recipes-misc/|meta-ti/recipes-ti/packagegroup/"
> -     BBMASK .= "|.*meta-oe/recipes-support/"
> -     BBMASK .= "|.*openldap"
> -     BBMASK .= "|.*opencv"
> -     BBMASK .= "|.*lzma"
> +     BBMASK += "/meta-ti/recipes-misc/ meta-ti/recipes-ti/packagegroup/"
> +     BBMASK += "/meta-oe/recipes-support/"
> +     BBMASK += "/meta-foo/.*/openldap"
> +     BBMASK += "opencv.*\.bbappend"
> +     BBMASK += "lzma"
>                      </literallayout>
> -                    Notice how the vertical bar is used to append the
> fragments.
>                      <note>
>                          When specifying a directory name, use the trailing
>                          slash character to ensure you match just that
> directory
> --
> 2.1.0
>
> --
> _______________________________________________
> poky mailing list
> poky@yoctoproject.org
> https://lists.yoctoproject.org/listinfo/poky
>

--001a113d6618756e19052a58f84f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This has been applied.=C2=A0 see <a href=3D"http://ww=
w.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#var-BBMASK">http://w=
ww.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#var-BBMASK</a>.=C2=
=A0 <br><br></div>Thanks<br></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, Jan 27, 2016 at 9:23 AM, Peter Kjellerstedt <span =
dir=3D"ltr">&lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_b=
lank">peter.kjellerstedt@axis.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Update the help for BBMASK to reflect that it is now allowed=
 to<br>
contain multiple regular expressions. Also changed the examples for<br>
BBMASK to be a bit more diverse.<br>
<br>
Signed-off-by: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@=
axis.com">peter.kjellerstedt@axis.com</a>&gt;<br>
---<br>
=C2=A0documentation/ref-manual/ref-variables.xml | 26 ++++++++++-----------=
-----<br>
=C2=A01 file changed, 10 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/documentation/ref-manual/ref-variables.xml b/documentation/ref=
-manual/ref-variables.xml<br>
index 673e431..49aea7a 100644<br>
--- a/documentation/ref-manual/ref-variables.xml<br>
+++ b/documentation/ref-manual/ref-variables.xml<br>
@@ -1200,17 +1200,13 @@<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;glossentry id=3D&#39;var-BBMASK&#39;&=
gt;&lt;glossterm&gt;BBMASK&lt;/glossterm&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;info&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BBMASK[doc] =3D &q=
uot;Prevents BitBake from processing specific recipes or recipe append file=
s. Use the BBMASK variable from within conf/local.conf.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BBMASK[doc] =3D &q=
uot;Prevents BitBake from processing specific recipes or recipe append file=
s.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/info&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;glossdef&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;para role=
=3D&quot;glossdeffirst&quot;&gt;<br>
=C2=A0&lt;!--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;pa=
ra role=3D&quot;glossdeffirst&quot;&gt;&lt;imagedata fileref=3D&quot;figure=
s/define-generic.png&quot; /&gt; --&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Prevents BitBake from processing recipes and recipe<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0append files.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Use =
the &lt;filename&gt;BBMASK&lt;/filename&gt; variable from within the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;=
filename&gt;conf/local.conf&lt;/filename&gt; file found<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in t=
he<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;=
ulink url=3D&#39;&amp;YOCTO_DOCS_DEV_URL;#build-directory&#39;&gt;Build Dir=
ectory&lt;/ulink&gt;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/para&gt;=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;para&gt;<=
br>
@@ -1218,14 +1214,14 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0to &quot;hide&quot; these &lt;filename&gt;.bb&lt;/filename&gt; and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;filename&gt;.bbappend&lt;/filename&gt; files.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BitBake ignores any recipe or recipe append files that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matc=
h the expression.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matc=
h any of the expressions.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0It is as if BitBake does not see them at all.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Consequently, matching files are not parsed or otherwise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0used by BitBake.&lt;/para&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;para&gt;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The =
value you provide is passed to Python&#39;s regular<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The =
values you provide are passed to Python&#39;s regular<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0expression compiler.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The =
expression is compared against the full paths to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The =
expressions are compared against the full paths to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0the files.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0For complete syntax information, see Python&#39;s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0documentation at<br>
@@ -1241,18 +1237,16 @@<br>
=C2=A0 =C2=A0 =C2=A0 BBMASK =3D &quot;meta-ti/recipes-misc/&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;/literallayout&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0If you want to mask out multiple directories or recipes,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use =
the vertical bar to separate the regular expression<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frag=
ments.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 you =
can specify multiple regular expression fragments.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0This next example masks out multiple directories and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0individual recipes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;literallayout class=3D&#39;monospaced&#39;&gt;<br>
-=C2=A0 =C2=A0 =C2=A0BBMASK =3D &quot;meta-ti/recipes-misc/|meta-ti/recipes=
-ti/packagegroup/&quot;<br>
-=C2=A0 =C2=A0 =C2=A0BBMASK .=3D &quot;|.*meta-oe/recipes-support/&quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0BBMASK .=3D &quot;|.*openldap&quot;<br>
-=C2=A0 =C2=A0 =C2=A0BBMASK .=3D &quot;|.*opencv&quot;<br>
-=C2=A0 =C2=A0 =C2=A0BBMASK .=3D &quot;|.*lzma&quot;<br>
+=C2=A0 =C2=A0 =C2=A0BBMASK +=3D &quot;/meta-ti/recipes-misc/ meta-ti/recip=
es-ti/packagegroup/&quot;<br>
+=C2=A0 =C2=A0 =C2=A0BBMASK +=3D &quot;/meta-oe/recipes-support/&quot;<br>
+=C2=A0 =C2=A0 =C2=A0BBMASK +=3D &quot;/meta-foo/.*/openldap&quot;<br>
+=C2=A0 =C2=A0 =C2=A0BBMASK +=3D &quot;opencv.*\.bbappend&quot;<br>
+=C2=A0 =C2=A0 =C2=A0BBMASK +=3D &quot;lzma&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;/literallayout&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Noti=
ce how the vertical bar is used to append the fragments.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;note&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0When specifying a directory name, use the trailing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0slash character to ensure you match just that directory<br=
>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.0<br>
<br>
--<br>
_______________________________________________<br>
poky mailing list<br>
<a href=3D"mailto:poky@yoctoproject.org">poky@yoctoproject.org</a><br>
<a href=3D"https://lists.yoctoproject.org/listinfo/poky" rel=3D"noreferrer"=
 target=3D"_blank">https://lists.yoctoproject.org/listinfo/poky</a><br>
</font></span></blockquote></div><br></div>

--001a113d6618756e19052a58f84f--
