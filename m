Return-Path: <freesilicon@gmail.com>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
	[209.85.128.193])
	by mail.openembedded.org (Postfix) with ESMTP id 49624782C0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 15:43:57 +0000 (UTC)
Received: by mail-wr0-f193.google.com with SMTP id l24so2177599wre.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=J59KTKqGcj7N13uU8ljPjdkgdi4+W+RaERHPviSBETY=;
	b=kiR2YSFcyNO+nJm6lfZJjouc+1lmC0ZThpMr19YpvfTbRo63XOc40Todbh2eN3md9Q
	D1iT1QkiVgo9YkIrmGC+6QQ8TEJc52a5A1aw1CW2lACafr/3I4DKNL7hasgEpUxVzAPO
	38yt3FwZ7mD3iISx23h61J86GChFNy8bW63hQJV1tBbUEvZmDw5oi/pULe6gUwpTzGhp
	WKlA4uYAq9FWDkeVvFio6ddq5rD9hZ92SoYMhrw/7EtJQ9IFz8c8ycWfP2kA1vnnIqog
	AUqhNKylLHMTkgSM90TCENl6/ws6z93KHHgA5wOnbxsjEhm7f3CXqEB/QhI5FCvwQlxz
	BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=J59KTKqGcj7N13uU8ljPjdkgdi4+W+RaERHPviSBETY=;
	b=I82k5+ZhdjLFFRxlVAhX4QTKI9b04C+j5pgjsjmE6uRJOW+eMP1QB52Khz5y6F+nMx
	WFS6ISkQkuAt8oMU8BgxCmknPJfIX1eMIJbNsDuxYkFVCQ6yaLXv8SmKpiIdryhkaMWU
	MkOO8Bn/vs9H9Lc+P5ln1fPnzpTo3zgXNdkZe9xB5iPSeIuwd99pmJ8mBGNonazK6Zjr
	iSkHY3svTxkJEUanVrQP/3SQJCvCKNcz/BX7OVKzuHzedvSQ3/NhZzuzdNE5GnK2sD1I
	QeziVhVhWhG3XL/2jDKYikglCGMIyPm/PF4CL4beTRio+1GvbkpY9VvbbOrRsYYeYYcG
	rViA==
X-Gm-Message-State: AMCzsaV9F6NVLBxoxk1HEJ72JRmY/SD+PmD4gwUSita41rljYPN4kZLg
	yFiJ5WTFUcNUpnbtWTE2hhH+B1Wy
X-Google-Smtp-Source: ABhQp+T3aA+3N33s8vua4QqmB6euKK5JB1RUAlF4fCZ/2fzZchmSdghqMBnUjl49Fc6+Hx3ahNL9Ag==
X-Received: by 10.223.153.45 with SMTP id x42mr4061228wrb.212.1508255038376;
	Tue, 17 Oct 2017 08:43:58 -0700 (PDT)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	y129sm9932991wmg.42.2017.10.17.08.43.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 08:43:57 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Oct 2017 17:43:16 +0200
Message-Id: <20171017154316.18464-3-freesilicon@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171017154316.18464-1-freesilicon@gmail.com>
References: <20171017112748.10968-1-freesilicon@gmail.com>
	<20171017154316.18464-1-freesilicon@gmail.com>
Subject: [PATCH v2 2/2] bitbake-user-manual: update git fetcher
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
X-List-Received-Date: Tue, 17 Oct 2017 15:43:58 -0000

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
2.14.2


