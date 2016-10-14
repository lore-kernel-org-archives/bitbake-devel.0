Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 54BD571B15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:28:09 +0000 (UTC)
Received: by mail-pf0-f179.google.com with SMTP id r16so27708660pfg.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=WoA/XfFcLKj4laz1WKxy+1xxbyLcuPF8LsKCTalP24Q=;
	b=gCZ6T97BbbJzncDGubPrs4+iG7cOIzo0BAugUOWwto0ejjQHqS1GDu2F87XyqGP4MK
	PYPsFbewfpcnnjLpHJ4GuJtItQDusCdgkeOjqhsUSYPcXsoowVkADFN2Wz+W2FensYgA
	cL3YI9CCwbH0NpaPuODQFn49FxUqHXoFqpYBCU1QJy4OUJHf1swzvsz0x7KgNLv4Eedl
	ujijY4CDx6dZOIoIo030aPD3k9S6TxqPrtQPDk40aHWNr9XdsC4nybKNmys2YZ2IMKU6
	IcDpkpjTFCwOdu7Mz2WxC8WsIsIHXTO3a39tFDRUw38e+r2xnlC3TqbfRixspvqqrt8m
	6Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WoA/XfFcLKj4laz1WKxy+1xxbyLcuPF8LsKCTalP24Q=;
	b=YQV7jVXPodPxvXPOZCFQWd1NmazNJ9HSSIra7MN+uuS7295q50Gp+q9MASJripN07x
	IYIQWGpkDdj47zpYmiS2z9H+/3uKeFdDtfaMYSYdk0IiG9OGclxKp8TCNmDj0MOs/RVL
	0TID1Qt4aHRUJ02zX339DKZWXw+CKSAhMWLYV1BgJRXQq22V1UqfpKyAfcySp2a6KIHJ
	eCOct1AytA+wxZAKRsZg9YL55wjEVSxPBferCLzzPXVj68C9dY5VvZ0s8m7NeJKaSJgX
	QfNHx8dyXpo5NfC6ZZnnQ3rt28Zem4DRmZLko5SX9vpekcowBdceZEw7s9BXr1O++AZx
	9Szw==
X-Gm-Message-State: AA6/9RnlVW+8SuttPWAkko6KKYfbomrkJUeY0SPkcMGyju2Ef/XyHEGL/72UeR4X5LXdsk8e
X-Received: by 10.99.184.25 with SMTP id p25mr7566897pge.120.1476458891440;
	Fri, 14 Oct 2016 08:28:11 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	n7sm28386090pfn.62.2016.10.14.08.28.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Oct 2016 08:28:10 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Oct 2016 16:27:58 +0100
Message-Id: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/3][1.32] Add morty/2.2/1.32 release information to toaster
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
X-List-Received-Date: Fri, 14 Oct 2016 15:28:10 -0000

From Brian:

This changes the fixtures for toaster in Morty so that
1) We only allow the morty branch for new projects
2) we default to morty when making a new project.

This release we do not support building older releases due to
the Python 2.7 -> Python 3 change Morty represents.

This patch set updates both the poky and oe-core fixtures.

Note: this only applies to the Morty branch and should *not* be applied to
master.

-bavery

Changes by me:
 - Fix branch name in oe-core for bitbake
 - Add "2.2" as part of the description


brian avery (3):
  toaster: Update oe-core fixture for Morty release
  toaster: Update poky fixture for Morty release
  toaster: Update default release to Morty

 lib/toaster/orm/fixtures/oe-core.xml  | 16 ++++++++--------
 lib/toaster/orm/fixtures/poky.xml     | 12 ++++++------
 lib/toaster/orm/fixtures/settings.xml |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.7.4


