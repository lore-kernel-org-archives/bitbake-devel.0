Return-Path: <nicolac76@yahoo.fr>
Received: from sonic307-54.consmr.mail.ir2.yahoo.com
	(sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	by mail.openembedded.org (Postfix) with ESMTP id 89D7B71AB4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jan 2018 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
	t=1516961145; bh=LxNUmjijfLH7zDIlnYbIjAr+CudKxon9v+xe2IhipQE=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=orSt8SzdFOB3jwqQSCN7y/trdbV9Wr3NIvW9GS8XxTkxPuOTK+pCy/Zieo+QisC5PYPtxLMeZ0Y1VZimMDV6SwtIWM+BwqxJZIWrsYaqOcueRGRtHQo5N9+WsXF76H93A1Pj/Bj86Y/ZaSwc4MNZuYMcmgCqARVkPEZCDkvRZC+xShFJGImuQoqFe/Xpl1Xn4E1QwPxyr9Ju+CRti0zd9OSAkvZPxbXStgAVXo/P1lT53Oke6idll2kDYPMEGsttgv5kDZMg3eWriGBFz/iGwMEs6fePC3N5CSsysgnkHrtoSMQkWeCu0d5h/FC7Iph5cWAWn/e9sGNHMU88rSEXTg==
X-YMail-OSG: 1Tx_fjMVM1kP22x17ly4lpp5EpQZcpRzhZdfd62.rjF9dKwJqFrkGorRnGVVkAE
	B1aK7HR73BkH_6eOLl3hsNiyVEhD4ZiNi.g1TTtgAvcbJCRFQy24Cr57iKKW1IVmhN9qHtxZ6BGA
	yx7_67NY64XdLoI53QPeeLIhjOEVNqARQJ6pfis5a_j07mcnjSzT1rQ.kwn8ifQIP0o3v2x0rIRR
	PjFIExUIKfSWxPtkO2NY.9I9Odqn.gBezxEziXvZIQxOqQlHh62AAnMhfxeFEyVLXwj_0WxpAcd9
	dvePr25Dxbjk0jjqene.JLxLVQWWmLU1uz6rJJI6TgC24HK_EvmEpz.Hfu5hlyZJsXmz7OCFVhtU
	BLFuvE1twvJUJw_rUBsjvYfJIgUve5Pqli5kcclQEjTQJo9IDRWcERFOEEnSKETA_AHOBjvXtoal
	CUeqohrBUsb8K8I7F1itrkme5rK3hDRctHaMPugXlxYljDYdWAcMA1atatK9AizIg6di0FD7BO0p
	Z875in4Mm4sc2MgVqWAFEcSHviXY-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic307.consmr.mail.ir2.yahoo.com with HTTP;
	Fri, 26 Jan 2018 10:05:45 +0000
Received: from smtpgate105.mail.ir2.yahoo.com (EHLO Achlys.localdomain.com)
	([217.146.188.189])
	by smtp404.mail.ir2.yahoo.com (JAMES SMTP Server ) with ESMTPA ID
	3aa7bfc279f9436fca1dce2ebfba1e94; 
	Fri, 26 Jan 2018 10:05:43 +0000 (UTC)
From: Nicolas Cornu <nicolac76@yahoo.fr>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Jan 2018 11:05:36 +0100
Message-Id: <20180126100536.29450-1-nicolac76@yahoo.fr>
X-Mailer: git-send-email 2.14.3
X-Mailman-Approved-At: Sun, 28 Jan 2018 13:49:37 +0000
Cc: Nicolas Cornu <nicolac76@yahoo.fr>
Subject: [PATCH] bitbake-user-manual: Addeds support for the repo Fetcher
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
X-List-Received-Date: Fri, 26 Jan 2018 10:05:44 -0000

Added a new repo Fetcher section in the same spirit as the existing
sections for other supported fetchers.  Changes included the new section,
removal of the bulleted item that mentioned this fetcher as an
"additional" fetcher, and the creation of a new variable in the glossary
named REPODIR.

Signed-off-by: Nicolas Cornu <nicolac76@yahoo.fr>
---
 .../bitbake-user-manual-fetching.xml               | 37 ++++++++++++++++++++--
 .../bitbake-user-manual-ref-variables.xml          |  9 ++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index c721e86e..0787f884 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -777,6 +777,40 @@
             </para>
         </section>
 
+        <section id='repo-fetcher'>
+            <title>Repo Fetcher (<filename>repo://</filename>)</title>
+
+            <para>
+                This fetcher submodule fetches code from google-repo
+                source control system.
+                The fetcher work by initiating and syncing sources of the
+                repo into
+                <link linkend='var-REPODIR'><filename>REPODIR</filename></link>,
+                which is usually
+                <filename><link linkend='var-DL_DIR'>DL_DIR</link>/repo</filename>.
+            </para>
+
+            <para>
+                This fetcher support the following parameters:
+                <itemizedlist>
+                    <listitem><para><emphasis>"protocol":</emphasis>
+                        Protocol to fetch the repo manifest (default: git).
+                        </para></listitem>
+                    <listitem><para><emphasis>"branch":</emphasis>
+                        Branch or tag of repository to get (default: master).
+                        </para></listitem>
+                    <listitem><para><emphasis>"manifest":</emphasis>
+                        Name of the manifest file (default: default.xml).
+                        </para></listitem>
+                </itemizedlist>
+                Some example URLs are as follows:
+                <literallayout class='monospaced'>
+    SRC_URI = "repo://REPOROOT;protocol=git;branch=some_branch;manifest=my_manifest.xml"
+    SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml"
+                </literallayout>
+            </para>
+        </section>
+
         <section id='other-fetchers'>
             <title>Other Fetchers</title>
 
@@ -795,9 +829,6 @@
                     <listitem><para>
                         Secure Shell (<filename>ssh://</filename>)
                         </para></listitem>
-                    <listitem><para>
-                        Repo (<filename>repo://</filename>)
-                        </para></listitem>
                     <listitem><para>
                         OSC (<filename>osc://</filename>)
                         </para></listitem>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index d89e123e..88bec480 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -2089,6 +2089,15 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-REPODIR'><glossterm>REPODIR</glossterm>
+            <glossdef>
+                <para>
+                    The directory in which a local copy of a google-repo
+                    directory is stored when it is synced.
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-RPROVIDES'><glossterm>RPROVIDES</glossterm>
             <glossdef>
                 <para>
-- 
2.14.3


