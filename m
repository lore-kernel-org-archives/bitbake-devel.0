Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SUf9k-0008M1-EO
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 16:24:48 +0200
Received: by wgbdr1 with SMTP id dr1so668211wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 May 2012 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=vr+LNa1v/yPP2m3DO7Ql5txiLlVJwzKaydwBRu2nlbk=;
	b=w4DFBGtMnO5zR2gSwUTQCbhiClarMivRszXqu6Ezmk7qGkAkjYLxEacnm8oYa80B+A
	GCb5pMHyfuwEWQTzFF4lZVFpySlQA7anCbpgfsXb08ucdLg59qYunkSUMSwlTzllIxeS
	A08GDhEW4J8twYUqDp2Ab01rdGlWYoDNjMDFyUDHuOKbohPj95myCu2CKgum1el8R5PG
	5s58r0wJAu8JzYtI+3b2wtNqZv0fqs/HyOBLZAjTrIpF6tEbbiSIztJeovj3QvSZwjr5
	RxPTkQ0lH/7EsMUpb0NR7ddd+GQlnRZ9KqT4hpH/LHAX3ZidKYuXSVnx1JUHTofP+1y2
	VcbQ==
Received: by 10.180.93.38 with SMTP id cr6mr8389329wib.16.1337177687112; Wed,
	16 May 2012 07:14:47 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Wed, 16 May 2012 07:14:26 -0700 (PDT)
In-Reply-To: <e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
References: <cover.1337147194.git.liezhi.yang@windriver.com>
	<e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 16 May 2012 07:14:26 -0700
X-Google-Sender-Auth: KxTNSvWn76QcjTdaVJ4uB_mg_Fo
Message-ID: <CABcZAN=Li=d73RueP18YRZSB-ExDMkW7EVw_gpF4j72Ch-j5Cg@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/2] replace os.popen with subprocess.Popen
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
X-List-Received-Date: Wed, 16 May 2012 14:24:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2012 at 10:55 PM, Robert Yang <liezhi.yang@windriver.com> w=
rote:
> Replace os.popen with subprocess.Popen since the older function would
> fail (more or less) silently if the executed program cannot be found
>
> There is a bb.process.run() which will invoke the Popen to run command,
> use it for simplify the code.
>
> More info:
> http://docs.python.org/library/subprocess.html#subprocess-replacements
>
> [YOCTO #2075]
>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/perforce.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A06 +++---
> =C2=A0bitbake/lib/bb/fetch2/svk.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0bitbake/lib/bb/ui/crumbs/builddetailspage.py | =C2=A0 =C2=A03 ++-
> =C2=A0bitbake/lib/bb/ui/crumbs/hig.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A07 ++++---
> =C2=A04 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/pe=
rforce.py
> index 6abf15d..e07afdd 100644
> --- a/bitbake/lib/bb/fetch2/perforce.py
> +++ b/bitbake/lib/bb/fetch2/perforce.py
> @@ -91,7 +91,7 @@ class Perforce(FetchMethod):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D data.getVar('FETCHCOMMAND_p4', d, T=
rue)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, "Running %s%s changes -m 1 %s=
", p4cmd, p4opt, depot)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file =3D os.popen("%s%s changes -m 1 %s" %=
 (p4cmd, p4opt, depot))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0(p4file, errors) =3D bb.process.run("%s%s ch=
anges -m 1 %s" % (p4cmd, p4opt, depot))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cset =3D p4file.readline().strip()

This is wrong, and will actually fail badly if you attempt to use
this. run() returns the values from Popen.communicate(), which returns
the data as strings, not pipes, so read() and readline() will not be
available on that object, and aren't needed. Also, the parens aren't
needed. "foo, bar =3D" is just as valid as "(foo, bar) =3D" (minor). This
should do it:

    output, errors =3D bb.process.run("%s%s changes -m 1 %s" % (p4cmd,
p4opt, depot))
    cset =3D output.strip()

> @@ -755,7 +756,7 @@ class DeployImageDialog (CrumbsDialog):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmdline =3D bb.ui=
.crumbs.utils.which_terminal()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if cmdline:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd=
line +=3D "\"sudo dd if=3D" + self.image_path + " of=3D" + combo_item + "\"=
"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0su=
bprocess.Popen(args=3Dshlex.split(cmdline))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb=
.process.run(args=3Dshlex.split(cmdline))

This is wrong, and will fail. run() has no 'args' named argument. Try
not to get discouraged -- we do appreciate the work you're doing, but
checking this in would break bitbake for a great number of people. I'd
suggest actually testing bitbake with your changes before sending them
to the list. Thanks.
--=20
Christopher Larson


