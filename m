Return-Path: <kergoth@gmail.com>
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
	[209.85.210.181])
	by mail.openembedded.org (Postfix) with ESMTP id BEA417C617
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Oct 2019 02:35:03 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id q26so2172029pfn.11
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Oct 2019 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:message-id:in-reply-to:references:subject:mime-version; 
	bh=xCwmgvO/4BGWd3tAPcJCpTOy8oYV/wn4gtdy6wf2ebQ=;
	b=b60kWUrwMlCLAPtaW2MIwhl6toYaz6MreSGSJU4McWQGkhyyUbf+MsKC44Gqhr1pck
	N8gjrsMh5AZOIv09UcW7skmDCxAnAxJrn7K6QnRspn3v7Bu2t3tK/vN1myrYZyba8klj
	GuJx6HxTGQUzzHROBo4hCc2JkBXWsT1BcWjlOgxuHOeE1BelAd8UXJjgIPCiwIxQ6Yvb
	bSl0wQufIY2Td5kes3Z8mNY1hWwHad6UwXJGl5r93QwGaWpm/d8yjQE2vc39rf67dei1
	8uRC1yDXkvj9qcgQSDA1UCpMBsitMWwk3y02WO8fH+92cRD5ZVTSzaIKUw9lnj16qaga
	9RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
	:subject:mime-version;
	bh=xCwmgvO/4BGWd3tAPcJCpTOy8oYV/wn4gtdy6wf2ebQ=;
	b=P2nSvhxqWPY9ix621iqv5NAmp6GEIIQt4/BcFHHa5WDjOAs2+Et9ZYKsTnm5lbcTDG
	Py4r42HQSDWrG9YoJha6s+GS+E7Z0hxnbDcaONiiCLt8Rdg857yUTvjkPgfFCmKXQJls
	f0vqmNBeBsAzUX8wPrN3s7QRRWVvBJONEHb4nIvOQcGNwc5zlLs30wWzVWWhAXu5CG2N
	Y9PT8rc4e4Itr9kNcxKwVNHiQC/hWUDfy2f/KlFHApXpp6X3Oxhs7P5osTBlVl80+6rW
	7aN9QEujRBgslWzOp3TFgtJitXnP+6lS5JLITNIV4jwcW0I4CUDO1+OdgzgEXromyCq4
	XxzQ==
X-Gm-Message-State: APjAAAVH0Hb8eAUNj1EN3KT99icJKKgnN3T1O65YP73xmZXfQyOJFjsy
	1WwDXyR1U3Rr9XAV01jPyJRRany91Xg=
X-Google-Smtp-Source: APXvYqwfyQAcXCivC81uZuYtXYo4TKkDz6JM6Cty6pYXgUPyLDH+O78kopjNq49Lt4h+7JTAowfK/g==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr17991371pgh.193.1572230103806;
	Sun, 27 Oct 2019 19:35:03 -0700 (PDT)
Received: from [192.168.1.17] (ip70-180-21-74.ph.ph.cox.net. [70.180.21.74])
	by smtp.gmail.com with ESMTPSA id
	ce16sm7870899pjb.29.2019.10.27.19.35.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 27 Oct 2019 19:35:02 -0700 (PDT)
Date: Sun, 27 Oct 2019 19:34:52 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Konrad Scherer
	<Konrad.Scherer@windriver.com>
Message-ID: <409e8bd1-f128-43bb-8332-87ca1c91d277@Spark>
In-Reply-To: <f49f3c55-72d8-a781-955d-8f257a42615d@windriver.com>
References: <f49f3c55-72d8-a781-955d-8f257a42615d@windriver.com>
X-Readdle-Message-ID: 409e8bd1-f128-43bb-8332-87ca1c91d277@Spark
MIME-Version: 1.0
Subject: Re: Using gitsm fetcher and PREMIRROR
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
X-List-Received-Date: Mon, 28 Oct 2019 02:35:04 -0000
Content-Type: multipart/alternative; boundary="5db653d4_2ae8944a_1105f"

--5db653d4_2ae8944a_1105f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Don=E2=80=99t have time for a full reply at the moment, I=E2=80=99ll take=
 a look in the morning, but I did want to note that=C2=A0git2=5Fboringssl=
