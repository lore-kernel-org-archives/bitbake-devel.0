Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2525BC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 22:46:32 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.51616.1701902782712455804
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 14:46:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A+A0zPH1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3332f1512e8so286573f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701902781; x=1702507581; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHWXHuxlJoE+v8dDdo0so6CfWV7LhdqVmlzpl2Rt9DI=;
        b=A+A0zPH1fsNjnJRNixbRS/C15b5Be0VAO7ONKKB4vmadNg5OJyHU6QqQC/XBeH9Pue
         cNT2MdNEoiMLRZsCEMIs7oSk154H7/DEGteeK3rziQnblUpEX/e627lekPgP5hEjPY0W
         DSOW7E+ZUNQsuGcty4kDxA6+2KKhrtwYeI+u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902781; x=1702507581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHWXHuxlJoE+v8dDdo0so6CfWV7LhdqVmlzpl2Rt9DI=;
        b=qrrTlVp1y564cm0TOVQHFGnPHNAv4AoDH7MrEWezeZ3o4B2MJemsYMlOCXQM/uk8Rr
         RppUW+XL9Gy1TjK78cYMfAMEpYOD2seYgLOAleWgA9wBa4LHLBJLgq6xbLqg5/ZXdjhw
         3Kj/v82yJJTp5AdW4QnMqXYKi5KGuqesjxFWYZS2EYjjGn7talWDWzm7g5wDRtjv3Zcv
         YVDWfqs8lM65zXqs5GeCNxK5pChuvaVzYqsXz0YXEr4ZwNZ9qzOFofuUX8AnLbRbpu5d
         tXdEo6rumTNMHAFCgyYM1ZgEay5rkKwMOsCClo6B2WJChhC4wJ9AreG7u1r/FfUKMMd1
         TLUg==
X-Gm-Message-State: AOJu0YzklvqeaLuleG4rn+2Dj6kS97ll0bqNQoE2P0SsP+FJ+1HUNALQ
	UZNnl8yWx6yuxNSrpDX00kFII7qXrCN29zBA4sk=
X-Google-Smtp-Source: AGHT+IFIpZ5/M2i09L05c92seK6DG0bAcTOSiVCTzuNSrhcSCrSVX7Dm/zEJ0jvuiZGSC+UmiuhKDQ==
X-Received: by 2002:a5d:42d1:0:b0:333:5448:a524 with SMTP id t17-20020a5d42d1000000b003335448a524mr1003386wrr.70.1701902780673;
        Wed, 06 Dec 2023 14:46:20 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:30b4:b44a:2cc6:3876])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b0033330846e76sm677996wrt.86.2023.12.06.14.46.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:46:20 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster-eventreplay: Remove ordering assumptions
Date: Wed,  6 Dec 2023 22:46:19 +0000
Message-Id: <20231206224619.1703343-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 22:46:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15626

Currently the script assumes the variarables are dumped at the start of the
file which is hard to arrange safely in the bitbake code and no longer a true
assumption.

Rewrite the code so that it can cope with different ordering and event files
containing multiple builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/toaster-eventreplay | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 404b61f516..f137c71d5c 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -45,7 +45,13 @@ class EventPlayer:
         if not line:
             return
         try:
-            event_str = json.loads(line)['vars'].encode('utf-8')
+            decodedline = json.loads(line)
+            if 'allvariables' in decodedline:
+                self.variables = decodedline['allvariables']
+                return
+            if not 'vars' in decodedline:
+                raise ValueError
+            event_str = decodedline['vars'].encode('utf-8')
             event = pickle.loads(codecs.decode(event_str, 'base64'))
             event_name = "%s.%s" % (event.__module__, event.__class__.__name__)
             if event_name not in self.eventmask:
@@ -99,8 +105,16 @@ class EventPlayer:
 def main(argv):
     with open(argv[-1]) as eventfile:
         # load variables from the first line
-        variables = json.loads(eventfile.readline().strip())['allvariables']
-
+        variables = None
+        while line := eventfile.readline().strip():
+            try:
+                variables = json.loads(line)['allvariables']
+                break
+            except (KeyError, json.JSONDecodeError):
+                continue
+        if not variables:
+            sys.exit("Cannot find allvariables entry in event log file %s" % argv[-1])
+        eventfile.seek(0)
         params = namedtuple('ConfigParams', ['observe_only'])(True)
         player = EventPlayer(eventfile, variables)
 
-- 
2.39.2


