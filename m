Return-Path: <scott.murray@konsulko.com>
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
	[209.85.166.49])
	by mail.openembedded.org (Postfix) with ESMTP id D03607BEDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:37 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id p17so3581493iol.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:subject:date:message-id;
	bh=1NmocYBWIGtq76+9pLXQdXKIgeIYSgnJk2AxN8r3XC8=;
	b=Eh9NpeYQuAA1NrlW8lVtfZkKq5SnWWy7WfSdMuW9iucTPaEsGiz3Ja+60b4c8R7spa
	dkZR791PEETBLg3o9qeAAd8VzlbmdBLq0N1l/asr8s2IqJPwb4V3GW6x5QPgWriBgxDa
	FAonxSY5ENqepfNBZN8h08hLhyJqsNMmpRTdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=1NmocYBWIGtq76+9pLXQdXKIgeIYSgnJk2AxN8r3XC8=;
	b=OaztRKg2Q2SRnjycWrifsRujitC65Tuh92Nc6aT7uXQd1alpTQTwoPJjS6cp29wJb0
	FGoj66FlCEEb1s7mLf1Z/uE4Fpcsfxd1OprH5YYw5uoxIZi+KNpWuT02ciQaxXBRyFWD
	GjAy/k3644N9Z/vAue1tGjDpeCk9/J8UKmb93suqLhZO4PRligodsDnSJujC4KTYZefI
	ut/g96XCflVjJOsleH15qPefFd58NJfzbJrkibx8LllW4EtMiYA3yOCVwRWz7iBcWepy
	d1gxi1xd2eKQTwwIKF9YPK+KrNJqqjoDHVZyE6gM6huCk4thn1hD9WPLKZazWhlEDyIE
	0ipQ==
X-Gm-Message-State: APjAAAUg3gjPL3KBNqDk/jupM51BI/nCcwIEWEYaH2zyaIQVqmgLq7kb
	9GEUCR6NmOMp6M8BK+vjnJf6ZW47UJU=
X-Google-Smtp-Source: APXvYqxMhNKJM4ti0GXQtEybLOxukRiAxhGFTpJYqzycRUCnUEElyPFz4xi90XmMRaf2l/+kLka5yg==
X-Received: by 2002:a5e:c901:: with SMTP id z1mr6251585iol.304.1552430558626; 
	Tue, 12 Mar 2019 15:42:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:17 -0400
Message-Id: <20190312224627.12667-1-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
Subject: [1.40][PATCH 0/10] Backport gitsm fetcher fixes
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:38 -0000

Backport Mark's git submodule fetcher fixes and a related testcase
change to the 1.40 branch so they can make their way into thud.  All
changes cherry-picked cleanly, and bitbake-selftest passes successfully.
Additional testing has been done with the Automotive Grade Linux (AGL)
build, which requires these fixes to build against poky thud.

Thanks,

Scott



