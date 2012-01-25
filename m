Received: from col0-omc4-s5.col0.hotmail.com ([65.55.34.207])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kyoonn@hotmail.com>) id 1RqBkH-0001PP-Qi
	for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jan 2012 23:55:14 +0100
Received: from COL120-W31 ([65.55.34.201]) by col0-omc4-s5.col0.hotmail.com
	with Microsoft SMTPSVC(6.0.3790.4675); 
	Wed, 25 Jan 2012 14:46:23 -0800
Message-ID: <COL120-W317CACA522F5F6B650F343DD880@phx.gbl>
X-Originating-IP: [70.137.132.86]
From: simran singh <kyoonn@hotmail.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jan 2012 14:46:22 -0800
Importance: Normal
MIME-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2012 22:46:23.0110 (UTC)
	FILETIME=[29A35260:01CCDBB3]
Subject: Perl extension for openSSL - Net::SSLeay
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
X-List-Received-Date: Wed, 25 Jan 2012 22:55:14 -0000
X-Groupsio-MsgNum: 900
Content-Type: multipart/mixed;
	boundary="_1cb8b2f5-3938-44d8-a56e-421aacb2fcf4_"

--_1cb8b2f5-3938-44d8-a56e-421aacb2fcf4_
Content-Type: multipart/alternative;
	boundary="_20af68f9-fdda-4f81-8e71-7a42f3322ec7_"

--_20af68f9-fdda-4f81-8e71-7a42f3322ec7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

I am not sure if this is the right list.

Trying to add Net::SSLeay perl module=2C I get the following error.



 NOTE: Running task 204 of 315 (ID: 11=2C=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackco=
re-common/recipes/

net-ssleay/net-ssleay_1.36.bb=2C do_compile)

ERROR: TaskFailed event exception=2C aborting

ERROR: Build of=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackco=
re-common/recipes/net-ssleay/net-ssleay_1.36.bb

 do_compile failed

ERROR: Task 11=20
(/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackc=
ore-common/recipes/net-ssleay/net-ssleay_1.36.bb=2C

 do_compile) failed with 256

ERROR:=20
'/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackc=
ore-common/recipes/net-ssleay/net-ssleay_1.36.bb'
 failed

NOTE: package net-ssleay-1.36-r0: task do_compile: Started

ERROR: Function do_compile failed

NOTE: Task failed: ('function do_compile failed'=2C=20
'/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds=
_release/work/

ppce500mc-linux/net-ssleay-1.36-r0/temp/log.do_compile.22680')

ERROR: Logfile of failure stored in:=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds_=
release/work/ppce500mc-

linux/net-ssleay-1.36-r0/temp/log.do_compile.22680

Log data follows:

| NOTE: make -j 2 -e MAKEFLAGS=3D PASTHRU_INC=3D -fexpensive-optimizations=
=20
-frename-registers -fomit-frame-pointer -O2 -g0 CCFLAGS=3D -fexpensive

-optimizations -frename-registers -fomit-frame-pointer -O2 -g0=20
LD=3Dpowerpc-linux-gnu-gcc -mcpu=3De500mc -maix-struct-return=20
--sysroot=3D/home/Simran/

Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds_release/sysro=
ots/ppce500mc-linux

| Can't locate ExtUtils/Command.pm in @INC (@INC contains: inc=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release

/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib

/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib/perl/5.10.1

 /home/

jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_p1023r=
ds_release/sysroots/i686-linux/usr/lib/perl .).

| BEGIN failed--compilation aborted.

| make: *** [blib/lib/Net/.exists] Error 2

| make: *** Waiting for unfinished jobs....

| Can't locate ExtUtils/Command.pm in @INC (@INC contains: inc=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/

build_p1023rds_release/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release

/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr

/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib/perl
 .).

| BEGIN failed--compilation aborted.

| make: *** [blib/arch/.exists] Error 2

| FATAL: oe_runmake failed

| ERROR: Function do_compile failed

NOTE: package net-ssleay-1.36-r0: task do_compile: Failed

ERROR: TaskFailed event exception=2C aborting





I used the libnet-ssleay-perl_1.36.bb=2C I found in the oe-commit archive.

Please advice and thanks.



Sim Gill 		 	   		   		 	   		  =

