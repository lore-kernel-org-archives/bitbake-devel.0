Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
	[209.85.214.172])
	by mail.openembedded.org (Postfix) with ESMTP id AF2CD7FA0C
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:48 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id x17so22040183pln.1
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GaZWonIRjfqGU5xGxrhi2qB09AUo+iu9jjX0GJVt8Ug=;
	b=LO44cuVhi+iakr+eeHAcwR1hF6n0iuF5sjYkgdYDZ1578eh0qvR3Ke4zlnf2wLsAbO
	dCUw99JEgHxeeO6l5BL/HfyB1vBs0sqg8E6XzLBpKC6mvYB3UFZUjf4JUpr0Cc0OdwLl
	YWIavkb+/dtGZh4EUfb3Pay8I5e5BAz5xgtYcuZYycdQLfXQzviPctWeD0Nffeyxl1Fj
	+uofiTKazPZjXTLEIdMJ7j62SDTXOqmoiVYMs+/EdnDvvahQNvchzGjlz3JQTjesXvM+
	UO6Hu3ob9ivhWH5whCkOZ7jXCVLeoFyaBaO0zQapXv5jACA657JBKog4ouQx1lNv66ga
	bQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GaZWonIRjfqGU5xGxrhi2qB09AUo+iu9jjX0GJVt8Ug=;
	b=hvZ1CMTxy0btFzHliUZ5yyIVnI95qT1/cS5L+59T/xH5el47D8Fyk2Bv5QiYKUYBL5
	VzAjwmj6KMRcppEXwEjq/hK7/AOpw/kgs/n+PEycoCKI8YrfgRySudnf/GtgacyGWc/R
	IPJ+jjEop8AFiUAoJloMsFBFX3atk+lG9XzToOucPH/Hz6piSqYCY/ZM4mSIAPtQakXN
	pABCWVIVVb8TuVtiMdQiHJhgEz0Q24WwS4MDKewnUMHU6q3csDFNaHWdS/CEgLiDM0ut
	GaS4R+C/+H7DrN8i/q6YFOM6mAmM4o+7jlo//XZUerKnowXfhCJ+hqVPOFGzQ3KlNirZ
	6mFg==
X-Gm-Message-State: APjAAAXU7kicQTpvWMKVTXwhKOlBBBkc1S6Lk6eMsRqOTkveQl39Vf2N
	bfTmRYaJ7VN48sun9RLZgMffZK1W
X-Google-Smtp-Source: APXvYqwSUIbZnVQgNFPbxOnTJzqGMgEd5Pr8eTz53ZBeVcu6eyuWogr+cBSfUYT75xV2FuPcuQCuww==
X-Received: by 2002:a17:902:a70c:: with SMTP id
	w12mr105699336plq.124.1578328009732; 
	Mon, 06 Jan 2020 08:26:49 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.49
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:49 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:21 -0800
Message-Id: <cover.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Subject: [1.44 00/25] Pull request
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here is the next series for 1.44.
Please merge to 1.44.


The following changes since commit cfa307aabf710d79c404a8571b4158b864a94727:

  runqueue.py: not show warning for deferred multiconfig task (2019-11-29 11:26:07 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-next

Aníbal Limón (1):
  lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on
    directories

Chris Laplante via bitbake-devel (1):
  bb.utils.fileslocked: don't leak files if yield throws

Joshua Watt (1):
  runqueue: Batch scenequeue updates

Ola x Nilsson (1):
  prserv/serv: Use with while reading pidfile

Richard Purdie (21):
  hashserv: Add support for equivalent hash reporting
  runqueue/siggen: Allow handling of equivalent hashes
  runqueue: Add extra debugging when locked sigs mismatches occur
  knotty/uihelper: Switch from pids to tids for Task event management
  siggen: Avoid taskhash mismatch errors for nostamp tasks when
    dependencies rehash
  siggen: Ensure new unihash propagates through the system
  siggen: Fix performance issue in get_unihash
  runqueue: Rework process_possible_migrations() to improve performance
  runqueue: Fix task mismatch failures from incorrect logic
  siggen: Split get_tashhash for performance
  runqueue: Fix sstate task iteration performance
  runqueue: Optimise task migration code slightly
  runqueue: Optimise out pointless loop iteration
  runqueue: Optimise task filtering
  runqueue: Only call into the migrations function if migrations active
  lib/bb: Optimise out debug messages from cooker
  runqueue: Fix equiv hash handling build failures
  runqueue: Ensure task dependencies are run correctly
  runqueue: Fix task dependency corner case in sanity test
  siggen: Test extra cross/native hashserv method
  cache: Lower debug level for wold build messages

 lib/bb/__init__.py        |   5 ++
 lib/bb/build.py           |  25 +++----
 lib/bb/cache.py           |   6 +-
 lib/bb/checksum.py        |   5 +-
 lib/bb/fetch2/__init__.py |   4 +-
 lib/bb/runqueue.py        | 137 +++++++++++++++++++++++---------------
 lib/bb/siggen.py          | 104 +++++++++++++++++++++++------
 lib/bb/ui/knotty.py       |  12 ++--
 lib/bb/ui/uihelper.py     |  39 ++++++-----
 lib/bb/utils.py           |   9 +--
 lib/hashserv/client.py    |   8 +++
 lib/hashserv/server.py    |  36 ++++++++++
 lib/prserv/serv.py        |  12 ++--
 13 files changed, 277 insertions(+), 125 deletions(-)

-- 
2.17.1


