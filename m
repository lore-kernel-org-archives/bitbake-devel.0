Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 2856C78686
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 15:25:11 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id z3so5783029wme.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nqtqLS+P33tQMGvQMfRLvdLkBATrigZgScQCUq2s4B4=;
	b=Dt8U2Yn6fAxgqmBytZJRiedrQuhTeQFMsBEfFXkIGw9AG64p+ZaZiJWIIOY121AfzR
	7frrv3ulKCoyMLk9/bBkgtVFHp3DAPqFX/D2xOxI4IrrQIv1WRIyZ1X2zpeItEya6+2Z
	6djwlbfFTqManqK6U1PBr9Ji63bU9vGV+Svx9qDpHfsY1Jheg/LYsEBzxuqL1p6xWScv
	2r3qjk7vnksRfobDxRlRS1Ey5iU/tv3zea5e8UtrUODsDeTLxqlJcgDEQ9QLb2o2Y5lr
	br4nUv4I/Ra6cywBaxpowQTYuYEr3CBUQapCcNyPlhPffwE2hF5QVme2wGuSOHDdgFVV
	/A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=nqtqLS+P33tQMGvQMfRLvdLkBATrigZgScQCUq2s4B4=;
	b=VIT/aWBZntwh/X/YrguOWA4m995e/j3/tR5vtVU4PvPgulaCV6kPU0c8KoI4XKf7cg
	FtzQ5IywYmCFKkZHFByhXSolNTnR7X2jTkQBNDc8Fp+mTxLA1wCg3QRpwAEMNxthtMew
	iL/P6uu+hRZurnrBwigeevl8fk6sip2DUucXnLi5/i6WrT+b2i7B3fJgTp9kXuefjbyw
	Qujz+VRR8nbYFvQFj5ppaIwCg26/m1+YgIobHqIaadzIOzZLhJxmD4EcDHVOt/8aEWgz
	ah3USmtUO7rg8onHj8j3XSVub54aBPWuI6lEHM0VrAkCo0cy5vy41NWKEFszYTUFqxNh
	LICg==
X-Gm-Message-State: AJaThX5q5K737/ytQn5Kmfrk87hK2UykeENzMVvOehsVAoeBj3gCx6WS
	4tqyM1bKS+xEbLoSJVCsCYhPcxzK
X-Google-Smtp-Source: AGs4zMY13Lmsyok3+DS1ojJ+xWEi/jiQA7QQcMkFAOI+k5Ima9vftPi4CIGq+3aIawY0JDg4QqlGdg==
X-Received: by 10.28.155.18 with SMTP id d18mr6860730wme.107.1510586712418;
	Mon, 13 Nov 2017 07:25:12 -0800 (PST)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	l16sm20192454wma.19.2017.11.13.07.25.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 Nov 2017 07:25:11 -0800 (PST)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Nov 2017 16:24:04 +0100
Message-Id: <20171113152404.21785-3-freesilicon@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113152404.21785-1-freesilicon@gmail.com>
References: <20171113151617.20905-1-freesilicon@gmail.com>
	<20171113152404.21785-1-freesilicon@gmail.com>
Subject: [PATCH v3 2/2] bitbake-user-manual: update git fetcher
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
X-List-Received-Date: Mon, 13 Nov 2017 15:25:12 -0000

Add precisions for the multiple branches support in git fetcher. This
support was documented in source code but not in documentation, so
include it.

Signed-off-by: David Vincent <freesilicon@gmail.com>
---
 .../bitbake-user-manual-fetching.xml               | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index c721e86e..353e9a3c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -565,8 +565,26 @@
                     <listitem><para><emphasis>"branch":</emphasis>
                         The branch(es) of the Git tree to clone.
                         If unset, this is assumed to be "master".
-                        The number of branch parameters much match the number of
-                        name parameters.
+                        This option also supports multiple branch fetching, with
+                        branches separated by commas.
+                        <note>
+                            <title>Note</title>
+                            <para>
+                                In multiple branches case, the name option must
+                                have the same number of names to match the
+                                branches, which is used to specify the
+                                <link linkend="var-SRCREV"><filename>SRCREV</filename></link>
+                                for the branch.
+                            </para>
+
+                            <para>
+                                After checkout, all branches will be created
+                                with their tip pointing to the corresponding
+                                <filename>SRCREV</filename>. In particular, the
+                                current checked out branch will be the first
+                                provided in the list.
+                            </para>
+                        </note>
                         </para></listitem>
                     <listitem><para><emphasis>"rev":</emphasis>
                         The revision to use for the checkout.
@@ -589,12 +607,24 @@
                         By default, the path is <filename>git/</filename>.
                         </para></listitem>
                 </itemizedlist>
+            </para>
+
+            <para>
                 Here are some example URLs:
                 <literallayout class='monospaced'>
      SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
      SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
                 </literallayout>
             </para>
+
+            <para>
+                Here is an example URL using multiple branches:
+                <literallayout class='monospaced'>
+     SRC_URI = "git://git.oe.handhelds.org/git/vip.git;name=master,feature;branch=master,features/feature1"
+     SRCREV_master = "ad8b1d659ddd2699ebf7d50ef9de8940b157bfc2"
+     SRCREV_feature = "06c0dbdcba374ca7f92a53d69292d6bb7bc9b0f3"
+                </literallayout>
+            </para>
         </section>
 
         <section id='gitsm-fetcher'>
-- 
2.13.6


