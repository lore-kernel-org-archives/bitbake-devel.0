Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
	[209.85.215.181])
	by mail.openembedded.org (Postfix) with ESMTP id D62F97E08E
	for <bitbake-devel@openembedded.org>;
	Wed, 22 Jan 2020 05:25:05 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id z124so2795505pgb.13
	for <bitbake-devel@openembedded.org>;
	Tue, 21 Jan 2020 21:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=HaB8usi5SOurZ4j047v6yRnnMf3ETSDmJ34uAbmGO1Q=;
	b=mMF9AHAb9n5nLdsnTEndtSx1q8taaQeFWnEo4fkIkdTYpvVl4mc646W9LmvSkcRqwR
	Jo4xHuxaK0p/G006r/A304BWY1yeUj07kcw8LHvk+unbK1QnUdqgJDgMY3m8/w/jht+d
	shFRCKfdCGhCivCaZBLa8+wVmmGN9oCLu/h/4MV6aMloC5QJIQ8t/x36r4HCvEDIbiAo
	gSunpeTNFlTclqZxxWnllR6jNN+qb31vjOWfZwfE1NsAvQVvWL9tRjHYrTwzvGA1Fk8r
	UN1AUZQSys6mSHazC5b98rc76797bqSlkRo4jJspWWvsLex1txpPzshHsI7FIUPV/lBG
	ZP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=HaB8usi5SOurZ4j047v6yRnnMf3ETSDmJ34uAbmGO1Q=;
	b=BlHWVaTUZVEQM6n6rx7o0YrHWXIbb3jNzcIw857D2WSq79BsfRjrL8+II+f4gsms/T
	cb2vPFYb9gPHlt1kQFGv1WgYwlQBMPrLjphqME0MCzIt5PezpWeKLHXoxFEq9cfBsa5B
	M/SI0YOSIqW9hReCOP9sTf6u/gZOnfP1vDfnheyUtJzAHk2A7fOGWqySiechV/z2uPkn
	DfHg8XW1gGydhd2m+m1h9VyRLXvkBRKa4994Jyv75iwh1g7zYPfsFg/kYdVblhBNhYMK
	bEAQkohojqpt1A+QNek3/WfFFK9gGGTZ+mmFVszl5tUsklzmTklrl49arv+j6Nz1auqL
	S+Pg==
X-Gm-Message-State: APjAAAVyvuRVi1qV9TIOXmUBJnoZ0b2vzyx68yc4TuGi5c95a8obfg4T
	1WBqAZnKLNwhZ6OHPVy6FojO3Ts9
X-Google-Smtp-Source: APXvYqz1Zmc8uLzzxNX2cLKVS9WEjXEihdcPHbh4WknGf8/V0w5x71UGKNzHUuEONHPIgq7awGvCjQ==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr991204pfl.231.1579670706526;
	Tue, 21 Jan 2020 21:25:06 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:682c:76b9:6d8a:bbd2])
	by smtp.gmail.com with ESMTPSA id o7sm1228628pjs.28.2020.01.21.21.25.05
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 21:25:05 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Tue, 21 Jan 2020 21:24:58 -0800
Message-Id: <cover.1579670574.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.44 0/4] Patch review
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
X-List-Received-Date: Wed, 22 Jan 2020 05:25:06 -0000

Most of these have been on the list already.
Please havecComments back by Thusday

The following changes since commit 46969195492708a705390896c9dea515f158954c:

  cache: Lower debug level for wold build messages (2020-01-02 20:23:09 -0800)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-nut

Peter Kjellerstedt (3):
  cooker: Keep track of watched files using a set instead of a list
  knotty: Hide the footer if a process progress bar is shown
  knotty: Be consistent when creating/updating progress bars

Richard Purdie (1):
  runqueue: Use a set for the setscene tasks list

 lib/bb/cooker.py    | 16 ++++++++--------
 lib/bb/runqueue.py  |  4 ++--
 lib/bb/ui/knotty.py | 17 ++++++++++-------
 3 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.1


