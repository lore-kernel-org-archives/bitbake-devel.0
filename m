Return-Path: <timothy.godfrey@gmail.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 9FF30754DC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 03:56:30 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id f6-v6so10941544wmc.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 May 2018 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=rCaSd6Ds5gFf/cFBY8GeQFj8XCcmkUv96E0dcZ8vGeA=;
	b=iQFx9GBrjirb5QtjgfBL2SHNP92onVUZ/cfeVIb0k9+PKCn4FaPiOAF+pS+6dmPfpP
	uJHtctgEDxe+9esIAbWdzv5X+r2ryzQUToYiEIscUkxuHJuvNbkB0rHBifIZOu9hdcI7
	YQX6cMDxevNGOtPqO8A6HvBWTI+2VjQQZNtWI5WaUuLyHCDSnR3d7NOVsm+eMCwCisTI
	p1nf00pDzmuXhkdSo17/AFW3hwkROtM7bxQMR/HImn5jSmGFKNe4SaCfkrIhZ+o7peFk
	25TfOERJK9G/tyiYuoSQrNqy8LOnDw798Wb9LkbnmL8s/GQv5gCaoScIKUaXILDPjcCu
	gwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=rCaSd6Ds5gFf/cFBY8GeQFj8XCcmkUv96E0dcZ8vGeA=;
	b=X81r6xJwWpuaW1NoNU03iC7sEtC/9/Aan2hrzuskqM9zmMPn13/pBY/M5/9Nr8DbnK
	zw8ZgZglbQRhH2Cfz7at+sOlQABgCSiPsOoJPcemS59ezDzPUUH01h3K6yvoPRjWSZ62
	43Oiyxvnfb21DW+H73NdkkHKMMDkfMhRpMTZR3dxmGpkbjfGkolwBad56VKeuXymSxsB
	cCNKG+a7JQSnZDqegQtJ4W6OkHWrYlEOfuSR7dnMx8/Lj3PiSnzHCEInI2M8aQxh9CPB
	gvDbZRD1u5lojiHbUAemQ6pOmGZIZ/4eQhcFIf4xVfEuwdulSXDdKfHTzTOKX2iRrshF
	/mmQ==
X-Gm-Message-State: ALKqPweEgosoy4Qv9uGIch2RZLcbrT55qaT4ehpflucSeG9wWx0hpPct
	zJZEoanwEvmvJXnvtIVBQXGIzhENmC9dz+ioRk8S
X-Google-Smtp-Source: AB8JxZrKsItEhKymuvT9WMBOFzbE+TEKDQartidVoepW40MRBWcFfpj9j9WuyKjuNIr4ToC4hkb27oHfA0MnrVLrg2k=
X-Received: by 2002:a1c:36cc:: with SMTP id
	y73-v6mr4059449wmh.28.1526270190360; 
	Sun, 13 May 2018 20:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.65.6 with HTTP; Sun, 13 May 2018 20:56:29 -0700 (PDT)
From: Tim Godfrey <timothy.godfrey@gmail.com>
Date: Mon, 14 May 2018 13:56:29 +1000
Message-ID: <CAHb6uwd5ugu+pARsTcMVtyjf_UrCthqnG0Pbt0Obc4evSfbWQw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake task not returning
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
X-List-Received-Date: Mon, 14 May 2018 03:56:30 -0000
Content-Type: multipart/alternative; boundary="000000000000871e22056c2278d4"

--000000000000871e22056c2278d4
Content-Type: text/plain; charset="UTF-8"

Hello!

A recipe I am working with hangs on the do_unpack task. Looking at the
logs, the sub-task appears to complete successfully, but the calling task
doesn't, and the overall bitbake build process doesn't either.

This is the complete log for the do_unpack task:

DEBUG: Executing python function do_unpack
DEBUG: Executing python function base_do_unpack
NOTE: Unpacking
/home/tim/tisdk/downloads/ti_cgt_c6000_8.2.2_linux_installer_x86.bin to
/home/tim/tisdk/build/arago-tmp-external-linaro-toolchain/work/x86_64-nativesdk-arago-linux/nativesdk-ti-cgt6x/1_8.2.2-r0/
DEBUG: Python function base_do_unpack finished
DEBUG: Executing python function ti_bin_do_unpack
----------------------------------------------------------------------------
Welcome to the C6000 Code Generation Tools Setup Wizard.

