Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6316.1795182807818575535
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2026 05:53:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=JcnSUqBp;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d05d51553so6180585e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182806; x=1795787606; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIVXYE21YSy2WOJ3xvMs0pZzkyaukuKloO6zxOlId/M=;
        b=JcnSUqBppsmqRO/7h+WJAPcRZxr8oUrh54B9eRFvfsuU6H8YreD4zn6aRVfXgm65TN
         FHrIzojkjJwN6V1SG+NgK3sJFVplNEHOcMqkdYz9Sq8i9Pp2ytkFM5IyM7Bk5f4HGSpt
         FScdRDGNyjoFb7MQ03MVCSRD7O7CtM9RRCcSncSy/E+sC06cU8woO44jFByB2ydCeA+v
         6etKN92rP6Jni40tetUwftm0xO8YjDIHoomDpzDQJpzp7V44jhAy5s5VyXMtYoKaT6yW
         xcFeMpXOztC9OkSaJopbJkUArUROtXjpoEJHCcrOdptPHl7LrqLzhzh+aWq7EL3sdIap
         Xavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182806; x=1795787606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIVXYE21YSy2WOJ3xvMs0pZzkyaukuKloO6zxOlId/M=;
        b=MHW7QZO6BRZW1JmhFwLoMfg5NEoZI1evYP9iAfmmHmeIArkbHcYe7LkIAR4smAqgR+
         KGjPxQwH5G5JKGjEdvdyUc93Vjcg5ACXsyZiT3i6hcs80yQKa0UsjVIaBRxRIw9mNwn0
         OisHV/jwp3XK19O9eok2yex5OabxMGqCOz8HMGQxbkr+FK1nBuJDDxxL301fy/WkGTRt
         hBfcZmBCXvO+66MCyDWs+SD/N2bmydf/rGClGKYl9EZEdiwO0Jc91KxL2nm4PlqMnYuJ
         gPhvccaCzbcLwE108cdWaylmUnr8qbmR0YFBKYDIXnkCrgxbdmrQaTCahfFaH7KiSHJC
         PFPg==
X-Gm-Message-State: APuU4Z8WDBX1+gyRPEE7Vi89sfKcAbgPfhsNviCJTnlloZpY3isDvhR6
	mo2LqhVLQTSI7dNF2OwMTDFcck7blzst3hySEgHJljlRdqqMx2ZyViRxikIgPTIH
X-Gm-Gg: AYBFou1mI4MkYO2FSUys6uQyq3FtWyZlIoZwCFjhnUoNkXobAlOSSnaTRBop6ZZPD8W
	+kTRd/MYlo9G3cWRnuxwzPr+ws3ZDjuipUKWbvHCOxBn6YNO4iT1CS+h5ncBO+2nvtErXCx4qaR
	s30jHij7v3StLpRcPUwAHqMWkeUYK72DeT3KBtKUEHjO5OuhJTEwVPfyO5hImOpUvtkDFJoNbxT
	4k5h3aeKBITkzo8V2P3lO8jormtJNxNaiJApFUMX8JOcVoQRdhYaoDruUjW9ABJM4rcd88qTYkd
	HLUn8gC8FVQ+ylHFZY9EyH+echy78RGPor6CdZ5+cDws4+qL49W0CxblDjOWz0cJ0aUvOqbfsPr
	jWhVqcIJpz0GIXQpKAmG+qWjS9IRWglirvgQOLLXLYp+XR0pOqFrv2DHUk8W4piD/3Ramy4hE8N
	hHp8nxMd6gezZn1CwFmyLk6vJTty2Ks8sfgNYV/bvBylyOB/ozdENEXuuBYthjd0YuJ6omqyhzi
	0c+fvbfPyloQtpwS+F4XpmKTEJg+2l0hdMLwC7GzJXSdEtxsH/WkkeQ7QQZVWTrSDe3DEDVHTyv
	7qhgvzcWqTBp8+g/An4uzUPYNDlP+wL5
X-Received: by 2002:a05:600c:5303:b0:4a2:fe11:9a8a with SMTP id 5b1f17b1804b1-4bb88786cfamr66491495e9.0.1795182805712;
        Fri, 20 Nov 2026 05:53:25 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm6018485f8f.36.2026.11.20.05.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:53:24 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH 0/2] fetch/npm: no npm executable, and an event log fix
Date: Fri, 20 Nov 2026 14:53:21 +0100
Message-ID: <20261120135323.2627478-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 13:53:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20465
Content-Type: text/plain; charset="utf-8"

Hi,

The OE-Core series "npm: list the dependencies in SRC_URI" needs these
two patches. I send that series at the same time. The two patches do
not depend on each other.

1. cooker: "recipetool create" for npm runs two builds in one server.
   The second build fails to write the event log, because
   sstate.bbclass stores compiled regular expressions in the
   datastore. The recipetool selftest of the OE-Core series shows this
   failure.
2. fetch/npm: Alexander asked for this in the RFC thread [1]. The npm
   fetcher must work without the npm executable, as the crate fetcher
   works without cargo. The npm tests now run without npm, and new
   tests fetch a package from a premirror without network access.

Tests: bitbake-selftest bb.tests.fetch.NPMTest passes, with an npm in
PATH that always fails. bb.tests.event and bb.tests.cooker pass.

[1] https://lore.kernel.org/openembedded-core/20261111115845.1940227-1-stondo@gmail.com/T/

Stefano Tondo (2):
  cooker: Write variables that are not JSON types to the event log
  fetch/npm: Build the tarball URL without the npm executable

 lib/bb/cooker.py      |  2 +-
 lib/bb/fetch/npm.py   | 50 +++----------------------
 lib/bb/tests/fetch.py | 85 ++++++++++++++++++++++---------------------
 3 files changed, 50 insertions(+), 87 deletions(-)

-- 
2.56.1

