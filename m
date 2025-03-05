Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C891C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:17:42 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.10191.1741169856637924793
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 02:17:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e+N9en+K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390dd3403fdso5613472f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741169854; x=1741774654; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEX3lHo6f2rsb0I3OmiWc6IuGt+Ty30TedPY0qcFSNo=;
        b=e+N9en+KtByEkM9HVG5XG20dPoFhxvw3hp0j/fhSeEu7JN+EPa1J+ONGjX/UGuzKp3
         F67ZItJMTl5Er9azM4qjBp0KsBOBrMlEIfYogrw3E+2yeaO0zbhLnSl6Ef0H3WAw5VzD
         BH50wbAIg8lSUXt8oSn3n6Q6sPxICj0tijwro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169854; x=1741774654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEX3lHo6f2rsb0I3OmiWc6IuGt+Ty30TedPY0qcFSNo=;
        b=K3Ufp/aI/7nREQYkoWqkwH8rb11OoE9m7Zq2KJ/uN931DDKIfzsXqVG/NcKZDlLdvU
         /UwyFbf6V8jpcwJTtj90XuWg+k9jqL3QZrbX6XLSp5dqEoU1qTFBvAuzNQu+2nPICw/Z
         FTaS0j5CqCzXuTmAKRuZR6qZ5PXdHirg3QlbYyKRJI+j0bV+8KAUYREQ9ewk8Musvwjm
         jmeS75PwLczT973Qm8ZQtwaszdw9574b7dqmhixolAt36ZlMvfs9k/Y2eu8e4Ue1pP2y
         76ae/QnQMrjL1G5xGOWH+PhpLGr+z0/W4AyETkwfEAJ2vYKmdU72yvPQy3AZ2lj6RGYw
         DiSg==
X-Gm-Message-State: AOJu0YzK+2Ox0509lt5MnV0IWGMDABl+TMhNo0+a8eWRp9tbCtrIqpkL
	PssNVY0yUevUmSFLx8CPIoUcwXEnbf2P3ZmhLITrL2fi36cKXyyG7qJl4L9Egi7o8NcO53iq2gp
	8
X-Gm-Gg: ASbGncsEr2ouGhp3xqmU8E9F7Z/pcydHx/TF9Rg4QM7Xa1neZ+SM3bzFNr/D+lvunLn
	BaOGiPLXmHCtQAY8jt1w2Igb3wYNMmx+CBCbdlu7N6JD6XPvq+1Gw++WVIy7tINbN9zNbQHM14z
	MI0w6n8wXybGvsmx3O0eSrxl4QElghKlmF0/+1ZNQfcGEgPJLHCv2m/LSo1PXouIxQcryGVliuW
	rS/8A7RWVhDBSyVDL0fkVoEpVk/iHFuSe1/gWxv0vK+L2RnJQJr0MPWN73ZA8ppL+/NZ8S9Qd6W
	9pc7+Dc76XL7kU17BSp9fYi/lyZqWvTVIQn50d8HGa6/rByTa81XAx9ePKINvYsx17GKDKJbCw=
	=
X-Google-Smtp-Source: AGHT+IFrFgcBNJhGhNixR8GUXiTvNLD2aGBfXBdcdLRsAixN/tO3Iwu8cSEH/B3xRwrKhopcLRATlg==
X-Received: by 2002:a5d:64cf:0:b0:390:e63d:30d9 with SMTP id ffacd0b85a97d-3911f7bb9admr1954665f8f.36.1741169854121;
        Wed, 05 Mar 2025 02:17:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm20642373f8f.73.2025.03.05.02.17.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:17:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] toaster: Add script to compare toaster fixtures to project release data
Date: Wed,  5 Mar 2025 10:17:31 +0000
Message-ID: <20250305101732.2042605-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 10:17:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17384

We need to validate the toaster fixtures information against our current release
data to ensure it is correct when we release. Add a script we can use to
do this which the autobuilder can run to validate things.

[YOCTO #15516]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/check_fixtures.py | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 lib/toaster/orm/fixtures/check_fixtures.py

diff --git a/lib/toaster/orm/fixtures/check_fixtures.py b/lib/toaster/orm/fixtures/check_fixtures.py
new file mode 100755
index 0000000000..ae3722e0f6
--- /dev/null
+++ b/lib/toaster/orm/fixtures/check_fixtures.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2025 Linux Foundation
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import json
+import urllib.request
+
+import gen_fixtures as fixtures
+
+RELEASE_URL = "https://dashboard.yoctoproject.org/releases.json"
+
+with urllib.request.urlopen(RELEASE_URL) as response:
+    if response.getcode() == 200:
+        data = response.read().decode("utf-8")
+        releases = json.loads(data)
+    else:
+        print("Couldn't access %s: %s" % (RELEASE_URL, reponse.getcode()))
+        exit(1)
+
+
+# grab the recent release branches and add master, so we can ignore old branches
+active_releases = [
+    e["release_codename"].lower() for e in releases if e["series"] == "current"
+]
+active_releases.append("master")
+active_releases.append("head")
+
+fixtures_releases = [x[0].lower() for x in fixtures.current_releases]
+
+if set(active_releases) != set(fixtures_releases):
+    print("WARNING: Active releases don't match toaster configured releases, the difference is: %s" % set(active_releases).difference(set(fixtures_releases)))
+    print("Active releases: %s" % sorted(active_releases))
+    print("Toaster configured releases: %s" % sorted(fixtures_releases))
+else:
+    print("Success, configuration matches")
+

