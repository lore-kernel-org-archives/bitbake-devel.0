Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 186F977002
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 23:20:27 +0000 (UTC)
Received: by pasz6 with SMTP id z6so515975pas.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=O2AaGzPBXRjkDb4+H7VvzDT98ptWtgNDuo0RCl60Qbo=;
	b=Ta+pCxluZRBanJbZr+ysq/KDWWaxu+y3uuK/8porS6T3jDoDidYyX5TXomu8UFhDPc
	RN0N3GJGJYT7MpB1I7yIico32z0S5UYxkJQyWupT1Sb/vTmg/dfZ47kyuwWBu6Bp2Rr2
	TPhGwSxypokpLpI8LlxqCIQ1XKREDr8rHGGGtzbZBL+mb18Y7gHlzm3HmnrFhHdr4HBM
	GL4qE56USJtXykYWe+vxEjCvkCX0c0rjVgBZhmiMZjHhH+Bj5cUVhc3PtnM9zaJ2JMew
	xJHE+KGIY/g15gaWp/Y3xOSeAdQ50qFoepaUaLOxbtTWS/JhJQp5f2yDiG6rdmFEcveF
	ZVNg==
X-Received: by 10.66.184.203 with SMTP id ew11mr93585pac.24.1445296827325;
	Mon, 19 Oct 2015 16:20:27 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id ir5sm88628pbc.13.2015.10.19.16.20.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 19 Oct 2015 16:20:26 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Oct 2015 16:22:39 -0700
Message-Id: <cover.1445296793.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] toaster: Make LogMessage a TextField so the length is not an issue in mysql
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
X-List-Received-Date: Mon, 19 Oct 2015 23:20:28 -0000

Log messages can be quite log so use a TextField rather than a char
field with max length of 240. mySQL is especially picky about field
lengths and will cause an exception of the log is too long.

[YOCTO #8475]
-b

The following changes since commit fd49c611b7a52b233a9c030fb4946b9993369368:

  cooker: preserve pre and post configs (2015-10-19 13:59:16 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/2015-10-14_LogMessage-textfield-for-length
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/2015-10-14_LogMessage-textfield-for-length

Michael Wood (1):
  toaster: orm Fix restrictive LogMessage message length

 .../0028_auto__chg_field_logmessage_message.py     | 345 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   2 +-
 2 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py

--
1.9.1

