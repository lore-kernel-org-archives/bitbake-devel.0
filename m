Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1T51TZ-00070P-NB
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 23:31:34 +0200
Received: by iaky10 with SMTP id y10so4196831iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2012 14:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=wCPoUdaZ72MNqEQwNIyoqWyBwhnsKdV/pHIkQnU+vrY=;
	b=ds8yvW50fCWAKP4Bqk7ncJHxFajnNoE3vgP1BBnNmi3yv/Lbm8eMLczWoz0DrWf449
	UMVMWNFiOR1WZ/Xn+8ms569w/s7Peq/MmN2Pn643a6vOsR7HI+LDQiJevA6XnwFKLT9U
	o6sv3p6rnZ+4tnCilJMk0meV8O1CC2dK2W5T6RURRq4DqggfxPrvdaBpyY1UlzKvex1w
	qgt27cIwoTCu+oCE4/AK1UXCPu0Wpv5VtdfE7+gvm9gi0cjCzQHAbjAc18JCoJ70iGla
	spZGbzfXxDIT86yph+gRKBbKSekaXsynJou8JERn+Kn0lSVQHgGBos481X9a3Tkn4zDG
	QbqQ==
Received: by 10.50.189.167 with SMTP id gj7mr3592933igc.34.1345843165137; Fri,
	24 Aug 2012 14:19:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.63.50 with HTTP; Fri, 24 Aug 2012 14:19:04 -0700 (PDT)
X-Originating-IP: [79.118.181.96]
In-Reply-To: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
From: Andrei Gherzan <andrei@gherzan.ro>
Date: Sat, 25 Aug 2012 00:19:04 +0300
Message-ID: <CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
X-Gm-Message-State: ALoCoQmh9s38+x04U6BJVl3+muHYoHk1M4g3el3I2eBs4T1UAMoe75UFMnSamXNRc4vu+vPCmh39
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] clarify wording
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
X-List-Received-Date: Fri, 24 Aug 2012 21:31:34 -0000
Content-Type: multipart/alternative; boundary=14dae9340efbc80b7404c8098721

--14dae9340efbc80b7404c8098721
Content-Type: text/plain; charset=ISO-8859-1

Modify the commit subject. to include what you are changing. In your case
the subject should be something like:
"bitbake: Clarify wording"

On Fri, Aug 24, 2012 at 3:22 AM, Trevor Woerner <twoerner@gmail.com> wrote:

> From: Trevor Woerner <twoerner@gmail.com>
>
> The '-s' option shows (input) recipes, not (built/output) packages. Clarify
> the help wording for this option so it is consistent.
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  bin/bitbake |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index 0b4f556..ed2ff06 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -142,7 +142,7 @@ Default BBFILES are the .bb files in the current
> directory.""")
>      parser.add_option("-p", "--parse-only", help = "quit after parsing
> the BB files (developers only)",
>                 action = "store_true", dest = "parse_only", default =
> False)
>
> -    parser.add_option("-s", "--show-versions", help = "show current and
> preferred versions of all packages",
> +    parser.add_option("-s", "--show-versions", help = "show current and
> preferred versions of all recipes",
>                 action = "store_true", dest = "show_versions", default =
> False)
>
>      parser.add_option("-e", "--environment", help = "show the global or
> per-package environment (this is what used to be bbread)",
> --
> 1.7.10.GIT
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>

--14dae9340efbc80b7404c8098721
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Modify=A0the commit subject. to include what you=
 are changing. In your case the subject should be something like:</div><div=
 class=3D"gmail_quote">&quot;bitbake: Clarify wording&quot;</div><div class=
=3D"gmail_quote">

<br></div><div class=3D"gmail_quote">On Fri, Aug 24, 2012 at 3:22 AM, Trevo=
r Woerner <span dir=3D"ltr">&lt;<a href=3D"mailto:twoerner@gmail.com" targe=
t=3D"_blank">twoerner@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

From: Trevor Woerner &lt;<a href=3D"mailto:twoerner@gmail.com">twoerner@gma=
il.com</a>&gt;<br>
<br>
The &#39;-s&#39; option shows (input) recipes, not (built/output) packages.=
 Clarify<br>
the help wording for this option so it is consistent.<br>
<br>
Signed-off-by: Trevor Woerner &lt;<a href=3D"mailto:twoerner@gmail.com">two=
erner@gmail.com</a>&gt;<br>
---<br>
=A0bin/bitbake | =A0 =A02 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bin/bitbake b/bin/bitbake<br>
index 0b4f556..ed2ff06 100755<br>
--- a/bin/bitbake<br>
+++ b/bin/bitbake<br>
@@ -142,7 +142,7 @@ Default BBFILES are the .bb files in the current direct=
ory.&quot;&quot;&quot;)<br>
=A0 =A0 =A0parser.add_option(&quot;-p&quot;, &quot;--parse-only&quot;, help=
 =3D &quot;quit after parsing the BB files (developers only)&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D &quot;store_true&quot;, dest =3D=
 &quot;parse_only&quot;, default =3D False)<br>
<br>
- =A0 =A0parser.add_option(&quot;-s&quot;, &quot;--show-versions&quot;, hel=
p =3D &quot;show current and preferred versions of all packages&quot;,<br>
+ =A0 =A0parser.add_option(&quot;-s&quot;, &quot;--show-versions&quot;, hel=
p =3D &quot;show current and preferred versions of all recipes&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D &quot;store_true&quot;, dest =3D=
 &quot;show_versions&quot;, default =3D False)<br>
<br>
=A0 =A0 =A0parser.add_option(&quot;-e&quot;, &quot;--environment&quot;, hel=
p =3D &quot;show the global or per-package environment (this is what used t=
o be bbread)&quot;,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.10.GIT<br>
<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-deve=
l" target=3D"_blank">http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bi=
tbake-devel</a><br>
</font></span></blockquote></div><br>

--14dae9340efbc80b7404c8098721--
