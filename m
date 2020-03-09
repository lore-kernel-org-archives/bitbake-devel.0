Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
	[209.85.166.177])
	by mail.openembedded.org (Postfix) with ESMTP id 4292961B3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:33:56 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id g126so9259171ilh.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=gT1Mi3jEUdvU6lRbSBYtEGXhMTh8izdAb8Qw+Uo03Ek=;
	b=snExztFBiB8mJ54+yrrQOzDh1l4YJlSaiqWVZ+dgAVjwdJl602L3WasH0wtNzbLaFN
	/vtPlP+6db0bZzH2VJ/E/S9MdrCaLyZbNctulxqe0qDebUoEhKnJV2uKluwgyzgorcvV
	Km86juahdrSJeOFQILT/iD5FTMZtSR1JwNDLLiOm1Bkem+1YceWIW35GZ6qWh5+aXwmz
	X6RpiQDi1pFNjdfejOn0E/ljuiBR9s4sWO3qqMWYtw8QhDyWeEOMLM62ZLn8dB0sH1PK
	Pq9b6VVpu3YFFej18lqB6o6OnHEmL4TFDTrRW4/6XxIca6drQvQQ07fNnp5P+sjyLADp
	C3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=gT1Mi3jEUdvU6lRbSBYtEGXhMTh8izdAb8Qw+Uo03Ek=;
	b=HfmIUOXr9fFS8UFpkvSGEWY9Zb03fW5vyjI/zLZBO2fVQFubZ8gBvjAL0A9+6Md/q4
	3SV5pHAna+kKdxLPFoPIZ6qQmAJau476KeGbaji559SZsPcgz+i67FqINnR+EXCEf8pQ
	QaGFgI1temDpCGnyZrNgF56NMLs9ii5KBXBtaYe52UBh0Pg2JF3TG7F0XTMPg+lh2zC/
	piYlMUSBF62UNE+UUygsDe7QeINCVkSPABe/NU8k+crDcBS1zHZzvZzXS1fOuqeraVn9
	Xi2GBs9+BeRI1wBHFCjWINLluxh795KdeWxJrSboAeJ9XqsF2UqLYfb81W8jCCOh8RXk
	GzdQ==
X-Gm-Message-State: ANhLgQ2DXUVulZbIxXMZyBvDdReYLYml5ATnBtW48QpWQU3ighzdmYhX
	IFj+259T0MDJr78VzmF+XttVN8NzIHQ=
X-Google-Smtp-Source: ADFU+vs2rnJD/HqRxN1N2yktpz7pk/ySxL17MN9M9iWzoXZIK5Cgx8yDQCHeWKFNCWuJHBkc+drLug==
X-Received: by 2002:a92:c50e:: with SMTP id r14mr16705676ilg.52.1583771636941; 
	Mon, 09 Mar 2020 09:33:56 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.33.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:33:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:38 -0500
Message-Id: <20200309163353.15362-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 00/15] Add support for python structured logging
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
X-List-Received-Date: Mon, 09 Mar 2020 16:33:56 -0000

Adds support for users to provide configuration for Python structured
logging in bitbake. This gives a high degree of flexibility to the way
that logs are capture and displayed, so users can generate very targeted
logging if desired. The initial use case for this is to maintain the
high level of hash equivalence logging on the Yocto autobuilders, while
reducing the noise for most other users.

I've added documentation updates for the new BB_LOGCONFIG variable, but
it probably needs some grooming.

Joshua Watt (15):
  bitbake: lib/bb/msg.py: Convert default domains to a dictionary
  bitbake: knotty: Handle logging messages with specific logger
  bitbake: lib/bb/msg.py: Use log level instead of debug count
  bitbake: lib/bb/msg.py: Add repr for BBLogFormatter
  bitbake: knotty: Add commented logging_tree code
  bitbake: lib/bb/msg.py: Add filter utilities
  bitbake: lib/bb/msg.py: Remove unused filters
  bitbake: lib/bb/msg.py: Add helper to set logging config
  bitbake: knotty: Remove dependency on format variable
  bitbake: knotty: Setup logs with config helper
  bitbake: worker: Remove unnecessary addDefaultLogFilter
  bitbake: Log hash equivalence with a different logger
  bitbake: Add autobuilder logging configuration
  bitbake: Lower hash equivalence logging
  bitbake: doc: Add documentation for BB_LOGCONFIG

 bitbake/bin/bitbake-worker                    |   3 +-
 bitbake/contrib/autobuilderlog.json           |  27 +++
 .../bitbake-user-manual-execution.xml         |  97 ++++++++++
 .../bitbake-user-manual-ref-variables.xml     |  11 ++
 bitbake/lib/bb/__init__.py                    |   7 +-
 bitbake/lib/bb/msg.py                         | 172 +++++++++++++----
 bitbake/lib/bb/runqueue.py                    |  13 +-
 bitbake/lib/bb/siggen.py                      |  17 +-
 bitbake/lib/bb/tinfoil.py                     |   4 +-
 bitbake/lib/bb/ui/knotty.py                   | 173 ++++++++++++------
 10 files changed, 419 insertions(+), 105 deletions(-)
 create mode 100644 bitbake/contrib/autobuilderlog.json

-- 
2.17.1


