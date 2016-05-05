Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id B558E6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 16:29:46 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id f89so89521706ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 May 2016 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=c9ydjR82lf8fOdScUXySlKDrBSiw+AShbErr8v+ZQuE=;
	b=fFunNzObAwEZ80YpBXU5erZPbIPLTFPrjQdkX5P7ODsMAUH/houWYF/RIpwUh30kMh
	rKlr+GOeCLBpI8ZsbqQEOWFhXRkzZ4WBJ488yaTMYAwhp2H6iSA5D/7R+RBcjkMBEkS3
	xciElFGI6YVW+3cKg/g2gxGdQoQdDHM6gFZmyyMDVnQ8sEKmqBriIbXEU5Ixnm1oAWIZ
	vk4XmAt5Ey2eFHPZF4w9yO9D4Ef48lPJqFMz9349B0bxsVN/HYZCTC25J1dH/q4l3lZe
	z1QXtPIZ6Y7d10O1KP26FykHZA974G3shZVvy8iJQoO3vICOuWJcPsXnGpsA2p+glDsy
	2ZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=c9ydjR82lf8fOdScUXySlKDrBSiw+AShbErr8v+ZQuE=;
	b=IXaLOJP2UtaevI3I3IJaRkX4euexpKQcq1t87aKHJxBfnvBLSfWxbGGU/KD7ZUJLy8
	mtn+SLREkexQn1o/l+LUU21hbgTngI3UL1GAqHFy43mldH5Q+v5fEsRVw4GJkwnCtcgm
	0x/ogV+UEu1Wzof96DzCWhwxqYNwEm5gF5J+GJBxlVNwd7xOcplhXJV4SPzqdx5+q92N
	z+QsHQnFGC0eiDy5VuIXwshUyK0OkV7L7VNF5JqzJIbIFZJqwca/U8EkJyDLi/Lt0YjT
	ammQt62gToSCU01oYXe3snk7N1V0x2S6MII/PdQb9a8rVJ+dtJMF2wxMrB4FRAHAalcF
	HyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=c9ydjR82lf8fOdScUXySlKDrBSiw+AShbErr8v+ZQuE=;
	b=hmMuOYXHTYJjypYPaUmqrqeQ8i6UMPf5J3K22FeL8GEgr/PZTWtOTUx/lZzhW0LDrS
	x1Ram5ksLOS4jmd5MW509T86qtITsYKGqtdpmIZ7IvQkj4jvuq8aJ47wpBpWED3Eoerf
	q78yc2ru8+bIcr4jGSOivYWpSn4xrvH2hdPoN5lfAxDFce9o/ypILl5R8JJAgLwtYMlK
	QCp57Q0cgY6yFDrbQMBtHqCi943D6KV8WvAze2weXs9j4jjrqDVKzUVitWIQQITG5E3U
	CKq4jOY4Pw4VovPEPiXdSqwGO7mlgYnQPHPD+wFJVCZWAiXgV7U+q6i2P09uK8tQi6M6
	EsXA==
X-Gm-Message-State: AOPr4FVjpnkvuTYKsRImI6tapVMfDmMptSlq+IvI0/UIEMGtbS+cRZU/zQz6A4WuqVT06FZwsMvwGw80HMz4lA==
X-Received: by 10.107.147.7 with SMTP id v7mr18329418iod.3.1462465787344; Thu,
	05 May 2016 09:29:47 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Thu, 5 May 2016 09:29:27 -0700 (PDT)
In-Reply-To: <20160505153158.GB2562@jama>
References: <20160505153158.GB2562@jama>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 5 May 2016 09:29:27 -0700
X-Google-Sender-Auth: elLnoB12y3NhcVvrMgLMNmq5ZxM
Message-ID: <CABcZANmn5iVp3_rP-WOCeqbW=iykHTrJghmW+JaNnKigOVmkpw@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: lsof fails with python exception when bitbake is finished
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
X-List-Received-Date: Thu, 05 May 2016 16:29:47 -0000
Content-Type: multipart/alternative; boundary=94eb2c055f68c0401a05321ad9fe

