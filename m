Return-Path: <mounesh.sutar@gmail.com>
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com
	[209.85.217.182])
	by mail.openembedded.org (Postfix) with ESMTP id B4AEE6FFCC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Dec 2016 06:01:03 +0000 (UTC)
Received: by mail-ua0-f182.google.com with SMTP id 51so438616217uai.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Dec 2016 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=j/T7/hOekh3Z87ZVPH18cxOpVJqMjQPt/a2dXJoBBzQ=;
	b=lHNHaOzn/UvSegA2q05Db0ZSDv2JjL4vEyxsXEuz0O/StQigKFbaL+AN0p87jA+ubo
	JtrqyYsXZiUxRAWD7/AfDbWQJZs/ls2JBP4MBhDcV/dBgYVT50CJFA+R4CsakArRBLEI
	9GRXpUn6wPYYg5lRMFA7TesrI05ANvGlFzJOBD0X0OQmYOof+QaLVxVNHd2ZiNprZbu8
	4nxmpDBy/bQ8xrcpLmRSaM/RBMHzbJTdxkGnQGxKt0utHCjXHkAFsszzsjuZMTFQXkKa
	dK6kFh1l0HLXURLbT/+AkB8YwjQ+cXngpoOBsWA7rfqmSNM+bRTSeyTW1c6zOsXjtgz+
	cAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=j/T7/hOekh3Z87ZVPH18cxOpVJqMjQPt/a2dXJoBBzQ=;
	b=Q+ZKbdk29iPdhcVezBOMQIgo+HWbrC3BMdXq/PUqS58o0C+AhE+43JOyYkBPXRMOHo
	/7EHvmN6UPw2mZ6w8mIXIzD34EW6FKZZMM1cj5JKk5KOFRg68xZU3aONhluIyWeBkVtk
	89BEaTn17Kx4WOtIqWv1BMHO9UEGylZljt1GMndGOClNZcXHwLzRsS1lvx/+ZRkn9uzg
	Jx3Qwr+ViX5qmvMkHkEb7g3OmCOTwexoajyYyHYbcsoLb9KHDSjvkO9p+P2Z734xGR/9
	9gOs3ecYMiI3Kk4JeN7m5X/sx50Ctd7XAED+SVFLPdMGqyy4NUJd4yzm2FfcFkqSCyw/
	fxKA==
X-Gm-Message-State: AKaTC00m1vVrLn6NC0LAFRNpIc7RPrwRNd4y5o3B3KpXGOa+EGEr27V9I2O9vyBpQeej/VnLWjBA0CsOdaXr3w==
X-Received: by 10.159.53.100 with SMTP id o91mr46021611uao.146.1481176864545; 
	Wed, 07 Dec 2016 22:01:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.126.85 with HTTP; Wed, 7 Dec 2016 22:01:04 -0800 (PST)
In-Reply-To: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
References: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
From: Mounesh Sutar <mounesh.sutar@gmail.com>
Date: Thu, 8 Dec 2016 11:31:04 +0530
Message-ID: <CAOtT3B52FFNZHsx+7GQwtLp0qoWvZ3C5AxU4tVYm5cPnAZC3Zg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: Re: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Thu, 08 Dec 2016 06:01:03 -0000
Content-Type: multipart/alternative; boundary=94eb2c03f976dc5fc805431f5c1f

--94eb2c03f976dc5fc805431f5c1f
Content-Type: text/plain; charset=UTF-8

Hi,
Adding more information about this issue.
For example, consider below recipes with respective Pattern Name and
priority.

Package Name           Recipe file path
 BBFILE_PATTERN                    Priority

alsa                           /Projects/abc/alsa
/Projects/abc/alsa                            160
layer-man                 /Projects/abc/layer-man
/Projects/abc/layer-man                  150
xyz                            /Projects/abc/xyz
   /Projects/abc/xyz                             130
gpu-viv                      /Projects/abc/xyz/gpu-viv
/Projects/abc/xyz/gpu-viv                 130
update-1                   /Projects/abc/xyz/update-1
/Projects/abc/xyz/update-1              130
update-2                   /Projects/abc/xyz/update-2
/Projects/abc/xyz/update-2              130


If we consider the case of parsing alsa recipe, with its file name parsing
against all patterns, it would find matching pattern("/Projects/abc/alsa ")
and parse successfully.
Similarly the case with layer-man recipes.
When it comes to case of xyz, it does parses like other alsa recipe, as it
would find matching pattern("/Projects/abc/xyz") to its file name.
When it picks up next gpu-viv recipe file("/Projects/abc/xyz/gpu-viv/*/*.bb"),
and starts parsing against all PATTERNs,
on finding pattern "/Projects/abc/xyz", the condition :
"if regex.match(filename):"

will succeed, as partial file name "/Projects/abc/xyz/gpu-viv" matches to
it.
So, it is not matching against correct pattern ("Projects/abc/xyz/gpu-viv").
This is causing remaining recipes of folder "xyz" are not being parsed
against all patterns.
By current change, it will force to parse all recipe files against all
PATTERN's and store matching patterns.

