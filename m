Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB1C88E7D
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 16:06:46 +0000 (UTC)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.455.1789488397057164192
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Sep 2026 09:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qNMrEiaV;
 spf=pass (domain: gmail.com, ip: 74.125.228.42, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso2927817a12.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488396; x=1790093196; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGLRrjcu/h94PIcZuwZIAFBILtTGt6EkzkLA2IF6PS0=;
        b=qNMrEiaVg6gSY+KHoEl8HzMV+d1tJR/gdwLkTKNA3lpVFnuLGdnF5wFOc8WhiMn7in
         GfS9qmGTWIMEpCaUzZzR6BNndPkH4CCl06WZ/swcaXPf2haxWksGuVulPirjFJqXEbb4
         aVfp4ZWLTLFV2jnGY4IC6oL+XGMgUS6TfQw6HEdne24nI10uQvTzWXeIH3f1bofWiVlo
         P7Wnm4luaURZ1x4ptV7gJ0/2P+sH+4H/8rRrhNADas1cMV8qgPdVOFMHNtwUWPM3IYY4
         3kgHQmWUiUfZfEOm6P4mwtksrX1pOCA6tLDIs0CTFfAqtdqovC61Flqd/SwQ+3Ajj8O+
         z7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488396; x=1790093196;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jGLRrjcu/h94PIcZuwZIAFBILtTGt6EkzkLA2IF6PS0=;
        b=k/iw8nRZGKYv46lgIFU4DvG+i79RojhMy8j2G9J8qw8R+V3V7mimDra4yf/cHkFSLh
         63r70LnkXpcoPwCt6dmVfad8w0aebe0rUKd5REt1uRKPUrrqyjPR/pAWaNp9xTAMrjI1
         l5JThbR8btMyTF1H/fKSSDb8XmRIJVckyGHJjYTPspCijjq5IJTFJ8etyzMorcwH+fDg
         vK23x0EWe4T347xnmW8+UjbgL0bjSdRSYenjrT0IvyKQ/0QrUL68nWihVVpJ9/MsPWNo
         7UyM3ssKln+lOGysAag+ecP+YVE98tc+kowNoABj0HGGvf2V48GWO7X8U1sNRdvm+E8F
         Y9rw==
X-Gm-Message-State: AFuF++nBalCqXGJYIEldkGQqJgZNSJVNnVb+TAYEmSJeO1Pgp+9mFrZ6
	GqeXSnVXUF+FPpSxsCOoOrAogroyO94CPrPzECjuqRu0PqS2L8Ja7CKf1n41clcPgX8=
X-Gm-Gg: AYBFou17Zt0/hYy3mR/FCnRFgrK7MHOj6c+eq0H24h3m/p2wGPB3LI9qdeSjNjReuNb
	YkA+Ni0S1yVMgByhNkfqsEMo02tEMw3pEle+X8aPjv6esk5x8LYYtDAEQiMk8r6OxPxswsHLUI3
	Uszn3D5d3zOVpWkZOCqkTZDxySf16yR5RbR4HQFwmfmjlbGz7WrRhl9BF3UNM+chpGk3HjYyJgT
	MNwj7cenp0o1uH3XKVW2Zs6VZfMIdywHUdqbANL3GrHwsC+riBRj9xziUvVvQawSMnb5WfkcYTH
	/bgCkwa7C8yFzwc36SWtpsYCiHT+ZP9bjyVGCbIx+M/Lec1a/X5mbMVHS7fdlm9Ljk0tmxX3oBg
	clFSWDYJrZ8kHifUIqxtSuEf4fE8odyOM1hO1Fhl+YQ03neeLSQv+5S+avMNhZ1xPH3sCibrUMV
	VHEcXsmGBAES/GVZPQ0HIrEOy8W2+9d3lKJm7H7VV2znCrS9jwKiPUmwrjCH8CIz5vmPIPT6U=
X-Received: by 2002:a17:90b:440b:b0:39d:e784:3e1c with SMTP id 98e67ed59e1d1-39dec0f7193mr16794182a91.19.1789488396239;
        Tue, 15 Sep 2026 09:06:36 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba020d1sm2605678a91.2.2026.09.15.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:06:34 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2 0/3] prserv: add --status, and make --start notice a dead server
Date: Tue, 15 Sep 2026 16:06:30 +0000
Message-ID: <20260915160633.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 16:06:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20213

v1 of --status failed bitbake-selftest on the autobuilder: test_2 found
a stale pidfile for the server test_1 had just started. The daemon dies
somewhere between writing its pidfile and serving, and --start cannot
tell, because it returns once the intermediate fork exits. The old
start/stop pair never noticed a dead server since --stop treats a stale
pidfile as success. Every autobuilder run that carried v1 failed the
same way (26 runs on 20 workers, on Richard's and Mathieu's
master-next) while it passes here. Binding 8585 before --start gives
the identical symptom, but the workers' prserv.log is not published so
I do not know what kills it there.

1/3 ScriptTests picks a free port and keeps one database directory
    for the class instead of 8585 and a directory per test.
2/3 --start waits until the daemon has bound and opened its database,
    and exits 1 with the daemon's error and the logfile path if it
    fails first. The daemon removes its pidfile on failure. New test:
    --start on a busy port fails and leaves no pidfile.
3/3 --status, as in v1, with the tests on the class port.

If the daemon still dies on the autobuilder, test_1 fails with the
reason in the log rather than test_2 with a stale pidfile.

Tested on top of 046a90b0e: prserv.tests 10/10 at the tip and at each
intermediate commit, ScriptTests 20 runs in a row clean, and the rest of
bitbake-selftest module by module with BB_SKIP_NETTESTS=yes, all OK
except hashserv.tests, which hangs on this host with or without these
patches.

Babanpreet Singh (3):
  prserv/tests: run ScriptTests on a free port with one database
  prserv: make --start fail when the server does not come up
  prserv: add --status to list running servers

 bin/bitbake-prserv  |  7 +++++
 lib/prserv/serv.py  | 76 ++++++++++++++++++++++++++++++++++++++++-----
 lib/prserv/tests.py | 54 +++++++++++++++++++++++++++-----
 3 files changed, 122 insertions(+), 15 deletions(-)

-- 
2.43.0


