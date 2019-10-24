Return-Path: <ravihm22@gmail.com>
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
	[209.85.166.44])
	by mail.openembedded.org (Postfix) with ESMTP id 988507F9AA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Oct 2019 13:07:50 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id c6so29315399ioo.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Oct 2019 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=IpPfxNyoLjB29NUyZAiI/g9J39vCC1kT3feCCqgOaws=;
	b=KTrxurj9WuRL/BxZKX2ATiBOGD9q+28ReM4eXIoKZag+bEmTLaCJWXP5GqnKA4AAjB
	yB4onaBnyzObdy6Rhj86H6QPqqoONjAlGnenxILwfd4fWeG3rPBFtorT/GX8nVI9Vbvq
	AevOdhmcZZziBd7jLOR8QQmVs/O3hsFuOSx/a/2ti68fzMhQaygTt0r1ZahS/hnfpV6k
	9B1An6H5gitvc7+cUAwb998I2U6GJMg3/t2GyavftzAQ3jqRW7OOYCm1qn8+qZaQJTdH
	Kr6WmDxkLwBehhumtE1fRQvvRzsRohP1IzNtm84pK75ugVVxK4tnxv+jRP1GFbOlvXq1
	8srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=IpPfxNyoLjB29NUyZAiI/g9J39vCC1kT3feCCqgOaws=;
	b=o05ulXlj6+xhadeJu3Urknl2LxJIM8kCitRCpvNhAVe0P7pY/p/PmV/CdP7Tfo6Q2D
	JDZdt8Pe1D4/kT+1Ks0MyrnseIlz5ycQv38nVUJ2zgzQqvOc+9b8tDlt6VRRcL/GIU3H
	hOq7HGZr1hMDw7WFDTgn24cIwuCEpQOisfPSCE3QBRZMOmul1FCIaRtPFDKDQOqTYMbY
	xrKo461dkAENezhSHjkw/12rXW/knWnwQgjk2NIL9c6ozgBOW6we++bznYrcRU1hyXxc
	9blQZTFsPJpOsQyliWw37B7uWanvZGZZ4FH7AEdkUO+gmuwE/vRktKs4U4KbjvG2pKLR
	BkNQ==
X-Gm-Message-State: APjAAAVUXK+mB4EeZ++Yf3jftEOdJ5087GLWORD9M+uzMzcnK0jeM2Pg
	sEY0DgNgQTA6PTPALDm/pM8asY7z41pKtTVUfHHkJ1sY
X-Google-Smtp-Source: APXvYqyWbP2NulMilkKdCDUT2HNaTm7GGXPD6psjriJRsCUfcNN8+QChXNUR+Zn//Fn85DoZnHNIqwf8SRB7NZ34ETg=
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr9364456ioq.236.1571922471203; 
	Thu, 24 Oct 2019 06:07:51 -0700 (PDT)
MIME-Version: 1.0
From: HM Ravi <ravihm22@gmail.com>
Date: Thu, 24 Oct 2019 18:37:39 +0530
Message-ID: <CAMR-me_9_6-gu4GBpywfpi=-rZbqxbSoEguEN0xT5+D2ebnf_g@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake -c populate_sdk atmel-qt5-demo-image : build error
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
X-List-Received-Date: Thu, 24 Oct 2019 13:07:50 -0000
Content-Type: multipart/alternative; boundary="00000000000082ba130595a7b894"

--00000000000082ba130595a7b894
Content-Type: text/plain; charset="UTF-8"

Hi,

I am working on embedded project and the device used is SAMA5d27(Microchip
based). In this I am facing some problem while building the yocto project
2.6.4 for qt5 demo. can you please help me to come out of those error
problem and also thanks in advance. The following will be the error.
 I have used the following link to build the Yocto project.

http://www.at91.com/linux4sam/bin/view/Linux4SAM/PokyBuild#How_to_build_Poky_for_AT91

  The following is build error ERROR: qtbase-5.11.3+gitAUTOINC+08de243eaa-r0
do_patch: Function failed: patch_do_patch

  can you please help me out to solve those problem and thanks in advance.

ravi@ubuntu:~/microchip/yocto/poky/build-microchip$ bitbake -c populate_sdk
atmel-qt5-demo-image
 Loading cache: 100% |#############################
############################################################
######################################| Time: 0:00:03
 Loaded 3260 entries from dependency cache.
 Parsing recipes: 100% |#############################
############################################################
####################################| Time: 0:00:03
 Parsing of 2283 .bb files complete (2282 cached, 1 parsed). 3261 targets,
327 skipped, 0 masked, 0 errors.
 NOTE: Resolving any missing task queue dependencies
 Build Configuration:
 BB_VERSION           = "1.40.0"
 BUILD_SYS            = "x86_64-linux"
 NATIVELSBSTRING      = "universal"
 TARGET_SYS           = "arm-poky-linux-gnueabi"
 MACHINE              = "sama5d27-som1-ek-sd"
 DISTRO               = "poky-atmel"
 DISTRO_VERSION       = "2.6.4"
 TUNE_FEATURES        = "arm armv7a vfp thumb neon callconvention-hard
