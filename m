Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id 955706FFA4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jun 2016 13:44:43 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 00E4921722;
	Thu,  9 Jun 2016 09:44:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
	by compute5.internal (MEProxy); Thu, 09 Jun 2016 09:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=FFmDB
	lnSAy4ElE1uRZlTV8P1/sk=; b=cbzIYB2aH+gNfrbLLre2Bq7BoPQtUuliXqly9
	kwbEX2ivyWZTboTbY2tqq2O9sI1PxnP04L4e2GOtCjp06Ovc9gjW233q2qccVHG2
	UrqUIq21fdXk5PEVBlCst/8pvkbU4t2I1WQOrk77aqRvm5xliHvTlj06F9PQUv+I
	oUijco=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FFmD
	BlnSAy4ElE1uRZlTV8P1/sk=; b=kWvd63kKdQNI3qqc6M2zaPSi6Div5fgUjIHH
	KWTuEaL1Jg06Cwr+Aih4Zr4jsW3Deo3ClDg7RsdXHbf+IQGjfIGttWcAzOTDqxaK
	/5xTZkexAYlRlagf1Ww9YbQN/Iq1CSAWafDg/feB2mu/FDAaNtWP8u7pxsnVVXS0
	X8jdDOU=
X-Sasl-enc: hMb0NnpfTdnx+4AYYljNwXH2yIru0X9+sVL1apkni5bn 1465479883
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 37A70CCDA7;
	Thu,  9 Jun 2016 09:44:43 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2016 09:44:09 -0400
Message-Id: <1465479849-28634-3-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
References: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH v2 2/2] doc: Document use of Perforce fetcher
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
X-List-Received-Date: Thu, 09 Jun 2016 13:44:44 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
---
 .../bitbake-user-manual-fetching.xml               | 68 +++++++++++++++++++++-
 .../bitbake-user-manual-ref-variables.xml          | 11 +++-
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index f168cfa..65acb35 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -716,6 +716,71 @@
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
+                which defaults to <filename>DL_DIR/p4</filename>.
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
+                or to explicitly set variables which <filename>P4CONFIG</filename>
+                can contain, you can specify the <filename>P4PORT</filename> value,
+                which is the server's URL and port number, and you can
+                specify a username and password directly in your recipe within
+                <link linkend='var-SRC_URI'><filename>SRC_URI</filename></link>.
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
+                Here is one behaviour worth mentioning:
+                <itemizedlist>
+                    <listitem><para><filename>S</filename> should always be set
+                        to <filename>"${WORKDIR}/p4"</filename> in your recipe.</para></listitem>
+                </itemizedlist>
+            </para>
+        </section>
+
         <section id='other-fetchers'>
             <title>Other Fetchers</title>
 
@@ -726,9 +791,6 @@
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


