Return-Path: <dushyantkumars94@gmail.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 9D72677E87
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jan 2018 08:41:10 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id f3so28181740wmc.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jan 2018 00:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=J6k5LiU++Qf2XZozPxwGyvwX5VWkiRcSUYppbP2FLNs=;
	b=YxJhs69+X8Tx45+4uCufkJTgjfOELHNm1oy0r9H3XlGPFSTwSBMFkuPZZUFY/PUfNK
	/GZ4igfxBMdER3L9qWv4+OVf3HwXvj4NMysxkjCjAjQI2Vt/Rs0Sct0jNsIx7MOkYtnh
	+oUo64FY/FTOH/NEMnC2nL0V+sz4Zr7BV6/yveEbGx9cdLiCWlnq3q4+19ILcozJwh2N
	CD/JbfP2wcSzltJaWPajRgQDzlfTh3JWS84Wrp1SX0mrfRUuepR2ZIjIbfIqxzqKIQW/
	HleHXuApYLH8BvuAUNkJbXoK1Vg9RVFYoe/cLoBYi+nrKkVByhWUphwiRoXaQ2oPZCX1
	PZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=J6k5LiU++Qf2XZozPxwGyvwX5VWkiRcSUYppbP2FLNs=;
	b=kr/f4XxUCyrxugk7okL8L/6JuNzXAF0QseBiPOUKnVxY4nvfYAmwwJRPHpUVT/ZKEU
	IO006VuPFbd5lDpOT9T2WXYr4SxVDEz3/hvHDx2sEVMsx5Gv51Z+Cwfz+sw2q4O7l6Co
	cjyJNpOmMX7E+o/LclgoJcljUafPlvs99cUgRPfA807/0C6Ds74cSnbjWtMeHgFJr5lY
	EiQ7q4lSTqv7WJAe1Lx5EtP7CLnpq7ouol03q2t9pM9I4UiOVIvjHtMyirC7dmV/vJRO
	BOK0D4UDQ8iIvacyOo/avGvsUAsnQwYx7fcFlmAoIWswntrclINJa33BeJsVmknKqH03
	H7Qg==
X-Gm-Message-State: AKwxytd9DJ0Uikx8cVTZsMBeXHBeGJSob16VhG0vNPlNf5cl5KNF5mLg
	xaleAmzus9RqPbgmAIBZRmdvaw07BqEmljxZkpobkg==
X-Google-Smtp-Source: AH8x2278xmG3zOszOngs8tUlCTioGJKAIT12skZ7M8rwLIr+5ZNo+dxw1+yFDPKZU1F/oGA2g+W4YlXScKwr/PXITYA=
X-Received: by 10.80.203.2 with SMTP id g2mr40844340edi.4.1517128870568; Sun,
	28 Jan 2018 00:41:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.194.10 with HTTP; Sun, 28 Jan 2018 00:41:10 -0800 (PST)
From: DUSHYANT KUMAR Singh <dushyantkumars94@gmail.com>
Date: Sun, 28 Jan 2018 14:11:10 +0530
Message-ID: <CAFrFSW7+XYeZG9DzB1JyVgsg0gEYbFU7HQ+j0L44=jTnG2m0gA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sun, 28 Jan 2018 13:49:37 +0000
Subject: Regarding the bitbake tool
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
X-List-Received-Date: Sun, 28 Jan 2018 08:41:10 -0000
Content-Type: multipart/alternative; boundary="f40304394f7868a7ec0563d217d0"

--f40304394f7868a7ec0563d217d0
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am trying to build the yocto project for ubuntu 16.04. I am following the
Yocto Project Quick Start Guide. The steps I followed and the output I got
are :

$ sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip
python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm



$ git clone git://git.yoctoproject.org/poky


$ cd ~/poky
$ git checkout -b rocko origin/rocko


$ source oe-init-build-env     ---   as a root user and I directly
moved to build
directory



$ bitbake core-image-sato      ----   as a root user but I got the error as

ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker
(see sanity.conf).Following is the list of potential problems / advisories:

    Do not use Bitbake as root.


Then I again tried the whole procedure with bitbake command as normal user but I

got that bitbake: command not found



Please give me some hints regarding this so that I can solve this issue.

Thank You

With Regards

Dushyant Kumar Singh

--f40304394f7868a7ec0563d217d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,<br><br></div>I am trying to build the yocto p=
roject for ubuntu 16.04. I am following the Yocto Project Quick Start Guide=
. The steps I followed and the output I got are :<br><br><pre class=3D"gmai=
l-literallayout">$ sudo apt-get install gawk wget git-core diffstat unzip t=
exinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-=
pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm<br><br><br><br>$=
 git clone git://<a href=3D"http://git.yoctoproject.org/poky">git.yoctoproj=
ect.org/poky</a><br><br><br>$ cd ~/poky
$ git checkout -b rocko origin/rocko<br><br><br>$ source oe-init-build-env =
    ---   as a root user and I directly moved to build <br>directory<br><br=
><br><br>$ bitbake core-image-sato      ----   as a root user but I got the=
 error as <br><br>ERROR:  OE-core&#39;s config sanity checker detected a po=
tential misconfiguration.<br>    Either fix the cause of this error or at y=
our own risk disable the checker <br>(see sanity.conf).Following is the lis=
t of potential problems / advisories:<br><br>    Do not use Bitbake as root=
.<br><br><br></pre><pre class=3D"gmail-literallayout">Then I again tried th=
e whole procedure with bitbake command as normal user but I<br></pre><pre c=
lass=3D"gmail-literallayout">got that bitbake: command not found<br><br><br=
><br></pre><pre class=3D"gmail-literallayout">Please give me some hints reg=
arding this so that I can solve this issue.<br><br></pre><pre class=3D"gmai=
l-literallayout">Thank You<br><br></pre><pre class=3D"gmail-literallayout">=
With Regards<br></pre><pre class=3D"gmail-literallayout">Dushyant Kumar Sin=
gh<br></pre></div>

--f40304394f7868a7ec0563d217d0--
