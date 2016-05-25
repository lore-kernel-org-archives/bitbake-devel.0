Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id 09D3873193
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 19:53:35 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 8A3D321528;
	Wed, 25 May 2016 15:48:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
	by compute1.internal (MEProxy); Wed, 25 May 2016 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ctMCj
	ZRDgaAXGcRqsd8bCH8ezXw=; b=R6vFIdJvKbujdOU7oGZXGDnooREMmrH7f66hL
	cwdA+U94bQfZGFUKCQ3cHspMc7sA8ceDf4jHaIMS3boyupgJCT5TnAWt4cVfQxHG
	tl6dPvmjgs+OdaKh2KUZmzppY58uRcdfg8sEKkxMLogCpEZGuFZYDaKky9PEqhtY
	MZzIRU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ctMC
	jZRDgaAXGcRqsd8bCH8ezXw=; b=m8l8Fv5Ud8tlcXmJBAIbP5gY0lwCfhQuRh1N
	Ht7woA8eNhaKlSPbynpunPypjHi37qE3HvkV4ycvj87NshLG4rqgvbyaP6FQmRCj
	hyDXRU3uGy42yYs9qcNw+858wZukqBpteT/av1rL2DidQ8TslDpxx4f5L1y7z6jp
	CNWcOpI=
X-Sasl-enc: wQ3rjjVpbsJYCLu2vL4fSpoDxi/XVOaS0dr3Ru2RX0N9 1464205711
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 41151F2A06;
	Wed, 25 May 2016 15:48:31 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 15:48:24 -0400
Message-Id: <1464205704-26377-3-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
References: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH 2/2] doc: Document use of Perforce fetcher
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
X-List-Received-Date: Wed, 25 May 2016 19:53:35 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
---
 .../bitbake-user-manual-fetching.xml               | 72 +++++++++++++++++++++-
 .../bitbake-user-manual-ref-variables.xml          | 11 +++-
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index f168cfa..0d8bec0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -716,6 +716,75 @@
             </para>
         </section>
 
+        <section id='perforce-fetcher'>
+            <title>Perforce Fetcher (<filename>p4://</filename>)</title>
+
+            <para>
+                This fetcher submodule fetches code from the
+                <ulink url='https://www.perforce.com/'>Perforce</ulink>
+                source control system.
+                The executable used is specified by
+                <filename>FETCHCMD_p4</filename>, which defaults
+                to "p4".
+                The fetcher's temporary working directory is set by
+                <link linkend='var-P4DIR'><filename>P4DIR</filename></link>,
+                which is usually <filename>DL_DIR/p4</filename>.
+            </para>
+
+            <para>
+                To use this fetcher, make sure your recipe has proper
+                <link linkend='var-SRC_URI'><filename>SRC_URI</filename></link>,
+                <link linkend='var-SRCREV'><filename>SRCREV</filename></link>, and
+                <link linkend='var-PV'><filename>PV</filename></link>.
+                The p4 executable is able to use the config file defined by your
+                system's <filename>P4CONFIG</filename> environment variable in
+                order to define the Perforce server URL and port, username, and
+                password if you do not wish to keep those values in a recipe
+                itself.  If you choose not to use <filename>P4CONFIG</filename>,
+                you can specify the <filename>P4PORT</filename> value,
+                which is the server's URL and port number.  If you wish to
+                specify a username and password directly in your recipe, do so
+                within <link linkend='var-SRC_URI'><filename>SRC_URI</filename></link>.
+            </para>
+
+            <para>
+                Here is an example which relies on <filename>P4CONFIG</filename>
+                to specify the server URL and port, username, and password, and
+                fetches the Head Revision:
+                <literallayout class='monospaced'>
+    SRC_URI = "p4://example-depot/main/source/..."
+    SRCREV = "${AUTOREV}"
+    PV = "p4-${SRCPV}"
+    S = "${WORKDIR}/p4"
+                </literallayout>
+            </para>
+
+            <para>
+                Here is an example which specifies the server URL and port,
+                username, and password, and fetches a Revision based on a Label:
+                <literallayout class='monospaced'>
+    P4PORT = "tcp:p4server.example.net:1666"
+    SRC_URI = "p4://user:passwd@example-depot/main/source/..."
+    SRCREV = "release-1.0"
+    PV = "p4-${SRCPV}"
+    S = "${WORKDIR}/p4"
+                </literallayout>
+            </para>
+
+            <para>
+                Here are a few behaviours worth mentioning:
+                <itemizedlist>
+                    <listitem><para><link linkend='var-SRC_URI'><filename>SRC_URI</filename></link>
+                        should always end in <filename>/...</filename> to specify
+                        fetching of all directories and files below the given depot
+                        path.  Fetching of an individual file does not currently
+                        work correctly.</para></listitem>
+                    <listitem><para><filename>S</filename> should always be set
+                        to <filename>"${WORKDIR}/p4"</filename> in your recipe.</para></listitem>
+                </itemizedlist>
+            </para>
+        </section>
+
         <section id='other-fetchers'>
             <title>Other Fetchers</title>
 
@@ -726,9 +795,6 @@
                         Bazaar (<filename>bzr://</filename>)
                         </para></listitem>
                     <listitem><para>
-                        Perforce (<filename>p4://</filename>)
-                        </para></listitem>
-                    <listitem><para>
                         Trees using Git Annex (<filename>gitannex://</filename>)
                         </para></listitem>
                     <listitem><para>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index 4d06ff9..f59fe85 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -52,7 +52,7 @@
        <link linkend='var-MIRRORS'>M</link>
 <!--               <link linkend='var-glossary-n'>N</link> -->
        <link linkend='var-OVERRIDES'>O</link>
-       <link linkend='var-PACKAGES'>P</link>
+       <link linkend='var-P4DIR'>P</link>
 <!--       <link linkend='var-QMAKE_PROFILES'>Q</link> -->
        <link linkend='var-RDEPENDS'>R</link>
        <link linkend='var-SECTION'>S</link>
@@ -1748,6 +1748,15 @@
 
     <glossdiv id='var-glossary-p'><title>P</title>
 
+        <glossentry id='var-P4DIR'><glossterm>P4DIR</glossterm>
+            <glossdef>
+                <para>
+                    The directory in which a local copy of a Perforce depot
+                    is stored when it is fetched.
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-PACKAGES'><glossterm>PACKAGES</glossterm>
             <glossdef>
                 <para>The list of packages the recipe creates.
-- 
2.8.1


