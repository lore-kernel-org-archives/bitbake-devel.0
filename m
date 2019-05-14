Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id 6B6D66C216
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 May 2019 04:40:32 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id u17so8398059pfn.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 May 2019 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=M5fM1RvAJ1evn5U0qgYblCTJBMOxkQ4fJ5QdrfhK4HA=;
	b=AAE2pya66WCONoHGJHvdqUubSdQUK/G61CYc8Trlu54Y28uMRGx+rgdjyqfOhma8pF
	9vyWOZbM+mNf2+Ry6KflzdcS4Cb/BLbWuAobrdTj1CgDHDOwYZxkL7dSM5OfehfZEG11
	ZwL4sUHkbEUGeBnZU02nffe3tQC+wVm0YMD81oPATM6IyM7bilXBzZ8SCTxuGTsEsV4O
	0jqbUJ7uyutE5MlHYcWxzBGOLMqOAyrbcGYDxhX6Zcu8+4L9Q9e+L6RBpsy8ZYuGSS1b
	c4oCLM6tOoO88mwhf5QYQDOXynUkLsYyyZtEo+B6BTOBML7kOGLU+X0TUrLRQF2LfjM6
	O4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=M5fM1RvAJ1evn5U0qgYblCTJBMOxkQ4fJ5QdrfhK4HA=;
	b=BD1gJsa3QIZS6eJW5ZfjzRhvhrPPnkBGIiO+hpud8+n04dHl8WMAvmuGNx64pecDVP
	GlejmqnIB4LnnlaCR/zO5oQ/y7KKLTV/+lpxC06hh3yobfpBQQ6oVdIBqZG/FOOjwSve
	v6DQ2bcJm2FTMjSYZutjzjoJhqofeeEYYLhK2f61054Yu8PVGCNoHi9eGXN5xQhAFWiD
	lTeCIqcfyMHSEjh3PvyaefWO16gpr+Aalliw0M3NRiB6hjVkAqYR5E//icm6sD1Nnm4a
	cKK7icPhWCGrMEJnCce94RE3Xska48aQrIL4YHIHznhuztEJB1Q1QBMvKNLjrnqfbAhS
	n1xA==
X-Gm-Message-State: APjAAAW0oUWN0fbhVUjZkP6w4knfksiJzPw0EfC7Lv6ZoYjt269LnALU
	xNdb3BWy4mLQ9AFj+yJ+lu6oUfiT
X-Google-Smtp-Source: APXvYqxbUoRILXfaEqaw8RMHfZLuWpPIyJFBJzCjNMPvTogWw0IU4tWkBRsgOfE/Rmt4ajNZokTbMA==
X-Received: by 2002:a62:68c4:: with SMTP id
	d187mr20800026pfc.245.1557808833241; 
	Mon, 13 May 2019 21:40:33 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:d909:eb3d:d2ab:fd1d])
	by smtp.gmail.com with ESMTPSA id
	132sm18371323pga.79.2019.05.13.21.40.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 May 2019 21:40:32 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 May 2019 21:40:26 -0700
Message-Id: <cover.1557808320.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/2] bitbake 1.42 next patch review
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
X-List-Received-Date: Tue, 14 May 2019 04:40:32 -0000

Please review these changes for the next 1.42 update

The following changes since commit cd8d4ec8ec6650b756dafe750436528f736b3938:

  bitbake-user-manual: Added section on modifying variables (2019-04-23 16:33:48 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.42-nmut
  http://cgit.openembedded.org/bitbake-contrib /log/?h=stable/1.42-nmut

David Reyna (1):
  toaster: update to Warrior

Naveen Saini (1):
  bitbake: fetch2/git: git-lfs check

 lib/bb/fetch2/git.py                 | 25 +++++++++++++++++++++++++
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 3 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.7.4


