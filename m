Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
	[209.85.214.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2F9436FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jun 2016 21:51:50 +0000 (UTC)
Received: by mail-it0-f65.google.com with SMTP id k76so2605121ita.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 04 Jun 2016 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=gkhYYzl8O5+Zrh0Ac2VKPYiDcLiseBQaI0Eu8GcsrLo=;
	b=g4+rEif+QtRR2mm6SrTweIY+YWvN5LmaOrt28+XmEatUYOdX2o0Bj1HdYAnjEUiqAC
	thAxb/6QjjsG6utcJnyCWC72MhltagNcOqcBQLyZSwy0ljM34oW/zEGIOtwQoX9LDdDM
	fmjIiGnZSh7yZge8sD/7xZNeHRZ1LWMTMjFiXI9rwLU7xL0bQwR1sLJdSrpy1cd8vlRa
	/azLVCsj5DJQQJlJjumhH8LrBHVXmqSHLsFvkYCyg3dCTdqfcDBXUH5VCa3u3UvBJBJm
	wHOZ6P/ZroCEdco/3krtTqZ9YU9WotE/dIEAI8CkODe+/am/W233WWSRtIHmyiN6JkQV
	Z/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=gkhYYzl8O5+Zrh0Ac2VKPYiDcLiseBQaI0Eu8GcsrLo=;
	b=WNamu2+aNAVWrc/qICgmQU7PY7y/+8hT0iytmsDsyR78iSvEAhSqQxVuRPD8Bq/LB5
	27Rg0gkcRru2+faizziEO3fHeuYPLSzlHv0+V/y8q5Lp6osF560ojv6l2kQvOQdYqlVx
	ewJRsWnIVCCmnrgWeCHjYjkv6WE9s9tAaPbz05H6HHLrIlu/zlnmYhFFxIXWTAlafdME
	wpfP7pdImXpbzD+mKHp/KPu5mCc3dY6wuNQyWJaVlSuX9tzczdwPKhu62Y+XV4tke4yo
	K7d++EQkb1o/okxbHiyuP0blL/UTABzLSpoAuB3CzX64onr+x2k1fQLgr/nf0Dknr9eD
	UREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=gkhYYzl8O5+Zrh0Ac2VKPYiDcLiseBQaI0Eu8GcsrLo=;
	b=GTkRdYD4Uqcq4sZ4yeb3t3ZobqzWjsGvs/oU0yyK5bYlUTDgAlODbieEtr4Hfk3B1L
	oxZQTu9+ZNRvx6CgSgjJNLirpWkonq+dNBDON1d0Y/4cr1OPvkotAKFb6MuIV1ncS2LS
	RjZI7PekHZ6rnKzs5sWvM/VSiR5bQF8hza7D/jcGiCpDbbRkQ/9mb1NOB7ooZRxTSmxI
	e4+raTGtq6P7kp+e3VzKB11cSnGVLDnhCTHnDBaduPB2Wwu0meY1WkuKhshhXJxzt0TX
	YRGkt1xBS5BKsw1xrYrdhVMa2WTa8LzP/8g86Karzw3ZZNX/IgjVgWFDp74cqJ0qKNCQ
	yl+Q==
X-Gm-Message-State: ALyK8tJJ+sOJjS339iYHqu/X3Bl609EA+lQk8yxUmAsaEaZyIrsuJxLVa3XiBtgfksi7GN2thpxkWg8PoT6qqA==
X-Received: by 10.36.218.68 with SMTP id z65mr7996100itg.19.1465077111607;
	Sat, 04 Jun 2016 14:51:51 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.5 with HTTP; Sat, 4 Jun 2016 14:51:32 -0700 (PDT)
In-Reply-To: <9547b470c88646879f86e63f4371ad71@VAADCEX01.cable.comcast.com>
References: <9547b470c88646879f86e63f4371ad71@VAADCEX01.cable.comcast.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 4 Jun 2016 14:51:32 -0700
X-Google-Sender-Auth: uCGiTSqzldKo4U9sFI3deBWGYHA
Message-ID: <CABcZANmO0ymS8uUFq-GRdwi4LHm+aKwLjWRSfnafqYytNKGmOw@mail.gmail.com>
To: "Nair, Sandeep (Contractor)" <Sandeep_Nair2@cable.comcast.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Random Bitbake build failures
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
X-List-Received-Date: Sat, 04 Jun 2016 21:51:53 -0000
Content-Type: multipart/alternative; boundary=94eb2c0b09b4ce7c8005347ad8a3

--94eb2c0b09b4ce7c8005347ad8a3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 4, 2016 at 11:09 AM, Nair, Sandeep (Contractor) <
Sandeep_Nair2@cable.comcast.com> wrote:

> We are facing random failures with Bitbake builds. Bitbake is returning a=
n
> error even when the operation succeeded on the successful retry.
>
>
>
> Eg:
>
>
>
> ERROR: Error executing a python function in
> /mnt/jenkins/workspace/PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-ext=
ended/netzyn/
> netzyn_git.bb:
>
> Exception: IOError: [Errno 116] Stale file handle
>
>
>
> WARNING: Logfile for failed setscene task is
> /mnt/jenkins/workspace/PACEXI3V2-Yocto-Build/build-pacexi3v2/tmp/work/mip=
s32el-rdk-linux/netzyn/1.99+gitAUTOINC+c3752ca038_c7068967a1-r0/temp/log.do=
_package_setscene.8946
>
> WARNING: Setscene task 1277
> (/mnt/jenkins/workspace/PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-ex=
tended/netzyn/
> netzyn_git.bb, do_package_setscene) failed with exit code '1' - real task
> will be run instead
>
>
>
> =E2=80=9CSetscene=E2=80=9D is a bb attempt to use sstate cache.
>
>
>
> It says about real task will run instead. Does that mean it tried build
> locally (it should)?
>
>
>
> In all stale cases it fails in this code:
>
>
>
> File: =E2=80=98=E2=80=A6./openembedded-core/bitbake/lib/bb/utils.py', lin=
eno: 467,
> function: md5_file
>
>      0463:        import md5
>
>      0464:        m =3D md5.new()
>
>      0465:
>
>      0466:    with open(filename, "rb") as f:
>
> *** 0467:        for line in f:
>
>      0468:            m.update(line)
>
>      0469:    return m.hexdigest()
>
>      0470:
>
>
>
> As can be seen it tries use handle it was given but the file is not valid
> on remote side already. So system lib returns stale handle.
>

remote side? bitbake builds have never been supported on nfs. But yes,
generally the real task runs if the setscene fails.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c0b09b4ce7c8005347ad8a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 4, 2016 at 11:09 AM, Nair, Sandeep (Contractor) <span dir=3D"lt=
r">&lt;<a href=3D"mailto:Sandeep_Nair2@cable.comcast.com" target=3D"_blank"=
>Sandeep_Nair2@cable.comcast.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><p class=3D"MsoNormal">We are facing random failures with Bit=
bake builds. Bitbake is returning an error even when the operation succeede=
d on the successful retry.
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Eg: <u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">ERROR: Error executing a python function in /mnt/jen=
kins/workspace/PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-extended/netz=
yn/<a href=3D"http://netzyn_git.bb" target=3D"_blank">netzyn_git.bb</a>:<u>=
</u><u></u></p>
<p class=3D"MsoNormal">Exception: IOError: [Errno 116] Stale file handle<u>=
</u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">WARNING: Logfile for failed setscene task is /mnt/je=
nkins/workspace/PACEXI3V2-Yocto-Build/build-pacexi3v2/tmp/work/mips32el-rdk=
-linux/netzyn/1.99+gitAUTOINC+c3752ca038_c7068967a1-r0/temp/log.do_package_=
setscene.8946<u></u><u></u></p>
<p class=3D"MsoNormal">WARNING: Setscene task 1277 (/mnt/jenkins/workspace/=
PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-extended/netzyn/<a href=3D"h=
ttp://netzyn_git.bb" target=3D"_blank">netzyn_git.bb</a>, do_package_setsce=
ne) failed with exit code &#39;1&#39; - real task will be run instead<u></u=
><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=E2=80=9CSetscene=E2=80=9D is a bb attempt to use ss=
tate cache.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">It says about real task will run instead. Does that =
mean it tried build locally (it should)?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">In all stale cases it fails in this code: <u></u><u>=
</u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">File: =E2=80=98=E2=80=A6./openembedded-core/bitbake/=
lib/bb/utils.py&#39;, lineno: 467, function: md5_file<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0463:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 import md5<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0464:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 m =3D md5.new()<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0465:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0466:=C2=A0=C2=A0=C2=A0 wit=
h open(filename, &quot;rb&quot;) as f:<u></u><u></u></p>
<p class=3D"MsoNormal">*** 0467:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for line in f:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0468:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0m.update(line)<u></u><u></u><=
/p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0469:=C2=A0=C2=A0=C2=A0 ret=
urn m.hexdigest()<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 0470:<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">As can be seen it tries use handle it was given but =
the file is not valid on remote side already. So system lib returns stale h=
andle.</p></blockquote><div><br></div><div>remote side? bitbake builds have=
 never been supported on nfs. But yes, generally the real task runs if the =
setscene fails.</div></div>-- <br><div class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<b=
r>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Seni=
or Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c0b09b4ce7c8005347ad8a3--