.googlesource.com.boringssl.tar.gz is a full git mirror tarball as genera=
ted by BB=5FGENERATE=5FMIRROR=5FTARBALLS, and the premirrors fetching wil=
l download and use them if you want to skip the git-http-backend approach=
 entirely. They are *not* shallow in any way. Only gitshallow=5F*.tar.gz =
are shallow tarballs.
On Oct 25, 2019, 1:39 PM -0700, Konrad Scherer <Konrad.Scherer=40windrive=
r.com>, wrote:
> Hello,
>
> I recently found a strange problem involving the gitsm fetcher and our =
PREMIRRORS and I was able to
> reproduce it using poky.
>
> > git clone git://git.yoctoproject.org/poky poky1
> > cd poky1
> > . oe-init-build-env
> > bitbake ovmf
>
> The ovmf recipe has git submodules inside git submodules. This step wor=
ks fine.
>
> I then exposed the downloads directory over http (http://<host>/downloa=
ds) and the downloads/git2
> directory over http with git-http-backend enabled (http://<host>/git).
>
> I noticed that there are shallow clone tarballs in downloads that match=
 the git repos in
> downloads/git2. =46or example:
>
> downloads/git2/boringssl.googlesource.com.boringssl/
> downloads/git2=5Fboringssl.googlesource.com.boringssl.tar.gz
>
> Since these are duplicates of the git repos, I deleted the tar.gz files=

>
> > rm -f downloads/git2=5F*
>
> <new shell>
>
> > git clone git://git.yoctoproject.org/poky poky2
> > cd poky2
> > . oe-init-build-env
> > cat >> conf/local.conf <<EO=46
> WRS=5FMIRROR=5FHOST =3D =22<host>=22
> BB=5FALLOWED=5FNETWORKS =3D =22=24=7BWRS=5FMIRROR=5FHOST=7D=22
>
> BB=5FNO=5FNETWORK =3D '0'
> BB=5F=46ETCH=5FPREMIRRORONLY =3D '1'
>
> PREMIRRORS=5Fappend =3D =22 =5C
> .*://.*/.* http://=24=7BWRS=5FMIRROR=5FHOST=7D/downloads/ =5Cn =5C
> git://.*/.* git://=24=7BWRS=5FMIRROR=5FHOST=7D/git/MIRRORNAME;protocol=3D=
http =5Cn =5C
> gitsm://.*/.* git://=24=7BWRS=5FMIRROR=5FHOST=7D/git/MIRRORNAME;protoco=
l=3Dhttp =5Cn =5C
> =22
> CONNECTIVITY=5FCHECK=5FURIS =3D =22=22
> EO=46
> > bitbake ovmf
>
> This fails with:
>
> ERROR: ovmf-edk2-stable201905-r0 do=5Funpack: gitsm: submodule unpack f=
ailed: UnpackError Unpack
> failure for URL:
> 'gitsm://github.com/openssl/openssl;protocol=3Dhttps;name=3DCryptoPkg/L=
ibrary/OpensslLib/openssl;subpath=3DCryptoPkg/Library/OpensslLib/openssl;=
bareclone=3D1;nobranch=3D1'.
> No up to date source found: clone directory not available or not up to =
date:
> /ala-lpggp22/kscherer/gitsm/poky2/build/downloads/git2/github.com.opens=
sl.openssl; shallow clone not
> enabled
>
> If I leave the shallow clone tarballs in the PREMIRROR the build succee=
ds. The other recipes that
> use git are fetched properly. The logs don't have any warnings before t=
he error and I verified that
> the objects are indeed present in the repo.
>
> Are my PREMIRROR settings correct=3F Is this a bug in the gitsm fetcher=
=3F
>
> Any help and insight appreciated.
>
> --
> Konrad Scherer, MTS, Linux Products Group, Wind River
> --
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> bitbake-devel mailing list
> bitbake-devel=40lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--5db653d4_2ae8944a_1105f
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Don=E2=80=99t have time for a full reply at the mom=
ent, I=E2=80=99ll take a look in the morning, but I did want to note that=
&=23160;git2=5Fboringssl.googlesource.com.boringssl.tar.gz is a full git =
mirror tarball as generated by BB=5FGENERATE=5FMIRROR=5FTARBALLS, and the=
 premirrors fetching will download and use them if you want to skip the g=
it-http-backend approach entirely. They are *not* shallow in any way. Onl=
y gitshallow=5F*.tar.gz are shallow tarballs.</div>
</div>
<div name=3D=22messageReplySection=22>On Oct 25, 2019, 1:39 PM -0700, Kon=
rad Scherer &lt;Konrad.Scherer=40windriver.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>He=
llo,<br />
<br />
I recently found a strange problem involving the gitsm fetcher and our PR=
EMIRRORS and I was able to<br />
reproduce it using poky.<br />
<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>gi=
t clone git://git.yoctoproject.org/poky poky1<br />
cd poky1<br />
. oe-init-build-env<br />
bitbake ovmf<br /></blockquote>
<br />
The ovmf recipe has git submodules inside git submodules. This step works=
 fine.<br />
<br />
I then exposed the downloads directory over http (http://&lt;host&gt;/dow=
nloads) and the downloads/git2<br />
directory over http with git-http-backend enabled (http://&lt;host&gt;/gi=
t).<br />
<br />
I noticed that there are shallow clone tarballs in downloads that match t=
he git repos in<br />
downloads/git2. =46or example:<br />
<br />
downloads/git2/boringssl.googlesource.com.boringssl/<br />
downloads/git2=5Fboringssl.googlesource.com.boringssl.tar.gz<br />
<br />
Since these are duplicates of the git repos, I deleted the tar.gz files<b=
r />
<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>rm=
 -f downloads/git2=5F*<br /></blockquote>
<br />
&lt;new shell&gt;<br />
<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>gi=
t clone git://git.yoctoproject.org/poky poky2<br />
cd poky2<br />
. oe-init-build-env<br />
cat &gt;&gt; conf/local.conf &lt;&lt;EO=46<br /></blockquote>
WRS=5FMIRROR=5FHOST =3D =22&lt;host&gt;=22<br />
BB=5FALLOWED=5FNETWORKS =3D =22=24=7BWRS=5FMIRROR=5FHOST=7D=22<br />
<br />
BB=5FNO=5FNETWORK =3D '0'<br />
BB=5F=46ETCH=5FPREMIRRORONLY =3D '1'<br />
<br />
PREMIRRORS=5Fappend =3D =22 =5C<br />
.*://.*/.* http://=24=7BWRS=5FMIRROR=5FHOST=7D/downloads/ =5Cn =5C<br />
git://.*/.* git://=24=7BWRS=5FMIRROR=5FHOST=7D/git/MIRRORNAME;protocol=3D=
http =5Cn =5C<br />
gitsm://.*/.* git://=24=7BWRS=5FMIRROR=5FHOST=7D/git/MIRRORNAME;protocol=3D=
http =5Cn =5C<br />
=22<br />
CONNECTIVITY=5FCHECK=5FURIS =3D =22=22<br />
EO=46<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =23e67e22;=22>bi=
tbake ovmf<br /></blockquote>
<br />
This fails with:<br />
<br />
ERROR: ovmf-edk2-stable201905-r0 do=5Funpack: gitsm: submodule unpack fai=
led: UnpackError Unpack<br />
failure for URL:<br />
'gitsm://github.com/openssl/openssl;protocol=3Dhttps;name=3DCryptoPkg/Lib=
rary/OpensslLib/openssl;subpath=3DCryptoPkg/Library/OpensslLib/openssl;ba=
reclone=3D1;nobranch=3D1'.<br />
No up to date source found: clone directory not available or not up to da=
te:<br />
/ala-lpggp22/kscherer/gitsm/poky2/build/downloads/git2/github.com.openssl=
.openssl; shallow clone not<br />
enabled<br />
<br />
If I leave the shallow clone tarballs in the PREMIRROR the build succeeds=
. The other recipes that<br />
use git are fetched properly. The logs don't have any warnings before the=
 error and I verified that<br />
the objects are indeed present in the repo.<br />
<br />
Are my PREMIRROR settings correct=3F Is this a bug in the gitsm fetcher=3F=
<br />
<br />
Any help and insight appreciated.<br />
<br />
--<br />
Konrad Scherer, MTS, Linux Products Group, Wind River<br />
--<br />
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br />
bitbake-devel mailing list<br />
bitbake-devel=40lists.openembedded.org<br />
http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br /></block=
quote>
</div>
</body>
</html>

--5db653d4_2ae8944a_1105f--
