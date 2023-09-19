Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADECD3447
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 06:59:49 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.1913.1695106783832901047
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 23:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AbSldrqW;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: insu0.park@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso4706696b3a.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695106783; x=1695711583; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J42R4BaYcG7D97p1y63bWjTaO9WAh/oEDeSDJqHGLV0=;
        b=AbSldrqWTh0GXRf1ICy4Pcaq2DA0d9+DswnT1ODeDAZqTEnOMu1Dttl2dRmugNZjHt
         4KMia1KxTTxQHpPaDrW01CxTE8H2LScRqIxH2GigCZTlBRKGXO11Pevgu2N6j3bf6dEw
         X58ipcWK43Plg8RHjFgQz9mGL+HPCIU9Tr5CiDKakx0ENKNc3UpOk9HnZYe1nMeMX+Kk
         WWGGT9AOgmmJP3kdEGzFxfXOPNAWS2jKzCpKHDcpLlNVcI24aVGFWm8lquDX5WsMTzrJ
         DurdOXxIuDp5y/93XfObpRzx3taKOZ1wINMeShNkdAEV5d0WxNVjzQ5iCMfkQD218Wuv
         eFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695106783; x=1695711583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J42R4BaYcG7D97p1y63bWjTaO9WAh/oEDeSDJqHGLV0=;
        b=iMeQ18ofwsKyXn+E8Ox3RNkxMEXcBa2BCa8eQAEMGorjp0zLL8AlqRUcw36qbHDdfm
         /LtN0svbFe4SBrJzxoTpRWf5PZDX/tH4fm2dXe1vPrvY9DuwIvIFkQ1jP9ViheqRDIHj
         r0y7A2uDgQwkj9N8K/ogrk2uojW/DWstd5eTwZjKYgHzBQs2xMz4op48GglYUYGVtspN
         9lN4l64Nf/RuE4nFJNRx9KRRS3L0uKrOnp/wOLSRFXKMqFKcGBAa2apjJSG7OEXArIhI
         CcKHvsHTRQa25zsJn1y7cDSu2q/UD3ffHVxfmwKDdLGfUz/iez3bQHsiwBiSTRdiLUpW
         /NZA==
X-Gm-Message-State: AOJu0YwN9MHsIVPeUNi5VNMgHhXF/loKLez6uAb32l1jyPH9wz7Z4WcC
	9/L+++OYF7xTLuwWE1GXxBT30yeU99tSW+Gm
X-Google-Smtp-Source: AGHT+IGIagDCYmfFKX6diry0V1htvrYhLdETR4sajlrGjXGjYAMLFqAjL/vp6yMYVrqjzR0qRouhNg==
X-Received: by 2002:a05:6a00:15c5:b0:68c:49e4:bd71 with SMTP id o5-20020a056a0015c500b0068c49e4bd71mr14935494pfu.34.1695106782957;
        Mon, 18 Sep 2023 23:59:42 -0700 (PDT)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0068aca503b9fsm8090298pfn.114.2023.09.18.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:59:42 -0700 (PDT)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Insu Park <insu0.park@gmail.com>
Subject: [PATCH v2 0/1] Fix dependency handling bug of remove operator
Date: Tue, 19 Sep 2023 15:59:37 +0900
Message-Id: <20230919065938.1317052-1-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 06:59:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15082

Unlike the meta layers under the Yocto projects, custom layers frequently use following style
of overriding to disable something default in the base layer without touching it:
    bb in the base layer:
        OPTIONS = "foo bar"
    bbappend in the custom layer:
        OPTIONS:remove = "${@bb.utils.contains('CUSTOM_FEATURES', 'no-foo', 'foo', '', d)}"

The problem is that the value of "CUSTOM_FEATURES" is not shown in the task signature.
Here is a test example.

test-override-operators.bb:
    ANOTHERVAR = "testval"
    ANOTHERVAR:prepend = "${@bb.utils.filter('TESTVAR1', 'testval1', d)} "
    ANOTHERVAR:append = " ${@bb.utils.filter('TESTVAR2', 'testval2', d)}"
    ANOTHERVAR:remove = "${@bb.utils.contains('TESTVAR3', 'no-testval', 'testval', '', d)}"

local.conf:
    TESTVAR1 = "blah"
    TESTVAR2 = "testval2"
    TESTVAR3 = "blah"

Signature dump (Bug):
    Variable ANOTHERVAR value is ${@bb.utils.filter('TESTVAR1', 'testval1', d)} testval ${@bb.utils.filter('TESTVAR2', 'testval2', d)}
    TESTVAR1{testval1} = Unset
    TESTVAR2{testval2} = Set
    _remove of ${@bb.utils.contains('TESTVAR3', 'no-testval', 'testval', '', d)}

Note that the signature dump above doesn't take the value of TESTVAR3 into account.
Therefore, even if the local.conf changes the TESTVAR3 value to "no-testval",
the two different configs produce exactly same signature, so the recipe won't be re-built,
even worse, its sstate-cache output is not deterministic (depend on the config it first met).

With the fixed code, the new signature recognizes the TESTVAR3, and the problem solved.
Signature dump (Fixed):
    (Same as above)
    TESTVAR3{no-testval} = Unset

Now, the new test case fails without the fix:
|$ bitbake-selftest bb.tests.codeparser.DependencyReferenceTest.test_contains_vardeps_override_operators
|F
|======================================================================
|FAIL: test_contains_vardeps_override_operators (bb.tests.codeparser.DependencyReferenceTest)
|----------------------------------------------------------------------
|Traceback (most recent call last):
|  File "/home/worker/work/poky-test/bitbake/lib/bb/tests/codeparser.py", line 454, in test_contains_vardeps_override_operators
|    self.assertEqual(sorted(values.splitlines()),
|AssertionError: Lists differ: ['${@[155 chars]t', '_remove of ${@bb.utils.contains("TESTVAR3[32 chars]d)}'] != ['${@[155 chars]t', 'TESTVAR3{no-testval} = Set', '_remove of [62 chars]d)}']
|
|First differing element 3:
|'_remove of ${@bb.utils.contains("TESTVAR3", "no-testval", "testval", "", d)}'
|'TESTVAR3{no-testval} = Set'
|
|Second list contains 1 additional elements.
|First extra element 4:
|'_remove of ${@bb.utils.contains("TESTVAR3", "no-testval", "testval", "", d)}'
|
|  ['${@bb.utils.filter("TESTVAR1", "testval1", d)} testval '
|   '${@bb.utils.filter("TESTVAR2", "testval2", d)}',
|   'TESTVAR1{testval1} = Unset',
|   'TESTVAR2{testval2} = Set',
|+  'TESTVAR3{no-testval} = Set',
|   '_remove of ${@bb.utils.contains("TESTVAR3", "no-testval", "testval", "", d)}']
|
|----------------------------------------------------------------------
|Ran 1 test in 0.002s
|
|FAILED (failures=1)

Insu Park (1):
  bitbake: data: Add missing dependency handling of remove operator

 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.25.1


