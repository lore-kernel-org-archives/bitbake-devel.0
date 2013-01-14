Received: from relay1.mentorg.com ([192.94.38.131])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Andrew_Stubbs@mentor.com>) id 1Tum3N-0001do-HY
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 16:34:36 +0100
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp 
	id 1TuloY-0003qz-4O from Andrew_Stubbs@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 07:19:06 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by
	SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft
	SMTPSVC(6.0.3790.4675); Mon, 14 Jan 2013 07:19:05 -0800
Received: from [172.30.3.170] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
	(137.202.0.104) with Microsoft SMTP Server id 14.1.289.1;
	Mon, 14 Jan 2013 15:19:04 +0000
Message-ID: <50F421E6.4060400@codesourcery.com>
Date: Mon, 14 Jan 2013 15:19:02 +0000
From: Andrew Stubbs <ams@codesourcery.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-OriginalArrivalTime: 14 Jan 2013 15:19:05.0823 (UTC)
	FILETIME=[7E038EF0:01CDF26A]
Subject: [PATCH] fix bundled base.bbclass file
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
X-List-Received-Date: Mon, 14 Jan 2013 15:34:39 -0000
X-Groupsio-MsgNum: 3107
Content-Type: multipart/mixed; boundary="------------080904070504080507030802"

--------------080904070504080507030802
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The base.bbclass file that is included with the bitbake sources does not 
appear to work properly. Specifically, none of the output appears on screen.

A quick look at the poky equivalent shows that they use a different 
means to print the data. Presumably something got updated somewhere, and 
the example base class is merely out of date.

The attached patch fixes the do_listtasks and do_showdata code such that 
it works as I would expect.

I had expected that the base_do_build function would run if my .bb file 
did not define do_build, but it does not appear to, and it's not obvious 
to me how, when, or why it is supposed to work.

Andrew

--------------080904070504080507030802
Content-Type: text/x-patch; name="baseclass.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="baseclass.patch"

--- /opt/bitbake/classes/base.bbclass	2012-11-26 09:55:32.000000000 +0000
+++ classes/base.bbclass	2013-01-14 15:02:36.965594908 +0000
@@ -44,7 +44,7 @@
 	# emit the metadata which isnt valid shell
 	for e in bb.data.keys(d):
 		if d.getVarFlag(e, 'python'):
-			sys.__stdout__.write("\npython %s () {\n%s}\n" % (e, d.getVar(e, True)))
+			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e, True)))
 }
 
 addtask listtasks
@@ -53,7 +53,7 @@
 	import sys
 	for e in bb.data.keys(d):
 		if d.getVarFlag(e, 'task'):
-			sys.__stdout__.write("%s\n" % e)
+			bb.plain("%s" % e)
 }
 
 addtask build

--------------080904070504080507030802--
