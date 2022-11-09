Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF1C433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 14:30:00 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web09.3946.1668004191857003826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 06:29:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=2IBTu+T2;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id q1so16347811pgl.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WKON8Xqgm7mfACpFVqMDSuF3F0b35OxeVGF/9TkqNg=;
        b=2IBTu+T2NQc6QH2snT6vryTwelt38rCdTXY+gkxYiwnh6GkZ/Bfqnzh9aV80MtA9Qh
         sQHiv0w7MCIhgKaI6dJoj9xOFdnMyclvyjB6aakSCj8gz0QIUgPE+ZDh6VWU24uzQ8Mm
         G8iC5z/bqE17t6XDa+jfjIWHVCzq3Y1UV2AcsLwRfeA1vrStzloCc7K2pgTkFphIBa8d
         uTni33PZ5O6Jizai0qf6yQCgM/I2DZe6a8NFAK4i/U+iNSpS+nPv+GY9mrkSJaBl2nBS
         As1ai4hoZd4YBJAednLCg6ceFwvYHhHzmAj3lJRgVzP/AxYsXvcHVAKZJWyXzfSklj27
         CwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WKON8Xqgm7mfACpFVqMDSuF3F0b35OxeVGF/9TkqNg=;
        b=zWiEFK2TSSjkoi0xf37jmWHrUwNqjSTn0ZPO8rOtgnCR55W67/xPsL3KM4z2LwC/oN
         VUuVvnsodwV1KuhJLRWYARSnUFh1k9q9M/vlMMFfal+z60qIq+AxjX00Zk4NXeS9yM9z
         4dur/A6Qkf5KvpHU3k+pckHG+dRPelP63ou7huEQIOqweV6TvtT2x/OKQVOsUzPjVPHq
         qmKhKBsYxC/Sbjl2dLrYvbPubOB+w/3uEvfAs2mWvXSONhmugzebTci6rk/pebk2Yv0V
         /XT0DPnOBiVjCXG69MgaxJVDSvpx26dsim7/VPiCkPVsaqhUNvthbrbOjT1Tt/rKO1CA
         pvXg==
X-Gm-Message-State: ACrzQf2M4a7rycxQ1wjHCnJ7LLOwyMBRIL/dOmtZye0YsmQwWBjgewTp
	ZAXQsdRQrX351bOfUzSRM+3nfZBZ/fXEGR8u
X-Google-Smtp-Source: AMsMyM4AToYM+PeS7beqOsMCoHbN+l0bVUzuBOi64GUDDLZFyJfEDSl85nonmUPBRXMAmMtclmu6NA==
X-Received: by 2002:a05:6a00:22c3:b0:56b:f793:5ad1 with SMTP id f3-20020a056a0022c300b0056bf7935ad1mr61975603pfj.58.1668004190929;
        Wed, 09 Nov 2022 06:29:50 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm1308611pjb.13.2022.11.09.06.29.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:29:50 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 1/4] bitbake-user-manual: details about variable flags starting with underscore
Date: Wed,  9 Nov 2022 04:29:33 -1000
Message-Id: <a51e68544f97fce8c1b136b4f78fc0da8c69e9d6.1668003926.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668003926.git.steve@sakoman.com>
References: <cover.1668003926.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 14:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14062

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Fixes [YOCTO #14140]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0f3e9d87168813ce49995ff04bccdce11c5f7b47)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b533d9dc..b7c3d809 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -422,6 +422,12 @@ documentation to a BitBake variable as follows::
 
    CACHE[doc] = "The directory holding the cache of the metadata."
 
+.. note::
+
+   Variable flag names starting with an underscore (``_``) character
+   are allowed but are ignored by ``d.getVarFlags("VAR")``
+   in Python code. Such flag names are used internally by BitBake.
+
 Inline Python Variable Expansion
 --------------------------------
 
-- 
2.25.1


