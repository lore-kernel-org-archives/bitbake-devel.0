Return-Path: <katutxakurra@gmail.com>
Received: from mail-yk0-f178.google.com (mail-yk0-f178.google.com
	[209.85.160.178])
	by mail.openembedded.org (Postfix) with ESMTP id ACBA472A85
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 14:43:10 +0000 (UTC)
Received: by ykeo186 with SMTP id o186so22087581yke.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=yCqv4qafgMTA3jr17T7VnkeOofK93t+prW7dxeVbAtA=;
	b=mJTy2NL71A6ZrOc4tXpaNpgzdR9RKQvXjtTnVCe2nK1MfmoobMyNtZyLV8T0ONbuoA
	vSC3uOELkkb81+fXY72sMv8e2weTtdgL93YLBoz20g9+Zaw57EahOrJHh3i89NRBX6qh
	uk8uCkZol6zRl934uaA6lFmHxw2zRowsM7YVJ4KltsMOBhATDocKqWpe/NbTLxHgtFGJ
	nDyHnvyLWgymiNADPbz74HwLNAlhQ+ZbfRqRMEbgIu9gjwC5MWQEt/GIa4CeJJCaY21/
	T0/J9u7M3nBO9Pv07gGkHk1Fcm7UeMTl9bSy0OLLdM7AgakSLhORMgy+JymzinYW/NMA
	aG+w==
MIME-Version: 1.0
X-Received: by 10.236.229.202 with SMTP id h70mr23784277yhq.45.1430232192064; 
	Tue, 28 Apr 2015 07:43:12 -0700 (PDT)
Received: by 10.129.78.208 with HTTP; Tue, 28 Apr 2015 07:43:12 -0700 (PDT)
Date: Tue, 28 Apr 2015 15:43:12 +0100
Message-ID: <CAM1ZcoWg_S6ens4kumJSJzX3fdJio19tw3SUXEPFYpDoR6rAjw@mail.gmail.com>
From: Katu Txakur <katutxakurra@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: List available kernel modules
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
X-List-Received-Date: Tue, 28 Apr 2015 14:43:11 -0000
Content-Type: multipart/alternative; boundary=089e0160c646c124ab0514c9e1f0

--089e0160c646c124ab0514c9e1f0
Content-Type: text/plain; charset=UTF-8

Hi,

I'm using Yocto to bitbake a kernel and I would like to list the available
kernel modules to decide which ones should I include. Could somebody please
point me to the documentation explaining this. I've failed to find it.

I know how to use the menuconfig, but I would like to see the list.
Something similar to checking the list of packages that a recipe builds
with
bitbake -e myrecipe | grep ^PACKAGES=

Thank you for your time.

--089e0160c646c124ab0514c9e1f0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m using Yocto to bitbake a ke=
rnel and I would like to list the available kernel modules to decide which =
ones should I include. Could somebody please point me to the documentation =
explaining this. I&#39;ve failed to find it.</div><div><br></div><div>I kno=
w how to use the menuconfig, but I would like to see the list. Something si=
milar to checking the list of packages that a recipe builds with=C2=A0</div=
><div>bitbake -e myrecipe | grep ^PACKAGES=3D</div><div><br></div><div>Than=
k you for your time.</div></div>

--089e0160c646c124ab0514c9e1f0--
