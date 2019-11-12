Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
	[209.85.215.169])
	by mail.openembedded.org (Postfix) with ESMTP id 9965260125
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 20:50:29 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id q17so12615369pgt.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=jW8BGsW0+PHocCpAZo/J8rWBeRM9qVPk7Yc6YF3dnX8=;
	b=UBYlIEeqYNFsytog/ThZcgcleQ5IA4t8AqAoH6psscmZFt76ht6QZyjOOipzapnuDk
	KFlUgXE+zfRwPTtjz9Cs/LFnlw90T3f35XFaclgpXdM1l/cFn1+pcMu/qXptsHfVh51b
	Z6o3mgAkDn6xDv/vrsk9S5eDbufqxeO1FbYvF+0AYc28hZe6CwzPIyaqPjtiAd+lAJYY
	sURBb11b+dsfZ2dgB3EYUOyJCRynfEpdim8iFKasbC00Xyr/FzJ50eXGgM9Owi8chCXZ
	e8zq0i+9GVXHA0O0P6Md0PMxlZdhYaqK7P9I5ae2F52JLoY+Qod44Vz1IKGex3d7YBrN
	Np+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=jW8BGsW0+PHocCpAZo/J8rWBeRM9qVPk7Yc6YF3dnX8=;
	b=tu1YYVJfXXy8gLwnatlRQUy/NDo42B0ytyexto/auSE8pu/PMifzN+jfKTWWYgwzlW
	myF1kicxuqLLDQ9A+5iuqEzsfX7G4TT1H7IJqD4hz4GzKAlCxBx2UMfGsVHM82Wtt6kS
	bYH220jmLFdj3A+dIgLYF+/mSF0vYM91mJUFp6lOBQHMkOmbqZlRLg9TkBkMPhdRvYIj
	cgWN+kHkGBMzccCAlrYm9pgys0VH9Ef1fT54NiMUzD1OgGTyW3iTE9dg6zJkweD3nUDP
	tMp0P9xBbwAyv8B9zrEihqHnjsFw3jvYKosHYzJGz5YOizo4NJuS0spB8p3NMZsAm1xg
	YcPw==
X-Gm-Message-State: APjAAAXUE5ggpSRjYSz3lQO6tJkMIaR/kx2IYSZ4Oa7p9ENBrldVZ5l9
	93wJ4I953DbLXBXhYTCC0+YvhRN1tYB6bZ3zRERX9nGdnq4=
X-Google-Smtp-Source: APXvYqxJ2rXYRrfoREmjI38ZYUCfusHPsCZq/21VSnY0xg5kTEv8PSgQC7z2NLUdjPaubwgDpOJEOa6dGbNn2BTw+0E=
X-Received: by 2002:a62:53c6:: with SMTP id h189mr4498017pfb.93.1573591830012; 
	Tue, 12 Nov 2019 12:50:30 -0800 (PST)
MIME-Version: 1.0
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Tue, 12 Nov 2019 15:49:54 -0500
Message-ID: <CAJE9sG=reXLA4GZQjBMsHc8eis=W7ejHTSmvNTAfNJ7gDBsQXw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: MACHINE_ARCH not in pkgarch (sstatesig.py)
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
X-List-Received-Date: Tue, 12 Nov 2019 20:50:29 -0000
Content-Type: multipart/alternative; boundary="0000000000000cb70105972c66a9"

--0000000000000cb70105972c66a9
Content-Type: text/plain; charset="UTF-8"

All,

In:
oe-core/meta/lib/oe/sstatesig.py

The find_sstate_manifest function will search for a manifest assuming a
number of potential paths based on various package architecture names.
However, a few of the choices appear to have needed to be queried from the
bitbake database but their bb database variable *names* are used, instead.
That yields search paths which could never be correct:

        pkgarchs = ['${MACHINE_ARCH}']
        pkgarchs = pkgarchs +
list(reversed(d2.getVar("PACKAGE_EXTRA_ARCHS").split()))
        pkgarchs.append('allarch')
        pkgarchs.append('${SDK_ARCH}_${SDK_ARCH}-${SDKPKGSUFFIX}')

        for pkgarch in pkgarchs:
                manifest =
d2.expand("${SSTATE_MANIFESTS}/manifest-%s-%s.%s" % (pkgarch, taskdata,
taskname))
                if os.path.exists(manifest):
                ...

I think we wanted something like this:

        pkgarchs = [d.getVar("MACHINE_ARCH")]
        ...

-Alan

--0000000000000cb70105972c66a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All,<div><br></div><div>In:</div><div><font face=3D"monosp=
ace">oe-core/meta/lib/oe/sstatesig.py</font></div><div><font face=3D"monosp=
ace"><br></font></div><div>The <font face=3D"monospace">find_sstate_manifes=
t</font> function will search for a manifest assuming a number of potential=
 paths based on various package architecture names.=C2=A0 However, a few of=
 the choices appear to have needed to be queried from the bitbake database =
but their bb database variable <i>names</i> are used, instead.=C2=A0 That y=
ields search paths which could never be correct:</div><div><br></div><div><=
font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D [<font col=
or=3D"#ff0000">&#39;${MACHINE_ARCH}&#39;</font>]<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pkgarchs =3D pkgarchs + list(reversed(d2.getVar(&quot;PACKAGE_EXTRA_=
ARCHS&quot;).split()))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append(&#39;=
allarch&#39;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append(<font color=3D=
"#ff0000">&#39;${SDK_ARCH}_${SDK_ARCH}-${SDKPKGSUFFIX}&#39;</font>)<br></fo=
nt></div><div><font face=3D"monospace"><br></font></div><div><font face=3D"=
monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkgarch in pkgarchs:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 manifest =3D d2.expand(&qu=
ot;${SSTATE_MANIFESTS}/manifest-%s-%s.%s&quot; % (pkgarch, taskdata, taskna=
me))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.=
exists(manifest):</font><br></div><div><font face=3D"monospace">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...</font></div><div><br></di=
v><div>I think we wanted something like this:</div><div><br clear=3D"all"><=
div><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D [<fon=
t color=3D"#ff0000">d.getVar(&quot;MACHINE_ARCH&quot;)</font>]<br></font></=
div><div><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...</font></d=
iv><div><br></div><div>-Alan</div><input name=3D"virtru-metadata" type=3D"h=
idden" value=3D"{&quot;email-policy&quot;:{&quot;state&quot;:&quot;closed&q=
uot;,&quot;expirationUnit&quot;:&quot;days&quot;,&quot;disableCopyPaste&quo=
t;:false,&quot;disablePrint&quot;:false,&quot;disableForwarding&quot;:false=
,&quot;enableNoauth&quot;:false,&quot;persistentProtection&quot;:false,&quo=
t;expandedWatermarking&quot;:false,&quot;expires&quot;:false,&quot;isManage=
d&quot;:false},&quot;attachments&quot;:{},&quot;compose-id&quot;:&quot;1&qu=
ot;,&quot;compose-window&quot;:{&quot;secure&quot;:false}}"></div></div>

--0000000000000cb70105972c66a9--
