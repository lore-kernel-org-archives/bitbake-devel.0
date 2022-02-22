Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580AC433EF
	for <webhook@archiver.kernel.org>; Tue, 22 Feb 2022 11:38:18 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.11766.1645529896746067125
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Feb 2022 03:38:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dxDRK117;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id p9so32569640wra.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Feb 2022 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrIQ2785dk7UXFT3iOtKVMe3B7Ht71z0bz3s7fwQNl4=;
        b=dxDRK1178/ECmIa1oT9OwZlbavl2zMjDRY+pCBDZzYfPhGyvHq2jOPzCJa72JiLbfK
         K2iLUP4Zo/ht/YD2rm1UF/ubkRCm9OxgTVnhVzZNg5cRRoQYQClEUOhfn+Sy3ABF5g53
         7u47nY4ALqqTQebXw8EU3uJhfbbm9iaiMCviI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrIQ2785dk7UXFT3iOtKVMe3B7Ht71z0bz3s7fwQNl4=;
        b=os7SFOozhDihkxX++C+jSn5hXozRkSwitrnEnUXtm5XmnpsWdQy4BwAVb7NVN+KBJg
         jSLbUIZ9nG1lhNmLY66n8xGXEU/VcXeRDOX0eeazcf6VbhPI/o59ECa+u9j3Iw9T8FgY
         inuEceZn9ANVlBuS0By1t0GiII4Pfh5jKwJ7m9JltYPSfwL9ar5B3FlD2ijM7GLgwuUl
         +11J67PwfTZTWUeSWfj2X0RTKZoJ2x00PdtzifVoqnRHntaov3/hKaKCDXB2PDnChKN0
         YCQ9Ft+EOXbJleUcvs51g74KnQPQQb2Qm1tISG1cSmjGuIr/3hlSCSKt+vXN8sLB1Hjr
         DTMQ==
X-Gm-Message-State: AOAM530g7SNKRTxhUYClW2D9Pn5BT/R0KJYgTSU4M5vOpxdDMngd7u1I
	4FSbYrhkkKsPv0U2w8SwVfIZQMYhQqJqM7XU
X-Google-Smtp-Source: 
 ABdhPJyzhxmA67GSxquW8S/QdLs/ufeS5hJceNT7y8h0jY4VPjY1pwuOClKHv/Q1F2tpBQl0+hPt2g==
X-Received: by 2002:adf:f34d:0:b0:1e3:3e54:cc96 with SMTP id
 e13-20020adff34d000000b001e33e54cc96mr19146430wrp.84.1645529894820;
        Tue, 22 Feb 2022 03:38:14 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:26ce:ff82:5c7d:d03e])
        by smtp.gmail.com with ESMTPSA id
 k19sm2072765wmo.8.2022.02.22.03.38.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:38:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Avoid exceptions for non string data
Date: Tue, 22 Feb 2022 11:38:13 +0000
Message-Id: <20220222113813.3213276-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Feb 2022 11:38:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13397

  File "scripts/lib/checklayer/__init__.py", line 49, in _get_layer_collections
    ldata.expandVarref('LAYERDIR')
  File "build/bitbake/lib/bb/data_smart.py", line 1007, in expandVarref
    if referrervalue and ref in referrervalue:
TypeError: argument of type 'bool' is not iterable

We inject True values as an internal sentinel to the datastore, fix
this codepath to handle it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index e7047d79ca..8d3825f398 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1004,7 +1004,7 @@ class DataSmart(MutableMapping):
         value = self.getVar(variable, False)
         for key in keys:
             referrervalue = self.getVar(key, False)
-            if referrervalue and ref in referrervalue:
+            if referrervalue and isinstance(referrervalue, str) and ref in referrervalue:
                 self.setVar(key, referrervalue.replace(ref, value))
 
     def localkeys(self):
-- 
2.32.0


