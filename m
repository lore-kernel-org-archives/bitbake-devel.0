Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3773FC04FF6
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:02:52 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.42174.1712912567611373311
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CKTqwwRq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A97E60006;
	Fri, 12 Apr 2024 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hKbgBu8PC+dECwAW9lLh62l+4JZ/vkZIUWrabtnTVSs=;
	b=CKTqwwRqRaZAj+H6sOTibLw46/f4ev42800JiFpgHRllAwefqaxVEoJAagUiKlPhNr4Ebo
	g9xdADtcWK+yekf/T1hejg/PMxayZ1XMp+LOrDD4MG/wRU+BoKi+VgR9Va6pCo7yRUMO4q
	ROvaoLA+LXDKb1Cc+FmuZZ55A1ExMhkqfM1pIOu84zdPcNeHZ3k4Z8+TwmqgjYzQZF5+F5
	YCs00TjAxlOLTQRGElYZkRNo+Fk921Y/gRE2WnsrsLjrVR+Xcs3ziULftb7ZeW037XAPm5
	TSkR19yPZDTPCEVK6ePQ+dP/GrAT0C1i7xTc+5YtzG1NGC0ohAgm49q6gdUI5w==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 00/12] prserv: add support for an "upstream" server
Date: Fri, 12 Apr 2024 11:02:22 +0200
Message-Id: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 09:02:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16075

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to customize an "upstream" distribution
by modifying local packages. If the "upstream" package bears
revision "x", the local one will have revision "x.y", this
having priority over the upstream one.

Multiple levels of upstream servers are supported, so "x.y.z" revisions
are possible too.

Take advantage of this work to clean-up and update the prserv code too.

Manual "sanity" tests have been run so far but automated tests
(based on Python unittest, as for the hash server tests)
are being prepared for the next iteration. They will also to
test also supported scenarios.

Code reviews are welcome, especially for more Pythonic
ways of implementing some details.

---

Changes in V3:

- Revert the commit removing the so far unused "hist" mode, which
  we wish to keep for binary reproducibility sake.

- Simplification of get_value() function to take
  both "hist" and "nohist" modes with the same shared code.

- Add "history" parameter to the "getPR" request,
  so that the client can ask for the mode of its choice.
  This will also make it possible to implement tests
  for both modes.

  Note that more requests ("export", "import"...)
  will also need a "history" parameter, in a future version,
  after the first tests are implemented.

- Several fixes to bugs either present in V2 or introduced
  by the V3 code changes.

- Put all the new features at the tip of the branch,
  to make the cleanup commits easier to merged.

Changes in V2:

- Add this new commit:
  prserv: remove unused "hist" mode in the database backend

- Squash commit "prserv: fix read_only test" into
  commit "prserv: simplify the PRServerClient() interface"
  (Reported by Richard Purdie)

- Fix the code to support increasing "x.y.z" values, thus
  supporting several levels of upstream servers.

- db.py: remove duplicate definition of find_max_value() function in db.py

- prserv.py: remove tabs before comments (Python didn't complain)

- db.py: now stores the revision ("value") as TEXT.
  This way we can store "1.0" without having it transformed to "1"
  when the default type was INTEGER.

- This allows to fix a regression when the first packages were created
  with 'r0.1' instead of 'r0.0' initially.

- find_max_value: now returns None instead of '0' when no value is found
  Before we couldn't tell the difference between a '0'
  max value and the absence of such a value.

Michael Opdenacker (12):
  prserv: simplify the PRServerClient() interface
  prserv: use double quotes by default
  bitbake-prserv: replace deprecated optparse by argparse
  prserv: use self.logger instead of logger directly
  asyncrpc: include parse_address from hashserv
  prserv: capitalization and spacing improvements
  prserv: add extra requests
  prserv: remove redundant exception handler
  prserv: correct error message
  prserv: remove unnecessary code
  prserv: add "upstream" server support
  prserv: add "history" argument to "get-pr" request

 bin/bitbake-prserv        |  99 ++++++++++++-----
 lib/bb/asyncrpc/client.py |  23 ++++
 lib/hashserv/__init__.py  |  27 +----
 lib/prserv/__init__.py    |  21 +++-
 lib/prserv/client.py      |  44 ++++++--
 lib/prserv/db.py          | 225 ++++++++++++++++++++++----------------
 lib/prserv/serv.py        | 220 ++++++++++++++++++++++++++-----------
 7 files changed, 436 insertions(+), 223 deletions(-)

-- 
2.34.1