Regards,
Mounesh

On Tue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar <mounesh.sutar@gmail.com>
wrote:

> From: Mounesh Sutar <mounesh_sutar@mentor.com>
>
> bitbake is parsing all recipe files, against layers BBFILE_PATTERN for
> warning message display.
> In case of sublayer with lower/equal priority, then all sublayer's
> patterns are not being
> considered for pattern match. While checking recipe file against matching
> pattern,
> the first matching pattern is accepted and added to matched list, while
> remaning PATTERNs are
> not being considered. With this, the recipes are being neglected from
> PATTERN match.
> This fix let's parser run through all the layers PATTERNs and on matching
> added to match list.
>
> Upstream-Status: Submitted [bitbake-devel@lists.openembedded.org]
>
> Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
> ---
>  bitbake/lib/bb/cooker.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 4df8881..5fde995 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):
>                  if matched != None:
>                      if not regex in matched:
>                          matched.add(regex)
> -                return pri
> +                        return pri
>          return 0
>
>      def get_bbfiles(self):
> --
> 1.7.9.5
>
>

--94eb2c03f976dc5fc805431f5c1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>
Adding more information about this issue.<br>
For example, consider below recipes with respective Pattern Name and priori=
ty.<br>
<br>
Package Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Recipe file path=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BBFILE_PATTERN=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Priority<br>
<br>
alsa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 /Projects/abc/alsa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 /Proje=
cts/abc/alsa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 160<br>
layer-man=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 /Pro=
jects/abc/layer-man=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0 /Projects/abc/layer-man=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 150<br>
xyz=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /Projects/abc/xyz=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
 /Projects/abc/xyz=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 130<br>
gpu-viv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /Projects/abc/xyz/gpu-viv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /Projects/abc/xyz/gpu-viv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0130<br>
update-1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 /Projects/abc/xyz/update-1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /Projects/abc/xyz/update-1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 130<br>
update-2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=
=A0 /Projects/abc/xyz/update-2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /Projects/abc/xyz/update-2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 130<br>=C2=A0
<br>
<br>
If we consider the case of parsing alsa recipe, with its file name=20
parsing against all patterns, it would find matching=20
pattern(&quot;/Projects/abc/alsa &quot;) and parse successfully.<br>
Similarly the case with layer-man recipes.<br>
When it comes to case of xyz, it does parses like other alsa recipe, as=20
it would find matching pattern(&quot;/Projects/abc/xyz&quot;) to its file n=
ame.<br>
When it picks up next gpu-viv recipe file(&quot;/Projects/abc/xyz/gpu-<wbr>=
viv/*/*.bb&quot;), and starts parsing against all PATTERNs,<br>
on finding pattern &quot;/Projects/abc/xyz&quot;, the condition :<br>
&quot;if regex.match(filename):&quot;<br>
<br>
will succeed, as partial file name &quot;/Projects/abc/xyz/gpu-viv&quot; ma=
tches to it.<br>
So, it is not matching against correct pattern (&quot;Projects/abc/xyz/gpu-=
viv&quot;).<br>
This is causing remaining recipes of folder &quot;xyz&quot; are not being p=
arsed against all patterns.<br>
By current change, it will force to parse all recipe files against all PATT=
ERN&#39;s and store matching patterns.<br>
<br>
Regards,<br>
Mounesh</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On T=
ue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mounesh.sutar@gmail.com" target=3D"_blank">mounesh.sutar@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Mounesh Su=
tar &lt;<a href=3D"mailto:mounesh_sutar@mentor.com">mounesh_sutar@mentor.co=
m</a>&gt;<br>
<br>
bitbake is parsing all recipe files, against layers BBFILE_PATTERN for warn=
ing message display.<br>
In case of sublayer with lower/equal priority, then all sublayer&#39;s patt=
erns are not being<br>
considered for pattern match. While checking recipe file against matching p=
attern,<br>
the first matching pattern is accepted and added to matched list, while rem=
aning PATTERNs are<br>
not being considered. With this, the recipes are being neglected from PATTE=
RN match.<br>
This fix let&#39;s parser run through all the layers PATTERNs and on matchi=
ng added to match list.<br>
<br>
Upstream-Status: Submitted [<a href=3D"mailto:bitbake-devel@lists.openembed=
ded.org">bitbake-devel@lists.<wbr>openembedded.org</a>]<br>
<br>
Signed-off-by: Mounesh Sutar &lt;<a href=3D"mailto:mounesh_sutar@mentor.com=
">mounesh_sutar@mentor.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/cooker.py |=C2=A0 =C2=A0 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
index 4df8881..5fde995 100644<br>
--- a/bitbake/lib/bb/cooker.py<br>
+++ b/bitbake/lib/bb/cooker.py<br>
@@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if matched !=
=3D None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if not regex in matched:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0matched.add(regex)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pri<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return pri<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_bbfiles(self):<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c03f976dc5fc805431f5c1f--
