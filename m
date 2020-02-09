Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
	[209.85.215.178])
	by mail.openembedded.org (Postfix) with ESMTP id 341E96080B
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:18 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id d6so2525587pgn.5
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=yNZXZxV0skD5J0C6F3J54rf2oWb8TZhoIxsksoWlASo=;
	b=C55mkrQTO/tFDUuXRlZ0ajgFjT3VobzgUyuKd2OeuuhLlm4VI8AqAof29PacS3BfOk
	tWVmwDhJ2XAFPQZF219nAwGkL+78WT1fRDX33CxALevbNhrMIhzwln7zVwC1o9WzADKQ
	4yihD56FENVf9Syr64Hl7/oYAzlJnMSgOFBagF4TwcWJkRyy8j3eL0pTqBlbDqd3K6tN
	iilqlHzUDH0tEvlDm4H+JwQlCBbg4EGOkk6YEuNDYFKPBUrGqGiRS4J2Ddw3o07RSYtC
	+qxOjFuQGhtFqAhKyw+4H4nov7y5n/JoRzUzfqeRw3cNZoTSvUK7hOr2502SEI5dwkHK
	pcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=yNZXZxV0skD5J0C6F3J54rf2oWb8TZhoIxsksoWlASo=;
	b=Oi5kVQPGwPk2zjuovOjfCP7zJ3hbv3nDnOxuf7tIA+/nTJU7UicSbvBWsRKzY8Dviu
	0Lwh8+ZwXiozJVSTAodf0krFRWOpOEQPRvHk2qyNxwgU8A719qmnW1ezPZJ3e24P4u4/
	D9a73KuVyeXe7wPJR0ctmUBJUYb+xG2WOnIMj2nlPzZjBUvh4NoXxkOf1oZnz68gaPGu
	+Lm5sN3CCCydpxkVMcA5q5KMnHwc6YTwq7vOaHnyGuZhTtgpe2BWBQK1ZbTGFt/PTm0p
	Tm290millTsxWGW93ojLGr49pBJH/4rJszTKBAjPXqQo0CuC/WL6P+4oUnEmCnyrPjF8
	Lrfw==
X-Gm-Message-State: APjAAAVtNOZymqSd328lZoSburjZsNeFSOtrGmaqWGBFc3UjPFXbCYmQ
	BrLJUQrhH8oIRnfzkXCjTCmjLUcA
X-Google-Smtp-Source: APXvYqwhfChOKgeSgs1cbMHS5aMDEToUSGz5+FSEwiaKizwLDNF0Pan7MHv/x0q23h6ih98PtpP4SA==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr9643664pgc.34.1581264198841;
	Sun, 09 Feb 2020 08:03:18 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.18
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:18 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:08 -0800
Message-Id: <cover.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.44 0/7] patch review
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:18 -0000

Here are a few more changes targeted for the zeus 3.0.2 release.
Please have comments back by Tuesday.

The following changes since commit 1a026d4aca47ed1b0b74a8a818635e7520e8f9c8:

  runqueue: Use a set for the setscene tasks list (2020-01-18 12:20:38 -0800)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-nut

Chris Laplante (3):
  fetch2: do not suffix srcrev cache key with PN
  fetch2/git: _revision_key: collapse adjacent slashes
  persist_data.py: Immediately get exclusive lock in __setitem__

Frazer Clews (1):
  cooker/toaster: replaced deprecated method warn() with warning()

Richard Purdie (3):
  siggen: Optimise get_unihash disk based cache handling
  siggen: Cache unihash values to avoid cache lookup
  siggen: Avoid cache mismatch issues with locked sigs

 lib/bb/cooker.py                              |  2 +-
 lib/bb/fetch2/__init__.py                     |  3 +-
 lib/bb/fetch2/git.py                          |  4 +-
 lib/bb/persist_data.py                        |  3 +
 lib/bb/siggen.py                              | 68 +++++++++++++------
 .../management/commands/runbuilds.py          |  6 +-
 6 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.17.1