--_20af68f9-fdda-4f81-8e71-7a42f3322ec7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hello=2C<br>
I am not sure if this is the right list.<br>
Trying to add Net::SSLeay perl module=2C I get the following error.<br>
<br>
&nbsp=3BNOTE: Running task 204 of 315 (ID: 11=2C=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackco=
re-common/recipes/<br>
net-ssleay/net-ssleay_1.36.bb=2C do_compile)<br>
ERROR: TaskFailed event exception=2C aborting<br>
ERROR: Build of=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackco=
re-common/recipes/net-ssleay/net-ssleay_1.36.bb<br>
&nbsp=3Bdo_compile failed<br>
ERROR: Task 11=20
(/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackc=
ore-common/recipes/net-ssleay/net-ssleay_1.36.bb=2C<br>
&nbsp=3Bdo_compile) failed with 256<br>
ERROR:=20
'/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/engage-blackc=
ore-common/recipes/net-ssleay/net-ssleay_1.36.bb'
 failed<br>
NOTE: package net-ssleay-1.36-r0: task do_compile: Started<br>
ERROR: Function do_compile failed<br>
NOTE: Task failed: ('function do_compile failed'=2C=20
'/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds=
_release/work/<br>
ppce500mc-linux/net-ssleay-1.36-r0/temp/log.do_compile.22680')<br>
ERROR: Logfile of failure stored in:=20
/home/Simran/Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds_=
release/work/ppce500mc-<br>
linux/net-ssleay-1.36-r0/temp/log.do_compile.22680<br>
Log data follows:<br>
| NOTE: make -j 2 -e MAKEFLAGS=3D PASTHRU_INC=3D -fexpensive-optimizations=
=20
-frename-registers -fomit-frame-pointer -O2 -g0 CCFLAGS=3D -fexpensive<br>
-optimizations -frename-registers -fomit-frame-pointer -O2 -g0=20
LD=3Dpowerpc-linux-gnu-gcc -mcpu=3De500mc -maix-struct-return=20
--sysroot=3D/home/Simran/<br>
Freescale/QorIQ-DPAA-SDK-20111026-systembuilder/build_p4080ds_release/sysro=
ots/ppce500mc-linux<br>
| Can't locate ExtUtils/Command.pm in @INC (@INC contains: inc=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release<br>
/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib<br>
/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib/perl/5.10.1

 /home/<br>
jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_p1023r=
ds_release/sysroots/i686-linux/usr/lib/perl .).<br>
| BEGIN failed--compilation aborted.<br>
| make: *** [blib/lib/Net/.exists] Error 2<br>
| make: *** Waiting for unfinished jobs....<br>
| Can't locate ExtUtils/Command.pm in @INC (@INC contains: inc=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/<br>
build_p1023rds_release/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release<br>
/sysroots/i686-linux/usr/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr<br>
/lib/perl/5.10.1=20
/home/jenkins/jenkins/jobs/qoriq-dpaa-iso-step1/workspace/sb-dev.git/build_=
p1023rds_release/sysroots/i686-linux/usr/lib/perl
 .).<br>
| BEGIN failed--compilation aborted.<br>
| make: *** [blib/arch/.exists] Error 2<br>
| FATAL: oe_runmake failed<br>
| ERROR: Function do_compile failed<br>
NOTE: package net-ssleay-1.36-r0: task do_compile: Failed<br>
ERROR: TaskFailed event exception=2C aborting<br>
<br>
<br>
I used the libnet-ssleay-perl_1.36.bb=2C I found in the oe-commit archive.<=
br>
Please advice and thanks.<br>
<br>
Sim Gill 		 	   		   		 	   		  </div></body>
</html>=

--_20af68f9-fdda-4f81-8e71-7a42f3322ec7_--

--_1cb8b2f5-3938-44d8-a56e-421aacb2fcf4_
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="net-ssleay_1.36.bb"

