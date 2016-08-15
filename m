Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id DF4ED7710C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:21:11 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id b22so4893227oii.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=SL5AjT7KB855LBuWYGoYZ52NoaW6QaUWHh6bQLYk7aE=;
	b=go0qthPVydRM18n5F2m5yFHnmJrQKVq89Jokg9ErerZB/StWvrhS5JXmnH3Ptokl/B
	XzRm3m61NJ0vjoD/uPIk/MdmKjLyvy8S1yxXmo4UTaIMB0p6kTcDpodX0RSp/W6PVVRW
	z805XOUa9xm5KgER8pRvMeSE9j54ExolW6WjJ2Y3/04IHIBh6BlBz5ygRVLoz/j14CxX
	iA6jGE/ZrYontGsS/avKERiOdOQa8n4kfrPDJysb8cjy3fy2FhV80vAj3wUeCGWhK5Sr
	/+XDrZdgE9/vqPaZ/fCIwL/EADz1R6cx5rMb3ValLBqT+q5nhr4X5PXp6JKrrt4vb3x/
	QUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=SL5AjT7KB855LBuWYGoYZ52NoaW6QaUWHh6bQLYk7aE=;
	b=OGBWrehoWz9+JI+oVa20BiTcflQjv7Bi7w+kZo3AgskEd1k6XsvXwVTEyIRXwbyHRF
	xCYX2L1phN/6rX43ZcQ34AMZFWGZwFgsYImdpV8PhBFIlHO3NeUVKWw0CGeEEPu7ul9X
	sJmilY23OSSSLfQ2uH7mLYUg6wdKsbJ79o305iqJiC2WCAFjWu+WG7XkGxS2MSyAUust
	FoirsBS9c03+cPdAf7OPLoNKeSSu+dCTBqffS0NxAJSsKKvkPM/n1HLiDARjsPqBPIJs
	YneeCrfSFMhkYSexJjsEOqQ55polmMwxLMooBpYHBsRQcpvCwRKXYwsJa+3aaEF41RZJ
	IT5g==
X-Gm-Message-State: AEkooutRxYBpSUtU3Qum9J9bFoFjku4ilvYSnVUrg2mmM5js9X+EEOgGzWljMpf8yFPAYB61zvP62gpmfm8eOg==
X-Received: by 10.157.63.221 with SMTP id i29mr13769128ote.156.1471281672315; 
	Mon, 15 Aug 2016 10:21:12 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 10:20:51 -0700 (PDT)
In-Reply-To: <1471280561.20391.98.camel@linuxfoundation.org>
References: <1471280561.20391.98.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 10:20:51 -0700
X-Google-Sender-Auth: 4Sw5PIocQE1iI8_spcvaAov-tyw
Message-ID: <CABcZANkPs9Y=4Xq9jWRJf8=bhqYM8DE=uv3KjwNckqavUt8G0w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: Split Cache() into a NoCache() parent object
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
X-List-Received-Date: Mon, 15 Aug 2016 17:21:16 -0000
Content-Type: multipart/alternative; boundary=001a1137cb127168a5053a1f7545

--001a1137cb127168a5053a1f7545
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 10:02 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> There are some cases we want to parse recipes without any cache
> setup or involvement. Split out the standalone functions into
> a NoCache variant which the Cache is based upon, setting the scene
> for further cleanup and restructuring.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index 7118c83..8c1fe11 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -265,12 +265,68 @@ def realfn2virtual(realfn, cls):
>          return realfn
>      return "virtual:" + cls + ":" + realfn
>
> -class Cache(object):
> +class NoCache(object):
> +
> +    def __init__(self, databuilder):
> +        self.databuilder = databuilder
> +        self.data = databuilder.data
>

I like the idea, but do we really need to pass in databuilder and set data
if this class makes no use of it? It's all class methods, after all.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1137cb127168a5053a1f7545
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 10:02 AM, Richard Purdie <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard=
.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":3dd" class=3D"a3s aXjCH m1568f27d419f5841">There are s=
ome cases we want to parse recipes without any cache<br>
setup or involvement. Split out the standalone functions into<br>
a NoCache variant which the Cache is based upon, setting the scene<br>
for further cleanup and restructuring.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;<br>
<br>
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py<br>
index 7118c83..8c1fe11 100644<br>
--- a/bitbake/lib/bb/cache.py<br>
+++ b/bitbake/lib/bb/cache.py<br>
@@ -265,12 +265,68 @@ def realfn2virtual(realfn, cls):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return realfn<br>
=C2=A0 =C2=A0 =C2=A0return &quot;virtual:&quot; + cls + &quot;:&quot; + rea=
lfn<br>
<br>
-class Cache(object):<br>
+class NoCache(object):<br>
+<br>
+=C2=A0 =C2=A0 def __init__(self, databuilder):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.databuilder =3D databuilder<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data =3D databuilder.data</div></blockquo=
te></div><br>I like the idea, but do we really need to pass in databuilder =
and set data if this class makes no use of it? It&#39;s all class methods, =
after all.<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail=
_signature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - B=
itBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software E=
ngineer, Mentor Graphics</div>
</div></div>

--001a1137cb127168a5053a1f7545--