--94eb2c055f68c0401a05321ad9fe
Content-Type: text/plain; charset=UTF-8

On Thu, May 5, 2016 at 8:31 AM, Martin Jansa <martin.jansa@gmail.com> wrote:

> I haven't checked what leads to this error, but with latest oe-core and
> bitbake
> I've noticed ugly python exception after successful build with bitbake:
>
>
> Summary: There were 35 WARNING messages shown.
> Process ProcessServer-1:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/multiprocessing/process.py", line 258, in
> _bootstrap
>     self.run()
>   File "/OE/bitbake/lib/bb/server/process.py", line 104, in run
>     bb.cooker.server_main(self.cooker, self.main)
>   File "/OE/bitbake/lib/bb/cooker.py", line 1692, in server_main
>     cooker.post_serve()
>   File "/OE/bitbake/lib/bb/cooker.py", line 1627, in post_serve
>     procs = subprocess.check_output(["lsof", '-w', lockfile],
> stderr=subprocess.STDOUT)
>   File "/usr/lib/python2.7/subprocess.py", line 573, in check_output
>     raise CalledProcessError(retcode, cmd, output=output)
> CalledProcessError: Command '['lsof', '-w', '/OE/bitbake.lock']' returned
> non-zero exit status 1
> /OE/$ lsof -w /OE/bitbake.lock
> /OE/$ echo $?
> 1
> /OE/$ ls -lah bitbake.lock
> -rw-rw-r-- 1 mjansa mjansa 0 May  5 13:19 bitbake.lock
>

I'd suggest catching that exception at 1627 of cooker.py and at least
printing exc.output, so we can see if lsof showed any errors.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c055f68c0401a05321ad9fe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, May 5, 2016 at 8:31 AM, Martin Jansa <span dir=3D"ltr">&lt;<a href=
=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex"><div id=3D":1wi" class=3D"">I ha=
ven&#39;t checked what leads to this error, but with latest oe-core and bit=
bake<br>
I&#39;ve noticed ugly python exception after successful build with bitbake:=
<br>
<br>
<br>
Summary: There were 35 WARNING messages shown.<br>
Process ProcessServer-1:<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/usr/lib/python2.7/multiprocessing/process.py&quot;, line=
 258, in _bootstrap<br>
=C2=A0 =C2=A0 self.run()<br>
=C2=A0 File &quot;/OE/bitbake/lib/bb/server/process.py&quot;, line 104, in =
run<br>
=C2=A0 =C2=A0 bb.cooker.server_main(self.cooker, self.main)<br>
=C2=A0 File &quot;/OE/bitbake/lib/bb/cooker.py&quot;, line 1692, in server_=
main<br>
=C2=A0 =C2=A0 cooker.post_serve()<br>
=C2=A0 File &quot;/OE/bitbake/lib/bb/cooker.py&quot;, line 1627, in post_se=
rve<br>
=C2=A0 =C2=A0 procs =3D subprocess.check_output([&quot;lsof&quot;, &#39;-w&=
#39;, lockfile], stderr=3Dsubprocess.STDOUT)<br>
=C2=A0 File &quot;/usr/lib/python2.7/subprocess.py&quot;, line 573, in chec=
k_output<br>
=C2=A0 =C2=A0 raise CalledProcessError(retcode, cmd, output=3Doutput)<br>
CalledProcessError: Command &#39;[&#39;lsof&#39;, &#39;-w&#39;, &#39;/OE/bi=
tbake.lock&#39;]&#39; returned non-zero exit status 1<br>
/OE/$ lsof -w /OE/bitbake.lock<br>
/OE/$ echo $?<br>
1<br>
/OE/$ ls -lah bitbake.lock<br>
-rw-rw-r-- 1 mjansa mjansa 0 May=C2=A0 5 13:19 bitbake.lock</div></blockquo=
te></div><br>I&#39;d suggest catching that exception at 1627 of cooker.py a=
nd at least printing exc.output, so we can see if lsof showed any errors.<b=
r>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at ke=
rgoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer =
- Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c055f68c0401a05321ad9fe--