----------------------------------------------------------------------------
Select Installation Directory

Please specify the directory where C6000 Code Generation Tools will be
installed. The installation requires 264592 KB.

Destination Directory
[/home/tim/tisdk/build/arago-tmp-external-linaro-toolchain/work/x86_64-nativesdk-arago-linux/nativesdk-ti-cgt6x/1_8.2.2-r0/ti-cgt6x-8.2.2/ti-cgt-c6000_8.2.2]:

----------------------------------------------------------------------------
Setup is now ready to begin installing C6000 Code Generation Tools on your
computer.

Do you want to continue? [Y/n]:
----------------------------------------------------------------------------
Please wait while Setup installs C6000 Code Generation Tools on your
computer.

 Installing
 0% ______________ 50% ______________ 100%
 #########################################

----------------------------------------------------------------------------
Setup has finished installing C6000 Code Generation Tools on your computer.

The cooker log includes this line:

NOTE: recipe nativesdk-ti-cgt6x-1_8.2.2-r0: task do_unpack: Started

but there is no corresponding 'Succeeded' line in the log. I'm guessing it
has something to do with the ti_bin_do_unpack task not returning to the
calling do_unpack task.

Is this a known problem? Is there a known solution to it? On a related
point, if I would like to call the python tasks directly in order to
troubleshoot the problem, is there a standard/easy way to do that?

All input warmly received, thanks!
Tim

--000000000000871e22056c2278d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hello!<br><br></div>A r=
ecipe I am working with hangs on the do_unpack task. Looking at the logs, t=
he sub-task appears to complete successfully, but the calling task doesn&#3=
9;t, and the overall bitbake build process  doesn&#39;t either. <br><br></d=
iv>This is the complete log for the do_unpack task:<br><br>DEBUG: Executing=
 python function do_unpack<br>DEBUG: Executing python function base_do_unpa=
ck<br>NOTE: Unpacking /home/tim/tisdk/downloads/ti_cgt_c6000_8.2.2_linux_in=
staller_x86.bin to /home/tim/tisdk/build/arago-tmp-external-linaro-toolchai=
n/work/x86_64-nativesdk-arago-linux/nativesdk-ti-cgt6x/1_8.2.2-r0/<br>DEBUG=
: Python function base_do_unpack finished<br>DEBUG: Executing python functi=
on ti_bin_do_unpack<br>----------------------------------------------------=
------------------------<br>Welcome to the C6000 Code Generation Tools Setu=
p Wizard.<br><br>----------------------------------------------------------=
------------------<br>Select Installation Directory<br><br>Please specify t=
he directory where C6000 Code Generation Tools will be <br>installed. The i=
nstallation requires 264592 KB.<br><br>Destination Directory [/home/tim/tis=
dk/build/arago-tmp-external-linaro-toolchain/work/x86_64-nativesdk-arago-li=
nux/nativesdk-ti-cgt6x/1_8.2.2-r0/ti-cgt6x-8.2.2/ti-cgt-c6000_8.2.2]: <br>-=
---------------------------------------------------------------------------=
<br>Setup is now ready to begin installing C6000 Code Generation Tools on y=
our <br>computer.<br><br>Do you want to continue? [Y/n]: <br>--------------=
--------------------------------------------------------------<br>Please wa=
it while Setup installs C6000 Code Generation Tools on your computer.<br><b=
r>=C2=A0Installing<br>=C2=A00% ______________ 50% ______________ 100%<br>=
=C2=A0#########################################<br><br>--------------------=
--------------------------------------------------------<br>Setup has finis=
hed installing C6000 Code Generation Tools on your computer.<br><br></div>T=
he cooker log includes this line:<br><br>NOTE: recipe nativesdk-ti-cgt6x-1_=
8.2.2-r0: task do_unpack: Started<br><br></div>but there is no correspondin=
g &#39;Succeeded&#39; line in the log. I&#39;m guessing it has something to=
 do with the ti_bin_do_unpack task not returning to the calling do_unpack t=
ask. <br><br></div>Is this a known problem? Is there a known solution to it=
? On a related point, if I would like to call the python tasks directly in =
order to troubleshoot the problem, is there a standard/easy way to do that?=
<br><br></div>All input warmly received, thanks!<br></div>Tim<br></div>

--000000000000871e22056c2278d4--
