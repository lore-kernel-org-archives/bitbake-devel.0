Return-Path: <jatedev@gmail.com>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
	[209.85.216.178])
	by mail.openembedded.org (Postfix) with ESMTP id 9D17E73F49;
	Thu,  7 May 2015 23:50:41 +0000 (UTC)
Received: by qcyk17 with SMTP id k17so29757042qcy.1;
	Thu, 07 May 2015 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=F7jOJXWxy60BIGW6Rnc+HRULQZ3058zO+TFRRJVFWXg=;
	b=eSnXFgijbcDXfG2+d3FNgcRa084T7g1LLdwR8ZsrMTZHkDAeGQpuzfe8mmHnzkq/KY
	HJx7YELlU4d7wJImUzXlf2SDh9MhSeziZunQAAAl6ZWIxWGVbPSz2vCrG1Bp9CcG1vpR
	1IREuVvxxoaIgw11cuUegbyKUBMhpdO5yQ346BjRgmVxpWL36E/259r4Kcu/Ql8TlAUm
	nnykJi5DNTLirRuIxGm+4ZFUedzFo5lQKAPCU1yrFCV/P6/K5fuQmFRKAkxeOGBJMvK8
	C1Sbtw99DnfVIDAoKtMjWYfjV2ZbjcQNHfWNVU0Ma2zO0qRK1QBPC2FAwRE0Gq8kt55m
	OSfQ==
MIME-Version: 1.0
X-Received: by 10.140.108.74 with SMTP id i68mr1509956qgf.73.1431042643128;
	Thu, 07 May 2015 16:50:43 -0700 (PDT)
Received: by 10.140.102.74 with HTTP; Thu, 7 May 2015 16:50:43 -0700 (PDT)
Date: Thu, 7 May 2015 19:50:43 -0400
Message-ID: <CAPphmgYj=ARopeoCC+UdcLXcMTfZGO+CH=_YN4Zb7mvdvP==Yw@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org
Subject: [0/2] Yocto Bug #6149, #5044
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
X-List-Received-Date: Thu, 07 May 2015 23:50:43 -0000
Content-Type: multipart/alternative; boundary=001a11395d2066f49405158694e8

--001a11395d2066f49405158694e8
Content-Type: text/plain; charset=UTF-8

I came across these bugs in poky 1.6.3 (daisy) with multiple package
providers. I fixed bug 6149 with just bitbake patch.

I came across another bug with this when I tried the bitbake fix on master.
With the test case

IMAGE_INSTALL_append = " sshd"
PREFERRED_PROVIDER_sshd="dropbear"

meta/lib/oe/package_manager.py reported a package not found in the base
feeds. The file image.bbclass starts copies IMAGE_INSTALL to
PACKAGE_INSTALL and performs fix ups for multilib, etc. I added another
function (rootfs_process_preferred_providers) to replace sshd in
PACKAGE_INSTALL with dropbear. This eliminated the error.

The mega-manual is vague when it describes what can be specified in
PREFERRED_PROVIDER: an item. And the code partially supports run-time
packages as a valid item on the left. My implementation assumes a package
name on the right.

Yocto bug 5044 suggests traversing from the package name to the virtual/*
provider, but I have not thought through how this might work.

IMAGE_INSTALL_append = " libasound-module-bluez"
PREFERRED_PROVIDER_libasound-module-bluez="bluez4"

I got this working on poky 1.6.3, but some changes to the bluez recipes on
master seemed to mitigate the original problem.


- Jate S.

--001a11395d2066f49405158694e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I came across these bugs in poky 1.6.3 (daisy) w=
ith multiple package providers. I fixed bug 6149 with just bitbake patch.<b=
r><br>I came across another bug with this when I tried the bitbake fix on m=
aster. With the test case <br><br>IMAGE_INSTALL_append =3D &quot; sshd&quot=
;<br>PREFERRED_PROVIDER_sshd=3D&quot;dropbear&quot;<br><br></div>meta/lib/o=
e/package_manager.py reported a package not found in the base feeds. The fi=
le image.bbclass starts copies IMAGE_INSTALL to PACKAGE_INSTALL and perform=
s fix ups for multilib, etc. I added another function (rootfs_process_prefe=
rred_providers) to replace sshd in PACKAGE_INSTALL with dropbear. This elim=
inated the error.<br><br></div><div>The mega-manual is vague when it descri=
bes what can be specified in PREFERRED_PROVIDER: an item. And the code part=
ially supports run-time packages as a valid item on the left. My implementa=
tion assumes a package name on the right.<br><br>Yocto bug 5044 suggests tr=
aversing from the package name to the=20
virtual/* provider, but I have not thought through how this might work.<br>=
<br>IMAGE_INSTALL_append =3D &quot; libasound-module-bluez&quot;<br>PREFERR=
ED_PROVIDER_libasound-module-bluez=3D&quot;bluez4&quot;<br><br></div><div>I=
 got this working on poky 1.6.3, but some changes to the bluez recipes on m=
aster seemed to mitigate the original problem.<br><br><br></div><div>- Jate=
 S.<br></div></div>

--001a11395d2066f49405158694e8--
