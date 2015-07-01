Return-Path: <brahim.aida@openwide.fr>
X-Greylist: delayed 1018 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 01 Jul 2015 08:33:44 UTC
Received: from zimbra3.corp.accelance.fr (zimbra3.corp.accelance.fr
	[213.162.49.233])
	by mail.openembedded.org (Postfix) with ESMTP id 35D3C60017
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jul 2015 08:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 5F8FE7EBE4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jul 2015 10:16:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id R6NsRKvZ2qGL for <bitbake-devel@lists.openembedded.org>; 
	Wed,  1 Jul 2015 10:16:45 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr
	[213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id BA0B57EB67
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jul 2015 10:16:45 +0200 (CEST)
Date: Wed, 1 Jul 2015 10:16:45 +0200 (CEST)
From: =?utf-8?B?QcOvZGE=?= Brahim <brahim.aida@openwide.fr>
To: bitbake-devel@lists.openembedded.org
Message-ID: <74556586.2389309.1435738605689.JavaMail.root@openwide.fr>
In-Reply-To: <2119774081.2388882.1435738369262.JavaMail.root@openwide.fr>
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
X-List-Received-Date: Wed, 01 Jul 2015 08:33:47 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_2389308_295288229.1435738605689"

------=_Part_2389308_295288229.1435738605689
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, 

I'm trying to generate an embedded linux image with a java oracle meta but here what I get : 



aida@aida:~/poky/build$ bitbake core-image-minimal 
Loading cache: 100% |##########################################| ETA: 00:00:00 
Loaded 1292 entries from dependency cache. 
WARNING: No bb files matched BBFILE_PATTERN_oraclejava '^/home/aida/poky/meta-oracle-java/' 
NOTE: Resolving any missing task queue dependencies 
ERROR: Nothing RPROVIDES 'oracle-jse-jdk-i586' (but /home/aida/poky/meta/recipes-core/images/core-image-minimal.bb RDEPENDS on or otherwise requires it) 
ERROR: oracle-jse-jdk-i586 was skipped: because it has a restricted license not whitelisted in LICENSE_FLAGS_WHITELIST 
NOTE: Runtime target 'oracle-jse-jdk-i586' is unbuildable, removing... 
Missing or unbuildable dependency chain was: ['oracle-jse-jdk-i586'] 
ERROR: Required build target 'core-image-minimal' has no buildable providers. 
Missing or unbuildable dependency chain was: ['core-image-minimal', 'oracle-jse-jdk-i586'] 

Summary: There was 1 WARNING message shown. 
Summary: There were 2 ERROR messages shown, returning a non-zero exit code. 




Despite my bblayers.conf : 


<blockquote>
BBLAYERS ?= " \ 
/home/aida/poky/meta \ 
/home/aida/poky/meta-yocto \ 
/home/aida/poky/meta-oracle-java \ 
/home/aida/poky/meta-yocto-bsp \ 
" 

</blockquote>

And my local.conf : 


<blockquote>
LICENSE_FLAGS_WHITELIST += "oracle_java" 

</blockquote>

I can't find where this No bb files matched BBFILE_PATTERN warning came from, neither then the licence problem... 

Thank you ! 

------=_Part_2389308_295288229.1435738605689
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'>Hello, <br><br>I'm trying to generate an embedded lin=
ux image with a java oracle meta but here what I get :<br><br><blockquote><=
i>aida@aida:~/poky/build$ bitbake core-image-minimal</i><br><i>Loading cach=
e: 100% |##########################################| ETA: &nbsp;00:00:00</i=
><br><i>Loaded 1292 entries from dependency cache.</i><br><b><i>WARNING: No=
 bb files matched BBFILE_PATTERN_oraclejava '^/home/aida/poky/meta-oracle-j=
ava/'</i></b><br><i>NOTE: Resolving any missing task queue dependencies</i>=
<br><i>ERROR: Nothing RPROVIDES 'oracle-jse-jdk-i586' (but /home/aida/poky/=
meta/recipes-core/images/core-image-minimal.bb RDEPENDS on or otherwise req=
uires it)</i><br><i>ERROR: oracle-jse-jdk-i586 was skipped: because it has =
a restricted license not whitelisted in LICENSE_FLAGS_WHITELIST</i><br><i>N=
OTE: Runtime target 'oracle-jse-jdk-i586' is unbuildable, removing...</i><b=
r><i>Missing or unbuildable dependency chain was: ['oracle-jse-jdk-i586']</=
i><br><i>ERROR: Required build target 'core-image-minimal' has no buildable=
 providers.</i><br><i>Missing or unbuildable dependency chain was: ['core-i=
mage-minimal', 'oracle-jse-jdk-i586']</i><br><br><i>Summary: There was 1 WA=
RNING message shown.</i><br><i>Summary: There were 2 ERROR messages shown, =
returning a non-zero exit code.</i><br></blockquote><br><br>Despite my bbla=
yers.conf :<br><br><blockquote><i>BBLAYERS ?=3D " \<br>&nbsp;&nbsp;/home/ai=
da/poky/meta \<br>&nbsp;&nbsp;/home/aida/poky/meta-yocto \<br>&nbsp;&nbsp;/=
home/aida/poky/meta-oracle-java \<br>&nbsp;&nbsp;/home/aida/poky/meta-yocto=
-bsp \<br>&nbsp;&nbsp;"<br></i></blockquote><br>And my local.conf : <br><br=
><blockquote><i><code>LICENSE_FLAGS_WHITELIST +=3D "oracle_java"</code></i>=
<br></blockquote><br>I can't find where this No bb files matched BBFILE_PAT=
TERN warning came from, neither then the licence problem...<br><br>Thank yo=
u !<br></div></body></html>

------=_Part_2389308_295288229.1435738605689--
