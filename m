Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 505DF60D2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 09:52:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s069qfDp020446
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 6 Jan 2014 01:52:41 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 6 Jan 2014 01:52:41 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 6 Jan 2014 04:52:36 -0500
Message-ID: <893916267ab5583320eae46f18c7da64e53753ff.1389001793.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1389001793.git.liezhi.yang@windriver.com>
References: <cover.1389001793.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: usermanual.xml: fix a typo
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
X-List-Received-Date: Mon, 06 Jan 2014 09:52:40 -0000
Content-Type: text/plain

Fixed:
"should created" -> "should be created"

[YOCTO #5703]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/doc/manual/usermanual.xml |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
index 6781a71..749ee98 100644
--- a/bitbake/doc/manual/usermanual.xml
+++ b/bitbake/doc/manual/usermanual.xml
@@ -241,7 +241,7 @@ addtask printdate before do_build</screen></para>
                 <title>Task Flags</title>
                 <para>Tasks support a number of flags which control various functionality of the task. These are as follows:</para>
                 <para>'dirs' - directories which should be created before the task runs</para>
-                <para>'cleandirs' - directories which should created before the task runs but should be empty</para>
+                <para>'cleandirs' - directories which should be created before the task runs but should be empty</para>
                 <para>'noexec' - marks the tasks as being empty and no execution required. These are used as dependency placeholders or used when added tasks need to be subsequently disabled.</para>
                 <para>'nostamp' - don't generate a stamp file for a task. This means the task is always rexecuted.</para>
                 <para>'fakeroot' - this task needs to be run in a fakeroot environment, obtained by adding the variables in FAKEROOTENV to the environment.</para>
-- 
1.7.10.4


