Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 9B7746FFE2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Feb 2016 21:54:42 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 184so898970pff.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Feb 2016 13:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=tMSmnhmRCmpFHxCxIsxS0yHSrnunfGDyPkI0dxtW87w=;
	b=P+ZFhSb3bJSRbVWTgFPzy8i0M26VxyGP3iPhdzjHeTb7FqKm9p9Gj0DgjtHMTO93Sr
	uMoP67FyDZrahIHXhccSPwzkERdUlUYy7CAffgPhvQ8Hugz2psLBnUxEf7bspptJktA/
	XAH6gYa8YOeoUHOkYtsKSaZJ+ffKMqoeTEzykVmBxChtx9WzAG7EcRp1K7icHDBtFHNs
	IALuhV8p+ebJStClGfTSu13iINxfeI813p53mZFPAAevRAUilJ2r9zkYG0dnORXmiqko
	5XesX325cqQV+fWpZIyRvzKVzfBqWwL765PzB6EtmM3EihohRM7X75ZyNa++RYTSLLkJ
	9Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tMSmnhmRCmpFHxCxIsxS0yHSrnunfGDyPkI0dxtW87w=;
	b=J+PdLGSKegm3i2mdGaKByC9LI4hkEeAALLfWGP1tep8T0S1qcpQ77JT68p8jZJGGFp
	m8RptbqAST/8J/lZxBYxfrf74cKmmRP4OJwb6WFgPratwcBuMg3CTYZdAsxSpEK7fzTt
	oQeW7BJUaq5YVNs0RoFJVjHESVye/6e0VAPrk+H6rMLAi0MUAbax7OdXryuzb4LvchzB
	6NmzKkrpLTLBsP4rSVjvKC5NEnF5HvWg4mYGp3dtVlmrRrPESxjw3IH9uY2XTNHprhLS
	0bZHFRnVbmxrCIeGMzhvYrsGIRxujSVs9hodEaAFfz/QPJ82UhpK5vaZXrl8Wl9+CICy
	yLAA==
X-Gm-Message-State: AD7BkJIUnP+74XLzLc+GDWuYQOUrU6d+YPDdbnPu4o2h49ZA6nOi4py6G9lhhRCLyt1kIw==
X-Received: by 10.98.74.144 with SMTP id c16mr11828735pfj.129.1456610083014;
	Sat, 27 Feb 2016 13:54:43 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	i13sm28033083pfi.95.2016.02.27.13.54.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 27 Feb 2016 13:54:42 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 27 Feb 2016 14:00:44 -0800
Message-Id: <cover.1456610242.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/1] bitbake: Remove Hob ui
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
X-List-Received-Date: Sat, 27 Feb 2016 21:54:45 -0000

This patch removes the hob ui from bitbake as it's functionality is being replaced
by Toaster in the upcoming release.  Note that there are still some files like
lib/bb/ui/crumbs/hobcolor.py that remain since some of the other gtk based uis
use these.

-bavery

The following changes since commit e0fd96442a20e3fe7953bf38fc02520cd0dd4d6a:

  bitbake: toaster: change 'delete layer' to 'remove layer' (2016-02-26 17:20:38 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/bitbake/removeHob
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/bitbake/removeHob

bavery (1):
  hob: removal of hob ui and associated ui files

 lib/bb/ui/crumbs/builddetailspage.py           |  437 -------
 lib/bb/ui/crumbs/builder.py                    | 1534 ------------------------
 lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |  341 ------
 lib/bb/ui/crumbs/hig/deployimagedialog.py      |  219 ----
 lib/bb/ui/crumbs/hig/imageselectiondialog.py   |  172 ---
 lib/bb/ui/crumbs/hig/parsingwarningsdialog.py  |  163 ---
 lib/bb/ui/crumbs/hig/proxydetailsdialog.py     |   90 --
 lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   51 -
 lib/bb/ui/crumbs/hig/saveimagedialog.py        |  159 ---
 lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  891 --------------
 lib/bb/ui/crumbs/hobeventhandler.py            |  645 ----------
 lib/bb/ui/crumbs/hoblistmodel.py               |  903 --------------
 lib/bb/ui/crumbs/hobpages.py                   |  128 --
 lib/bb/ui/crumbs/imageconfigurationpage.py     |  561 ---------
 lib/bb/ui/crumbs/imagedetailspage.py           |  705 -----------
 lib/bb/ui/crumbs/packageselectionpage.py       |  355 ------
 lib/bb/ui/crumbs/recipeselectionpage.py        |  335 ------
 lib/bb/ui/crumbs/sanitycheckpage.py            |   85 --
 lib/bb/ui/crumbs/utils.py                      |   34 -
 lib/bb/ui/hob.py                               |  109 --
 20 files changed, 7917 deletions(-)
 delete mode 100755 bitbake/lib/bb/ui/crumbs/builddetailspage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/builder.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/proxydetailsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hobeventhandler.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hoblistmodel.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/hobpages.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/imagedetailspage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/utils.py
 delete mode 100755 bitbake/lib/bb/ui/hob.py

--
1.9.1

