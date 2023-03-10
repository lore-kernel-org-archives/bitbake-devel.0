Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF1C6FD19
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:46:21 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.30872.1678481173328163688
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:46:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fRHuceKM;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id v16so6254166wrn.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtiPxARjG/iCR3iGNMp3/OwF5gaSaHgbThLq4Wc2mdY=;
        b=fRHuceKMzBUkvIJXsv3wMWxPCjOxMqwMUgPJW61ABzt2CLzbqak3uuVV6vSYnnDqb/
         /f1+4D9LPBccoUPBSUqNV9GiCmk9vndt5rRj9nsrC+ZCf7H8kfN5Zk88oaWwZim3njp1
         +yqL/EPapgG+ZUyKFtSy6GvR5zzRj/nYCkeUxbHrfqv3PQTTrY7ON6nG47deJxYOJHoH
         sHUJ2rnDSfiauX/xcmby7e8HUqSveD0sPBVa42RISNP0oiA16Y0faf4HGS27QbJMEWPo
         Gocw+Dh3xaCpjodmuzwkQ+oHxwe1Xbg+SyFLGcGd/cA3STv0UzA1DtBd9Zva7k3QrR8h
         p22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtiPxARjG/iCR3iGNMp3/OwF5gaSaHgbThLq4Wc2mdY=;
        b=S1P9ehhEx8Eu0dluaQjcFUI+GFT/PIgn5CtV4BZ37R8fTTPD04XjdtvomsUXYZfkq0
         ijUj5jrcisvSQ5fiQSK6g545w8Bzx3MrsTJUcu5FcKjCcLM+0uvEgcjeh56JNLNHWt6V
         xUOUQkvYXcjBdFT0VNJk2kUTM27bdadAHl8m/dEV9qgwwNxH6/VCQ6k6Df6N8TqNJtpu
         HNvLCjJMmIibJvXhoLKY9TjKhkq/mBOeF7CG18AIkdWodb5HJajLodD9A1T7J/UhxO/T
         t4cgQUhiy+xKh5UpRn3KNh/ExzK/4SeqmJmsC6WjnX+HdWS82spwluKoILgVI8OsoTJX
         dP5w==
X-Gm-Message-State: AO0yUKWnU49EKYszjKV8O96qF4iopf84spe3dPGWR9YJN4xzp0Q4OY+i
	YpEB6Gn/7qQyFd04jK4aN0AEpPRl1lc=
X-Google-Smtp-Source: AK7set84JqzzreVhTJZNklM/m/jBcKfjnSoAEM23foz4XJRv8oLPMBksahCR9YR38zf7fOWfGxJXbg==
X-Received: by 2002:adf:d0ca:0:b0:2c7:3f9:7053 with SMTP id z10-20020adfd0ca000000b002c703f97053mr17533127wrh.52.1678481171887;
        Fri, 10 Mar 2023 12:46:11 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c510d00b003e20970175dsm995868wms.32.2023.03.10.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:46:11 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 4/4] cookerdata: Drop dubious exception handling code
Date: Fri, 10 Mar 2023 21:46:01 +0100
Message-Id: <20230310204601.730833-4-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204601.730833-1-Martin.Jansa@gmail.com>
References: <20230310204601.730833-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:46:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14547

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This code appears to be dangerous, it swallows exceptions, turning them into
"handled" versions which then show no errors to the user. This is a pretty
poor user experience and I can't see why this code should be swallowing
such things. Drop the worst bits of code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e2dbb3b21..ec3741cc1 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -293,14 +293,9 @@ class CookerDataBuilder(object):
                 bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
 
             self.data_hash = data_hash.hexdigest()
-        except (SyntaxError, bb.BBHandledException):
-            raise bb.BBHandledException()
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
             raise bb.BBHandledException()
-        except Exception:
-            logger.exception("Error parsing configuration files")
-            raise bb.BBHandledException()
 
 
         # Handle obsolete variable names
-- 
2.39.2


