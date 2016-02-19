Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 0BE26731DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:15:58 +0000 (UTC)
Received: by mail-pf0-f169.google.com with SMTP id e127so44687738pfe.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Phhwz0QfjGAym+oBBnEtBJAOWvnSmKPYTsmHzFTL80o=;
	b=d+cMM8eu3tVQLj0RTvgHKYxP/sxeVtvlVRQjkP5rL5AkrfriJyH907MwHY2zPZCu8S
	vv1SPSbX63I4PnoNZAQWEies3G7XTydv4BNo8JjLdHrbKt/mScFjGcqBQaARLr1xOiUI
	SBdVbGkv9ShEwm/CJxKYJVGiZZD3bwDhDs4y/4zWgPbqncfmvXTRIwsdXLTbzR5YSB2I
	d7xeV3HGAXwz0Q9MK5T7e9MpYOdwzZcfjJ6O53dzlBfRTp2W5QILn/1l1WcqeGQF1Tvq
	maJ7sIEEqv1FmN+6A5U6pDf6V5Uw49zux63m0KccL3MY+Bzu0f5P6QIlXMH+4UwRMDfO
	i/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Phhwz0QfjGAym+oBBnEtBJAOWvnSmKPYTsmHzFTL80o=;
	b=nFZNRy3ei5mk6fHa0Y04c3N+md+eba6hg4PaOWMWNMZjxZgNVcIyhe0qCeGwjx5JIV
	w26XXogXdCmhOGJsktEKKV9SYJhTuFCvQLUBzX1CPHU+k/Aoi5nnB/Ep8T3fSuPlGeco
	jLbYHA0E405J9G4Yv2qZedVgp4LiTR1kSin49lZx+bPjDBEQ7HLVAEUn+W4dvzaURPIu
	7f0HJWfXrEhRBEDCO2ulfrg4S+0myFSiNqKlPLx4ubegMst/YWhbUgiJJPHEQfnDhsSF
	kjC3vh8RAs7+Xy43afnVsPcBIk2pLpCcGqwkEQ9lSOmmnwqx62mbJ0UxCINywA8AeLg0
	Z4rQ==
X-Gm-Message-State: AG10YOTjcO/JgyFwAdGpGqw3YI4Ghr7keqhRtd9ICr2Hjn4htd8IPas333WH1yYMosvyBw==
X-Received: by 10.98.43.149 with SMTP id r143mr15387319pfr.7.1455858959061;
	Thu, 18 Feb 2016 21:15:59 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	o17sm14124607pfj.50.2016.02.18.21.15.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:15:58 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:43 -0800
Message-Id: <cover.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/5] toaster: fix mysql migrations and add django test fixture
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
X-List-Received-Date: Fri, 19 Feb 2016 05:15:59 -0000

This series contains a clean up of the database migrations to fix the issue that was preventing Toaster from starting up when using mysql backend.
See https://bugzilla.yoctoproject.org/show_bug.cgi?id=9116

After fixing these migrations and getting Toaster to start up properly using mysql backend a number of unittests failed due to differences in testing on sqlite.
To remove these differences I've changed the data that was in the setUp to be more agnostic and added .lower() where needed to make sure the orderby re-ordering in the same way. I also took this opportunitiy to convert the toastergui unit tests to use a django fixture making it easier to load the database state for testing.

Bugs fixed discovered by fixing the unit tests are:
 - toaster: SoftwareRecipesTable apply default order_by
 - toaster: toastergui Fix invalid char test and implementation
and one already reported
 - toaster: PackagesTable show only installed packages

The following changes since commit eb71785922100bf0f52c3429e60568524d488fd3:

  toaster: update the meta-yocto toaster configuration file (2016-02-16 17:37:47 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/test/michaelw/mysql-migration
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/test/michaelw/mysql-migration

Michael Wood (5):
  toaster: orm migrations Sort out migrations mess
  toaster: SoftwareRecipesTable apply default order_by
  toaster: toastergui unit tests convert to use fixtures
  toaster: PackagesTable show only installed packages
  toaster: toastergui Fix invalid char test and implementation

 lib/toaster/orm/migrations/0001_initial.py         |  26 --
 .../orm/migrations/0002_auto_20151210_1209.py      |  41 --
 .../orm/migrations/0002_customimagerecipe.py       |  24 ++
 .../orm/migrations/0003_customimagepackage.py      |   2 +-
 lib/toaster/orm/migrations/0004_merge.py           |  15 -
 ...0002_auto_20151223_1528.py => 0004_provides.py} |   2 +-
 .../orm/migrations/0005_auto_20160118_1055.py      |  19 -
 .../0006_customimagerecipe_last_updated.py         |  19 -
 .../fixtures/toastergui-unittest-data.xml          | 446 +++++++++++++++++++++
 lib/toaster/toastergui/tables.py                   |   5 +-
 lib/toaster/toastergui/tests.py                    | 257 ++----------
 lib/toaster/toastergui/views.py                    |   7 +-
 12 files changed, 524 insertions(+), 339 deletions(-)
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0002_auto_20151210_1209.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0002_customimagerecipe.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0004_merge.py
 rename bitbake/lib/toaster/orm/migrations/{0002_auto_20151223_1528.py => 0004_provides.py} (94%)
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0005_auto_20160118_1055.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0006_customimagerecipe_last_updated.py
 create mode 100644 bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml

--
1.9.1

