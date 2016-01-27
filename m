Return-Path: <martin.samuelsson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id D6D7677123
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 12:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id E2B582E3B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 7-hfx8jLqISy for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:08 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 26A052E3AE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:08 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 0E244156E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:08 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 024D1D0F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:08 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 0025D34271
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 13:24:07 +0100 (CET)
Received: from lnxmartinsa2.se.axis.com (10.92.55.2) by smtp-x.axis.com
	(10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0;
	Wed, 27 Jan 2016 13:24:07 +0100
Date: Wed, 27 Jan 2016 13:24:06 +0100
From: Martin Samuelsson <martin.samuelsson@axis.com>
To: bitbake development advancement <bitbake-devel@lists.openembedded.org>
Message-ID: <20160127122406.GA20819@lnxmartinsa2.se.axis.com>
References: <20151119125639.GC19141@lnxmartinsa2.se.axis.com>
	<20160114135304.GA7849@lnxmartinsa2.se.axis.com>
MIME-Version: 1.0
In-Reply-To: <20160114135304.GA7849@lnxmartinsa2.se.axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH v2] user-manual-metadata: Clarify functionality of task flag 'dirs'.
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
X-List-Received-Date: Wed, 27 Jan 2016 12:24:10 -0000
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline

Signed-off-by: Martin Samuelsson <martin.samuelsson@axis.com>
---
I've seen no response to this. With this being my first attempt at making a 
contribution to bitbake, I would appreciate any feedback. Is something e.g. 
problematic with the patch?

Please note that in the current state of documentation the two flags 'dirs' 
and 'cleandirs' are very similar in their description. Yet the flags are not 
all that similar. It is easy to get (and I got) the impression that they are 
functionally interchangeable with exception from that 'cleandirs' creates 
clean directories. The fact that 'dirs' points out the work dir to be used, 
while 'cleandirs' does not, is quite unexpected and should be important 
enough to be explicitly stated.

Bonus in this patch version. Typo fix in description of cleandirs.

 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 1b9d800..c242653 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -1214,7 +1214,7 @@
             functionality of the task:
             <itemizedlist>
                 <listitem><para><emphasis>cleandirs:</emphasis>
-                    Empty directories that should created before the task runs.
+                    Empty directories that should be created before the task runs.
                     </para></listitem>
                 <listitem><para><emphasis>depends:</emphasis>
                     Controls inter-task dependencies.
@@ -1233,7 +1233,9 @@
                     section for more information.
                     </para></listitem>
                 <listitem><para><emphasis>dirs:</emphasis>
-                    Directories that should be created before the task runs.
+                    Directories that should be created before the task runs. The
+                    last directory listed will be used as the work directory for the
+                    task.
                     </para></listitem>
                 <listitem><para><emphasis>lockfiles:</emphasis>
                      Specifies one or more lockfiles to lock while the task
-- 
2.1.4


