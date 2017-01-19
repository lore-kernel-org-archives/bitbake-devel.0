Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
	[209.85.214.53])
	by mail.openembedded.org (Postfix) with ESMTP id 242B571C5F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 19:35:25 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id c7so4379920itd.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=UG9InewcjQWKMjLjrdbkSUK6ItSmlJV3aFsPDq1u18U=;
	b=Fi+manU3SYWi4QPPZe8HhUArSgAtFfujslvN08ADS0kfd2Jbls8k7HW5KotVhikEcr
	w7qLR5k+vAdnpULfHJBHgzONScLFPXK6asRugEIRI7AbadBYAfmkWJGIRxKNFT/50CH1
	BshVA+JZd7VLFkj8QuIzi5AzCqRWWIUWomjmdaNNwjeWlBXyGVpoyeGWXwAmJy5UBPVF
	oSvRjCyu5QW5F/hyjFC7ZPD9W6BiqiglIolAugvjuiUfxQbfTk91BVD1mN08DkOwbGBv
	oI526Qt0HYmATIO59LzD6YwL4heDbBRCKZudgEkGYMXsvibR9O2QMyxarCLTxn9nSV4f
	dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=UG9InewcjQWKMjLjrdbkSUK6ItSmlJV3aFsPDq1u18U=;
	b=aCwboBiALvnh1yMZ2p08wKmX3nkkgUHhWBl+hIu/V7azymbt1px3ZRP93IuRRL3fjb
	L03OS989u1oH3Ub3NjYmHb22fQRXfeWBRell0maiBwu3fuh7MYU1ivlRZU8gQz2xIHrL
	Gc6neIYfGlGpLQnac4tC+h72FmofWEgqACTR9Az6cdjVsdeCnHdWdGgf5KpvpoN5u4ET
	oN+NNeo2e9cExO1B3icQKC2vumRTSBm0xd3miuvmGrQw5TMQtkqYBATqvdVcElm9YI/i
	2SQf9jM0A67m9hBpEyEpbiTej2xe9BotmhKKazeRLcIY/VAzxYoDCfQ5fyqqB8KaOyg5
	lpNg==
X-Gm-Message-State: AIkVDXLLeZA0cig7ujje13vOQ0IkZ60mkFT7bjEjV0+RGWzg3jlRVxt+wqPHCYYZnA/yxtbm
X-Received: by 10.36.26.9 with SMTP id 9mr258002iti.25.1484854526218;
	Thu, 19 Jan 2017 11:35:26 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A5686E.dip0.t-ipconnect.de.
	[87.165.104.110])
	by smtp.gmail.com with ESMTPSA id x128sm84150ite.11.2017.01.19.11.35.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 19 Jan 2017 11:35:24 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 20:35:14 +0100
Message-Id: <cover.71d0a8886d0d5ad010cacb3c2ae130efc35fc5f5.1484854453.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH v3 0/2] bitbake: rm_work enhancements
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
X-List-Received-Date: Thu, 19 Jan 2017 19:35:26 -0000

This is the bitbake side of the rm_work.bbclass enhancements. See the
OE-core "rm_work + pybootchart enhancements" mail thread for further
information.

Do not merge yet! The first commit is from RP's poky-contrib wip-rss
branch and needs to be merged from there. Once that is done, the rest
of the changes should be okay.

Related-to: YOCTO #10584

Changes since v1:
  - replaced prioritized anonymous functions with a dedicated event
  - replaced the implementation of the "completion" scheduler with
    the new code, without changing the name

Changes since v2:
  - rebased onto master-next and dropped the preliminary
    version of RP's RecipeTaskPreProcess
  - fixed the remaining reference to RunQueueSchedulerRmwork

Patrick Ohly (2):
  build.py: add preceedtask() API
  runqueue.py: revised completion scheduler

 lib/bb/build.py    |  16 ++++++-
 lib/bb/runqueue.py | 125 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 117 insertions(+), 24 deletions(-)

base-commit: ce1e70b8018340b54dba3a81d7d379182cb77514
-- 
git-series 0.9.1

