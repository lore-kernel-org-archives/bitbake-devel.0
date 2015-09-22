Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 0F28773D17
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 02:41:02 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so136336970pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=EIhoFPrdVPjukzTB1aUPDegQlwnFaTa6Y14Rt9mlX3o=;
	b=yX7u2Qk7hrmiufMT3EHU+x+3fIllXFiMDG+wRsvJOpUSYaE7aLkfxMhZPgPZBb02Bf
	Gs/b5EjHvOUt2BEK9fTZvAqWVimfy2f8jyJ1v2wBuf93F5sJ/czhdljDa79BHaolGR3T
	jU9I1kwt4pMeUwcyxBRGdsTsmHuA7izQSLdgHqjopO4gDlv+tGkSiOxVS0ts90gqJcns
	JEPZA5BJPhLBPgYSar9FyZGUZCySn9mrnh1oVOrT4/2G+NVL8n01wClAs4A21+y90Xf4
	HIctrWXydl9RKc/2doGVhyiMW01jUnlyI1PRcUc432S7UyctILEaQQ6iPUJa6V3x18SQ
	BpcQ==
X-Received: by 10.66.121.163 with SMTP id ll3mr28424852pab.146.1442889662666; 
	Mon, 21 Sep 2015 19:41:02 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	fk8sm27289218pab.33.2015.09.21.19.41.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Sep 2015 19:41:02 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 19:42:27 -0700
Message-Id: <cover.1442889648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] Add fake entry to Target_File for filesystem root
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
X-List-Received-Date: Tue, 22 Sep 2015 02:41:03 -0000

The files-in-image.txt file is produced by bitbake after an
image is created, listing all the files in the image.
However, this list doesn't include the root directory ('/').

Fix this by creating a fake entry for the root directory
in the Target_File table, so that the direct subdirectories
of / can be assigned a parent. Note that it doesn't matter
that the root is faked, as its properties are never shown
in the directory structure tree.

The following changes since commit 7b86c771c80d0759c2ca0e57c46c4c966f89c49e:

  bitbake: bitbake: bb.fetch2.git: Import errno module (2015-09-19 22:38:44 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/20150921_add-fake-root-to-Target-File
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/20150921_add-fake-root-to-Target-File

Elliot Smith (1):
  toaster: Add fake entry to Target_File for filesystem root

 lib/bb/ui/buildinfohelper.py | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
1.9.1


