Return-Path: <LW@KARO-electronics.de>
X-Greylist: delayed 361 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 20 Mar 2018 15:36:46 UTC
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.31])
	by mail.openembedded.org (Postfix) with ESMTP id DA22978956
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Mar 2018 15:36:46 +0000 (UTC)
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
	by smtprelay04.ispgateway.de with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
	(envelope-from <LW@KARO-electronics.de>)
	id 1eyIne-0003Pz-8Z; Tue, 20 Mar 2018 16:03:56 +0100
Received: from lothar by ipc1.ka-ro with local (Exim 4.84_2 #2 (Debian))
	id 1eyInX-0006LF-5J; Tue, 20 Mar 2018 16:03:35 +0100
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2018 16:03:28 +0100
Message-Id: <1521558208-16547-1-git-send-email-LW@KARO-electronics.de>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
X-Mailman-Approved-At: Mon, 02 Apr 2018 22:22:40 +0000
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] bitbake: bitbake-user-manual-metadata: fix wrong option to 'echo' comamnd in example
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
X-List-Received-Date: Tue, 20 Mar 2018 15:36:47 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The original text reads:
| For these to have an effect, the value must be passed
| to some utility that interprets escape sequences,
| such as printf or echo -n.

The '-n' option tells echo to not append a newline to the output.
What's meant here is the '-e' option to "enable interpretation of
backslash escapes".

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 0cfa53d..abdbd54 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -98,7 +98,7 @@
                     For these to have an effect, the value must be passed
                     to some utility that interprets escape sequences,
                     such as <filename>printf</filename> or
-                    <filename>echo -n</filename>.
+                    <filename>echo -e</filename>.
                 </note>
             </para>
         </section>
-- 
2.1.4