cortexa5"
 TARGET_FPU           = "hard"
 meta
 meta-poky
 meta-yocto-bsp       = "thud:51f6145f8f99a02df1dad937684f014b0172e72a"
 meta-atmel           = "thud:5d8d83e656246c8ca534c6288bbb7fbb7afda683"
 meta-oe
 meta-networking
 meta-python
 meta-multimedia      = "thud:2d088d252624b19df384aecc434d23afb636178f"
 meta-qt5             = "upstream/thud:1520d5b2b2beec5e1c3209d3178219
e93ef08bca"

 Initialising tasks: 100% |#############################
############################################################
#################################| Time: 0:00:07
> Sstate summary: Wanted 342 Found 0 Missed 342 Current 1149 (0% match, 77%
complete)
> NOTE: Executing SetScene Tasks
> NOTE: Executing RunQueue Tasks
> ERROR: qtbase-5.11.3+gitAUTOINC+08de243eaa-r0 do_patch: Command Error:
'quilt --quiltrc /home/ravi/microchip/yocto/poky/build-microchip/tmp/work/
cortexa5t2hf-neon-poky-linux-gnueabi/qtbase/5.11.3+gitAUTOINC+08de243eaa-r0/
recipe-sysroot-native/etc/quiltrc push' exited with 0  Output:
> Applying patch 0004-Provide-access-to-linuxfb-dri-fd-through-
platform.patch
> patching file src/platformsupport/fbconvenience/qfbscreen_p.h
> patching file src/plugins/platforms/linuxfb/qlinuxfbdrmscreen.cpp
> patching file src/plugins/platforms/linuxfb/qlinuxfbdrmscreen.h
> patching file src/plugins/platforms/linuxfb/qlinuxfbintegration.cpp
> Hunk #1 FAILED at 173.
> 1 out of 1 hunk FAILED -- rejects in file src/plugins/platforms/linuxfb/
qlinuxfbintegration.cpp
> patching file src/plugins/platforms/linuxfb/qlinuxfbscreen.h
> Patch 0004-Provide-access-to-linuxfb-dri-fd-through-platform.patch does
not apply (enforce with -f)
> ERROR: qtbase-5.11.3+gitAUTOINC+08de243eaa-r0 do_patch: Function failed:
patch_do_patch
> ERROR: Logfile of failure stored in: /home/ravi/microchip/yocto/
poky/build-microchip/tmp/work/cortexa5t2hf-neon-poky-linux-
gnueabi/qtbase/5.11.3+gitAUTOINC+08de243eaa-r0/temp/log.do_patch.21776
> ERROR: Task (/home/ravi/microchip/yocto/meta-qt5/recipes-qt/qt5/
qtbase_git.bb:do_patch) failed with exit code '1'
> NOTE: Tasks Summary: Attempted 1150 tasks of which 1149 didn't need to be
rerun and 1 failed.
> Summary: 1 task failed:
>   /home/ravi/microchip/yocto/meta-qt5/recipes-qt/qt5/qtbase_git.bb:
do_patch
> Summary: There were 2 ERROR messages shown, returning a non-zero exit
code.
>
> ------------------------------------------------------------
----------------------------

--00000000000082ba130595a7b894
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><s=
pan style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-in=
dent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-=
size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-dec=
oration:none;word-spacing:0px;display:inline;white-space:normal;float:none;=
background-color:rgb(255,255,255)">Hi,</span></div><div><span style=3D"text=
-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-s=
pacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font=
-style:normal;font-variant:normal;font-weight:400;text-decoration:none;word=
-spacing:0px;display:inline;white-space:normal;float:none;background-color:=
rgb(255,255,255)"><br></span></div><div dir=3D"ltr"><span style=3D"text-ali=
gn:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spaci=
ng:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-sty=
le:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spa=
cing:0px;display:inline;white-space:normal;float:none;background-color:rgb(=
255,255,255)">I am working on embedded project and the device used is SAMA5=
d27(Microchip based). In this I am facing some problem while building the y=
octo project 2.6.4 for qt5 demo. can you please help me to come out of thos=
e error problem and also thanks in advance. The following will be the error=
.</span><br style=3D"text-align:left;color:rgb(80,0,80);text-transform:none=
;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-ser=
if;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;=
text-decoration:none;word-spacing:0px;white-space:normal"><span style=3D"te=
xt-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter=
-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;fo=
nt-style:normal;font-variant:normal;font-weight:400;text-decoration:none;wo=
rd-spacing:0px;display:inline;white-space:normal;float:none;background-colo=
r:rgb(255,255,255)">=C2=A0I have used the following link to build the Yocto=
 project.</span></div><div dir=3D"ltr"><span style=3D"text-align:left;color=
:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fon=
t-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fon=
t-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;disp=
lay:inline;white-space:normal;float:none;background-color:rgb(255,255,255)"=
><br></span></div><div dir=3D"ltr"><span style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-variant:normal;word-=
spacing:0px;display:inline;white-space:normal;float:none;background-color:r=
gb(255,255,255)"><a style=3D"text-align:left;color:rgb(17,85,204);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:underline;word-spacing:0px;white-space:normal" hr=
ef=3D"http://www.at91.com/linux4sam/bin/view/Linux4SAM/PokyBuild#How_to_bui=
ld_Poky_for_AT91" target=3D"_blank" rel=3D"noreferrer noreferrer">http://ww=
w.at91.com/linux4sam/bin/view/Linux4SAM/PokyBuild#How_to_build_Poky_for_AT9=
1</a></span></div><div dir=3D"ltr"><span style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-variant:normal;word-=
spacing:0px;display:inline;white-space:normal;float:none;background-color:r=
gb(255,255,255)">=C2=A0 =C2=A0</span></div><div><span style=3D"text-align:l=
eft;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:n=
ormal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-variant=
:normal;word-spacing:0px;display:inline;white-space:normal;float:none;backg=
round-color:rgb(255,255,255)">=C2=A0 The following is build error <span sty=
le=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0p=
x;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13=
.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration=
:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgro=
und-color:rgb(255,255,255)">ERROR: qtbase-5.11.3+gitAUTOINC+</span><span st=
yle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0=
px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:1=
3.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoratio=
n:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgr=
ound-color:rgb(255,255,255)">08de243eaa-r0 do_patch: Function failed: patch=
_do_patch</span></span></div><div><span style=3D"text-align:left;color:rgb(=
80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fam=
ily:Arial,Helvetica,sans-serif;font-size:13.33px;font-variant:normal;word-s=
pacing:0px;display:inline;white-space:normal;float:none;background-color:rg=
b(255,255,255)"><span style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;display:inline;white-space:=
normal;float:none;background-color:rgb(255,255,255)"><br></span></span></di=
v><div><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:non=
e;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-se=
rif;font-size:13.33px;font-variant:normal;word-spacing:0px;display:inline;w=
hite-space:normal;float:none;background-color:rgb(255,255,255)"><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">=C2=A0 can you please help me out to solve those =
problem and thanks in advance.=C2=A0</span></span></div><div><span style=3D=
"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;let=
ter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px=
;font-variant:normal;word-spacing:0px;display:inline;white-space:normal;flo=
at:none;background-color:rgb(255,255,255)"><b></b><i></i><u></u><sub></sub>=
<sup></sup><strike></strike><br></span></div><div><span style=3D"text-align=
:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing=
:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-varia=
nt:normal;word-spacing:0px;display:inline;white-space:normal;float:none;bac=
kground-color:rgb(255,255,255)"><span style=3D"text-align:left;color:rgb(80=
,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-famil=
y:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varia=
nt:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:inl=
ine;white-space:normal;float:none;background-color:rgb(255,255,255)"> ravi@=
ubuntu:~/microchip/yocto/</span><span style=3D"text-align:left;color:rgb(80=
,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-famil=
y:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varia=
nt:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:inl=
ine;white-space:normal;float:none;background-color:rgb(255,255,255)">poky/b=
uild-microchip$ bitbake -c populate_sdk atmel-qt5-demo-image</span><br styl=
e=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px=
;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.=
33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:=
none;word-spacing:0px;white-space:normal"><span style=3D"text-align:left;co=
lor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;=
font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;=
font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;d=
isplay:inline;white-space:normal;float:none;background-color:rgb(255,255,25=
5)">=C2=A0Loading cache: 100% |#############################</span><span st=
yle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0=
px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:1=
3.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoratio=
n:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgr=
ound-color:rgb(255,255,255)">##############################</span><span sty=
le=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0p=
x;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13=
.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration=
:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgro=
und-color:rgb(255,255,255)">##############################</span><span styl=
e=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px=
;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.=
33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:=
none;word-spacing:0px;display:inline;white-space:normal;float:none;backgrou=
nd-color:rgb(255,255,255)">##############################</span><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">########| Time: 0:00:03</span><br style=3D"text-a=
lign:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spa=
cing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-s=
tyle:normal;font-variant:normal;font-weight:400;text-decoration:none;word-s=
pacing:0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,=
0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-family=
:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varian=
t:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:inli=
ne;white-space:normal;float:none;background-color:rgb(255,255,255)">=C2=A0L=
oaded 3260 entries from dependency cache.</span><br style=3D"text-align:lef=
t;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:nor=
mal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:nor=
mal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0=
px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);te=
xt-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,H=
elvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal=
;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;white=
-space:normal;float:none;background-color:rgb(255,255,255)">=C2=A0Parsing r=
ecipes: 100% |#############################</span><span style=3D"text-align=
:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing=
:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style=
:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spaci=
ng:0px;display:inline;white-space:normal;float:none;background-color:rgb(25=
5,255,255)">##############################</span><span style=3D"text-align:=
left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:=
normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:=
normal;font-variant:normal;font-weight:400;text-decoration:none;word-spacin=
g:0px;display:inline;white-space:normal;float:none;background-color:rgb(255=
,255,255)">##############################</span><span style=3D"text-align:l=
eft;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:n=
ormal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:n=
ormal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing=
:0px;display:inline;white-space:normal;float:none;background-color:rgb(255,=
255,255)">##############################</span><span style=3D"text-align:le=
ft;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:no=
rmal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:no=
rmal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:=
0px;display:inline;white-space:normal;float:none;background-color:rgb(255,2=
55,255)">######| Time: 0:00:03</span><br style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-va=
riant:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-sp=
ace:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transfor=
m:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sa=
ns-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weigh=
t:400;text-decoration:none;word-spacing:0px;display:inline;white-space:norm=
al;float:none;background-color:rgb(255,255,255)">=C2=A0Parsing of 2283 .bb =
files complete (2282 cached, 1 parsed). 3261 targets, 327 skipped, 0 masked=
, 0 errors.</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span s=
tyle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:=
0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:=
13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorati=
on:none;word-spacing:0px;display:inline;white-space:normal;float:none;backg=
round-color:rgb(255,255,255)">=C2=A0NOTE: Resolving any missing task queue =
dependencies</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span =
style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent=
:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size=
:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorat=
ion:none;word-spacing:0px;display:inline;white-space:normal;float:none;back=
ground-color:rgb(255,255,255)">=C2=A0Build Configuration:</span><br style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;white-space:normal"><span style=3D"text-align:left;col=
or:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;f=
ont-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;f=
ont-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;di=
splay:inline;white-space:normal;float:none;background-color:rgb(255,255,255=
)">=C2=A0BB_VERSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;1.40.=
0&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-transfor=
m:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sa=
ns-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weigh=
t:400;text-decoration:none;word-spacing:0px;white-space:normal"><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">=C2=A0BUILD_SYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D &quot;x86_64-linux&quot;</span><br style=3D"text-align:left;col=
or:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;f=
ont-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;f=
ont-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;wh=
ite-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tr=
ansform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvet=
ica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font=
-weight:400;text-decoration:none;word-spacing:0px;display:inline;white-spac=
e:normal;float:none;background-color:rgb(255,255,255)">=C2=A0NATIVELSBSTRIN=
G=C2=A0 =C2=A0 =C2=A0 =3D &quot;universal&quot;</span><br style=3D"text-ali=
gn:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spaci=
ng:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-sty=
le:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spa=
cing:0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,=
80);text-transform:none;text-indent:0px;letter-spacing:normal;font-family:A=
rial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:=
normal;font-weight:400;text-decoration:none;word-spacing:0px;display:inline=
;white-space:normal;float:none;background-color:rgb(255,255,255)">=C2=A0TAR=
GET_SYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;arm-poky-linux-gn=
ueabi&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span s=
tyle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:=
0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:=
13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorati=
on:none;word-spacing:0px;display:inline;white-space:normal;float:none;backg=
round-color:rgb(255,255,255)">=C2=A0MACHINE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;sama5d27-som1-ek-sd&quot;</span><br style=3D"te=
xt-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter=
-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;fo=
nt-style:normal;font-variant:normal;font-weight:400;text-decoration:none;wo=
rd-spacing:0px;white-space:normal"><span style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-va=
riant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:=
inline;white-space:normal;float:none;background-color:rgb(255,255,255)">=C2=
=A0DISTRO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;p=
oky-atmel&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-=
transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helv=
etica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;fo=
nt-weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><sp=
an style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-ind=
ent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-s=
ize:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-deco=
ration:none;word-spacing:0px;display:inline;white-space:normal;float:none;b=
ackground-color:rgb(255,255,255)">=C2=A0DISTRO_VERSION=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D &quot;2.6.4&quot;</span><br style=3D"text-align:left;color:rgb(80=
,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-famil=
y:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varia=
nt:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-space=
:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:n=
one;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-=
serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:4=
00;text-decoration:none;word-spacing:0px;display:inline;white-space:normal;=
float:none;background-color:rgb(255,255,255)">=C2=A0TUNE_FEATURES=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;arm armv7a vfp thumb neon callconvention-hard c=
ortexa5&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tr=
ansform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvet=
ica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font=
-weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span=
 style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-inden=
t:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-siz=
e:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decora=
tion:none;word-spacing:0px;display:inline;white-space:normal;float:none;bac=
kground-color:rgb(255,255,255)">=C2=A0TARGET_FPU=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=3D &quot;hard&quot;</span><br style=3D"text-align:left;color=
:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fon=
t-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fon=
t-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;whit=
e-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;display:inline;white-space:=
normal;float:none;background-color:rgb(255,255,255)">=C2=A0meta</span><br s=
tyle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:=
0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:=
13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorati=
on:none;word-spacing:0px;white-space:normal"><span style=3D"text-align:left=
;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norm=
al;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norm=
al;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0p=
x;display:inline;white-space:normal;float:none;background-color:rgb(255,255=
,255)">=C2=A0meta-poky</span><br style=3D"text-align:left;color:rgb(80,0,80=
);text-transform:none;text-indent:0px;letter-spacing:normal;font-family:Ari=
al,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:no=
rmal;font-weight:400;text-decoration:none;word-spacing:0px;white-space:norm=
al"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;t=
ext-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif=
;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;te=
xt-decoration:none;word-spacing:0px;display:inline;white-space:normal;float=
:none;background-color:rgb(255,255,255)">=C2=A0meta-yocto-bsp=C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D &quot;thud:</span><span style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-va=
riant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:=
inline;white-space:normal;float:none;background-color:rgb(255,255,255)">51f=
6145f8f99a02df1dad937684f01</span><span style=3D"text-align:left;color:rgb(=
80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fam=
ily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-var=
iant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:i=
nline;white-space:normal;float:none;background-color:rgb(255,255,255)">4b01=
72e72a&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span =
style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent=
:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size=
:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorat=
ion:none;word-spacing:0px;display:inline;white-space:normal;float:none;back=
ground-color:rgb(255,255,255)">=C2=A0meta-atmel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D &quot;thud:</span><span style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-va=
riant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:=
inline;white-space:normal;float:none;background-color:rgb(255,255,255)">5d8=
d83e656246c8ca534c6288bbb7f</span><span style=3D"text-align:left;color:rgb(=
80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fam=
ily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-var=
iant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:i=
nline;white-space:normal;float:none;background-color:rgb(255,255,255)">bb7a=
fda683&quot;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span =
style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent=
:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size=
:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorat=
ion:none;word-spacing:0px;display:inline;white-space:normal;float:none;back=
ground-color:rgb(255,255,255)">=C2=A0meta-oe</span><br style=3D"text-align:=
left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:=
normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:=
normal;font-variant:normal;font-weight:400;text-decoration:none;word-spacin=
g:0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80)=
;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:Aria=
l,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:nor=
mal;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;wh=
ite-space:normal;float:none;background-color:rgb(255,255,255)">=C2=A0meta-n=
etworking</span><br style=3D"text-align:left;color:rgb(80,0,80);text-transf=
orm:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,=
sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-wei=
ght:400;text-decoration:none;word-spacing:0px;white-space:normal"><span sty=
le=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0p=
x;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13=
.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration=
:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgro=
und-color:rgb(255,255,255)">=C2=A0meta-python</span><br style=3D"text-align=
:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing=
:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style=
:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spaci=
ng:0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80=
);text-transform:none;text-indent:0px;letter-spacing:normal;font-family:Ari=
al,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:no=
rmal;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;w=
hite-space:normal;float:none;background-color:rgb(255,255,255)">=C2=A0meta-=
multimedia=C2=A0 =C2=A0 =C2=A0 =3D &quot;thud:</span><span style=3D"text-al=
ign:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spac=
ing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-st=
yle:normal;font-variant:normal;font-weight:400;text-decoration:none;word-sp=
acing:0px;display:inline;white-space:normal;float:none;background-color:rgb=
(255,255,255)">2d088d252624b19df384aecc434d23</span><span style=3D"text-ali=
gn:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spaci=
ng:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-sty=
le:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spa=
cing:0px;display:inline;white-space:normal;float:none;background-color:rgb(=
255,255,255)">afb636178f&quot;</span><br style=3D"text-align:left;color:rgb=
(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fa=
mily:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-va=
riant:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-sp=
ace:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transfor=
m:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sa=
ns-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weigh=
t:400;text-decoration:none;word-spacing:0px;display:inline;white-space:norm=
al;float:none;background-color:rgb(255,255,255)">=C2=A0meta-qt5=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;upstream/thud:</span><span =
style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent=
:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size=
:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorat=
ion:none;word-spacing:0px;display:inline;white-space:normal;float:none;back=
ground-color:rgb(255,255,255)">1520d5b2b2beec5e1c3209d3178219</span><span s=
tyle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:=
0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:=
13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorati=
on:none;word-spacing:0px;display:inline;white-space:normal;float:none;backg=
round-color:rgb(255,255,255)">e93ef08bca&quot;</span><br style=3D"text-alig=
n:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacin=
g:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-styl=
e:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spac=
ing:0px;white-space:normal"><div><br></div><div><span style=3D"text-align:l=
eft;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:n=
ormal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:n=
ormal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing=
:0px;display:inline;white-space:normal;float:none;background-color:rgb(255,=
255,255)">=C2=A0Initialising tasks: 100% |#############################</sp=
an><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;te=
xt-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;=
font-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;tex=
t-decoration:none;word-spacing:0px;display:inline;white-space:normal;float:=
none;background-color:rgb(255,255,255)">##############################</spa=
n><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;tex=
t-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;f=
ont-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text=
-decoration:none;word-spacing:0px;display:inline;white-space:normal;float:n=
one;background-color:rgb(255,255,255)">##############################</span=
><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text=
-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;fo=
nt-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-=
decoration:none;word-spacing:0px;display:inline;white-space:normal;float:no=
ne;background-color:rgb(255,255,255)">##############################</span>=
<span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-=
indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;fon=
t-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-d=
ecoration:none;word-spacing:0px;display:inline;white-space:normal;float:non=
e;background-color:rgb(255,255,255)">###| Time: 0:00:07</span><br style=3D"=
text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;lett=
er-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;=
font-style:normal;font-variant:normal;font-weight:400;text-decoration:none;=
word-spacing:0px;white-space:normal"></div><span style=3D"text-align:left;c=
olor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal=
;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal=
;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;=
display:inline;white-space:normal;float:none;background-color:rgb(255,255,2=
55)">
&gt; Sstate summary: Wanted 342 Found 0 Missed 342 Current 1149 (0% match, =
77% complete)</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tr=
ansform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvet=
ica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font=
-weight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span=
 style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-inden=
t:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-siz=
e:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decora=
tion:none;word-spacing:0px;display:inline;white-space:normal;float:none;bac=
kground-color:rgb(255,255,255)">
&gt; NOTE: Executing SetScene Tasks</span><br style=3D"text-align:left;colo=
r:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fo=
nt-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fo=
nt-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;whi=
te-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;display:inline;white-space=
:normal;float:none;background-color:rgb(255,255,255)">
&gt; NOTE: Executing RunQueue Tasks</span><br style=3D"text-align:left;colo=
r:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fo=
nt-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fo=
nt-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;whi=
te-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;display:inline;white-space=
:normal;float:none;background-color:rgb(255,255,255)">
&gt; ERROR: qtbase-5.11.3+gitAUTOINC+</span><span style=3D"text-align:left;=
color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norma=
l;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norma=
l;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px=
;display:inline;white-space:normal;float:none;background-color:rgb(255,255,=
255)">08de243eaa-r0 do_patch: Command Error: &#39;quilt --quiltrc /home/rav=
i/microchip/yocto/</span><span style=3D"text-align:left;color:rgb(80,0,80);=
text-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial=
,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:norm=
al;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;whi=
te-space:normal;float:none;background-color:rgb(255,255,255)">poky/build-mi=
crochip/tmp/work/</span><span style=3D"text-align:left;color:rgb(80,0,80);t=
ext-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,=
Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:norma=
l;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;whit=
e-space:normal;float:none;background-color:rgb(255,255,255)">cortexa5t2hf-n=
eon-poky-linux-</span><span style=3D"text-align:left;color:rgb(80,0,80);tex=
t-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,He=
lvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;=
font-weight:400;text-decoration:none;word-spacing:0px;display:inline;white-=
space:normal;float:none;background-color:rgb(255,255,255)">gnueabi/qtbase/5=
.11.3+</span><span style=3D"text-align:left;color:rgb(80,0,80);text-transfo=
rm:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,s=
ans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weig=
ht:400;text-decoration:none;word-spacing:0px;display:inline;white-space:nor=
mal;float:none;background-color:rgb(255,255,255)">gitAUTOINC+08de243eaa-r0/=
</span><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:non=
e;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-se=
rif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:400=
;text-decoration:none;word-spacing:0px;display:inline;white-space:normal;fl=
oat:none;background-color:rgb(255,255,255)">recipe-sysroot-native/etc/</spa=
n><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;tex=
t-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;f=
ont-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text=
-decoration:none;word-spacing:0px;display:inline;white-space:normal;float:n=
one;background-color:rgb(255,255,255)">quiltrc push&#39; exited with 0=C2=
=A0 Output:</span><br style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;white-space:normal"><span s=
tyle=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:=
0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:=
13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorati=
on:none;word-spacing:0px;display:inline;white-space:normal;float:none;backg=
round-color:rgb(255,255,255)">
&gt; Applying patch 0004-Provide-access-to-</span><span style=3D"text-align=
:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing=
:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style=
:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spaci=
ng:0px;display:inline;white-space:normal;float:none;background-color:rgb(25=
5,255,255)">linuxfb-dri-fd-through-</span><span style=3D"text-align:left;co=
lor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;=
font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;=
font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;d=
isplay:inline;white-space:normal;float:none;background-color:rgb(255,255,25=
5)">platform.patch</span><br style=3D"text-align:left;color:rgb(80,0,80);te=
xt-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,H=
elvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal=
;font-weight:400;text-decoration:none;word-spacing:0px;white-space:normal">=
<span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-=
indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;fon=
t-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-d=
ecoration:none;word-spacing:0px;display:inline;white-space:normal;float:non=
e;background-color:rgb(255,255,255)">
&gt; patching file src/platformsupport/</span><span style=3D"text-align:lef=
t;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:nor=
mal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:nor=
mal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0=
px;display:inline;white-space:normal;float:none;background-color:rgb(255,25=
5,255)">fbconvenience/qfbscreen_p.h</span><br style=3D"text-align:left;colo=
r:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fo=
nt-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fo=
nt-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;whi=
te-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tra=
nsform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helveti=
ca,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-=
weight:400;text-decoration:none;word-spacing:0px;display:inline;white-space=
:normal;float:none;background-color:rgb(255,255,255)">
&gt; patching file src/plugins/platforms/linuxfb/</span><span style=3D"text=
-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-s=
pacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font=
-style:normal;font-variant:normal;font-weight:400;text-decoration:none;word=
-spacing:0px;display:inline;white-space:normal;float:none;background-color:=
rgb(255,255,255)">qlinuxfbdrmscreen.cpp</span><br style=3D"text-align:left;=
color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norma=
l;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norma=
l;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px=
;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text=
-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Hel=
vetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;f=
ont-weight:400;text-decoration:none;word-spacing:0px;display:inline;white-s=
pace:normal;float:none;background-color:rgb(255,255,255)">
&gt; patching file src/plugins/platforms/linuxfb/</span><span style=3D"text=
-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-s=
pacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font=
-style:normal;font-variant:normal;font-weight:400;text-decoration:none;word=
-spacing:0px;display:inline;white-space:normal;float:none;background-color:=
rgb(255,255,255)">qlinuxfbdrmscreen.h</span><br style=3D"text-align:left;co=
lor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;=
font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;=
font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;w=
hite-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-t=
ransform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helve=
tica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;fon=
t-weight:400;text-decoration:none;word-spacing:0px;display:inline;white-spa=
ce:normal;float:none;background-color:rgb(255,255,255)">
&gt; patching file src/plugins/platforms/linuxfb/</span><span style=3D"text=
-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-s=
pacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font=
-style:normal;font-variant:normal;font-weight:400;text-decoration:none;word=
-spacing:0px;display:inline;white-space:normal;float:none;background-color:=
rgb(255,255,255)">qlinuxfbintegration.cpp</span><br style=3D"text-align:lef=
t;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:nor=
mal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:nor=
mal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0=
px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);te=
xt-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,H=
elvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal=
;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;white=
-space:normal;float:none;background-color:rgb(255,255,255)">
&gt; Hunk #1 FAILED at 173.</span><br style=3D"text-align:left;color:rgb(80=
,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-famil=
y:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varia=
nt:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-space=
:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:n=
one;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-=
serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:4=
00;text-decoration:none;word-spacing:0px;display:inline;white-space:normal;=
float:none;background-color:rgb(255,255,255)">
&gt; 1 out of 1 hunk FAILED -- rejects in file src/plugins/platforms/linuxf=
b/</span><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:n=
one;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-=
serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:4=
00;text-decoration:none;word-spacing:0px;display:inline;white-space:normal;=
float:none;background-color:rgb(255,255,255)">qlinuxfbintegration.cpp</span=
><br style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-i=
ndent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font=
-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-de=
coration:none;word-spacing:0px;white-space:normal"><span style=3D"text-alig=
n:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacin=
g:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-styl=
e:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spac=
ing:0px;display:inline;white-space:normal;float:none;background-color:rgb(2=
55,255,255)">
&gt; patching file src/plugins/platforms/linuxfb/</span><span style=3D"text=
-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-s=
pacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font=
-style:normal;font-variant:normal;font-weight:400;text-decoration:none;word=
-spacing:0px;display:inline;white-space:normal;float:none;background-color:=
rgb(255,255,255)">qlinuxfbscreen.h</span><br style=3D"text-align:left;color=
:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;fon=
t-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;fon=
t-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;whit=
e-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-tran=
sform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetic=
a,sans-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-w=
eight:400;text-decoration:none;word-spacing:0px;display:inline;white-space:=
normal;float:none;background-color:rgb(255,255,255)">
&gt; Patch 0004-Provide-access-to-</span><span style=3D"text-align:left;col=
or:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;f=
ont-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;f=
ont-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;di=
splay:inline;white-space:normal;float:none;background-color:rgb(255,255,255=
)">linuxfb-dri-fd-through-</span><span style=3D"text-align:left;color:rgb(8=
0,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fami=
ly:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-vari=
ant:normal;font-weight:400;text-decoration:none;word-spacing:0px;display:in=
line;white-space:normal;float:none;background-color:rgb(255,255,255)">platf=
orm.patch does not apply (enforce with -f)</span><br style=3D"text-align:le=
ft;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:no=
rmal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:no=
rmal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:=
0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80);t=
ext-transform:none;text-indent:0px;letter-spacing:normal;font-family:Arial,=
Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:norma=
l;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;whit=
e-space:normal;float:none;background-color:rgb(255,255,255)">
&gt; ERROR: qtbase-5.11.3+gitAUTOINC+</span><span style=3D"text-align:left;=
color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norma=
l;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norma=
l;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px=
;display:inline;white-space:normal;float:none;background-color:rgb(255,255,=
255)">08de243eaa-r0 do_patch: Function failed: patch_do_patch</span><br sty=
le=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0p=
x;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13=
.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration=
:none;word-spacing:0px;white-space:normal"><span style=3D"text-align:left;c=
olor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal=
;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal=
;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;=
display:inline;white-space:normal;float:none;background-color:rgb(255,255,2=
55)">
&gt; ERROR: Logfile of failure stored in: /home/ravi/microchip/yocto/</span=
><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text=
-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;fo=
nt-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-=
decoration:none;word-spacing:0px;display:inline;white-space:normal;float:no=
ne;background-color:rgb(255,255,255)">poky/build-microchip/tmp/work/</span>=
<span style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-=
indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;fon=
t-size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-d=
ecoration:none;word-spacing:0px;display:inline;white-space:normal;float:non=
e;background-color:rgb(255,255,255)">cortexa5t2hf-neon-poky-linux-</span><s=
pan style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-in=
dent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-=
size:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-dec=
oration:none;word-spacing:0px;display:inline;white-space:normal;float:none;=
background-color:rgb(255,255,255)">gnueabi/qtbase/5.11.3+</span><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">gitAUTOINC+08de243eaa-r0/temp/</span><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">log.do_patch.21776</span><br style=3D"text-align:=
left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:=
normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:=
normal;font-variant:normal;font-weight:400;text-decoration:none;word-spacin=
g:0px;white-space:normal"><span style=3D"text-align:left;color:rgb(80,0,80)=
;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:Aria=
l,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-variant:nor=
mal;font-weight:400;text-decoration:none;word-spacing:0px;display:inline;wh=
ite-space:normal;float:none;background-color:rgb(255,255,255)">
&gt; ERROR: Task (/home/ravi/microchip/yocto/</span><span style=3D"text-ali=
gn:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spaci=
ng:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-sty=
le:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spa=
cing:0px;display:inline;white-space:normal;float:none;background-color:rgb(=
255,255,255)">meta-qt5/recipes-qt/qt5/</span><span style=3D"text-align:left=
;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norm=
al;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norm=
al;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0p=
x;display:inline;white-space:normal;float:none;background-color:rgb(255,255=
,255)">qtbase_git.bb:do_patch) failed with exit code &#39;1&#39;</span><br =
style=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent=
:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size=
:13.33px;font-style:normal;font-variant:normal;font-weight:400;text-decorat=
ion:none;word-spacing:0px;white-space:normal"><span style=3D"text-align:lef=
t;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:nor=
mal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:nor=
mal;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0=
px;display:inline;white-space:normal;float:none;background-color:rgb(255,25=
5,255)">
&gt; NOTE: Tasks Summary: Attempted 1150 tasks of which 1149 didn&#39;t nee=
d to be rerun and 1 failed.</span><br style=3D"text-align:left;color:rgb(80=
,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-famil=
y:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-varia=
nt:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-space=
:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:n=
one;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-=
serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:4=
00;text-decoration:none;word-spacing:0px;display:inline;white-space:normal;=
float:none;background-color:rgb(255,255,255)">
&gt; Summary: 1 task failed:</span><br style=3D"text-align:left;color:rgb(8=
0,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fami=
ly:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-vari=
ant:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-spac=
e:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:=
none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans=
-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:=
400;text-decoration:none;word-spacing:0px;display:inline;white-space:normal=
;float:none;background-color:rgb(255,255,255)">
&gt;=C2=A0 =C2=A0/home/ravi/microchip/yocto/</span><span style=3D"text-alig=
n:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacin=
g:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-styl=
e:normal;font-variant:normal;font-weight:400;text-decoration:none;word-spac=
ing:0px;display:inline;white-space:normal;float:none;background-color:rgb(2=
55,255,255)">meta-qt5/recipes-qt/qt5/</span><span style=3D"text-align:left;=
color:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:norma=
l;font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:norma=
l;font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px=
;display:inline;white-space:normal;float:none;background-color:rgb(255,255,=
255)">qtbase_git.bb:do_patch</span><br style=3D"text-align:left;color:rgb(8=
0,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;font-fami=
ly:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;font-vari=
ant:normal;font-weight:400;text-decoration:none;word-spacing:0px;white-spac=
e:normal"><span style=3D"text-align:left;color:rgb(80,0,80);text-transform:=
none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans=
-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:=
400;text-decoration:none;word-spacing:0px;display:inline;white-space:normal=
;float:none;background-color:rgb(255,255,255)">
&gt; Summary: There were 2 ERROR messages shown, returning a non-zero exit =
code.</span><br style=3D"text-align:left;color:rgb(80,0,80);text-transform:=
none;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans=
-serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:=
400;text-decoration:none;word-spacing:0px;white-space:normal"><span style=
=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0px;=
letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13.3=
3px;font-style:normal;font-variant:normal;font-weight:400;text-decoration:n=
one;word-spacing:0px;display:inline;white-space:normal;float:none;backgroun=
d-color:rgb(255,255,255)">
&gt;</span><br style=3D"text-align:left;color:rgb(80,0,80);text-transform:n=
one;text-indent:0px;letter-spacing:normal;font-family:Arial,Helvetica,sans-=
serif;font-size:13.33px;font-style:normal;font-variant:normal;font-weight:4=
00;text-decoration:none;word-spacing:0px;white-space:normal"><div><span sty=
le=3D"text-align:left;color:rgb(80,0,80);text-transform:none;text-indent:0p=
x;letter-spacing:normal;font-family:Arial,Helvetica,sans-serif;font-size:13=
.33px;font-style:normal;font-variant:normal;font-weight:400;text-decoration=
:none;word-spacing:0px;display:inline;white-space:normal;float:none;backgro=
und-color:rgb(255,255,255)">
&gt; ------------------------------</span><span style=3D"text-align:left;co=
lor:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;=
font-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;=
font-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;d=
isplay:inline;white-space:normal;float:none;background-color:rgb(255,255,25=
5)">------------------------------</span><span style=3D"text-align:left;col=
or:rgb(80,0,80);text-transform:none;text-indent:0px;letter-spacing:normal;f=
ont-family:Arial,Helvetica,sans-serif;font-size:13.33px;font-style:normal;f=
ont-variant:normal;font-weight:400;text-decoration:none;word-spacing:0px;di=
splay:inline;white-space:normal;float:none;background-color:rgb(255,255,255=
)">----------------------------</span></div><div><b></b><i></i><u></u><sub>=
</sub><sup></sup><strike></strike><br></div></span></div></div></div></div>=
</div>

--00000000000082ba130595a7b894--
