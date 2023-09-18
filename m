Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B73C46CA1
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 09:05:32 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.47313.1695027928367692502
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 02:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BYjXcNHt;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: insu0.park@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-57756115f08so3582526a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695027927; x=1695632727; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8/aEWeO+zej/TgnteJDCPAsmJxB/IVuB0Qcc/INzt0=;
        b=BYjXcNHtSNMUrkEYIrtdtRVRBitN0ySyTzWalJk0AzohmFAybsl3fWnmgAKI+JQD6A
         sK8Hyxc2ESD5R/JaNxJujYVwu3S7cFFN6n4c/EzeDKtbOL5KuHXNp+4JiqaPp0o014wp
         QNxGv+P8p/xEJSfQ+ZWnuf0176pzYkpsomyhqtvLAtIXeAwOD/Ppcokkcpac2GksHmSn
         vg3Nih6gm00x6C/UcoxA9RKI9vmKGdB3kXm93Y3k15J2hJ2DqhfrEYmNdEEp0OIACVBx
         c542c6PrkJGkMCpzoNtaDVxvjsFLiw5h1VbsXXvFeqVz/qvQDMv3/hpSviQLJBwFYhfZ
         G31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695027927; x=1695632727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8/aEWeO+zej/TgnteJDCPAsmJxB/IVuB0Qcc/INzt0=;
        b=b2dYB6Rdta01n25ibvnTKoPfCCGN7QIM+Zv4X540hgXuMY6995MWiH2kiMAOWjQSx6
         9tRAP+JCrCw9/3jrO3MwHjIJ/87csSMlFjJU5UDRQluRB13Bs0enboCQRIa//70PeeIg
         wlyrOVYaOnP8wA9ECpStGffiZWr5hU8Uw+GYuOHGIhz+MfBaehmTJJZoUeGgB4p3mB9n
         KBPOiWU66ofhF+bONTlobXXkbI+MJao5y6yXszoWWLdMQwsWVidelkcTu1EoaBDZYwzj
         TjVBTauu1CbGey1p2hCscc5hQ/abIE/KXRn+BZg/lWOfipnpHTDydkyh89B5qU+URkQ/
         GNPA==
X-Gm-Message-State: AOJu0YxmdaMzSSOfSFyFyMPaNSPdda1p6prtq9iAlsWME3yi1L3nGATg
	Cfbb8TGiknay0kLCrWHEha76l6igjq6Uhg==
X-Google-Smtp-Source: AGHT+IHSUG5Ng1xgVyRcqk56J/GYFL4/1ZbLvkJBSzbBdoO8rwYf7XyXhjzYZEBZ4PRBq44RPBYiNA==
X-Received: by 2002:a17:90a:bf90:b0:273:e073:1d02 with SMTP id d16-20020a17090abf9000b00273e0731d02mr8080182pjs.38.1695027927552;
        Mon, 18 Sep 2023 02:05:27 -0700 (PDT)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b00273744e6eccsm7438112pjg.12.2023.09.18.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:05:27 -0700 (PDT)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Insu Park <insu0.park@gmail.com>
Subject: [PATCH 0/1] Fix dependency handling bug of :remove operation
Date: Mon, 18 Sep 2023 18:05:21 +0900
Message-Id: <20230918090522.659869-1-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 09:05:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15075

Unlike the meta layers under the Yocto projects, custom layers frequently use following style
of overriding to disable something default in the base layer without touching it:
    bb in the base layer:
        OPTIONS = "foo bar"
    bbappend in the custom layer:
        OPTIONS:remove = "${@bb.utils.contains('CUSTOM_FEATURES', 'no-foo', 'foo', '', d)}"

The problem is that the value of "CUSTOM_FEATURES" is not shown in the task signature.
Here is a test example.

test-remove-operation.bb:
    TEST_VAR        =  "v1 ${@bb.utils.contains('TEST_FEAT1', 'foo', 'v1foo', '', d)}"
    TEST_VAR:append = " v2 ${@bb.utils.contains('TEST_FEAT2', 'bar', 'v2bar', '', d)}"
    TEST_VAR:remove =  "v3 ${@bb.utils.contains('TEST_FEAT3', 'disable-v1', 'v1', '', d)}"

local.conf:
    TEST_FEAT1 = "foo"
    TEST_FEAT2 = "foo"
    TEST_FEAT3 = "foo"

Signature dump (Bug):
    Variable TEST_VAR value is v1 ${@bb.utils.contains('TEST_FEAT1', 'foo', 'v1foo', '', d)} v2 ${@bb.utils.contains('TEST_FEAT2', 'bar', 'v2bar', '', d)}
    TEST_FEAT1{foo} = Set
    TEST_FEAT2{bar} = Unset
    _remove of v3 ${@bb.utils.contains('TEST_FEAT3', 'disable-v1', 'v1', '', d)}

Note that the signature dump above doesn't take the value of TEST_FEAT3 into account.
Therefore, even if the local.conf changes the TEST_FEAT3 value to "disable-v1",
the two different configs produce exactly same signature, so the recipe won't be re-built,
even worse, its sstate-cache output is not deterministic (depend on the config it first met).

With the fixed code, the new signature recognizes the TEST_FEAT3, and the problem solved.
Signature dump (Fixed):
    (Same as above)
    TEST_FEAT3{disable-v1} = Unset

Insu Park (1):
  bitbake: data: Add missing dependency handling of :remove operation

 lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1