REVTQ1JJUFRJT04gPSAiTmV0OjpTU0xlYXkgLSBQZXJsIGV4dGVuc2lvbiBmb3IgdXNpbmcgT3Bl
blNTTCIKU0VDVElPTiA9ICJsaWJzIgpMSUNFTlNFID0gIk9wZW5TU0wiCkRFUEVORFMgPSAib3Bl
bnNzbCB6bGliIgpSREVQRU5EU18ke1BOfSArPSAiIFwKCXBlcmwtbW9kdWxlLWNhcnAgXAoJcGVy
bC1tb2R1bGUtZXJybm8gXAoJcGVybC1tb2R1bGUtZXh0dXRpbHMtbWFrZW1ha2VyIFwKCXBlcmwt
bW9kdWxlLW1pbWUtYmFzZTY0IFwKCXBlcmwtbW9kdWxlLXNvY2tldCBcCgkiCgpCQkNMQVNTRVhU
RU5EID0gIm5hdGl2ZSIKUFIgPSAicjAiCgpTUkNfVVJJID0gImh0dHA6Ly9zZWFyY2guY3Bhbi5v
cmcvQ1BBTi9hdXRob3JzL2lkL0YvRkwvRkxPUkEvTmV0LVNTTGVheS0ke1BWfS50YXIuZ3o7bmFt
ZT1uZXQtc3NsZWF5LSR7UFZ9IgpTUkNfVVJJW25ldC1zc2xlYXktMS4zNi5tZDVzdW1dID0gIjU0
MDYxNjM4NzIwZGQ2YTMyNTM5NTMzMWM3N2YyMWQ4IgpTUkNfVVJJW25ldC1zc2xlYXktMS4zNi5z
aGEyNTZzdW1dID0gImUyNjI4OTcyNjNjNWFhOTA5NmUzOWY3ODEzYzdjYjdkNGQwNTUwOGNhNDA2
YjE3Mzg3OGM0ZWNkZGIyYzUzY2UiCgpTID0gIiR7V09SS0RJUn0vTmV0LVNTTGVheS0ke1BWfSIK
CmV4cG9ydCBPUEVOU1NMX1BSRUZJWD0iJHtTVEFHSU5HX0lOQ0RJUn0vLi4iCgppbmhlcml0IGNw
YW4KCgoKCgoKCiNERVNDUklQVElPTiA9ICJOZXQ6OlNTTGVheSBwZXJsIG1vZHVsZSIKI1BSID0g
InIwIgoKI2luaGVyaXQgY3BhbgoKI0RFUEVORFMgPSAicGVybCBvcGVuc3NsIHpsaWIiCiNSREVQ
RU5EU18ke1BOfSArPSAiIFwKIyAgICAgICAgICAgIHBlcmwtbW9kdWxlLWNhcnAgXAojICAgICAg
ICAgICAgcGVybC1tb2R1bGUtZXJybm8gXAojICAgICAgICAgICAgcGVybC1tb2R1bGUtZXh0dXRp
bHMtbWFrZW1ha2VyIFwKIyAgICAgICAgICAgIHBlcmwtbW9kdWxlLW1pbWUtYmFzZTY0IFwKIyAg
ICAgICAgICAgIHBlcmwtbW9kdWxlLXNvY2tldCBcCiMJICAgIHBlcmwtbW9kdWxlLWV4dHV0aWxz
LWNvbW1hbmQgXAojCSAgICBwZXJsLW1vZHVsZS1leHR1dGlscy1jb21tYW5kLW1tIFwKIyAJICAg
ICIKCiNCQkNMQVNTRVhURU5EID0gIm5hdGl2ZSIKCiNTUkNfVVJJID0gImZpbGU6Ly8ke1BOfS0k
e1BWfS50YXIuZ3oiCgojUyA9ICIke1dPUktESVJ9L05ldC1TU0xlYXktMS4zNiIKCiNleHBvcnQg
T1BFTlNTTF9QUkVGSVg9IiR7U1RBR0lOR19JTkNESVJ9Ly4uIgoKI2Zha2Vyb290IGRvX2luc3Rh
bGwoKSB7CgojCW1rZGlyIC1wICR7RH0vdXNyL2Jpbi9OZXQtU1NMZWF5LTEuMzYKCiMJY2QgTmV0
LVNTTGVheS0xLjM2CiMJcGVybCBNYWtlZmlsZS5QTCBJTlNUQUxMX0JBU0U9JHtXT1JLRElSfS9p
bWFnZS91c3IvYmluL05ldC1TU0xlYXktMS4zNgojCXBlcmwgTWFrZWZpbGUuUEwKIwlwZXJsICct
VjppbnN0YWxsLionCiMJbWFrZSBpbnN0YWxsCgojfQoKI0ZJTEVTXyR7UE59ICs9ICIvdXNyL2Jp
bi9uZXQtc3NsZWF5Igo=

--_1cb8b2f5-3938-44d8-a56e-421aacb2fcf4_--
