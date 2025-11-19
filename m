Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0ACF34AC
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 12:48:47 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6074.1763556520962488486
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 04:48:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WiPfbfo7;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c4c65485so5567087f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 04:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763556519; x=1764161319; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m8YgXUJ9F/hFZnV2/x//+St4gPipSBHgmLd1/ctBVY=;
        b=WiPfbfo77T2Xn3w5kbWw4RBMq1+kKAvkLkrOBqAoyGqYKBKAEYvBvZmLcDzaIv5CSV
         cCHxq+ou1ytAhH9djkyLJJHr7SyfkFL/E5eAPHN93pwRv/5KOgYqssmTGMniFUCH7fqn
         TQ2YR+VP1IgGXhbcGkntlWBTyr/NblO+CqBjRm6hHZ8oe+TW0Fb7MrZlJl/HtezXeKSc
         vaUb8Nou6lZ6Vb1Znw/K74OFMLxCcO+NP4r8p0DzAMlqvAk7AQjJxp+BzMabrDy2zKi9
         ssfIpvfZa+bq5qVeOKcxDvGIopbgwUSDQg598FC2C5w90axjT2QDcU8TNI3hfHMfoiQ1
         2fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556519; x=1764161319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/m8YgXUJ9F/hFZnV2/x//+St4gPipSBHgmLd1/ctBVY=;
        b=oP7Ktiz+h+QtkOsIw7rYTdmwWxazV6TFEKWD3N+PKL3F6zdX/tr236hi95fyLWEeHl
         SMqc2O9ZgTsHXcqgFCdDd8ReOzlxPUHAL/d3c1iyypW3gRO37I6WRoaRiOXDgU2VpvEi
         zl8OG32gOdNzOLIYg+d0ywJ9MM/CZW1ZfZoHrEVnHKjBvwXmX0nDbTQTYVOq5xJ9cOYJ
         kbCcfhdDHcq7IB4B3DJ7TT0TPgsXUHyptAXkXXAhj2oFcYr+U4G6dTTJeE1ePOO3O0rW
         P+ONGprkCYaJ6hu4VBSSqCjIs+/eLMBMF3BcrrByQgE1hGn+lUbPh0nOQMv3dx8iVwEz
         /dTQ==
X-Gm-Message-State: AOJu0Ywd7ccIYNC/9/4TG+l/XIoqX5EmGK11eTvf/tUBd6qyVkrYBd9p
	6i90i+b8T/2ogje4JaidC8g/yz4OjY0oV8AcUdaucWtF1STVk2cP5aOy1HpBtA==
X-Gm-Gg: ASbGnctEmAePvVyhM8aJZO2thk/aoa0/8fWLp5Wt16U1sp9tQXKlI15tAvoEmtgWHZc
	1EmoZiHAFNDPEoS8V9p0/c6XDlmSsoaj7X5Usd1o63bxi5wegS2r7+AGK6Yxjffs4f59j5y+VEl
	snzdDoXSg9/5yppR5qPJPNlyJHKAMy3V+hLmeNjpAI0l2qWEapZu0dMDNarTMVr3CyElgl27B0v
	QutK11UG7WDWD2JH4bn0LFK3ah1zpomV+uAQC3sAH4by4BWAaCl74UTvAgpw7Hwi/7ARSSrCekP
	stV4+mQxpiGUaKvMqHzqXfwPjf8RrauvuISEyG3yW6sq1TvC9Ql1NPadpf4GvcUqW3yPLJ+D5P4
	mPhN2HfhBbzg/AWfZUwc7pD3Kh160TfcSTuzvMWUg61LikvZuAYskkh30zc7KQSbjiik9gyvEDq
	swAXpgoeZNfoA32gUU6bzOkCPIQpKfgvsaGggjISQwcv/U12ZoG8pbn0IC0A==
X-Google-Smtp-Source: AGHT+IGPsR126S7aDBf0jrn3oz68CqbvfUL3v57hCoXG8jtCB5OVh5jQYwtm4vqZgQYcyRxnTlq6Bg==
X-Received: by 2002:a05:6000:2509:b0:42b:3e0a:649e with SMTP id ffacd0b85a97d-42b59328f9fmr20643126f8f.13.1763556519229;
        Wed, 19 Nov 2025 04:48:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm36953267f8f.13.2025.11.19.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] bitbake-setup: add information about enabling fragments to toolcfg.conf, tool output and written-out README
Date: Wed, 19 Nov 2025 13:48:32 +0100
Message-Id: <20251119124832.3906214-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119124832.3906214-1-alex.kanavin@gmail.com>
References: <20251119124832.3906214-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 12:48:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18457

From: Alexander Kanavin <alex@linutronix.de>

Also adjust the order of those pieces to be more logical, and tweak
the newlines so that each item is separated by a single newline
from the previous and next ones.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b331eac53..a8da10e4f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -259,6 +259,12 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     shell = "bash"
     fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
     if fragments:
+        toolcfg_file = os.path.join(bitbake_builddir,'conf/toolcfg.conf')
+        toolcfg_comment = """# Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments
+# or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO).
+"""
+        with open(toolcfg_file, 'w') as f:
+            f.write(toolcfg_comment)
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
     if os.path.exists(backup_bitbake_confdir):
@@ -287,23 +293,29 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         print('Applying upstream bitbake configuration changes')
         print(f'Leaving the previous configuration in {backup_bitbake_confdir}')
 
-    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
+    fragment_note = "Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO)."
+
     readme = """{}\n\nAdditional information is in {} and {}\n
-Source the environment using '. {}' to run builds from the command line.
+Source the environment using '. {}' to run builds from the command line.\n
+{}\n
 The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
 """.format(
         bitbake_config["description"],
         os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
         os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
         init_script,
+        fragment_note,
         bitbake_builddir
         )
     readme_file = os.path.join(bitbake_builddir, "README")
     with open(readme_file, 'w') as f:
         f.write(readme)
+
+    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
     print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
+    print("To run builds, source the environment using\n    . {}\n".format(init_script))
+    print("{}\n".format(fragment_note))
     print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
-    print("To run builds, source the environment using\n    . {}".format(init_script))
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
-- 
2.39.5


