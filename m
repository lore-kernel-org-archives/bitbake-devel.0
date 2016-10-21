Return-Path: <nitishjha16@gmail.com>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
	[209.85.215.45])
	by mail.openembedded.org (Postfix) with ESMTP id 3183171AB6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Oct 2016 14:55:26 +0000 (UTC)
Received: by mail-lf0-f45.google.com with SMTP id b75so146945816lfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Oct 2016 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=PAkrPr2qz9cDK/xdn1xXfCiQ4xZtWOd1YF3O8M0lWQI=;
	b=r4QYeN4wKDMSwGqU80h8X/agMS1hfeOXniRkEZ5flTCntmhWCaYirMR1bfL/LdWLHA
	/Eavj8vryUji1KMm69uIzdAO/4R0VEDZsdefTmtruc/aYFzXKZWAmOFMrDqfUkvJAU2R
	GqlnR0FAqw/J1AIGGEWweNHUCN3Dh4k8OU9XlgkX2VXdVsVAtrMMko3Sk4BlTVku673T
	ZOnJDdDqehVIHuiRLgATSLTIOuq2srdYgxyX2ee9MJHycsnC3Kxw9E7bsHpbEjqGI8Ly
	uIRW8qjd5blvpeCXFMFvM2EcIhBl9dQmjUDOSnzGonguOXC/xdbk1XHi4OVMJlKYsDzi
	Rw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=PAkrPr2qz9cDK/xdn1xXfCiQ4xZtWOd1YF3O8M0lWQI=;
	b=AVw9WBTRMC5kScyvn1cgvCKDpVN4btYn4VOv9B17XDYYUvmraciOxoP34ODKqHzKYJ
	qvYaNO5hj/aE3JLADwFOj2MThLQLQ4LaljKex3R9GMS3U0ssJw3RejcIK3GbV7lca4qe
	uRVda0n1rxuwzVx0L/CUko137rFSDgewHNie9HIwtjiz89JLszvVGj+h48apzs9Rfn1g
	pDSfPORbysIYqJsrSJCB6q+jXtfjp5tG3RietdN+yFtIvnZQjFW/dMrx2fBprNbyhPvv
	SrSb5YWxzJazDkj26MekTpA1ENU1c9XXL4PddFZNibud/p7eg9mVATpSHKThP1u/Hezw
	1Z0A==
X-Gm-Message-State: AA6/9Rl5X+vGQICOm5cwvqSN8DNWCuDdUOl/LsWZxGOhEJJK/TxNpXm1Pi/3JyME5KO5WGnVfiMTY+eQwgeyXg==
X-Received: by 10.28.9.141 with SMTP id 135mr3249296wmj.68.1477061727256; Fri,
	21 Oct 2016 07:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.131.200 with HTTP; Fri, 21 Oct 2016 07:55:26 -0700 (PDT)
From: nitish jha <nitishjha16@gmail.com>
Date: Fri, 21 Oct 2016 16:55:26 +0200
Message-ID: <CABh+fobJ2oYvPgEk=jAXZo2PRrHiH9+G136PMCG-MS=iLDXS0w@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, poky@yoctoproject.org
Subject: Eclipse: Yocto Image build and Remote debugg
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
X-List-Received-Date: Fri, 21 Oct 2016 14:55:27 -0000
Content-Type: multipart/alternative; boundary=001a11444dc69084ae053f613b7e

--001a11444dc69084ae053f613b7e
Content-Type: text/plain; charset=UTF-8

Hello All,

I am facing some Issues in Remote debugging of yocto image

Steps I have done:

1) Installing eclipse with CDT plugins,ADT, RSE and TCF plugin
2) Making a project in eclipse using Bitbake Commander
3) Creating a custom image using HOB by adding some custom layers.
4) Running Image on QEMU
5) Creating an sdk and extracting sysroot
6) Configuring Image and Sysroot in Eclipse Yocto ADT settings.
7) Creating a TCF Connection and providing this connection to c++ remote
application

But launch fails by saying that this is not valid C++ project

I have following questions regarding this

1) I understand this is not a c++ project as it is created by Bitbake
commander but How I will be able to debug the code I have added in my image.
2) When I use new TCF instance in Debug Configuration its not detecting
automatically my QEMU which is running my image.

Can anybody help me in debugging Software I have installed in my image as
extra layer by any ways i.e. TCF debugging/Eclipse remote application
debugging.

Thanks in advance.


-- 
*Nitish Jha*

--001a11444dc69084ae053f613b7e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div><br></div><div>I am facing some Issues in R=
emote debugging of yocto image</div><div><br></div><div>Steps I have done:<=
/div><div><br></div><div>1) Installing eclipse with CDT plugins,ADT, RSE an=
d TCF plugin</div><div>2) Making a project in eclipse using Bitbake Command=
er</div><div>3) Creating a custom image using HOB by adding some custom lay=
ers.</div><div>4) Running Image on QEMU</div><div>5) Creating an sdk and ex=
tracting sysroot</div><div>6) Configuring Image and Sysroot in Eclipse Yoct=
o ADT settings.</div><div>7) Creating a TCF Connection and providing this c=
onnection to c++ remote application</div><div><br></div><div>But launch fai=
ls by saying that this is not valid C++ project</div><div><br></div><div>I =
have following questions regarding this</div><div><br></div><div>1) I under=
stand this is not a c++ project as it is created by Bitbake commander but H=
ow I will be able to debug the code I have added in my image.</div><div>2) =
When I use new TCF instance in Debug Configuration its not detecting automa=
tically my QEMU which is running my image.</div><div><br></div><div>Can any=
body help me in debugging Software I have installed in my image as extra la=
yer by any ways i.e. TCF debugging/Eclipse remote application debugging.</d=
iv><div><br></div><div>Thanks in advance.</div><div><br clear=3D"all"><div>=
<br></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div style=3D"font-family:arial;font-size:small"><div><b>Nitish Jha</b></d=
iv><div><br></div></div></div></div></div></div></div>
</div></div>

--001a11444dc69084ae053f613b7e--
