Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id A80E6770B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Oct 2015 21:18:07 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so87164371pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Oct 2015 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=LOoSQ3VqL8aMP22kKfo18KFNe93RlwFCriSX5y1S3FU=;
	b=ZwPvDoH+n8ZBYMNjWqI4uCsuMrgr4YKMSnRguABXfrDj6Zj03doKMcmJZQi55mTRkJ
	3A2hBs5r3k31FQ2AkGqTtcyRlugvksB9n/dVtHtQq4985HRTJ93q0GyQg+dVqM9TLlM4
	y/zIbHJEfoptvyHvSmUwiT+r/yKfeetjVC/8h5z5O1NNRemdGar/cEZmZa+OeKvVvdHY
	4ZaDzgQF69DRpu2WlIZb0zqDE3g38QM/FHl2C28p8P63EGXbjKtQLUjiU18JOMbHUkLN
	GkxC5RJg4K63/QfO//6IgLR6mAwYD4Q18n1+ILLVjrNjIt2WdTuc/TwaIKFqc1PaJGta
	blxA==
X-Received: by 10.66.228.97 with SMTP id sh1mr14758390pac.91.1443734287883;
	Thu, 01 Oct 2015 14:18:07 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	xd10sm8513493pab.25.2015.10.01.14.18.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 01 Oct 2015 14:18:07 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Oct 2015 14:19:49 -0700
Message-Id: <cover.1443734209.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/2] remove empty recipe names #7969
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
X-List-Received-Date: Thu, 01 Oct 2015 21:18:09 -0000

This removes the receipes with empty names from toaster.

The following changes since commit 7b10ae122d46891c734e786358ea5f36760e8d5e:

  toaster: Fix broken test case (2015-10-01 10:42:16 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2015-10-1_nameless-recipes-7969
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2015-10-1_nameless-recipes-7969

Ed Bartosh (2):
  toaster: delete recipe if it can't be saved
  toaster: exclude recipes with empty names

 lib/toaster/orm/models.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1


