Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
	[209.85.215.66])
	by mail.openembedded.org (Postfix) with ESMTP id 93AAF6093B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 11:35:49 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id a69so23614490lfe.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=hQVNjHwTQktREKY9O5bN2x28N1p8mJ29eJqTBixSsw0=;
	b=Vg/H/gVWnmv8uzFqQ3mCdClMLHBUWFUFpsQdOvYQBdbhfQd8dO38oFxGv5XIYI4BFx
	b7qzV+LUfBsrko+FSYbXnzV3bVjJQvOk+7JJ0uKjQiD82bJYg6y/pbQOOm3Wxrp8pOwC
	W9CKQE77/ql0oxes9pHY9upRsLMPElmmujfW2iA+q59tEo6CKaWe+gk6hnkSzjh8HiO6
	aBGkeauQLUC0EmZV3aHqZTCHENDdlnbwUSGN2sx9jNfUXi0ADCcJynfCecsAMbLeLh0j
	uwAxt0epboKZJfKLaHG54OYPSm+3DcL7zALCw/MHDGcFEG4G/h6EXLB094ldSf1qPEcy
	rtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=hQVNjHwTQktREKY9O5bN2x28N1p8mJ29eJqTBixSsw0=;
	b=rZpoHnkt/Fit3sf3ewpXrgiXBj9gPveWGM6Q8PL/D+pVw54q4J8KzREphpTRCtJg2r
	5QnUxL0IqWe0TNBlAsxFFem8yZWqC+WdtXPSL3H6ndgFo9VK1DKSyPUEs3d+Nzunfuj+
	alh7ggHPeO8ld4sU3OjUfcg4IMNbLoAZ+pYygZ0Wj1d8eUWoMzLT6WrnHwrl2qiEgI4U
	RdFUM71SHsUCkCx+rNr79P2MQuBNasm1RBzUZIyPq5M0QeE8Xj3dvSejOlthBvjVnmz5
	IEq5/wXQlID2FLdYI+/3rXHafrK5msBJJBQvGS0ZXsqhQ70h/47h7lIRkT1yv/Kfg467
	nJ0w==
X-Gm-Message-State: AMCzsaW6vy7xZF9BXkONL5nFUoCT/o/wVz13Qzv9pOQcwScH9ZikBkzA
	DgpsJXra2lHL1ihTcpzzemoQbA==
X-Google-Smtp-Source: ABhQp+QVBAt/7P5+cYFKT4Z6mddrnhmC2h00rqCjJF5qbK74pldj1rhGckefKbZboZl7yoWI/tE9aw==
X-Received: by 10.25.217.66 with SMTP id q63mr5668520lfg.176.1508844950053;
	Tue, 24 Oct 2017 04:35:50 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id h82sm18166lfb.21.2017.10.24.04.35.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Oct 2017 04:35:49 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2017 14:35:40 +0300
Message-Id: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: andr2000@gmail.com,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 0/4] fetch2/repo: Repo fetcher fixes and improvements
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
X-List-Received-Date: Tue, 24 Oct 2017 11:35:49 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

While working with repo fetcher I have collected number of patches
which may be of interest for the community.
Some of those are fixes and some are improvements.
Please consider.

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (4):
  fetch2/repo: Fix missing logger import in repo fetcher
  fetch2/repo: Always check if branch is correct
  fetch2/repo: Make fetcher always sync on unpack
  fetch2/repo: Use multiple jobs to fetch and sync

 lib/bb/fetch2/repo.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.7.4


