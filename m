Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD09FC433FE
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:43 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web12.683.1652206000910398894
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=3Qpt3nU8;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.178,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f178.google.com with SMTP id l11so9692173pgt.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wpYxsLkAZarFu1ZNhLqkIWcfTi/243R9XscNnwxz4+8=;
        b=3Qpt3nU82ZPT9s47gDhD5It8U0svAbEJUGh1c/xT7xieF3dXMT3wrPc2hx+GxL5pyf
         jyC2LMjBtY3kpw3Ecq2K8swZOZyKkS+8TT2Htx5tYmTD+DhnlHM2epo4nq/pLJUT83vO
         9ebsktGl0esN466U+L4rWab7VY3Ev92M34Lddt5VNzc52n/w7bgTrbf2AdzC8j3Zn8av
         oLgpCsafzZhyEZXmdganFfEoJF3jzpCmOJPIh4XZJJcuq/xzVznnX2z/fNdSRRIDNUH9
         cRrQxy1gtC0jlvwxv8XCMLr2exFfYM1wvDw9JCPufr+/DwK7c5J9c26pNw8o7U2rsejr
         CiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpYxsLkAZarFu1ZNhLqkIWcfTi/243R9XscNnwxz4+8=;
        b=acNoRATbqtwpTsmqGb9u9zJ4oWMkcZAitgaF1XSR95FFMMVhYxCld/C+AZAvch33RT
         N28xoTCMKPeqHpdJ27KZTQczAbcgwBkh038/5N4g960XPpQ1bQWEiHSMQ598LonMqmJv
         F8NGvJPXZN+DUIvOdu0tjl0CSm5hpnDg4Zb6DtnLfcxCaIoaspbMrXddOmCA6QioL4bt
         qVXn7wIiq4iqMQOuKHFKDXoh4nQqHHeDKfAaGcWlUAUbr5PhOrlYW3iItcTMDUAK8mKj
         oVzoOiicNY2u2XAlq/YRt9z6eASWd/csRk0BByyMJ77igi9jktoM2w7JFRFA6e0mbbxK
         C6TA==
X-Gm-Message-State: AOAM532nnk18qIjJNZQQBNj7Cq+q+C/P8MD/cBipmIyMThUOs2l1Jv9+
	Ax+I9Jr53+uHdMAKETZT7wx8Dm2p8FJxt1KO
X-Google-Smtp-Source: 
 ABdhPJz+YHXxl1O2Ao7dYhZDw+XeTbW5ZS5s9WINf6HzatK6W5AUVnYwIYR/eevavHiMG/vkNXYA+A==
X-Received: by 2002:a05:6a00:2148:b0:4fa:92f2:bae3 with SMTP id
 o8-20020a056a00214800b004fa92f2bae3mr21705781pfk.69.1652205999706;
        Tue, 10 May 2022 11:06:39 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:39 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 15/18] fetch2/ssh.py: decode path
 back for ssh
Date: Tue, 10 May 2022 08:05:40 -1000
Message-Id: 
 <bb2828ac82b707dfc5c6d5f7015c318ba646fa32.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13695

From: Robert Yang <liezhi.yang@windriver.com>

The path has been encoded by urllib.parse.quote(), so decode it back for ssh.

Fixed when fetch from PREMIRRORS via ssh:
$ bitbake bonnie++ libsigc++-2.0 -cfetch

scp: /path/to/downloads/libsigc%2B%2B-2.10.7.tar.xz: No such file or directory

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c1c8fc678eb4783cea3974328a5fa8d1b79f1266)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/ssh.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 48445308..8d082b38 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -32,6 +32,7 @@ IETF secsh internet draft:
 
 import re, os
 from bb.fetch2 import check_network_access, FetchMethod, ParameterError, runfetchcmd
+import urllib
 
 
 __pattern__ = re.compile(r'''
@@ -70,6 +71,7 @@ class SSH(FetchMethod):
                 "git:// prefix with protocol=ssh", urldata.url)
         m = __pattern__.match(urldata.url)
         path = m.group('path')
+        path = urllib.parse.unquote(path)
         host = m.group('host')
         urldata.localpath = os.path.join(d.getVar('DL_DIR'),
                 os.path.basename(os.path.normpath(path)))
@@ -99,7 +101,7 @@ class SSH(FetchMethod):
 
         if path[0] != '~':
             path = '/%s' % path
-        path = path.replace("%3A", ":")
+        path = urllib.parse.unquote(path)
 
         fr += ':%s' % path
 
@@ -139,7 +141,7 @@ class SSH(FetchMethod):
 
         if path[0] != '~':
             path = '/%s' % path
-        path = path.replace("%3A", ":")
+        path = urllib.parse.unquote(path)
 
         cmd = 'ssh -o BatchMode=true %s %s [ -f %s ]' % (
             portarg,
-- 
2.25.1


