Return-Path: <brahim.aida@openwide.fr>
Received: from zimbra3.corp.accelance.fr (zimbra3.corp.accelance.fr
	[213.162.49.233])
	by mail.openembedded.org (Postfix) with ESMTP id C556960017
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jul 2015 09:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 0D01F7EC00;
	Wed,  1 Jul 2015 11:23:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id rbyeU46643QV; Wed,  1 Jul 2015 11:23:29 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr
	[213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 7D35C7EB67;
	Wed,  1 Jul 2015 11:23:29 +0200 (CEST)
Date: Wed, 1 Jul 2015 11:23:29 +0200 (CEST)
From: =?utf-8?B?QcOvZGE=?= Brahim <brahim.aida@openwide.fr>
To: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Message-ID: <703421811.2393911.1435742609449.JavaMail.root@openwide.fr>
MIME-Version: 1.0
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.6_GA_2926 (ZimbraWebClient - FF3.0 (Linux)/7.2.6_GA_2926)
X-Mailman-Approved-At: Tue, 07 Jul 2015 12:25:31 +0000
Subject: No bb files matched ?
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
X-List-Received-Date: Wed, 01 Jul 2015 09:23:31 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_2393910_899692734.1435742609448"

------=_Part_2393910_899692734.1435742609448
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, 

I'm trying to generate an embedded linux image with a java oracle 
meta but here what I get : 



aida@aida:~/poky/build$ bitbake core-image-minimal 
Loading cache: 100% |##########################################| ETA: 
00:00:00 
Loaded 1292 entries from dependency cache. 
WARNING: No bb files matched BBFILE_PATTERN_oraclejava 
'^/home/aida/poky/meta-oracle-java/' 
NOTE: Resolving any missing task queue dependencies 
ERROR: Nothing RPROVIDES 'oracle-jse-jdk-i586' (but 
/home/aida/poky/meta/recipes-core/images/core-image-minimal.bb 
RDEPENDS on or otherwise requires it) 
ERROR: oracle-jse-jdk-i586 was skipped: because it has a restricted 
license not whitelisted in LICENSE_FLAGS_WHITELIST 
NOTE: Runtime target 'oracle-jse-jdk-i586' is unbuildable, 
removing... 
Missing or unbuildable dependency chain was: ['oracle-jse-jdk-i586'] 
ERROR: Required build target 'core-image-minimal' has no buildable 
providers. 
Missing or unbuildable dependency chain was: ['core-image-minimal', 
'oracle-jse-jdk-i586'] 

Summary: There was 1 WARNING message shown. 
Summary: There were 2 ERROR messages shown, returning a non-zero exit 
code. 


Despite my bblayers.conf : 






<blockquote>
BBLAYERS ?= " \ 
/home/aida/poky/meta \ 
/home/aida/poky/meta-yocto \ 
/home/aida/poky/meta-oracle-java \ 
/home/aida/poky/meta-yocto-bsp \ 
" 

And my local.conf : 
</blockquote>



<blockquote>
LICENSE_FLAGS_WHITELIST += "oracle_java" 

I can't find where this No bb files matched BBFILE_PATTERN warning 
</blockquote>

came from, neither then the licence problem... 

Thank you ! 

------=_Part_2393910_899692734.1435742609448
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'>Hello,<br><br>I'm trying to generate an embedded linu=
x image with a java oracle<br>meta but here what I get :<br><br><blockquote=
> aida@aida:~/poky/build$ bitbake core-image-minimal<br>&nbsp;Loading cache=
: 100% |##########################################| ETA:<br>&nbsp;00:00:00<=
br>&nbsp;Loaded 1292 entries from dependency cache.<br>&nbsp;<b>WARNING: No=
 bb files matched BBFILE_PATTERN_oraclejava<br>&nbsp;'^/home/aida/poky/meta=
-oracle-java/'</b><br>&nbsp;NOTE: Resolving any missing task queue dependen=
cies<br>&nbsp;ERROR: Nothing RPROVIDES 'oracle-jse-jdk-i586' (but<br>&nbsp;=
/home/aida/poky/meta/recipes-core/images/core-image-minimal.bb<br>&nbsp;RDE=
PENDS on or otherwise requires it)<br>&nbsp;ERROR: oracle-jse-jdk-i586 was =
skipped: because it has a restricted<br>&nbsp;license not whitelisted in LI=
CENSE_FLAGS_WHITELIST<br>&nbsp;NOTE: Runtime target 'oracle-jse-jdk-i586' i=
s unbuildable,<br>&nbsp;removing...<br>&nbsp;Missing or unbuildable depende=
ncy chain was: ['oracle-jse-jdk-i586']<br>&nbsp;ERROR: Required build targe=
t 'core-image-minimal' has no buildable<br>&nbsp;providers.<br>&nbsp;Missin=
g or unbuildable dependency chain was: ['core-image-minimal',<br>&nbsp;'ora=
cle-jse-jdk-i586']<br><br>&nbsp;Summary: There was 1 WARNING message shown.=
<br>&nbsp;Summary: There were 2 ERROR messages shown, returning a non-zero =
exit<br>&nbsp;code.<br><br><br>Despite my bblayers.conf :</blockquote><br><=
br><br><br><blockquote> BBLAYERS ?=3D " \<br>&nbsp;/home/aida/poky/meta \<b=
r>&nbsp;/home/aida/poky/meta-yocto \<br>&nbsp;/home/aida/poky/meta-oracle-j=
ava \<br>&nbsp;/home/aida/poky/meta-yocto-bsp \<br>&nbsp;"<br><br>And my lo=
cal.conf :</blockquote><br><br><blockquote> LICENSE_FLAGS_WHITELIST +=3D "o=
racle_java"<br><br>I can't find where this No bb files matched BBFILE_PATTE=
RN warning</blockquote><br>came from, neither then the licence problem...<b=
r><br>Thank you !</div></body></html>

------=_Part_2393910_899692734.1435742609448--
