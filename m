Return-Path: <rpjday@crashcourse.ca>
Received: from smtp486.redcondor.net (smtp486.redcondor.net [208.80.204.86])
	by mail.openembedded.org (Postfix) with ESMTP id 3786365CAD
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Aug 2014 12:51:21 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
	via TCP (outbound) with ESMTPS id 20140810125121643
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Aug 2014 12:51:21 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=35179 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XGSah-0003Vr-8o for bitbake-devel@lists.openembedded.org;
	Sun, 10 Aug 2014 08:51:15 -0400
Date: Sun, 10 Aug 2014 08:51:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408100847510.28457@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] bitbake-user-manual-metadata.xml: Use newer rdeptask example.
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
X-List-Received-Date: Sun, 10 Aug 2014 12:51:27 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Given that the "do_package_write" task doesn't exist in OE anymore,
steal another, existing example to demonstrate the "rdeptask" flag.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  grab an existing, actual example out of OE's insane.bbclass file, in
case readers go looking for it.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 992f650..a8f72ab 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -1551,11 +1551,11 @@
                 item runtime dependency which must have completed before that
                 task can be executed.
                 <literallayout class='monospaced'>
-     do_package_write[rdeptask] = "do_package"
+     do_package_qa[rdeptask] = "do_packagedata"
                 </literallayout>
-                In the previous example, the <filename>do_package</filename>
+                In the previous example, the <filename>do_packagedata</filename>
                 task of each item in <filename>RDEPENDS</filename> must have
-                completed before <filename>do_package_write</filename> can execute.
+                completed before <filename>do_package_qa</filename> can execute.
             </para>
         </section>


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


